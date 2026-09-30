
//===========================================================================
//  QuestSystem v3.1 - 完成/失败逻辑优化版
//  修改：
//  1. 完成任务后：
//     - keepAfterComplete = true → QuestSetCompleted(wc3quest, true) 保留记录
//     - keepAfterComplete = false → DestroyQuest() 删除
//  2. 任务失败后：
//     - 重置任务状态 → QUEST_STATE_NONE
//     - 删除Cache记录
//     - DestroyQuest() + 失败提示
//===========================================================================

library QuestSystem requires basic

    globals
        constant integer QUEST_STATE_NONE       = 0
        constant integer QUEST_STATE_INPROGRESS = 1
        constant integer QUEST_STATE_COMPLETED  = 2
        constant integer QUEST_STATE_FAILED     = 3
        constant integer QUEST_STATE_UNKNOWN    = 99
        
        constant integer QUEST_PERSISTENT  = 0  // 主要任务，默认不保留
        constant integer QUEST_REPEATABLE  = 1  // 可选任务，默认保留
        
        private constant string CACHE_PREFIX = "QS_"

        unit QUEST_EVENT_UNIT = null 
    endglobals

    function QuestMessage takes integer msgType, string msg returns nothing
        if msgType == 0 then
            call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_COMPLETED,"|cffffcc00任务完成：|r " + msg)
        elseif msgType == 1 then
            call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_FAILED,"|cffff0000任务失败：|r " + msg)
        elseif msgType == 2 then 
            call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_DISCOVERED,"|cffffcc00接受任务：|r " + msg)
        endif
    endfunction

    function ObjectiveMessage takes integer msgType, string msg returns nothing
        if msgType == 0 then
            call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_UPDATED,"|cffffcc00目标完成：|r " + msg)
        else
            call DisplayTimedTextToPlayer(PLAYER, 0, 0, bj_TEXT_DELAY_QUESTDONE, msg)
        endif
    endfunction

    function QuestReplaceDialog takes unit whichUnit,integer originalDialog,integer newDialog,integer flag returns nothing
        if whichUnit == null then 
            return 
        endif 
        call RemoveItemFromStock(whichUnit,originalDialog)
        call AddItemToStock(whichUnit,newDialog,0,flag)
    endfunction
    function QuestRemoveDialog takes unit whichUnit,integer whichDialog returns nothing
        if whichUnit == null then 
            return 
        endif 
        call RemoveItemFromStock(whichUnit,whichDialog)
    endfunction
    function QuestAddDialog takes unit whichUnit,integer whichDialog,integer flag returns nothing
        if whichUnit == null then 
            return 
        endif 
        call AddItemToStock(whichUnit,whichDialog,0,flag)
    endfunction
    function QuestSwapDialog takes unit unit1,integer removeDialog1,unit unit2,integer addDialog2,integer flag returns nothing
        if unit1 == null or unit2 == null then 
            return 
        endif 
        call RemoveItemFromStock(unit1,removeDialog1)
        call AddItemToStock(unit2,addDialog2,0,flag)
    endfunction 

    private function GetPlayerHero takes nothing returns unit
        return QUEST_EVENT_UNIT
    endfunction

    //===========================================================================
    //  任务目标 (Objective) - 无变化
    //===========================================================================

    struct Objective

        questitem qi        = null
        string    description = ""
        integer   current     = 0
        integer   required    = 0
        boolean   completed   = false
        Quest     fromQuest   = 0
        
        static method create takes string desc, integer req returns thistype
            local thistype this = thistype.allocate()
            set this.description = desc
            set this.required    = req
            return this
        endmethod
        
        method addProgress takes nothing returns nothing
            if this.completed then
                return
            endif
            set this.current = this.current + 1
            call QuestItemSetDescription(this.qi, this.description + " (" + I2S(this.current) + "/" + I2S(this.required) + ")")
            if this.current >= this.required then
                set this.completed = true
                call QuestItemSetCompleted(this.qi, true)
                call ObjectiveMessage(0,this.description + " (" + I2S(this.current) + "/" + I2S(this.required) + ")")
            else
                call ObjectiveMessage(1,this.description + " (" + I2S(this.current) + "/" + I2S(this.required) + ")")
            endif
            call this.fromQuest.save()
            if this.fromQuest.checkCompletion() then 
                call TriggerExecute(this.fromQuest.onFinish)
            endif 
        endmethod

    endstruct

    struct NPC
        unit npc = null 
        integer yellow_exclamation  = 0
        integer yellow_question     = 0
        integer white_exclamation   = 0
        integer white_question      = 0
        integer blue_exclamation    = 0
        integer blue_question       = 0 
        minimapicon icon            = null 

        static method create takes unit whichUnit returns thistype
            local thistype this = GetHeroData(whichUnit,"NPC_ID_BIND")
            if whichUnit == null then 
                return 0
            endif 
            if this == 0 then 
                set this = thistype.allocate()
            endif 
            set this.npc = whichUnit
            call SetHeroData(whichUnit,"NPC_ID_BIND",this)
            return this 
        endmethod

        private method checkQuestMark takes nothing returns nothing
            local integer nowMark = 0
            if this.yellow_exclamation > 0 then 
                set nowMark = 'AQ00'
                if this.icon != null then 
                    call DestroyMinimapIcon(this.icon)
                endif 
                set this.icon = CreateMinimapIconOnUnit(this.npc,255,204,0,"war3campImported\\MiniMap-exc.mdx",FOG_OF_WAR_VISIBLE)
            elseif this.blue_exclamation > 0 then 
                set nowMark = 'AQ20'
                if this.icon != null then 
                    call DestroyMinimapIcon(this.icon)
                endif 
                set this.icon = CreateMinimapIconOnUnit(this.npc,0,112,221,"war3campImported\\MiniMap-exc.mdx",FOG_OF_WAR_VISIBLE)
            elseif this.yellow_question > 0 then 
                set nowMark = 'AQ01'
                if this.icon != null then 
                    call DestroyMinimapIcon(this.icon)
                endif 
                set this.icon = CreateMinimapIconOnUnit(this.npc,255,204,0,"war3campImported\\MiniMap-que.mdx",FOG_OF_WAR_VISIBLE)
            elseif this.blue_question > 0 then 
                set nowMark = 'AQ21'
                if this.icon != null then 
                    call DestroyMinimapIcon(this.icon)
                endif 
                set this.icon = CreateMinimapIconOnUnit(this.npc,0,112,221,"war3campImported\\MiniMap-que.mdx",FOG_OF_WAR_VISIBLE)
            elseif this.white_question > 0 then 
                set nowMark = 'AQ11'
                if this.icon != null then 
                    call DestroyMinimapIcon(this.icon)
                endif 
                set this.icon = CreateMinimapIconOnUnit(this.npc,75,75,75,"war3campImported\\MiniMap-que.mdx",FOG_OF_WAR_VISIBLE)
            elseif this.white_exclamation > 0 then 
                set nowMark = 'AQ10'
                if this.icon != null then 
                    call DestroyMinimapIcon(this.icon)
                endif 
                set this.icon = CreateMinimapIconOnUnit(this.npc,75,75,75,"war3campImported\\MiniMap-exc.mdx",FOG_OF_WAR_VISIBLE)
            endif
            if nowMark != 'AQ00' and GetUnitAbilityLevel(this.npc,'AQ00') > 0 then 
                call UnitRemoveAbility(this.npc,'AQ00')
            endif 
            if nowMark != 'AQ01' and GetUnitAbilityLevel(this.npc,'AQ01') > 0 then 
                call UnitRemoveAbility(this.npc,'AQ01')
            endif 
            if nowMark != 'AQ10' and GetUnitAbilityLevel(this.npc,'AQ10') > 0 then 
                call UnitRemoveAbility(this.npc,'AQ10')
            endif 
            if nowMark != 'AQ11' and GetUnitAbilityLevel(this.npc,'AQ11') > 0 then 
                call UnitRemoveAbility(this.npc,'AQ11')
            endif 
            if nowMark != 'AQ20' and GetUnitAbilityLevel(this.npc,'AQ20') > 0 then 
                call UnitRemoveAbility(this.npc,'AQ20')
            endif 
            if nowMark != 'AQ21' and GetUnitAbilityLevel(this.npc,'AQ21') > 0 then 
                call UnitRemoveAbility(this.npc,'AQ21')
            endif 
            if nowMark == 0 then 
                if this.icon != null then 
                    call DestroyMinimapIcon(this.icon)
                endif 
                return 
            else 
                call SetMinimapIconVisible(this.icon,true)
            endif 
            if GetUnitAbilityLevel(this.npc,nowMark) == 0 then 
                call UnitAddAbility(this.npc,nowMark)
            endif 
        endmethod

        static method addExclamation_Y takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.yellow_exclamation = this.yellow_exclamation+1
            call this.checkQuestMark()
        endmethod
        static method addExclamation_W takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.white_exclamation = this.white_exclamation+1
            call this.checkQuestMark()
        endmethod
        static method addExclamation_B takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.blue_exclamation = this.blue_exclamation+1
            call this.checkQuestMark()
        endmethod
        static method addQuestion_Y takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.yellow_question = this.yellow_question+1
            call this.checkQuestMark()
        endmethod
        static method addQuestion_W takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.white_question = this.white_question+1
            call this.checkQuestMark()
        endmethod
        static method addQuestion_B takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.blue_question = this.blue_question+1
        endmethod
        static method reduceExclamation_Y takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.yellow_exclamation = this.yellow_exclamation-1
            call this.checkQuestMark()
        endmethod
        static method reduceExclamation_W takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.white_exclamation = this.white_exclamation-1
            call this.checkQuestMark()
        endmethod
        static method reduceExclamation_B takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.blue_exclamation = this.blue_exclamation-1
            call this.checkQuestMark()
        endmethod
        static method reduceQuestion_Y takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.yellow_question = this.yellow_question-1
            call this.checkQuestMark()
        endmethod
        static method reduceQuestion_W takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.white_question = this.white_question-1
            call this.checkQuestMark()
        endmethod
        static method reduceQuestion_B takes unit whichUnit returns nothing
            local thistype this = thistype.create(whichUnit)
            if whichUnit == null then 
                return 
            endif 
            set this.blue_question = this.blue_question-1
            call this.checkQuestMark()
        endmethod
    endstruct

    //===========================================================================
    //  任务 (Quest) - 核心逻辑优化
    //===========================================================================

    struct Quest

        static thistype first = 0
        thistype prev = 0
        thistype next = 0
        integer id   = 0
        integer flag = 0

        unit owner = null 
        unit anotherOwner = null 
        
        quest   wc3quest = null
        string  title       = ""
        string  description = ""
        string  icon        = ""
        integer questType   = QUEST_PERSISTENT
        boolean keepAfterComplete = false
        
        integer prereq1 = -1
        integer prereq2 = -1
        integer prereq3 = -1
        
        integer state       = QUEST_STATE_NONE
        
        Objective obj1 = 0
        Objective obj2 = 0
        Objective obj3 = 0
        Objective obj4 = 0
        Objective obj5 = 0
        
        // 奖励
        integer rewardGold   = 0
        integer rewardLumber = 0
        integer rewardExp    = 0
        integer rewardItem1   = 0
        integer rewardCharge1= 0
        integer rewardItem2   = 0
        integer rewardCharge2= 0
        integer rewardItem3   = 0
        integer rewardCharge3= 0
        
        trigger onAccept    = null
        trigger onComplete  = null
        trigger onFail      = null
        trigger onFinish    = null 
        
        static integer totalId = 0
        
        static method create takes integer flag,string title, string desc, string icon, integer whichType returns thistype
            local thistype this = thistype.allocate()
            set this.id         = thistype.totalId
            set this.flag       = flag 
            set thistype.totalId = thistype.totalId + 1
            set this.title      = title
            set this.description = desc
            set this.icon       = icon
            set this.questType  = whichType
            set this.state      = QUEST_STATE_NONE
            set this.keepAfterComplete = false
            
            if thistype.first == 0 then
                set thistype.first = this
            else
                set this.next = thistype.first
                set thistype.first.prev = this
                set thistype.first = this
            endif
            
            return this
        endmethod
        
        // 前置、目标添加方法保持不变...
        method addPrereq takes integer prereqFlag returns nothing
            if this.prereq1 == -1 then
                set this.prereq1 = prereqFlag
            elseif this.prereq2 == -1 then
                set this.prereq2 = prereqFlag
            elseif this.prereq3 == -1 then
                set this.prereq3 = prereqFlag
            endif
        endmethod
        
        method prereqsCompleted takes nothing returns boolean
            local Quest q
            if this.prereq1 != -1 then
                set q = thistype.getByFlag(this.prereq1)
                if q == 0 or q.state != QUEST_STATE_COMPLETED then
                    return false
                endif
            endif
            if this.prereq2 != -1 then
                set q = thistype.getByFlag(this.prereq2)
                if q == 0 or q.state != QUEST_STATE_COMPLETED then
                    return false
                endif
            endif
            if this.prereq3 != -1 then
                set q = thistype.getByFlag(this.prereq3)
                if q == 0 or q.state != QUEST_STATE_COMPLETED then
                    return false
                endif
            endif
            return true
        endmethod
        
        method addObjective takes string desc, integer required returns Objective
            local Objective obj
            if this.obj1 == 0 then
                set obj = Objective.create(desc, required)
                set this.obj1 = obj
            elseif this.obj2 == 0 then
                set obj = Objective.create(desc, required)
                set this.obj2 = obj
            elseif this.obj3 == 0 then
                set obj = Objective.create(desc, required)
                set this.obj3 = obj
            elseif this.obj4 == 0 then
                set obj = Objective.create(desc, required)
                set this.obj4 = obj
            elseif this.obj5 == 0 then
                set obj = Objective.create(desc, required)
                set this.obj5 = obj
            endif
            if obj > 0 then 
                set obj.fromQuest = this 
            endif 
            return obj
        endmethod
        
        method hasObjective takes Objective obj returns boolean
            return obj == this.obj1 or obj == this.obj2 or obj == this.obj3 or obj == this.obj4 or obj == this.obj5
        endmethod
        
        method accept takes nothing returns boolean
            if this.state != QUEST_STATE_NONE then
                return false
            endif
            if this.questType == QUEST_PERSISTENT and not this.prereqsCompleted() then
                return false
            endif
            
            set this.state = QUEST_STATE_INPROGRESS
            // WC3 quest
            set this.wc3quest = CreateQuest()
            call QuestSetRequired(this.wc3quest, this.questType == QUEST_PERSISTENT)
            call QuestSetTitle(this.wc3quest, this.title)
            call QuestSetIconPath(this.wc3quest, this.icon)
            call QuestSetDescription(this.wc3quest, this.description)
            call QuestMessage(2, this.title)
            if this.obj1 != 0 then 
                set this.obj1.qi = QuestCreateItem(this.wc3quest)
                call QuestItemSetDescription(this.obj1.qi, this.obj1.description + " ("+I2S(this.obj1.current)+"/" + I2S(this.obj1.required) + ")")
                call DisplayTimedTextToPlayer(PLAYER,0,0,15,"-"+this.obj1.description + " ("+I2S(this.obj1.current)+"/" + I2S(this.obj1.required) + ")")
            endif 
            if this.obj2 != 0 then 
                set this.obj2.qi = QuestCreateItem(this.wc3quest)
                call QuestItemSetDescription(this.obj2.qi, this.obj2.description + " ("+I2S(this.obj2.current)+"/" + I2S(this.obj2.required) + ")")
                call DisplayTimedTextToPlayer(PLAYER,0,0,15,"-"+this.obj2.description + " ("+I2S(this.obj2.current)+"/" + I2S(this.obj2.required) + ")")
            endif 
            if this.obj3 != 0 then 
                set this.obj3.qi = QuestCreateItem(this.wc3quest)
                call QuestItemSetDescription(this.obj3.qi, this.obj3.description + " ("+I2S(this.obj3.current)+"/" + I2S(this.obj3.required) + ")")
                call DisplayTimedTextToPlayer(PLAYER,0,0,15,"-"+this.obj3.description + " ("+I2S(this.obj3.current)+"/" + I2S(this.obj3.required) + ")")
            endif 
            if this.obj4 != 0 then 
                set this.obj4.qi = QuestCreateItem(this.wc3quest)
                call QuestItemSetDescription(this.obj4.qi, this.obj4.description + " ("+I2S(this.obj4.current)+"/" + I2S(this.obj4.required) + ")")
                call DisplayTimedTextToPlayer(PLAYER,0,0,15,"-"+this.obj4.description + " ("+I2S(this.obj4.current)+"/" + I2S(this.obj4.required) + ")")
            endif 
            if this.obj5 != 0 then 
                set this.obj5.qi = QuestCreateItem(this.wc3quest)
                call QuestItemSetDescription(this.obj5.qi, this.obj5.description + " ("+I2S(this.obj5.current)+"/" + I2S(this.obj5.required) + ")")
                call DisplayTimedTextToPlayer(PLAYER,0,0,15,"-"+this.obj5.description + " ("+I2S(this.obj5.current)+"/" + I2S(this.obj5.required) + ")")
            endif 
            
            
            
            if this.onAccept != null then
                call TriggerExecute(this.onAccept)
            endif
            call this.save()
            return true
        endmethod
        
        method checkCompletion takes nothing returns boolean
            if this.obj1 != 0 and not this.obj1.completed then 
                return false 
            endif
            if this.obj2 != 0 and not this.obj2.completed then 
                return false 
            endif
            if this.obj3 != 0 and not this.obj3.completed then 
                return false 
            endif
            if this.obj4 != 0 and not this.obj4.completed then 
                return false 
            endif
            if this.obj5 != 0 and not this.obj5.completed then 
                return false 
            endif
            return true
        endmethod
        
        // ========== 完成任务 - 新逻辑 ==========
        method complete takes nothing returns nothing
            if this.state != QUEST_STATE_INPROGRESS or not this.checkCompletion() then
                return
            endif
            
            set this.state = QUEST_STATE_COMPLETED
            call FlashQuestDialogButton()
            
            // 关键修改：根据 keepAfterComplete 处理
            if this.keepAfterComplete then
                // 保留记录：设置为已完成状态
                call QuestSetCompleted(this.wc3quest, true)
            else
                // 删除任务
                call DestroyQuest(this.wc3quest)
            endif
            call QuestMessage(0, this.title)

            call this.giveRewards()
            
            if this.onComplete != null then
                call TriggerExecute(this.onComplete)
            endif
            call this.save()
            
            if this.questType == QUEST_REPEATABLE then 
                call this.reset()
            endif 
        endmethod
        
        // ========== 失败任务 - 新逻辑 ==========
        method fail takes nothing returns nothing
            local string key 
            if this.state != QUEST_STATE_INPROGRESS then
                return
            endif
            
            // 1. 重置任务状态
            set this.state = QUEST_STATE_NONE
            
            // 2. 重置所有目标
            if this.obj1 != 0 then
                set this.obj1.current = 0
                set this.obj1.completed = false
                call QuestItemSetCompleted(this.obj1.qi, false)
                call QuestItemSetDescription(this.obj1.qi, this.obj1.description + " (0/" + I2S(this.obj1.required) + ")")
            endif
            if this.obj2 != 0 then
                set this.obj2.current = 0
                set this.obj2.completed = false
                call QuestItemSetCompleted(this.obj2.qi, false)
                call QuestItemSetDescription(this.obj2.qi, this.obj2.description + " (0/" + I2S(this.obj2.required) + ")")
            endif
            if this.obj3 != 0 then
                set this.obj3.current = 0
                set this.obj3.completed = false
                call QuestItemSetCompleted(this.obj3.qi, false)
                call QuestItemSetDescription(this.obj3.qi, this.obj3.description + " (0/" + I2S(this.obj3.required) + ")")
            endif
            if this.obj4 != 0 then
                set this.obj4.current = 0
                set this.obj4.completed = false
                call QuestItemSetCompleted(this.obj4.qi, false)
                call QuestItemSetDescription(this.obj4.qi, this.obj4.description + " (0/" + I2S(this.obj4.required) + ")")
            endif
            if this.obj5 != 0 then
                set this.obj5.current = 0
                set this.obj5.completed = false
                call QuestItemSetCompleted(this.obj5.qi, false)
                call QuestItemSetDescription(this.obj5.qi, this.obj5.description + " (0/" + I2S(this.obj5.required) + ")")
            endif
            
            // 3. 删除 WC3 quest 显示
            call DestroyQuest(this.wc3quest)
            
            // 4. 删除 Cache 记录（仅 PERSISTENT）
            if this.questType == QUEST_PERSISTENT and gameCache != null then
                set key = CACHE_PREFIX + I2S(this.id)
                call StoreInteger(gameCache, "quests", key, QUEST_STATE_NONE)
            endif
            
            // 5. 失败提示
            call QuestMessage(1, this.title)
            
            if this.onFail != null then
                call TriggerExecute(this.onFail)
            endif
            
        endmethod
        
        // 重置（仅 REPEATABLE）
        method reset takes nothing returns nothing
            if this.questType != QUEST_REPEATABLE then
                return
            endif
            
            set this.state = QUEST_STATE_NONE
            
            if this.obj1 != 0 then
                set this.obj1.current = 0
                set this.obj1.completed = false
                call QuestItemSetCompleted(this.obj1.qi, false)
                call QuestItemSetDescription(this.obj1.qi, this.obj1.description + " (0/" + I2S(this.obj1.required) + ")")
            endif
            if this.obj2 != 0 then
                set this.obj2.current = 0
                set this.obj2.completed = false
                call QuestItemSetCompleted(this.obj2.qi, false)
                call QuestItemSetDescription(this.obj2.qi, this.obj2.description + " (0/" + I2S(this.obj2.required) + ")")
            endif
            if this.obj3 != 0 then
                set this.obj3.current = 0
                set this.obj3.completed = false
                call QuestItemSetCompleted(this.obj3.qi, false)
                call QuestItemSetDescription(this.obj3.qi, this.obj3.description + " (0/" + I2S(this.obj3.required) + ")")
            endif
            if this.obj4 != 0 then
                set this.obj4.current = 0
                set this.obj4.completed = false
                call QuestItemSetCompleted(this.obj4.qi, false)
                call QuestItemSetDescription(this.obj4.qi, this.obj4.description + " (0/" + I2S(this.obj4.required) + ")")
            endif
            if this.obj5 != 0 then
                set this.obj5.current = 0
                set this.obj5.completed = false
                call QuestItemSetCompleted(this.obj5.qi, false)
                call QuestItemSetDescription(this.obj5.qi, this.obj5.description + " (0/" + I2S(this.obj5.required) + ")")
            endif
            call this.save()
        endmethod
        
        private method giveRewards takes nothing returns nothing
            local unit hero = GetPlayerHero()
            local item rewItem1 = null 
            local item rewItem2 = null 
            local item rewItem3 = null 
            local string rewardMsg = " "
            local real x = GetUnitX(hero)
            local real y = GetUnitY(hero)
            if this.rewardGold > 0 then
                call DisplayTimedTextToPlayer(PLAYER, 0, 0, 8.0, " + |cffffcc00"+I2S(this.rewardGold)+"|r 金币")
                call AdjustPlayerStateBJ(this.rewardGold, PLAYER, PLAYER_STATE_RESOURCE_GOLD)
            endif
            if this.rewardLumber > 0 then
                call DisplayTimedTextToPlayer(PLAYER, 0, 0, 8.0, " + |cffe6cc80"+I2S(this.rewardLumber)+"|r 白金币")
                call AdjustPlayerStateBJ(this.rewardLumber, PLAYER, PLAYER_STATE_RESOURCE_LUMBER)
            endif
            if this.rewardExp > 0 then
                call DisplayTimedTextToPlayer(PLAYER, 0, 0, 8.0, " + |cffff00ff"+I2S(this.rewardExp)+"|r 经验")
                call getXP.evaluate(this.rewardExp)
            endif
            if this.rewardItem1 != 0 then
                set rewItem1 = CreateItemEx(this.rewardItem1,x,y)
                if this.rewardCharge1 > 0 then
                    call SetItemCharges(rewItem1, this.rewardCharge1)
                endif 
                set rewardMsg = " |cffffcc00奖励物品：|r" + GetItemNameEX(rewItem1)
            endif
            if this.rewardItem2 != 0 then
                set rewItem2 = CreateItemEx(this.rewardItem2,x,y)
                if this.rewardCharge2 > 0 then
                    call SetItemCharges(rewItem2, this.rewardCharge2)
                endif 
                set rewardMsg = rewardMsg + "、" + GetItemNameEX(rewItem2)
            endif
            if this.rewardItem3 != 0 then
                set rewItem3 = CreateItemEx(this.rewardItem3,x,y)
                if this.rewardCharge3 > 0 then
                    call SetItemCharges(rewItem3, this.rewardCharge3)
                endif 
                set rewardMsg = rewardMsg + "、" + GetItemNameEX(rewItem3)
            endif
            call DisplayTimedTextToPlayer(PLAYER, 0, 0, 8.0, rewardMsg)
            
            if rewItem1 != null then 
                call delayedUnitAddItem(hero,rewItem1)
            endif 
            if rewItem2 != null then 
                call delayedUnitAddItem(hero,rewItem2)
            endif 
            if rewItem3 != null then 
                call delayedUnitAddItem(hero,rewItem3)
            endif 
            
            set hero = null
            set rewItem1 = null 
            set rewItem2 = null 
            set rewItem3 = null 
        endmethod
        
        // 奖励设置、事件绑定保持不变...
        method setReward takes integer gold, integer lumber, integer exp, integer itm1, integer chg1, integer itm2, integer chg2, integer itm3, integer chg3 returns nothing
            set this.rewardGold   = gold
            set this.rewardLumber = lumber
            set this.rewardExp    = exp
            set this.rewardItem1  = itm1
            set this.rewardCharge1= chg1
            set this.rewardItem2  = itm2
            set this.rewardCharge2= chg2
            set this.rewardItem3  = itm3
            set this.rewardCharge3= chg3
        endmethod

        method setSimpleReward takes integer gold,integer lumber,integer exp returns nothing
            call this.setReward(gold, lumber, exp, 0, 0, 0, 0, 0, 0)
        endmethod
        
        method bindOnAccept takes code func returns nothing
            if this.onAccept == null then
                set this.onAccept = CreateTrigger()
            endif
            call TriggerAddActionEx(this.onAccept, func)
        endmethod
        method bindOnComplete takes code func returns nothing
            if this.onComplete == null then 
                set this.onComplete = CreateTrigger() 
            endif
            call TriggerAddActionEx(this.onComplete, func)
        endmethod
        method bindOnFail takes code func returns nothing
            if this.onFail == null then 
                set this.onFail = CreateTrigger() 
            endif
            call TriggerAddActionEx(this.onFail, func)
        endmethod
        method bindOnFinish takes code func returns nothing
            if this.onFinish == null then 
                set this.onFinish = CreateTrigger() 
            endif
            call TriggerAddActionEx(this.onFinish, func)
        endmethod
        
        // Cache 保存（仅 PERSISTENT 且非失败）
        method save takes nothing returns nothing
            local string key
            if this.questType != QUEST_PERSISTENT or gameCache == null or this.state == QUEST_STATE_NONE then
                return
            endif
            set key = CACHE_PREFIX + I2S(this.flag)
            call StoreInteger(gameCache, "quests", key, this.state)
            if this.obj1 != 0 then
                call StoreInteger(gameCache, key, "obj1", this.obj1.current) 
            endif
            if this.obj2 != 0 then 
                call StoreInteger(gameCache, key, "obj2", this.obj2.current) 
            endif
            if this.obj3 != 0 then 
                call StoreInteger(gameCache, key, "obj3", this.obj3.current) 
            endif
            if this.obj4 != 0 then 
                call StoreInteger(gameCache, key, "obj4", this.obj4.current) 
            endif
            if this.obj5 != 0 then 
                call StoreInteger(gameCache, key, "obj5", this.obj5.current) 
            endif
        endmethod
        
        method load takes nothing returns nothing
            local string key = CACHE_PREFIX + I2S(this.flag)
            local integer savedState
            
            if gameCache == null or not HaveStoredInteger(gameCache, "quests", key) then 
                return 
            endif
            
            set savedState = GetStoredInteger(gameCache, "quests", key)

            if savedState == QUEST_STATE_NONE then 
                return 
            endif 

            set this.wc3quest = CreateQuest()
            call QuestSetRequired(this.wc3quest, this.questType == QUEST_PERSISTENT)
            call QuestSetTitle(this.wc3quest, this.title)
            call QuestSetIconPath(this.wc3quest, this.icon)
            call QuestSetDescription(this.wc3quest, this.description)
            
            if this.obj1 != 0 then 
                set this.obj1.qi = QuestCreateItem(this.wc3quest)
                set this.obj1.current = GetStoredInteger(gameCache, key, "obj1")
                call QuestItemSetDescription(this.obj1.qi, this.obj1.description + " ("+I2S(this.obj1.current)+"/" + I2S(this.obj1.required) + ")")
                if this.obj1.current >= this.obj1.required then 
                    set this.obj1.completed = true 
                    call QuestItemSetCompleted(this.obj1.qi,true)
                endif 
            endif 
            if this.obj2 != 0 then 
                set this.obj2.qi = QuestCreateItem(this.wc3quest)
                set this.obj2.current = GetStoredInteger(gameCache, key, "obj2")
                call QuestItemSetDescription(this.obj2.qi, this.obj2.description + " ("+I2S(this.obj2.current)+"/" + I2S(this.obj2.required) + ")")
                if this.obj2.current >= this.obj2.required then 
                    set this.obj2.completed = true 
                    call QuestItemSetCompleted(this.obj2.qi,true)
                endif 
            endif 
            if this.obj3 != 0 then 
                set this.obj3.qi = QuestCreateItem(this.wc3quest)
                set this.obj3.current = GetStoredInteger(gameCache, key, "obj3")
                call QuestItemSetDescription(this.obj3.qi, this.obj3.description + " ("+I2S(this.obj3.current)+"/" + I2S(this.obj3.required) + ")")
                if this.obj3.current >= this.obj3.required then 
                    set this.obj3.completed = true 
                    call QuestItemSetCompleted(this.obj3.qi,true)
                endif 
            endif 
            if this.obj4 != 0 then 
                set this.obj4.qi = QuestCreateItem(this.wc3quest)
                set this.obj4.current = GetStoredInteger(gameCache, key, "obj4")
                call QuestItemSetDescription(this.obj4.qi, this.obj4.description + " ("+I2S(this.obj4.current)+"/" + I2S(this.obj4.required) + ")")
                if this.obj4.current >= this.obj4.required then 
                    set this.obj4.completed = true 
                    call QuestItemSetCompleted(this.obj4.qi,true)
                endif 
            endif 
            if this.obj5 != 0 then 
                set this.obj5.qi = QuestCreateItem(this.wc3quest)
                set this.obj5.current = GetStoredInteger(gameCache, key, "obj5")
                call QuestItemSetDescription(this.obj5.qi, this.obj5.description + " ("+I2S(this.obj5.current)+"/" + I2S(this.obj5.required) + ")")
                if this.obj5.current >= this.obj5.required then 
                    set this.obj5.completed = true 
                    call QuestItemSetCompleted(this.obj5.qi,true)
                endif 
            endif 

            if this.onAccept != null then 
                call TriggerExecute(this.onAccept)
            endif 

            set this.state = QUEST_STATE_INPROGRESS
                
            if this.checkCompletion() and this.onFinish != null then 
                call TriggerExecute(this.onFinish)
            endif 
                
            if savedState == QUEST_STATE_COMPLETED then
                set this.state = QUEST_STATE_COMPLETED
                if this.onComplete != null then 
                    call TriggerExecute(this.onComplete)
                endif 

                if this.keepAfterComplete then
                    call QuestSetCompleted(this.wc3quest, true)
                else
                    call DestroyQuest(this.wc3quest)
                endif
            endif
        endmethod
        
        static method getById takes integer id returns thistype
            local thistype this = thistype.first
            loop
                exitwhen this == 0
                if this.id == id then 
                    return this 
                endif
                set this = this.next
            endloop
            return 0
        endmethod

        static method getByFlag takes integer flag returns thistype
            local thistype this = thistype.first
            loop
                exitwhen this == 0
                if this.flag == flag then 
                    return this 
                endif
                set this = this.next
            endloop
            return 0
        endmethod
        
        static method getByObjective takes Objective obj returns thistype
            local thistype this = thistype.first
            loop
                exitwhen this == 0
                if this.hasObjective(obj) then 
                    return this 
                endif
                set this = this.next
            endloop
            return 0
        endmethod
        
        method onDestroy takes nothing returns nothing
            if this.obj1 != 0 then 
                call this.obj1.destroy() 
            endif
            if this.obj2 != 0 then 
                call this.obj2.destroy() 
            endif
            if this.obj3 != 0 then 
                call this.obj3.destroy() 
            endif
            if this.obj4 != 0 then 
                call this.obj4.destroy() 
            endif
            if this.obj5 != 0 then 
                call this.obj5.destroy() 
            endif
            
            if this.wc3quest != null then 
                call DestroyQuest(this.wc3quest) 
            endif
            
            if this.prev != 0 then
                set this.prev.next = this.next
            else
                set thistype.first = this.next
            endif
            if this.next != 0 then 
                set this.next.prev = this.prev 
            endif
            
            if this.onAccept != null then 
                call DestroyTriggerEx(this.onAccept) 
            endif
            if this.onComplete != null then 
                call DestroyTriggerEx(this.onComplete) 
            endif
            if this.onFail != null then 
                call DestroyTriggerEx(this.onFail) 
            endif
        endmethod
    endstruct

    //===========================================================================
    //  QuestManager & 辅助函数 - 无变化
    //===========================================================================
    struct QuestManager
        static method loadAll takes nothing returns nothing
            local Quest q = 1
            loop
                exitwhen q == Quest.first or Quest.first == 0
                call q.load()
                set q = q.prev
            endloop
        endmethod
    endstruct

endlibrary

library QuestDatas initializer init requires QuestSystem

    globals 
        private integer mQI = 0
        private integer sQI = 0
        private integer rQI = 0
        Quest array mainQuest       [500]
        Quest array sideQuest       [500]
        Quest array repeatableQuest [500]
    endglobals
    //////
    // region objAdds
    //////
    function ENEMY_KILLING_n607 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[0].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[0].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n608 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[0].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[0].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n600 takes nothing returns nothing
        if GetRandomReal(0,1) < 0.35 and MAP_INDEX == 1 and sideQuest[1].state == QUEST_STATE_INPROGRESS and sideQuest[1].obj1.completed == false then 
            call CreateItemEx('iq00',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ENEMY_KILLING_n601 takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 1 and sideQuest[1].state == QUEST_STATE_INPROGRESS and sideQuest[1].obj1.completed == false  then 
            call CreateItemEx('iq00',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ITEM_PICK_iq00 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[1].state == QUEST_STATE_INPROGRESS and sideQuest[2].obj1.completed == false  then 
            call sideQuest[1].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n602 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[2].state == QUEST_STATE_INPROGRESS then 
            call CreateItemEx('iq01',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ITEM_PICK_iq01 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[2].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[2].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n609 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[3].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[3].obj1.addProgress()
        endif 
    endfunction
    
    function ITEM_PICK_IK00 takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call mainQuest[0].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_IK03 takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call mainQuest[1].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n60A takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[4].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[4].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n60B takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[4].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[4].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n60C takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[4].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[4].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n60D takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[4].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[4].obj1.addProgress()
        endif 
    endfunction

    function ITEM_PICK_iq02 takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call mainQuest[5].obj1.addProgress()
        endif 
    endfunction

    function ITEM_PICK_IK0I takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call mainQuest[6].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_IK0M takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call mainQuest[7].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_IK11 takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call mainQuest[12].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_IK1D takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call mainQuest[16].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_IQ0G takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call sideQuest[5].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_IQ0U takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call sideQuest[10].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_IQ13 takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call sideQuest[13].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_IQ17 takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call sideQuest[14].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_IQ0X takes nothing returns nothing
        if MAP_INDEX == 2 then 
            call sideQuest[11].obj1.addProgress()
        endif 
    endfunction

    function ITEM_PICK_iq0C takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call sideQuest[18].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_iq0D takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call sideQuest[19].obj1.addProgress()
        endif 
    endfunction
    
    function ENEMY_KILLING_n62G takes nothing returns nothing
        if GetRandomReal(0,1) < 0.3 and MAP_INDEX == 1 and sideQuest[26].state == QUEST_STATE_INPROGRESS and sideQuest[26].obj1.completed == false  then 
            call CreateItemEx('iq0F',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ENEMY_KILLING_n62I takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 1 and sideQuest[26].state == QUEST_STATE_INPROGRESS and sideQuest[26].obj1.completed == false  then 
            call CreateItemEx('iq0F',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ENEMY_KILLING_n62H takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 1 and sideQuest[26].state == QUEST_STATE_INPROGRESS and sideQuest[26].obj1.completed == false  then 
            call CreateItemEx('iq0F',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ITEM_PICK_iq0F takes nothing returns nothing
        if MAP_INDEX == 1 then 
            call sideQuest[26].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n624 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[15].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[15].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n621 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[15].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[15].obj2.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n622 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[15].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[15].obj4.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n623 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[15].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[15].obj3.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n625 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[16].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[16].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n63W takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[17].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[17].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n644 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[27].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[27].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n633 takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[28].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[28].obj1.addProgress()
        endif 
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 2 and sideQuest[32].state == QUEST_STATE_INPROGRESS and sideQuest[32].obj1.completed == false  then 
            call CreateItemEx('iq0I',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction

    function ENEMY_KILLING_n634 takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[28].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[28].obj2.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n630 takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[29].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[29].obj1.addProgress()
        endif 
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 2 and sideQuest[29].state == QUEST_STATE_INPROGRESS and sideQuest[29].obj2.completed == false  then 
            call CreateItemEx('iq0H',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction

    function ENEMY_KILLING_n631 takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[29].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[29].obj1.addProgress()
        endif 
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 2 and sideQuest[29].state == QUEST_STATE_INPROGRESS and sideQuest[29].obj2.completed == false  then 
            call CreateItemEx('iq0H',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction

    function ENEMY_KILLING_n632 takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[29].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[29].obj1.addProgress()
        endif 
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 2 and sideQuest[29].state == QUEST_STATE_INPROGRESS and sideQuest[29].obj2.completed == false  then 
            call CreateItemEx('iq0H',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction

    function ITEM_PICK_iq0H takes nothing returns nothing
        if sideQuest[29].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[29].obj2.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n635 takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[30].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[30].obj1.addProgress()
        endif 
    endfunction

    function ITEM_PICK_iq0I takes nothing returns nothing
        if sideQuest[32].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[32].obj1.addProgress()
        endif 
    endfunction

    function ITEM_PICK_iq0J takes nothing returns nothing
        if sideQuest[33].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[33].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n63A takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[34].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[34].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n63B takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[34].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[34].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n63C takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[35].state == QUEST_STATE_INPROGRESS and sideQuest[35].obj1.completed == false  then 
            call CreateItemEx('iq0K',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction

    function ITEM_PICK_iq0K takes nothing returns nothing
        if sideQuest[35].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[35].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n639 takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[36].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[36].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n63G takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[37].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[37].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n63S takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[38].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[38].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n63N takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[39].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[39].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n63H takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[40].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[40].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n63E takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[40].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[40].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n63D takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[40].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[40].obj1.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n64F takes nothing returns nothing
        if MAP_INDEX == 2 and sideQuest[41].state == QUEST_STATE_INPROGRESS and sideQuest[41].obj1.completed == false  then 
            call CreateItemEx('iq0M',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction

    function ITEM_PICK_iq0M takes nothing returns nothing
        if sideQuest[41].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[41].obj1.addProgress()
        endif 
    endfunction



    function ITEM_PICK_IQ0D takes nothing returns nothing
        local integer i = 0
        if MAP_INDEX == 1 then 
            loop 
                exitwhen i > 5
                if GetItemTypeId(UnitItemInSlot(itemTriggerUnit,i)) == 'iq04' then 
                    exitwhen true 
                endif 
                set i = i+1
            endloop
            if i > 5 then
                call DisplayErrorMsg("|cffffcc00请选择带有任务物品的英雄。|r")
            elseif GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) < 6 then 
                call DisplayErrorMsg("|cffffcc00物品数量不足（需要：6）。|r")
            else 
                if GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) == 6 then 
                    call RemoveItem(UnitItemInSlot(itemTriggerUnit,i))
                else 
                    call SetItemCharges(UnitItemInSlot(itemTriggerUnit,i),GetItemCharges(UnitItemInSlot(itemTriggerUnit,i))-6)
                endif 
                call sideQuest[4].obj1.addProgress()
            endif 
        endif 
    endfunction
    function ITEM_PICK_IQ10 takes nothing returns nothing
        local integer i = 0
        if MAP_INDEX == 1 then 
            loop 
                exitwhen i > 5
                if GetItemTypeId(UnitItemInSlot(itemTriggerUnit,i)) == 'ID00' then 
                    exitwhen true 
                endif 
                set i = i+1
            endloop
            if i > 5 then
                call DisplayErrorMsg("|cffffcc00请选择带有任务物品的英雄。|r")
            elseif GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) < 4 then 
                call DisplayErrorMsg("|cffffcc00物品数量不足（需要：4）。|r")
            else 
                if GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) == 4 then 
                    call RemoveItem(UnitItemInSlot(itemTriggerUnit,i))
                else 
                    call SetItemCharges(UnitItemInSlot(itemTriggerUnit,i),GetItemCharges(UnitItemInSlot(itemTriggerUnit,i))-4)
                endif 
                call sideQuest[12].obj1.addProgress()
            endif 
        endif 
    endfunction
    function ITEM_PICK_IQ1S takes nothing returns nothing
        local integer i = 0
        local integer req = 3
        if MAP_INDEX == 1 then 
            loop 
                exitwhen i > 5
                if GetItemTypeId(UnitItemInSlot(itemTriggerUnit,i)) == 'IMH2' then 
                    exitwhen true 
                endif 
                set i = i+1
            endloop
            if i > 5 then
                call DisplayErrorMsg("|cffffcc00请选择带有任务物品的英雄。|r")
            elseif GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) < req then 
                call DisplayErrorMsg("|cffffcc00物品数量不足（需要："+I2S(req)+"）。|r")
            else 
                if GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) == req then 
                    call RemoveItem(UnitItemInSlot(itemTriggerUnit,i))
                else 
                    call SetItemCharges(UnitItemInSlot(itemTriggerUnit,i),GetItemCharges(UnitItemInSlot(itemTriggerUnit,i))-req)
                endif 
                call sideQuest[21].obj1.addProgress()
            endif 
        endif 
    endfunction
    function ITEM_PICK_IQ1V takes nothing returns nothing
        local integer i = 0
        local integer req = 3
        if MAP_INDEX == 1 then 
            loop 
                exitwhen i > 5
                if GetItemTypeId(UnitItemInSlot(itemTriggerUnit,i)) == 'IMH0' then 
                    exitwhen true 
                endif 
                set i = i+1
            endloop
            if i > 5 then
                call DisplayErrorMsg("|cffffcc00请选择带有任务物品的英雄。|r")
            elseif GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) < req then 
                call DisplayErrorMsg("|cffffcc00物品数量不足（需要："+I2S(req)+"）。|r")
            else 
                if GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) == req then 
                    call RemoveItem(UnitItemInSlot(itemTriggerUnit,i))
                else 
                    call SetItemCharges(UnitItemInSlot(itemTriggerUnit,i),GetItemCharges(UnitItemInSlot(itemTriggerUnit,i))-req)
                endif 
                call sideQuest[22].obj1.addProgress()
            endif 
        endif 
    endfunction
    function ITEM_PICK_IQ1Y takes nothing returns nothing
        local integer i = 0
        local integer req = 3
        if MAP_INDEX == 1 then 
            loop 
                exitwhen i > 5
                if GetItemTypeId(UnitItemInSlot(itemTriggerUnit,i)) == 'IMH1' then 
                    exitwhen true 
                endif 
                set i = i+1
            endloop
            if i > 5 then
                call DisplayErrorMsg("|cffffcc00请选择带有任务物品的英雄。|r")
            elseif GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) < req then 
                call DisplayErrorMsg("|cffffcc00物品数量不足（需要："+I2S(req)+"）。|r")
            else 
                if GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) == req then 
                    call RemoveItem(UnitItemInSlot(itemTriggerUnit,i))
                else 
                    call SetItemCharges(UnitItemInSlot(itemTriggerUnit,i),GetItemCharges(UnitItemInSlot(itemTriggerUnit,i))-req)
                endif 
                call sideQuest[23].obj1.addProgress()
            endif 
        endif 
    endfunction
    function ITEM_PICK_IQ21 takes nothing returns nothing
        local integer i = 0
        local integer req = 1
        if MAP_INDEX == 1 then 
            loop 
                exitwhen i > 5
                if GetItemTypeId(UnitItemInSlot(itemTriggerUnit,i)) == 'IMH9' then 
                    exitwhen true 
                endif 
                set i = i+1
            endloop
            if i > 5 then
                call DisplayErrorMsg("|cffffcc00请选择带有任务物品的英雄。|r")
            elseif GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) < req then 
                call DisplayErrorMsg("|cffffcc00物品数量不足（需要："+I2S(req)+"）。|r")
            else 
                if GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) == req then 
                    call RemoveItem(UnitItemInSlot(itemTriggerUnit,i))
                else 
                    call SetItemCharges(UnitItemInSlot(itemTriggerUnit,i),GetItemCharges(UnitItemInSlot(itemTriggerUnit,i))-req)
                endif 
                call sideQuest[24].obj1.addProgress()
            endif 
        endif 
    endfunction
    function ITEM_PICK_IQ3J takes nothing returns nothing
        local integer i = 0
        local integer req = 5
        if MAP_INDEX == 2 then 
            loop 
                exitwhen i > 5
                if GetItemTypeId(UnitItemInSlot(itemTriggerUnit,i)) == 'IMO5' then 
                    exitwhen true 
                endif 
                set i = i+1
            endloop
            if i > 5 then
                call DisplayErrorMsg("|cffffcc00请选择带有任务物品的英雄。|r")
            elseif GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) < req then 
                call DisplayErrorMsg("|cffffcc00物品数量不足（需要："+I2S(req)+"）。|r")
            else 
                if GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) == req then 
                    call RemoveItem(UnitItemInSlot(itemTriggerUnit,i))
                else 
                    call SetItemCharges(UnitItemInSlot(itemTriggerUnit,i),GetItemCharges(UnitItemInSlot(itemTriggerUnit,i))-req)
                endif 
                call sideQuest[42].obj1.addProgress()
            endif 
        endif 
    endfunction
    function ITEM_PICK_IR01 takes nothing returns nothing
        local integer i = 0
        if MAP_INDEX == 1 then 
            loop 
                exitwhen i > 5
                if GetItemTypeId(UnitItemInSlot(itemTriggerUnit,i)) == 'iq04' then 
                    exitwhen true 
                endif 
                set i = i+1
            endloop
            if i > 5 then
                call DisplayErrorMsg("|cffffcc00请选择带有任务物品的英雄。|r")
            elseif GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) < 6 then 
                call DisplayErrorMsg("|cffffcc00物品数量不足（需要：6）。|r")
            else 
                if GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) == 6 then 
                    call RemoveItem(UnitItemInSlot(itemTriggerUnit,i))
                else 
                    call SetItemCharges(UnitItemInSlot(itemTriggerUnit,i),GetItemCharges(UnitItemInSlot(itemTriggerUnit,i))-6)
                endif 
                call repeatableQuest[0].obj1.addProgress()
            endif 
        endif 
    endfunction
    function ITEM_PICK_IR04 takes nothing returns nothing
        local integer i = 0
        if MAP_INDEX == 1 then 
            loop 
                exitwhen i > 5
                if GetItemTypeId(UnitItemInSlot(itemTriggerUnit,i)) == 'iq0B' then 
                    exitwhen true 
                endif 
                set i = i+1
            endloop
            if i > 5 then
                call DisplayErrorMsg("|cffffcc00请选择带有任务物品的英雄。|r")
            elseif GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) < 4 then 
                call DisplayErrorMsg("|cffffcc00物品数量不足（需要：4）。|r")
            else 
                if GetItemCharges(UnitItemInSlot(itemTriggerUnit,i)) == 4 then 
                    call RemoveItem(UnitItemInSlot(itemTriggerUnit,i))
                else 
                    call SetItemCharges(UnitItemInSlot(itemTriggerUnit,i),GetItemCharges(UnitItemInSlot(itemTriggerUnit,i))-4)
                endif 
                call repeatableQuest[1].obj1.addProgress()
            endif 
        endif 
    endfunction


    function ENEMY_KILLING_n612 takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[8].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[8].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n60O takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[8].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[8].obj2.addProgress()
        endif 
    endfunction

    function ENEMY_KILLING_n613 takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[10].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[10].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n614 takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[10].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[10].obj2.addProgress()
        endif 
    endfunction
    
    function ENEMY_KILLING_n61O takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 1 and sideQuest[6].state == QUEST_STATE_INPROGRESS and sideQuest[6].obj1.completed == false  then 
            call CreateItemEx('iq05',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
        if MAP_INDEX == 1 and sideQuest[8].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[8].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n61N takes nothing returns nothing
        if GetRandomReal(0,1) < 0.25 and MAP_INDEX == 1 and sideQuest[6].state == QUEST_STATE_INPROGRESS and sideQuest[6].obj1.completed == false  then 
            call CreateItemEx('iq05',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
        if MAP_INDEX == 1 and sideQuest[8].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[8].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n61P takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[8].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[8].obj2.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n61G takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 1 and sideQuest[6].state == QUEST_STATE_INPROGRESS and sideQuest[6].obj2.completed == false  then 
            call CreateItemEx('iq06',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ITEM_PICK_iq05 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[6].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[6].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_iq06 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[6].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[6].obj2.addProgress()
        endif 
    endfunction

    
    function ENEMY_KILLING_n61H takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 1 and sideQuest[7].state == QUEST_STATE_INPROGRESS and sideQuest[7].obj1.completed == false  then 
            call CreateItemEx('iq07',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ENEMY_KILLING_n61I takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 1 and sideQuest[7].state == QUEST_STATE_INPROGRESS and sideQuest[7].obj1.completed == false  then 
            call CreateItemEx('iq07',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ENEMY_KILLING_n61J takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 1 and sideQuest[7].state == QUEST_STATE_INPROGRESS and sideQuest[7].obj1.completed == false  then 
            call CreateItemEx('iq07',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ENEMY_KILLING_n61K takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 1 and sideQuest[7].state == QUEST_STATE_INPROGRESS and sideQuest[7].obj1.completed == false  then 
            call CreateItemEx('iq07',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ENEMY_KILLING_n61L takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and MAP_INDEX == 1 and sideQuest[7].state == QUEST_STATE_INPROGRESS and sideQuest[7].obj1.completed == false  then 
            call CreateItemEx('iq07',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ENEMY_KILLING_n61M takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[7].state == QUEST_STATE_INPROGRESS and sideQuest[7].obj2.completed == false  then 
            call CreateItemEx('iq08',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction
    function ITEM_PICK_iq07 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[7].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[7].obj1.addProgress()
        endif 
    endfunction
    function ITEM_PICK_iq08 takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[7].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[7].obj2.addProgress()
        endif 
    endfunction
    
    function ENEMY_KILLING_n62J takes nothing returns nothing
        if MAP_INDEX == 1 and sideQuest[18].state == QUEST_STATE_INPROGRESS and sideQuest[18].obj1.completed == false  then 
            call CreateItemEx('iq0C',GetUnitX(eventDyingUnit),GetUnitY(eventDyingUnit))
        endif 
    endfunction

    
    function ENEMY_KILLING_n61R takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[13].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[13].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n61S takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[13].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[13].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n61T takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[13].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[13].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n61U takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[13].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[13].obj1.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n62D takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[13].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[13].obj2.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n60Q takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[13].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[13].obj3.addProgress()
        endif 
    endfunction
    function ENEMY_KILLING_n60R takes nothing returns nothing
        if MAP_INDEX == 1 and mainQuest[13].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[13].obj4.addProgress()
        endif 
    endfunction

    function ITEM_PICK_iq0A takes nothing returns nothing
        if mainQuest[15].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[15].obj5.addProgress()
        endif 
    endfunction

    //////
    // endregion 
    //////

    //////
    // region questItems
    //////
    function ITEM_PICK_IQ00 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[0].state == QUEST_STATE_NONE then 
            call sideQuest[0].accept()
        endif
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ02 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[0].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[0].complete()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ03 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[1].state == QUEST_STATE_NONE then 
            call sideQuest[1].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ05 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[1].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[1].complete()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ06 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[2].state == QUEST_STATE_NONE then 
            call sideQuest[2].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ08 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[2].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[2].complete()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ09 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[3].state == QUEST_STATE_NONE then 
            call sideQuest[3].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ0B takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[3].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[3].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IK01 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[0].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[0].complete()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IK02 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[1].state == QUEST_STATE_NONE then 
            call mainQuest[1].accept()
        endif 
        call PerformStockUpdates()
        call PingMinimap(GetUnitX(mainQuest[1].anotherOwner),GetUnitY(mainQuest[1].anotherOwner),5)
    endfunction
    function ITEM_PICK_IK04 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[1].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[1].complete()
        endif 
        call PerformStockUpdates()
        call PingMinimap(GetUnitX(mainQuest[1].owner),GetUnitY(mainQuest[1].owner),5)
        call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffadadff提示：|r在军需官和旁边的装甲架可以购买到一些基础装备。利用它们武装你的队伍，可以使旅程轻松不少。")
    endfunction
    function ITEM_PICK_IK05 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[2].state == QUEST_STATE_NONE then 
            call mainQuest[2].accept()
        endif 
        call PerformStockUpdates()
        call PingMinimap(1136,-1920,1.5)
    endfunction
    function ITEM_PICK_IK07 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[2].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[2].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IK08 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[3].state == QUEST_STATE_NONE then 
            call mainQuest[3].accept()
        endif 
        call PerformStockUpdates()
        call PingMinimap(1136,-1920,1.5)
    endfunction
    function ITEM_PICK_IK0A takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[3].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[3].complete()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IK0B takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[4].state == QUEST_STATE_NONE then 
            call mainQuest[4].accept()
        endif 
        call PerformStockUpdates()
        call PingMinimap(1136,-1920,1.5)
    endfunction
    function ITEM_PICK_IK0D takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[4].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[4].complete()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IK0E takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[5].state == QUEST_STATE_NONE then 
            call mainQuest[5].accept()
        endif 
        call PerformStockUpdates()
        call PingMinimap(1136,-1920,1.5)
    endfunction
    function ITEM_PICK_IK0G takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[5].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[5].complete()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IK0H takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[6].state == QUEST_STATE_NONE then 
            call mainQuest[6].accept()
        endif 
        call PerformStockUpdates()
        call PingMinimap(10154,-11707,5)
    endfunction
    function ITEM_PICK_IK0J takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[6].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[6].complete()
        endif 
        call PerformStockUpdates()
        call PingMinimap(11983,-13220,5)
    endfunction
    function ITEM_PICK_IK0L takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[7].state == QUEST_STATE_NONE then 
            call mainQuest[7].accept()
        endif 
        call PerformStockUpdates()
        call PingMinimap(8900,-22379,5)
    endfunction
    function ITEM_PICK_IK0N takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[7].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[7].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IK0O takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[8].state == QUEST_STATE_NONE then 
            call mainQuest[8].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IK0Q takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[8].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[8].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IK0R takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[9].state == QUEST_STATE_NONE then 
            call mainQuest[9].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IK0T takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[9].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[9].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IK0U takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[10].state == QUEST_STATE_NONE then 
            call mainQuest[10].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IK0W takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[10].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[10].complete()
        endif 
        call PerformStockUpdates()
        call PingMinimap(11963,-13235,5)
    endfunction

    function ITEM_PICK_IK0X takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[11].state == QUEST_STATE_NONE then 
            call mainQuest[11].accept()
        endif 
        call PerformStockUpdates()
        call PingMinimap(11711,-15415,5)
    endfunction
    function ITEM_PICK_IK0Z takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[11].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[11].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IK10 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[12].state == QUEST_STATE_NONE then 
            call mainQuest[12].accept()
        endif 
        call PerformStockUpdates()
        call PingMinimap(8352,-8232,5)
    endfunction
    function ITEM_PICK_IK12 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[12].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[12].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IK13 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[13].state == QUEST_STATE_NONE then 
            call mainQuest[13].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IK15 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[13].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[13].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IK16 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[14].state == QUEST_STATE_NONE then 
            call mainQuest[14].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IK18 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[14].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[14].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IK19 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[15].state == QUEST_STATE_NONE then 
            call mainQuest[15].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IK1B takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[15].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[15].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IK1C takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[16].state == QUEST_STATE_NONE then 
            call mainQuest[16].accept()
        endif 
        call PerformStockUpdates()
        call PingMinimap(GetUnitX(mainQuest[16].anotherOwner),GetUnitY(mainQuest[16].anotherOwner),5)
    endfunction
    function ITEM_PICK_IK1E takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if mainQuest[16].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[16].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ0C takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[4].state == QUEST_STATE_NONE then 
            call sideQuest[4].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ0E takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[4].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[4].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ0F takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[5].state == QUEST_STATE_NONE then 
            call sideQuest[5].accept()
        endif 
        call PerformStockUpdates()
        call PingMinimap(19197,-11718,5)
    endfunction
    function ITEM_PICK_IQ0H takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[5].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[5].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ0I takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[6].state == QUEST_STATE_NONE then 
            call sideQuest[6].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ0K takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[6].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[6].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ0L takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[7].state == QUEST_STATE_NONE then 
            call sideQuest[7].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ0N takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[7].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[7].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ0O takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[8].state == QUEST_STATE_NONE then 
            call sideQuest[8].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ0Q takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[8].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[8].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ0T takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[10].state == QUEST_STATE_NONE then 
            call sideQuest[10].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ0V takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[10].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[10].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    
    function ITEM_PICK_iq09 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[9].state == QUEST_STATE_NONE then 
            call sideQuest[9].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ0S takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[9].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[9].complete()
            if sideQuest[13].state == QUEST_STATE_INPROGRESS then 
                call QuestReplaceDialog(sideQuest[13].anotherOwner,'IQ15','IQ13',1)
            endif 
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ0W takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[11].state == QUEST_STATE_NONE then 
            call sideQuest[11].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ0Y takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[11].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[11].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ0Z takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[12].state == QUEST_STATE_NONE then 
            call sideQuest[12].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ11 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[12].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[12].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ12 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[13].state == QUEST_STATE_NONE then 
            call sideQuest[13].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ14 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[13].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[13].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ16 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[14].state == QUEST_STATE_NONE then 
            call sideQuest[14].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ18 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[14].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[14].complete()
        endif 
        if MAP_INDEX == 1 then 
            call delayedPlayAnimation(sideQuest[14].anotherOwner,"spell slam",100)
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ19 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[15].state == QUEST_STATE_NONE then 
            call sideQuest[15].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ1B takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[15].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[15].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ1C takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[16].state == QUEST_STATE_NONE then 
            call sideQuest[16].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ1E takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[16].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[16].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ1F takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[17].state == QUEST_STATE_NONE then 
            call sideQuest[17].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ1H takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[17].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[17].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ1I takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[18].state == QUEST_STATE_NONE then 
            call sideQuest[18].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ1K takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[18].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[18].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ1L takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[19].state == QUEST_STATE_NONE then 
            call sideQuest[19].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ1N takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[19].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[19].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ1O takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[20].state == QUEST_STATE_NONE then 
            call sideQuest[20].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ1Q takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[20].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[20].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ1R takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[21].state == QUEST_STATE_NONE then 
            call sideQuest[21].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ1T takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[21].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[21].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ1U takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[22].state == QUEST_STATE_NONE then 
            call sideQuest[22].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ1W takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[22].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[22].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ1X takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[23].state == QUEST_STATE_NONE then 
            call sideQuest[23].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ1Z takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[23].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[23].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ20 takes nothing returns nothing
        local integer id = 24
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ22 takes nothing returns nothing
        local integer id = 24
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ23 takes nothing returns nothing
        local integer id = 25
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ25 takes nothing returns nothing
        local integer id = 25
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ26 takes nothing returns nothing
        local integer id = 26
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ28 takes nothing returns nothing
        local integer id = 26
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ29 takes nothing returns nothing
        local integer id = 27
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ2B takes nothing returns nothing
        local integer id = 27
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ2C takes nothing returns nothing
        local integer id = 28
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ2E takes nothing returns nothing
        local integer id = 28
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ2F takes nothing returns nothing
        local integer id = 29
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ2H takes nothing returns nothing
        local integer id = 29
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ2I takes nothing returns nothing
        local integer id = 30
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ2K takes nothing returns nothing
        local integer id = 30
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ2L takes nothing returns nothing
        local integer id = 31
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ2N takes nothing returns nothing
        local integer id = 31
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ2O takes nothing returns nothing
        local integer id = 32
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ2Q takes nothing returns nothing
        local integer id = 32
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ2R takes nothing returns nothing
        local integer id = 33
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ2T takes nothing returns nothing
        local integer id = 33
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ2U takes nothing returns nothing
        local integer id = 34
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ2W takes nothing returns nothing
        local integer id = 34
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ2X takes nothing returns nothing
        local integer id = 35
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ2Z takes nothing returns nothing
        local integer id = 35
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ30 takes nothing returns nothing
        local integer id = 36
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ32 takes nothing returns nothing
        local integer id = 36
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ33 takes nothing returns nothing
        local integer id = 37
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ35 takes nothing returns nothing
        local integer id = 37
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ36 takes nothing returns nothing
        local integer id = 38
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ38 takes nothing returns nothing
        local integer id = 38
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ39 takes nothing returns nothing
        local integer id = 39
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ3B takes nothing returns nothing
        local integer id = 39
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ3C takes nothing returns nothing
        local integer id = 40
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ3E takes nothing returns nothing
        local integer id = 40
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ3F takes nothing returns nothing
        local integer id = 41
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ3H takes nothing returns nothing
        local integer id = 41
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ3I takes nothing returns nothing
        local integer id = 42
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ3K takes nothing returns nothing
        local integer id = 42
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IQ3L takes nothing returns nothing
        local integer id = 43
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_NONE then 
            call sideQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IQ3N takes nothing returns nothing
        local integer id = 43
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if sideQuest[id].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction



    function ITEM_PICK_IR00 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if repeatableQuest[0].state == QUEST_STATE_NONE then 
            call repeatableQuest[0].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IR02 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if repeatableQuest[0].state == QUEST_STATE_INPROGRESS then 
            call repeatableQuest[0].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IR03 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if repeatableQuest[1].state == QUEST_STATE_NONE then 
            call repeatableQuest[1].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IR05 takes nothing returns nothing
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if repeatableQuest[1].state == QUEST_STATE_INPROGRESS then 
            call repeatableQuest[1].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    function ITEM_PICK_IR06 takes nothing returns nothing
        local integer id = 2
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if repeatableQuest[id].state == QUEST_STATE_NONE then 
            call repeatableQuest[id].accept()
        endif 
        call PerformStockUpdates()
    endfunction
    function ITEM_PICK_IR08 takes nothing returns nothing
        local integer id = 2
        set QUEST_EVENT_UNIT = itemTriggerUnit
        if repeatableQuest[id].state == QUEST_STATE_INPROGRESS then 
            call repeatableQuest[id].complete()
        endif 
        call PerformStockUpdates()
    endfunction

    //////
    // endregion
    //////

    //////
    // region questCallBacks
    //////
    function QUEST_ACCEPT_MQ0 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 0
        call QuestAddDialog(mainQuest[mQI].owner,'IK00',1)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
    endfunction
    function QUEST_FINISH_MQ0 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 0
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK00','IK01',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_COMPLETE_MQ0 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 0
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK01','IK02',1)
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
        call NPC.addExclamation_Y(mainQuest[mQI].owner)
    endfunction

    function QUEST_ACCEPT_MQ1 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 1
        call QuestSwapDialog(mainQuest[mQI].owner,'IK02',mainQuest[mQI].anotherOwner,'IK03',1)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].anotherOwner)
    endfunction
    function QUEST_FINISH_MQ1 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 1
        call QuestReplaceDialog(mainQuest[mQI].anotherOwner,'IK03','IK04',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].anotherOwner)
        call NPC.addQuestion_Y(mainQuest[mQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_MQ1 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 1
        call QuestSwapDialog(mainQuest[mQI].anotherOwner,'IK04',mainQuest[mQI].owner,'IK05',1)
        call NPC.reduceQuestion_Y(mainQuest[mQI].anotherOwner)
        call NPC.addExclamation_Y(mainQuest[mQI].owner)
    endfunction

    function QUEST_ACCEPT_MQ2 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 2
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK05','IK06',0)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
    endfunction
    function QUEST_FINISH_MQ2 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 2
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK06','IK07',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_COMPLETE_MQ2 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 2
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK07','IK08',1)
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
        call NPC.addExclamation_Y(mainQuest[mQI].owner)
        call QuestAddDialog(mainQuest[mQI].owner,'IK0B',1)
        call NPC.addExclamation_Y(mainQuest[mQI].owner)
        call QuestAddDialog(mainQuest[mQI].owner,'IK0E',1)
        call NPC.addExclamation_Y(mainQuest[mQI].owner)
    endfunction

    function QUEST_ACCEPT_MQ3 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 3
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK08','IK09',0)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
    endfunction
    function QUEST_FINISH_MQ3 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 3
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK09','IK0A',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
        call ShowUnit(mainQuest[6].owner,true)
    endfunction
    function QUEST_COMPLETE_MQ3 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 3
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK0A')
        if mainQuest[6].state == QUEST_STATE_UNKNOWN and mainQuest[6].prereqsCompleted() then 
            set mainQuest[6].state = QUEST_STATE_NONE
            call QuestAddDialog(mainQuest[6].owner,'IK0H',1)
            call NPC.addExclamation_Y(mainQuest[6].owner)
        endif 
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_FAIL_MQ3 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 3
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK09','IK08',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addExclamation_Y(mainQuest[mQI].owner)
    endfunction

    function QUEST_ACCEPT_MQ4 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 4
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0B','IK0C',0)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
    endfunction
    function QUEST_FINISH_MQ4 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 4
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0C','IK0D',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_COMPLETE_MQ4 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 4
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK0D')
        if mainQuest[6].state == QUEST_STATE_UNKNOWN and mainQuest[6].prereqsCompleted() then 
            set mainQuest[6].state = QUEST_STATE_NONE
            call QuestAddDialog(mainQuest[6].owner,'IK0H',1)
            call NPC.addExclamation_Y(mainQuest[6].owner)
        endif 
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
    endfunction

    function QUEST_ACCEPT_MQ5 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 5
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0E','IK0F',0)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
    endfunction
    function QUEST_FINISH_MQ5 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 5
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0F','IK0G',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_COMPLETE_MQ5 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 5
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK0G')
        if mainQuest[6].state == QUEST_STATE_UNKNOWN and mainQuest[6].prereqsCompleted() then 
            set mainQuest[6].state = QUEST_STATE_NONE
            call QuestAddDialog(mainQuest[6].owner,'IK0H',1)
            call NPC.addExclamation_Y(mainQuest[6].owner)
        endif
        if mainQuest[6].state == QUEST_STATE_COMPLETED then 
            call QuestAddDialog(mainQuest[6].owner,'IK0H',1)
            call NPC.addExclamation_Y(mainQuest[6].owner)
        endif
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
    endfunction

    function QUEST_ACCEPT_MQ6 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 6
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK0H')
        call QuestRemoveDialog(mainQuest[mQI].anotherOwner,'IK0K')
        call QuestAddDialog(mainQuest[mQI].anotherOwner,'IK0I',1)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].anotherOwner)
    endfunction
    function QUEST_FINISH_MQ6 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 6
        call QuestReplaceDialog(mainQuest[mQI].anotherOwner,'IK0I','IK0J',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].anotherOwner)
        call NPC.addQuestion_Y(mainQuest[mQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_MQ6 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 6
        call QuestRemoveDialog(mainQuest[mQI].anotherOwner,'IK0J')
        call QuestAddDialog(mainQuest[7].owner,'IK0L',1)
        call NPC.addExclamation_Y(mainQuest[7].owner)
        call NPC.reduceQuestion_Y(mainQuest[mQI].anotherOwner)
    endfunction

    function QUEST_ACCEPT_MQ7 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 7
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK0L')
        call QuestAddDialog(mainQuest[mQI].anotherOwner,'IK0M',1)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].anotherOwner)
    endfunction
    function QUEST_FINISH_MQ7 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 7
        call QuestReplaceDialog(mainQuest[mQI].anotherOwner,'IK0M','IK0N',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].anotherOwner)
        call NPC.addQuestion_Y(mainQuest[mQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_MQ7 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 7
        call QuestReplaceDialog(mainQuest[mQI].anotherOwner,'IK0N','IK0O',1)
        call QuestAddDialog(mainQuest[9].owner,'IK0R',1)
        call NPC.reduceQuestion_Y(mainQuest[mQI].anotherOwner)
        call NPC.addExclamation_Y(mainQuest[8].owner)
        call NPC.addExclamation_Y(mainQuest[9].owner)
    endfunction

    function QUEST_ACCEPT_MQ8 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 8
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0O','IK0P',0)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
    endfunction
    function QUEST_FINISH_MQ8 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 8
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0P','IK0Q',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_COMPLETE_MQ8 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 8
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK0Q')
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
        if mainQuest[10].state == QUEST_STATE_UNKNOWN and mainQuest[10].prereqsCompleted() then 
            set mainQuest[10].state = QUEST_STATE_NONE
            call QuestAddDialog(mainQuest[10].owner,'IK0U',1)
            call NPC.addExclamation_Y(mainQuest[10].owner)
        endif
    endfunction

    function QUEST_ACCEPT_MQ9 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 9
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0R','IK0S',0)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
    endfunction
    function QUEST_FINISH_MQ9 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 9
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0S','IK0T',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_COMPLETE_MQ9 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 9
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK0T')
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
        if mainQuest[10].state == QUEST_STATE_UNKNOWN and mainQuest[10].prereqsCompleted() then 
            set mainQuest[10].state = QUEST_STATE_NONE
            call QuestAddDialog(mainQuest[10].owner,'IK0U',1)
            call NPC.addExclamation_Y(mainQuest[10].owner)
        endif
        call QuestAddDialog(sideQuest[5].owner,'IQ0F',1)
        call NPC.addExclamation_Y(sideQuest[5].owner)
    endfunction
    function QUEST_FAIL_MQ9 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 9
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0S','IK0R',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addExclamation_Y(mainQuest[mQI].owner)
    endfunction
    
    function QUEST_ACCEPT_MQ10 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 10
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0U','IK0V',0)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
    endfunction
    function QUEST_FINISH_MQ10 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 10
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0V','IK0W',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_COMPLETE_MQ10 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 10
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK0W')
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
        call QuestAddDialog(mainQuest[11].owner,'IK0X',1)
        call NPC.addExclamation_Y(mainQuest[11].owner)
        
        call QuestAddDialog(sideQuest[4].owner,'IQ0C',1)
        call NPC.addExclamation_Y(sideQuest[4].owner)
    endfunction

    
    function QUEST_ACCEPT_MQ11 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 11
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0X','IK0Y',0)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
        call StoreInteger(gameCache,"KEY",KEY_DUNGEON_JAIL,1)
    endfunction
    function QUEST_FINISH_MQ11 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 11
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0Y','IK0Z',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_COMPLETE_MQ11 takes nothing returns nothing
        call DestroyQuest(mainQuest[6].wc3quest)
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 11
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK0Z','IK10',1)
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
        call NPC.addExclamation_Y(mainQuest[mQI].owner)
        call ShowUnit(mainQuest[mQI].anotherOwner,true)
    endfunction

    function QUEST_ACCEPT_MQ12 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 12
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK10')
        call QuestAddDialog(mainQuest[mQI].anotherOwner,'IK11',1)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].anotherOwner)
        call ShowUnit(mainQuest[8].owner,false)
    endfunction
    function QUEST_FINISH_MQ12 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 12
        call QuestReplaceDialog(mainQuest[mQI].anotherOwner,'IK11','IK12',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].anotherOwner)
        call NPC.addQuestion_Y(mainQuest[mQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_MQ12 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 12
        call QuestReplaceDialog(mainQuest[mQI].anotherOwner,'IK12','IK13',1)
        call NPC.reduceQuestion_Y(mainQuest[mQI].anotherOwner)
        call NPC.addExclamation_Y(mainQuest[mQI].anotherOwner)
        call QuestAddDialog(mainQuest[mQI].anotherOwner,'IK16',1)
        call NPC.addExclamation_Y(mainQuest[mQI].anotherOwner)
    endfunction

    function QUEST_ACCEPT_MQ13 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 13
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK13','IK14',0)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
    endfunction
    function QUEST_FINISH_MQ13 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 13
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK14','IK15',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_COMPLETE_MQ13 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 13
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK15')
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
        if mainQuest[15].state == QUEST_STATE_UNKNOWN and mainQuest[15].prereqsCompleted() then 
            set mainQuest[15].state = QUEST_STATE_NONE
            call QuestAddDialog(mainQuest[15].owner,'IK19',1)
            call NPC.addExclamation_Y(mainQuest[15].owner)
        endif 
    endfunction

    function QUEST_ACCEPT_MQ14 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 14
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK16','IK17',0)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
    endfunction
    function QUEST_FINISH_MQ14 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 14
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK17','IK18',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_COMPLETE_MQ14 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 14
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK18')
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
        if mainQuest[15].state == QUEST_STATE_UNKNOWN and mainQuest[15].prereqsCompleted() then 
            set mainQuest[15].state = QUEST_STATE_NONE
            call QuestAddDialog(mainQuest[15].owner,'IK19',1)
            call NPC.addExclamation_Y(mainQuest[15].owner)
        endif 
    endfunction

    
    function QUEST_ACCEPT_MQ15 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 15
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK19','IK1A',0)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].owner)
        call StoreInteger(gameCache,"KEY",KEY_DUNGEON_NECROPOLIS,1)
    endfunction
    function QUEST_FINISH_MQ15 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 15
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK1A','IK1B',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].owner)
        call NPC.addQuestion_Y(mainQuest[mQI].owner)
    endfunction
    function QUEST_COMPLETE_MQ15 takes nothing returns nothing
        call DestroyQuest(mainQuest[11].wc3quest)
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 15
        call QuestReplaceDialog(mainQuest[mQI].owner,'IK1B','IK1C',1)
        call NPC.reduceQuestion_Y(mainQuest[mQI].owner)
        call NPC.addExclamation_Y(mainQuest[mQI].owner)
        call QuestAddDialog(mainQuest[mQI].owner,'IR03',1)
        call NPC.addExclamation_B(mainQuest[mQI].owner)
    endfunction

    
    function QUEST_ACCEPT_MQ16 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 16
        call QuestRemoveDialog(mainQuest[mQI].owner,'IK1C')
        call QuestAddDialog(mainQuest[mQI].anotherOwner,'IK1D',1)
        call NPC.reduceExclamation_Y(mainQuest[mQI].owner)
        call NPC.addQuestion_W(mainQuest[mQI].anotherOwner)
    endfunction
    function QUEST_FINISH_MQ16 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 16
        call QuestReplaceDialog(mainQuest[mQI].anotherOwner,'IK1D','IK1E',1)
        call NPC.reduceQuestion_W(mainQuest[mQI].anotherOwner)
        call NPC.addQuestion_Y(mainQuest[mQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_MQ16 takes nothing returns nothing
        call DestroyQuest(mainQuest[15].wc3quest)
        if MAP_INDEX != 1 then 
            return 
        endif 
        set mQI = 16
        call QuestRemoveDialog(mainQuest[mQI].anotherOwner,'IK1E')
        call NPC.reduceQuestion_Y(mainQuest[mQI].anotherOwner)
        call StoreInteger(gameCache,"KEY",KEY_MAP_DESERT,1)

        call QuestAddDialog(sideQuest[10].owner,'IQ0T',1)
        call NPC.addExclamation_Y(sideQuest[10].owner)
        call QuestAddDialog(sideQuest[11].owner,'IQ0W',1)
        call NPC.addExclamation_Y(sideQuest[11].owner)
        call QuestAddDialog(sideQuest[12].owner,'IQ0Z',1)
        call NPC.addExclamation_Y(sideQuest[12].owner)
        call QuestAddDialog(sideQuest[13].owner,'IQ12',1)
        call NPC.addExclamation_Y(sideQuest[13].owner)
        call QuestAddDialog(sideQuest[27].owner,'IQ29',1)
        call NPC.addExclamation_Y(sideQuest[27].owner)
    endfunction

    //////
    function QUEST_ACCEPT_SQ0 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 0
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ00','IQ01',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ0 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 0
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ01','IQ02',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ0 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 0
        call RemoveItemFromStock(sideQuest[sQI].owner,'IQ02')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ1 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 1
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ03','IQ04',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ1 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 1
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ04','IQ05',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ1 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 1
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ05','IQ06',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ2 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 2
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ06','IQ07',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ2 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 2
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ07','IQ08',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ2 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 2
        call RemoveItemFromStock(sideQuest[sQI].owner,'IQ08')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call ReplaceUnitBJ(sideQuest[sQI].owner,'hN0H',bj_UNIT_STATE_METHOD_MAXIMUM)
    endfunction

    function QUEST_ACCEPT_SQ3 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 3
        call QuestSwapDialog(sideQuest[sQI].owner,'IQ09',sideQuest[sQI].anotherOwner,'IQ0A',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_FINISH_SQ3 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 3
        call QuestReplaceDialog(sideQuest[sQI].anotherOwner,'IQ0A','IQ0B',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].anotherOwner)
        call NPC.addQuestion_Y(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_SQ3 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 3
        call QuestRemoveDialog(sideQuest[sQI].anotherOwner,'IQ0B')
        call NPC.reduceQuestion_Y(sideQuest[sQI].anotherOwner)
    endfunction

    function QUEST_ACCEPT_SQ4 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 4
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ0C','IQ0D',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ4 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 4
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ0D','IQ0E',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ4 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 4
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ0E')
        call QuestAddDialog(sideQuest[sQI].owner,'IR00',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_B(sideQuest[sQI].owner)
    endfunction
    
    function QUEST_ACCEPT_SQ5 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 5
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ0F')
        call QuestAddDialog(sideQuest[sQI].anotherOwner,'IQ0G',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_FINISH_SQ5 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 5
        call QuestReplaceDialog(sideQuest[sQI].anotherOwner,'IQ0G','IQ0H',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].anotherOwner)
        call NPC.addQuestion_Y(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_SQ5 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 5
        call QuestRemoveDialog(sideQuest[sQI].anotherOwner,'IQ0H')
        call NPC.reduceQuestion_Y(sideQuest[sQI].anotherOwner)
        call UnitAddAbility(sideQuest[sQI].anotherOwner,'ANP6')
    endfunction
    
    function QUEST_ACCEPT_SQ6 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 6
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ0I','IQ0J',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ6 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 6
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ0J','IQ0K',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ6 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 6
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ0K','IQ0L',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction
    
    function QUEST_ACCEPT_SQ7 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 7
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ0L','IQ0M',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ7 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 7
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ0M','IQ0N',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ7 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 7
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ0N')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call QuestAddDialog(sideQuest[9].anotherOwner,'iq09',1)
    endfunction

    function QUEST_ACCEPT_SQ8 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 8
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ0O','IQ0P',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ8 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 8
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ0P','IQ0Q',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ8 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 8
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ0Q')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ9 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 9
        call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\Orc\\OrcSmallDeathExplode\\OrcSmallDeathExplode.mdl",GetUnitX(sideQuest[sQI].anotherOwner),GetUnitY(sideQuest[sQI].anotherOwner)))
        call RemoveUnit(sideQuest[sQI].anotherOwner)
        call QuestAddDialog(sideQuest[sQI].owner,'IQ0R',0)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ9 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 9
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ0R','IQ0S',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ9 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 9
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ0S')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ10 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 10
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ0T')
        call QuestAddDialog(sideQuest[sQI].anotherOwner,'IQ0U',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_FINISH_SQ10 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 10
        call QuestReplaceDialog(sideQuest[sQI].anotherOwner,'IQ0U','IQ0V',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].anotherOwner)
        call NPC.addQuestion_Y(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_SQ10 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 10
        call QuestReplaceDialog(sideQuest[sQI].anotherOwner,'IQ0V','IQ19',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].anotherOwner)
        call NPC.addExclamation_Y(sideQuest[sQI].anotherOwner)

        call QuestAddDialog(sideQuest[21].owner,'IQ1R',1)
        call NPC.addExclamation_Y(sideQuest[21].owner)

        call QuestAddDialog(sideQuest[25].owner,'IQ23',1)
        call NPC.addExclamation_Y(sideQuest[25].owner)
    endfunction

    function QUEST_ACCEPT_SQ11 takes nothing returns nothing
        set sQI = 11
        if MAP_INDEX == 1 then 
            call QuestRemoveDialog(sideQuest[sQI].owner,'IQ0W')
            call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        endif 
        if MAP_INDEX == 2 then 
            call QuestAddDialog(sideQuest[sQI].anotherOwner,'IQ0X',1)
            call NPC.addQuestion_W(sideQuest[sQI].anotherOwner)
        endif 
    endfunction
    function QUEST_FINISH_SQ11 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 11
        call QuestReplaceDialog(sideQuest[sQI].anotherOwner,'IQ0X','IQ0Y',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].anotherOwner)
        call NPC.addQuestion_Y(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_SQ11 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 11
        call QuestRemoveDialog(sideQuest[sQI].anotherOwner,'IQ0Y')
        call NPC.reduceQuestion_Y(sideQuest[sQI].anotherOwner)
    endfunction

    function QUEST_ACCEPT_SQ12 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 12
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ0Z','IQ10',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ12 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 12
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ10','IQ11',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ12 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 12
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ11')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ13 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 13
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ12')
        if sideQuest[9].state == QUEST_STATE_COMPLETED then 
            call QuestAddDialog(sideQuest[sQI].anotherOwner,'IQ13',1)
        else 
            call QuestAddDialog(sideQuest[sQI].anotherOwner,'IQ15',0)
        endif 
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_FINISH_SQ13 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 13
        call QuestReplaceDialog(sideQuest[sQI].anotherOwner,'IQ13','IQ14',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].anotherOwner)
        call NPC.addQuestion_Y(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_SQ13 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 13
        call QuestReplaceDialog(sideQuest[sQI].anotherOwner,'IQ14','IQ16',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].anotherOwner)
        call NPC.addExclamation_Y(sideQuest[sQI].anotherOwner)
    endfunction

    function QUEST_ACCEPT_SQ14 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 14
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ16','IQ17',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_FINISH_SQ14 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 14
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ17')
        call QuestAddDialog(sideQuest[sQI].anotherOwner,'IQ18',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].anotherOwner)
        call NPC.addQuestion_Y(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_SQ14 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 14
        call QuestRemoveDialog(sideQuest[sQI].anotherOwner,'IQ18')
        call NPC.reduceQuestion_Y(sideQuest[sQI].anotherOwner)
        call CreateUnit(GetOwningPlayer(sideQuest[sQI].owner),'hN1E',1818,-6979,255)
    endfunction

    function QUEST_ACCEPT_SQ15 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 15
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ19','IQ1A',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ15 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 15
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1A','IQ1B',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ15 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 15
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1B','IQ1C',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ16 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 16
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1C','IQ1D',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ16 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 16
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1D','IQ1E',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ16 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 16
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1E','IQ1F',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ17 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 17
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ1F')
        call QuestAddDialog(sideQuest[sQI].anotherOwner,'IQ1G',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_FINISH_SQ17 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 17
        call QuestReplaceDialog(sideQuest[sQI].anotherOwner,'IQ1G','IQ1H',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].anotherOwner)
        call NPC.addQuestion_Y(sideQuest[sQI].anotherOwner)
    endfunction
    function QUEST_COMPLETE_SQ17 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 17
        call QuestReplaceDialog(sideQuest[sQI].anotherOwner,'IQ1H','IQ1I',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].anotherOwner)
        call NPC.addExclamation_Y(sideQuest[sQI].anotherOwner)

        call QuestAddDialog(sideQuest[26].owner,'IQ26',1)
        call NPC.addExclamation_Y(sideQuest[26].owner)
    endfunction

    function QUEST_ACCEPT_SQ18 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 18
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1I','IQ1J',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ18 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 18
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1J','IQ1K',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ18 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 18
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1K','IQ1L',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ19 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 19
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1L','IQ1M',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ19 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 19
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1M','IQ1N',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ19 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 19
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1N','IQ1O',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ20 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 20
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1O','IQ1P',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
        call StoreInteger(gameCache,"KEY",KEY_DUNGEON_SANCTUM,1)
    endfunction
    function QUEST_FINISH_SQ20 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 20
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1P','IQ1Q',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ20 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 20
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ1Q')
        //call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1Q','IQ1R',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        //call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ21 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 21
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1R','IQ1S',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ21 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 21
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1S','IQ1T',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ21 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 21
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1T','IQ1U',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
        call QuestAddDialog(sideQuest[sQI].owner,'ir03',2)
    endfunction

    function QUEST_ACCEPT_SQ22 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 22
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1U','IQ1V',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ22 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 22
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1V','IQ1W',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ22 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 22
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1W','IQ1X',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
        call QuestAddDialog(sideQuest[sQI].owner,'ir02',2)
    endfunction

    function QUEST_ACCEPT_SQ23 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 23
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1X','IQ1Y',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ23 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 23
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1Y','IQ1Z',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ23 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 23
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ1Z','IQ20',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
        call QuestAddDialog(sideQuest[sQI].owner,'ir01',2)
    endfunction

    function QUEST_ACCEPT_SQ24 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 24
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ20','IQ21',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ24 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 24
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ21','IQ22',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ24 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 24
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ22')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call UnitAddAbility(sideQuest[sQI].owner,'ANP2')
    endfunction

    function QUEST_ACCEPT_SQ25 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 25
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ23','IQ24',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ25 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 25
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ24','IQ25',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ25 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 25
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ25','IR06',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_B(sideQuest[sQI].owner)

        call UnitAddAbilityEx(sideQuest[sQI].anotherOwner,'Apit')
        call UnitAddAbilityEx(sideQuest[sQI].anotherOwner,'Aneu')
        call UnitAddAbilityEx(sideQuest[sQI].anotherOwner,'ANP8')
    endfunction

    function QUEST_ACCEPT_SQ26 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 26
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ26','IQ27',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ26 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 26
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ27','IQ28',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ26 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 26
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ28')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ27 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 27
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ29','IQ2A',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ27 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 27
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2A','IQ2B',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ27 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set sQI = 27
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ2B')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ28 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 28
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2C','IQ2D',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ28 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 28
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2D','IQ2E',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ28 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 28
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2E','IQ2F',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ29 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 29
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2F','IQ2G',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ29 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 29
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2G','IQ2H',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ29 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 29
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2H','IQ2I',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ30 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 30
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2I','IQ2J',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ30 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 30
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2J','IQ2K',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ30 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 30
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2K','IQ2L',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ31 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 31
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2L','IQ2M',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
        call StoreInteger(gameCache,"KEY",KEY_DUNGEON_NETHERFLAMECAVERN,1)
    endfunction
    function QUEST_FINISH_SQ31 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 31
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2M','IQ2N',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ31 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 31
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ2N')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ32 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 32
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2O','IQ2P',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ32 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 32
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2P','IQ2Q',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ32 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 32
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2Q','IQ2R',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ33 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 33
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2R','IQ2S',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ33 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 33
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2S','IQ2T',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ33 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 33
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ2T')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ34 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 34
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2U','IQ2V',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ34 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 34
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2V','IQ2W',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ34 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 34
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2W','IQ2X',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ35 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 35
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2X','IQ2Y',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ35 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 35
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ2Y','IQ2Z',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ35 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 35
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ2Z')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ36 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 36
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ30','IQ31',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ36 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 36
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ31','IQ32',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ36 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 36
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ32','IQ33',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ37 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 37
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ33','IQ34',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ37 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 37
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ34','IQ35',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ37 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 37
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ35','IQ36',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ38 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 38
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ36','IQ37',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ38 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 38
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ37','IQ38',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ38 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 38
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ38')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ39 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 39
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ39','IQ3A',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ39 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 39
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ3A','IQ3B',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ39 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 39
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ3B')
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ40 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 40
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ3C','IQ3D',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ40 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 40
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ3D','IQ3E',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ40 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 40
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ3E','IQ3F',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ41 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 41
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ3F','IQ3G',0)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
        call QuestAddDialog(sideQuest[sQI].owner,'iq0L',1)
    endfunction
    function QUEST_FINISH_SQ41 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 41
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ3G','IQ3H',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ41 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 41
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ3H','IQ3I',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ42 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 42
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ3I','IQ3J',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ42 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 42
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ3J','IQ3K',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ42 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 42
        call QuestReplaceDialog(sideQuest[sQI].owner,'IQ3K','IQ3L',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
        call NPC.addExclamation_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_SQ43 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 43
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ3L')
        call QuestAddDialog(sideQuest[sQI].anotherOwner,'IQ3M',1)
        call NPC.reduceExclamation_Y(sideQuest[sQI].owner)
        call NPC.addQuestion_W(sideQuest[sQI].owner)
    endfunction
    function QUEST_FINISH_SQ43 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 43
        call QuestAddDialog(sideQuest[sQI].owner,'IQ3N',1)
        call NPC.reduceQuestion_W(sideQuest[sQI].owner)
        call NPC.addQuestion_Y(sideQuest[sQI].owner)
    endfunction
    function QUEST_COMPLETE_SQ43 takes nothing returns nothing
        if MAP_INDEX != 2 then 
            return 
        endif 
        set sQI = 43
        call QuestRemoveDialog(sideQuest[sQI].owner,'IQ3N')
        call QuestAddDialog(sideQuest[sQI].anotherOwner,'iq0O',1)
        call NPC.reduceQuestion_Y(sideQuest[sQI].owner)
    endfunction

    function QUEST_ACCEPT_RQ0 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set rQI = 0
        call QuestReplaceDialog(repeatableQuest[rQI].owner,'IR00','IR01',1)
        call NPC.reduceExclamation_B(repeatableQuest[rQI].owner)
        call NPC.addQuestion_W(repeatableQuest[rQI].owner)
    endfunction
    function QUEST_FINISH_RQ0 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set rQI = 0
        call QuestReplaceDialog(repeatableQuest[rQI].owner,'IR01','IR02',1)
        call NPC.reduceQuestion_W(repeatableQuest[rQI].owner)
        call NPC.addQuestion_B(repeatableQuest[rQI].owner)
    endfunction
    function QUEST_COMPLETE_RQ0 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set rQI = 0
        call QuestReplaceDialog(repeatableQuest[rQI].owner,'IR02','IR00',1)
        call NPC.reduceQuestion_B(repeatableQuest[rQI].owner)
        call NPC.addExclamation_B(repeatableQuest[rQI].owner)
    endfunction

    function QUEST_ACCEPT_RQ1 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set rQI = 1
        call QuestReplaceDialog(repeatableQuest[rQI].owner,'IR03','IR04',1)
        call NPC.reduceExclamation_B(repeatableQuest[rQI].owner)
        call NPC.addQuestion_W(repeatableQuest[rQI].owner)
    endfunction
    function QUEST_FINISH_RQ1 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set rQI = 1
        call QuestReplaceDialog(repeatableQuest[rQI].owner,'IR04','IR05',1)
        call NPC.reduceQuestion_W(repeatableQuest[rQI].owner)
        call NPC.addQuestion_B(repeatableQuest[rQI].owner)
    endfunction
    function QUEST_COMPLETE_RQ1 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set rQI = 1
        call QuestReplaceDialog(repeatableQuest[rQI].owner,'IR05','IR03',1)
        call NPC.reduceQuestion_B(repeatableQuest[rQI].owner)
        call NPC.addExclamation_B(repeatableQuest[rQI].owner)
    endfunction

    function QUEST_ACCEPT_RQ2 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set rQI = 2
        call QuestReplaceDialog(repeatableQuest[rQI].owner,'IR06','IR07',0)
        call NPC.reduceExclamation_B(repeatableQuest[rQI].owner)
        call NPC.addQuestion_W(repeatableQuest[rQI].owner)
    endfunction
    function QUEST_FINISH_RQ2 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set rQI = 2
        call QuestReplaceDialog(repeatableQuest[rQI].owner,'IR07','IR08',1)
        call NPC.reduceQuestion_W(repeatableQuest[rQI].owner)
        call NPC.addQuestion_B(repeatableQuest[rQI].owner)
    endfunction
    function QUEST_COMPLETE_RQ2 takes nothing returns nothing
        if MAP_INDEX != 1 then 
            return 
        endif 
        set rQI = 2
        call QuestReplaceDialog(repeatableQuest[rQI].owner,'IR08','IR06',1)
        call NPC.reduceQuestion_B(repeatableQuest[rQI].owner)
        call NPC.addExclamation_B(repeatableQuest[rQI].owner)
    endfunction
    //////
    // endregion 
    //////
    
    //////
    // region initQuest
    //////
    function initMainQuest takes nothing returns nothing
        local Objective obj 
        local string title
        local string desc 
        local string icon 
        local integer req

        //
        set mQI = 0 
        set title = "初至永望港"  
        set desc = "长途跋涉之后，你们终于从暴风城抵达了永望港。向里尔总督报到，获取接下来的指令。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M000',title,desc,icon,QUEST_PERSISTENT)
        set desc = "向里尔总督报到"  
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(0,0,50,0,0,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ0)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ0)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ0)
        //
        set mQI = 1
        set title = "营地补给"  
        set desc = "里尔总督命你们前往军需官处领取配给。找到军需官克莱，他负责新到人员的物资分配。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"    
        set mainQuest[mQI] = Quest.create('M001',title,desc,icon,QUEST_PERSISTENT)
        set desc = "找到军需官克莱"  
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(500,0,50,'I60H',5,'IPL0',5,'IPM0',5)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ1)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ1)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ1)
        //
        set mQI = 2
        set title = "失踪的信使"  
        set desc = "大要塞的信使在前往永望港的途中失踪了。前往东南方向的道路周边，寻找信使留下的痕迹。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M002',title,desc,icon,QUEST_PERSISTENT)
        set desc = "找到并调查信使的痕迹"  
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(50,0,50,0,0,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ2)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ2)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ2)
        //
        set mQI = 3
        set title = "营救信使"  
        set desc = "信使被狗头人俘虏了。救出他，并安全护送回永望港。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M003',title,desc,icon,QUEST_PERSISTENT)
        set desc = "营救信使"  
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        set desc = "护送信使"  
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(100,0,50,'I60H',5,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ3)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ3)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ3)
        call mainQuest[mQI].bindOnFail(function QUEST_FAIL_MQ3)
        //
        set mQI = 4
        set title = "血债血偿"  
        set desc = "灰洞狗头人袭击了联盟的巡逻队。让他们付出代价——彻底清除这些威胁。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M004',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭灰洞狗头人"  
        set req = 15
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(100,0,50,'IPL0',5,'IPM0',5,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ4)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ4)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ4)
        //
        set mQI = 5
        set title = "愿英灵安息"  
        set desc = "战死的卫队尸骸散落在荒野中。焚烧尸骸，取回烈士们的骨灰，让他们得以安息。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M005',title,desc,icon,QUEST_PERSISTENT)
        set desc = "焚烧尸骸"  
        set req = 1
        set desc = "取得焚烧后的骨灰"  
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(100,0,50,'I627',0,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ5)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ5)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ5)
        //
        set mQI = 6
        set title = "前往赫德要塞"  
        set desc = "永望港的事务已告一段落。信使带来了消息：赫德要塞发生了剧变，你们必须尽快前往。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M006',title,desc,icon,QUEST_PERSISTENT)
        set mainQuest[mQI].keepAfterComplete = true 
        call mainQuest[mQI].addPrereq('M003')
        call mainQuest[mQI].addPrereq('M004')
        call mainQuest[mQI].addPrereq('M005')
        set mainQuest[mQI].state = QUEST_STATE_UNKNOWN
        set desc = "前往赫德要塞"  
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(0,0,0,0,0,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ6)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ6)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ6)
        //
        set mQI = 7
        set title = "港口的外患"  
        set desc = "穆丁司令命令你们前往港口区，调查并清除那里的天灾威胁。先找到塞尔勋爵汇合。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M007',title,desc,icon,QUEST_PERSISTENT)
        set desc = "找到塞尔勋爵"  
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(100,0,50,'IPL1',3,'IPM1',3,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ7)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ7)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ7)
        //
        set mQI = 8
        set title = "净化港口"  
        set desc = "港口区已被瘟疫侵蚀。消灭通灵师，清除复生的僵尸，净化这片区域。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M008',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭复生僵尸"  
        set req = 8
        call mainQuest[mQI].addObjective(desc,req)
        set desc = "消灭通灵师"  
        set req = 3
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(200,0,125,'I609',0,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ8)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ8)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ8)
        //
        set mQI = 9
        set title = "熄灭鬼火"  
        set desc = "港口残留着不灭的鬼火，用圣水逐一将其熄灭，切断瘟疫的能量源头。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M009',title,desc,icon,QUEST_PERSISTENT)
        set desc = "熄灭鬼火"  
        set req = 4
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(150,0,125,'I61M',0,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ9)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ9)
        call mainQuest[mQI].bindOnFail(function QUEST_FAIL_MQ9)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ9)
        //
        set mQI = 10
        set title = "根除"  
        set desc = "屏障已被打破，通灵师玛吉拉就在前方。消灭她，终结港口的天灾威胁。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M010',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭石像鬼"  
        set req = 7
        call mainQuest[mQI].addObjective(desc,req)
        set desc = "消灭通灵师玛吉拉"  
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].addPrereq('M008')
        call mainQuest[mQI].addPrereq('M009')
        set mainQuest[mQI].state = QUEST_STATE_UNKNOWN
        call mainQuest[mQI].setReward(250,0,200,'I61D',0,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ10)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ10)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ10)
        //
        set mQI = 11
        set title = "监狱暴乱"  
        set desc = "赫德要塞的监狱发生了暴乱。进入监狱(地下城)，查明真相，协助赫德元帅平定局面。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M011',title,desc,icon,QUEST_PERSISTENT)
        set mainQuest[mQI].keepAfterComplete = true 
        set desc = "找出监狱暴乱的真相"  
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(500,1,300,'IPL2',5,'IPM2',5,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ11)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ11)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ11)
        //
        set mQI = 12
        set title = "城外的会面"
        set desc = "前往城外的腐化之地，与塞尔勋爵会合，准备发动对天灾的下一步攻势。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M012',title,desc,icon,QUEST_PERSISTENT)
        set desc = "找到塞尔勋爵"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(50,0,50,0,0,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ12)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ12)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ12)
        //
        set mQI = 13
        set title = "剿灭天灾"
        set desc = "大墓地外围盘踞着大量天灾部队。清理它们，并消灭三名关键头目：齿痕、悲惨的提米、脊石—恐怖之翼。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M013',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭天灾部队"
        set req = 30
        call mainQuest[mQI].addObjective(desc,req)
        set desc = "消灭齿痕"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        set desc = "消灭悲惨的提米"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        set desc = "消灭脊石-恐怖之翼"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(200,1,150,'IPL1',5,'IPM1',5,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ13)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ13)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ13)
        //
        set mQI = 14
        set title = "关闭屏障"
        set desc = "大墓地被一道能量屏障保护着。摧毁两座通灵塔——鲜血通灵塔与冰霜通灵塔——解除屏障。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M014',title,desc,icon,QUEST_PERSISTENT)
        set desc = "关闭鲜血通灵塔"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        set desc = "关闭冰霜通灵塔"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(200,1,150,'I624',0,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ14)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ14)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ14)
        //
        set mQI = 15
        set title = "清算：阿纳克提斯"
        set desc = "攻入大墓地阿纳克提斯。消灭维康尼亚夫人、阿努比罗斯、屠夫与阿纳克领主，并带回浮空城日志。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M015',title,desc,icon,QUEST_PERSISTENT)
        set mainQuest[mQI].keepAfterComplete = true 
        call mainQuest[mQI].addPrereq('M013')
        call mainQuest[mQI].addPrereq('M014')
        set mainQuest[mQI].state = QUEST_STATE_UNKNOWN
        set desc = "消灭维康尼亚夫人"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        set desc = "消灭阿努比罗斯"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        set desc = "消灭屠夫"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        set desc = "消灭阿纳克领主"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        set desc = "取得浮空城日志"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(500,2,300,0,0,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ15)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ15)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ15)
        //
        set mQI = 16
        set title = "尾声"
        set desc = "返回赫德要塞，向赫德元帅复命，汇报此次行动的成果。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp"  
        set mainQuest[mQI] = Quest.create('M016',title,desc,icon,QUEST_PERSISTENT)
        set mainQuest[mQI].keepAfterComplete = true 
        set desc = "与赫德元帅对话"
        set req = 1
        call mainQuest[mQI].addObjective(desc,req)
        call mainQuest[mQI].setReward(150,2,200,'I697',0,0,0,0,0)
        call mainQuest[mQI].bindOnAccept(function QUEST_ACCEPT_MQ16)
        call mainQuest[mQI].bindOnFinish(function QUEST_FINISH_MQ16)
        call mainQuest[mQI].bindOnComplete(function QUEST_COMPLETE_MQ16)
        //
    endfunction
    function initSideQuest takes nothing returns nothing
        local Objective obj 
        local string title
        local string desc 
        local string icon 
        local integer req

        //
        set sQI = 0 
        set title = "清除野狼"  
        set desc = "永望港东南方的野狼泛滥成灾，严重威胁过往行商与巡逻兵的安全。消灭10只野狼，恢复道路安全。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S000',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭永望港南的野狼"  
        set req = 10
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(50,0,50,'I60F',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ0)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ0)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ0)
        //
        set sQI = 1 
        set title = "收集珍珠"  
        set desc = "珠宝商朱娜的一箱珍贵珍珠被南岸的鱼人抢走了。从鱼人手中夺回6颗珍珠。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S001',title,desc,icon,QUEST_PERSISTENT)
        set desc = "取得'珍珠'"  
        set req = 6
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(50,0,50,'I61B',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ1)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ1)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ1)
        //
        set sQI = 2
        set title = "普拉多"  
        set desc = "鱼人部落中出现了一名强大的首领——普拉多。传说他拥有稀世珍宝“幻彩珍珠”。击败他，夺回珍珠。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S002',title,desc,icon,QUEST_PERSISTENT)
        set desc = "取得'巨大华丽幻彩珍珠'"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(75,0,75,'I60K',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ2)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ2)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ2)
        //
        set sQI = 3
        set title = "悬赏：恐怖之狼"  
        set desc = "永望港周边出现了一头恐怖的巨狼，猎杀它，领取赏金。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S003',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭恐怖之狼"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(100,0,75,'I60L',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ3)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ3)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ3)
        //
        set sQI = 4
        set title = "叛军的军械"  
        set desc = "大要塞急需扩充军备。监狱叛军散落了不少军械，收缴6份散落的军械，充作军用。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S004',title,desc,icon,QUEST_PERSISTENT)
        set desc = "提交6份'散落的军械'"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(200,1,100,'IPL1',2,'IPM1',2,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ4)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ4)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ4)
        //
        set sQI = 5
        set title = "附魔领域大师"  
        set desc = "伊斯特·逐光向你们介绍了附魔之道。前往法师区，找到奥法师西蒙，了解更多关于附魔的知识。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S005',title,desc,icon,QUEST_PERSISTENT)
        set desc = "找到奥法师西蒙"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(100,0,50,'IE02',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ5)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ5)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ5)
        //
        set sQI = 6
        set title = "我的大药房(I)"  
        set desc = "伊泽尔·黑酿需要药剂材料。收集5份蜘蛛毒腺和5颗蝙蝠心，交给他。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S006',title,desc,icon,QUEST_PERSISTENT)
        set desc = "获得'蜘蛛毒腺'"  
        set req = 5
        call sideQuest[sQI].addObjective(desc,req)
        set desc = "获得'蝙蝠心'"  
        set req = 5
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(100,0,75,'I607',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ6)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ6)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ6)
        //
        set sQI = 7
        set title = "我的大药房(II)"  
        set desc = "伊泽尔·黑酿需要更稀罕的材料——巨魔的血液。收集10份巨魔血液样本，并取回沃卢的血液样本。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S007',title,desc,icon,QUEST_PERSISTENT)
        set desc = "获得'巨魔血液样本'"  
        set req = 10
        call sideQuest[sQI].addObjective(desc,req)
        set desc = "获得'沃卢的血液样本'"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(100,0,75,'I61E',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ7)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ7)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ7)
        //
        set sQI = 8
        set title = "蜘蛛恐惧症"  
        set desc = "绿皮营地的食人魔护士请求你们处理附近的蜘蛛。消灭10只蜘蛛和1只育母蜘蛛。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S008',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭蜘蛛"  
        set req = 10
        call sideQuest[sQI].addObjective(desc,req)
        set desc = "消灭育母蜘蛛"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(100,0,100,'I61A',0,'IF00',3,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ8)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ8)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ8)
        //
        set sQI = 9
        set title = "来自地狱"  
        set desc = "法阵闪烁，恶魔被召唤而出——那瓶药剂竟是祭品。消灭地狱使者，终结这场召唤。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S009',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭地狱使者"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(200,2,200,'I62G',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ9)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ9)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ9)
        //
        set sQI = 10
        set title = "建交：风牛部落"  
        set desc = "赫德元帅希望与北方的牛头人建立同盟。前往风牛部落，与穆尔·风牛交谈，传达联盟的诚意。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00A',title,desc,icon,QUEST_PERSISTENT)
        set desc = "与穆尔·风牛交谈"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(150,0,400,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ10)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ10)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ10)
        //
        set sQI = 11
        set title = "沙漠彼方的声音"  
        set desc = "塞拉·月影在风声中听到了精灵的低语。前往沙漠深处，调查那里的精灵踪迹。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00B',title,desc,icon,QUEST_PERSISTENT)
        set desc = "探索沙漠"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(300,2,400,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ11)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ11)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ11)
        //
        set sQI = 12
        set title = "大餐"  
        set desc = "厨师卡鲁正在筹备一顿丰盛的大餐。提交4份生肉，帮助他完成这道佳肴。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00C',title,desc,icon,QUEST_PERSISTENT)
        set desc = "提交4份'生肉'"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(100,0,400,'IDZZ',8,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ12)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ12)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ12)
        //
        set sQI = 13
        set title = "合金弹头(I)"  
        set desc = "穆丁司令命你们前往地精营地，收取之前预定的武器。质问伊泽尔·黑酿，取回货物。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00D',title,desc,icon,QUEST_PERSISTENT)
        set desc = "质问伊泽尔·黑酿"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(50,0,150,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ13)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ13)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ13)
        //
        set sQI = 14
        set title = "合金弹头(II)"  
        set desc = "地精拿出了一块地狱铁——但他们不打算免费给。支付1000金币，买下这块地狱铁。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00E',title,desc,icon,QUEST_PERSISTENT)
        set desc = "掏钱！"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(0,0,500,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ14)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ14)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ14)
        //
        set sQI = 15
        set title = "半人马的威胁(I)"  
        set desc = "半人马不断袭扰风牛部落。猎杀废土苦工、先驱、猎手、巫师各5名，削减他们的兵力。"  
        set icon = "replaceabletextures\\commandbuttons\\fromDOTA\\btnaftershock.blp" 
        set sideQuest[sQI] = Quest.create('S00F',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭废土苦工"  
        set req = 5
        call sideQuest[sQI].addObjective(desc,req)
        set desc = "消灭废土先驱"  
        set req = 5
        call sideQuest[sQI].addObjective(desc,req)
        set desc = "消灭废土猎手"  
        set req = 5
        call sideQuest[sQI].addObjective(desc,req)
        set desc = "消灭废土巫师"  
        set req = 5
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(150,0,400,'I62Z',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ15)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ15)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ15)
        //
        set sQI = 16
        set title = "半人马的威胁(II)"  
        set desc = "半人马的可汗革隆仍坐镇军中。深入沙漠洞穴，执行斩首行动。"  
        set icon = "replaceabletextures\\commandbuttons\\fromDOTA\\btnaftershock.blp"  
        set sideQuest[sQI] = Quest.create('S00G',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭革隆-废土可汗"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(150,1,600,'I630',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ16)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ16)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ16)
        //
        set sQI = 17
        set title = "肃清道路"  
        set desc = "雪山上的亡魂阻断了通往祖地的道路。消灭15个怨灵，让道路恢复畅通。"  
        set icon = "replaceabletextures\\commandbuttons\\fromDOTA\\btnaftershock.blp" 
        set sideQuest[sQI] = Quest.create('S00H',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭怨灵"  
        set req = 15
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(150,0,400,'Ic01',1,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ17)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ17)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ17)
        //
        set sQI = 18
        set title = "蒙尘的圣所"  
        set desc = "开启牛头人圣所所需的符节遗失了。据线索，它落入了东边的野人部落手中。夺回符节。"  
        set icon = "replaceabletextures\\commandbuttons\\fromDOTA\\btnaftershock.blp" 
        set sideQuest[sQI] = Quest.create('S00I',title,desc,icon,QUEST_PERSISTENT)
        set desc = "取回'圣所符节'"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(200,1,600,'I62W',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ18)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ18)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ18)
        //
        set sQI = 19
        set title = "悬崖之下"  
        set desc = "圣所隐藏在悬崖下方的瀑布之后。制造一架绳梯，打通往返悬崖的道路。"  
        set icon = "replaceabletextures\\commandbuttons\\fromDOTA\\btnaftershock.blp" 
        set sideQuest[sQI] = Quest.create('S00J',title,desc,icon,QUEST_PERSISTENT)
        set desc = "制造'绳梯'"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(150,0,400,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ19)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ19)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ19)
        //
        set sQI = 20
        set title = "埋藏的邪恶"  
        set desc = "是时候进入远古圣所(地下城)了。调查隐藏在圣所深处的异变，查清亡魂的源头。"  
        set icon = "replaceabletextures\\commandbuttons\\fromDOTA\\btnaftershock.blp" 
        set sideQuest[sQI] = Quest.create('S00K',title,desc,icon,QUEST_PERSISTENT)
        set desc = "调查圣所埋藏的邪恶"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(300,4,800,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ20)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ20)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ20)
        //
        set sQI = 21
        set title = "草药学入门(I)"  
        set desc = "卡林·风之图腾教导你们草药学的第一步。采集3株荆棘藻，作为入门的第一课。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00L',title,desc,icon,QUEST_PERSISTENT)
        set desc = "提交3株'荆棘藻'"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(100,0,350,'IF01',3,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ21)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ21)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ21)
        //
        set sQI = 22
        set title = "草药学入门(II)"  
        set desc = "卡林·风之图腾的第二课。采集3株野钢花，它们生长在荒野中。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00M',title,desc,icon,QUEST_PERSISTENT)
        set desc = "提交3株'野钢花'"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(100,0,350,'IF02',3,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ22)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ22)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ22)
        //
        set sQI = 23
        set title = "草药学入门(III)"  
        set desc = "卡林·风之图腾的第三课。采集3株墓地苔，它们只生长在有死亡的地方。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00N',title,desc,icon,QUEST_PERSISTENT)
        set desc = "提交3株'墓地苔'"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(100,0,350,'IF00',3,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ23)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ23)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ23)
        //
        set sQI = 24
        set title = "草药学入门(IV)"  
        set desc = "卡林·风之图腾的最后一课。采集1株黑莲花——最稀有、最难寻的草药。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00O',title,desc,icon,QUEST_PERSISTENT)
        set desc = "提交1株'黑莲花'"  
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(200,2,800,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ24)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ24)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ24)
        //
        set sQI = 25
        set title = "肉食储备"  
        set desc = "猎人塔鲁需要活的野猪来建立肉食储备。前往南边丛林，用捕网捕获10头野猪，活着带回来。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00P',title,desc,icon,QUEST_PERSISTENT)
        set desc = "捕获野猪"  
        set req = 10
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(100,0,400,'ID00',4,'IML0',4,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ25)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ25)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ25)
        //
        set sQI = 26
        set title = "野人的威胁"  
        set desc = "加卡·风之图腾委托你击杀雪山野人，带回他们的角作为凭证。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00Q',title,desc,icon,QUEST_PERSISTENT)
        set desc = "取得'野人的角'"  
        set req = 10
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(150,0,400,'I62V',0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ26)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ26)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ26)
        //
        set sQI = 27
        set title = "毒林的鬼影"  
        set desc = "工程师布鲁诺委托你使用特制脉冲枪研究要塞外的亡灵。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00R',title,desc,icon,QUEST_PERSISTENT)
        set desc = "取得成果"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(200,0,600,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ27)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ27)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ27)
        //
        set sQI = 28
        set title = "安抚元素"  
        set desc = "泰高尔·风之图腾请我们除去一些躁狂的元素，抚平大地的悲鸣。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00S',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭熔火元素"
        set req = 5
        call sideQuest[sQI].addObjective(desc,req)
        set desc = "消灭融钢傀儡"
        set req = 5
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(150,0,400,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ28)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ28)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ28)
        //
        set sQI = 29
        set title = "拜荒者的密谋"  
        set desc = "泰高尔·风之图腾请我们消灭一些半人马拜荒者，并取得它们的密文。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00T',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭半人马拜荒者"
        set req = 10
        call sideQuest[sQI].addObjective(desc,req)
        set desc = "取得'拜荒者密文'"
        set req = 5
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(150,0,400,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ29)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ29)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ29)
        //
        set sQI = 30
        set title = "斩首巫师"  
        set desc = "泰高尔·风之图腾请我们消灭拜荒者的大祭司索拉斯。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00U',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭索拉斯"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(200,2,600,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ30)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ30)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ30)
        //
        set sQI = 31
        set title = "熔火核心"  
        set desc = "泰高尔·风之图腾请我们深入冥火石窟(地下城)，消灭其中的火焰大军。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00V',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭弗莱拉斯"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        set desc = "消灭不灭"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        set desc = "消灭辛格尔-火焰之王"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(400,4,800,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ31)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ31)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ31)
        //
        set sQI = 32
        set title = "火石的妙用"  
        set desc = "厨师卡布请我们从熔火元素手中取得一些熔火石。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00W',title,desc,icon,QUEST_PERSISTENT)
        set desc = "取得'熔火石'"
        set req = 3
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(100,0,600,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ32)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ32)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ32)
        //
        set sQI = 33
        set title = "火石的妙用"  
        set desc = "厨师卡布请我们帮忙找寻不会熄灭的火石，或许在大火山里会有。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00X',title,desc,icon,QUEST_PERSISTENT)
        set desc = "取得'不灭的火焰'"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(300,2,1200,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ33)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ33)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ33)
        //
        set sQI = 34
        set title = "沙海毒钳(I)"  
        set desc = "卫兵队长穆齐委托我们帮忙消灭一些沙漠蝎，以便垦荒团向沙海深处进发。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00Y',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭沙漠蝎"
        set req = 30
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(150,0,600,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ34)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ34)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ34)
        //
        set sQI = 35
        set title = "沙海毒钳(II)"  
        set desc = "卫兵队长穆齐委托我们消灭沙漠蝎王，带回它的尾针作为凭证。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S00Z',title,desc,icon,QUEST_PERSISTENT)
        set desc = "取得'沙漠蝎王的尾针'"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(250,1,800,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ35)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ35)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ35)
        //
        set sQI = 36
        set title = "赏金猎人(I)"  
        set desc = "猎魔人苏拉要求你狩猎荒野最强大的敌人，首先是鹰身人的女王血翎。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S010',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭血翎"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(200,1,900,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ36)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ36)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ36)
        //
        set sQI = 37
        set title = "赏金猎人(II)"  
        set desc = "猎魔人苏拉要求你狩猎荒野最强大的敌人，现在轮到野猪人的头目烂齿了。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S011',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭烂齿"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(250,1,1000,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ37)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ37)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ37)
        //
        set sQI = 38
        set title = "赏金猎人(III)"  
        set desc = "猎魔人苏拉要求你狩猎荒野最强大的敌人，最后轮到暴掠余孽的剑圣尤舒拉了。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S012',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭尤舒拉"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(300,1,1200,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ38)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ38)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ38)
        //
        set sQI = 39
        set title = "猎风行动"  
        set desc = "地精哥布请求我们消灭一些“讨厌的”风元素。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S013',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭无羁之风"
        set req = 8
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(200,0,600,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ39)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ39)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ39)
        //
        set sQI = 40
        set title = "为迷信付出代价"  
        set desc = "加兹·瑞奇要求我们铲除一些“迷信”的野猪人：它们阻碍了他继续抽取燃油！"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S014',title,desc,icon,QUEST_PERSISTENT)
        set desc = "消灭野猪人"
        set req = 30
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(250,0,600,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ40)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ40)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ40)
        //
        set sQI = 41
        set title = "黑色燃油"  
        set desc = "加兹·瑞奇要求我们拿上特制的提取器，从软泥怪手里夺取燃油。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S015',title,desc,icon,QUEST_PERSISTENT)
        set desc = "取得'黑色燃油'"
        set req = 5
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(200,0,800,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ41)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ41)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ41)
        //
        set sQI = 42
        set title = "地狱铁游艇"  
        set desc = "加兹·瑞奇要求我们缴纳一些地狱铁，帮他完成游艇。再坚持坚持就可以坐豪华游艇了！！"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S016',title,desc,icon,QUEST_PERSISTENT)
        set desc = "缴纳5份'地狱铁'"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(250,0,800,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ42)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ42)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ42)
        //
        set sQI = 43
        set title = "入场费"  
        set desc = "加兹·瑞奇居然临时变卦！！我们想参加游艇派对居然还有一道关卡。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set sideQuest[sQI] = Quest.create('S017',title,desc,icon,QUEST_PERSISTENT)
        set desc = "购买'游艇船票'"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        set desc = "完成游艇之旅"
        set req = 1
        call sideQuest[sQI].addObjective(desc,req)
        call sideQuest[sQI].setReward(0,0,0,0,0,0,0,0,0)
        call sideQuest[sQI].bindOnAccept(function QUEST_ACCEPT_SQ43)
        call sideQuest[sQI].bindOnFinish(function QUEST_FINISH_SQ43)
        call sideQuest[sQI].bindOnComplete(function QUEST_COMPLETE_SQ43)
        //
    endfunction
    function initRepeatableQuest takes nothing returns nothing
        local Objective obj 
        local string title
        local string desc 
        local string icon 
        local integer req

        //
        set rQI = 0 
        set title = "更多军械"  
        set desc = "大要塞扩充兵员急需军械，收缴监狱叛军的军械可能是个不错的选择。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set repeatableQuest[rQI] = Quest.create('R000',title,desc,icon,QUEST_REPEATABLE)
        set desc = "提交6份'散落的军械'"  
        set req = 1
        call repeatableQuest[rQI].addObjective(desc,req)
        call repeatableQuest[rQI].setReward(100,1,0,'IPL1',2,'IPM1',2,0,0)
        call repeatableQuest[rQI].bindOnAccept(function QUEST_ACCEPT_RQ0)
        call repeatableQuest[rQI].bindOnFinish(function QUEST_FINISH_RQ0)
        call repeatableQuest[rQI].bindOnComplete(function QUEST_COMPLETE_RQ0)
        //
        set rQI = 1 
        set title = "死灵精华"  
        set desc = "塞尔勋爵请你协助收集大墓地中强大亡灵生物的精华。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set repeatableQuest[rQI] = Quest.create('R001',title,desc,icon,QUEST_REPEATABLE)
        set desc = "提交4份'死灵精华'"  
        set req = 1
        call repeatableQuest[rQI].addObjective(desc,req)
        call repeatableQuest[rQI].setReward(150,1,0,'IPL1',3,'IPM1',3,0,0)
        call repeatableQuest[rQI].bindOnAccept(function QUEST_ACCEPT_RQ1)
        call repeatableQuest[rQI].bindOnFinish(function QUEST_FINISH_RQ1)
        call repeatableQuest[rQI].bindOnComplete(function QUEST_COMPLETE_RQ1)
        //
        set rQI = 2
        set title = "野猪捕手"  
        set desc = "塔鲁请你们再捕获一些野猪。"  
        set icon = "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"  
        set repeatableQuest[rQI] = Quest.create('R002',title,desc,icon,QUEST_REPEATABLE)
        set desc = "捕捉野猪"  
        set req = 10
        call repeatableQuest[rQI].addObjective(desc,req)
        call repeatableQuest[rQI].setReward(100,0,200,'ID00',4,'IML0',4,0,0)
        call repeatableQuest[rQI].bindOnAccept(function QUEST_ACCEPT_RQ2)
        call repeatableQuest[rQI].bindOnFinish(function QUEST_FINISH_RQ2)
        call repeatableQuest[rQI].bindOnComplete(function QUEST_COMPLETE_RQ2)

    endfunction
    //////
    // endregion
    //////

    private function init takes nothing returns nothing
        call initMainQuest.execute()
        call initSideQuest.execute()
        call initRepeatableQuest.execute()
    endfunction

endlibrary

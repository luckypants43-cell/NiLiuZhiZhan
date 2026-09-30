
library MapTrig initializer init requires talentlib 
    globals
        group allInns = CreateGroup()
        trigger array QuestTrig [50]
        trigger HintLevelUp = CreateTrigger()
        trigger HintPickItem = CreateTrigger()
        trigger HintSave = CreateTrigger()
        trigger HintRevive = CreateTrigger()
        trigger HintSwap = CreateTrigger()
        trigger OpenCityGate = CreateTrigger()
        trigger bindHearthStone = CreateTrigger()
        trigger swapHero_EnterInn = CreateTrigger()
        trigger swapHero_OutInn   = CreateTrigger()
        trigger unlockReviveStone1 = CreateTrigger()
        trigger unlockReviveStone2 = CreateTrigger()
        trigger unlockReviveStone3 = CreateTrigger()
        trigger unlockReviveStone4 = CreateTrigger()
        trigger unlockReviveStone5 = CreateTrigger()
        trigger unlockReviveStone6 = CreateTrigger()
        trigger unlockArmoury = CreateTrigger()
        trigger unlockJail = CreateTrigger()
        trigger RemoveBarricade = CreateTrigger()
        trigger ToPlateau = CreateTrigger()

        Enemy Necromancer1
        Enemy Necromancer2
        Enemy Necromancer3
        Enemy Gargoyle1
        Enemy Gargoyle2
        Enemy Gargoyle3
        Enemy Gargoyle4
        Enemy Gargoyle5
        Enemy Gargoyle6
        Enemy Gargoyle7
        Enemy NecromancerElite
        region Region_Fire1
        region Region_Fire2 
        region Region_Fire3
        region Region_Fire4
        boolean Fire1Done = false 
        boolean Fire2Done = false 
        boolean Fire3Done = false 
        boolean Fire4Done = false 

        timer timerSummonHellBringer = CreateTimer()
        integer lastSummonHellBringer = 0

        timer timerCloseZigguratA = CreateTimer()
        timer timerCloseZigguratB = CreateTimer()

        Entrance enterDungeon00 
        Entrance enterDungeon01
        Entrance enterDungeon02
        Entrance enterDungeon04
        Entrance enterDesert 

        group CinematicGroup1 = CreateGroup()
    endglobals


    function CinematicFunc1_0 takes nothing returns nothing
        if GetOwningPlayer(GetEnumUnit()) == Player(1) then 
            call PauseUnit(GetEnumUnit(),true)
            call ShowUnit(GetEnumUnit(),false)
        endif   
    endfunction
    function CinematicFunc1_1 takes nothing returns nothing
        if GetOwningPlayer(GetEnumUnit()) == Player(1) then 
            call PauseUnit(GetEnumUnit(),false)
            call ShowUnit(GetEnumUnit(),true)
            call SetUnitAcquireRange(GetEnumUnit(),100)
        endif   
    endfunction
    function CinematicFunc2_0 takes nothing returns nothing
        if GetDestructableTypeId(GetEnumDestructable()) == 'B62Y' or GetDestructableTypeId(GetEnumDestructable()) == 'B630' then 
            call ShowDestructable(GetEnumDestructable(),false)
        endif 
    endfunction
    function CinematicFunc2_1 takes nothing returns nothing
        if GetDestructableTypeId(GetEnumDestructable()) == 'B62Y' or GetDestructableTypeId(GetEnumDestructable()) == 'B630' then 
            call ShowDestructable(GetEnumDestructable(),true)
        endif 
    endfunction

    function QuestTrig0_Action_DE_20 takes nothing returns nothing
        call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"映入眼帘的是一片惨烈的战场。看样子使团遭到了狗头人的伏击。")
    endfunction
    function QuestTrig0_Action_DE_50 takes nothing returns nothing
        call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"必须立刻返回报告里尔总督，以采取进一步措施。")
    endfunction
    function QuestTrig0_Action_DE_80 takes nothing returns nothing
        call mainQuest[2].obj1.addProgress()
    endfunction
    function QuestTrig0_Action takes nothing returns nothing
        local delayedevent de 
        if mainQuest[2].state == QUEST_STATE_INPROGRESS and IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) and GetOwningPlayer(GetTriggerUnit()) == PLAYER then 
            call DisableTrigger(GetTriggeringTrigger())
            set de = delayedevent.create(200,1,function QuestTrig0_Action_DE_20)
            set de = delayedevent.create(500,1,function QuestTrig0_Action_DE_50)
            set de = delayedevent.create(800,1,function QuestTrig0_Action_DE_80)
        endif 
    endfunction

    function QuestTrig1_Action_DE_2 takes nothing returns nothing
        call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"...愿逝者安息...")
    endfunction
    function QuestTrig1_Action_DE_5 takes nothing returns nothing
        call CreateItemEx('iq02',1136,-1920)
    endfunction
    function QuestTrig1_Action_Des_Pick takes nothing returns nothing
        if GetDestructableTypeId(GetEnumDestructable()) == 'B604' or GetDestructableTypeId(GetEnumDestructable()) == 'B605' then 
            call SetDestructableAnimation(GetEnumDestructable(),"Decay Flesh")
            call SetDestructableAnimationSpeed(GetEnumDestructable(),10)
        endif 
    endfunction
    function QuestTrig1_Action_Des_Pick_EX takes nothing returns nothing
        if GetDestructableTypeId(GetEnumDestructable()) == 'B604' or GetDestructableTypeId(GetEnumDestructable()) == 'B605' then 
            call RemoveDestructable(GetEnumDestructable())
        endif 
    endfunction
    function QuestTrig1_Action_DE_8 takes nothing returns nothing
        call EnumDestructablesInRectAll(gg_rct_QuestZone00,function QuestTrig1_Action_Des_Pick)
    endfunction
    function QuestTrig1_Action_DE_20 takes nothing returns nothing
        call EnumDestructablesInRectAll(gg_rct_QuestZone00,function QuestTrig1_Action_Des_Pick_EX)
    endfunction
    function QuestTrig1_Action takes nothing returns nothing
        local delayedevent de 
        if mainQuest[5].state == QUEST_STATE_INPROGRESS and mainQuest[5].checkCompletion() == false and IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) and GetOwningPlayer(GetTriggerUnit()) == PLAYER then 
            call DisableTrigger(GetTriggeringTrigger())
            call delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\flameguard.mdx",1136,-1920),1000)
            call delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\flamedash_ground.mdx",1136,-1920),1500)
            call delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\birdshit_1.mdx",1136,-1920),1000)
            call delayedDestroyEffect(AddSpecialEffectEX("Abilities\\Spells\\Human\\FlameStrike\\FlameStrike1.mdl",1136,-1920),1000)
            call delayedDestroyEffect(AddSpecialEffectEX("Abilities\\Spells\\Human\\FlameStrike\\FlameStrike.mdl",1136,-1920),1000)
            call delayedDestroyEffect(AddSpecialEffectEX("Abilities\\Spells\\Human\\FlameStrike\\FlameStrike2.mdl",1136,-1920),1000)
            set de = delayedevent.create(200,1,function QuestTrig1_Action_DE_2)
            set de = delayedevent.create(500,1,function QuestTrig1_Action_DE_5)
            set de = delayedevent.create(800,1,function QuestTrig1_Action_DE_8)
            set de = delayedevent.create(2000,1,function QuestTrig1_Action_DE_20)
        endif 
    endfunction
    function QuestTrig3_Action takes nothing returns nothing
        call mainQuest[3].fail()
        call SetDestructableAnimation(gg_dest_LOcg_3895,"stand")
    endfunction
    function QuestTrig4_Timer takes nothing returns nothing
        call SetUnitFacing(gg_unit_hN09_0028,317)
        call DestroyTimer(GetExpiredTimer())
    endfunction
    function QuestTrig4_Action takes nothing returns nothing
        local real x
        local real y 
        local real x1 
        local real y1 
        if GetUnitTypeId(GetTriggerUnit()) == 'hN0A' then
            set x = GetUnitX(GetTriggerUnit())
            set y = GetUnitY(GetTriggerUnit()) 
            set x1 = GetUnitX(gg_unit_hN09_0028)
            set y1 = GetUnitY(gg_unit_hN09_0028)
            call mainQuest[3].obj2.addProgress()
            call RemoveUnit(GetTriggerUnit())
            call SetUnitX(gg_unit_hN09_0028,x)
            call SetUnitY(gg_unit_hN09_0028,y)
            call ShowUnit(gg_unit_hN09_0028,true)
            call IssuePointOrderById(gg_unit_hN09_0028,ORDER_move,x1,y1)
            call TimerStart(CreateTimer(),2,false,function QuestTrig4_Timer)
        endif 
    endfunction
    function QuestTrig2_Delay takes nothing returns nothing
        local Patrol patrol = delayedevent.currentEvent.loadInteger("PATROL")
        call patrol.start()
        call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00元帅特使：|r去永望港，要塞有紧急情报。")
    endfunction
    function QuestTrig2_Action takes nothing returns nothing
        local group pick 
        local Patrol patrol 
        local delayedevent de 
        if mainQuest[3].state == QUEST_STATE_INPROGRESS and mainQuest[3].obj1.completed == false and IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) and GetOwningPlayer(GetTriggerUnit()) == PLAYER then 
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,gg_rct_QuestZone01,playerEnemy)
            if CountUnitsInGroup(pick) <= 0 then 
                call mainQuest[3].obj1.addProgress()
                set mainQuest[3].anotherOwner = CreateUnit(Player(1),'hN0A',5072,4272,270)
                set patrol = CreatePatrolOnce(mainQuest[3].anotherOwner)
                call patrol.addNode(3184,3312)
                call patrol.addNode(2224,3312)
                call patrol.addNode(528,2416)
                call patrol.addNode(-752,2320)
                call patrol.addNode(-1872,2480)
                call patrol.addNode(-2416,2992)
                call patrol.addNode(-2032,3728)
                set de = delayedevent.create(400,1,function QuestTrig2_Delay)
                call de.saveInteger("PATROL",patrol)
                call TriggerRegisterUnitEvent(QuestTrig[3],mainQuest[3].anotherOwner,EVENT_UNIT_DEATH)
                call SetDestructableAnimation(gg_dest_LOcg_3895,"death")
                call TriggerRegisterEnterRectSimple(QuestTrig[4],gg_rct_QuestZone04)
                call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00元帅特使：|r感谢诸位，但这里不是说话的地方。")
            endif 
            call DestroyGroup(pick)
            set pick = null 
        endif 
    endfunction
    function QuestTrig5_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK0Q' then 
            call DisableTrigger(GetTriggeringTrigger())
            set Necromancer1.needRespawn = false
            set Necromancer2.needRespawn = false
            set Necromancer3.needRespawn = false
            call KillUnit(Necromancer1.u)
            call KillUnit(Necromancer2.u)
            call KillUnit(Necromancer3.u)
        endif 
    endfunction
    function QuestTrig6_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK0W' then 
            call DisableTrigger(GetTriggeringTrigger())
            set NecromancerElite.needRespawn = false
            call KillUnit(NecromancerElite.u)
            set Gargoyle1.needRespawn = false
            call KillUnit(Gargoyle1.u)
            set Gargoyle2.needRespawn = false
            call KillUnit(Gargoyle2.u)
            set Gargoyle3.needRespawn = false
            call KillUnit(Gargoyle3.u)
            set Gargoyle4.needRespawn = false
            call KillUnit(Gargoyle4.u)
            set Gargoyle5.needRespawn = false
            call KillUnit(Gargoyle5.u)
            set Gargoyle6.needRespawn = false
            call KillUnit(Gargoyle6.u)
            set Gargoyle7.needRespawn = false
            call KillUnit(Gargoyle7.u)
        endif 
    endfunction
    function QuestTrig7_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK0U' then 
            call DisableTrigger(GetTriggeringTrigger())
            call KillDestructable( gg_dest_Dofv_17621 )
            call KillDestructable( gg_dest_Dofv_17622 )
            call KillDestructable( gg_dest_Dofv_17623 )
        endif 
    endfunction
    function QuestTrig8_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK0Z' then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetPlayerTechResearched(Player(1),'R600',1)
        endif 
    endfunction
    function QuestTrig9_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK10' then 
            call DisableTrigger(GetTriggeringTrigger())
            call ForGroup(CinematicGroup1,function CinematicFunc1_1)
            call EnumDestructablesInRectAll(gg_rct_CinematicArea1,function CinematicFunc2_1)
        endif 
    endfunction
    function QuestTrig10_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK18' then 
            call DisableTrigger(GetTriggeringTrigger())
            call GetGateFromDestructable(gg_dest_Dofv_27618).letOpen()
            call GetGateFromDestructable(gg_dest_Dofv_27619).letOpen()
            call GetGateFromDestructable(gg_dest_Dofv_27620).letOpen()
            call GetGateFromDestructable(gg_dest_Dofv_27621).letOpen()
        endif 
    endfunction
    function QuestTrig11_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK19' then 
            call DisableTrigger(GetTriggeringTrigger())
            set enterDungeon01.active = true 
            call delayedHint("|cffadadff提示：|r现在可以进入大墓地阿纳克提斯了。",200)
        endif 
    endfunction
    function QuestTrig12_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK1B' then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetPlayerTechResearched(Player(1),'R601',1)
        endif 
    endfunction
    function QuestTrig13_Action takes nothing returns nothing
        local real x 
        local real y 
        local real f 
        if GetItemTypeId(GetManipulatedItem()) == 'IK1E' then 
            call DisableTrigger(GetTriggeringTrigger())
            set enterDesert.active = true 
            call delayedHint("|cffadadff提示：|r现在你可以离开西海岸，自由探索整片大陆了。",200)
            call delayedHint("|cffadadff提示：|r现在，大要塞的更多角色将向你提供任务。",800)
            set x = GetUnitX(gg_unit_hN0N_0630)
            set y = GetUnitY(gg_unit_hN0N_0630)
            set f = GetUnitFacing(gg_unit_hN0N_0630)
            call RemoveUnit(gg_unit_hN0N_0630)
            call CreateUnit(Player(1),'hN1A',x,y,f)
        endif 
    endfunction
    function QuestTrig14_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IQ1O' then 
            call DisableTrigger(GetTriggeringTrigger())
            set enterDungeon02.active = true 
            call delayedHint("|cffadadff提示：|r现在可以进入远古圣所了。",200)
        endif 
    endfunction
    function QuestTrig15_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IQ1Q' then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetPlayerTechResearched(Player(2),'R602',1)
        endif 
    endfunction

    function ITEM_iq03_USE takes nothing returns nothing
        if IsUnitInRegion(Region_Fire1,itemTriggerUnit) and Fire1Done == false then 
            set Fire1Done = true 
            call SetDoodadAnimationRect(gg_rct_Fire1,'D624',"death",false)
            call mainQuest[9].obj1.addProgress()
            call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\HolyForce.mdx",GetUnitX(itemTriggerUnit),GetUnitY(itemTriggerUnit)))
        endif 
        if IsUnitInRegion(Region_Fire2,itemTriggerUnit) and Fire2Done == false then 
            set Fire2Done = true 
            call SetDoodadAnimationRect(gg_rct_Fire2,'D624',"death",false)
            call mainQuest[9].obj1.addProgress()
            call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\HolyForce.mdx",GetUnitX(itemTriggerUnit),GetUnitY(itemTriggerUnit)))
        endif 
        if IsUnitInRegion(Region_Fire3,itemTriggerUnit) and Fire3Done == false then 
            set Fire3Done = true 
            call SetDoodadAnimationRect(gg_rct_Fire3,'D624',"death",false)
            call mainQuest[9].obj1.addProgress()
            call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\HolyForce.mdx",GetUnitX(itemTriggerUnit),GetUnitY(itemTriggerUnit)))
        endif 
        if IsUnitInRegion(Region_Fire4,itemTriggerUnit) and Fire4Done == false then 
            set Fire4Done = true 
            call SetDoodadAnimationRect(gg_rct_Fire4,'D624',"death",false)
            call mainQuest[9].obj1.addProgress()
            call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\HolyForce.mdx",GetUnitX(itemTriggerUnit),GetUnitY(itemTriggerUnit)))
        endif 
    endfunction

    function Hint1 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        call PingMinimap(GetUnitX(mainQuest[0].owner),GetUnitY(mainQuest[0].owner),5)
        call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffadadff提示：|r点击选中NPC，然后点击界面中的对话按钮，可以与NPC对话来接取/完成任务或进行其他操作。")
    endfunction
    function Hint2 takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            if GetStoredInteger(gameCache,"DATAS","HINT_LEVEL_UP") == 0 then 
                call StoreInteger(gameCache,"DATAS","HINT_LEVEL_UP",1)
                call TriggerSleepAction(2)
                call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffadadff提示：|r你升级了！可以学习新的技能，并可以使用天赋。点击界面上的天赋按钮(快捷键：|cffffcc00T|r)即可打开天赋页面配置天赋。每2级都会解锁1个天赋栏位。")
            endif 
        endif 
    endfunction
    function Hint3 takes nothing returns nothing
        if GetEquipment(GetManipulatedItem()) > 0 then 
            call DisableTrigger(GetTriggeringTrigger())
            if GetStoredInteger(gameCache,"DATAS","HINT_PICK_ITEM") == 0 then 
                call StoreInteger(gameCache,"DATAS","HINT_PICK_ITEM",1)
                call TriggerSleepAction(2)
                call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffadadff提示：|r你获得了一件装备。在物品栏内点击它以将其装备。点击界面上的装备栏按钮(快捷键：|cffffcc00I|r)即可打开装备栏，管理英雄的装备。需要注意某些装备带有护甲或武器类型限制，请合理分配。")
            endif 
        endif 
    endfunction
    function Hint4 takes nothing returns nothing
        if GetStoredInteger(gameCache,"DATAS","HINT_UNLOCK_REVIVE_STONE") == 0 then 
            call StoreInteger(gameCache,"DATAS","HINT_UNLOCK_REVIVE_STONE",1)
            call TriggerSleepAction(2)
            call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffadadff提示：|r你激活了一个复活石！在大地图上，你可以找到许多复活石，靠近以激活它们，以便在英雄阵亡时可以被重生在正确的位置。你也可以在复活石之间快速移动。")
        endif 
    endfunction
    function Hint5 takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) then 
            call DisableTrigger(GetTriggeringTrigger())
            if GetStoredInteger(gameCache,"DATAS","HINT_UNLOCK_ARMOURY") == 0 then 
                call StoreInteger(gameCache,"DATAS","HINT_UNLOCK_ARMOURY",1)
                call SetUnitOwner(armoury,PLAYER,true)
                call UnitAddIndicator(armoury,174,174,255,255)
                call TriggerSleepAction(2)
                call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffadadff提示：|r现在可以使用军械库储存物品或是英雄的装备配置了。")
            endif 
        endif 
    endfunction
    function Hint6 takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK01' then 
            call DisableTrigger(GetTriggeringTrigger())
            if GetStoredInteger(gameCache,"DATAS","HINT_SAVE") == 0 then 
                call StoreInteger(gameCache,"DATAS","HINT_SAVE",1)
                call TriggerSleepAction(2)
                call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffadadff提示：|r在游戏过程中，你可以随时在聊天框中输入|cffffcc00save|r来保存游戏数据，以便继续游戏。建议时常输入|cffffcc00save|r存档，以免数据丢失。")
            endif 
        endif 
    endfunction
    function Hint7 takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) then 
            call DisableTrigger(GetTriggeringTrigger())
            if GetStoredInteger(gameCache,"DATAS","HINT_REVIVE") == 0 then 
                call StoreInteger(gameCache,"DATAS","HINT_REVIVE",1)
                call TriggerSleepAction(2)
                call PingMinimap(-5235,-349,5)
                call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffadadff提示：|r你可以在地图上找到许多复活石，它们能免费地将英雄从死亡中复活。")
            endif 
        endif 
    endfunction
    function Hint8 takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) then 
            call DisableTrigger(GetTriggeringTrigger())
            if GetStoredInteger(gameCache,"DATAS","HINT_SWAP") == 0 then 
                call StoreInteger(gameCache,"DATAS","HINT_SWAP",1)
                call TriggerSleepAction(2)
                call PingMinimap(13691,-20609,5)
                call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffadadff提示：|r将队伍中的英雄放入酒馆可以使他们离队；队伍不满时点击酒馆中的英雄可以将他们加入队伍。你的队伍获得经验时，酒馆中的英雄也会获得经验。")
                
                call UnitShareVision(gg_unit_nzin_1337,PLAYER,true)
                call UnitShareVision(gg_unit_nzin_1338,PLAYER,true)
            endif 
        endif 
    endfunction
    function Hint9 takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK0X' then 
            call DisableTrigger(GetTriggeringTrigger())
            set enterDungeon00.active = true 
            call delayedHint("|cffadadff提示：|r现在可以进入要塞监狱了。",200)
            call delayedHint("|cffadadff提示：|r首领敌人会使用引导类技能，并显示引导指示器。|cffffcc00“沉默”、“诱捕”、“缠绕”、“击晕”效果|r均可以打断引导。",350)
            call delayedHint("|cffadadff提示：|r只有引导指示器为红色时，首领敌人可以被打断。引导技能的威胁度较高，请注意队伍技能搭配！",500)
        endif 
    endfunction

    function ToPlateau_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'iq0R' then 
            call enterDungeon04.Leave()
        endif 
    endfunction

    globals
        private group summonUseGroup = CreateGroup()
    endglobals
    
    function delayedSummonHellBringer_150 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl",GetRectCenterX(gg_rct_summon5),GetRectCenterY(gg_rct_summon5)))
        call BossHellBringer_boss.initialize()
        call BossHellBringer_boss.activate()
    endfunction
    function delayedSummonHellBringer_50 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",GetRectCenterX(gg_rct_summon5),GetRectCenterY(gg_rct_summon5)))
        call TimerStart(CreateTimer(),1,false,function delayedSummonHellBringer_150)
    endfunction
    function SummonHellBringer takes nothing returns nothing
        local integer count = 0
        if sideQuest[9].state == QUEST_STATE_NONE then 
            return 
        endif 
        if lastSummonHellBringer > 0 and globalNowtime-lastSummonHellBringer < 30000 then 
            return 
        endif 
        call GroupClear(summonUseGroup)
        call GroupEnumUnitsInRect(summonUseGroup,gg_rct_summon1,playerHero)
        if CountUnitsInGroup(summonUseGroup) > 0 then 
            set count = count+1
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",GetRectCenterX(gg_rct_summon1),GetRectCenterY(gg_rct_summon1)))
        endif 
        call GroupClear(summonUseGroup)
        call GroupEnumUnitsInRect(summonUseGroup,gg_rct_summon2,playerHero)
        if CountUnitsInGroup(summonUseGroup) > 0 then 
            set count = count+1
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",GetRectCenterX(gg_rct_summon2),GetRectCenterY(gg_rct_summon2)))
        endif 
        call GroupClear(summonUseGroup)
        call GroupEnumUnitsInRect(summonUseGroup,gg_rct_summon3,playerHero)
        if CountUnitsInGroup(summonUseGroup) > 0 then 
            set count = count+1
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",GetRectCenterX(gg_rct_summon3),GetRectCenterY(gg_rct_summon3)))
        endif 
        call GroupClear(summonUseGroup)
        call GroupEnumUnitsInRect(summonUseGroup,gg_rct_summon4,playerHero)
        if CountUnitsInGroup(summonUseGroup) > 0 then 
            set count = count+1
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",GetRectCenterX(gg_rct_summon4),GetRectCenterY(gg_rct_summon4)))
        endif 
        if count == 4 then 
            call PauseTimer(timerSummonHellBringer)
            call TimerStart(CreateTimer(),0.5,false,function delayedSummonHellBringer_50)
            call delayedDestroyEffect(AddSpecialEffectEX("Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeTarget.mdl",GetRectCenterX(gg_rct_summon5),GetRectCenterY(gg_rct_summon5)),200)
        endif 
    endfunction

    globals 
        private group closeUseGroup_A = CreateGroup()
        private group closeUseGroup_B = CreateGroup()
    endglobals
    function CloseZigguratA takes nothing returns nothing
        local integer count = 0
        
        if mainQuest[14].state != QUEST_STATE_INPROGRESS then 
            return 
        endif 
        call GroupClear(closeUseGroup_A)
        call GroupClear(closeUseGroup_B)
        call GroupEnumUnitsInRect(closeUseGroup_A,gg_rct_Ziggurata1,playerHero)
        call GroupEnumUnitsInRect(closeUseGroup_B,gg_rct_Ziggurata1,playerEnemy)
        if CountUnitsInGroup(closeUseGroup_A) > 0 and CountUnitsInGroup(closeUseGroup_B) == 0 then 
            set count = count+1
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl",GetRectCenterX(gg_rct_Ziggurata1),GetRectCenterY(gg_rct_Ziggurata1)))
        endif 
        call GroupClear(closeUseGroup_A)
        call GroupClear(closeUseGroup_B)
        call GroupEnumUnitsInRect(closeUseGroup_A,gg_rct_Ziggurata2,playerHero)
        call GroupEnumUnitsInRect(closeUseGroup_B,gg_rct_Ziggurata2,playerEnemy)
        if CountUnitsInGroup(closeUseGroup_A) > 0 and CountUnitsInGroup(closeUseGroup_B) == 0 then 
            set count = count+1
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl",GetRectCenterX(gg_rct_Ziggurata2),GetRectCenterY(gg_rct_Ziggurata2)))
        endif 
        call GroupClear(closeUseGroup_A)
        call GroupClear(closeUseGroup_B)
        call GroupEnumUnitsInRect(closeUseGroup_A,gg_rct_Ziggurata3,playerHero)
        call GroupEnumUnitsInRect(closeUseGroup_B,gg_rct_Ziggurata3,playerEnemy)
        if CountUnitsInGroup(closeUseGroup_A) > 0 and CountUnitsInGroup(closeUseGroup_B) == 0 then 
            set count = count+1
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl",GetRectCenterX(gg_rct_Ziggurata3),GetRectCenterY(gg_rct_Ziggurata3)))
        endif 
        if count == 3 then 
            call PauseTimer(timerCloseZigguratA)
            call delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\HolyForce.mdx",GetRectCenterX(gg_rct_Ziggurata4),GetRectCenterY(gg_rct_Ziggurata4)),200)
            call SetDoodadAnimationRect(gg_rct_Ziggurata,'D63W',"death",false)
            call mainQuest[14].obj2.addProgress()
        endif 
    endfunction
    function CloseZigguratB takes nothing returns nothing
        local integer count = 0
        if mainQuest[14].state != QUEST_STATE_INPROGRESS then 
            return 
        endif 
        call GroupClear(closeUseGroup_A)
        call GroupClear(closeUseGroup_B)
        call GroupEnumUnitsInRect(closeUseGroup_A,gg_rct_Zigguratb1,playerHero)
        call GroupEnumUnitsInRect(closeUseGroup_B,gg_rct_Zigguratb1,playerEnemy)
        if CountUnitsInGroup(closeUseGroup_A) > 0 and CountUnitsInGroup(closeUseGroup_B) == 0 then 
            set count = count+1
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl",GetRectCenterX(gg_rct_Zigguratb1),GetRectCenterY(gg_rct_Zigguratb1)))
        endif 
        call GroupClear(closeUseGroup_A)
        call GroupClear(closeUseGroup_B)
        call GroupEnumUnitsInRect(closeUseGroup_A,gg_rct_Zigguratb2,playerHero)
        call GroupEnumUnitsInRect(closeUseGroup_B,gg_rct_Zigguratb2,playerEnemy)
        if CountUnitsInGroup(closeUseGroup_A) > 0 and CountUnitsInGroup(closeUseGroup_B) == 0 then 
            set count = count+1
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl",GetRectCenterX(gg_rct_Zigguratb2),GetRectCenterY(gg_rct_Zigguratb2)))
        endif 
        call GroupClear(closeUseGroup_A)
        call GroupClear(closeUseGroup_B)
        call GroupEnumUnitsInRect(closeUseGroup_A,gg_rct_Zigguratb3,playerHero)
        call GroupEnumUnitsInRect(closeUseGroup_B,gg_rct_Zigguratb3,playerEnemy)
        if CountUnitsInGroup(closeUseGroup_A) > 0 and CountUnitsInGroup(closeUseGroup_B) == 0 then 
            set count = count+1
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl",GetRectCenterX(gg_rct_Zigguratb3),GetRectCenterY(gg_rct_Zigguratb3)))
        endif 
        if count == 3 then 
            call PauseTimer(timerCloseZigguratB)
            call delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\HolyForce.mdx",GetRectCenterX(gg_rct_Zigguratb4),GetRectCenterY(gg_rct_Zigguratb4)),200)
            call SetDoodadAnimationRect(gg_rct_Zigguratb,'D63W',"death",false)
            call mainQuest[14].obj1.addProgress()
        endif 
    endfunction
    
    function OpenCityGates takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK0J' then 
            call DisableTrigger(GetTriggeringTrigger())
            call GetGateFromDestructable(gg_dest_B606_4702).enable()
            call GetGateFromDestructable(gg_dest_YTcx_5006).enable()
            call GetGateFromDestructable(gg_dest_YTcx_4703).enable()
            call GetGateFromDestructable(gg_dest_YTce_5005).enable()
            call GetGateFromDestructable(gg_dest_YTce_4701).enable()
        endif 
    endfunction

    function RemoveBarricades takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IK0N' then 
            call DisableTrigger(GetTriggeringTrigger())
            call KillDestructable( gg_dest_LTba_8952 )
            call KillDestructable( gg_dest_LTba_8951 )
            call KillDestructable( gg_dest_LTba_8942 )
            call KillDestructable( gg_dest_LTba_8941 )
            call KillDestructable( gg_dest_LTba_8939 )
            call KillDestructable( gg_dest_LTba_8940 )
            call KillDestructable( gg_dest_LTba_8950 )
            call KillDestructable( gg_dest_LTba_8949 )
        endif 
    endfunction

    function unlockReviveStone1_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0561,PLAYER,true)
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_1",1)
            call AddUnitAnimationProperties(gg_unit_hAVT_0561,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0561,174,174,255,255)
            call Hint4()
        endif 
    endfunction
    function unlockReviveStone2_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0562,PLAYER,true)
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_2",1)
            call AddUnitAnimationProperties(gg_unit_hAVT_0562,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0562,174,174,255,255)
            call Hint4()
        endif 
    endfunction
    function unlockReviveStone3_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0563,PLAYER,true)
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_3",1)
            call AddUnitAnimationProperties(gg_unit_hAVT_0563,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0563,174,174,255,255)
            call Hint4()
        endif 
    endfunction
    function unlockReviveStone4_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0564,PLAYER,true)
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_4",1)
            call AddUnitAnimationProperties(gg_unit_hAVT_0564,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0564,174,174,255,255)
            call Hint4()
        endif 
    endfunction
    function unlockReviveStone5_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_1339,PLAYER,true)
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_5",1)
            call AddUnitAnimationProperties(gg_unit_hAVT_1339,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_1339,174,174,255,255)
            call Hint4()
        endif 
    endfunction
    function unlockReviveStone6_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_1420,PLAYER,true)
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_6",1)
            call AddUnitAnimationProperties(gg_unit_hAVT_1420,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_1420,174,174,255,255)
            call Hint4()
        endif 
    endfunction

    function resetInnsSelected takes nothing returns nothing
        call UnitShareVision(GetEnumUnit(),PLAYER,true)
        call SetUnitOwner(GetEnumUnit(),Player(8),true)
    endfunction
    function bindHearthStone_Action takes nothing returns nothing
        call GroupClear(allInns)
        call GroupEnumUnitsInRect(allInns,wholeMapRect,isInnSelected)
        if GetItemTypeId(GetSoldItem()) == 'IHSN' then 
            if GetUnitTypeId(GetTriggerUnit()) == 'hN03' and GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") != 0 then 
                call ForGroup(allInns,function resetInnsSelected)
                call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME",0)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl",GetTriggerUnit(),"origin"))
                call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00绑定旅店：狮鹫之帆|r")
                call SetUnitOwner(gg_unit_ugol_0566,Player(2),true)
            elseif GetUnitTypeId(GetTriggerUnit()) == 'hN0G' and GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") != 1 then 
                call ForGroup(allInns,function resetInnsSelected)
                call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME",1)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl",GetTriggerUnit(),"origin"))
                call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00绑定旅店：旅者的小憩|r")
                call SetUnitOwner(gg_unit_ugol_0565,Player(2),true)
            elseif GetUnitTypeId(GetTriggerUnit()) == 'hN0P' and GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") != 2 then 
                call ForGroup(allInns,function resetInnsSelected)
                call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME",2)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl",GetTriggerUnit(),"origin"))
                call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00绑定旅店：财富路口|r")
                call SetUnitOwner(gg_unit_ugol_0649,Player(2),true)
            elseif GetUnitTypeId(GetTriggerUnit()) == 'hN1F' and GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") != 3 then 
                call ForGroup(allInns,function resetInnsSelected)
                call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME",3)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl",GetTriggerUnit(),"origin"))
                call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00绑定旅店：灵魂栖所|r")
                call SetUnitOwner(gg_unit_ugol_1382,Player(2),true)
            endif 
        endif 
    endfunction

    private function init takes nothing returns nothing
        set QuestTrig[0] = CreateTrigger()
        call TriggerRegisterEnterRectSimple(QuestTrig[0],gg_rct_QuestZone00)
        call TriggerAddActionEx(QuestTrig[0],function QuestTrig0_Action)
        set QuestTrig[1] = CreateTrigger()
        call TriggerRegisterEnterRectSimple(QuestTrig[1],gg_rct_QuestZone00)
        call TriggerAddActionEx(QuestTrig[1],function QuestTrig1_Action)
        set QuestTrig[2] = CreateTrigger()
        call TriggerRegisterEnterRectSimple(QuestTrig[2],gg_rct_QuestZone03)
        call TriggerRegisterLeaveRectSimple(QuestTrig[2],gg_rct_QuestZone03)
        call TriggerAddActionEx(QuestTrig[2],function QuestTrig2_Action)
        set QuestTrig[3] = CreateTrigger()
        call TriggerAddActionEx(QuestTrig[3],function QuestTrig3_Action)
        set QuestTrig[4] = CreateTrigger()
        call TriggerAddActionEx(QuestTrig[4],function QuestTrig4_Action)
        set QuestTrig[5] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[5],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[5],function QuestTrig5_Action)
        set QuestTrig[6] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[6],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[6],function QuestTrig6_Action)
        set QuestTrig[7] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[7],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[7],function QuestTrig7_Action)
        set QuestTrig[8] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[8],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[8],function QuestTrig8_Action)
        set QuestTrig[9] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[9],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[9],function QuestTrig9_Action)
        set QuestTrig[10] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[10],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[10],function QuestTrig10_Action)
        set QuestTrig[11] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[11],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[11],function QuestTrig11_Action)
        set QuestTrig[12] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[12],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[12],function QuestTrig12_Action)
        set QuestTrig[13] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[13],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[13],function QuestTrig13_Action)
        set QuestTrig[14] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[14],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[14],function QuestTrig14_Action)
        set QuestTrig[15] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[15],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[15],function QuestTrig15_Action)


        call TriggerRegisterPlayerUnitEvent(HintLevelUp,PLAYER,EVENT_PLAYER_HERO_LEVEL,null)
        call TriggerAddActionEx(HintLevelUp,function Hint2)
        call TriggerRegisterAnyUnitEventBJ(HintPickItem,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(HintPickItem,function Hint3)
        call TriggerRegisterAnyUnitEventBJ(OpenCityGate,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(OpenCityGate,function OpenCityGates)
        call TriggerRegisterAnyUnitEventBJ(RemoveBarricade,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(RemoveBarricade,function RemoveBarricades)
        call TriggerRegisterAnyUnitEventBJ(HintSave,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(HintSave,function Hint6)
        call TriggerRegisterAnyUnitEventBJ(HintRevive,EVENT_PLAYER_UNIT_DEATH)
        call TriggerRegisterTimerEventSingle(HintRevive,180)
        call TriggerAddActionEx(HintRevive,function Hint7)
        call TriggerRegisterEnterRectSimple(HintSwap,gg_rct_HintSwapRect)
        call TriggerAddActionEx(HintSwap,function Hint8)
        call TriggerRegisterAnyUnitEventBJ(unlockJail,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(unlockJail,function Hint9)

        call TriggerRegisterAnyUnitEventBJ(ToPlateau,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(ToPlateau,function ToPlateau_Action)
        
        call TriggerRegisterUnitInRangeSimple(unlockReviveStone1,350,gg_unit_hAVT_0561)
        call TriggerAddAction(unlockReviveStone1,function unlockReviveStone1_Action)
        call TriggerRegisterUnitInRangeSimple(unlockReviveStone2,350,gg_unit_hAVT_0562)
        call TriggerAddAction(unlockReviveStone2,function unlockReviveStone2_Action)
        call TriggerRegisterUnitInRangeSimple(unlockReviveStone3,350,gg_unit_hAVT_0563)
        call TriggerAddAction(unlockReviveStone3,function unlockReviveStone3_Action)
        call TriggerRegisterUnitInRangeSimple(unlockReviveStone4,350,gg_unit_hAVT_0564)
        call TriggerAddAction(unlockReviveStone4,function unlockReviveStone4_Action)
        call TriggerRegisterUnitInRangeSimple(unlockReviveStone5,350,gg_unit_hAVT_1339)
        call TriggerAddAction(unlockReviveStone5,function unlockReviveStone5_Action)
        call TriggerRegisterUnitInRangeSimple(unlockReviveStone6,350,gg_unit_hAVT_1420)
        call TriggerAddAction(unlockReviveStone6,function unlockReviveStone6_Action)

        call TriggerRegisterAnyUnitEventBJ(bindHearthStone,EVENT_PLAYER_UNIT_SELL_ITEM)
        call TriggerAddAction(bindHearthStone,function bindHearthStone_Action)

        call TimerStart(timerSummonHellBringer,1,true,function SummonHellBringer)

        call TimerStart(timerCloseZigguratA,1,true,function CloseZigguratA)
        call TimerStart(timerCloseZigguratB,1,true,function CloseZigguratB)
    endfunction
endlibrary

library MapLoot initializer init requires MapTrig

    function ENEMY_LOOT_n602 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Pulato,1,0.05)
    endfunction
    function ENEMY_LOOT_n609 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_TerribleWolf,1,0.05)
    endfunction
    function ENEMY_LOOT_n60D takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_KoboldLord,1,0.05)
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,1)
    endfunction

    
    function ENEMY_LOOT_n61P takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_BroodMother,1,0.15)
    endfunction
    function ENEMY_LOOT_n61M takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_ShadowHunter,1,0.15)
    endfunction
    function ENEMY_LOOT_n60Q takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Ghoul,1,0.15)
    endfunction
    function ENEMY_LOOT_n60R takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Gargoyle,1,0.15)
    endfunction
    function ENEMY_LOOT_n62D takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Scrab,1,0.15)
    endfunction
    function ENEMY_LOOT_n625 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Centaur,1,0.15)
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,1)
    endfunction
    function ENEMY_LOOT_n62J takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Yeti,1,0.15)
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,1.5)
    endfunction

    function ENEMY_LOOT_n61S takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n61L takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n61H takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n61K takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n61I takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n61J takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n621 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n622 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n623 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n624 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n61T takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n61G takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n62C takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,0.2)
    endfunction
    function ENEMY_LOOT_n62B takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,0.2)
        call EnemyLoot(eventDyingUnit,Loot_Food_1,0,0.4)
    endfunction
    function ENEMY_LOOT_n62I takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,0.3)
    endfunction
    function ENEMY_LOOT_n62G takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,0.3)
    endfunction
    function ENEMY_LOOT_n62H takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,0.35)
    endfunction

    
    function UNIT_hMC0_DEATH takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Common,1,0.25)
        call EnemyLoot(eventDyingUnit,Loot_Chest,0,1)
    endfunction
    function UNIT_hMO0_DEATH takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Gem_Level_1,0,0.5)
    endfunction
    function UNIT_hMO1_DEATH takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Gem_Level_1,0,0.5)
    endfunction

    function DefeatBossHellBringer takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_HellBringer,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)
        call EnemyLoot(eventBoss.u[0],Loot_Fabric_1,0,1)
        call EnemyLoot(eventBoss.u[0],Loot_DemonBone,0,1)
        set lastSummonHellBringer = globalNowtime
        call TimerStart(timerSummonHellBringer,0.5,true,function SummonHellBringer)
        if sideQuest[9].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[9].obj1.addProgress()
        endif 
    endfunction
    function ResetBossHellBringer takes nothing returns nothing
        call TimerStart(timerSummonHellBringer,0.5,true,function SummonHellBringer)
    endfunction

    globals 
        LootPool EliteLoot_Pulato
        LootPool EliteLoot_TerribleWolf
        LootPool EliteLoot_KoboldLord

        LootPool EliteLoot_BroodMother
        LootPool EliteLoot_ShadowHunter
        LootPool EliteLoot_Ghoul
        LootPool EliteLoot_Gargoyle
        LootPool EliteLoot_Scrab
        LootPool EliteLoot_Centaur
        LootPool EliteLoot_Yeti

        LootPool EliteLoot_Common

        LootPool BossLoot_HellBringer

        LootPool BossDropPlatinum

        LootPool Loot_Chest
        LootPool Loot_Leather_1
        LootPool Loot_Fabric_1
        LootPool Loot_Food_1
        LootPool Loot_DemonBone
        LootPool Loot_Gem_Level_1
    endglobals

    private function init takes nothing returns nothing
        local LootPool whichPool

        
        set whichPool = CreateLootPool()
        call whichPool.addItem('I60L',8)
        call whichPool.addItem('I60P',5)
        call whichPool.addItem('I60O',8)
        call whichPool.addItem('I609',8)
        call whichPool.addItem('I60K',3)
        call whichPool.addItem('I629',7)
        call whichPool.addItem('I62A',7)
        call whichPool.addItem('I62B',7)
        call whichPool.addItem('I62L',7)
        call whichPool.addItem('I61D',11)
        call whichPool.addItem('I61F',11)
        call whichPool.addItem('I623',11)
        call whichPool.addItem('I624',11)
        call whichPool.addItem('I625',11)
        call whichPool.addItem('I62N',11)
        call whichPool.addItem('I62O',11)
        call whichPool.addItem('I62P',11)
        call whichPool.addItem('I62Q',11)
        call whichPool.addItem('I62U',11)
        call whichPool.addItem('I62V',11)
        call whichPool.addItem('I62W',11)
        set EliteLoot_Common = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,47)
        call whichPool.addItem('IML0',13)
        call whichPool.addItem('IMF1',11)
        call whichPool.addItem('I62R',5)
        call whichPool.addItem('I62S',5)
        call whichPool.addItem('I62T',5)
        set Loot_Chest = whichPool


        set whichPool = CreateLootPool()
        call whichPool.addItem('I60L',8)
        call whichPool.addItem('I60P',5)
        call whichPool.addItem('I60O',8)
        call whichPool.addItem('I60I',11)
        call whichPool.addItem('I609',8)
        call whichPool.addItem('I60K',3)
        set EliteLoot_TerribleWolf = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I60O',8)
        call whichPool.addItem('I60P',5)
        call whichPool.addItem('I60K',3)
        call whichPool.addItem('I60L',8)
        call whichPool.addItem('I608',11)
        call whichPool.addItem('I609',8)
        set EliteLoot_Pulato = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I60Q',11)
        call whichPool.addItem('I60P',5)
        call whichPool.addItem('I60K',3)
        call whichPool.addItem('I609',8)
        call whichPool.addItem('I60L',8)
        call whichPool.addItem('I60O',8)
        set EliteLoot_KoboldLord = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I629',7)
        call whichPool.addItem('I62A',7)
        call whichPool.addItem('I62B',7)
        call whichPool.addItem('I62L',7)
        set EliteLoot_BroodMother = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I61J',5)
        call whichPool.addItem('I605',5)
        call whichPool.addItem('I61O',5)
        call whichPool.addItem('I62I',5)
        set EliteLoot_ShadowHunter = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I61D',11)
        call whichPool.addItem('I61F',11)
        call whichPool.addItem('I623',11)
        call whichPool.addItem('I624',11)
        call whichPool.addItem('I625',11)
        call whichPool.addItem('I62C',53)
        call whichPool.addItem('I62M',53)
        set EliteLoot_Ghoul = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I623',11)
        call whichPool.addItem('I624',11)
        call whichPool.addItem('I625',11)
        call whichPool.addItem('I61D',11)
        call whichPool.addItem('I61F',11)
        call whichPool.addItem('I62D',53)
        call whichPool.addItem('I62E',53)
        set EliteLoot_Gargoyle = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I61F',11)
        call whichPool.addItem('I61D',11)
        call whichPool.addItem('I624',11)
        call whichPool.addItem('I625',11)
        call whichPool.addItem('I623',11)
        call whichPool.addItem('I62J',53)
        call whichPool.addItem('I62K',53)
        set EliteLoot_Scrab = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I62N',31)
        call whichPool.addItem('I62O',31)
        call whichPool.addItem('I62P',31)
        call whichPool.addItem('I62Q',31)
        set EliteLoot_Centaur = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I62U',17)
        call whichPool.addItem('I62V',17)
        call whichPool.addItem('I62W',17)
        set EliteLoot_Yeti = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I62R',19)
        call whichPool.addItem('I62S',19)
        call whichPool.addItem('I62T',19)
        set BossLoot_HellBringer = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,43)
        call whichPool.addItem('ipl0',5)
        set BossDropPlatinum = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,17)
        call whichPool.addItem('IML0',13)
        set Loot_Leather_1 = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,17)
        call whichPool.addItem('IMF1',11)
        set Loot_Fabric_1 = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,8)
        call whichPool.addItem('ID00',10)
        set Loot_Food_1 = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('IMOZ',10)
        set Loot_DemonBone = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,37)
        call whichPool.addItem('Ic00',10)
        call whichPool.addItem('Ic01',10)
        call whichPool.addItem('Ic02',10)
        call whichPool.addItem('Ic03',10)
        set Loot_Gem_Level_1 = whichPool
    endfunction
endlibrary

library mapscript initializer init requires MapLoot

    globals
        unit array selectedHero [5]
        effect array selectionEffect [5]
        trigger triggerSelectHero = CreateTrigger()
        trigger triggerRepickHero = CreateTrigger()
        trigger triggerConfirmSelection = CreateTrigger()
        trigger triggerResetSelection = CreateTrigger()
        unit selectingHero = null 
        dialog dialogConfirmSelection = DialogCreate()
        button btnConfirmSelection = DialogAddButton(dialogConfirmSelection,"确认",0)
        button btnResetSelection = DialogAddButton(dialogConfirmSelection,"重选",0)
        group groupSelectedHeroes = CreateGroup()
        string array HERO_TOOLTIP

        constant integer MAP_INDEX = 1
    endglobals
    /////////////////////////////////////////////
    // region Reselect
    /////////////////////////////////////////////
    function OutInnAction takes nothing returns nothing
        local integer i = 0
        local integer k = 0
        local Equipment eq 
        if GetHeroIndex(GetTriggerUnit()) > 0 and GetPartyIndex(GetTriggerUnit()) == -1 and GetOwningPlayer(GetTriggerUnit()) == PLAYER2 then 
            loop 
                exitwhen i > 4
                if party[i] == null then 
                    call SetUnitOwner(GetTriggerUnit(),PLAYER,true)
                    set party[i] = GetTriggerUnit()
                    call ClearTargetHeroGrid(party[i])
                    call SetUnitX(GetTriggerUnit(),GetRandomReal(14720,14912))
                    call SetUnitY(GetTriggerUnit(),GetRandomReal(-20896,-20736))
                    call SetHeroData(party[i],PARTY_INDEX,i+1)
                    call UnitAddAbility(party[i],'AIV0'+i)
                    call UnitMakeAbilityPermanent(party[i],true,'AIV0'+i)
                    loop 
                        exitwhen k > 9
                        set eq = GetEquipedItem(party[i],k)
                        if eq > 0 then 
                            call eq.changeAbility()
                        else 
                            call ResetInvDescription(party[i],k)
                        endif   
                        set k = k+1
                    endloop
                    call RefreshHeroTalent_Learn.evaluate(party[i])
                    set placedHeroCount = placedHeroCount - 1
                    exitwhen true 
                endif 
                set i = i+1
            endloop
        endif 
    endfunction
    function EnterInnAction takes nothing returns nothing
        local integer i = 0
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            set i = GetPartyIndex(GetTriggerUnit())
            call SetUnitOwner(party[i],PLAYER2,true)
            call PlaceUnselectedHeroScattered(party[i], loadOtherHeroesRect)
            call UnitRemoveAbility(party[i],'AIV0'+i)
            call SetHeroData(party[i],PARTY_INDEX,0)
            call RefreshHeroTalent_Reset.evaluate(party[i])
            set party[i] = null 
            call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffffcc00现在可以点击酒馆中的英雄来将其加入队伍。|r")
        endif 
    endfunction
    /////////////////////////////////////////////////////
    // endregion 
    /////////////////////////////////////////////////////

    function triggerSelectHero_Action_Enable takes nothing returns nothing
        call EnableTrigger(triggerSelectHero)
    endfunction
    function triggerSelectHero_Action takes nothing returns nothing
        local integer i = 0
        call DisableTrigger(triggerSelectHero)
        if IsUnitInGroup(GetTriggerUnit(),groupSelectedHeroes) == false then 
            if GetTriggerUnit() == selectingHero then
                loop 
                    exitwhen selectedHero[i] == null or i>4
                    set i = i+1
                endloop
                if i <= 4 then 
                    set selectedHero[i] = CreateUnit(PLAYER,GetUnitTypeId(selectingHero),GetRandomReal(GetRectMinX(gg_rct_GameStartRect),GetRectMaxX(gg_rct_GameStartRect)),GetRandomReal(GetRectMinY(gg_rct_GameStartRect),GetRectMaxY(gg_rct_GameStartRect)),235)
                    call ShowUnit(selectedHero[i],false)
                    call ModifyHeroSkillPoints(selectedHero[i],bj_MODIFYMETHOD_SET,0)
                    call GroupAddUnit(groupSelectedHeroes,selectingHero)
                    set selectionEffect[i] = AddSpecialEffectEX("war3campImported\\BeamOnly.mdx",GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()))
                    set selectingHero = null 
                    call ClearTextMessages()
                    call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffffcc00双击英雄进行选择。\n\n你需要选择五名英雄组成队伍。\n\n在稍后的游戏进程中，你可以随时更换队伍中的英雄。|r")
                endif 
                if i == 4 then 
                    call DialogDisplay(PLAYER,dialogConfirmSelection,true)
                endif 
            else 
                set selectingHero = GetTriggerUnit()
                call ClearTextMessages()
                call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,HERO_TOOLTIP[GetHeroIndex(selectingHero)-1])
            endif 
        endif 
        call delayedevent.create(10,1,function triggerSelectHero_Action_Enable)
    endfunction
    function triggerConfirmSelection_Action takes nothing returns nothing
        local integer i = 0
        local integer k = 0
        set party[0] = selectedHero[0]
        call SetHeroData(party[0],PARTY_INDEX,1)
        call UnitAddAbility(party[0],'AIV0'+0)
        call UnitMakeAbilityPermanent(party[0],true,'AIV0'+0)
        set party[1] = selectedHero[1]
        call SetHeroData(party[1],PARTY_INDEX,2)
        call UnitAddAbility(party[1],'AIV0'+1)
        call UnitMakeAbilityPermanent(party[1],true,'AIV0'+1)
        set party[2] = selectedHero[2]
        call SetHeroData(party[2],PARTY_INDEX,3)
        call UnitAddAbility(party[2],'AIV0'+2)
        call UnitMakeAbilityPermanent(party[2],true,'AIV0'+2)
        set party[3] = selectedHero[3]
        call SetHeroData(party[3],PARTY_INDEX,4)
        call UnitAddAbility(party[3],'AIV0'+3)
        call UnitMakeAbilityPermanent(party[3],true,'AIV0'+3)
        set party[4] = selectedHero[4]
        call SetHeroData(party[4],PARTY_INDEX,5)
        call UnitAddAbility(party[4],'AIV0'+4)
        call UnitMakeAbilityPermanent(party[4],true,'AIV0'+4)

        call DestroyEffectEX(selectionEffect[0])
        call DestroyEffectEX(selectionEffect[1])
        call DestroyEffectEX(selectionEffect[2])
        call DestroyEffectEX(selectionEffect[3])
        call DestroyEffectEX(selectionEffect[4])
        loop 
            exitwhen i > MAX_HERO_TYPE-1
            call PlaceUnselectedHeroScatteredImmediate.evaluate(hero[i],loadOtherHeroesRect)
            call SetUnitOwner(hero[i],PLAYER2,true)
            set i = i+1
        endloop 
        call RemoveUnit(hero[GetHeroIndex(selectedHero[0])-1])
        call RemoveUnit(hero[GetHeroIndex(selectedHero[1])-1])
        call RemoveUnit(hero[GetHeroIndex(selectedHero[2])-1])
        call RemoveUnit(hero[GetHeroIndex(selectedHero[3])-1])
        call RemoveUnit(hero[GetHeroIndex(selectedHero[4])-1])
        set hero[GetHeroIndex(selectedHero[0])-1] = selectedHero[0]
        set hero[GetHeroIndex(selectedHero[1])-1] = selectedHero[1]
        set hero[GetHeroIndex(selectedHero[2])-1] = selectedHero[2]
        set hero[GetHeroIndex(selectedHero[3])-1] = selectedHero[3]
        set hero[GetHeroIndex(selectedHero[4])-1] = selectedHero[4]
        set i = 0
        loop 
            exitwhen i > MAX_HERO_TYPE-1
            call SetHeroData(hero[i],"LEARNED_ABILITY_0",0)
            call SetHeroData(hero[i],"LEARNED_ABILITY_1",0)
            call SetHeroData(hero[i],"LEARNED_ABILITY_2",0)
            call SetHeroData(hero[i],"LEARNED_ABILITY_3",0)
            call SetHeroData(hero[i],"LEARNED_ABILITY_4",0)
            
            call CheckHeroLearnBook.evaluate(hero[i])
            set i = i+1
        endloop 

        set bag[0] = CreateUnit(PLAYER,'hBAG',GetUnitX(hero[0]),GetUnitY(hero[0]),0)
        set bag[1] = CreateUnit(NEUTRAL,'hBAG',GetUnitX(hero[0]),GetUnitY(hero[0]),0)
        set bag[2] = CreateUnit(NEUTRAL,'hBAG',GetUnitX(hero[0]),GetUnitY(hero[0]),0)
        set bag[3] = CreateUnit(NEUTRAL,'hBAG',GetUnitX(hero[0]),GetUnitY(hero[0]),0)
        set bag[4] = CreateUnit(NEUTRAL,'hBAG',GetUnitX(hero[0]),GetUnitY(hero[0]),0)
        set bag[5] = CreateUnit(NEUTRAL,'hBAG',GetUnitX(hero[0]),GetUnitY(hero[0]),0)
        set bag[6] = CreateUnit(NEUTRAL,'hBAG',GetUnitX(hero[0]),GetUnitY(hero[0]),0)
        set bag[7] = CreateUnit(NEUTRAL,'hBAG',GetUnitX(hero[0]),GetUnitY(hero[0]),0)

        set i = 0
        loop
            exitwhen i > 7
            call UnitAddAbility(bag[i],'Abg0'+i)
            call UnitAddAbility(bag[i],'ABG0'+ModuloInteger(i+1,8))
            call UnitAddAbility(bag[i],'ABG0'+ModuloInteger(i+2,8))
            call UnitAddAbility(bag[i],'ABG0'+ModuloInteger(i+3,8))
            call UnitAddAbility(bag[i],'ABG0'+ModuloInteger(i+4,8))
            call UnitAddAbility(bag[i],'ABG0'+ModuloInteger(i+5,8))
            call UnitAddAbility(bag[i],'ABG0'+ModuloInteger(i+6,8))
            call UnitAddAbility(bag[i],'ABG0'+ModuloInteger(i+7,8))
            set i = i+1
        endloop

        set i = 0
        loop 
            exitwhen i > MAX_HERO_TYPE-1
            set k = 0
            loop 
                exitwhen k > 4
                call SetHeroSelectedPublicTalent(hero[i],k,0)
                call SetHeroSelectedPrivateTalent(hero[i],k,0)
                set k = k+1
            endloop
            call SetHeroSelectedUltimateTalent(hero[i],0,0)
            call SetHeroSelectedUltimateTalent(hero[i],1,0)
            call unitCheckState.evaluate(hero[i])
            set i = i+1
        endloop

        call ShowUnit(party[0],true)
        call ShowUnit(party[1],true)
        call ShowUnit(party[2],true)
        call ShowUnit(party[3],true)
        call ShowUnit(party[4],true)
        call SelectUnitAdd(party[0])
        call SelectUnitAdd(party[1])
        call SelectUnitAdd(party[2])
        call SelectUnitAdd(party[3])
        call SelectUnitAdd(party[4])

        call SetCameraBoundsToRect(GetCameraBoundsMapRect())
        call ClearTextMessages()

        call SetUnitOwner(gg_unit_nzin_0013,Player(PLAYER_NEUTRAL_PASSIVE),false)

        call EnableTrigger(saveCampaignFiles)
        call mainQuest[0].accept()
        call save.execute()
        call DestroyTriggerEx(triggerConfirmSelection)
        call DestroyTriggerEx(triggerRepickHero)
        call DestroyTriggerEx(triggerResetSelection)
        call DestroyTriggerEx(triggerSelectHero)

        call SetCameraPosition(GetUnitX(party[0]),GetUnitY(party[0]))
        call TimerStart(CreateTimer(),3,false,function Hint1)
    endfunction
    function triggerRepickHero_Action takes nothing returns nothing
        call RemoveUnit(selectedHero[0])
        call RemoveUnit(selectedHero[1])
        call RemoveUnit(selectedHero[2])
        call RemoveUnit(selectedHero[3])
        call RemoveUnit(selectedHero[4])
        set selectedHero[0] = null 
        set selectedHero[1] = null 
        set selectedHero[2] = null 
        set selectedHero[3] = null 
        set selectedHero[4] = null 
        call DestroyEffectEX(selectionEffect[0])
        call DestroyEffectEX(selectionEffect[1])
        call DestroyEffectEX(selectionEffect[2])
        call DestroyEffectEX(selectionEffect[3])
        call DestroyEffectEX(selectionEffect[4])
        call GroupClear(groupSelectedHeroes)
        call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00现在你可以重新选择英雄了。|r")
    endfunction
    function initializePlayerData takes nothing returns nothing
        if GetStoredBoolean(gameCache,"DATAS","HAVE_SAVE_FILES") == false then 
            //call FlushGameCache(gameCache)
            call SetCameraPosition(GetRectCenterX(gg_rct_SelectingCameraRect),GetRectCenterY(gg_rct_SelectingCameraRect))
            call SetCameraBoundsToRect(gg_rct_SelectingCameraBound)
            call SetUnitOwner(gg_unit_nzin_0013,PLAYER,false)
            set enableBank = 0
            set hero[0] = gg_unit_HZ00_0001
            set hero[1] = gg_unit_HZ01_0000
            set hero[2] = gg_unit_HZ02_0004
            set hero[3] = gg_unit_HZ03_0003
            set hero[4] = gg_unit_HZ04_0007
            set hero[5] = gg_unit_HZ05_0006
            set hero[6] = gg_unit_HZ06_0008
            set hero[7] = gg_unit_HZ07_0009
            set hero[8] = gg_unit_HZ08_0005
            set hero[9] = gg_unit_HZ09_0012
            set hero[10] = gg_unit_HZ0A_0010
            set hero[11] = gg_unit_HZ0B_0011
            set hero[12] = gg_unit_HZ0C_0014
            set hero[13] = gg_unit_HZ0D_0015
            set hero[14] = gg_unit_HZ0E_0016
            set hero[15] = gg_unit_HZ0F_0065
            set bank[0] = gg_unit_hBNK_0046
            set bank[1] = gg_unit_hBNK_0054
            set bank[2] = gg_unit_hBNK_0055
            set bank[3] = gg_unit_hBNK_0071
            set bank[4] = gg_unit_hBNK_0072
            set bank[5] = gg_unit_hBNK_0073
            set bank[6] = gg_unit_hBNK_0074
            set bank[7] = gg_unit_hBNK_0075
            set armoury = gg_unit_hARM_0560
            call SetUnitX(armoury,loadArmouryX)
            call SetUnitY(armoury,loadArmouryY)
            call ShowUnit(bank[0],false)
            call ShowUnit(bank[1],false)
            call ShowUnit(bank[2],false)
            call ShowUnit(bank[3],false)
            call ShowUnit(bank[4],false)
            call ShowUnit(bank[5],false)
            call ShowUnit(bank[6],false)
            call ShowUnit(bank[7],false)
            call SetUnitX(bank[0],loadBankX[0])
            call SetUnitX(bank[1],loadBankX[1])
            call SetUnitX(bank[2],loadBankX[2])
            call SetUnitX(bank[3],loadBankX[3])
            call SetUnitX(bank[4],loadBankX[4])
            call SetUnitX(bank[5],loadBankX[5])
            call SetUnitX(bank[6],loadBankX[6])
            call SetUnitX(bank[7],loadBankX[7])
            call SetUnitY(bank[0],loadBankX[0])
            call SetUnitY(bank[1],loadBankX[1])
            call SetUnitY(bank[2],loadBankX[2])
            call SetUnitY(bank[3],loadBankX[3])
            call SetUnitY(bank[4],loadBankX[4])
            call SetUnitY(bank[5],loadBankX[5])
            call SetUnitY(bank[6],loadBankX[6])
            call SetUnitY(bank[7],loadBankX[7])
            call UnitRemoveAbility(bank[0],'Amov')
            call UnitRemoveAbility(bank[1],'Amov')
            call UnitRemoveAbility(bank[2],'Amov')
            call UnitRemoveAbility(bank[3],'Amov')
            call UnitRemoveAbility(bank[4],'Amov')
            call UnitRemoveAbility(bank[5],'Amov')
            call UnitRemoveAbility(bank[6],'Amov')
            call UnitRemoveAbility(bank[7],'Amov')
            call UnitRemoveAbility(armoury,'Amov')
            set selectedHero[0] = null 
            set selectedHero[1] = null 
            set selectedHero[2] = null 
            set selectedHero[3] = null 
            set selectedHero[4] = null 
            call DisableTrigger(saveCampaignFiles)
            call TriggerRegisterPlayerSelectionEventBJ(triggerSelectHero,PLAYER,true)
            call TriggerAddActionEx(triggerSelectHero,function triggerSelectHero_Action)
            call TriggerRegisterPlayerEventEndCinematic(triggerRepickHero,PLAYER)
            call TriggerAddActionEx(triggerRepickHero,function triggerRepickHero_Action)
            call DialogSetMessage(dialogConfirmSelection,"是否以当前阵容开始游戏？")
            call TriggerRegisterDialogButtonEvent(triggerConfirmSelection,btnConfirmSelection)
            call TriggerAddActionEx(triggerConfirmSelection,function triggerConfirmSelection_Action)
            call TriggerRegisterDialogButtonEvent(triggerResetSelection,btnResetSelection)
            call TriggerAddActionEx(triggerResetSelection,function triggerRepickHero_Action)
            call SetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_GOLD,0)
            call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffffcc00双击英雄进行选择。\n\n你需要选择五名英雄组成队伍。\n\n在稍后的游戏进程中，你可以随时更换队伍中的英雄。|r")
            set enableBank = 0
        else 
            call RemoveUnit(gg_unit_HZ00_0001)
            call RemoveUnit(gg_unit_HZ01_0000)
            call RemoveUnit(gg_unit_HZ02_0004)
            call RemoveUnit(gg_unit_HZ03_0003)
            call RemoveUnit(gg_unit_HZ04_0007)
            call RemoveUnit(gg_unit_HZ05_0006)
            call RemoveUnit(gg_unit_HZ06_0008)
            call RemoveUnit(gg_unit_HZ07_0009)
            call RemoveUnit(gg_unit_HZ08_0005)
            call RemoveUnit(gg_unit_HZ09_0012)
            call RemoveUnit(gg_unit_HZ0A_0010)
            call RemoveUnit(gg_unit_HZ0B_0011)
            call RemoveUnit(gg_unit_HZ0C_0014)
            call RemoveUnit(gg_unit_HZ0D_0015)
            call RemoveUnit(gg_unit_HZ0E_0016)
            call RemoveUnit(gg_unit_HZ0F_0065)
            call RemoveUnit(gg_unit_hBNK_0046)
            call RemoveUnit(gg_unit_hBNK_0054)
            call RemoveUnit(gg_unit_hBNK_0055)
            call RemoveUnit(gg_unit_hBNK_0071)
            call RemoveUnit(gg_unit_hBNK_0072)
            call RemoveUnit(gg_unit_hBNK_0073)
            call RemoveUnit(gg_unit_hBNK_0074)
            call RemoveUnit(gg_unit_hBNK_0075)
            call RemoveUnit(gg_unit_hARM_0560)
        endif 
    endfunction
    function initNPCDatas takes nothing returns nothing
        set mainQuest[0].owner = gg_unit_hN00_0037
        set mainQuest[1].owner = gg_unit_hN00_0037
        set mainQuest[1].anotherOwner = gg_unit_hN04_0082
        set mainQuest[2].owner = gg_unit_hN00_0037
        set mainQuest[3].owner = gg_unit_hN00_0037
        set mainQuest[4].owner = gg_unit_hN00_0037
        set mainQuest[5].owner = gg_unit_hN00_0037
        set mainQuest[6].owner = gg_unit_hN09_0028
        set mainQuest[6].anotherOwner = gg_unit_hN0B_0202
        set mainQuest[7].owner = gg_unit_hN0D_0542
        set mainQuest[7].anotherOwner = gg_unit_hN0E_0543
        set mainQuest[8].owner = gg_unit_hN0E_0543
        set mainQuest[9].owner = gg_unit_hN0F_0548
        set mainQuest[10].owner = gg_unit_hN0E_0543
        set mainQuest[11].owner = gg_unit_hN0D_0542
        set mainQuest[11].anotherOwner = gg_unit_hN0M_0992
        set mainQuest[12].owner = gg_unit_hN0D_0542
        set mainQuest[12].anotherOwner = gg_unit_hN0E_1271
        set mainQuest[13].owner = gg_unit_hN0E_1271
        set mainQuest[14].owner = gg_unit_hN0E_1271
        set mainQuest[15].owner = gg_unit_hN0E_1271
        set mainQuest[16].owner = gg_unit_hN0E_1271
        set mainQuest[16].anotherOwner = gg_unit_hN0M_0992

        call QuestAddDialog(mainQuest[6].anotherOwner,'IK0K',0)
        call ShowUnit(mainQuest[6].owner,false)

        set sideQuest[0].owner = gg_unit_hN06_0158
        call QuestAddDialog(sideQuest[0].owner,'IQ00',1)
        call NPC.addExclamation_Y(sideQuest[0].owner)

        set sideQuest[1].owner = gg_unit_hN05_0085
        call QuestAddDialog(sideQuest[1].owner,'IQ03',1)
        call NPC.addExclamation_Y(sideQuest[1].owner)
        set sideQuest[2].owner = gg_unit_hN05_0085

        set sideQuest[3].owner = gg_unit_hN08_0160
        set sideQuest[3].anotherOwner = gg_unit_hN07_0159
        call QuestAddDialog(sideQuest[3].owner,'IQ09',1)
        call NPC.addExclamation_Y(sideQuest[3].owner)
        set sideQuest[4].owner = gg_unit_hN0U_0970
        set sideQuest[5].owner = gg_unit_hN0F_0548
        set sideQuest[5].anotherOwner = gg_unit_hN0J_0567

        set sideQuest[6].owner = gg_unit_hN0R_0641
        call QuestAddDialog(sideQuest[6].owner,'IQ0I',1)
        call NPC.addExclamation_Y(sideQuest[6].owner)
        set sideQuest[7].owner = gg_unit_hN0R_0641

        set sideQuest[8].owner = gg_unit_hN0V_0997
        call QuestAddDialog(sideQuest[8].owner,'IQ0O',1)
        call NPC.addExclamation_Y(sideQuest[8].owner)

        set sideQuest[9].owner = gg_unit_hN0R_0641
        set sideQuest[9].anotherOwner = gg_unit_hN10_1239

        set sideQuest[10].owner = gg_unit_hN0M_0992
        set sideQuest[10].anotherOwner = gg_unit_hN11_1152

        set sideQuest[11].owner = gg_unit_hN1C_1378
        set sideQuest[12].owner = gg_unit_hN1D_1379

        set sideQuest[13].owner = gg_unit_hN0D_0542
        set sideQuest[13].anotherOwner = gg_unit_hN0R_0641

        set sideQuest[14].owner = gg_unit_hN0R_0641
        set sideQuest[14].anotherOwner = gg_unit_hN0D_0542

        set sideQuest[15].owner = gg_unit_hN11_1152
        set sideQuest[16].owner = gg_unit_hN11_1152
        set sideQuest[17].owner = gg_unit_hN11_1152
        set sideQuest[17].anotherOwner = gg_unit_hN14_1240
        set sideQuest[18].owner = gg_unit_hN14_1240
        set sideQuest[19].owner = gg_unit_hN14_1240
        set sideQuest[20].owner = gg_unit_hN14_1240

        set sideQuest[21].owner = gg_unit_hN13_1168
        set sideQuest[22].owner = gg_unit_hN13_1168
        set sideQuest[23].owner = gg_unit_hN13_1168
        set sideQuest[24].owner = gg_unit_hN13_1168

        set sideQuest[25].owner = gg_unit_hN1G_1383
        set sideQuest[25].anotherOwner = gg_unit_hN1J_1399

        set sideQuest[26].owner = gg_unit_hN1I_1395
        set sideQuest[27].owner = gg_unit_hN1K_1400

        set repeatableQuest[0].owner = gg_unit_hN0U_0970
        set repeatableQuest[1].owner = gg_unit_hN0E_1271
        set repeatableQuest[2].owner = gg_unit_hN1G_1383

        set bankManager = gg_unit_hN1H_1394

        call SetDestructableInvulnerable(gg_dest_LOcg_3895,true)    
        call SetUnitAnimation(gg_unit_hN0W_1016,"attack")   

        call SetUnitState(sideQuest[9].anotherOwner,UNIT_STATE_LIFE,1)
        call SetUnitAnimation(sideQuest[9].anotherOwner,"death") 
        call ShowUnit(sideQuest[9].anotherOwner,false)  

        call ShowUnit(gg_unit_hN0M_0992,false)
        
        call GroupClear(allInns)
        call GroupEnumUnitsInRect(allInns,wholeMapRect,isInnSelected)
        call ForGroup(allInns,function resetInnsSelected)
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 0 then 
            call SetUnitOwner(gg_unit_ugol_0566,Player(2),true)
        elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 1 then 
            call SetUnitOwner(gg_unit_ugol_0565,Player(2),true)
        elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 2 then 
            call SetUnitOwner(gg_unit_ugol_0649,Player(2),true)
        elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 3 then 
            call SetUnitOwner(gg_unit_ugol_1382,Player(2),true)
        endif 
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"ENTER") == 0 then 
            if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 0 then 
                set loadPartyRect = gg_rct_Home00
            elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 1 then 
                set loadPartyRect = gg_rct_Home01
            elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 2 then 
                set loadPartyRect = gg_rct_Home02
            elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 3 then 
                set loadPartyRect = gg_rct_Home03
            endif 
        else
            if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"ENTER") == 1 then 
                set loadPartyRect = gg_rct_LeaveDungeon0
            elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"ENTER") == 2 then 
                set loadPartyRect = gg_rct_LeaveDungeon1
            elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"ENTER") == 3 then 
                set loadPartyRect = gg_rct_LeaveDesert
            elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"ENTER") == 4 then 
                set loadPartyRect = gg_rct_LeaveDungeon2
            elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"ENTER") == 5 then 
                set loadPartyRect = gg_rct_LeaveDungeon3
            endif 
        endif 
        call GroupEnumUnitsInRect(CinematicGroup1,gg_rct_CinematicArea1,null )
        call ForGroup(CinematicGroup1,function CinematicFunc1_0)

        call EnumDestructablesInRectAll(gg_rct_CinematicArea1,function CinematicFunc2_0)
    endfunction
    function initEnvironment takes nothing returns nothing
        local real x 
        local real y 
        local real f 
        local delayedevent de 
        local integer i = 0
        //////////////////
        set Necromancer1 = GetEnemyFromUnit( gg_unit_n60O_0618 )
        set Necromancer2 = GetEnemyFromUnit( gg_unit_n60O_0620 )
        set Necromancer3 = GetEnemyFromUnit( gg_unit_n60O_0616 )
        set NecromancerElite = GetEnemyFromUnit( gg_unit_n614_0127 )
        set Gargoyle1 = GetEnemyFromUnit( gg_unit_n613_0628 )
        set Gargoyle2 = GetEnemyFromUnit( gg_unit_n613_0635 )
        set Gargoyle3 = GetEnemyFromUnit( gg_unit_n613_0629 )
        set Gargoyle4 = GetEnemyFromUnit( gg_unit_n613_0634 )
        set Gargoyle5 = GetEnemyFromUnit( gg_unit_n613_0633 )
        set Gargoyle6 = GetEnemyFromUnit( gg_unit_n613_0636 )
        set Gargoyle7 = GetEnemyFromUnit( gg_unit_n613_0632 )
        call SetUnitAnimation(Necromancer1.u,"stand channel")
        call SetUnitAnimation(Necromancer2.u,"stand channel")
        call SetUnitAnimation(Necromancer3.u,"stand channel")
        call SetUnitX(NecromancerElite.u,5824)
        call SetUnitY(NecromancerElite.u,-20352)
        set Region_Fire1 = CreateRegion()
        call RegionAddRect(Region_Fire1,gg_rct_Fire1)
        set Region_Fire2 = CreateRegion()
        call RegionAddRect(Region_Fire2,gg_rct_Fire2)
        set Region_Fire3 = CreateRegion()
        call RegionAddRect(Region_Fire3,gg_rct_Fire3)
        set Region_Fire4 = CreateRegion()
        call RegionAddRect(Region_Fire4,gg_rct_Fire4)
        //////////////////
        set de = delayedevent.create(200,0,function CAMP_FIRE_REGEN_PIG_0)
        call de.saveUnit("CASTER",gg_unit_hDMY_0972)
        //////////////////
        if mainQuest[5].state == QUEST_STATE_COMPLETED or mainQuest[5].checkCompletion() then 
            call EnumDestructablesInRectAll(gg_rct_QuestZone00,function QuestTrig1_Action_Des_Pick_EX)
        endif 
        if mainQuest[3].obj1.completed and mainQuest[3].obj2.completed == false and mainQuest[3].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[3].fail()
        endif 
        if mainQuest[9].obj1.completed == false and mainQuest[9].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[9].fail()
        endif 
        if mainQuest[9].checkCompletion() then 
            call SetDoodadAnimationRect(gg_rct_Fire1,'D624',"death",false)
            call SetDoodadAnimationRect(gg_rct_Fire2,'D624',"death",false)
            call SetDoodadAnimationRect(gg_rct_Fire3,'D624',"death",false)
            call SetDoodadAnimationRect(gg_rct_Fire4,'D624',"death",false)
        endif 
        if mainQuest[6].checkCompletion() then 
            call GetGateFromDestructable(gg_dest_B606_4702).enable()
            call GetGateFromDestructable(gg_dest_YTcx_5006).enable()
            call GetGateFromDestructable(gg_dest_YTcx_4703).enable()
            call GetGateFromDestructable(gg_dest_YTce_5005).enable()
            call GetGateFromDestructable(gg_dest_YTce_4701).enable()
        endif 
        if mainQuest[7].state == QUEST_STATE_COMPLETED then 
            call KillDestructable( gg_dest_LTba_8952 )
            call KillDestructable( gg_dest_LTba_8951 )
            call KillDestructable( gg_dest_LTba_8942 )
            call KillDestructable( gg_dest_LTba_8941 )
            call KillDestructable( gg_dest_LTba_8939 )
            call KillDestructable( gg_dest_LTba_8940 )
            call KillDestructable( gg_dest_LTba_8950 )
            call KillDestructable( gg_dest_LTba_8949 )
        endif 
        if mainQuest[8].state == QUEST_STATE_COMPLETED then 
            set Necromancer1.needRespawn = false
            set Necromancer2.needRespawn = false
            set Necromancer3.needRespawn = false
            call KillUnit(Necromancer1.u)
            call KillUnit(Necromancer2.u)
            call KillUnit(Necromancer3.u)
        endif 
        if mainQuest[10].state != QUEST_STATE_UNKNOWN then 
            call KillDestructable( gg_dest_Dofv_17621 )
            call KillDestructable( gg_dest_Dofv_17622 )
            call KillDestructable( gg_dest_Dofv_17623 )
        endif 
        if mainQuest[10].state == QUEST_STATE_COMPLETED then 
            set NecromancerElite.needRespawn = false
            call KillUnit(NecromancerElite.u)
            set Gargoyle1.needRespawn = false
            call KillUnit(Gargoyle1.u)
            set Gargoyle2.needRespawn = false
            call KillUnit(Gargoyle2.u)
            set Gargoyle3.needRespawn = false
            call KillUnit(Gargoyle3.u)
            set Gargoyle4.needRespawn = false
            call KillUnit(Gargoyle4.u)
            set Gargoyle5.needRespawn = false
            call KillUnit(Gargoyle5.u)
            set Gargoyle6.needRespawn = false
            call KillUnit(Gargoyle6.u)
            set Gargoyle7.needRespawn = false
            call KillUnit(Gargoyle7.u)
        endif 
        if sideQuest[7].state == QUEST_STATE_COMPLETED then 
            call ShowUnit(sideQuest[9].anotherOwner,true)
            call QuestAddDialog(sideQuest[9].anotherOwner,'iq09',1)
        endif 
        if mainQuest[12].state != QUEST_STATE_NONE then 
            call ForGroup(CinematicGroup1,function CinematicFunc1_1)
            call EnumDestructablesInRectAll(gg_rct_CinematicArea1,function CinematicFunc2_1)
        endif 
        if mainQuest[14].obj1.completed then 
            call SetDoodadAnimationRect(gg_rct_Zigguratb,'D63W',"death",false)
            call PauseTimer(timerCloseZigguratB)
        endif 
        if mainQuest[14].obj2.completed then 
            call SetDoodadAnimationRect(gg_rct_Ziggurata,'D63W',"death",false)
            call PauseTimer(timerCloseZigguratA)
        endif 
        if mainQuest[14].state == QUEST_STATE_COMPLETED then 
            call GetGateFromDestructable(gg_dest_Dofv_27618).letOpen()
            call GetGateFromDestructable(gg_dest_Dofv_27619).letOpen()
            call GetGateFromDestructable(gg_dest_Dofv_27620).letOpen()
            call GetGateFromDestructable(gg_dest_Dofv_27621).letOpen()
        endif 
        /////////////////
        if mainQuest[11].state == QUEST_STATE_COMPLETED then 
            call SetPlayerTechResearched(Player(1),'R600',1)
        endif 
        if mainQuest[15].state == QUEST_STATE_COMPLETED then 
            call SetPlayerTechResearched(Player(1),'R601',1)
        endif 
        if mainQuest[16].state == QUEST_STATE_COMPLETED then 
            set x = GetUnitX(gg_unit_hN0N_0630)
            set y = GetUnitY(gg_unit_hN0N_0630)
            set f = GetUnitFacing(gg_unit_hN0N_0630)
            call RemoveUnit(gg_unit_hN0N_0630)
            call CreateUnit(Player(1),'hN1A',x,y,f)
        endif 
        if sideQuest[20].state == QUEST_STATE_COMPLETED then 
            call SetPlayerTechResearched(Player(2),'R602',1)
        endif 
        /////////////////
        call AddUnitAnimationProperties(gg_unit_hAVT_0249,"alternate",true)
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_1") > 0 then 
            call DisableTrigger(unlockReviveStone1)
            call SetUnitOwner(gg_unit_hAVT_0561,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0561,"alternate",true)
        endif 
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_2") > 0 then 
            call DisableTrigger(unlockReviveStone2)
            call SetUnitOwner(gg_unit_hAVT_0562,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0562,"alternate",true)
        endif 
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_3") > 0 then 
            call DisableTrigger(unlockReviveStone3)
            call SetUnitOwner(gg_unit_hAVT_0563,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0563,"alternate",true)
        endif 
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_4") > 0 then 
            call DisableTrigger(unlockReviveStone4)
            call SetUnitOwner(gg_unit_hAVT_0564,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0564,"alternate",true)
        endif 
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_5") > 0 then 
            call DisableTrigger(unlockReviveStone5)
            call SetUnitOwner(gg_unit_hAVT_1339,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_1339,"alternate",true)
        endif 
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_6") > 0 then 
            call DisableTrigger(unlockReviveStone6)
            call SetUnitOwner(gg_unit_hAVT_1420,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_1420,"alternate",true)
        endif 
        /////////////////
        call TriggerRegisterUnitInRange(unlockArmoury,armoury,300,null)
        call TriggerAddAction(unlockArmoury,function Hint5)
        /////////////////
        set i = 0
        loop 
            exitwhen i > 7
            if enableBank > i then 
                call ShowUnit(bank[i],true)
            endif   
            set i = i+1
        endloop
        set i = 0
        loop 
            exitwhen i > MAX_HERO_TYPE-1
            if GetPartyIndex(hero[i]) == -1 then 
                call ShowUnit(hero[i],true)
            endif 
            set i = i+1
        endloop
        call ShowUnit(armoury,true)

        set enterDungeon00 = CreateEntrance(gg_rct_EnterDungeon0,"监狱","DUNGEON00.w3m",0,100)
        if GetStoredInteger(gameCache,"KEY",KEY_DUNGEON_JAIL) == 1 then 
            set enterDungeon00.active = true
        else 
            set enterDungeon00.active = false 
        endif 
        set enterDungeon01 = CreateEntrance(gg_rct_EnterDungeon1,"大墓地阿纳克提斯","DUNGEON01.w3m",0,101)
        if GetStoredInteger(gameCache,"KEY",KEY_DUNGEON_NECROPOLIS) == 1 then 
            set enterDungeon01.active = true
        else 
            set enterDungeon01.active = false 
        endif 
        set enterDungeon02 = CreateEntrance(gg_rct_EnterDungeon2,"远古圣所","DUNGEON02.w3m",0,102)
        if GetStoredInteger(gameCache,"KEY",KEY_DUNGEON_SANCTUM) == 1 then 
            set enterDungeon02.active = true
        else 
            set enterDungeon02.active = false 
        endif 
        set enterDungeon04 = CreateEntranceSimple("蓝冰峡谷","DUNGEON04.w3m",0,104)
        set enterDungeon04.active = true

        set enterDesert = CreateEntrance(gg_rct_EnterDesert,"广大荒漠","DESERT.w3m",1,2)
        if GetStoredInteger(gameCache,"KEY",KEY_MAP_DESERT) == 1 then 
            set enterDesert.active = true
        else 
            set enterDesert.active = false 
        endif 
        
        call ResourceType.register('hPH0', 'hMH0', 'IMH0', 6)  // 野钢花
        call ResourceType.register('hPH1', 'hMH1', 'IMH1', 6)  // 墓地苔
        call ResourceType.register('hPH2', 'hMH2', 'IMH2', 6)  // 荆棘藻
        call ResourceType.register('hPH9', 'hMH9', 'IMH9', 1)  // 黑莲花

        call ResourceType.register('hPO0', 'hMO0', 'IMO0', 7)  // 铁矿

        call ResourceType.register('hPC0', 'hMC0', 0, 1)  // 宝箱
        //==================================================
        // region scope BossHellBringer
        //==================================================
        call BossHellBringer_bossGateAdd.evaluate( gg_dest_Dofw_21946 )
        call BossHellBringer_bossGateAdd.evaluate( gg_dest_Dofw_21947 )
        call BossHellBringer_bossGateAdd.evaluate( gg_dest_Dofw_27601 )
        call BossHellBringer_bossGateAdd.evaluate( gg_dest_Dofw_27602 )
        call BossHellBringer_bossGateAdd.evaluate( gg_dest_Dofw_27603 )
        call BossHellBringer_bossGateAdd.evaluate( gg_dest_Dofw_21949 )
        call BossHellBringer_bossGateAdd.evaluate( gg_dest_Dofw_21948 )
        call BossHellBringer_bossGateAdd.evaluate( gg_dest_Dofw_22035 )
        call BossHellBringer_bossGateAdd.evaluate( gg_dest_Dofw_22036 )
        call BossHellBringer_bossGateAdd.evaluate( gg_dest_Dofw_22038 )
        call BossHellBringer_boss.setRect(gg_rct_BossHellBringerArea)
        call BossHellBringer_boss.addSpawn(BossHellBringer_bossUnitId,5876,-7877,315)
        set  BossHellBringer_boss.autoReset = false 
        //call BossHellBringer_boss.initialize()
        
        call BossHellBringer_boss.regionAddRect(gg_rct_BossHellBringerArea)
        call BossHellBringer_boss.bindOnReset(function ResetBossHellBringer)
        call BossHellBringer_boss.bindOnDefeat(function DefeatBossHellBringer)
        //===================================================
        // endregion
        //===================================================
        if GetStoredInteger(gameCache,"DATAS","HINT_SWAP") != 0 then 
            call UnitShareVision(gg_unit_nzin_1337,PLAYER,true)
            call UnitShareVision(gg_unit_nzin_1338,PLAYER,true)
        endif 
    endfunction
    private function init takes nothing returns nothing
        local real loadBankLeftX = 15024
        local real loadBankTopY = -20976
        local real loadBankDis = 96

        set HERO_TOOLTIP[0]  = "|cffffcc00先锋|r\n|cffadadff英雄职责：|r坦克\n|cffadadff使用难度：|r★\n\n先锋是队伍的铁壁，擅于冲锋陷阵，为团队吸收伤害。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[1]  = "|cffffcc00圣骑士|r\n|cffadadff英雄职责：|r坦克/治疗者\n|cffadadff使用难度：|r★★★☆\n\n圣骑士善于利用圣光防御或治疗盟友，并能使用强大的祝福和光环法术来为团队提供援助。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[2]  = "|cffffcc00角斗士|r\n|cffadadff英雄职责：|r伤害输出\n|cffadadff使用难度：|r★★★\n\n角斗士的攻击势大力沉，可以劈开敌人的护甲，令敌人流血和受伤。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[3]  = "|cffffcc00机械师|r\n|cffadadff英雄职责：|r伤害输出\n|cffadadff使用难度：|r★\n\n机械师善于灵活使用符文弹药和枪械技艺，支援队友并重创敌人。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[4]  = "|cffffcc00巡林人|r\n|cffadadff英雄职责：|r伤害输出\n|cffadadff使用难度：|r★☆\n\n巡林人是出色的射手和驯兽师，擅长从远距离向敌人倾泻弹药，配合动物伙伴消灭敌人。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[5]  = "|cffffcc00刺客|r\n|cffadadff英雄职责：|r伤害输出\n|cffadadff使用难度：|r★★★★★\n\n刺客擅长在背后偷袭敌人，拥有最为强大的机动和爆发能力，但脆弱的她亟需队友的保护。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[6]  = "|cffffcc00法师|r\n|cffadadff英雄职责：|r伤害输出\n|cffadadff使用难度：|r★\n\n法师精于冰霜魔法，擅长控制敌人并施展对群攻击。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[7]  = "|cffffcc00牧师|r\n|cffadadff英雄职责：|r治疗者/伤害输出\n|cffadadff使用难度：|r★☆\n\n牧师可以施展圣光之力，作为团队中可靠的治疗者；或是施展暗影魔法，侵蚀并消灭敌人。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[8]  = "|cffffcc00德鲁伊|r\n|cffadadff英雄职责：|r坦克/治疗者/伤害输出\n|cffadadff使用难度：|r★★★★\n\n德鲁伊可以化作各种形态来适应不同的角色定位，是团队中的多面手。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[9]  = "|cffffcc00死亡骑士|r\n|cffadadff英雄职责：|r坦克/伤害输出\n|cffadadff使用难度：|r★★★★\n\n死亡骑士可以使用不同的灵气来适应战场，用她邪恶的魔法保护自己或是残忍地终结她的敌人。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[10] = "|cffffcc00魔战士|r\n|cffadadff英雄职责：|r坦克/伤害输出\n|cffadadff使用难度：|r★★★\n\n魔战士精通反制魔法的技巧，可以活用奥术魔法沉默或是驱散他的敌人，以减少来自魔法的威胁。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[11] = "|cffffcc00贤者|r\n|cffadadff英雄职责：|r治疗者/伤害输出\n|cffadadff使用难度：|r★★★\n\n贤者可以召唤元素之力并可以使用图腾法术，治愈他的盟友，或是撕裂他的敌人。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[12] = "|cffffcc00魔巫|r\n|cffadadff英雄职责：|r伤害输出\n|cffadadff使用难度：|r★★☆\n\n魔巫会使用黑暗魔法，召唤亡灵、邪火或是恶魔粉碎他的敌人。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[13] = "|cffffcc00恶魔猎手|r\n|cffadadff英雄职责：|r坦克/伤害输出\n|cffadadff使用难度：|r★★★☆\n\n恶魔猎手是经历过残酷训练的暗夜精灵战士，以灵巧的战斗风格和邪能的力量支援队友并歼灭敌人。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[14] = "|cffffcc00武僧|r\n|cffadadff英雄职责：|r坦克/治疗者/伤害输出\n|cffadadff使用难度：|r★★★\n\n武僧修习真气武道，可以使用各种武技和道法支援队友并攻击敌人。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"
        set HERO_TOOLTIP[15] = "|cffffcc00女巫|r\n|cffadadff英雄职责：|r伤害输出\n|cffadadff使用难度：|r★★★☆\n\n女巫是使用火焰魔法的大师，拥有强大的爆发能力，但极度依赖法力。\n\n|cffffcc00双击选择英雄，按ESC重置选择|r"

        /*
        set HERO_TOOLTIP[0]  = "|cffffcc00Vanguard|r\n|cffadadffHero Role:|r Tank\n|cffadadffDifficulty:|r ★\n\nThe Vanguard is the team's bulwark, excelling at charging into the fray and absorbing damage for the party.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[1]  = "|cffffcc00Paladin|r\n|cffadadffHero Role:|r Tank / Healer\n|cffadadffDifficulty:|r ★★★☆\n\nThe Paladin uses holy light to defend or heal allies, and bolsters the team with powerful blessings and auras.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[2]  = "|cffffcc00Gladiator|r\n|cffadadffHero Role:|r Damage Dealer\n|cffadadffDifficulty:|r ★★★\n\nThe Gladiator's attacks are heavy and devastating, able to shred armor and cause bleeding and wounds.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[3]  = "|cffffcc00Mechanist|r\n|cffadadffHero Role:|r Damage Dealer\n|cffadadffDifficulty:|r ★\n\nThe Mechanist is adept at using runic ammunition and gunsmith skills to support allies and deal heavy damage.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[4]  = "|cffffcc00Ranger|r\n|cffadadffHero Role:|r Damage Dealer\n|cffadadffDifficulty:|r ★☆\n\nThe Ranger is a master archer and beast tamer, unleashing barrages from afar and coordinating with animal companions to eliminate foes.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[5]  = "|cffffcc00Assassin|r\n|cffadadffHero Role:|r Damage Dealer\n|cffadadffDifficulty:|r ★★★★★\n\nThe Assassin specializes in backstabbing enemies, boasting supreme mobility and burst potential, yet her fragility calls for protection from allies.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[6]  = "|cffffcc00Mage|r\n|cffadadffHero Role:|r Damage Dealer\n|cffadadffDifficulty:|r ★\n\nThe Mage is a master of frost magic, excelling at crowd control and area-of-effect attacks.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[7]  = "|cffffcc00Priest|r\n|cffadadffHero Role:|r Healer / Damage Dealer\n|cffadadffDifficulty:|r ★☆\n\nThe Priest wields holy light as a reliable healer, or turns to shadow magic to erode and destroy enemies.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[8]  = "|cffffcc00Druid|r\n|cffadadffHero Role:|r Tank / Healer / Damage Dealer\n|cffadadffDifficulty:|r ★★★★\n\nThe Druid can shapeshift into various forms to adapt to different roles, a true all-rounder for the team.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[9]  = "|cffffcc00Death Knight|r\n|cffadadffHero Role:|r Tank / Damage Dealer\n|cffadadffDifficulty:|r ★★★★\n\nThe Death Knight employs different presences to suit the battlefield, using unholy magic to protect herself or ruthlessly terminate enemies.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[10] = "|cffffcc00Spellblade|r\n|cffadadffHero Role:|r Tank / Damage Dealer\n|cffadadffDifficulty:|r ★★★\n\nThe Spellblade is skilled in counter-magic, utilizing arcane arts to silence or dispel enemies, reducing magical threats.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[11] = "|cffffcc00Sage|r\n|cffadadffHero Role:|r Healer / Damage Dealer\n|cffadadffDifficulty:|r ★★★\n\nThe Sage summons elemental forces and employs totemic spells to heal allies or rend enemies.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[12] = "|cffffcc00Warlock|r\n|cffadadffHero Role:|r Damage Dealer\n|cffadadffDifficulty:|r ★★☆\n\nThe Warlock commands dark magic, summoning undead, fel fire, or demons to crush foes.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[13] = "|cffffcc00Demon Hunter|r\n|cffadadffHero Role:|r Tank / Damage Dealer\n|cffadadffDifficulty:|r ★★★☆\n\nThe Demon Hunter is a fiercely trained night elf warrior, blending agile combat and fel energy to support allies and annihilate enemies.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[14] = "|cffffcc00Monk|r\n|cffadadffHero Role:|r Tank / Healer / Damage Dealer\n|cffadadffDifficulty:|r ★★★\n\nThe Monk practices martial arts and chi techniques, using various combat moves and spells to aid allies and strike foes.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        set HERO_TOOLTIP[15] = "|cffffcc00Witch|r\n|cffadadffHero Role:|r Damage Dealer\n|cffadadffDifficulty:|r ★★★☆\n\nThe Witch is a master of fire magic, possessing overwhelming burst power but heavily reliant on mana.\n\n|cffffcc00Double-click to select hero, press ESC to reset selection|r"
        */
        set loadBankX[0] = loadBankLeftX+loadBankDis*0
        set loadBankY[0] = loadBankTopY-loadBankDis*0
        set loadBankX[1] = loadBankLeftX+loadBankDis*1
        set loadBankY[1] = loadBankTopY-loadBankDis*0
        set loadBankX[2] = loadBankLeftX+loadBankDis*2
        set loadBankY[2] = loadBankTopY-loadBankDis*0
        set loadBankX[3] = loadBankLeftX+loadBankDis*3
        set loadBankY[3] = loadBankTopY-loadBankDis*0
        set loadBankX[4] = loadBankLeftX+loadBankDis*0
        set loadBankY[4] = loadBankTopY-loadBankDis*1
        set loadBankX[5] = loadBankLeftX+loadBankDis*1
        set loadBankY[5] = loadBankTopY-loadBankDis*1
        set loadBankX[6] = loadBankLeftX+loadBankDis*2
        set loadBankY[6] = loadBankTopY-loadBankDis*1
        set loadBankX[7] = loadBankLeftX+loadBankDis*3
        set loadBankY[7] = loadBankTopY-loadBankDis*1
        set loadArmouryX = 15472
        set loadArmouryY = -20976
        set loadPartyRect = gg_rct_Home00
        set loadOtherHeroesRect = gg_rct_inn
        call delayedevent.create(1,1,function initNPCDatas)
        call delayedevent.create(5,1,function initializePlayerData)
        call delayedevent.create(10,1,function initEnvironment)

        call AutomaticGate.create( gg_dest_B606_5007,"death alternate" )
        call AutomaticGate.create( gg_dest_B606_4702,"death alternate" ).disable()
        call AutomaticGate.create( gg_dest_YTcx_5006,"death alternate" ).disable()
        call AutomaticGate.create( gg_dest_YTcx_4703,"death alternate" ).disable()
        call AutomaticGate.create( gg_dest_YTce_5005,"death alternate" ).disable()
        call AutomaticGate.create( gg_dest_YTce_4701,"death alternate" ).disable()
        call AutomaticGate.create( gg_dest_B622_7075,"death" ).addBlocker( gg_dest_B600_15244 )
        call AutomaticGate.create( gg_dest_B622_7077,"death" ).addBlocker( gg_dest_B600_15245 )

        call AutomaticGate.create( gg_dest_Dofv_27618,"death" ).disable()
        call AutomaticGate.create( gg_dest_Dofv_27620,"death" ).disable()
        call AutomaticGate.create( gg_dest_Dofv_27619,"death" ).disable()
        call AutomaticGate.create( gg_dest_Dofv_27621,"death" ).disable()
        call GetGateFromDestructable(gg_dest_Dofv_27618).letClose()
        call GetGateFromDestructable(gg_dest_Dofv_27619).letClose()
        call GetGateFromDestructable(gg_dest_Dofv_27620).letClose()
        call GetGateFromDestructable(gg_dest_Dofv_27621).letClose()

        call DestructableRestoreLife( gg_dest_Dofv_17621,500,false )
        call SetDestructableAnimation( gg_dest_Dofv_17621,"stand")
        call DestructableRestoreLife( gg_dest_Dofv_17622,500,false )
        call SetDestructableAnimation( gg_dest_Dofv_17622,"stand")
        call DestructableRestoreLife( gg_dest_Dofv_17623,500,false )
        call SetDestructableAnimation( gg_dest_Dofv_17623,"stand")

        call SetDestructableAnimationSpeed( gg_dest_B62D_8850 ,0)
        call SetDestructableAnimationSpeed( gg_dest_B62G_14838 ,0)

        call TriggerRegisterPlayerSelectionEventBJ(swapHero_OutInn,PLAYER,true)
        call TriggerAddAction(swapHero_OutInn,function OutInnAction)
        call TriggerRegisterEnterRectSimple(swapHero_EnterInn,gg_rct_EnterInn)
        call TriggerAddAction(swapHero_EnterInn,function EnterInnAction)
    endfunction
endlibrary

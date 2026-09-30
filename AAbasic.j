
    globals
        string ssss = "                                  !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_'abcdefghijklmnopqrstuvwxyz{|}~"
        constant player PLAYER = Player(0)
        constant player NEUTRAL = Player(PLAYER_NEUTRAL_PASSIVE)
        constant player PLAYER2 = Player(4)
        constant integer MAX_HERO_TYPE = 16
        constant integer MAX_ELITE_LEVEL = 50
        constant integer ELITE_LEVEL_XP_MODIFIER = 10
        constant integer VERSION = 00000
        constant string GAME_CACHE_NAME = "ni_liu_zhi_zhan_pre.w3v"
        constant integer GLOBAL_UPDATE_PERIOD = 4
        constant real MAX_BLOCK = 0.3
        constant real MAX_ARMOR_RESISTANCE = 0.75
        constant real MAX_RESISTANCE = 0.5
        constant real MAX_EVADE = 0.5
        constant real MAX_CRIT = 0.7

        unit array HERO_STACK [MAX_HERO_TYPE]
        integer HERO_STACK_NUM = 0
        
        sound SND_HOOK  = CreateSound("abilities\\Weapons\\SentinelMissile\\HuntressMissileLaunch.wav",false,false,false,1,1,"SpellsEAX")
        sound SND_ABOMINATION_YES_ATTACK_2 = CreateSound("Units\\Undead\\Abomination\\AbominationYesAttack2.wav",false,false,false,1,1,"SpellsEAX")
        sound SND_FROST_WYRM_WARCRY_1 = CreateSound("Units\\Undead\\FrostWyrm\\FrostwyrmWarcry1.flac",false,false,false,1,1,"SpellsEAX")
        
        //错误提示音
        sound SND_ERROR = CreateSound("Sound\\Interface\\Error.wav",false,false,false,1,1,"SpellsEAX")
        //小提示
        sound SND_DING = CreateSound("Sound\\Interface\\ItemReceived.wav",false,false,false,1,1,"SpellsEAX")
        //维护费钟声，中提示
        sound SND_RING = CreateSound("Sound\\Interface\\UpkeepRing.wav",false,false,false,1,1,"SpellsEAX")
        //警告，强提示
        sound SND_WARNING = CreateSound("Sound\\Interface\\Warning.wav",false,false,false,1,1,"SpellsEAX")
        //嗜血术音效
        sound SND_BLOODLUST = CreateSound("Abilities\\Spells\\Orc\\Bloodlust\\BloodlustTarget.flac",false,false,false,1,1,"SpellsEAX")
        //暴风雪音效
        sound SND_BLIZZARD = CreateSound("Abilities\\Spells\\Human\\Blizzard\\BlizzardLoop1.flac",false,true,false,1,1,"SpellsEAX")
        //船只装载
        sound SND_LOAD = CreateSound("Abilities\\Spells\\Other\\LoadUnload\\Loading.flac",false,false,false,1,1,"SpellsEAX")

        boolean GAME_AUTO_SAVE = false 
        integer GLOBAL_CREATED_FRAME = 0

        integer array HERO_DEFAULT_ID

        boolean array NEED_REFRESH_FORM [MAX_HERO_TYPE]
        integer startTotalTime = 0

        boolean MAP_IS_DUNGEON = false 
        rect wholeMapRect

        constant string ABILITY_Q = "0"
        constant string ABILITY_W = "1"
        constant string ABILITY_E = "2"
        constant string ABILITY_R = "3"
        constant string ABILITY_F = "4"

        constant integer INT_ATTACK_TYPE_NORMAL = 0
        constant integer INT_ATTACK_TYPE_MELEE = 1
        constant integer INT_ATTACK_TYPE_PIERCE = 2
        constant integer INT_ATTACK_TYPE_SIEGE = 3
        constant integer INT_ATTACK_TYPE_MAGIC = 4
        constant integer INT_ATTACK_TYPE_CHAOS = 5
        constant integer INT_ATTACK_TYPE_HERO = 6

        constant integer INT_DAMAGE_TYPE_UNKNOWN             = 0
        constant integer INT_DAMAGE_TYPE_NORMAL              = 4
        constant integer INT_DAMAGE_TYPE_ENHANCED            = 5
        constant integer INT_DAMAGE_TYPE_FIRE                = 8
        constant integer INT_DAMAGE_TYPE_COLD                = 9
        constant integer INT_DAMAGE_TYPE_LIGHTNING           = 10
        constant integer INT_DAMAGE_TYPE_POISON              = 11
        constant integer INT_DAMAGE_TYPE_DISEASE             = 12
        constant integer INT_DAMAGE_TYPE_DIVINE              = 13
        constant integer INT_DAMAGE_TYPE_MAGIC               = 14
        constant integer INT_DAMAGE_TYPE_SONIC               = 15
        constant integer INT_DAMAGE_TYPE_ACID                = 16
        constant integer INT_DAMAGE_TYPE_FORCE               = 17
        constant integer INT_DAMAGE_TYPE_DEATH               = 18
        constant integer INT_DAMAGE_TYPE_MIND                = 19
        constant integer INT_DAMAGE_TYPE_PLANT               = 20
        constant integer INT_DAMAGE_TYPE_DEFENSIVE           = 21
        constant integer INT_DAMAGE_TYPE_DEMOLITION          = 22
        constant integer INT_DAMAGE_TYPE_SLOW_POISON         = 23
        constant integer INT_DAMAGE_TYPE_SPIRIT_LINK         = 24
        constant integer INT_DAMAGE_TYPE_SHADOW_STRIKE       = 25
        constant integer INT_DAMAGE_TYPE_UNIVERSAL           = 26

        constant integer INT_WEAPON_TYPE_WHOKNOWS            = 0
        constant integer INT_WEAPON_TYPE_METAL_LIGHT_CHOP    = 1
        constant integer INT_WEAPON_TYPE_METAL_MEDIUM_CHOP   = 2
        constant integer INT_WEAPON_TYPE_METAL_HEAVY_CHOP    = 3
        constant integer INT_WEAPON_TYPE_METAL_LIGHT_SLICE   = 4
        constant integer INT_WEAPON_TYPE_METAL_MEDIUM_SLICE  = 5
        constant integer INT_WEAPON_TYPE_METAL_HEAVY_SLICE   = 6
        constant integer INT_WEAPON_TYPE_METAL_MEDIUM_BASH   = 7
        constant integer INT_WEAPON_TYPE_METAL_HEAVY_BASH    = 8
        constant integer INT_WEAPON_TYPE_METAL_MEDIUM_STAB   = 9
        constant integer INT_WEAPON_TYPE_METAL_HEAVY_STAB    = 10
        constant integer INT_WEAPON_TYPE_WOOD_LIGHT_SLICE    = 11
        constant integer INT_WEAPON_TYPE_WOOD_MEDIUM_SLICE   = 12
        constant integer INT_WEAPON_TYPE_WOOD_HEAVY_SLICE    = 13
        constant integer INT_WEAPON_TYPE_WOOD_LIGHT_BASH     = 14
        constant integer INT_WEAPON_TYPE_WOOD_MEDIUM_BASH    = 15
        constant integer INT_WEAPON_TYPE_WOOD_HEAVY_BASH     = 16
        constant integer INT_WEAPON_TYPE_WOOD_LIGHT_STAB     = 17
        constant integer INT_WEAPON_TYPE_WOOD_MEDIUM_STAB    = 18
        constant integer INT_WEAPON_TYPE_CLAW_LIGHT_SLICE    = 19
        constant integer INT_WEAPON_TYPE_CLAW_MEDIUM_SLICE   = 20
        constant integer INT_WEAPON_TYPE_CLAW_HEAVY_SLICE    = 21
        constant integer INT_WEAPON_TYPE_AXE_MEDIUM_CHOP     = 22
        constant integer INT_WEAPON_TYPE_ROCK_HEAVY_BASH     = 23

        constant string KEY_DUNGEON_JAIL                    = "KEY_DUNGEON_JAIL"                                    //监狱
        constant string KEY_DUNGEON_NECROPOLIS              = "KEY_DUNGEON_NECROPOLIS"                              //大墓地
        constant string KEY_MAP_DESERT                      = "KEY_MAP_DESERT"                                      //广大荒漠
        constant string KEY_MAP_NARDAL                      = "KEY_MAP_NARDAL"                                      //纳达尔
        constant string KEY_DUNGEON_SANCTUM                 = "KEY_DUNGEON_SANCTUM"                                 //远古圣所
        constant string KEY_DUNGEON_NETHERFLAMECAVERN       = "KEY_DUNGEON_NETHERFLAMECAVERN"                       //冥火石窟

        constant integer MAX_RELIC_LEVEL = 99
        constant integer MIN_RELIC_LEVEL = 2
        constant integer MAX_LOW_LEVEL = 49
        constant real LEVEL_SCALE = 50.0 / 15.0
        constant real E = 2.718281828  // 自然对数底
        constant real MU_BASE = 10.0
        constant real MU_SCALE = 45.0
        constant real SIGMA_BASE = 5.0
        constant real SIGMA_SCALE = 35.0
        constant real LEVEL_DIVISOR = 30.0

        string array heroMainState [MAX_HERO_TYPE]
        boolean ATTACK_RANGE_SET_FIXED = false 

        string array heroName [MAX_HERO_TYPE]
        integer array eliteLevel [MAX_HERO_TYPE]
        integer TEAM_XP_GAIN_RATE = 10000
        integer TEAM_ITEM_FOUND_RATE = 10000
        real GLOBAL_WAR_FORGE_RATE = 1 
        integer GLOBAL_WAR_FORGE_BONUS = 0
        unit PRELOAD_ABILITY_DUMMY = null // = CreateUnit(NEUTRAL,'hDMY',0,0,0)
        integer GLOBAL_BONUS_TALENT_POINTS = 0
        multiboard damageMeter = null
        multiboarditem damageMeter_Hero_Title
        multiboarditem damageMeter_Time_Title
        multiboarditem damageMeter_Dps_Title
        multiboarditem damageMeter_Hps_Title
        multiboarditem array damageMeter_Items [20]
        real array damageTotal 
        real array healTotal 
        real array healOverdozeTotal
        real array combatTime 
        integer array talentRowRequirement
        unit randomInGroup = null 
        group randomInGroupGroup = CreateGroup()
        group deathUnits = CreateGroup()
        unit eventDyingUnit = null 

        integer MAP_ENEMY_MIN_LEVEL = 1
        integer MAP_EXTRA_LEVEL = 0
        constant real MAP_DIFFICULTY_MULTIPLE = 1.1
        real array LEVEL_LIFE_MULTIPLE [25]
        real array LEVEL_DAMAGE_MULTIPLE [25]

        item PATH_CHECKER
    endglobals

    library TableLib
        struct Table
            private hashtable ht
            static method create takes nothing returns Table
                local Table t = Table.allocate()
                set t.ht = InitHashtable()
                return t
            endmethod
            method operator [] takes integer key returns integer
                return LoadInteger(ht, 0, key)
            endmethod
            method operator []= takes integer key, integer value returns nothing
                call SaveInteger(ht, 0, key, value)
            endmethod
            method has takes integer key returns boolean
                return HaveSavedInteger(ht, 0, key)
            endmethod
            method remove takes integer key returns nothing
                call RemoveSavedInteger(ht, 0, key)
            endmethod
            method destroy takes nothing returns nothing
                call FlushChildHashtable(ht, 0)
                call this.deallocate()
            endmethod
        endstruct

        globals 
            private hashtable trigActionHash = InitHashtable()
        endglobals

        function TriggerAddActionEx takes trigger whichTrigger,code actionFunc returns nothing
            local integer key = GetHandleId(whichTrigger)
            local integer index = LoadInteger(trigActionHash,key,-1)
            if actionFunc == null then 
                return 
            endif 
            call SaveTriggerActionHandle(trigActionHash,key,index,TriggerAddAction(whichTrigger,actionFunc))
            call SaveInteger(trigActionHash,key,-1,index+1)
        endfunction
        function TriggerClearActionsEx takes trigger whichTrigger returns nothing
            local integer key = GetHandleId(whichTrigger)
            local integer index = LoadInteger(trigActionHash,key,-1)
            if whichTrigger == null then 
                return 
            endif 
            loop 
                set index = index-1
                exitwhen index < 0
                call TriggerRemoveAction(whichTrigger,LoadTriggerActionHandle(trigActionHash,key,index))
            endloop
            call FlushChildHashtable(trigActionHash,key)
        endfunction
        function DestroyTriggerEx takes trigger whichTrigger returns nothing
            if whichTrigger == null then 
                return 
            endif 
            call TriggerClearActionsEx(whichTrigger)
            call DestroyTrigger(whichTrigger)
        endfunction

        globals
            item lastCreatedItem
        endglobals
        
        function GetEquipType takes integer itemTypeId returns EquipType
            return LoadInteger(equipHash,itemTypeId,0)
        endfunction

        function CreateItemEx takes integer itemid,real x,real y returns item 
            local Equipment eq 
            if itemid == 0 then 
                set lastCreatedItem = null
                return null 
            endif 
            set lastCreatedItem = CreateItem(itemid,x,y)
            if GetEquipType(itemid) > 0 then 
                set eq = Equipment.create(GetEquipType(itemid))
                call eq.bindOnItem(lastCreatedItem)
            endif 
            //call BJDebugMsg("Created Item = "+I2S(itemid)+","+I2S(GetHandleId(lastCreatedItem)))
            return lastCreatedItem
        endfunction
    endlibrary

    library BubbleSort
        struct sort
            static integer array arr [1000]   // 全局数组，用于排序
            static integer size = 0         // 数组大小

            static method run takes nothing returns nothing
                local integer i = 0
                local integer j = 0
                local integer temp = 0
                local boolean swapped

                loop
                    exitwhen i >= sort.size - 1
                    set swapped = false
                    set j = 0
                    loop
                        exitwhen j >= sort.size - i - 1
                        if sort.arr[j] > sort.arr[j + 1] then
                            // 交换元素
                            set temp = sort.arr[j]
                            set sort.arr[j] = sort.arr[j + 1]
                            set sort.arr[j + 1] = temp
                            set swapped = true
                        endif
                        set j = j + 1
                    endloop
                    // 如果没有交换，提前结束
                    if not swapped then
                        return
                    endif
                    set i = i + 1
                endloop
            endmethod

            static method clear takes nothing returns nothing
                local integer i = 0

                loop 
                    exitwhen i > sort.size - 1
                    set sort.arr[i] = 0
                    set i = i + 1
                endloop
                set sort.size = 0
            endmethod

            static method add takes integer i returns nothing
                set sort.arr[sort.size] = i
                set sort.size = sort.size+1
            endmethod

            static method shuffle takes nothing returns nothing
                local integer i = sort.size - 1  // 从数组末尾开始
                local integer j             // 随机选择的索引
                local integer temp           // 临时交换变量
                
                loop
                    exitwhen i <= 0  // 遍历到第一个元素时结束
                    
                    // 生成0到i之间的随机索引（包括i）
                    set j = GetRandomInt(0, i)
                    
                    // 交换arr[i]和arr[j]
                    set temp = sort.arr[i]
                    set sort.arr[i] = sort.arr[j]
                    set sort.arr[j] = temp
                    
                    set i = i - 1  // 向前移动
                endloop
            endmethod

            static method print takes nothing returns nothing
                local integer i = 0
                local string s = "数组: "
                
                loop
                    exitwhen i >= sort.size
                    set s = s + I2S(sort.arr[i])
                    
                    if i < sort.size - 1 then
                        set s = s + ", "
                    endif
                    
                    set i = i + 1
                endloop
                
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 60, s)
            endmethod
        endstruct
    endlibrary

    library PseudoRandomD initializer init requires TableLib

        // 伪随机结构（概率累加模型）
        struct PRD
            private real counter = 0.0        // 概率累加器
            private real baseChance            // 基础概率 [0,1]
            private static Table table = 0     // unit+skill -> PRD
            private static Table unitSkills = 0// unit -> skillId list
            private unit owner
            private integer skillId

            // 创建或获取 PRD 实例
            static method create takes unit u, integer skillId, real baseChance returns thistype
                local integer unitKey = GetHandleId(u)
                local integer key = unitKey * 8192 + skillId
                local thistype this
                local integer skillCount

                // 初始化 Table
                if (thistype.table == 0) then
                    set thistype.table = Table.create()
                    set thistype.unitSkills = Table.create()
                endif

                // 概率钳制
                if (baseChance < 0.0) then
                    set baseChance = 0.0
                elseif (baseChance > 1.0) then
                    set baseChance = 1.0
                endif

                set skillCount = thistype.unitSkills[unitKey]
                if (skillCount >= 1000) then
                    return 0
                endif

                // 已存在实例
                if (thistype.table.has(key)) then
                    set this = thistype.table[key]
                else
                    set this = thistype.allocate()
                    set this.owner = u
                    set this.skillId = skillId
                    set this.counter = 0.0

                    set thistype.table[key] = this
                    set thistype.unitSkills[unitKey] = skillCount + 1
                    set thistype.unitSkills[unitKey * 1000 + skillCount] = skillId
                endif

                set this.baseChance = baseChance
                return this
            endmethod

            // PRD 判定（期望守恒）
            method check takes nothing returns boolean
                local real r

                if (this.baseChance <= 0.0) then
                    return false
                endif

                if (this.baseChance >= 1.0) then
                    return true
                endif

                // 概率累加
                set this.counter = this.counter + this.baseChance
                set r = GetRandomReal(0.0, 1.0)

                if (r < this.counter) then
                    set this.counter = this.counter - 1.0
                    return true
                endif

                return false
            endmethod

            // 销毁单个实例
            method destroy takes nothing returns nothing
                local integer key = GetHandleId(this.owner) * 8192 + this.skillId
                call thistype.table.remove(key)
                set this.owner = null
                call this.deallocate()
            endmethod

            // 清理单位的所有 PRD
            static method clearUnit takes unit u returns nothing
                local integer unitKey = GetHandleId(u)
                local integer skillCount = thistype.unitSkills[unitKey]
                local integer i = 0
                local integer skillId
                local integer key
                local thistype this

                loop
                    exitwhen i >= skillCount
                    set skillId = thistype.unitSkills[unitKey * 1000 + i]
                    set key = unitKey * 8192 + skillId
                    if (thistype.table.has(key)) then
                        set this = thistype.table[key]
                        call this.destroy()
                    endif
                    set i = i + 1
                endloop

                call thistype.unitSkills.remove(unitKey)
                set i = 0
                loop
                    exitwhen i >= skillCount
                    call thistype.unitSkills.remove(unitKey * 1000 + i)
                    set i = i + 1
                endloop
            endmethod
        endstruct

        // 单位死亡时清理
        function Trig_UnitDeath_Actions takes nothing returns nothing
            local unit dyingUnit = GetDyingUnit()
            call PRD.clearUnit(dyingUnit)
            set dyingUnit = null
        endfunction

        private function init takes nothing returns nothing
            local trigger trig = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DEATH)
            call TriggerAddActionEx(trig, function Trig_UnitDeath_Actions)
            set trig = null
        endfunction

    endlibrary

    library shared initializer init requires BubbleSort,TableLib,PseudoRandomD,SettingsMenu
        globals 
            hashtable hash_CheckItemRecall = InitHashtable()
            string AutoSaveName = ""  
            boolean AutoSaveShow = false 
            boolean isSavingCampaign = false
        endglobals

        ///////////////////////////////////////////////////////////////
        //  修复原函数不能获取目标点z轴的bug
        ///////////////////////////////////////////////////////////////
        function BlzSetSpecialEffectHeightEX takes effect sfx,real height returns nothing
            local location loc = Location(BlzGetLocalSpecialEffectX(sfx),BlzGetLocalSpecialEffectY(sfx))
            call BlzSetSpecialEffectHeight(sfx,height+GetLocationZ(loc))
            call RemoveLocation(loc)
            set loc = null 
        endfunction

        function GetHeroQ takes unit whichUnit returns integer 
            if GetUnitAbilityLevel(whichUnit,'S03G') > 0 then 
                return 'S03G'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S02H') > 0 then 
                return 'S02H'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S033') > 0 then 
                return 'S033'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S01V') > 0 then 
                return 'S01V'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S01W') > 0 then 
                return 'S01W'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S01X') > 0 then 
                return 'S01X'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S01Y') > 0 then 
                return 'S01Y'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S002') > 0 then 
                return 'S002'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S045') > 0 then 
                return 'S045'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S046') > 0 then 
                return 'S046'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S047') > 0 then 
                return 'S047'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S02R') > 0 then 
                return 'S02R'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S00N') > 0 then 
                return 'S00N'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S00O') > 0 then 
                return 'S00O'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S015') > 0 then 
                return 'S015'
            endif
            if GetUnitAbilityLevel(whichUnit,'S019') > 0 then 
                return 'S019'
            endif  
            if GetUnitAbilityLevel(whichUnit,'S01F') > 0 then 
                return 'S01F'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S01E') > 0 then 
                return 'S01E'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S00G') > 0 then 
                return 'S00G'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S04W') > 0 then 
                return 'S04W'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S001') > 0 then 
                return 'S001'
            endif 
            if GetUnitAbilityLevel(whichUnit,'S00Z') > 0 then 
                return 'S00Z'
            endif 
            return 0
        endfunction

        function CheckPoint_Delayed takes nothing returns nothing
            call DestroyTimer(GetExpiredTimer())
            if isSavingCampaign then
                // 如果正在进行分段存档，延迟重试以避免与 SaveGameCache 冲突
                call TimerStart(CreateTimer(),0.15,false,function CheckPoint_Delayed)
                return
            endif
            call SaveGameCheckpoint(AutoSaveName,AutoSaveShow)
        endfunction
        function CheckPoint takes string name,boolean show returns nothing
            set AutoSaveName = name 
            set AutoSaveShow = show 
            if AutoSaveName == "" then 
                return
            else 
                call TimerStart(CreateTimer(),0,false,function CheckPoint_Delayed)
            endif 
        endfunction

        function ItemRecallCheck takes unit whichUnit,integer id returns boolean
            if LoadInteger(hash_CheckItemRecall,GetHandleId(whichUnit),id) == 0 or HaveSavedInteger(hash_CheckItemRecall,GetHandleId(whichUnit),id) == false then 
                call SaveInteger(hash_CheckItemRecall,GetHandleId(whichUnit),id,1)
                return true 
            endif 
            return false 
        endfunction
        function ItemRecallFlush takes nothing returns nothing
            call FlushParentHashtable(hash_CheckItemRecall)
        endfunction

        function PlaySndEx takes sound which returns nothing
            call StopSound(which,false,false)
            call StartSound(which)
            call SetSoundVolume(which,127)
        endfunction

        function Play3DSndEx takes sound which,real x,real y,real z returns nothing
            call StopSound(which,false,false)
            call SetSoundPosition(which,x,y,z)
            call StartSound(which)
            call SetSoundVolume(which,127)
        endfunction

        function DisplayErrorMsg takes string msg returns nothing
            call StopSound(SND_ERROR,false,false)
            call StartSound(SND_ERROR)
            call SetSoundVolume(SND_ERROR,127)
            call ClearTextMessages()
            call DisplayTextToPlayer(PLAYER,0,0,msg)
        endfunction

        function GroupRemoveFirstUnit takes group whichGroup returns nothing
            call GroupRemoveUnit(whichGroup,FirstOfGroup(whichGroup))
        endfunction 

        // 全局哈希表（在地图头部声明）
        globals
            hashtable ItemStackHash = InitHashtable()  // 堆叠上限哈希表
        endglobals

        // 外部注册函数（在地图初始化或其他地方调用）
        function RegisterItemStackLimit takes integer itemId, integer limit returns nothing
            call SaveInteger(ItemStackHash, 0, itemId, limit)
        endfunction

        // 获取堆叠上限（未注册返回 0 表示无限制）
        function GetItemStackLimit takes integer itemId returns integer
            if HaveSavedInteger(ItemStackHash, 0, itemId) then
                return LoadInteger(ItemStackHash, 0, itemId)
            endif
            return 0  // 默认无限制
        endfunction

        globals
            lightning array ActivingLightning [1000]
            integer LightningIndex = 0
            boolean loadinggame = false 
            lightning lastCreatedLightning = null 
        endglobals

        function I2SSSS takes integer i returns string
            local integer a = i/(16777216)
            local integer b = ModuloInteger(i/65536, 256)
            local integer c = ModuloInteger(i/256, 256)
            local integer d = ModuloInteger(i, 256)
            return SubString(ssss, a, a+1)+SubString(ssss, b, b+1)+SubString(ssss, c, c+1)+SubString(ssss, d, d+1)
        endfunction
        
        function LogUnitLife takes unit whichUnit returns boolean
            if COMBAT_LOG_ON then 
                call Preload("P|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(whichUnit))+"|"+I2S(GetHandleId(whichUnit)-1050000)+"|"+R2S(GetUnitState(whichUnit,UNIT_STATE_LIFE))+"|"+R2S(GetUnitState(whichUnit,UNIT_STATE_MAX_LIFE)))
                return true 
            endif 
            return false 
        endfunction

        struct random
            static trigger trig = CreateTrigger()
            static unit dummy 

            static method get takes unit whichUnit,real p,integer flag returns boolean
                /*
                if GetRandomReal(0,1) < p then 
                    return true 
                endif 
                return false 
                */
                local PRD prd
                if p >= 1 then 
                    return true 
                elseif p <= 0 then 
                    return false 
                endif 
                set prd = PRD.create(whichUnit, flag, p)
                if prd.check() then 
                    return true 
                endif 
                return false 
            endmethod
        endstruct

        function WeaponType2I takes weapontype whichType returns integer         
            if whichType == WEAPON_TYPE_WHOKNOWS            then
                return 0
            elseif whichType == WEAPON_TYPE_METAL_LIGHT_CHOP    then
                return 1
            elseif whichType == WEAPON_TYPE_METAL_MEDIUM_CHOP   then
                return 2
            elseif whichType == WEAPON_TYPE_METAL_HEAVY_CHOP    then
                return 3
            elseif whichType == WEAPON_TYPE_METAL_LIGHT_SLICE   then
                return 4
            elseif whichType == WEAPON_TYPE_METAL_MEDIUM_SLICE  then
                return 5
            elseif whichType == WEAPON_TYPE_METAL_HEAVY_SLICE   then
                return 6
            elseif whichType == WEAPON_TYPE_METAL_MEDIUM_BASH   then
                return 7
            elseif whichType == WEAPON_TYPE_METAL_HEAVY_BASH    then
                return 8
            elseif whichType == WEAPON_TYPE_METAL_MEDIUM_STAB   then
                return 9
            elseif whichType == WEAPON_TYPE_METAL_HEAVY_STAB    then
                return 10
            elseif whichType == WEAPON_TYPE_WOOD_LIGHT_SLICE    then
                return 11
            elseif whichType == WEAPON_TYPE_WOOD_MEDIUM_SLICE   then
                return 12
            elseif whichType == WEAPON_TYPE_WOOD_HEAVY_SLICE    then
                return 13
            elseif whichType == WEAPON_TYPE_WOOD_LIGHT_BASH     then
                return 14
            elseif whichType == WEAPON_TYPE_WOOD_MEDIUM_BASH    then
                return 15
            elseif whichType == WEAPON_TYPE_WOOD_HEAVY_BASH     then
                return 16
            elseif whichType == WEAPON_TYPE_WOOD_LIGHT_STAB     then
                return 17
            elseif whichType == WEAPON_TYPE_WOOD_MEDIUM_STAB    then
                return 18
            elseif whichType == WEAPON_TYPE_CLAW_LIGHT_SLICE    then
                return 19
            elseif whichType == WEAPON_TYPE_CLAW_MEDIUM_SLICE   then
                return 20
            elseif whichType == WEAPON_TYPE_CLAW_HEAVY_SLICE    then
                return 21
            elseif whichType == WEAPON_TYPE_AXE_MEDIUM_CHOP     then
                return 22
            elseif whichType == WEAPON_TYPE_ROCK_HEAVY_BASH     then
                return 23
            endif 
            return 0
        endfunction
        function AttackType2I takes attacktype whichType returns integer 
            if whichType == ATTACK_TYPE_NORMAL then 
                return 0
            elseif whichType == ATTACK_TYPE_MELEE then 
                return 1
            elseif whichType == ATTACK_TYPE_PIERCE then 
                return 2
            elseif whichType == ATTACK_TYPE_SIEGE then 
                return 3
            elseif whichType == ATTACK_TYPE_MAGIC then 
                return 4
            elseif whichType == ATTACK_TYPE_CHAOS then 
                return 5
            elseif whichType == ATTACK_TYPE_HERO then 
                return 6
            endif 
            return 0
        endfunction
        function DamageType2I takes damagetype whichType returns integer 
            if whichType == DAMAGE_TYPE_UNKNOWN            then 
                return 0
            elseif whichType == DAMAGE_TYPE_NORMAL             then 
                return 4
            elseif whichType == DAMAGE_TYPE_ENHANCED           then 
                return 5
            elseif whichType == DAMAGE_TYPE_FIRE               then 
                return 8
            elseif whichType == DAMAGE_TYPE_COLD               then 
                return 9
            elseif whichType == DAMAGE_TYPE_LIGHTNING          then 
                return 10
            elseif whichType == DAMAGE_TYPE_POISON             then 
                return 11
            elseif whichType == DAMAGE_TYPE_DISEASE            then 
                return 12
            elseif whichType == DAMAGE_TYPE_DIVINE             then 
                return 13
            elseif whichType == DAMAGE_TYPE_MAGIC              then 
                return 14
            elseif whichType == DAMAGE_TYPE_SONIC              then 
                return 15
            elseif whichType == DAMAGE_TYPE_ACID               then 
                return 16
            elseif whichType == DAMAGE_TYPE_FORCE              then 
                return 17
            elseif whichType == DAMAGE_TYPE_DEATH              then 
                return 18
            elseif whichType == DAMAGE_TYPE_MIND               then 
                return 19
            elseif whichType == DAMAGE_TYPE_PLANT              then 
                return 20
            elseif whichType == DAMAGE_TYPE_DEFENSIVE          then 
                return 21
            elseif whichType == DAMAGE_TYPE_DEMOLITION         then 
                return 22
            elseif whichType == DAMAGE_TYPE_SLOW_POISON        then 
                return 23
            elseif whichType == DAMAGE_TYPE_SPIRIT_LINK        then 
                return 24
            elseif whichType == DAMAGE_TYPE_SHADOW_STRIKE      then 
                return 25
            elseif whichType == DAMAGE_TYPE_UNIVERSAL          then 
                return 26
            endif 
            return 0
        endfunction

        function GetUnitLostLife takes unit whichUnit returns real 
            return GetUnitState(whichUnit,UNIT_STATE_MAX_LIFE)-GetUnitState(whichUnit,UNIT_STATE_LIFE)
        endfunction
        function GetUnitLostMana takes unit whichUnit returns real 
            return GetUnitState(whichUnit,UNIT_STATE_MAX_MANA)-GetUnitState(whichUnit,UNIT_STATE_MANA)
        endfunction

        function UnitAddAbilityEx takes unit whichUnit,integer abilityId returns boolean
            if GetUnitAbilityLevel(whichUnit,abilityId) == 0 then 
                call UnitAddAbility(whichUnit,abilityId)
                return true 
            endif 
            return false 
        endfunction
        function UnitRemoveAbilityEx takes unit whichUnit,integer abilityId returns boolean
            if GetUnitAbilityLevel(whichUnit,abilityId) != 0 then 
                call UnitRemoveAbility(whichUnit,abilityId)
                return true 
            endif 
            return false 
        endfunction

        function SetUnitAttackRange takes unit u, real newRange returns nothing
            local real attackRange0 = BlzGetUnitWeaponRealField(u, UNIT_WEAPON_RF_ATTACK_RANGE, 0)
            local real attackRange1 = BlzGetUnitWeaponRealField(u, UNIT_WEAPON_RF_ATTACK_RANGE, 1)
            if ATTACK_RANGE_SET_FIXED then 
                call BlzSetUnitWeaponRealFieldBJ(u, UNIT_WEAPON_RF_ATTACK_RANGE, 0, newRange)
            else 
                call BlzSetUnitWeaponRealFieldBJ(u, UNIT_WEAPON_RF_ATTACK_RANGE, 1, newRange - attackRange0 + attackRange1)
            endif 
        endfunction

        function RandomOfGroup takes group whichGroup returns unit 
            local integer i = 0
            call GroupAddGroup(whichGroup,randomInGroupGroup)
            set randomInGroup = null 
            loop 
                exitwhen FirstOfGroup(randomInGroupGroup) == null 
                set i = i+1
                if GetRandomInt(1,i) == 1 then
                    set randomInGroup = FirstOfGroup(randomInGroupGroup)
                endif 
                call GroupRemoveUnit(randomInGroupGroup,FirstOfGroup(randomInGroupGroup))
            endloop
            call GroupClear(randomInGroupGroup)
            return randomInGroup
        endfunction

        globals
            hashtable sfxHash = InitHashtable()
            effect lastCreatedSFX = null 
        endglobals
        function AddSpecialEffectEX takes string path,real x,real y returns effect
            local integer i = 0
            set lastCreatedSFX = AddSpecialEffect(path,x,y)
            set i = GetHandleId(lastCreatedSFX)
            call SaveBoolean(sfxHash,i,0,true)
            return lastCreatedSFX
        endfunction
        function AddSpecialEffectTargetEX takes string path,unit whichUnit,string attach returns effect
            local integer i = 0
            set lastCreatedSFX = AddSpecialEffectTarget(path,whichUnit,attach)
            set i = GetHandleId(lastCreatedSFX)
            call SaveBoolean(sfxHash,i,0,true)
            set whichUnit = null 
            return lastCreatedSFX
        endfunction
        function DestroyEffectEX takes effect whichEffect returns nothing
            local integer i = 0
            if whichEffect != null then 
                set i = GetHandleId(whichEffect)
                if LoadBoolean(sfxHash,i,0) then 
                    call SaveBoolean(sfxHash,i,0,false)
                    call DestroyEffect(whichEffect)
                endif 
                call FlushChildHashtable(sfxHash,i)
            endif 
        endfunction

        function GetHeroIndex takes unit whichHero returns integer
            local integer i = LoadInteger(globalHashtable,GetUnitTypeId(whichHero),StringHash("INDEX"))
            set whichHero = null 
            return i 
        endfunction
        function SetHeroIndex takes integer typeId,integer index returns nothing
            call SaveInteger(globalHashtable,typeId,StringHash("INDEX"),index)
        endfunction

        function unitGetBonusState takes unit whichUnit,string whichState returns integer 
            local integer result = 0
            local integer i = State.top
            local State s = i 
            loop 
                exitwhen i == 0 
                set s = i 
                if whichState == s.name then 
                    if s.defaultSumMode == STATE_MODE_INT then 
                        set result = s.getI(whichUnit)
                    endif 
                    if s.defaultSumMode == STATE_MODE_REAL then 
                        set result = s.getR(whichUnit)
                    endif 
                    if s.defaultSumMode == STATE_MODE_PERCENTAGE then 
                        set result = s.getP(whichUnit)
                    endif 
                    exitwhen true 
                endif 
                if whichState == s.name+"_P" then 
                    set result = s.getP(whichUnit)
                    exitwhen true 
                endif 
                set i = i-1
            endloop
            return result
        endfunction
        function unitGetAllBonusStateValue takes unit whichUnit,string whichState returns integer 
            local integer result = 0
            local integer i = State.top
            local State s = i 
            loop 
                exitwhen i == 0 
                set s = i 
                if whichState == s.name or whichState == s.name+"_P" then 
                    set result = s.getTotalState(whichUnit)
                    exitwhen true 
                endif 
                set i = i-1
            endloop
            return result 
        endfunction
        function unitSetAllBonusStateValue takes unit whichUnit,string whichState,integer value returns nothing
            local integer i = State.top
            local State s = i 
            loop 
                exitwhen i == 0 
                set s = i 
                if whichState == s.name or whichState == s.name+"_P" then 
                    exitwhen true 
                endif 
                set i = i-1
            endloop
        endfunction

        function find takes string originalStr,string targetStr returns boolean
            local integer iMax = StringLength(originalStr)
            local integer i = iMax
            local integer len = StringLength(targetStr)
            if StringLength(originalStr) < len then 
                return false 
            endif 
            loop
                exitwhen i < len or len <= 0 or i <= 0 
                if SubString(originalStr,i-len,i) == targetStr then 
                    return true 
                endif 
                set i = i-1
            endloop
            return false
        endfunction
        function findReturnInt takes string originalStr,string targetStr returns integer
            local integer iMax = StringLength(originalStr)
            local integer i = iMax
            local integer len = StringLength(targetStr)
            if StringLength(originalStr) < len then 
                return iMax
            endif 
            loop
                exitwhen i < len or len <= 0 or i <= 0 
                if SubString(originalStr,i-len,i) == targetStr then 
                    return i
                endif 
                set i = i-1
            endloop
            return iMax
        endfunction

        function GetItemNameEX takes item ii returns string 
            local string name = GetItemName(ii)
            local integer len = findReturnInt(name,"|r")
            return SubString(name,0,len)
        endfunction

        function upper takes string originalStr returns string
            return StringCase(originalStr,true)
        endfunction
        function lower takes string originalStr returns string
            return StringCase(originalStr,false)
        endfunction

        function GetHeroData takes unit whichHero,string whichData returns integer
            local integer i = LoadInteger(globalHashtable,GetHandleId(whichHero),StringHash("CUSTOM_DATA_"+whichData))
            return i 
        endfunction
        function SetHeroData takes unit whichHero,string whichData,integer value returns nothing
            call SaveInteger(globalHashtable,GetHandleId(whichHero),StringHash("CUSTOM_DATA_"+whichData),value)
        endfunction
        function GetHeroRealData takes unit whichHero,string whichData returns real
            local real i = LoadReal(globalHashtable,GetHandleId(whichHero),StringHash("CUSTOM_REAL_DATA_"+whichData))
            return i 
        endfunction
        function SetHeroRealData takes unit whichHero,string whichData,real value returns nothing
            call SaveReal(globalHashtable,GetHandleId(whichHero),StringHash("CUSTOM_REAL_DATA_"+whichData),value)
        endfunction

        function GetUnitAbility takes unit whichHero,string id returns integer 
            return GetHeroData(whichHero,"LEARNED_ABILITY_"+id)-2752512
        endfunction

        function DisByXY takes real x1,real y1,real x2,real y2 returns real
            return SquareRoot((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
        endfunction
        function DisByUnits takes unit u1,unit u2 returns real
            local real d = SquareRoot((GetUnitX(u2)-GetUnitX(u1))*(GetUnitX(u2)-GetUnitX(u1))+(GetUnitY(u2)-GetUnitY(u1))*(GetUnitY(u2)-GetUnitY(u1)))
            set u1 = null 
            set u2 = null 
            return d 
        endfunction
        function DisByUnXY takes unit u,real x,real y returns real
            local real d = SquareRoot((x-GetUnitX(u))*(x-GetUnitX(u))+(y-GetUnitY(u))*(y-GetUnitY(u)))
            set u = null 
            return d 
        endfunction

        function AngleByXY takes real x1,real y1,real x2,real y2 returns real
            return 57.295779 * Atan2(y2-y1,x2-x1)
        endfunction
        function AngleByUnits takes unit u1,unit u2 returns real
            local real a = 57.295779 * Atan2(GetUnitY(u2)-GetUnitY(u1),GetUnitX(u2)-GetUnitX(u1))
            set u1 = null
            set u2 = null 
            return a 
        endfunction
        function AngleByUnXY takes unit u,real x,real y returns real
            local real a = 57.295779 * Atan2(y-GetUnitY(u),x-GetUnitX(u))
            set u = null 
            return a 
        endfunction
        function AngleByXYnU takes real x,real y,unit u returns real
            local real a = 57.295779 * Atan2(GetUnitY(u)-y,GetUnitX(u)-x)
            set u = null 
            return a 
        endfunction

        function alive takes unit whichUnit returns boolean
            local boolean bl = GetUnitState(whichUnit,UNIT_STATE_LIFE) > 0 and IsUnitInGroup(whichUnit,deathUnits) == false 
            set whichUnit = null 
            return bl 
        endfunction

        function inCombat takes unit whichUnit returns boolean 
            local boolean bl = GetHeroData(whichUnit,"COMBAT") > globalNowtime
            set whichUnit = null 
            return bl 
        endfunction
        function getCombatTime takes unit whichUnit returns integer 
            local integer result = GetHeroData(whichUnit,"COMBAT")
            set whichUnit = null 
            return result 
        endfunction
        function clearCombat takes unit whichUnit returns nothing
            call SetHeroData(whichUnit,"COMBAT",0)
        endfunction
        function setCombatTime takes unit whichUnit,integer time returns nothing
            call SetHeroData(whichUnit,"COMBAT",time)
        endfunction
        function setCombat takes unit whichUnit returns nothing
            call SetHeroData(whichUnit,"COMBAT",globalNowtime+500)
        endfunction

        //======================================================================
        //  选取x,y范围radius内单位加入单位组whichGroup，满足filter，考虑目标碰撞
        //======================================================================
        function GroupEnumUnitsInRangeEx takes group whichGroup,real x,real y,real radius,boolexpr filter returns nothing
            local group pick = CreateGroup()
            call GroupEnumUnitsInRange(pick,x,y,radius+256,filter)
            loop
                exitwhen FirstOfGroup(pick) == null 
                if DisByUnXY(FirstOfGroup(pick),x,y) <= BlzGetUnitCollisionSize(FirstOfGroup(pick))+radius then 
                    call GroupAddUnit(whichGroup,FirstOfGroup(pick))
                endif 
                call GroupRemoveFirstUnit(pick)
            endloop
            call DestroyGroup(pick)
            set pick = null 
            set filter = null 
            set whichGroup = null 
        endfunction

        //======================================================================
        //  全局变量区（所有函数共用）
        //  必须放在地图脚本最上方
        //======================================================================
        globals
            // 复用枚举组（所有函数共用）
            private group   ENUM_GROUP      = CreateGroup()
            
            // 暂存返回值（避免 return 前 set null）
            private unit    RETURN_UNIT     = null
            private group   RETURN_GROUP    = null
            
            // 安全大值（替代 1.0E+30）
            private constant real MAX_REAL  = 2147483647
        endglobals

        //======================================================================
        //  【距离函数】1. 最近单位
        //======================================================================
        function GetClosestUnit takes unit whichUnit, group fromGroup returns unit
            local unit  closest = null
            local real  minDist = MAX_REAL
            local real  curDist
            local unit  u       = null

            call GroupClear(ENUM_GROUP)
            call GroupAddGroup(fromGroup, ENUM_GROUP)

            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null
                call GroupRemoveUnit(ENUM_GROUP, u)

                if alive(u) then
                    set curDist = DisByUnits(whichUnit, u)
                    if curDist < minDist then
                        set minDist = curDist
                        set closest = u
                    endif
                endif
            endloop

            set RETURN_UNIT = closest
            set u       = null
            set closest = null
            return RETURN_UNIT
        endfunction

        //======================================================================
        //  【距离函数】2. 最远单位
        //======================================================================
        function GetFarthestUnit takes unit whichUnit, group fromGroup returns unit
            local unit  farthest = null
            local real  maxDist  = -1.0
            local real  curDist
            local unit  u        = null

            call GroupClear(ENUM_GROUP)
            call GroupAddGroup(fromGroup, ENUM_GROUP)

            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null
                call GroupRemoveUnit(ENUM_GROUP, u)

                if alive(u) then
                    set curDist = DisByUnits(whichUnit, u)
                    if curDist > maxDist then
                        set maxDist = curDist
                        set farthest = u
                    endif
                endif
            endloop

            set RETURN_UNIT = farthest
            set u        = null
            set farthest = null
            return RETURN_UNIT
        endfunction

        //======================================================================
        //  【距离函数】3. 最近 amount 个单位
        //======================================================================
        function GetClosestUnits takes unit whichUnit, group fromGroup, integer amount returns group
            local group result = CreateGroup()
            local group temp   = CreateGroup()
            local unit  u      = null
            local unit  pick   = null
            local real  dist
            local real  pickDist
            local integer i    = 0

            call GroupAddGroup(fromGroup, temp)

            loop
                exitwhen i >= amount or CountUnitsInGroup(temp) == 0

                set pick     = null
                set pickDist = MAX_REAL

                loop
                    set u = FirstOfGroup(temp)
                    exitwhen u == null
                    call GroupRemoveUnit(temp, u)

                    if alive(u) then
                        set dist = DisByUnits(whichUnit, u)
                        if dist < pickDist then
                            set pickDist = dist
                            set pick     = u
                        endif
                    endif
                endloop

                if pick != null then
                    call GroupAddUnit(result, pick)
                    set i = i + 1
                endif
            endloop

            set RETURN_GROUP = result
            call DestroyGroup(temp)
            set temp = null
            set u    = null
            set pick = null
            set result = null
            return RETURN_GROUP
        endfunction

        //======================================================================
        //  【距离函数】4. 最远 amount 个单位
        //======================================================================
        function GetFarthestUnits takes unit whichUnit, group fromGroup, integer amount returns group
            local group result = CreateGroup()
            local group temp   = CreateGroup()
            local unit  u      = null
            local unit  pick   = null
            local real  dist
            local real  pickDist
            local integer i    = 0

            call GroupAddGroup(fromGroup, temp)

            loop
                exitwhen i >= amount or CountUnitsInGroup(temp) == 0

                set pick     = null
                set pickDist = -1.0

                loop
                    set u = FirstOfGroup(temp)
                    exitwhen u == null
                    call GroupRemoveUnit(temp, u)

                    if alive(u) then
                        set dist = DisByUnits(whichUnit, u)
                        if dist > pickDist then
                            set pickDist = dist
                            set pick     = u
                        endif
                    endif
                endloop

                if pick != null then
                    call GroupAddUnit(result, pick)
                    set i = i + 1
                endif
            endloop

            set RETURN_GROUP = result
            call DestroyGroup(temp)
            set temp = null
            set u    = null
            set pick = null
            set result = null
            return RETURN_GROUP
        endfunction

        //======================================================================
        //  【生命值函数】1. 生命值百分比最高
        //======================================================================
        function GetUnitWithHighestHealthPct takes group fromGroup returns unit
            local unit  best   = null
            local real  maxPct = -1.0
            local real  curPct
            local unit  u      = null

            call GroupClear(ENUM_GROUP)
            call GroupAddGroup(fromGroup, ENUM_GROUP)

            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null
                call GroupRemoveUnit(ENUM_GROUP, u)

                if alive(u) and GetUnitState(u, UNIT_STATE_MAX_LIFE) > 0.0 then
                    set curPct = GetUnitStatePercent(u, UNIT_STATE_LIFE, UNIT_STATE_MAX_LIFE)
                    if curPct > maxPct then
                        set maxPct = curPct
                        set best   = u
                    endif
                endif
            endloop

            set RETURN_UNIT = best
            set u    = null
            set best = null
            return RETURN_UNIT
        endfunction

        //======================================================================
        //  【生命值函数】2. 生命值百分比最低
        //======================================================================
        function GetUnitWithLowestHealthPct takes group fromGroup returns unit
            local unit  worst  = null
            local real  minPct = 200.0
            local real  curPct
            local unit  u      = null

            call GroupClear(ENUM_GROUP)
            call GroupAddGroup(fromGroup, ENUM_GROUP)

            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null
                call GroupRemoveUnit(ENUM_GROUP, u)

                if alive(u) and GetUnitState(u, UNIT_STATE_MAX_LIFE) > 0.0 then
                    set curPct = GetUnitStatePercent(u, UNIT_STATE_LIFE, UNIT_STATE_MAX_LIFE)
                    if curPct < minPct then
                        set minPct = curPct
                        set worst  = u
                    endif
                endif
            endloop

            set RETURN_UNIT = worst
            set u     = null
            set worst = null
            return RETURN_UNIT
        endfunction

        //======================================================================
        //  【生命值函数】3. 生命值绝对值最高
        //======================================================================
        function GetUnitWithHighestHealth takes group fromGroup returns unit
            local unit  best   = null
            local real  maxHP  = -1.0
            local real  curHP
            local unit  u      = null

            call GroupClear(ENUM_GROUP)
            call GroupAddGroup(fromGroup, ENUM_GROUP)

            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null
                call GroupRemoveUnit(ENUM_GROUP, u)

                if alive(u) then
                    set curHP = GetUnitState(u, UNIT_STATE_LIFE)
                    if curHP > maxHP then
                        set maxHP = curHP
                        set best  = u
                    endif
                endif
            endloop

            set RETURN_UNIT = best
            set u    = null
            set best = null
            return RETURN_UNIT
        endfunction

        //======================================================================
        //  【生命值函数】4. 生命值绝对值最低
        //======================================================================
        function GetUnitWithLowestHealth takes group fromGroup returns unit
            local unit  worst  = null
            local real  minHP  = MAX_REAL
            local real  curHP
            local unit  u      = null

            call GroupClear(ENUM_GROUP)
            call GroupAddGroup(fromGroup, ENUM_GROUP)

            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null
                call GroupRemoveUnit(ENUM_GROUP, u)

                if alive(u) then
                    set curHP = GetUnitState(u, UNIT_STATE_LIFE)
                    if curHP < minHP then
                        set minHP = curHP
                        set worst = u
                    endif
                endif
            endloop

            set RETURN_UNIT = worst
            set u     = null
            set worst = null
            return RETURN_UNIT
        endfunction

        //======================================================================
        //  安全随机挑选单位（共用 ENUM_GROUP / RETURN_RANDOM_UNIT）
        //  takes group g → returns unit（空组返回 null）
        //======================================================================
        function GroupPickRandomUnitEx takes group g returns unit
            local integer count = CountUnitsInGroup(g)
            local integer pickIndex
            local unit    u     = null
            local integer i     = 0

            if FirstOfGroup(g) == null then 
                return null 
            endif 
            // 空组直接返回 null
            if count <= 0 then
                return null
            endif

            // 生成随机索引 [0, count-1]
            set pickIndex = GetRandomInt(0, count - 1)

            // 复制到复用组（不破坏原组）
            call GroupClear(ENUM_GROUP)
            call GroupAddGroup(g, ENUM_GROUP)

            // 遍历找第 pickIndex 个单位
            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null or i > count
                call GroupRemoveUnit(ENUM_GROUP, u)

                if i == pickIndex then
                    // 找到目标，存入返回值
                    set RETURN_UNIT = u
                    set u = null
                    return RETURN_UNIT
                endif
                set i = i + 1
                // 非目标单位直接丢弃（已在 ENUM_GROUP 中移除）
            endloop

            // 理论上不会执行
            set u = null
            return null
        endfunction

        function PathCheck takes real x,real y returns boolean
            local boolean result = false 
            local location loc = Location(x,y)
            call SetItemVisible(PATH_CHECKER,true)
            call SetItemPositionLoc(PATH_CHECKER,loc)
            if DisByXY(x,y,GetItemX(PATH_CHECKER),GetItemY(PATH_CHECKER)) < 16 then 
                set result = true 
            else 
                set result = false 
            endif 
            call RemoveLocation(loc)
            set loc = null 
            call SetItemVisible(PATH_CHECKER,false)
            return result
        endfunction
        ///////
        ///////
        //遗物等级生成
        // 函数：计算最大可能等级
        function CalculateMaxLevel takes integer riftLevel returns integer
            local integer scaled = R2I(riftLevel * LEVEL_SCALE)  // floor(rift_level * (50 / 15))
            local integer maxLvl = MAX_LOW_LEVEL + scaled
            if maxLvl > MAX_RELIC_LEVEL then
                set maxLvl = MAX_RELIC_LEVEL
            endif
            return maxLvl
        endfunction

        // 函数：计算权重
        function CalculateWeight takes integer level, real mu, real sigma returns real
            local real diff = I2R(level) - mu
            local real sigma2 = sigma * sigma
            local real exponent = - (diff * diff) / (2.0 * sigma2)
            local real weight = Pow(E, exponent)
            return weight
        endfunction

        // 函数：生成遗物等级
        function relicGetLevel takes nothing returns integer
            local integer riftLevel = MAP_EXTRA_LEVEL
            local integer maxLvl = CalculateMaxLevel(riftLevel)
            local real mu = MU_BASE + (I2R(riftLevel) / LEVEL_DIVISOR) * MU_SCALE
            local real sigma = SIGMA_BASE + (I2R(riftLevel) / LEVEL_DIVISOR) * SIGMA_SCALE
            local real totalWeight = 0.0
            local integer level = MIN_RELIC_LEVEL
            local real rand = GetRandomReal(0.0, 1.0)  // 随机数 [0,1)
            local real cumulative = 0.0
            local real weight
            
            // 先计算总权重
            loop
                exitwhen level > maxLvl
                set weight = CalculateWeight(level, mu, sigma)
                set totalWeight = totalWeight + weight
                set level = level + 1
            endloop
            
            // 如果总权重为0（理论上不可能），设为1
            if totalWeight == 0.0 then
                set totalWeight = 1.0
            endif
            
            // 重置 level 并计算累积概率
            set level = MIN_RELIC_LEVEL
            loop
                exitwhen level > maxLvl
                set weight = CalculateWeight(level, mu, sigma)
                set cumulative = cumulative + (weight / totalWeight)
                if rand < cumulative then
                    return level
                endif
                set level = level + 1
            endloop
            
            // 理论上不会到达这里，但作为安全返回最低级
            return MIN_RELIC_LEVEL
        endfunction
        ///////
        ///////
        function IsUnitElite takes unit whichUnit returns boolean
            return IsUnitType(whichUnit,UNIT_TYPE_TAUREN)
        endfunction
        function IsUnitBoss takes unit whichUnit returns boolean
            return IsUnitType(whichUnit,UNIT_TYPE_GIANT)
        endfunction

        function Condition_playerEnemyCombat takes nothing returns boolean
            return inCombat(GetFilterUnit()) and (IsUnitEnemy(GetFilterUnit(),PLAYER) == true) and (IsUnitType(GetFilterUnit(),UNIT_TYPE_ANCIENT) == false) and alive(GetFilterUnit())
        endfunction
        function Condition_playerEnemy takes nothing returns boolean
            return (IsUnitEnemy(GetFilterUnit(),PLAYER) == true) and (IsUnitType(GetFilterUnit(),UNIT_TYPE_ANCIENT) == false) and alive(GetFilterUnit())
        endfunction

        function Condition_playerAlly takes nothing returns boolean
            return (IsUnitAlly(GetFilterUnit(),PLAYER) == true) and (IsUnitType(GetFilterUnit(),UNIT_TYPE_ANCIENT) == false) and alive(GetFilterUnit())
        endfunction

        function Condition_groupEnumLegal takes nothing returns boolean
            return alive(GetFilterUnit()) and IsUnitType(GetFilterUnit(),UNIT_TYPE_ANCIENT) == false 
        endfunction

        function Condition_groupEnumLegal_Bounce takes nothing returns boolean
            return alive(GetFilterUnit()) and (IsUnitType(GetFilterUnit(),UNIT_TYPE_ANCIENT) == false or GetUnitTypeId(GetFilterUnit()) == 'hBNC')
        endfunction

        function Condition_blockMissile takes nothing returns boolean
            return GetUnitTypeId(GetFilterUnit()) == 'hBLK' and IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(projectile.currentProjectile.source))
        endfunction

        function Condition_playerHero takes nothing returns boolean
            return IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO) and alive(GetFilterUnit()) and (IsUnitType(GetFilterUnit(),UNIT_TYPE_ANCIENT) == false) and (GetOwningPlayer(GetFilterUnit()) == PLAYER)
        endfunction

        function Condition_autoGateFilter takes nothing returns boolean
            return (IsUnitType(GetFilterUnit(),UNIT_TYPE_SAPPER) or IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)) and alive(GetFilterUnit()) and (IsUnitType(GetFilterUnit(),UNIT_TYPE_ANCIENT) == false) and (GetOwningPlayer(GetFilterUnit()) == PLAYER)
        endfunction

        function Condition_bossResetFilter takes nothing returns boolean
            return IsUnitInRegion(eventBoss.region,GetFilterUnit()) and IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO) and alive(GetFilterUnit()) and (IsUnitType(GetFilterUnit(),UNIT_TYPE_ANCIENT) == false) and (GetOwningPlayer(GetFilterUnit()) == PLAYER)
        endfunction

        function Condition_isInnSelected takes nothing returns boolean
            return GetUnitTypeId(GetFilterUnit()) == 'ugol'
        endfunction

        function GetUnitIcon takes unit whichUnit returns string 
            local string str = LoadStr(globalHashtable,GetUnitTypeId(whichUnit),StringHash("ICON"))
            set whichUnit = null 
            return str 
        endfunction
        function SetUnitTypeIcon takes integer unitTypeId,string icon returns nothing
            call SaveStr(globalHashtable,unitTypeId,StringHash("ICON"),icon)
        endfunction
        
        function UnitLevel takes unit whichUnit returns integer 
            local minion mini = minion.getMinionByUnit(whichUnit)
            local integer result = GetUnitLevel(whichUnit)
            local integer minMapLevel = MAP_ENEMY_MIN_LEVEL
            if IsUnitEnemy(whichUnit,PLAYER) then 
                if IsUnitElite(whichUnit) then 
                    set minMapLevel = minMapLevel+1
                endif 
                if IsUnitBoss(whichUnit) then 
                    set minMapLevel = minMapLevel+2
                endif 
                set result = IMinBJ(25,IMaxBJ(Enemy.getEnemy(whichUnit).originalLevel,minMapLevel))
            endif 
            if mini > 0 then 
                set result = IMaxBJ(result,GetUnitLevel(mini.mast.masterUnit))
            endif 
            set whichUnit = null 
            return result
        endfunction

        function AddLightningSimple takes string lsfx,boolean check,real x1,real y1,real x2,real y2 returns lightning
            set ActivingLightning[LightningIndex] = AddLightning(lsfx,check,x1,y1,x2,y2)
            set lastCreatedLightning = ActivingLightning[LightningIndex]
            set LightningIndex = LightningIndex+1
            return lastCreatedLightning
        endfunction
        struct Lightning 
            static Lightning top = 0
            Lightning prev 
            Lightning next 
            lightning lt            = null 
            boolean isFromUnit      = false 
            boolean isToUnit        = false 
            boolean removeWhenDeath = false 
            boolean DESTROY         = false 
            string lsfx             = ""
            real fx                 = 0
            real fy                 = 0
            real fz                 = 0
            real tx                 = 0
            real ty                 = 0
            real tz                 = 0
            unit fromUnit           = null 
            unit toUnit             = null 
            real afx                = 0
            real afy                = 0 
            real afz                = 0
            real atx                = 0
            real aty                = 0
            real atz                = 0
            real R                  = 1
            real G                  = 1
            real B                  = 1
            real A                  = 1
            integer time            = 0
            integer fadeTime        = 0

            static method create takes nothing returns Lightning
                local thistype this = thistype.allocate()
                set this.prev = thistype.top 
                if this.prev > 0 then 
                    set this.prev.next = this 
                endif   
                set this.next = 0
                set thistype.top = this 
                return this 
            endmethod

            static method createU2U takes unit from,unit to,string lsfx,real afx,real afy,real afz,real atx,real aty,real atz,integer time,integer fadeTime,boolean rwd returns Lightning
                local thistype this         = thistype.create()
                local location loc          = null 
                local real a 
                set this.isFromUnit         = true 
                set this.isToUnit           = true 
                set this.fromUnit           = from 
                set this.toUnit             = to 
                set this.removeWhenDeath    = rwd
                set this.time               = time 
                set this.fadeTime           = fadeTime
                set this.afx                = afx 
                set this.afy                = afy 
                set this.afz                = afz 
                set this.atx                = atx 
                set this.aty                = aty 
                set this.atz                = atz 
                set this.lsfx               = lsfx 
                set a                       = GetUnitFacing(this.fromUnit)/57.2956
                set this.fx                 = GetUnitX(this.fromUnit)+this.afx*Cos(a)-this.afy*Sin(a)
                set this.fy                 = GetUnitY(this.fromUnit)+this.afx*Sin(a)+this.afy*Cos(a)
                set loc                     = Location(this.fx,this.fy)
                set this.fz                 = GetUnitFlyHeight(this.fromUnit)+GetLocationZ(loc)+this.afz
                call RemoveLocation(loc)
                set loc = null 
                set a                       = GetUnitFacing(this.toUnit)/57.2956
                set this.tx                 = GetUnitX(this.toUnit)+this.atx+this.atx*Cos(a)-this.aty*Sin(a)
                set this.ty                 = GetUnitY(this.toUnit)+this.aty+this.atx*Sin(a)+this.aty*Cos(a)
                set loc                     = Location(this.tx,this.ty)
                set this.tz                 = GetUnitFlyHeight(this.toUnit)+GetLocationZ(loc)+this.atz
                call RemoveLocation(loc)
                set loc = null 
                set this.lt                 = AddLightningEx(lsfx,false,this.fx,this.fy,this.fz,this.tx,this.ty,this.tz)
                return this 
            endmethod
            static method createU2L takes unit from,string lsfx,real afx,real afy,real afz,real atx,real aty,real atz,integer time,integer fadeTime,boolean rwd returns Lightning
                local thistype this         = thistype.create()
                local location loc          = null 
                local real a 
                set this.isFromUnit         = true 
                set this.isToUnit           = false 
                set this.fromUnit           = from 
                set this.toUnit             = null 
                set this.removeWhenDeath    = rwd
                set this.time               = time 
                set this.fadeTime           = fadeTime
                set this.afx                = afx 
                set this.afy                = afy 
                set this.afz                = afz 
                set this.atx                = atx 
                set this.aty                = aty 
                set this.atz                = atz 
                set this.lsfx               = lsfx 
                set a                       = GetUnitFacing(this.fromUnit)/57.2956
                set this.fx                 = GetUnitX(this.fromUnit)+this.afx+this.afx*Cos(a)-this.afy*Sin(a)
                set this.fy                 = GetUnitY(this.fromUnit)+this.afy+this.afx*Sin(a)+this.afy*Cos(a)
                set loc                     = Location(this.fx,this.fy)
                set this.fz                 = GetUnitFlyHeight(this.fromUnit)+GetLocationZ(loc)+this.afz
                call RemoveLocation(loc)
                set loc = null 
                set this.tx                 = this.atx
                set this.ty                 = this.aty
                set loc                     = Location(this.tx,this.ty)
                set this.tz                 = GetLocationZ(loc)+this.atz
                call RemoveLocation(loc)
                set loc = null 
                set this.lt                 = AddLightningEx(lsfx,false,this.fx,this.fy,this.fz,this.tx,this.ty,this.tz)
                return this 
            endmethod
            static method createL2L takes string lsfx,real afx,real afy,real afz,real atx,real aty,real atz,integer time,integer fadeTime,boolean rwd returns Lightning
                local thistype this         = thistype.create()
                local location loc          = null 
                set this.isFromUnit         = false
                set this.isToUnit           = false 
                set this.fromUnit           = null 
                set this.toUnit             = null 
                set this.removeWhenDeath    = rwd
                set this.time               = time 
                set this.fadeTime           = fadeTime
                set this.afx                = afx 
                set this.afy                = afy 
                set this.afz                = afz 
                set this.atx                = atx 
                set this.aty                = aty 
                set this.atz                = atz 
                set this.fx                 = this.afx
                set this.fy                 = this.afy
                set this.lsfx               = lsfx 
                set loc                     = Location(this.fx,this.fy)
                set this.fz                 = GetLocationZ(loc)+this.afz
                call RemoveLocation(loc)
                set loc = null 
                set this.tx                 = this.atx
                set this.ty                 = this.aty
                set loc                     = Location(this.tx,this.ty)
                set this.tz                 = GetLocationZ(loc)+this.atz
                call RemoveLocation(loc)
                set loc = null 
                set this.lt                 = AddLightningEx(lsfx,false,this.fx,this.fy,this.fz,this.tx,this.ty,this.tz)
                return this 
            endmethod
            static method createL2U takes unit to,string lsfx,real afx,real afy,real afz,real atx,real aty,real atz,integer time,integer fadeTime,boolean rwd returns Lightning
                local thistype this         = thistype.create()
                local location loc          = null 
                local real a 
                set this.isFromUnit         = false
                set this.isToUnit           = true 
                set this.fromUnit           = null
                set this.toUnit             = to 
                set this.removeWhenDeath    = rwd
                set this.time               = time 
                set this.fadeTime           = fadeTime
                set this.afx                = afx 
                set this.afy                = afy 
                set this.afz                = afz 
                set this.atx                = atx 
                set this.aty                = aty 
                set this.atz                = atz 
                set this.fx                 = this.afx
                set this.fy                 = this.afy
                set this.lsfx               = lsfx 
                set loc                     = Location(this.fx,this.fy)
                set this.fz                 = GetLocationZ(loc)+this.afz
                call RemoveLocation(loc)
                set loc = null 
                set a                       = GetUnitFacing(this.toUnit)/57.2956
                set this.tx                 = GetUnitX(this.toUnit)+this.atx*Cos(a)-this.aty*Sin(a)
                set this.ty                 = GetUnitY(this.toUnit)+this.atx*Sin(a)+this.aty*Cos(a)
                set loc                     = Location(this.tx,this.ty)
                set this.tz                 = GetUnitFlyHeight(this.toUnit)+GetLocationZ(loc)+this.atz
                call RemoveLocation(loc)
                set loc = null 
                set this.lt                 = AddLightningEx(lsfx,false,this.fx,this.fy,this.fz,this.tx,this.ty,this.tz)
                return this 
            endmethod

            method onDestroy takes nothing returns nothing
                if thistype.top == this then 
                    set thistype.top = this.prev 
                endif 
                if this.next > 0 then 
                    set this.next.prev = this.prev 
                endif 
                if this.prev > 0 then 
                    set this.prev.next = this.next 
                endif 
                if this.lt != null then 
                    call DestroyLightning(this.lt)
                endif 
                set this.fromUnit   = null 
                set this.toUnit     = null 
                set this.lt         = null 
            endmethod

            method setColor takes real r,real g,real b,real a returns nothing
                set this.R = r
                set this.G = g 
                set this.B = b 
                set this.A = a 
                call SetLightningColor(this.lt,this.R,this.G,this.B,this.A)
            endmethod

            method update takes nothing returns nothing
                local location loc          = null 
                local real a 
                set this.time = this.time-1
                if this.isFromUnit then 
                    if (this.fromUnit == null or alive(this.fromUnit) == false) and this.removeWhenDeath then 
                        set this.time = this.fadeTime
                    elseif this.fromUnit != null then 
                        set a = GetUnitFacing(this.fromUnit) * bj_DEGTORAD

                        set this.fx = GetUnitX(this.fromUnit) + this.afx * Cos(a) - this.afy * Sin(a)
                        set this.fy = GetUnitY(this.fromUnit) + this.afx * Sin(a) + this.afy * Cos(a)

                        set loc = Location(this.fx, this.fy)
                        set this.fz = GetUnitFlyHeight(this.fromUnit) + GetLocationZ(loc) + this.afz
                        call RemoveLocation(loc)
                        set loc = null
                    endif 
                endif 
                if this.isToUnit then 
                    if (this.toUnit == null or alive(this.toUnit) == false) and this.removeWhenDeath then 
                        set this.time = this.fadeTime
                    elseif this.toUnit != null then 
                        set a = GetUnitFacing(this.toUnit) * bj_DEGTORAD

                        set this.tx = GetUnitX(this.toUnit) + this.atx * Cos(a) - this.aty * Sin(a)
                        set this.ty = GetUnitY(this.toUnit) + this.atx * Sin(a) + this.aty * Cos(a)

                        set loc = Location(this.tx, this.ty)
                        set this.tz = GetUnitFlyHeight(this.toUnit) + GetLocationZ(loc) + this.atz
                        call RemoveLocation(loc)
                        set loc = null
                    endif 
                endif 
                if this.time <= this.fadeTime and this.fadeTime > 0 then 
                    set this.A = this.A-this.A/I2R(this.time)
                endif 
                if loadinggame then 
                    if this.lt != null then 
                        call SetLightningColor(this.lt,0,0,0,0)
                        set this.lt = null 
                    endif 
                    set this.lt = AddLightningEx(this.lsfx,false,this.fx,this.fy,this.fz,this.tx,this.ty,this.tz)
                    call SetLightningColor(this.lt,this.R,this.G,this.B,this.A)
                else 
                    if this.lt != null then 
                        call MoveLightningEx(this.lt,false,this.fx,this.fy,this.fz,this.tx,this.ty,this.tz)
                        call SetLightningColor(this.lt,this.R,this.G,this.B,this.A)
                    else 
                        set this.lt = AddLightningEx(this.lsfx,false,this.fx,this.fy,this.fz,this.tx,this.ty,this.tz)
                        call SetLightningColor(this.lt,this.R,this.G,this.B,this.A)
                    endif 
                endif 
                if this.time <= 0 then 
                    set this.DESTROY = true 
                endif 
                if this.DESTROY then 
                    call this.destroy()
                endif 
            endmethod

            static method updateAll takes nothing returns nothing
                local thistype this = thistype.top 
                loop
                    exitwhen this == 0
                    call this.update()
                    set this = this.prev 
                endloop
            endmethod
        endstruct

        function AddLightningPlus takes string lsfx,boolean check,real x1,real y1,real z1,real x2,real y2,real z2 returns lightning
            set ActivingLightning[LightningIndex] = AddLightningEx(lsfx,check,x1,y1,z1,x2,y2,z2)
            set lastCreatedLightning = ActivingLightning[LightningIndex]
            set LightningIndex = LightningIndex+1
            return lastCreatedLightning
        endfunction
        function DestroyLightningEx takes lightning lt returns nothing
            local integer i = 0
            local integer b = -1
            loop
                exitwhen i>LightningIndex
                if ActivingLightning[i]==lt then
                    set b=i
                endif
                set i=i+1
            endloop
            if b!=-1 then
                set ActivingLightning[b]=ActivingLightning[LightningIndex]
                set LightningIndex = LightningIndex-1
            endif
            if lt!=null then
                call DestroyLightning(lt)
            endif
            set lt = null
        endfunction
        function LightningSFXEX takes nothing returns nothing
            local unit u1 = delayedevent.currentEvent.loadUnit("UNIT_1")
            local unit u2 = delayedevent.currentEvent.loadUnit("UNIT_2")
            local real x1 = GetUnitX(u1)
            local real y1 = GetUnitY(u1)
            local real x2 = GetUnitX(u2)
            local real y2 = GetUnitY(u2)
            local real z1 = GetUnitFlyHeight(u1)+delayedevent.currentEvent.loadReal("Z_1")
            local real z2 = GetUnitFlyHeight(u2)+delayedevent.currentEvent.loadReal("Z_2")
            local real xx1 = delayedevent.currentEvent.loadReal("XX_1")
            local real xx2 = delayedevent.currentEvent.loadReal("XX_2")
            local real yy1 = delayedevent.currentEvent.loadReal("YY_1")
            local real yy2 = delayedevent.currentEvent.loadReal("YY_1")
            local real face1 = GetUnitFacing(u1)
            local real face2 = GetUnitFacing(u2)
            local integer ktime = delayedevent.currentEvent.loadInteger("K_TIME")
            local integer count = delayedevent.currentEvent.loadInteger("COUNT")
            local real fx1
            local real fx2
            local real fy1
            local real fy2
            local real fz1
            local real fz2
            local real a
            local real d
            local boolean rwd = delayedevent.currentEvent.loadBoolean("REMOVE_WHEN_DEATH")
            local real lsx1 = delayedevent.currentEvent.loadReal("LSX_1")
            local real lsy1 = delayedevent.currentEvent.loadReal("LSY_1")
            local real lsz1 = delayedevent.currentEvent.loadReal("LSZ_1")
            local real lsx2 = delayedevent.currentEvent.loadReal("LSX_2")
            local real lsy2 = delayedevent.currentEvent.loadReal("LSY_2")
            local real lsz2 = delayedevent.currentEvent.loadReal("LSZ_2")
            local lightning tempLightning = delayedevent.currentEvent.loadLightning("LIGHTNING")
            local location tempLoc
            
            if alive(u1) and u1 != null then
                set tempLoc = Location(x1,y1)
                set fz1 = z1+GetLocationZ(tempLoc)
                call RemoveLocation(tempLoc)
                set a = face1/57.2956
                set fx1 = x1+xx1*Cos(a)
                set fy1 = y1+xx1*Sin(a)
                set fx1 = x1+yy1*Cos(a-1.5708)
                set fy1 = y1+yy1*Sin(a-1.5708)
            else
                set fx1 = lsx1
                set fy1 = lsy1
                set fz1 = lsz1
            endif
            if alive(u2) and u2 != null then
                set tempLoc = Location(x2,y2)
                set fz2 = z2+GetLocationZ(tempLoc)
                call RemoveLocation(tempLoc)
                set a = face2/57.2956
                set fx2 = x2+xx2*Cos(a)
                set fy2 = y2+xx2*Sin(a)
                set fx2 = x2+yy2*Cos(a-1.5708)
                set fy2 = y2+yy2*Sin(a-1.5708)
            else
                set fx2 = lsx2
                set fy2 = lsy2
                set fz2 = lsz2
            endif
            set count = count-1
            call delayedevent.currentEvent.saveInteger("COUNT",count)
            call delayedevent.currentEvent.saveReal("LSX_1",fx1)
            call delayedevent.currentEvent.saveReal("LSY_1",fy1)
            call delayedevent.currentEvent.saveReal("LSZ_1",fz1)
            call delayedevent.currentEvent.saveReal("LSX_2",fx2)
            call delayedevent.currentEvent.saveReal("LSY_2",fy2)
            call delayedevent.currentEvent.saveReal("LSZ_2",fz2)
            if loadinggame == false then
                call MoveLightningEx(tempLightning,true,fx1,fy1,fz1,fx2,fy2,fz2)
                //////////call BJDebugMsg("x1:"+R2S(fx1)+" y1:"+R2S(fy1)+" z1:"+R2S(fz1)+" x2:"+R2S(fx2)+" y2:"+R2S(fy2)+" z1:"+R2S(fz2))
                if count < ktime then
                    call SetLightningColor(tempLightning,GetLightningColorR(tempLightning),GetLightningColorG(tempLightning),GetLightningColorB(tempLightning),1-(I2R(ktime-count)/RMaxBJ(1,I2R(ktime))))
                endif
                if (rwd and (u1 == null or u2 == null or alive(u1) == false or alive(u2)==false)) or count <= 0 then
                    call DestroyLightningEx(tempLightning)
                    set delayedevent.currentEvent.DESTROY = true 
                endif
            else 
                set delayedevent.currentEvent.DESTROY = true 
            endif

            set tempLightning = null 
            set tempLoc = null
        endfunction

        function UnitsAddLightningSFX takes unit u1,real xx1,real yy1,real z1,unit u2,real xx2,real yy2,real z2,string lsfx,real time,real ktime,boolean rwd returns Lightning
            return Lightning.createU2U(u1,u2,lsfx,xx1,yy1,z1,xx2,yy2,z2,R2I(time*100),R2I(ktime*100),rwd)
        endfunction

        //角度制，实际范围是二倍角度值
        function isBackStab takes unit source,unit target,real angle returns boolean
            return Cos((AngleByUnits(source,target)-GetUnitFacing(target))/57.2956) > Cos(angle/57.2956)
        endfunction

        function AddUnitLife takes unit whichUnit,real value returns nothing
            call SetUnitState(whichUnit,UNIT_STATE_LIFE,GetUnitState(whichUnit,UNIT_STATE_LIFE)+value)
        endfunction
        function AddUnitMana takes unit whichUnit,real value returns nothing
            call SetUnitState(whichUnit,UNIT_STATE_MANA,GetUnitState(whichUnit,UNIT_STATE_MANA)+value)
        endfunction
        function UnitLifeP takes unit whichUnit returns real 
            return GetUnitState(whichUnit,UNIT_STATE_LIFE)/GetUnitState(whichUnit,UNIT_STATE_MAX_LIFE)
        endfunction
        function UnitManaP takes unit whichUnit returns real 
            return GetUnitState(whichUnit,UNIT_STATE_MANA)/GetUnitState(whichUnit,UNIT_STATE_MAX_MANA)
        endfunction

        function GetUnitAttack takes unit whichUnit,integer index returns integer
            local integer damageDice = BlzGetUnitWeaponIntegerField(whichUnit,UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE,index)
            local integer attackDamage = BlzGetUnitWeaponIntegerField(whichUnit,UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE,index)
            local integer damageDiceSide = BlzGetUnitWeaponIntegerField(whichUnit,UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE,index)
            local integer bonusAttack = unitGetAllBonusStateValue(whichUnit,STATE_ATTACK)
            local integer i = 1
            loop 
                exitwhen i > damageDice
                set attackDamage = attackDamage+GetRandomInt(1,damageDiceSide)
                set i = i+1
            endloop
            return attackDamage+bonusAttack
        endfunction

        function GetUnitMinAttack takes unit whichUnit,integer index returns integer
            local integer damageDice = BlzGetUnitWeaponIntegerField(whichUnit,UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE,index)
            local integer attackDamage = BlzGetUnitWeaponIntegerField(whichUnit,UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE,index)
            local integer bonusAttack = unitGetAllBonusStateValue(whichUnit,STATE_ATTACK)
            return attackDamage+damageDice+bonusAttack
        endfunction
        function GetUnitMaxAttack takes unit whichUnit,integer index returns integer
            local integer damageDice = BlzGetUnitWeaponIntegerField(whichUnit,UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE,index)
            local integer attackDamage = BlzGetUnitWeaponIntegerField(whichUnit,UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE,index)
            local integer damageDiceSide = BlzGetUnitWeaponIntegerField(whichUnit,UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE,index)
            local integer bonusAttack = unitGetAllBonusStateValue(whichUnit,STATE_ATTACK)
            return attackDamage+damageDice*damageDiceSide+bonusAttack
        endfunction

        private function init takes nothing returns nothing
            call SetMapFlag(MAP_CHEATS,false)
            call SetMapFlag(MAP_CHEATS_HIDDEN,true)
            set heroName[0] = "先锋"
            set heroName[1] = "圣骑士"
            set heroName[2] = "角斗士"
            set heroName[3] = "机械师"
            set heroName[4] = "巡林人"
            set heroName[5] = "刺客"
            set heroName[6] = "法师"
            set heroName[7] = "牧师"
            set heroName[8] = "德鲁伊"
            set heroName[9] = "死亡骑士"
            set heroName[10] = "魔战士"
            set heroName[11] = "贤者"
            set heroName[12] = "魔巫"
            set heroName[13] = "恶魔猎手"
            set heroName[14] = "武僧"
            set heroName[15] = "女巫"
        endfunction

    endlibrary

    library LeaveMap initializer init requires basic

        globals
            Entrance eventEntrance = 0
            boolean enableEntrance = true 
            integer lastEnterTime  = 0
        endglobals
        struct Entrance
            static thistype top = 0
            Entrance prev
            boolean active
            rect area 
            dialog dialog 
            button btnConfirm 
            button btnCancel 
            integer home
            integer targetIndex  
            trigger trigEnterArea
            trigger trigClickBtn 
            string mapPath

            static method delayedEnterMap takes nothing returns nothing
                call DestroyTimer(GetExpiredTimer())
                call ChangeLevel(eventEntrance.mapPath,false)
            endmethod
            
            static method confirmEnterMap takes nothing returns nothing
                local thistype this = eventEntrance
                call StoreInteger(gameCache,"MAP_"+I2S(this.targetIndex),"ENTER",this.home)
                call save.execute()
                call CheckPoint("EnterMapAutoSave",true)
                call TimerStart(CreateTimer(),2,false,function Entrance.delayedEnterMap)
                set enableEntrance = false 
            endmethod

            method Leave takes nothing returns nothing
                if globalNowtime-lastEnterTime > 300 and enableEntrance and this.active then 
                    set eventEntrance = this
                    set lastEnterTime = globalNowtime
                    call DialogDisplay(PLAYER,this.dialog,true)
                endif 
            endmethod

            static method enterMapZone takes nothing returns nothing
                local thistype this = thistype.top 
                call DisableTrigger(GetTriggeringTrigger())
                if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) then 
                    loop 
                        exitwhen this == 0
                        if this.trigEnterArea == GetTriggeringTrigger() then 
                            exitwhen true 
                        endif 
                        set this = this.prev
                    endloop
                    if globalNowtime-lastEnterTime > 300 and enableEntrance and this.active then 
                        set eventEntrance = this
                        set lastEnterTime = globalNowtime
                        call DialogDisplay(PLAYER,this.dialog,true)
                    endif 
                endif 
                call EnableTrigger(GetTriggeringTrigger())
            endmethod
            
            static method create takes rect area,string mapName,string mapPath,integer home,integer targetIndex returns Entrance 
                local thistype this = thistype.allocate()
                set this.area = area 
                set this.dialog = DialogCreate()
                set this.btnConfirm = DialogAddButtonBJ(this.dialog,"是")
                set this.btnCancel = DialogAddButtonBJ(this.dialog,"否")
                call DialogSetMessage(this.dialog,"前往：|cffffcc00"+mapName+"|r？")
                set this.mapPath = mapPath
                set this.home = home
                set this.targetIndex = targetIndex
                set this.active = true 
                set this.trigEnterArea = CreateTrigger()
                call TriggerRegisterEnterRectSimple(this.trigEnterArea,this.area)
                call TriggerAddAction(this.trigEnterArea,function Entrance.enterMapZone)
                set this.trigClickBtn = CreateTrigger()
                call TriggerRegisterDialogButtonEvent(this.trigClickBtn,this.btnConfirm)
                call TriggerAddAction(this.trigClickBtn,function Entrance.confirmEnterMap)
                set this.prev = thistype.top
                set thistype.top = this 
                return this 
            endmethod   
            
            static method createSimple takes string mapName,string mapPath,integer home,integer targetIndex returns Entrance 
                local thistype this = thistype.allocate()
                set this.area = null 
                set this.dialog = DialogCreate()
                set this.btnConfirm = DialogAddButtonBJ(this.dialog,"是")
                set this.btnCancel = DialogAddButtonBJ(this.dialog,"否")
                call DialogSetMessage(this.dialog,"前往：|cffffcc00"+mapName+"|r？")
                set this.mapPath = mapPath
                set this.home = home
                set this.targetIndex = targetIndex
                set this.active = true 
                set this.trigClickBtn = CreateTrigger()
                call TriggerRegisterDialogButtonEvent(this.trigClickBtn,this.btnConfirm)
                call TriggerAddAction(this.trigClickBtn,function Entrance.confirmEnterMap)
                set this.prev = thistype.top
                set thistype.top = this 
                return this 
            endmethod   

        endstruct

        function CreateEntrance takes rect area,string mapName,string mapPath,integer enter,integer targetMapIndex returns Entrance 
            return Entrance.create(area,mapName,mapPath,enter,targetMapIndex)
        endfunction
        function CreateEntranceSimple takes string mapName,string mapPath,integer enter,integer targetMapIndex returns Entrance 
            return Entrance.createSimple(mapName,mapPath,enter,targetMapIndex)
        endfunction

        private function init takes nothing returns nothing

        endfunction
    endlibrary

    library SettingsMenu initializer Init

        globals
            // ========== 设置变量（可直接在外部引用） ==========
            boolean Settings_FloatDamage       = true
            boolean Settings_FloatHeal         = true
            boolean Settings_FloatDot          = true
            boolean Settings_FloatMinionDamage = true
            boolean Settings_FloatHot          = true
            boolean Settings_FloatMinionHeal   = true
            boolean Settings_FloatNoCrit       = false

            boolean Settings_CombatBossStart   = false
            boolean Settings_CombatBossEnd     = false

            boolean Settings_AutoAttack        = true
            boolean Settings_AutoHeal          = true
            boolean Settings_AutoBerserk       = false

            boolean Settings_OtherFullMap      = false
            boolean Settings_OtherMusic        = true
            integer Settings_OtherMusicMode    = 0      // 0=循环, 1=随机
            boolean Settings_OtherAutoSave     = false
            integer Settings_OtherSaveInterval = 30
            integer Settings_OtherSaveLimit    = 1
            boolean Settings_OtherCloseSearch  = false 
            boolean Settings_OtherNewFrameMode = false 

            // ========== 对话框与菜单状态 ==========
            private dialog   g_dialog         = null
            private integer  g_currentMenu    = 0
            private trigger  g_chatTrigger    = null

            // ========== 按钮触发器映射（全局数组） ==========
            private trigger  array g_btnTriggers   // 存储每个按钮的触发器
            private integer  array g_btnIds        // 存储对应的按钮ID
            private integer  g_btnCount = 0        // 当前按钮数量
            private constant integer MAX_BUTTONS = 50

            private constant player MAIN_PLAYER = Player(0)
        endglobals

        // ========== 按钮 ID 常量 ==========
        globals
            private constant integer ID_MAIN_FLOAT    = 0
            private constant integer ID_MAIN_COMBAT   = 1
            private constant integer ID_MAIN_AUTOCAST = 2
            private constant integer ID_MAIN_OTHER    = 3
            private constant integer ID_MAIN_EXIT     = 4

            private constant integer ID_SUB0_DAMAGE       = 10
            private constant integer ID_SUB0_HEAL         = 11
            private constant integer ID_SUB0_DOT          = 12
            private constant integer ID_SUB0_MINION_DMG   = 13
            private constant integer ID_SUB0_HOT          = 14
            private constant integer ID_SUB0_MINION_HEAL  = 15
            private constant integer ID_SUB0_NOCRIT       = 16
            private constant integer ID_SUB0_RETURN       = 17

            private constant integer ID_SUB1_BOSSSTART    = 20
            private constant integer ID_SUB1_BOSSEND      = 21
            private constant integer ID_SUB1_RETURN       = 22

            private constant integer ID_SUB2_ATTACK       = 30
            private constant integer ID_SUB2_HEAL         = 31
            private constant integer ID_SUB2_BERSERK      = 32
            private constant integer ID_SUB2_RETURN       = 33

            private constant integer ID_SUB3_FULLMAP      = 40
            private constant integer ID_SUB3_MUSIC        = 41
            private constant integer ID_SUB3_MUSICMODE    = 42
            private constant integer ID_SUB3_AUTOSAVE     = 43
            private constant integer ID_SUB3_SAVEINTERVAL = 44
            private constant integer ID_SUB3_SAVELIMIT    = 45
            private constant integer ID_SUB3_RETURN       = 46
            private constant integer ID_SUB3_CLOSESEARCH  = 47
            private constant integer ID_SUB3_NEWFRAMEMODE = 58

            private constant integer ID_INVALID = -1
        endglobals

        // ========== 辅助函数 ==========
        private function Iif takes boolean cond, string trueStr, string falseStr returns string
            if cond then
                return trueStr
            endif
            return falseStr
        endfunction

        // ========== 统一的按钮点击动作（通过 GetTriggeringTrigger 识别） ==========
        private function OnButtonClick takes nothing returns nothing
            local trigger t = GetTriggeringTrigger()
            local integer i = 0
            local integer id = ID_INVALID

            loop
                exitwhen i >= g_btnCount
                if g_btnTriggers[i] == t then
                    set id = g_btnIds[i]
                    exitwhen true
                endif
                set i = i + 1
            endloop

            if id != ID_INVALID then
                call HandleButtonClick.evaluate(id)
            endif
        endfunction

        // ========== 为按钮创建触发器并注册事件 ==========
        private function CreateButtonTrigger takes button btn, integer id returns nothing
            local trigger t = CreateTrigger()
            call TriggerRegisterDialogButtonEvent(t, btn)
            call TriggerAddAction(t, function OnButtonClick)
            set g_btnTriggers[g_btnCount] = t
            set g_btnIds[g_btnCount] = id
            set g_btnCount = g_btnCount + 1
        endfunction

        // ========== 销毁所有已注册的按钮触发器 ==========
        private function ClearButtonTriggers takes nothing returns nothing
            local integer i = 0
            loop
                exitwhen i >= g_btnCount
                call DestroyTrigger(g_btnTriggers[i])
                set g_btnTriggers[i] = null
                set i = i + 1
            endloop
            set g_btnCount = 0
        endfunction

        private function GetSettingText takes integer id returns string
            if id == ID_SUB0_DAMAGE then
                return Iif(Settings_FloatDamage, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB0_HEAL then
                return Iif(Settings_FloatHeal, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB0_DOT then
                return Iif(Settings_FloatDot, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB0_MINION_DMG then
                return Iif(Settings_FloatMinionDamage, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB0_HOT then
                return Iif(Settings_FloatHot, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB0_MINION_HEAL then
                return Iif(Settings_FloatMinionHeal, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB0_NOCRIT then
                return Iif(Settings_FloatNoCrit, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB1_BOSSSTART then
                return Iif(Settings_CombatBossStart, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB1_BOSSEND then
                return Iif(Settings_CombatBossEnd, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB2_ATTACK then
                return Iif(Settings_AutoAttack, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB2_HEAL then
                return Iif(Settings_AutoHeal, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB2_BERSERK then
                return Iif(Settings_AutoBerserk, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB3_FULLMAP then
                return Iif(Settings_OtherFullMap, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB3_MUSIC then
                return Iif(Settings_OtherMusic, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB3_MUSICMODE then
                return Iif(Settings_OtherMusicMode == 0, "循环", "随机")
            elseif id == ID_SUB3_AUTOSAVE then
                return Iif(Settings_OtherAutoSave, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB3_SAVEINTERVAL then
                return Iif(Settings_OtherSaveInterval == 30, "30", "60")
            elseif id == ID_SUB3_SAVELIMIT then
                return Iif(Settings_OtherSaveLimit == 1, "1", "2")
            elseif id == ID_SUB3_CLOSESEARCH then
                return Iif(Settings_OtherCloseSearch, "|cff00ff00开|r", "|cffff0000关|r")
            elseif id == ID_SUB3_NEWFRAMEMODE then
                return Iif(Settings_OtherNewFrameMode, "|cffffcc00新|r", "|cffffcc00默认|r")
            endif
            return ""
        endfunction

        // ========== 构建菜单 ==========
        function BuildMenu takes integer menuLevel returns nothing
            local button btn

            // 清除旧触发器
            call ClearButtonTriggers()

            call DialogClear(g_dialog)

            if menuLevel == 0 then
                call DialogSetMessage(g_dialog, "设置")
                set btn = DialogAddButton(g_dialog, "漂浮文字", 0)
                call CreateButtonTrigger(btn, ID_MAIN_FLOAT)

                set btn = DialogAddButton(g_dialog, "战斗日志", 0)
                call CreateButtonTrigger(btn, ID_MAIN_COMBAT)

                set btn = DialogAddButton(g_dialog, "自动施法", 0)
                call CreateButtonTrigger(btn, ID_MAIN_AUTOCAST)

                set btn = DialogAddButton(g_dialog, "其他设置", 0)
                call CreateButtonTrigger(btn, ID_MAIN_OTHER)

                set btn = DialogAddButton(g_dialog, "返回游戏", 0)
                call CreateButtonTrigger(btn, ID_MAIN_EXIT)

            elseif menuLevel == 1 then
                call DialogSetMessage(g_dialog, "漂浮文字")
                set btn = DialogAddButton(g_dialog, "伤害文字（" + GetSettingText(ID_SUB0_DAMAGE) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB0_DAMAGE)

                set btn = DialogAddButton(g_dialog, "治疗文字（" + GetSettingText(ID_SUB0_HEAL) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB0_HEAL)

                set btn = DialogAddButton(g_dialog, "持续伤害（" + GetSettingText(ID_SUB0_DOT) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB0_DOT)

                set btn = DialogAddButton(g_dialog, "仆从伤害（" + GetSettingText(ID_SUB0_MINION_DMG) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB0_MINION_DMG)

                set btn = DialogAddButton(g_dialog, "持续治疗（" + GetSettingText(ID_SUB0_HOT) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB0_HOT)

                set btn = DialogAddButton(g_dialog, "仆从治疗（" + GetSettingText(ID_SUB0_MINION_HEAL) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB0_MINION_HEAL)

                set btn = DialogAddButton(g_dialog, "屏蔽非暴击显示（" + GetSettingText(ID_SUB0_NOCRIT) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB0_NOCRIT)

                set btn = DialogAddButton(g_dialog, "返回上级", 0)
                call CreateButtonTrigger(btn, ID_SUB0_RETURN)

            elseif menuLevel == 2 then
                call DialogSetMessage(g_dialog, "战斗日志")
                set btn = DialogAddButton(g_dialog, "首领激活时开启（" + GetSettingText(ID_SUB1_BOSSSTART) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB1_BOSSSTART)

                set btn = DialogAddButton(g_dialog, "首领结束时终止（" + GetSettingText(ID_SUB1_BOSSEND) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB1_BOSSEND)

                set btn = DialogAddButton(g_dialog, "返回上级", 0)
                call CreateButtonTrigger(btn, ID_SUB1_RETURN)

            elseif menuLevel == 3 then
                call DialogSetMessage(g_dialog, "自动施法")
                set btn = DialogAddButton(g_dialog, "激活攻击类技能（" + GetSettingText(ID_SUB2_ATTACK) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB2_ATTACK)

                set btn = DialogAddButton(g_dialog, "激活治疗类技能（" + GetSettingText(ID_SUB2_HEAL) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB2_HEAL)

                set btn = DialogAddButton(g_dialog, "激活狂热类技能（" + GetSettingText(ID_SUB2_BERSERK) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB2_BERSERK)

                set btn = DialogAddButton(g_dialog, "返回上级", 0)
                call CreateButtonTrigger(btn, ID_SUB2_RETURN)

            elseif menuLevel == 4 then
                call DialogSetMessage(g_dialog, "其他设置")
                set btn = DialogAddButton(g_dialog, "自动显示地图*（" + GetSettingText(ID_SUB3_FULLMAP) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB3_FULLMAP)

                set btn = DialogAddButton(g_dialog, "背景音乐（" + GetSettingText(ID_SUB3_MUSIC) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB3_MUSIC)

                set btn = DialogAddButton(g_dialog, "音乐模式（" + GetSettingText(ID_SUB3_MUSICMODE) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB3_MUSICMODE)

                set btn = DialogAddButton(g_dialog, "随时间自动保存（" + GetSettingText(ID_SUB3_AUTOSAVE) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB3_AUTOSAVE)

                set btn = DialogAddButton(g_dialog, "自动保存间隔（" + GetSettingText(ID_SUB3_SAVEINTERVAL) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB3_SAVEINTERVAL)

                set btn = DialogAddButton(g_dialog, "自动保存上限（" + GetSettingText(ID_SUB3_SAVELIMIT) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB3_SAVELIMIT)

                set btn = DialogAddButton(g_dialog, "关闭自动索敌（" + GetSettingText(ID_SUB3_CLOSESEARCH) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB3_CLOSESEARCH)

                set btn = DialogAddButton(g_dialog, "UI布局*（" + GetSettingText(ID_SUB3_NEWFRAMEMODE) + "）", 0)
                call CreateButtonTrigger(btn, ID_SUB3_NEWFRAMEMODE)

                set btn = DialogAddButton(g_dialog, "返回上级", 0)
                call CreateButtonTrigger(btn, ID_SUB3_RETURN)
            endif

            call DialogDisplay(MAIN_PLAYER, g_dialog, true)
        endfunction

        // ========== 按钮点击处理核心函数 ==========
        function HandleButtonClick takes integer id returns nothing
            if id == ID_MAIN_FLOAT then
                set g_currentMenu = 1
                call BuildMenu(1)
            elseif id == ID_MAIN_COMBAT then
                set g_currentMenu = 2
                call BuildMenu(2)
            elseif id == ID_MAIN_AUTOCAST then
                set g_currentMenu = 3
                call BuildMenu(3)
            elseif id == ID_MAIN_OTHER then
                set g_currentMenu = 4
                call BuildMenu(4)
            elseif id == ID_MAIN_EXIT then
                call DialogDisplay(MAIN_PLAYER, g_dialog, false)

            elseif id == ID_SUB0_RETURN or id == ID_SUB1_RETURN or id == ID_SUB2_RETURN or id == ID_SUB3_RETURN then
                set g_currentMenu = 0
                call BuildMenu(0)

            elseif id == ID_SUB0_DAMAGE then
                set Settings_FloatDamage = not Settings_FloatDamage
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB0_HEAL then
                set Settings_FloatHeal = not Settings_FloatHeal
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB0_DOT then
                set Settings_FloatDot = not Settings_FloatDot
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB0_MINION_DMG then
                set Settings_FloatMinionDamage = not Settings_FloatMinionDamage
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB0_HOT then
                set Settings_FloatHot = not Settings_FloatHot
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB0_MINION_HEAL then
                set Settings_FloatMinionHeal = not Settings_FloatMinionHeal
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB0_NOCRIT then
                set Settings_FloatNoCrit = not Settings_FloatNoCrit
                call BuildMenu(g_currentMenu)

            elseif id == ID_SUB1_BOSSSTART then
                set Settings_CombatBossStart = not Settings_CombatBossStart
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB1_BOSSEND then
                set Settings_CombatBossEnd = not Settings_CombatBossEnd
                call BuildMenu(g_currentMenu)

            elseif id == ID_SUB2_ATTACK then
                set Settings_AutoAttack = not Settings_AutoAttack
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB2_HEAL then
                set Settings_AutoHeal = not Settings_AutoHeal
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB2_BERSERK then
                set Settings_AutoBerserk = not Settings_AutoBerserk
                call BuildMenu(g_currentMenu)

            elseif id == ID_SUB3_FULLMAP then
                set Settings_OtherFullMap = not Settings_OtherFullMap
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB3_MUSIC then
                set Settings_OtherMusic = not Settings_OtherMusic
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB3_MUSICMODE then
                set Settings_OtherMusicMode = 1 - Settings_OtherMusicMode
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB3_AUTOSAVE then
                set Settings_OtherAutoSave = not Settings_OtherAutoSave
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB3_SAVEINTERVAL then
                if Settings_OtherSaveInterval == 30 then
                    set Settings_OtherSaveInterval = 60
                else
                    set Settings_OtherSaveInterval = 30
                endif
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB3_SAVELIMIT then
                if Settings_OtherSaveLimit == 1 then
                    set Settings_OtherSaveLimit = 2
                else
                    set Settings_OtherSaveLimit = 1
                endif
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB3_CLOSESEARCH then
                set Settings_OtherCloseSearch = not Settings_OtherCloseSearch
                call BuildMenu(g_currentMenu)
            elseif id == ID_SUB3_NEWFRAMEMODE then
                set Settings_OtherNewFrameMode = not Settings_OtherNewFrameMode
                call BuildMenu(g_currentMenu)
            endif
        endfunction

        // ========== 聊天命令 "-config" ==========
        private function OnChatCommand takes nothing returns nothing
            if g_dialog == null then
                set g_dialog = DialogCreate()
            endif
            set g_currentMenu = 0
            call BuildMenu(0)
        endfunction

        // ========== 初始化 ==========
        private function Init takes nothing returns nothing
            set g_chatTrigger = CreateTrigger()
            call TriggerRegisterPlayerChatEvent(g_chatTrigger, MAIN_PLAYER, "-config", true)
            call TriggerRegisterPlayerChatEvent(g_chatTrigger, MAIN_PLAYER, "设置", true)
            call TriggerAddAction(g_chatTrigger, function OnChatCommand)
        endfunction

    endlibrary

    library PatrolSystem requires shared

        globals
            constant integer PATROL_DESTROY   = 0
            constant integer PATROL_ROUNDTRIP = 1
            constant integer PATROL_LOOP      = 2

            private constant integer COMMAND_INTERVAL_TICKS = 350  // 3.5s * 100 = 350
            private constant integer ARRIVE_DIST_SQ         = 4096 // 64^2
            private constant real    SWITCH_TO_MOVE_DIST   = 128.0 // ≤128 尝试 move
        endglobals

        struct PatrolNode
            real x
            real y
            
            static method create takes real x, real y returns thistype
                local thistype this
                set this = thistype.allocate()
                set this.x = x
                set this.y = y
                return this
            endmethod
        endstruct

        struct Patrol
            static thistype first = 0
            thistype prev = 0
            thistype next = 0
            
            unit patroller = null
            PatrolNode array nodes[50]
            integer nodeCount = 0
            
            integer currentNodeIndex = 0
            integer patrolMode = PATROL_LOOP
            
            boolean reachedFinal = false
            integer lastCommandTick = 0  // 共用：attack 或 move
            
            static method create takes unit u, integer mode returns thistype
                local thistype this
                set this = thistype.allocate()
                set this.patroller = u
                set this.patrolMode = mode
                set this.currentNodeIndex = 0
                set this.reachedFinal = false
                set this.lastCommandTick = globalNowtime
                
                if thistype.first == 0 then
                    set thistype.first = this
                else
                    set this.next = thistype.first
                    set thistype.first.prev = this
                    set thistype.first = this
                endif
                
                return this
            endmethod
            
            method addNode takes real x, real y returns nothing
                local PatrolNode node
                if this.nodeCount < 50 then
                    set node = PatrolNode.create(x, y)
                    set this.nodes[this.nodeCount] = node
                    set this.nodeCount = this.nodeCount + 1
                endif
            endmethod
            
            private method canIssueCommand takes nothing returns boolean
                return globalNowtime - this.lastCommandTick >= COMMAND_INTERVAL_TICKS
            endmethod
            
            private method getDistanceSqToNode takes nothing returns real
                local PatrolNode node
                local real dx
                local real dy
                set node = this.nodes[this.currentNodeIndex]
                set dx = GetUnitX(this.patroller) - node.x
                set dy = GetUnitY(this.patroller) - node.y
                return dx * dx + dy * dy
            endmethod
            
            private method issueAttackOrder takes nothing returns nothing
                local PatrolNode node
                set node = this.nodes[this.currentNodeIndex]
                call IssuePointOrderById(this.patroller, OrderId("attack"), node.x, node.y)
                set this.lastCommandTick = globalNowtime
            endmethod
            
            private method issueMoveOrder takes nothing returns nothing
                local PatrolNode node
                set node = this.nodes[this.currentNodeIndex]
                call IssuePointOrderById(this.patroller, OrderId("move"), node.x, node.y)
                set this.lastCommandTick = globalNowtime
            endmethod
            
            private method isAtCurrentNode takes nothing returns boolean
                return this.getDistanceSqToNode() <= ARRIVE_DIST_SQ
            endmethod
            
            private method advanceToNextNode takes nothing returns nothing
                local integer oldIndex
                set oldIndex = this.currentNodeIndex
                
                if this.patrolMode == PATROL_DESTROY then
                    if this.currentNodeIndex < this.nodeCount - 1 then
                        set this.currentNodeIndex = this.currentNodeIndex + 1
                    else
                        set this.reachedFinal = true
                        call this.issueMoveOrder()  // 终点只 move 一次
                        call this.destroy()
                        return
                    endif
                elseif this.patrolMode == PATROL_LOOP then
                    set this.currentNodeIndex = this.currentNodeIndex + 1
                    if this.currentNodeIndex >= this.nodeCount then
                        set this.currentNodeIndex = 0
                    endif
                elseif this.patrolMode == PATROL_ROUNDTRIP then
                    set this.currentNodeIndex = this.currentNodeIndex + 1
                    if this.currentNodeIndex >= this.nodeCount then
                        set this.currentNodeIndex = this.nodeCount - 2
                    endif
                endif
                
                // 到达节点：立即 attack（无视间隔）
                call this.issueAttackOrder()
            endmethod
            
            method start takes nothing returns nothing
                if this.nodeCount == 0 then
                    return
                endif
                set this.currentNodeIndex = 0
                set this.reachedFinal = false
                set this.lastCommandTick = globalNowtime
                call this.issueAttackOrder()
                if this.isAtCurrentNode() then
                    call this.advanceToNextNode()
                endif
            endmethod
            
            method stop takes nothing returns nothing
                set this.reachedFinal = true
                call IssueImmediateOrder(this.patroller, "stop")
            endmethod
            
            method resume takes nothing returns nothing
                set this.reachedFinal = false
                set this.lastCommandTick = globalNowtime - COMMAND_INTERVAL_TICKS  // 允许立即下命令
                call this.issueAttackOrder()
            endmethod
            
            method destroy takes nothing returns nothing
                local integer i
                if this.prev != 0 then
                    set this.prev.next = this.next
                else
                    set thistype.first = this.next
                endif
                if this.next != 0 then
                    set this.next.prev = this.prev
                endif
                
                set i = this.nodeCount - 1
                loop
                    exitwhen i < 0
                    call this.nodes[i].destroy()
                    set i = i - 1
                endloop
                set this.nodeCount = 0
                
                call this.deallocate()
            endmethod
            
            static method updateAll takes nothing returns nothing
                local thistype this = thistype.first
                local real dist_sq
                loop
                    exitwhen this == 0
                    if this.patroller != null and alive(this.patroller) == false then
                        call this.destroy()
                    elseif this.reachedFinal == false then
                        set dist_sq = this.getDistanceSqToNode()
                        if dist_sq <= ARRIVE_DIST_SQ then
                            call this.advanceToNextNode()  // 立即切换 + attack
                        else
                            if dist_sq <= SWITCH_TO_MOVE_DIST * SWITCH_TO_MOVE_DIST then
                                if this.canIssueCommand() then
                                    call this.issueMoveOrder()  // 3.5s 间隔
                                endif
                            else
                                if this.canIssueCommand() then
                                    call this.issueAttackOrder()  // 3.5s 间隔
                                endif
                            endif
                        endif
                    endif
                    set this = this.next
                endloop
            endmethod
        endstruct

        function CreatePatrol takes unit u, integer mode returns Patrol
            return Patrol.create(u, mode)
        endfunction
        
        function CreatePatrolLoop takes unit u returns Patrol
            return Patrol.create(u, PATROL_LOOP)
        endfunction
        
        function CreatePatrolRoundtrip takes unit u returns Patrol
            return Patrol.create(u, PATROL_ROUNDTRIP)
        endfunction
        
        function CreatePatrolOnce takes unit u returns Patrol
            return Patrol.create(u, PATROL_DESTROY)
        endfunction

    endlibrary

    library randomLoot requires shared

        globals
            private constant integer LCG_A = 1664525
            private constant integer LCG_C = 1013904223
            private constant integer LCG_M = 2147483647  // 2^31 - 1
            
            private constant integer PRIME_DISTURB = 10007  // 质数放大
            
            private integer lcgSeed = 1
            private integer gameSeed = 0      // 开局随机种子（不存档）
            private integer initTime = 0      // 开局时间（来自 startTotalTime）
        endglobals

        //===========================================================================
        //  加载种子（使用外部 startTotalTime）
        //===========================================================================
        function LoadSeqs takes nothing returns nothing
            local integer tempSeed
            
            if not HaveStoredInteger(gameCache, "LOOT_LCG_SEED", "SEED") then
                // === 新游戏：生成全新种子 ===
                set initTime = startTotalTime  // 使用外部变量（单位：0.01 秒）
                
                // 质数放大扰动
                set tempSeed = gameSeed
                set tempSeed = tempSeed + (initTime * PRIME_DISTURB)
                set tempSeed = tempSeed - (tempSeed / LCG_M) * LCG_M
                if tempSeed <= 0 then
                    set tempSeed = tempSeed + LCG_M
                endif
                
                set lcgSeed = tempSeed
                
                // 只存主种子
                call StoreInteger(gameCache, "LOOT_LCG_SEED", "SEED", lcgSeed)
            else
                // === 读档：恢复主种子 ===
                set lcgSeed = GetStoredInteger(gameCache, "LOOT_LCG_SEED", "SEED")
                set initTime = startTotalTime+1  // 实时更新，但不参与计算
            endif
            set gameSeed = GetRandomInt(1, LCG_M - 1)
            //call BJDebugMsg(I2S(gameSeed))
        endfunction

        //===========================================================================
        //  获取下一个 raw 值
        //===========================================================================
        private function GetNextRaw takes integer unitTypeId returns integer
            local integer next = LCG_A * lcgSeed + LCG_C
            local integer typeDisturb = unitTypeId * PRIME_DISTURB
            
            // 组合扰动（仅新游戏时 gameSeed 生效）
            set next = next + typeDisturb + (initTime * PRIME_DISTURB)
            
            if next < 0 then
                set next = next + LCG_M + 1
            endif
            
            set next = next - (next / LCG_M) * LCG_M
            set lcgSeed = next
            
            call StoreInteger(gameCache, "LOOT_LCG_SEED", "SEED", lcgSeed)
            
            return next
        endfunction

        //===========================================================================
        //  拒绝采样主函数，返回 0 ~ (modulus-1)
        //===========================================================================
        function GetLootNumber takes integer modulus, integer unitTypeId returns integer
            local integer raw = 0
            local integer maxValid = 0
            local integer remainder = 0
            local integer i = 0
            
            if modulus <= 0 then
                return 0
            endif
            set modulus = modulus
            set remainder = LCG_M - (LCG_M / modulus) * modulus
            set maxValid = LCG_M - remainder - 1
            
            loop
                set raw = GetNextRaw(unitTypeId)
                exitwhen raw <= maxValid or i > 3
                set i = i+1
            endloop
            
            return raw - (raw / modulus) * modulus
        endfunction

        //===========================================================================
        //  兼容原版 API，返回 0 ~ (modulus-1)
        //===========================================================================
        function GetLootNumberEx takes integer modulus returns integer
            return GetLootNumber(modulus, 0)
        endfunction

    endlibrary

    library lootPool requires randomLoot

        //===========================================================================
        //  物品节点
        //===========================================================================
        struct ItemNode
            integer itemId     = 0
            integer weight     = 0
            integer charge     = 0
            thistype next      = 0
            
            static method create takes integer id, integer w,integer c returns thistype
                local thistype this = thistype.allocate()
                set this.itemId = id
                set this.weight = w
                set this.charge = c 
                return this
            endmethod
        endstruct

        //===========================================================================
        //  掉落池主结构
        //===========================================================================
        struct LootPool
            static thistype first = 0
            thistype prev = 0
            thistype next = 0
            
            ItemNode head      = 0     // 链表头
            integer itemCount  = 0
            integer totalWeight = 0
            
            // 创建
            static method create takes nothing returns thistype
                local thistype this = thistype.allocate()
                
                if thistype.first == 0 then
                    set thistype.first = this
                else
                    set this.next = thistype.first
                    set thistype.first.prev = this
                    set thistype.first = this
                endif
                
                return this
            endmethod

            // 添加物品（重复累加）
            method addItem takes integer itemId, integer weight returns nothing
                local ItemNode node = this.head
                
                if weight <= 0 then
                    return
                endif
                
                // 查找重复
                loop
                    exitwhen node == 0
                    if node.itemId == itemId and node.charge == 0 then
                        set node.weight = node.weight + weight
                        set this.totalWeight = this.totalWeight + weight
                        return
                    endif
                    set node = node.next
                endloop
                
                // 新节点
                set node = ItemNode.create(itemId, weight,0)
                set node.next = this.head
                set this.head = node
                set this.itemCount = this.itemCount + 1
                set this.totalWeight = this.totalWeight + weight
            endmethod

            method addItemEx takes integer itemId, integer weight,integer charge returns nothing
                local ItemNode node = this.head
                
                if weight <= 0 then
                    return
                endif
                
                // 查找重复
                loop
                    exitwhen node == 0
                    if node.itemId == itemId and node.charge == charge then
                        set node.weight = node.weight + weight
                        set this.totalWeight = this.totalWeight + weight
                        return
                    endif
                    set node = node.next
                endloop
                
                // 新节点
                set node = ItemNode.create(itemId, weight,charge)
                set node.next = this.head
                set this.head = node
                set this.itemCount = this.itemCount + 1
                set this.totalWeight = this.totalWeight + weight
            endmethod
            
            
            // 复制另一个池中的物品
            method copy takes thistype from returns nothing
                local ItemNode node = from.head
                loop
                    exitwhen node == 0
                    call this.addItem(node.itemId,node.weight)
                    set node = node.next 
                endloop
            endmethod
            
            // 抽取物品
            method getRandomItem takes unit whichUnit returns ItemNode
                local integer roll = 0
                local ItemNode node = this.head
                local integer cumulative = 0
                
                if this.totalWeight <= 0 or this.head == 0 then
                    return 0
                endif

                //call this.debug()
                
                set roll = GetLootNumber(this.totalWeight,GetUnitTypeId(whichUnit))
                
                loop
                    exitwhen node == 0
                    set cumulative = cumulative + node.weight
                    if roll < cumulative then
                        return node
                    endif
                    set node = node.next
                endloop
                
                return 0  // 理论上不会到这里
            endmethod
            
            // 清空
            method clear takes nothing returns nothing
                local ItemNode node = this.head
                local ItemNode temp
                
                loop
                    exitwhen node == 0
                    set temp = node
                    set node = node.next
                    call temp.destroy()
                endloop
                
                set this.head = 0
                set this.itemCount = 0
                set this.totalWeight = 0
            endmethod
            
            // 销毁
            method destroy takes nothing returns nothing
                call this.clear()
                
                if this.prev != 0 then
                    set this.prev.next = this.next
                else
                    set thistype.first = this.next
                endif
                if this.next != 0 then
                    set this.next.prev = this.prev
                endif
                
                call this.deallocate()
            endmethod
            
            // 调试：打印所有物品
            method debug takes nothing returns nothing
                local ItemNode node = this.head
                local integer i = 0
                loop
                    exitwhen node == 0
                    call BJDebugMsg("[" + I2S(i) + "] ID: " + I2S(node.itemId) + "  Weight: " + I2S(node.weight))
                    set i = i + 1
                    set node = node.next
                endloop
                call BJDebugMsg("Total: " + I2S(this.itemCount) + " items, weight=" + I2S(this.totalWeight))
            endmethod
        endstruct

        //===========================================================================
        //  便捷函数
        //===========================================================================
        function CreateLootPool takes nothing returns LootPool
            return LootPool.create()
        endfunction

        function EnemyLoot takes unit whichEnemy,LootPool whichPool,integer baseLootCount,real extraLootChance returns nothing
            local real chanceRand = I2R(GetLootNumber(10000,GetUnitTypeId(whichEnemy)))/10000
            local real extraChance = extraLootChance*I2R(TEAM_ITEM_FOUND_RATE)/10000
            local integer lootCount = baseLootCount+R2I(extraChance)
            local real x = GetUnitX(whichEnemy)
            local real y = GetUnitY(whichEnemy)
            local ItemNode lootNode = 0
            set extraChance = extraChance-I2R(R2I(extraChance))

            //call BJDebugMsg("extraLootChance=" + R2S(extraLootChance))
            //call BJDebugMsg("TEAM_ITEM_FOUND_RATE=" + I2S(TEAM_ITEM_FOUND_RATE))
            //call BJDebugMsg("totalExtraChance=" + R2S(extraLootChance * I2R(TEAM_ITEM_FOUND_RATE) / 10000.0))

            loop 
                exitwhen lootCount == 0
                set lootNode = whichPool.getRandomItem(whichEnemy)
                if lootNode != 0 and lootNode.itemId != 0 then 
                    if lootNode.charge != 0 then 
                        call SetItemCharges(CreateItemEx(lootNode.itemId,x,y),lootNode.charge)
                    else 
                        call CreateItemEx(lootNode.itemId,x,y)
                    endif 
                endif 
                set lootCount = lootCount-1
            endloop
            if chanceRand < extraChance then 
                set lootNode = whichPool.getRandomItem(whichEnemy)
                if lootNode != 0 and lootNode.itemId != 0 then 
                    if lootNode.charge != 0 then 
                        call SetItemCharges(CreateItemEx(lootNode.itemId,x,y),lootNode.charge)
                    else 
                        call CreateItemEx(lootNode.itemId,x,y)
                    endif 
                endif 
            endif 
        endfunction

    endlibrary
    
    library ResourcePointSystem initializer Init requires lootPool

        globals
            private constant integer SELLING_ITEM_1 = 'iMGT'
            private constant integer SELLING_ITEM_2 = 'iMGP'

            private hashtable ResourcePointHash = InitHashtable()
            private hashtable ResourceUnitHash = InitHashtable()
            private hashtable ResourceIndexHash = InitHashtable()

            private unit lastCreatedResource = null

            private constant integer MAX_SPAWNS_PER_TYPE = 64

            private group ENUM_GROUP = CreateGroup()
            private integer FILTER_ID = 0
            private boolexpr FILTER
        endglobals

        struct ResourceRefresh
            ResourceType rt

            static method refresh takes nothing returns nothing
                local timer t = GetExpiredTimer()
                local ResourceRefresh this = LoadInteger(ResourcePointHash,GetHandleId(t),1)
                call this.rt.spawnOne()
                call FlushChildHashtable(ResourcePointHash,GetHandleId(t))
                call DestroyTimer(t)
                call this.destroy()
                set t = null
            endmethod

            static method create takes ResourceType rt returns thistype
                local timer t = CreateTimer()
                local ResourceRefresh this = ResourceRefresh.allocate()
                set this.rt = rt
                call SaveInteger(ResourcePointHash,GetHandleId(t),1,this)
                call TimerStart(t,0.8,false,function ResourceRefresh.refresh)
                set t = null
                return this 
            endmethod
        endstruct



        struct ResourceType
            integer resourceUnitId
            integer resourceItemId
            integer spawnCount
            integer totalSpawns
            integer lastHarvestIndex = -1
            integer minCharge
            integer maxCharge
            real array spawnX[MAX_SPAWNS_PER_TYPE]
            real array spawnY[MAX_SPAWNS_PER_TYPE]
            boolean array used[MAX_SPAWNS_PER_TYPE]
            // 新增：采集后禁止立即刷新的位置

            static method filter takes nothing returns boolean
                return GetUnitTypeId(GetFilterUnit()) == FILTER_ID
            endmethod

            static method register takes integer markerId, integer resourceUnit, integer resourceItem, integer initialCount returns ResourceType
                local ResourceType this = ResourceType.allocate()
                local unit fog
                local integer index = 0
                set this.resourceUnitId = resourceUnit
                set this.resourceItemId = resourceItem
                set this.spawnCount = 0
                set this.totalSpawns = 0
                set this.minCharge = 0
                set this.maxCharge = 0

                set FILTER_ID = markerId
                call GroupEnumUnitsInRect(ENUM_GROUP,wholeMapRect,FILTER)
                set fog = FirstOfGroup(ENUM_GROUP)

                loop
                    exitwhen fog == null
                    if index < MAX_SPAWNS_PER_TYPE then
                        set this.spawnX[index] = GetUnitX(fog)
                        set this.spawnY[index] = GetUnitY(fog)
                        set this.used[index] = false
                        set index = index + 1
                    endif
                    call GroupRemoveUnit(ENUM_GROUP,fog)
                    set fog = FirstOfGroup(ENUM_GROUP)
                endloop
                set this.totalSpawns = index
                call this.spawnInitial(initialCount)
                call SaveInteger(ResourcePointHash,0,resourceUnit,this)
                return this
            endmethod

            method createResource takes integer index returns unit
                set lastCreatedResource = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),this.resourceUnitId,this.spawnX[index],this.spawnY[index],0)
                set this.used[index] = true
                set this.spawnCount = this.spawnCount + 1
                call SaveInteger(ResourceUnitHash,GetHandleId(lastCreatedResource),0,this)
                call SaveInteger(ResourceIndexHash,GetHandleId(lastCreatedResource),0,index)
                return lastCreatedResource
            endmethod
            method spawnInitial takes integer count returns nothing
                local integer i = 0
                local integer array indexs
                local integer j
                local integer temp
                if count > this.totalSpawns then
                    set count = this.totalSpawns
                endif
                loop
                    exitwhen i >= this.totalSpawns
                    set indexs[i] = i
                    set i = i + 1
                endloop
                set i = this.totalSpawns - 1
                loop
                    exitwhen i < this.totalSpawns-count
                    set j = GetRandomInt(0,i)
                    set temp = indexs[i]
                    set indexs[i] = indexs[j]
                    set indexs[j] = temp
                    set i = i - 1
                endloop
                set i = 0
                loop
                    exitwhen i >= count
                    call this.createResource(indexs[this.totalSpawns-1-i])
                    set i = i + 1
                endloop
            endmethod
            method spawnOne takes nothing returns nothing
                local integer array available
                local integer count = 0
                local integer i = 0
                local integer index
                loop
                    exitwhen i >= this.totalSpawns
                    if not this.used[i] and i != this.lastHarvestIndex then
                        set available[count] = i
                        set count = count + 1
                    endif
                    set i = i + 1
                endloop
                if count <= 0 then
                    set this.lastHarvestIndex = -1
                    call this.spawnOne()
                    return
                endif
                set index = available[GetRandomInt(0,count-1)]
                call this.createResource(index)
                set this.lastHarvestIndex = -1
            endmethod
            method onHarvest takes unit harvested returns nothing
                local integer index = LoadInteger(ResourceIndexHash,GetHandleId(harvested),0)
                local real x = GetUnitX(harvested)
                local real y = GetUnitY(harvested)
                if index >= 0 and index < this.totalSpawns then
                    if this.used[index] then
                        set this.used[index] = false
                        set this.lastHarvestIndex = index
                        set this.spawnCount = this.spawnCount - 1
                    endif
                endif
                if this.resourceItemId != 0 then
                    if this.minCharge > 0 or this.maxCharge > 0 then
                        if this.maxCharge > this.minCharge then
                            call SetItemCharges(CreateItemEx(this.resourceItemId,x,y),GetLootNumberEx(this.maxCharge-this.minCharge+1)+this.minCharge)
                        else
                            call SetItemCharges(CreateItemEx(this.resourceItemId,x,y),this.minCharge)
                        endif
                    else
                        call CreateItemEx(this.resourceItemId,x,y)
                    endif
                endif
                // 保留死亡动画
                call KillUnit(harvested)
                call FlushChildHashtable(ResourceUnitHash,GetHandleId(harvested))
                call FlushChildHashtable(ResourceIndexHash,GetHandleId(harvested))
                // 延迟刷新
                call ResourceRefresh.create(this)
            endmethod
            static method getByUnitId takes integer unitId returns ResourceType
                if HaveSavedInteger(ResourcePointHash,0,unitId) then
                    return LoadInteger(ResourcePointHash,0,unitId)
                endif
                return 0
            endmethod
            static method onInit takes nothing returns nothing
                set FILTER = Condition(function thistype.filter)
            endmethod
        endstruct

        private function onSell takes nothing returns nothing
            local unit seller = GetSellingUnit()
            local item sold = GetSoldItem()
            local ResourceType rt
            if GetItemTypeId(sold) == SELLING_ITEM_1 or GetItemTypeId(sold) == SELLING_ITEM_2 then
                set rt = LoadInteger(ResourceUnitHash,GetHandleId(seller),0)
                if rt != 0 then
                    call rt.onHarvest(seller)
                else
                    set rt = ResourceType.getByUnitId(GetUnitTypeId(seller))
                    if rt != 0 then
                        call rt.onHarvest(seller)
                    endif
                endif
            endif
            set seller = null
            set sold = null
        endfunction
        private function Init takes nothing returns nothing
            local trigger t = CreateTrigger()
            call TriggerRegisterPlayerUnitEvent(t,NEUTRAL,EVENT_PLAYER_UNIT_SELL_ITEM,null)
            call TriggerAddAction(t,function onSell)
        endfunction
    endlibrary

    library Gate requires shared 
        globals
            private group pick = CreateGroup()
        endglobals
        //自动门
        struct AutomaticGate
            static AutomaticGate top = 0
            AutomaticGate prev 
            destructable gate
            destructable array blocker [10] 
            string openAnim 
            boolean active 
            boolean open
            integer blockerCount = 0

            static method create takes destructable gate,string openAnim returns AutomaticGate
                local thistype this = thistype.allocate()
                set this.gate = gate 
                set this.active = true 
                set this.open = false
                set this.openAnim = openAnim
                set this.prev = thistype.top
                set thistype.top = this 
                return this 
            endmethod

            method addBlocker takes destructable dest returns boolean
                if this.blockerCount < 10 then 
                    set this.blocker[this.blockerCount] = dest 
                    set this.blockerCount = this.blockerCount+1
                else 
                    return false 
                endif
                return true 
            endmethod

            method letOpen takes nothing returns nothing
                local integer i = 0 
                set this.open = true 
                call KillDestructable(this.gate)
                call SetDestructableAnimationSpeed(this.gate,1)
                call SetDestructableAnimation(this.gate,this.openAnim)
                loop 
                    exitwhen i >= this.blockerCount
                    call KillDestructable(this.blocker[i])
                    set i = i+1
                endloop
            endmethod

            method letClose takes nothing returns nothing
                local integer i = 0 
                set this.open = false 
                call DestructableRestoreLife(this.gate,GetDestructableMaxLife(this.gate),true)
                loop 
                    exitwhen i >= this.blockerCount
                    call DestructableRestoreLife(this.blocker[i],GetDestructableMaxLife(this.blocker[i]),false)
                    set i = i+1
                endloop
            endmethod

            static method updateAll takes nothing returns nothing
                local thistype this = thistype.top 
                loop 
                    exitwhen this == 0
                    if this.active then 
                        call GroupClear(pick)
                        call GroupEnumUnitsInRange(pick,GetWidgetX(this.gate),GetWidgetY(this.gate),350,autoGateFilter)
                        if CountUnitsInGroup(pick) == 0 then 
                            if this.open then 
                                call this.letClose()
                            endif 
                        else 
                            if this.open == false then 
                                call this.letOpen()
                            endif 
                        endif 
                    endif 
                    set this = this.prev
                endloop
            endmethod

            method disable takes nothing returns nothing
                set this.active = false 
            endmethod
            method enable takes nothing returns nothing
                set this.active = true 
            endmethod

            method forceOpen takes nothing returns nothing
                if this.open == false then 
                    call this.letOpen()
                endif 
                set this.open = true 
                set this.active = false 
            endmethod

            method forceClose takes nothing returns nothing
                if this.open then 
                    call this.letClose()
                endif 
                set this.open = false
                set this.active = false 
            endmethod
        endstruct
        function GetGateFromDestructable takes destructable whichDest returns AutomaticGate
            local AutomaticGate this = AutomaticGate.top 
            loop 
                exitwhen this == 0
                if this.gate == whichDest then 
                    return this 
                endif 
                set this = this.prev 
            endloop
            return 0
        endfunction
        function OpenGate takes AutomaticGate this returns nothing
            call this.forceOpen()
        endfunction
        function CloseGate takes AutomaticGate this returns nothing
            call this.forceClose()
        endfunction
    endlibrary

    library EnemyLib requires shared

        globals
            private constant real RESPAWN_TIME = 240.0  // 重生时间（秒）
            private hashtable hash = InitHashtable()  // 全局哈希表
            unit eventRespawningUnit = null   // 重生事件单位
        endglobals

        //===========================================================================
        //  便捷函数
        //===========================================================================
        function RegisterEnemy takes unit u returns Enemy
            return Enemy.register(u)
        endfunction
        
        function GetEnemyFromUnit takes unit u returns Enemy
            if u == null then
                return 0
            endif
            return LoadInteger(hash, GetHandleId(u), 0)
        endfunction
        
        //===========================================================================
        //  敌人结构体
        //==========================================================================
        
        struct Enemy
            static thistype top = 0
            thistype prev 
            thistype next 
            static boolean needReRegister = false 
            unit    u           = null
            player  owningPlayer
            real    spawnX      = 0.0
            real    spawnY      = 0.0
            real    spawnFacing = 0.0
            integer unitId      = 0
            timer   respawnTimer = null
            trigger deathTrig   = null  // 死亡触发器
            real    respawnTime = 0.0   // 每个实例的重生时间
            boolean giveReward  = true 
            boolean needRespawn = true 
            real    originalLife = 0
            integer originalLevel = 0
            
            // 注册敌人
            static method register takes unit whichUnit returns thistype
                local thistype this
                
                if whichUnit == null then
                    return 0
                endif
                //call SetUnitOwner(whichUnit,Player(PLAYER_NEUTRAL_AGGRESSIVE),false)
                if GetEnemyFromUnit(whichUnit) > 0 then 
                    set this = GetEnemyFromUnit(whichUnit)
                    call ModifyEnemyState.evaluate(this.u)
                    call unitCheckState.evaluate(this.u)
                    return this 
                else 
                    set this = this.allocate()
                endif 
                
                set this.prev = thistype.top
                if this.prev > 0 then 
                    set this.prev.next = this 
                endif 
                set thistype.top = this 
                set this.next = 0

                set this.u = whichUnit
                set this.originalLife = GetUnitState(this.u,UNIT_STATE_MAX_LIFE)
                set this.originalLevel = GetUnitLevel(this.u)
                set this.spawnX = GetUnitX(this.u)
                set this.spawnY = GetUnitY(this.u)
                set this.spawnFacing = GetUnitFacing(this.u)
                set this.unitId = GetUnitTypeId(this.u)
                set this.respawnTimer = null
                set this.deathTrig = null
                set this.owningPlayer = GetOwningPlayer(this.u)
                set this.respawnTime = RESPAWN_TIME  // 默认重生时间
                if GetUnitFlyHeight(this.u) != 0 then 
                    call UnitAddAbility(this.u,'Arav')
                    call UnitRemoveAbility(this.u,'Arav')
                    call SetUnitFlyHeight(this.u,GetUnitFlyHeight(this.u),0)
                endif 
                

                if IsUnitType(this.u,UNIT_TYPE_SUMMONED) then 
                    set this.needRespawn = false 
                endif 

                // 创建死亡触发器
                set this.deathTrig = CreateTrigger()
                call TriggerAddActionEx(this.deathTrig, function thistype.onDeath)
                call TriggerRegisterUnitEvent(this.deathTrig, this.u, EVENT_UNIT_DEATH)

                
                // 绑定 unit → this
                call SaveInteger(hash, GetHandleId(this.u), 0, this)
                
                call ModifyEnemyState.evaluate(this.u)
                call unitCheckState.evaluate(this.u)
                
                // 执行重生/创建事件
                set eventRespawningUnit = this.u
                call spawningEnemy.execute()  // 假设有一个类似于killingEnemy的spawningEnemy触发器或函数
                
                return this
            endmethod
            
            // 设置自定义重生时间
            method setRespawnTime takes real time returns nothing
                set this.respawnTime = time
            endmethod
            
            // 死亡回调
            private static method onDeath takes nothing returns nothing
                local unit dying = GetTriggerUnit()
                local integer dyingId = GetHandleId(dying)
                local thistype this = LoadInteger(hash, dyingId, 0)
                
                if this == 0 then
                    return
                endif
                

                if GetOwningPlayer(GetKillingUnit()) == PLAYER and IsUnitBoss(dying) == false and Boss.GetBossFromUnit(dying) == 0 and this.giveReward then 
                    set eventDyingUnit = dying
                    call killingEnemy.execute()
                endif 
                
                // 非副本：独立重生
                if MAP_IS_DUNGEON == false and this.needRespawn then
                    set this.respawnTimer = CreateTimer()
                    call SaveInteger(hash, GetHandleId(this.respawnTimer), 0, this)
                    call TimerStart(this.respawnTimer, this.respawnTime, false, function thistype.respawn)
                else
                    // 副本模式：不重生，销毁
                    call this.cleanup()
                endif

                // 移除 unit 绑定
                call RemoveSavedInteger(hash, dyingId, 0)
                
                call DestroyTriggerEx(this.deathTrig)
                set this.deathTrig = null 

                set dying = null
            endmethod
            
            // 独立重生
            private static method respawn takes nothing returns nothing
                local timer tm = GetExpiredTimer()
                local integer tmId = GetHandleId(tm)
                local thistype this = LoadInteger(hash, tmId, 0)
                local unit newUnit
                
                if this == 0 or this.needRespawn == false then
                    call RemoveSavedInteger(hash, tmId, 0)
                    call DestroyTimer(tm)
                    return
                endif
                
                // 清理旧 unit 残留
                call RemoveSavedInteger(hash, GetHandleId(this.u), 0)
                
                set newUnit = CreateUnit(this.owningPlayer, this.unitId, this.spawnX, this.spawnY, this.spawnFacing)
                set this.u = newUnit
                call SaveInteger(hash, GetHandleId(newUnit), 0, this)
                call ModifyEnemyState.evaluate(newUnit)
                call unitCheckState.evaluate(newUnit)
                call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", this.spawnX, this.spawnY))
                
                call UnitAddAbility(this.u,'Arav')
                call UnitRemoveAbility(this.u,'Arav')
                call SetUnitFlyHeight(this.u,GetUnitFlyHeight(this.u),0)

                // 重新绑定 + 创建新触发器
                set this.deathTrig = CreateTrigger()
                call TriggerRegisterUnitEvent(this.deathTrig, newUnit, EVENT_UNIT_DEATH)
                call TriggerAddActionEx(this.deathTrig, function thistype.onDeath)
                
                // 执行重生/创建事件
                set eventRespawningUnit = newUnit
                call spawningEnemy.execute()  // 与register中一致
                
                // 清理计时器
                call RemoveSavedInteger(hash, tmId, 0)
                call DestroyTimer(tm)
                set this.respawnTimer = null
            endmethod
            
            // 统一清理（副本模式调用）
            private method cleanup takes nothing returns nothing
                if this.deathTrig != null then
                    call DestroyTriggerEx(this.deathTrig)
                    set this.deathTrig = null
                endif
                if this.respawnTimer != null then
                    call RemoveSavedInteger(hash, GetHandleId(this.respawnTimer), 0)
                    call DestroyTimer(this.respawnTimer)
                    set this.respawnTimer = null
                endif
                if this.u != null then
                    call RemoveSavedInteger(hash, GetHandleId(this.u), 0)
                endif
                set this.u = null
            endmethod
            
            // 销毁
            method onDestroy takes nothing returns nothing
                call this.cleanup()
                if this.prev > 0 then 
                    set this.prev.next = this.next 
                endif 
                if this.next > 0 then 
                    set this.next.prev = this.prev 
                endif 
                if this == thistype.top then 
                    set thistype.top = this.prev 
                endif 
            endmethod

            static method getEnemy takes unit u returns Enemy
                if u == null then
                    return 0
                endif
                return LoadInteger(hash, GetHandleId(u), 0)
            endmethod

            method update takes nothing returns nothing
                if inCombat(this.u) == false and IsUnitType(this.u,UNIT_TYPE_SUMMONED) == false then 
                    if (DisByUnXY(this.u,this.spawnX,this.spawnY) > 900 or GetUnitCurrentOrder(this.u) == ORDER_stop or GetUnitCurrentOrder(this.u) == ORDER_cancel) and IsUnitBoss(this.u) == false then 
                        if DisByUnXY(this.u,this.spawnX,this.spawnY) > 32 then 
                            call IssuePointOrderById(this.u,ORDER_move,this.spawnX,this.spawnY)
                        else 
                            call SetUnitFacing(this.u,this.spawnFacing)
                        endif 
                    endif 
                endif 
            endmethod

            static method updateAll takes nothing returns nothing
                local thistype this = thistype.top
                loop 
                    exitwhen this == 0 
                    if thistype.needReRegister then 
                        call this.register(this.u)
                    endif 
                    call this.update()
                    set this = this.prev 
                endloop
                set thistype.needReRegister = false 
            endmethod

            static method onInit takes nothing returns nothing
                call SetCreepCampFilterState( false )
                call EnableCreepSleepBJ( false )
                call SetPlayerFlagBJ( PLAYER_STATE_GIVES_BOUNTY, false, Player(PLAYER_NEUTRAL_AGGRESSIVE) )
            endmethod
        endstruct

    endlibrary

    library BossLib initializer init requires EnemyLib, shared

        globals
            private constant real TIMELINE_TICK = 0.1
            private constant real RESET_DELAY   = 10.0   // 10秒延迟重置
            
            private hashtable hash        = InitHashtable()
            private group     tempGroup   = CreateGroup()
            private timer     updateTimer = null
            
            Boss eventBoss = 0
            boolean needReset = false 
            group allReviveStones = CreateGroup()
        endglobals

        //===========================================================================
        // 便捷函数
        function PauseReviveStones takes nothing returns nothing
            call PauseUnit(GetEnumUnit(),true)
        endfunction
        function UnpauseReviveStones takes nothing returns nothing
            call PauseUnit(GetEnumUnit(),false)
        endfunction

        //===========================================================================
        struct Boss
            // 链表
            static Boss top = 0
            Boss        prev = 0
            minimapicon icon = null 
            // 区域
            rect   area   = null
            region region = null
            
            // 单位（最多 4 个）
            unit   array u [4]
            Enemy  array e [4]
            integer     spawnCount = 0
            integer array spawnId  [4]
            real   array spawnX    [4]
            real   array spawnY    [4]
            real   array spawnF    [4]
            real   array controlPointX  [10]
            real   array controlPointY  [10]
            integer      controlPoints  = 0
            
            // 时间轴
            integer timeline = 0
            integer timelineMax = 0
            integer timelineMin = 0
            boolean pauseTL  = false
            
            // 状态
            boolean active = false
            boolean defeat = false 
            boolean enable = true 
            
            // 触发器（自动创建）
            trigger trigInit      = null
            trigger trigDefeat    = null
            trigger trigReset     = null
            trigger trigResetCheck= null
            trigger trigUpdate    = null 
            
            // 重置定时器
            boolean autoReset     = true 
            timer   resetTimer    = null
                
            static method GetBossFromUnit takes unit u returns Boss
                if u == null then
                    return 0
                endif
                return LoadInteger(hash, GetHandleId(u), 0)
            endmethod
            //=====================================================================
            // 简单创建
            static method createSimple takes nothing returns thistype
                local thistype this = thistype.allocate()
                
                // 加入链表
                set this.prev   = thistype.top
                set thistype.top = this
                
                return this
            endmethod

            //=====================================================================
            // 设置boss区域
            method setRect takes rect r returns nothing
                set this.area   = r
            endmethod
            method regionAddRect takes rect r returns nothing
                if this.region == null then 
                    set this.region = CreateRegion()
                endif 
                call RegionAddRect(this.region, r)
            endmethod
            
            //=====================================================================
            // 创建（地图初始化时调用）
            static method create takes rect r returns thistype
                local thistype this = thistype.allocate()
                
                call this.setRect(r)
                
                // 加入链表
                set this.prev   = thistype.top
                set thistype.top = this
                
                return this
            endmethod
            
            //=====================================================================
            // 添加生成点（最多 4 个）
            method addSpawn takes integer unitId, real x, real y, real facing returns nothing
                local integer i = this.spawnCount
                if i >= 4 then
                    return
                endif
                set this.spawnId[i] = unitId
                set this.spawnX[i]  = x
                set this.spawnY[i]  = y
                set this.spawnF[i]  = facing
                set this.spawnCount = i + 1
            endmethod
            
            //=====================================================================
            // 添加控制点（最多 10 个）
            method addControlPoint takes real x, real y returns nothing
                local integer i = this.controlPoints
                if i >= 4 then
                    return
                endif
                set this.controlPointX[i]  = x
                set this.controlPointY[i]  = y
                set this.controlPoints = i + 1
            endmethod
            
            //=====================================================================
            // 初始化/重新生成所有单位
            method initialize takes nothing returns nothing
                local integer i = 0
                local unit    nu = null
                
                // 清空旧单位
                loop
                    exitwhen i >= 4
                    if this.u[i] != null then
                        if GetEnemyFromUnit(this.u[i]) > 0 then 
                            call GetEnemyFromUnit(this.u[i]).destroy()
                        endif 
                        call KillUnit(this.u[i])
                        call RemoveUnit(this.u[i])
                        set this.u[i] = null
                    endif
                    if this.e[i] != 0 then
                        call this.e[i].destroy()
                        set this.e[i] = 0
                    endif
                    set i = i + 1
                endloop
                
                // 生成新单位
                set i = 0
                loop
                    exitwhen i >= this.spawnCount
                    set nu = CreateUnit(Player(11), this.spawnId[i], this.spawnX[i], this.spawnY[i], this.spawnF[i])
                    set this.u[i] = nu
                    set this.e[i] = RegisterEnemy(nu)
                    set this.e[i].needRespawn = false 
                    call SaveInteger(hash, GetHandleId(nu), 0, this)
                    call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", this.spawnX[i], this.spawnY[i]))
                    call PauseUnit(nu,true)
                    call SetUnitInvulnerable(nu,true)
                    set i = i + 1
                endloop

                set this.timeline = 0
                set this.timelineMax = 0
                set this.timelineMin = 0
                set this.active = false 
                set this.defeat = false 
                
                if this.icon != null then 
                    call DestroyMinimapIcon(this.icon)
                endif 
                set this.icon = CreateMinimapIcon(this.spawnX[0],this.spawnY[0],200,0,0,"ui\\minimap\\minimap-boss.mdx",FOG_OF_WAR_VISIBLE)
                set eventBoss = this
                if this.trigInit != null then
                    call TriggerExecute(this.trigInit)
                endif
                set nu = null
            endmethod
            
            //=====================================================================
            // 事件绑定（takes code）
            method bindOnInit takes code c returns nothing
                local trigger t = null
                if this.trigInit == null then
                    set t = CreateTrigger()
                    set this.trigInit = t
                else
                    set t = this.trigInit
                endif
                call TriggerAddActionEx(t, c)
                set t = null
            endmethod

            method bindOnUpdate takes code c returns nothing
                local trigger t = null
                if this.trigUpdate == null then
                    set t = CreateTrigger()
                    set this.trigUpdate = t
                else
                    set t = this.trigUpdate
                endif
                call TriggerAddActionEx(t, c)
                set t = null
            endmethod
            
            method bindOnDefeat takes code c returns nothing
                local trigger t = null
                if this.trigDefeat == null then
                    set t = CreateTrigger()
                    set this.trigDefeat = t
                else
                    set t = this.trigDefeat
                endif
                call TriggerAddActionEx(t, c)
                set t = null
            endmethod
            
            method bindOnResetCheck takes code c returns nothing
                local trigger t = null
                if this.trigResetCheck == null then
                    set t = CreateTrigger()
                    set this.trigResetCheck = t
                else
                    set t = this.trigResetCheck
                endif
                call TriggerAddActionEx(t, c)
                set t = null
            endmethod

            method bindOnReset takes code c returns nothing
                local trigger t = null
                if this.trigReset == null then
                    set t = CreateTrigger()
                    set this.trigReset = t
                else
                    set t = this.trigReset
                endif
                call TriggerAddActionEx(t, c)
                set t = null
            endmethod

            method Enable takes boolean flag returns nothing
                set this.enable = flag
            endmethod
            
            //=====================================================================
            // 时间轴事件（takes code），每0.1秒一帧
            method addTimeline takes integer timePoint, code c returns nothing
                local trigger t = CreateTrigger()
                call TriggerAddActionEx(t, c)
                if LoadTriggerHandle(hash,this,timePoint) != null then 
                    call DestroyTriggerEx(LoadTriggerHandle(hash,this,timePoint))
                endif 
                call SaveTriggerHandle(hash, this, timePoint, t)
                set t = null
            endmethod
            
            method flushTimeLine takes nothing returns nothing
                call FlushChildHashtable(hash,this)
            endmethod

            //=====================================================================
            // 激活（外部触发器调用）
            method activate takes nothing returns nothing
                if this.enable == false then 
                    return 
                endif 
                if this.active then
                    return
                endif
                set this.active   = true
                set this.timeline = 0
                set this.pauseTL  = false
                if Settings_CombatBossStart then 
                    call triggerCombatLog_Action.execute()
                endif 
                call Preload("S|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(this.spawnId[0]))
                call CheckPoint("LastBossBattleStart",true)
                if updateTimer == null then
                    set updateTimer = CreateTimer()
                    call TimerStart(updateTimer, TIMELINE_TICK, true, function thistype.updateAll)
                endif
                //call ForGroup(allReviveStones,function PauseReviveStones)
            endmethod
            
            //=====================================================================
            // 外部手动调用：标记为已击败
            method executeDefeat takes nothing returns nothing
                set this.defeat = true 
                set eventBoss = this
                if this.icon != null then 
                    call DestroyMinimapIcon(this.icon)
                endif 
                if Settings_CombatBossEnd then 
                    call triggerCombatLog_Action.execute()
                endif 
                call CheckPoint("LastBossDefeated",true)
                if this.trigDefeat != null then
                    call TriggerExecute(this.trigDefeat)
                endif
                call Preload("N|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(this.spawnId[0]))
                //call ForGroup(allReviveStones,function UnpauseReviveStones)
            endmethod
            
            //=====================================================================
            // 时间轴暂停/恢复
            method pauseTimeline takes boolean flag returns nothing
                set this.pauseTL = flag
            endmethod
            
            //=====================================================================
            // 延迟重置定时器回调
            private static method delayReset takes nothing returns nothing
                local timer   tm = GetExpiredTimer()
                local integer id = LoadInteger(hash, GetHandleId(tm), 0)
                local thistype this
                
                if id != 0 then
                    set this = id
                    call this.initialize()  // 10秒后重新生成
                    call FlushChildHashtable(hash, GetHandleId(tm))
                endif
                
                call DestroyTimer(tm)
                set this.resetTimer = null 
                set tm = null
            endmethod
            
            //=====================================================================
            // 重置
            private method reset takes nothing returns nothing
                local integer i = 0
                local unit    tu = null
                
                // 1. 时间轴归零
                set this.timeline = 0
                set this.timelineMin = 0
                set this.timelineMax = 0
                set this.active = false
                set this.defeat = false  

                if this.trigReset != null then 
                    set eventBoss = this 
                    call TriggerExecute(this.trigReset)
                endif 
                
                // 2. 彻底删除现有单位
                loop
                    exitwhen i >= this.spawnCount
                    set tu = this.u[i]
                    if tu != null then
                        if this.e[i] != 0 then
                            call this.e[i].destroy()    // 防止 Enemy 重生
                        endif
                        call KillUnit(tu)               // 触发 hashtable 清理
                        call RemoveUnit(tu)             // 彻底删除
                    endif
                    set this.u[i] = null
                    set this.e[i] = 0
                    set i = i + 1
                endloop
                
                // 3. 10秒后重新生成
                if this.autoReset then 
                    if this.resetTimer == null then
                        set this.resetTimer = CreateTimer()
                        call SaveInteger(hash, GetHandleId(this.resetTimer), 0, this)
                        call TimerStart(this.resetTimer, RESET_DELAY, false, function thistype.delayReset)
                    endif
                endif 
                
                if Settings_CombatBossEnd then 
                    call triggerCombatLog_Action.execute()
                endif 
                if this.icon != null then 
                    call DestroyMinimapIcon(this.icon)
                endif 
                call Preload("N|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(this.spawnId[0]))
                //call ForGroup(allReviveStones,function UnpauseReviveStones)

                set tu = null
            endmethod
            
            method executeReset takes nothing returns nothing
                call this.reset()
            endmethod
            //=====================================================================
            // 检查是否需要重置（每 1 秒）
            private method checkReset takes nothing returns nothing
                local integer i         = 0
                local unit    tu        = null
                //call BJDebugMsg("ACT")
                //call BJDebugMsg(I2S(GetHandleId(this.region))+":"+I2S(GetHandleId(this.area)))

                set needReset = false 
                set eventBoss = this
                // 1. 是否有存活 Boss 单位在区域内
                loop
                    exitwhen i >= this.spawnCount
                    set tu = this.u[i]
                    if tu != null and alive(tu) and IsUnitInRegion(this.region, tu) == false then
                        set needReset = true
                        exitwhen true
                    endif
                    set i = i + 1
                endloop

                // 2. 区域内是否有玩家英雄
                call GroupClear(tempGroup)
                call GroupEnumUnitsInRect(tempGroup, this.area, bossResetFilter)
                if CountUnitsInGroup(tempGroup) == 0 then
                    set needReset = true 
                endif

                //call BJDebugMsg(I2S(GetHandleId(this.region))+":"+I2S(GetHandleId(this.area))+":"+I2S(CountUnitsInGroup(tempGroup)))
                
                // 3. 用户自定义额外检查
                
                if this.trigResetCheck != null then
                    set eventBoss = this
                    call TriggerExecute(this.trigResetCheck)
                endif
                
                // 4. 执行重置
                if needReset then 
                    call this.reset()
                endif 
                
                set tu = null
            endmethod
            
            //=====================================================================
            // 时间轴更新
            private method update takes nothing returns nothing
                local trigger t = null
                
                // 每 1 秒检查重置
                if ModuloInteger(this.timeline, 10) == 0 then
                    call this.checkReset()
                endif
                
                if not this.active or this.pauseTL then
                    return
                endif
                
                if this.trigUpdate != null then 
                    set eventBoss = this 
                    call TriggerExecute(this.trigUpdate)
                endif 

                set this.timeline = this.timeline + 1
                
                // 时间轴事件
                set t = LoadTriggerHandle(hash, this, this.timeline)
                if t != null then
                    set eventBoss = this
                    call TriggerExecute(t)
                endif

                if this.timeline >= this.timelineMax then 
                    set this.timeline = this.timelineMin
                endif 
                
                set t = null
            endmethod
            
            //=====================================================================
            // 全局更新
            private static method updateAll takes nothing returns nothing
                local thistype node = thistype.top
                loop
                    exitwhen node == 0
                    if node.active and node.defeat == false then 
                        call node.update()
                    endif 
                    set node = node.prev
                endloop
            endmethod
        endstruct

        function isReviveStone takes nothing returns boolean
            return GetUnitTypeId(GetFilterUnit()) == 'hAVT'
        endfunction
        private function init takes nothing returns nothing

        endfunction
    endlibrary

    library frame initializer init requires shared

        globals
            constant integer HERO_PUBLIC_TALENT = 0
            constant integer HERO_PRIVATE_TALENT = 1
            constant integer HERO_ULTIMATE_TALENT = 2
            constant string DESCRIPTION_SELECTED = "\n\n|cffa0a0a0点击以卸除配置|r"
            constant string DESCRIPTION_SELECT = "\n\n|cffa0a0a0点击以配置天赋|r"
            constant string DESCRIPTION_TALENT_FULL = "\n\n|cffff0000无天赋栏位|r"
            constant string DESCRIPTION_HAVE_SELECTED = "\n\n|cff00ff00已配置|r"
            constant string DESCRIPTION_ULTIMATE_LIMIT_18 = "\n\n|cffff0000需要等级：18|r"
            constant string DESCRIPTION_ULTIMATE_LIMIT_20 = "\n\n|cffff0000需要等级：20|r"
            constant string DESCRIPTION_ULTIMATE_SELECTED = "\n\n|cff00ff00已激活|r"
            constant string NAME_LIFE   = "|cffffcc00生命：|r"
            constant string NAME_MANA   = "|cffffcc00法力：|r"
            constant string NAME_STR    = "|cffffcc00力量：|r"
            constant string NAME_AGI    = "|cffffcc00敏捷：|r"
            constant string NAME_INT    = "|cffffcc00智力：|r"
            constant string NAME_ATK    = "|cffffcc00攻击：|r"
            constant string NAME_AS     = "|cffffcc00攻击速度：|r"
            constant string NAME_ACC    = "|cffffcc00命中：|r"
            constant string NAME_AP     = "|cffffcc00法术强度：|r"
            constant string NAME_LR     = "|cffffcc00生命恢复：|r"
            constant string NAME_MR     = "|cffffcc00法力恢复：|r"
            constant string NAME_MS     = "|cffffcc00移动速度：|r"
            constant string NAME_ARMOR  = "|cffffcc00护甲：|r"
            constant string NAME_BLOCK  = "|cffffcc00格挡：|r"
            constant string NAME_APEN   = "|cffffcc00护甲穿透：|r"
            constant string NAME_CC     = "|cffffcc00暴击：|r"
            constant string NAME_CP     = "|cffffcc00暴击伤害：|r"
            constant string NAME_HASTE  = "|cffffcc00急速：|r"
            constant string NAME_VER    = "|cffffcc00全能：|r"
            constant string NAME_LEECH  = "|cffffcc00吸血：|r"
            constant string NAME_RES    = "|cffffcc00法术抗性：|r"
            constant string NAME_EVADE  = "|cffffcc00闪避：|r"
            constant string NAME_CR     = "|cffffcc00节能施法：|r"
            constant string NAME_DMG    = "|cffffcc00伤害加成：|r"
            constant string NAME_HEAL   = "|cffffcc00治疗加成：|r"
            constant string NAME_SHIELD = "|cffffcc00护盾加成：|r"
            
            constant string DESC_LIFE   = "生命降至0后，角色就会死亡。"
            constant string DESC_MANA   = "法力是施放技能所需的资源。"
            constant string DESC_STR    = "力量影响生命上限和暴击伤害。"
            constant string DESC_AGI    = "敏捷影响护甲和护甲穿透。"
            constant string DESC_INT    = "智力影响法力上限和法术强度。"
            constant string DESC_ATK    = "攻击影响角色自动攻击和部分技能的效果。"
            constant string DESC_AS     = "角色自动攻击的速度加成，也会影响部分技能的冷却时间，受急速加成。"
            constant string DESC_ACC    = "攻击击中敌人的概率加成。"
            constant string DESC_AP     = "法术强度影响角色部分技能的效果。"
            constant string DESC_LR     = "每秒自动恢复的生命值。"
            constant string DESC_MR     = "每秒自动恢复的法力值。"
            constant string DESC_MS     = "角色每秒能移动的距离。"
            constant string DESC_ARMOR  = "减免物理伤害，护甲的效用与伤害来源的等级有关，默认上限为75%%。"
            constant string DESC_BLOCK  = "减免普通攻击伤害并能降低被敌人碾压的概率，默认减免上限为30%%。"
            constant string DESC_APEN   = "造成物理伤害时穿透敌人的护甲。"
            constant string DESC_CC     = "打出暴击的概率。"
            constant string DESC_CP     = "打出暴击时造成的伤害。"
            constant string DESC_HASTE  = "等量提高角色和召唤生物的攻击速度，并影响部分技能的冷却时间与持续性效果的生效速度。"
            constant string DESC_VER    = "使角色造成的伤害、治疗、护盾效果提高，并降低角色受到的所有伤害。"
            constant string DESC_LEECH  = "角色对其他单位造成伤害或治疗后，恢复部分生命值。"
            constant string DESC_RES    = "减免法术伤害，默认上限为50%%。"
            constant string DESC_EVADE  = "有几率闪避攻击，与伤害来源的命中对抗。闪避上限默认为50%%。"
            constant string DESC_CR     = "施放技能所需的法力降低。"
            constant string DESC_DMG    = "影响角色造成的伤害，受全能加成。"
            constant string DESC_HEAL   = "影响角色造成的治疗，受全能加成。"
            constant string DESC_SHIELD = "影响角色施加的护盾，受全能加成。"

            constant string TYPE_CORE   = "|cffc3dbff[核心属性]|r"
            constant string TYPE_ATK    = "|cffc3dbff[攻击属性]|r"
            constant string TYPE_SPELL  = "|cffc3dbff[施法属性]|r"
            constant string TYPE_DEFND  = "|cffc3dbff[防御属性]|r"
            constant string TYPE_SUB    = "|cffc3dbff[次要属性]|r"

            string array STRING_ST_NAME
            string array STRING_ST_DESC
            State array  STATE_ST_AMOUNT
        endglobals

        globals 
            hashtable TTHashtable = InitHashtable()
            
            framehandle StaticTeamState = null 
            framehandle TooltipStaticTeamState = null 
            framehandle StaticStateTooltipBG = null 
            framehandle array StaticStateTooltipText
            framehandle array HeroStateIcon
            trigger array TriggerHeroStateIcon
            framehandle array HeroStateUbertipBG
            framehandle array TooltipHeroStateUberTipBG
            framehandle array HeroStateName 
            framehandle array HeroStateAmount
            framehandle array HeroName 

            framehandle array TTBGUPPER
            framehandle TalentBackground = null 
            trigger TriggerTalentBackground = null 
            framehandle  array SelectedTalentPublic 
            framehandle  array BackdropSelectedTalentPublic 
            trigger  array TriggerSelectedTalentPublic 
            framehandle  array SelectedTalentPrivate 
            framehandle  array BackdropSelectedTalentPrivate 
            trigger  array TriggerSelectedTalentPrivate 
            framehandle  array PublicTalent 
            framehandle  array BackdropPublicTalent 
            trigger  array TriggerPublicTalent 
            framehandle  array PrivateTalent 
            framehandle  array BackdropPrivateTalent 
            trigger  array TriggerPrivateTalent 
            framehandle  array UltimateTalent 
            framehandle  array BackdropUltimateTalent 
            trigger  array TriggerUltimateTalent 
            framehandle Text029 = null 
            trigger TriggerText029 = null 
            framehandle  array TooltipBackground 
            framehandle  array TooltipTooltipBackground 
            trigger  array TriggerTooltipBackground 
            framehandle  array TooltipText 
            trigger  array TriggerTooltipText 
            
            framehandle TTESC = null 
            framehandle BackdropTTESC = null 

            framehandle array DefaultHeroTooltip

            trigger TriggerTTESC = null 

            unit currentTTOwner = null
            integer currentTTClickBtnIndex = -1

            constant integer TT_ART_ABLE = StringHash("ART_ABLE")
            constant integer TT_ART_DISABLE = StringHash("ART_DISABLE")
            constant integer TT_NAME = StringHash("NAME")
            constant integer TT_DESCRIPTION = StringHash("DESCRIPTION")
            constant integer TT_MAX_LEVEL = StringHash("MAX_LEVEL")
            constant integer TT_REQUIRE = StringHash("REQUIRE")
            constant string PARTY_INDEX = "PARTY_INDEX"
        endglobals


        function SetHeroSelectedPublicTalent takes unit whichHero,integer index,integer whichTalentIndex returns nothing
            call SetHeroData(whichHero,"PUBLIC_TALENT_SELECTED_"+I2S(index),whichTalentIndex)
        endfunction
        function GetHeroSelectedPublicTalent takes unit whichHero,integer index returns integer
            return GetHeroData(whichHero,"PUBLIC_TALENT_SELECTED_"+I2S(index))
        endfunction
        function SetHeroSelectedPrivateTalent takes unit whichHero,integer index,integer whichTalentIndex returns nothing
            call SetHeroData(whichHero,"PRIVATE_TALENT_SELECTED_"+I2S(index),whichTalentIndex)
        endfunction
        function GetHeroSelectedPrivateTalent takes unit whichHero,integer index returns integer
            return GetHeroData(whichHero,"PRIVATE_TALENT_SELECTED_"+I2S(index))
        endfunction
        function SetHeroSelectedUltimateTalent takes unit whichHero,integer index,integer whichTalentIndex returns nothing
            call SetHeroData(whichHero,"ULTIMATE_TALENT_SELECTED_"+I2S(index),whichTalentIndex)
        endfunction
        function GetHeroSelectedUltimateTalent takes unit whichHero,integer index returns integer
            return GetHeroData(whichHero,"ULTIMATE_TALENT_SELECTED_"+I2S(index))
        endfunction

        function HeroHaveTalent takes unit whichHero,integer talentType,integer whichTalentIndex returns boolean
            if talentType == HERO_PUBLIC_TALENT then 
                return (GetHeroSelectedPublicTalent(whichHero,0) == whichTalentIndex) or (GetHeroSelectedPublicTalent(whichHero,1) == whichTalentIndex) or (GetHeroSelectedPublicTalent(whichHero,2) == whichTalentIndex) or (GetHeroSelectedPublicTalent(whichHero,3) == whichTalentIndex)
            elseif talentType == HERO_PRIVATE_TALENT then 
                return (GetHeroSelectedPrivateTalent(whichHero,0) == whichTalentIndex) or (GetHeroSelectedPrivateTalent(whichHero,1) == whichTalentIndex) or (GetHeroSelectedPrivateTalent(whichHero,2) == whichTalentIndex) or (GetHeroSelectedPrivateTalent(whichHero,3) == whichTalentIndex)
            elseif talentType == HERO_ULTIMATE_TALENT then 
                return (GetHeroSelectedUltimateTalent(whichHero,0) == whichTalentIndex) or (GetHeroSelectedUltimateTalent(whichHero,1) == whichTalentIndex)
            endif 
            return false 
        endfunction

        function SetHeroTypePublicTalent takes integer heroIndex,integer talentIndex,integer whichTalent returns nothing
            call SaveInteger(TTHashtable,heroIndex,StringHash("PUBLIC_TALENT_LIST_"+I2S(talentIndex)),whichTalent)
        endfunction
        function GetHeroTypePublicTalent takes integer heroIndex,integer talentIndex returns integer
            return LoadInteger(TTHashtable,heroIndex,StringHash("PUBLIC_TALENT_LIST_"+I2S(talentIndex)))
        endfunction

        function GetTalentArt takes integer heroIndex,integer talentIndex,boolean artAble returns string
            if artAble then 
                return LoadStr(TTHashtable,heroIndex*100+talentIndex,TT_ART_ABLE)
            endif 
            return LoadStr(TTHashtable,heroIndex*100+talentIndex,TT_ART_DISABLE)
        endfunction

        function GetTalentName takes integer heroIndex,integer talentIndex returns string
            return LoadStr(TTHashtable,heroIndex*100+talentIndex,TT_NAME)
        endfunction

        function GetTalentDescription takes integer heroIndex,integer talentIndex returns string
            return LoadStr(TTHashtable,heroIndex*100+talentIndex,TT_DESCRIPTION)
        endfunction

        function SetTalentArt takes integer heroIndex,integer talentIndex,boolean artAble,string value returns nothing
            if artAble then 
                call SaveStr(TTHashtable,heroIndex*100+talentIndex,TT_ART_ABLE,value)
            else
                call SaveStr(TTHashtable,heroIndex*100+talentIndex,TT_ART_DISABLE,value)
            endif 
        endfunction

        function SetTalentName takes integer heroIndex,integer talentIndex,string value returns nothing
            call SaveStr(TTHashtable,heroIndex*100+talentIndex,TT_NAME,value)
        endfunction

        function SetTalentDescription takes integer heroIndex,integer talentIndex,string value returns nothing
            call SaveStr(TTHashtable,heroIndex*100+talentIndex,TT_DESCRIPTION,value)
        endfunction

        function TTUpdate takes nothing returns nothing
            local integer i = 0
            local integer j = 0
            local integer k = 0
            local integer heroId = GetHeroIndex(currentTTOwner)
            local integer publicSolts = IMinBJ(4,(GetUnitLevel(currentTTOwner)+2)/4)
            local integer privateSolts = IMinBJ(4,GetUnitLevel(currentTTOwner)/4)
            local integer ultimateSolt = IMinBJ(2,IMaxBJ(0,GetUnitLevel(currentTTOwner)-16)/2)
            local integer publicCost = 0
            local integer privateCost = 0
            call BlzFrameSetText(Text029, "|cffffcc00"+heroName[GetHeroIndex(currentTTOwner)-1]+"|r")
            set i = 0
            loop 
                exitwhen i > 3
                if publicSolts > i then 
                    call BlzFrameSetTexture(TTBGUPPER[i],"war3campImported\\TTIcon_Uper.blp",0,true)
                    if GetHeroSelectedPublicTalent(currentTTOwner,i) > 0 then 
                        call BlzFrameSetTexture(BackdropSelectedTalentPublic[i],GetTalentArt(0,GetHeroTypePublicTalent(heroId,GetHeroSelectedPublicTalent(currentTTOwner,i)),true),0,true)
                        call BlzFrameSetText(TooltipText[i],"|cffffcc00"+GetTalentName(0,GetHeroTypePublicTalent(heroId,GetHeroSelectedPublicTalent(currentTTOwner,i)))+"|r\n\n"+GetTalentDescription(0,GetHeroTypePublicTalent(heroId,GetHeroSelectedPublicTalent(currentTTOwner,i)))+DESCRIPTION_SELECTED)
                        set publicCost = publicCost+1
                    else 
                        call BlzFrameSetTexture(BackdropSelectedTalentPublic[i],"UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp",0,true)
                        call BlzFrameSetText(TooltipText[i],"|cffffcc00基础天赋|r\n\n 可以从下方选择一项基础天赋")
                    endif 
                else 
                    call BlzFrameSetTexture(TTBGUPPER[i],"war3campImported\\TTIcon_Uper_Disabled.blp",0,true)
                    call BlzFrameSetTexture(BackdropSelectedTalentPublic[i],"UI\\Widgets\\Console\\Undead\\undead-inventory-slotfiller.blp",0,true)
                    call BlzFrameSetText(TooltipText[i],"|cffff0000未解锁此基础天赋|r\n\n 该天赋栏位在等级|cffffcc00"+I2S(i*4+2)+"|r解锁")
                endif 
                if privateSolts > i then 
                    call BlzFrameSetTexture(TTBGUPPER[12+i],"war3campImported\\TTIcon_Uper.blp",0,true)
                    if GetHeroSelectedPrivateTalent(currentTTOwner,i) > 0 then 
                        call BlzFrameSetTexture(BackdropSelectedTalentPrivate[i],GetTalentArt(heroId,GetHeroSelectedPrivateTalent(currentTTOwner,i),true),0,true)
                        call BlzFrameSetText(TooltipText[12+i],"|cffffcc00"+GetTalentName(heroId,GetHeroSelectedPrivateTalent(currentTTOwner,i))+"|r\n\n"+GetTalentDescription(heroId,GetHeroSelectedPrivateTalent(currentTTOwner,i))+DESCRIPTION_SELECTED)
                        set privateCost = privateCost+1
                    else 
                        call BlzFrameSetTexture(BackdropSelectedTalentPrivate[i],"UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp",0,true)
                        call BlzFrameSetText(TooltipText[12+i],"|cffffcc00进阶天赋|r\n\n 可以从下方选择一项进阶天赋")
                    endif 
                else 
                    call BlzFrameSetTexture(TTBGUPPER[12+i],"war3campImported\\TTIcon_Uper_Disabled.blp",0,true)
                    call BlzFrameSetTexture(BackdropSelectedTalentPrivate[i],"UI\\Widgets\\Console\\Undead\\undead-inventory-slotfiller.blp",0,true)
                    call BlzFrameSetText(TooltipText[12+i],"|cffff0000未解锁此进阶天赋|r\n\n 该天赋栏位在等级|cffffcc00"+I2S(i*4+4)+"|r解锁")
                endif 
                if HeroHaveTalent(currentTTOwner,HERO_ULTIMATE_TALENT,i+9) then 
                    call BlzFrameSetTexture(TTBGUPPER[24+i],"war3campImported\\TTIcon_Uper.blp",0,true)
                    call BlzFrameSetTexture(BackdropUltimateTalent[i],GetTalentArt(heroId,9+i,true),0,true)
                    call BlzFrameSetText(TooltipText[24+i],"|cffffcc00"+GetTalentName(heroId,9+i)+"|r"+DESCRIPTION_ULTIMATE_SELECTED+"\n\n"+GetTalentDescription(heroId,9+i)+DESCRIPTION_SELECTED)
                else 
                    call BlzFrameSetTexture(TTBGUPPER[24+i],"war3campImported\\TTIcon_Uper_Disabled.blp",0,true)
                    call BlzFrameSetTexture(BackdropUltimateTalent[i],GetTalentArt(heroId,9+i,false),0,true)
                    if ultimateSolt == 0 then 
                        call BlzFrameSetText(TooltipText[24+i],"|cffffcc00"+GetTalentName(heroId,9+i)+"|r"+DESCRIPTION_ULTIMATE_LIMIT_18+"\n\n"+GetTalentDescription(heroId,9+i))
                    elseif ultimateSolt == 1 and GetHeroSelectedUltimateTalent(currentTTOwner,0) > 0 then
                        call BlzFrameSetText(TooltipText[24+i],"|cffffcc00"+GetTalentName(heroId,9+i)+"|r"+DESCRIPTION_ULTIMATE_LIMIT_20+"\n\n"+GetTalentDescription(heroId,9+i))
                    elseif ultimateSolt == 2 and GetHeroSelectedUltimateTalent(currentTTOwner,0) > 0 and GetHeroSelectedUltimateTalent(currentTTOwner,1) > 0 then
                        call BlzFrameSetText(TooltipText[24+i],"|cffffcc00"+GetTalentName(heroId,9+i)+"|r"+DESCRIPTION_TALENT_FULL+"\n\n"+GetTalentDescription(heroId,9+i))
                    else
                        call BlzFrameSetText(TooltipText[24+i],"|cffffcc00"+GetTalentName(heroId,9+i)+"|r\n\n"+GetTalentDescription(heroId,9+i)+DESCRIPTION_SELECT)
                    endif 
                endif 
                set i = i+1
            endloop
            set i = 0
            loop 
                exitwhen i > 7  
                //检视基础天赋
                //有空位，则已选天赋变暗，未选天赋变亮
                if publicCost < publicSolts then 
                    if HeroHaveTalent(currentTTOwner,HERO_PUBLIC_TALENT,i+1) then 
                        call BlzFrameSetTexture(BackdropPublicTalent[i],GetTalentArt(0,GetHeroTypePublicTalent(heroId,i+1),false),0,true)
                        call BlzFrameSetText(TooltipText[4+i],"|cffffcc00"+GetTalentName(0,GetHeroTypePublicTalent(heroId,i+1))+"|r"+DESCRIPTION_HAVE_SELECTED+"\n\n"+GetTalentDescription(0,GetHeroTypePublicTalent(heroId,i+1)))
                    else 
                        call BlzFrameSetTexture(BackdropPublicTalent[i],GetTalentArt(0,GetHeroTypePublicTalent(heroId,i+1),true),0,true)
                        call BlzFrameSetText(TooltipText[4+i],"|cffffcc00"+GetTalentName(0,GetHeroTypePublicTalent(heroId,i+1))+"|r\n\n"+GetTalentDescription(0,GetHeroTypePublicTalent(heroId,i+1))+DESCRIPTION_SELECT)
                    endif 
                else 
                //无空位，则已选天赋变亮，未选天赋变暗
                    if HeroHaveTalent(currentTTOwner,HERO_PUBLIC_TALENT,i+1) then 
                        call BlzFrameSetTexture(BackdropPublicTalent[i],GetTalentArt(0,GetHeroTypePublicTalent(heroId,i+1),true),0,true)
                        call BlzFrameSetText(TooltipText[4+i],"|cffffcc00"+GetTalentName(0,GetHeroTypePublicTalent(heroId,i+1))+"|r"+DESCRIPTION_HAVE_SELECTED+"\n\n"+GetTalentDescription(0,GetHeroTypePublicTalent(heroId,i+1)))
                    else 
                        call BlzFrameSetTexture(BackdropPublicTalent[i],GetTalentArt(0,GetHeroTypePublicTalent(heroId,i+1),false),0,true)
                        call BlzFrameSetText(TooltipText[4+i],"|cffffcc00"+GetTalentName(0,GetHeroTypePublicTalent(heroId,i+1))+"|r"+DESCRIPTION_TALENT_FULL+"\n\n"+GetTalentDescription(0,GetHeroTypePublicTalent(heroId,i+1)))
                    endif 
                endif 
                //检视进阶天赋
                //有空位，则已选天赋变暗，未选天赋变亮
                if privateCost < privateSolts then 
                    if HeroHaveTalent(currentTTOwner,HERO_PRIVATE_TALENT,i+1) then 
                        call BlzFrameSetTexture(BackdropPrivateTalent[i],GetTalentArt(heroId,i+1,false),0,true)
                        call BlzFrameSetText(TooltipText[16+i],"|cffffcc00"+GetTalentName(heroId,i+1)+"|r"+DESCRIPTION_HAVE_SELECTED+"\n\n"+GetTalentDescription(heroId,i+1))
                    else 
                        call BlzFrameSetTexture(BackdropPrivateTalent[i],GetTalentArt(heroId,i+1,true),0,true)
                        call BlzFrameSetText(TooltipText[16+i],"|cffffcc00"+GetTalentName(heroId,i+1)+"|r\n\n"+GetTalentDescription(heroId,i+1)+DESCRIPTION_SELECT)
                    endif 
                else 
                //无空位，则已选天赋变亮，未选天赋变暗
                    if HeroHaveTalent(currentTTOwner,HERO_PRIVATE_TALENT,i+1) then 
                        call BlzFrameSetTexture(BackdropPrivateTalent[i],GetTalentArt(heroId,i+1,true),0,true)
                        call BlzFrameSetText(TooltipText[16+i],"|cffffcc00"+GetTalentName(heroId,i+1)+"|r"+DESCRIPTION_HAVE_SELECTED+"\n\n"+GetTalentDescription(heroId,i+1))
                    else 
                        call BlzFrameSetTexture(BackdropPrivateTalent[i],GetTalentArt(heroId,i+1,false),0,true)
                        call BlzFrameSetText(TooltipText[16+i],"|cffffcc00"+GetTalentName(heroId,i+1)+"|r"+DESCRIPTION_TALENT_FULL+"\n\n"+GetTalentDescription(heroId,i+1))
                    endif 
                endif 
                set i = i+1
            endloop
        endfunction
        function TTLearn takes integer slot,integer index,integer whichTalent returns nothing
            local integer i = whichTalent
            ////////call BJDebugMsg(" HERO: "+GetUnitName(currentTTOwner)+" FOR_SLOT: "+I2S(slot)+" FOR_INDEX: "+I2S(index)+" LEARN_TALENT: "+I2S(whichTalent))
            if slot == HERO_PUBLIC_TALENT then 
                set i = GetHeroTypePublicTalent(GetHeroIndex(currentTTOwner),whichTalent)
                call ExecuteFunc("PUBLIC_TALENT_LEARN_"+I2S(i))
                call SetHeroSelectedPublicTalent(currentTTOwner,index,whichTalent)
            elseif slot == HERO_PRIVATE_TALENT then 
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(currentTTOwner))+"_TALENT_LEARN_"+I2S(i))
                call SetHeroSelectedPrivateTalent(currentTTOwner,index,whichTalent)
            elseif slot == HERO_ULTIMATE_TALENT then 
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(currentTTOwner))+"_TALENT_LEARN_"+I2S(i))
                call SetHeroSelectedUltimateTalent(currentTTOwner,index,whichTalent)
            endif 
            call TTUpdate.execute()
            call State.checkAll.evaluate(currentTTOwner)
        endfunction

        function TTInitialize takes unit whichHero returns nothing
            
        endfunction

        function TTReset takes integer slot,integer index returns nothing
            local integer i
            ////////call BJDebugMsg(" HERO: "+GetUnitName(currentTTOwner)+" FOR_SLOT: "+I2S(slot)+" FORGET_TALENT: "+I2S(index))
            //////call BJDebugMsg(GetUnitName(currentTTOwner)+I2S(GetHandleId(currentTTOwner)))
            //////call BJDebugMsg(I2S(index))
            if slot == HERO_PUBLIC_TALENT then 
                set i = GetHeroTypePublicTalent(GetHeroIndex(currentTTOwner),GetHeroSelectedPublicTalent(currentTTOwner,index))
                call ExecuteFunc("PUBLIC_TALENT_RESET_"+I2S(i))
                call SetHeroSelectedPublicTalent(currentTTOwner,index,0)
            elseif slot == HERO_PRIVATE_TALENT then 
                set i = GetHeroSelectedPrivateTalent(currentTTOwner,index)
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(currentTTOwner))+"_TALENT_RESET_"+I2S(i))
                //////call BJDebugMsg(I2S(GetHeroIndex(currentTTOwner))+"-"+I2S(i))
                call SetHeroSelectedPrivateTalent(currentTTOwner,index,0)
            elseif slot == HERO_ULTIMATE_TALENT then 
                set i = GetHeroSelectedUltimateTalent(currentTTOwner,index)
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(currentTTOwner))+"_TALENT_RESET_"+I2S(i))
                call SetHeroSelectedUltimateTalent(currentTTOwner,index,0)
            endif 
            call TTUpdate.execute()
            call State.checkAll.evaluate(currentTTOwner)
        endfunction

        function TTClick takes nothing returns nothing
            local integer i = 0
            local integer k = 0
            local integer j = 0
            local boolean error = false 
            local integer errorId = 0
            local integer publicSolts = IMinBJ(4,(GetUnitLevel(currentTTOwner)+2)/4)
            local integer privateSolts = IMinBJ(4,GetUnitLevel(currentTTOwner)/4)
            local integer ultimateSolt = IMinBJ(2,IMaxBJ(0,GetUnitLevel(currentTTOwner)-16)/2)
            //判断是否在战斗，战斗中返回errorId = 99(无法在战斗中调整天赋设置)
            if inCombat(currentTTOwner) or alive(currentTTOwner) == false then 
                set error = true 
                set errorId = 99
            endif 
            if not error then 
                //判断点击的区域
                //1.指针为0-3：通用已选择天赋区，点击动作为卸下
                if currentTTClickBtnIndex >= 0 and currentTTClickBtnIndex <= 3 then 
                    //换算指针
                    set i = currentTTClickBtnIndex
                    //判断槽位是否已经解锁，未解锁则不做动作
                    if publicSolts-1 >= i then 
                        //判断槽位是否为空，为空则不做动作
                        if GetHeroSelectedPublicTalent(currentTTOwner,i) > 0 then 
                            //重置天赋
                            call TTReset(HERO_PUBLIC_TALENT,i)
                        endif 
                    endif
                endif 
                //2.指针为4-7：专属已选择天赋区，点击动作为卸下
                if currentTTClickBtnIndex >= 4 and currentTTClickBtnIndex <= 7 then 
                    //换算指针
                    set i = currentTTClickBtnIndex-4
                    //判断槽位是否已经解锁，未解锁则不做动作
                    if privateSolts-1 >= i then 
                        //判断槽位是否为空，为空则不做动作
                        if GetHeroSelectedPrivateTalent(currentTTOwner,i) > 0 then 
                            //重置天赋
                            call TTReset(HERO_PRIVATE_TALENT,i)
                        endif 
                    endif
                endif 
                //3.指针为8-15：通用天赋备选区，点击动作为装配
                if currentTTClickBtnIndex >= 8 and currentTTClickBtnIndex <= 15 then 
                    //换算指针
                    set i = currentTTClickBtnIndex-8
                    set k = publicSolts-1
                    set j = -1
                    loop 
                        //判断是否已有，如已有返回errorId = 1(不能装备重复的天赋)
                        exitwhen k <0
                        if GetHeroSelectedPublicTalent(currentTTOwner,k) == i+1 then 
                            set error = true 
                            set errorId = 1
                        endif 
                        if GetHeroSelectedPublicTalent(currentTTOwner,k) == 0 then 
                            set j = k
                        endif 
                        set k = k-1
                    endloop
                    if not error then 
                        //判断是否已满，如已满返回errorId = 2(没有空余的基础天赋栏位)
                        if j < 0 then 
                            set error = true 
                            set errorId = 2
                        else 
                            //未满，装备
                            call TTLearn(HERO_PUBLIC_TALENT,j,i+1)
                        endif 
                    endif 
                endif 
                //4.指针为16-23：专属天赋备选区，点击动作为装配
                if currentTTClickBtnIndex >= 16 and currentTTClickBtnIndex <= 23 then 
                    //换算指针
                    set i = currentTTClickBtnIndex-16
                    set k = privateSolts-1
                    set j = -1
                    loop 
                        //判断是否已有，如已有返回errorId = 1(不能装备重复的天赋)
                        exitwhen k <0
                        if GetHeroSelectedPrivateTalent(currentTTOwner,k) == i+1 then 
                            set error = true 
                            set errorId = 1
                        endif 
                        if GetHeroSelectedPrivateTalent(currentTTOwner,k) == 0 then 
                            set j = k
                        endif 
                        set k = k-1
                    endloop
                    if not error then 
                        //判断是否已满，如已满返回errorId = 3(没有空余的进阶天赋栏位)
                        if j < 0 then 
                            set error = true 
                            set errorId = 3
                        else 
                            //未满，装备
                            call TTLearn(HERO_PRIVATE_TALENT,j,i+1)
                        endif 
                    endif 
                endif 
                //5.指针为24-27：终极天赋区，点击动作为替换
                if currentTTClickBtnIndex >= 24 and currentTTClickBtnIndex <= 27 then 
                    //换算指针
                    set i = currentTTClickBtnIndex-24
                    //判断是否有终极技能槽位，如无则不进行动作
                    if ultimateSolt > 0 then 
                        //判断点击的是否为现有的，如是则取消天赋
                        if HeroHaveTalent(currentTTOwner,HERO_ULTIMATE_TALENT,i+9) then
                            if GetHeroSelectedUltimateTalent(currentTTOwner,0) == i+9 then  
                                call TTReset(HERO_ULTIMATE_TALENT,0)
                            elseif GetHeroSelectedUltimateTalent(currentTTOwner,1) == i+9 then 
                                call TTReset(HERO_ULTIMATE_TALENT,1)
                            endif 
                        else 
                        //学习新的
                            if GetHeroSelectedUltimateTalent(currentTTOwner,0) == 0 then 
                                call TTLearn(HERO_ULTIMATE_TALENT,0,i+9)
                            elseif GetHeroSelectedUltimateTalent(currentTTOwner,1) == 0 and ultimateSolt > 1 then 
                                call TTLearn(HERO_ULTIMATE_TALENT,1,i+9)
                            endif 
                        endif
                    endif 
                endif 
            endif 
            //错误提示
            if error then 
                if errorId == 1 then 
                    //call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00你不能装备两个重复的天赋。|r")
                elseif errorId == 2 then 
                    //call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00没有空余的基础天赋栏位。|r")
                elseif errorId == 3 then 
                    //call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00没有空余的进阶天赋栏位。|r")
                elseif errorId == 99 then 
                    call DisplayErrorMsg("|cffffcc00战斗中不能变更天赋设置。|r")
                endif 
            endif 
            //初始化指针
            set currentTTClickBtnIndex = -1
        endfunction

        function SelectedTalentPublic00Func takes nothing returns nothing 
            call BlzFrameSetEnable(SelectedTalentPublic[0], false) 
            call BlzFrameSetEnable(SelectedTalentPublic[0], true) 
            set currentTTClickBtnIndex = 0
            call TTClick()
        endfunction 
        
        function SelectedTalentPublic01Func takes nothing returns nothing 
            call BlzFrameSetEnable(SelectedTalentPublic[1], false) 
            call BlzFrameSetEnable(SelectedTalentPublic[1], true) 
            set currentTTClickBtnIndex = 1
            call TTClick()
        endfunction 
        
        function SelectedTalentPublic02Func takes nothing returns nothing 
            call BlzFrameSetEnable(SelectedTalentPublic[2], false) 
            call BlzFrameSetEnable(SelectedTalentPublic[2], true) 
            set currentTTClickBtnIndex = 2
            call TTClick()
        endfunction 
        
        function SelectedTalentPublic03Func takes nothing returns nothing 
            call BlzFrameSetEnable(SelectedTalentPublic[3], false) 
            call BlzFrameSetEnable(SelectedTalentPublic[3], true) 
            set currentTTClickBtnIndex = 3
            call TTClick()
        endfunction 
        
        function SelectedTalentPrivate00Func takes nothing returns nothing 
            call BlzFrameSetEnable(SelectedTalentPrivate[0], false) 
            call BlzFrameSetEnable(SelectedTalentPrivate[0], true) 
            set currentTTClickBtnIndex = 4
            call TTClick()
        endfunction 
        
        function SelectedTalentPrivate01Func takes nothing returns nothing 
            call BlzFrameSetEnable(SelectedTalentPrivate[1], false) 
            call BlzFrameSetEnable(SelectedTalentPrivate[1], true) 
            set currentTTClickBtnIndex = 5
            call TTClick()
        endfunction 
        
        function SelectedTalentPrivate02Func takes nothing returns nothing 
            call BlzFrameSetEnable(SelectedTalentPrivate[2], false) 
            call BlzFrameSetEnable(SelectedTalentPrivate[2], true) 
            set currentTTClickBtnIndex = 6
            call TTClick()
        endfunction 
        
        function SelectedTalentPrivate03Func takes nothing returns nothing 
            call BlzFrameSetEnable(SelectedTalentPrivate[3], false) 
            call BlzFrameSetEnable(SelectedTalentPrivate[3], true) 
            set currentTTClickBtnIndex = 7
            call TTClick()
        endfunction 
        
        function PublicTalent00Func takes nothing returns nothing 
            call BlzFrameSetEnable(PublicTalent[0], false) 
            call BlzFrameSetEnable(PublicTalent[0], true) 
            set currentTTClickBtnIndex = 8
            call TTClick()
        endfunction 
        
        function PublicTalent01Func takes nothing returns nothing 
            call BlzFrameSetEnable(PublicTalent[1], false) 
            call BlzFrameSetEnable(PublicTalent[1], true) 
            set currentTTClickBtnIndex = 9
            call TTClick()
        endfunction 
        
        function PublicTalent02Func takes nothing returns nothing 
            call BlzFrameSetEnable(PublicTalent[2], false) 
            call BlzFrameSetEnable(PublicTalent[2], true) 
            set currentTTClickBtnIndex = 10
            call TTClick()
        endfunction 
        
        function PublicTalent03Func takes nothing returns nothing 
            call BlzFrameSetEnable(PublicTalent[3], false) 
            call BlzFrameSetEnable(PublicTalent[3], true) 
            set currentTTClickBtnIndex = 11
            call TTClick()
        endfunction 
        
        function PublicTalent04Func takes nothing returns nothing 
            call BlzFrameSetEnable(PublicTalent[4], false) 
            call BlzFrameSetEnable(PublicTalent[4], true) 
            set currentTTClickBtnIndex = 12
            call TTClick()
        endfunction 
        
        function PublicTalent05Func takes nothing returns nothing 
            call BlzFrameSetEnable(PublicTalent[5], false) 
            call BlzFrameSetEnable(PublicTalent[5], true) 
            set currentTTClickBtnIndex = 13
            call TTClick()
        endfunction 
        
        function PublicTalent06Func takes nothing returns nothing 
            call BlzFrameSetEnable(PublicTalent[6], false) 
            call BlzFrameSetEnable(PublicTalent[6], true) 
            set currentTTClickBtnIndex = 14
            call TTClick()
        endfunction 
        
        function PublicTalent07Func takes nothing returns nothing 
            call BlzFrameSetEnable(PublicTalent[7], false) 
            call BlzFrameSetEnable(PublicTalent[7], true) 
            set currentTTClickBtnIndex = 15
            call TTClick()
        endfunction 
        
        function PrivateTalent00Func takes nothing returns nothing 
            call BlzFrameSetEnable(PrivateTalent[0], false) 
            call BlzFrameSetEnable(PrivateTalent[0], true) 
            set currentTTClickBtnIndex = 16
            call TTClick()
        endfunction 
        
        function PrivateTalent01Func takes nothing returns nothing 
            call BlzFrameSetEnable(PrivateTalent[1], false) 
            call BlzFrameSetEnable(PrivateTalent[1], true) 
            set currentTTClickBtnIndex = 17
            call TTClick()
        endfunction 
        
        function PrivateTalent02Func takes nothing returns nothing 
            call BlzFrameSetEnable(PrivateTalent[2], false) 
            call BlzFrameSetEnable(PrivateTalent[2], true) 
            set currentTTClickBtnIndex = 18
            call TTClick()
        endfunction 
        
        function PrivateTalent03Func takes nothing returns nothing 
            call BlzFrameSetEnable(PrivateTalent[3], false) 
            call BlzFrameSetEnable(PrivateTalent[3], true) 
            set currentTTClickBtnIndex = 19
            call TTClick()
        endfunction 
        
        function PrivateTalent04Func takes nothing returns nothing 
            call BlzFrameSetEnable(PrivateTalent[4], false) 
            call BlzFrameSetEnable(PrivateTalent[4], true) 
            set currentTTClickBtnIndex = 20
            call TTClick()
        endfunction 
        
        function PrivateTalent05Func takes nothing returns nothing 
            call BlzFrameSetEnable(PrivateTalent[5], false) 
            call BlzFrameSetEnable(PrivateTalent[5], true) 
            set currentTTClickBtnIndex = 21
            call TTClick()
        endfunction 
        
        function PrivateTalent06Func takes nothing returns nothing 
            call BlzFrameSetEnable(PrivateTalent[6], false) 
            call BlzFrameSetEnable(PrivateTalent[6], true) 
            set currentTTClickBtnIndex = 22
            call TTClick()
        endfunction 
        
        function PrivateTalent07Func takes nothing returns nothing 
            call BlzFrameSetEnable(PrivateTalent[7], false) 
            call BlzFrameSetEnable(PrivateTalent[7], true) 
            set currentTTClickBtnIndex = 23
            call TTClick()
        endfunction 
        
        function UltimateTalent00Func takes nothing returns nothing 
            call BlzFrameSetEnable(UltimateTalent[0], false) 
            call BlzFrameSetEnable(UltimateTalent[0], true) 
            set currentTTClickBtnIndex = 24
            call TTClick()
        endfunction 
        
        function UltimateTalent01Func takes nothing returns nothing 
            call BlzFrameSetEnable(UltimateTalent[1], false) 
            call BlzFrameSetEnable(UltimateTalent[1], true) 
            set currentTTClickBtnIndex = 25
            call TTClick()
        endfunction 
        
        function UltimateTalent02Func takes nothing returns nothing 
            call BlzFrameSetEnable(UltimateTalent[2], false) 
            call BlzFrameSetEnable(UltimateTalent[2], true) 
            set currentTTClickBtnIndex = 26
            call TTClick()
        endfunction 
        
        function UltimateTalent03Func takes nothing returns nothing 
            call BlzFrameSetEnable(UltimateTalent[3], false) 
            call BlzFrameSetEnable(UltimateTalent[3], true) 
            set currentTTClickBtnIndex = 27
            call TTClick()
        endfunction 

        function TTESCFunc takes nothing returns nothing 
            call BlzFrameSetEnable(TTESC, false) 
            call BlzFrameSetEnable(TTESC, true) 
            call BlzFrameSetVisible(TalentBackground,false)
            set currentTTOwner = null 
        endfunction 

        function resetAllFrames takes nothing returns nothing
            local integer i = 0
            local integer k = 0

            set StaticTeamState = null 
            set TooltipStaticTeamState = null 
            set StaticStateTooltipBG = null 
            set TalentBackground = null 
            set i = 0
            loop
                exitwhen i > 30
                set StaticStateTooltipText[i] = null
                set i = i+1 
            endloop
            set i = 0
            loop
                exitwhen i > 4
                set HeroName[i] = null 
                set HeroStateIcon[i] = null 
                set TooltipHeroStateUberTipBG[i] = null 
                set HeroStateUbertipBG[i] = null 
                set k = 0
                loop
                    exitwhen k > 30
                    set HeroStateName[i*31+k] = null
                    set HeroStateAmount[i*31+k] = null
                    set k = k+1
                endloop
                set i = i+1
            endloop

            set i = 0
            loop
                exitwhen i > 20
                set TTBGUPPER[i] = null 
                set SelectedTalentPublic [i] = null 
                set BackdropSelectedTalentPublic [i] = null 
                set SelectedTalentPrivate [i] = null 
                set BackdropSelectedTalentPrivate [i] = null 
                set PublicTalent [i] = null 
                set BackdropPublicTalent [i] = null 
                set PrivateTalent [i] = null 
                set BackdropPrivateTalent [i] = null 
                set UltimateTalent [i] = null 
                set BackdropUltimateTalent [i] = null 
                set TooltipBackground [i] = null 
                set TooltipTooltipBackground [i] = null 
                set TooltipText [i] = null 
                set i = i+1
            endloop
            set Text029 = null 
            set TTESC = null 
            set BackdropTTESC = null 
        endfunction

        globals 
            string STATIC_STATE_DESC = ""
        endglobals
        function createStateIcons takes nothing returns nothing
            
            local integer i = 0
            local integer k = 0
            local integer p = 0

            local real x = 0
            local real y = 0
            
            set StaticTeamState = BlzCreateFrameByType("TEXT", "name", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
            set GLOBAL_CREATED_FRAME = GLOBAL_CREATED_FRAME+1
            call BlzFrameSetAbsPoint(StaticTeamState, FRAMEPOINT_TOPLEFT, 0.200000, 0.140)
            call BlzFrameSetAbsPoint(StaticTeamState, FRAMEPOINT_BOTTOMRIGHT, 0.310000, 0.120)
            call BlzFrameSetText(StaticTeamState, "|cffFFCC00队伍属性：开(Alt)|r")
            call BlzFrameSetEnable(StaticTeamState, false)
            call BlzFrameSetScale(StaticTeamState, 1.00)
            call BlzFrameSetTextAlignment(StaticTeamState, TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_RIGHT)

            set TooltipStaticTeamState = BlzCreateFrameByType("FRAME", "", StaticTeamState, "", 0)
            call BlzFrameSetAllPoints(TooltipStaticTeamState, StaticTeamState)
            
            set StaticStateTooltipBG = BlzCreateFrameByType("BACKDROP","HEROSTBG["+I2S(i)+"]", StaticTeamState,"",0)
            call BlzFrameSetAbsPoint(StaticStateTooltipBG, FRAMEPOINT_TOPLEFT, 0.0420000, 0.530040)
            call BlzFrameSetAbsPoint(StaticStateTooltipBG, FRAMEPOINT_BOTTOMRIGHT, 0.645230, 0.160040)
            call BlzFrameSetTexture(StaticStateTooltipBG, "replaceabletextures\\commandbuttons\\fromDOTA\\btnnothing.blp", 0, true)
            call BlzFrameSetAlpha(StaticStateTooltipBG,75)
            call BlzFrameSetTooltip(StaticTeamState, StaticStateTooltipBG)

            call BlzFrameSetTooltip(TooltipStaticTeamState, StaticStateTooltipBG) 

            set k = 0
            set i = 0
            loop
                exitwhen i > 30 
                if i != 0 and i != 9 and i != 14 and i != 17 and i != 22 then 
                    set StaticStateTooltipText[i] = BlzCreateFrameByType("TEXT", "tooltip", StaticStateTooltipBG, "", 0)
                    call BlzFrameSetAbsPoint(StaticStateTooltipText[i], FRAMEPOINT_TOPLEFT, 0.0522000, 0.520040-0.01355*I2R(k))
                    call BlzFrameSetAbsPoint(StaticStateTooltipText[i], FRAMEPOINT_BOTTOMRIGHT, 0.645230, 0.520040-0.01355-0.01355*I2R(k))
                    call BlzFrameSetText(StaticStateTooltipText[i],STRING_ST_NAME[i]+STRING_ST_DESC[i])
                    call BlzFrameSetEnable(StaticStateTooltipText[i], false)
                    call BlzFrameSetScale(StaticStateTooltipText[i], 1)
                    call BlzFrameSetTextAlignment(StaticStateTooltipText[i], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
                    set k = k+1
                endif 
                set i = i+1
            endloop

            set i = 0
            loop
                exitwhen i > 4
                set HeroStateIcon[i] = BlzCreateFrameByType("BACKDROP", "BACKDROP", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 1)
                set GLOBAL_CREATED_FRAME = GLOBAL_CREATED_FRAME+1
                call BlzFrameSetAbsPoint(HeroStateIcon[i], FRAMEPOINT_TOPLEFT, 0.315+0.02*I2R(i), 0.140)
                call BlzFrameSetAbsPoint(HeroStateIcon[i], FRAMEPOINT_BOTTOMRIGHT, 0.335+0.02*I2R(i), 0.120)
                call BlzFrameSetTexture(HeroStateIcon[i], "CustomFrame.png", 0, true)
                call BlzFrameSetVisible(HeroStateIcon[i],false)

                set HeroStateUbertipBG[i] = BlzCreateFrameByType("BACKDROP","HEROSTBG["+I2S(i)+"]", HeroStateIcon[i],"",0)
                call BlzFrameSetAbsPoint(HeroStateUbertipBG[i], FRAMEPOINT_TOPLEFT, 0.000220000, 0.500040)
                call BlzFrameSetAbsPoint(HeroStateUbertipBG[i], FRAMEPOINT_BOTTOMRIGHT, 0.421220, 0.160040)
                call BlzFrameSetAlpha(HeroStateUbertipBG[i],75)
                call BlzFrameSetTexture(HeroStateUbertipBG[i], "UI\\Widgets\\EscMenu\\Human\\editbox-background.blp", 0, true)

                set TooltipHeroStateUberTipBG[i] = BlzCreateFrameByType("FRAME", "", HeroStateIcon[i], "", 0)
                call BlzFrameSetAllPoints(TooltipHeroStateUberTipBG[i], HeroStateIcon[i])
                call BlzFrameSetTooltip(TooltipHeroStateUberTipBG[i], HeroStateUbertipBG[i])

                set HeroName[i] = BlzCreateFrameByType("TEXT", "name", HeroStateUbertipBG[i], "", 0)
                call BlzFrameSetAbsPoint(HeroName[i], FRAMEPOINT_TOPLEFT, 0.00900000, 0.460000)
                call BlzFrameSetAbsPoint(HeroName[i], FRAMEPOINT_BOTTOMRIGHT,  0.209000, 0.445500)
                call BlzFrameSetText(HeroName[i], "|cffFFCC00HeroName0 - Level XX|r")
                call BlzFrameSetEnable(HeroName[i], false)
                call BlzFrameSetScale(HeroName[i], 1.20)
                call BlzFrameSetTextAlignment(HeroName[i], TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_MIDDLE)

                set k = 0
                loop
                    exitwhen k > 30
                    if k > 13 then 
                        set p = k-14
                        set x = 0.21000
                        set y = 0.48120
                    else 
                        set p = k
                        set x = 0.00022
                        set y = 0.42555
                    endif 

                    set HeroStateName[i*31+k] = BlzCreateFrameByType("TEXT", "name", HeroStateUbertipBG[i], "", 0)
                    call BlzFrameSetAbsPoint(HeroStateName[i*31+k], FRAMEPOINT_TOPLEFT, x,y-0.01855*I2R(p))
                    call BlzFrameSetAbsPoint(HeroStateName[i*31+k], FRAMEPOINT_BOTTOMRIGHT, x+0.07045,y-0.01855-0.01855*I2R(p))
                    call BlzFrameSetText(HeroStateName[i*31+k], STRING_ST_NAME[k])
                    call BlzFrameSetScale(HeroStateName[i*31+k], 1.075)
                    call BlzFrameSetEnable(HeroStateAmount[i*31+k], false)
                    call BlzFrameSetTextAlignment(HeroStateName[i*31+k], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_RIGHT)

                    
                    set HeroStateAmount[i*31+k] = BlzCreateFrameByType("TEXT", "amount", HeroStateUbertipBG[i], "", 0)
                    call BlzFrameSetAbsPoint(HeroStateAmount[i*31+k], FRAMEPOINT_TOPLEFT, x+0.07492, y-0.01855*I2R(p))
                    call BlzFrameSetAbsPoint(HeroStateAmount[i*31+k], FRAMEPOINT_BOTTOMRIGHT, x+0.22547, y-0.01855-0.01855*I2R(p))
                    call BlzFrameSetText(HeroStateAmount[i*31+k], "0")
                    call BlzFrameSetScale(HeroStateAmount[i*31+k], 1.075)
                    call BlzFrameSetEnable(HeroStateAmount[i*31+k], false)
                    call BlzFrameSetTextAlignment(HeroStateAmount[i*31+k], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

                    set k = k+1
                endloop

                set i = i+1
            endloop
            call SHOW_PARTY_DATAS_Check.execute()
        endfunction

        function createTalentFrame takes nothing returns nothing  
            local integer i = 0
            local integer k = 0
            local integer p = 0

            local real x = 0
            local real y = 0
            
            set TalentBackground = BlzCreateFrameByType("BACKDROP", "BACKDROP", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 1)
            set GLOBAL_CREATED_FRAME = GLOBAL_CREATED_FRAME+1
            call BlzFrameSetAbsPoint(TalentBackground, FRAMEPOINT_TOPLEFT, 0.406430, 0.420000)
            call BlzFrameSetAbsPoint(TalentBackground, FRAMEPOINT_BOTTOMRIGHT, 0.801430, 0.160000)
            call BlzFrameSetTexture(TalentBackground, "war3campImported\\talent.blp", 0, true)
            
            set TTESC = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(TTESC, FRAMEPOINT_TOPLEFT, 0.7700, 0.39000)
            call BlzFrameSetAbsPoint(TTESC, FRAMEPOINT_BOTTOMRIGHT, 0.75000, 0.37000)
            
            set BackdropTTESC = BlzCreateFrameByType("BACKDROP", "BackdropTTESC", TTESC, "", 0)
            call BlzFrameSetAllPoints(BackdropTTESC, TTESC)
            call BlzFrameSetTexture(BackdropTTESC, "ReplaceableTextures\\CommandButtons\\BTNCancel.blp", 0, true)
            set TriggerTTESC = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerTTESC, TTESC, FRAMEEVENT_CONTROL_CLICK) 
            call TriggerRegisterPlayerEventEndCinematic(TriggerTTESC,Player(0))
            call TriggerAddActionEx(TriggerTTESC, function TTESCFunc) 

            set SelectedTalentPublic[0] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(SelectedTalentPublic[0], FRAMEPOINT_TOPLEFT, 0.420000, 0.340000)
            call BlzFrameSetAbsPoint(SelectedTalentPublic[0], FRAMEPOINT_BOTTOMRIGHT, 0.450000, 0.310000)

            set BackdropSelectedTalentPublic[0] = BlzCreateFrameByType("BACKDROP", "BackdropSelectedTalentPublic[0]", SelectedTalentPublic[0], "", 0)
            call BlzFrameSetAllPoints(BackdropSelectedTalentPublic[0], SelectedTalentPublic[0])
            call BlzFrameSetTexture(BackdropSelectedTalentPublic[0], "CustomFrame.png", 0, true)
            set TriggerSelectedTalentPublic[0] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerSelectedTalentPublic[0], SelectedTalentPublic[0], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerSelectedTalentPublic[0], function SelectedTalentPublic00Func) 

            set SelectedTalentPublic[1] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(SelectedTalentPublic[1], FRAMEPOINT_TOPLEFT, 0.455000, 0.340000)
            call BlzFrameSetAbsPoint(SelectedTalentPublic[1], FRAMEPOINT_BOTTOMRIGHT, 0.485000, 0.310000)

            set BackdropSelectedTalentPublic[1] = BlzCreateFrameByType("BACKDROP", "BackdropSelectedTalentPublic[1]", SelectedTalentPublic[1], "", 0)
            call BlzFrameSetAllPoints(BackdropSelectedTalentPublic[1], SelectedTalentPublic[1])
            call BlzFrameSetTexture(BackdropSelectedTalentPublic[1], "CustomFrame.png", 0, true)
            set TriggerSelectedTalentPublic[1] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerSelectedTalentPublic[1], SelectedTalentPublic[1], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerSelectedTalentPublic[1], function SelectedTalentPublic01Func) 

            set SelectedTalentPublic[2] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(SelectedTalentPublic[2], FRAMEPOINT_TOPLEFT, 0.490000, 0.340000)
            call BlzFrameSetAbsPoint(SelectedTalentPublic[2], FRAMEPOINT_BOTTOMRIGHT, 0.520000, 0.310000)

            set BackdropSelectedTalentPublic[2] = BlzCreateFrameByType("BACKDROP", "BackdropSelectedTalentPublic[2]", SelectedTalentPublic[2], "", 0)
            call BlzFrameSetAllPoints(BackdropSelectedTalentPublic[2], SelectedTalentPublic[2])
            call BlzFrameSetTexture(BackdropSelectedTalentPublic[2], "CustomFrame.png", 0, true)
            set TriggerSelectedTalentPublic[2] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerSelectedTalentPublic[2], SelectedTalentPublic[2], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerSelectedTalentPublic[2], function SelectedTalentPublic02Func) 

            set SelectedTalentPublic[3] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(SelectedTalentPublic[3], FRAMEPOINT_TOPLEFT, 0.525000, 0.340000)
            call BlzFrameSetAbsPoint(SelectedTalentPublic[3], FRAMEPOINT_BOTTOMRIGHT, 0.555000, 0.310000)

            set BackdropSelectedTalentPublic[3] = BlzCreateFrameByType("BACKDROP", "BackdropSelectedTalentPublic[3]", SelectedTalentPublic[3], "", 0)
            call BlzFrameSetAllPoints(BackdropSelectedTalentPublic[3], SelectedTalentPublic[3])
            call BlzFrameSetTexture(BackdropSelectedTalentPublic[3], "CustomFrame.png", 0, true)
            set TriggerSelectedTalentPublic[3] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerSelectedTalentPublic[3], SelectedTalentPublic[3], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerSelectedTalentPublic[3], function SelectedTalentPublic03Func) 

            set SelectedTalentPrivate[0] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(SelectedTalentPrivate[0], FRAMEPOINT_TOPLEFT, 0.650000, 0.340000)
            call BlzFrameSetAbsPoint(SelectedTalentPrivate[0], FRAMEPOINT_BOTTOMRIGHT, 0.680000, 0.310000)

            set BackdropSelectedTalentPrivate[0] = BlzCreateFrameByType("BACKDROP", "BackdropSelectedTalentPrivate[0]", SelectedTalentPrivate[0], "", 0)
            call BlzFrameSetAllPoints(BackdropSelectedTalentPrivate[0], SelectedTalentPrivate[0])
            call BlzFrameSetTexture(BackdropSelectedTalentPrivate[0], "CustomFrame.png", 0, true)
            set TriggerSelectedTalentPrivate[0] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerSelectedTalentPrivate[0], SelectedTalentPrivate[0], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerSelectedTalentPrivate[0], function SelectedTalentPrivate00Func) 

            set SelectedTalentPrivate[1] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(SelectedTalentPrivate[1], FRAMEPOINT_TOPLEFT, 0.685000, 0.340000)
            call BlzFrameSetAbsPoint(SelectedTalentPrivate[1], FRAMEPOINT_BOTTOMRIGHT, 0.715000, 0.310000)

            set BackdropSelectedTalentPrivate[1] = BlzCreateFrameByType("BACKDROP", "BackdropSelectedTalentPrivate[1]", SelectedTalentPrivate[1], "", 0)
            call BlzFrameSetAllPoints(BackdropSelectedTalentPrivate[1], SelectedTalentPrivate[1])
            call BlzFrameSetTexture(BackdropSelectedTalentPrivate[1], "CustomFrame.png", 0, true)
            set TriggerSelectedTalentPrivate[1] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerSelectedTalentPrivate[1], SelectedTalentPrivate[1], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerSelectedTalentPrivate[1], function SelectedTalentPrivate01Func) 

            set SelectedTalentPrivate[2] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(SelectedTalentPrivate[2], FRAMEPOINT_TOPLEFT, 0.720000, 0.340000)
            call BlzFrameSetAbsPoint(SelectedTalentPrivate[2], FRAMEPOINT_BOTTOMRIGHT, 0.750000, 0.310000)

            set BackdropSelectedTalentPrivate[2] = BlzCreateFrameByType("BACKDROP", "BackdropSelectedTalentPrivate[2]", SelectedTalentPrivate[2], "", 0)
            call BlzFrameSetAllPoints(BackdropSelectedTalentPrivate[2], SelectedTalentPrivate[2])
            call BlzFrameSetTexture(BackdropSelectedTalentPrivate[2], "CustomFrame.png", 0, true)
            set TriggerSelectedTalentPrivate[2] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerSelectedTalentPrivate[2], SelectedTalentPrivate[2], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerSelectedTalentPrivate[2], function SelectedTalentPrivate02Func) 

            set SelectedTalentPrivate[3] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(SelectedTalentPrivate[3], FRAMEPOINT_TOPLEFT, 0.755000, 0.340000)
            call BlzFrameSetAbsPoint(SelectedTalentPrivate[3], FRAMEPOINT_BOTTOMRIGHT, 0.785000, 0.310000)

            set BackdropSelectedTalentPrivate[3] = BlzCreateFrameByType("BACKDROP", "BackdropSelectedTalentPrivate[3]", SelectedTalentPrivate[3], "", 0)
            call BlzFrameSetAllPoints(BackdropSelectedTalentPrivate[3], SelectedTalentPrivate[3])
            call BlzFrameSetTexture(BackdropSelectedTalentPrivate[3], "CustomFrame.png", 0, true)
            set TriggerSelectedTalentPrivate[3] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerSelectedTalentPrivate[3], SelectedTalentPrivate[3], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerSelectedTalentPrivate[3], function SelectedTalentPrivate03Func) 

            set PublicTalent[0] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PublicTalent[0], FRAMEPOINT_TOPLEFT, 0.420000, 0.280000)
            call BlzFrameSetAbsPoint(PublicTalent[0], FRAMEPOINT_BOTTOMRIGHT, 0.450000, 0.250000)

            set BackdropPublicTalent[0] = BlzCreateFrameByType("BACKDROP", "BackdropPublicTalent[0]", PublicTalent[0], "", 0)
            call BlzFrameSetAllPoints(BackdropPublicTalent[0], PublicTalent[0])
            call BlzFrameSetTexture(BackdropPublicTalent[0], "CustomFrame.png", 0, true)
            set TriggerPublicTalent[0] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPublicTalent[0], PublicTalent[0], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPublicTalent[0], function PublicTalent00Func) 

            set PublicTalent[2] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PublicTalent[2], FRAMEPOINT_TOPLEFT, 0.490000, 0.280000)
            call BlzFrameSetAbsPoint(PublicTalent[2], FRAMEPOINT_BOTTOMRIGHT, 0.520000, 0.250000)

            set BackdropPublicTalent[2] = BlzCreateFrameByType("BACKDROP", "BackdropPublicTalent[2]", PublicTalent[2], "", 0)
            call BlzFrameSetAllPoints(BackdropPublicTalent[2], PublicTalent[2])
            call BlzFrameSetTexture(BackdropPublicTalent[2], "CustomFrame.png", 0, true)
            set TriggerPublicTalent[2] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPublicTalent[2], PublicTalent[2], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPublicTalent[2], function PublicTalent02Func) 

            set PublicTalent[1] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PublicTalent[1], FRAMEPOINT_TOPLEFT, 0.455000, 0.280000)
            call BlzFrameSetAbsPoint(PublicTalent[1], FRAMEPOINT_BOTTOMRIGHT, 0.485000, 0.250000)

            set BackdropPublicTalent[1] = BlzCreateFrameByType("BACKDROP", "BackdropPublicTalent[1]", PublicTalent[1], "", 0)
            call BlzFrameSetAllPoints(BackdropPublicTalent[1], PublicTalent[1])
            call BlzFrameSetTexture(BackdropPublicTalent[1], "CustomFrame.png", 0, true)
            set TriggerPublicTalent[1] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPublicTalent[1], PublicTalent[1], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPublicTalent[1], function PublicTalent01Func) 

            set PublicTalent[3] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PublicTalent[3], FRAMEPOINT_TOPLEFT, 0.525000, 0.280000)
            call BlzFrameSetAbsPoint(PublicTalent[3], FRAMEPOINT_BOTTOMRIGHT, 0.555000, 0.250000)

            set BackdropPublicTalent[3] = BlzCreateFrameByType("BACKDROP", "BackdropPublicTalent[3]", PublicTalent[3], "", 0)
            call BlzFrameSetAllPoints(BackdropPublicTalent[3], PublicTalent[3])
            call BlzFrameSetTexture(BackdropPublicTalent[3], "CustomFrame.png", 0, true)
            set TriggerPublicTalent[3] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPublicTalent[3], PublicTalent[3], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPublicTalent[3], function PublicTalent03Func) 

            set PublicTalent[4] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PublicTalent[4], FRAMEPOINT_TOPLEFT, 0.420000, 0.240000)
            call BlzFrameSetAbsPoint(PublicTalent[4], FRAMEPOINT_BOTTOMRIGHT, 0.450000, 0.210000)

            set BackdropPublicTalent[4] = BlzCreateFrameByType("BACKDROP", "BackdropPublicTalent[4]", PublicTalent[4], "", 0)
            call BlzFrameSetAllPoints(BackdropPublicTalent[4], PublicTalent[4])
            call BlzFrameSetTexture(BackdropPublicTalent[4], "CustomFrame.png", 0, true)
            set TriggerPublicTalent[4] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPublicTalent[4], PublicTalent[4], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPublicTalent[4], function PublicTalent04Func) 

            set PublicTalent[5] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PublicTalent[5], FRAMEPOINT_TOPLEFT, 0.455000, 0.240000)
            call BlzFrameSetAbsPoint(PublicTalent[5], FRAMEPOINT_BOTTOMRIGHT, 0.485000, 0.210000)

            set BackdropPublicTalent[5] = BlzCreateFrameByType("BACKDROP", "BackdropPublicTalent[5]", PublicTalent[5], "", 0)
            call BlzFrameSetAllPoints(BackdropPublicTalent[5], PublicTalent[5])
            call BlzFrameSetTexture(BackdropPublicTalent[5], "CustomFrame.png", 0, true)
            set TriggerPublicTalent[5] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPublicTalent[5], PublicTalent[5], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPublicTalent[5], function PublicTalent05Func) 

            set PublicTalent[6] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PublicTalent[6], FRAMEPOINT_TOPLEFT, 0.490000, 0.240000)
            call BlzFrameSetAbsPoint(PublicTalent[6], FRAMEPOINT_BOTTOMRIGHT, 0.520000, 0.210000)

            set BackdropPublicTalent[6] = BlzCreateFrameByType("BACKDROP", "BackdropPublicTalent[6]", PublicTalent[6], "", 0)
            call BlzFrameSetAllPoints(BackdropPublicTalent[6], PublicTalent[6])
            call BlzFrameSetTexture(BackdropPublicTalent[6], "CustomFrame.png", 0, true)
            set TriggerPublicTalent[6] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPublicTalent[6], PublicTalent[6], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPublicTalent[6], function PublicTalent06Func) 

            set PublicTalent[7] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PublicTalent[7], FRAMEPOINT_TOPLEFT, 0.525000, 0.240000)
            call BlzFrameSetAbsPoint(PublicTalent[7], FRAMEPOINT_BOTTOMRIGHT, 0.555000, 0.210000)

            set BackdropPublicTalent[7] = BlzCreateFrameByType("BACKDROP", "BackdropPublicTalent[7]", PublicTalent[7], "", 0)
            call BlzFrameSetAllPoints(BackdropPublicTalent[7], PublicTalent[7])
            call BlzFrameSetTexture(BackdropPublicTalent[7], "CustomFrame.png", 0, true)
            set TriggerPublicTalent[7] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPublicTalent[7], PublicTalent[7], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPublicTalent[7], function PublicTalent07Func) 

            set PrivateTalent[0] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PrivateTalent[0], FRAMEPOINT_TOPLEFT, 0.650000, 0.280000)
            call BlzFrameSetAbsPoint(PrivateTalent[0], FRAMEPOINT_BOTTOMRIGHT, 0.680000, 0.250000)

            set BackdropPrivateTalent[0] = BlzCreateFrameByType("BACKDROP", "BackdropPrivateTalent[0]", PrivateTalent[0], "", 0)
            call BlzFrameSetAllPoints(BackdropPrivateTalent[0], PrivateTalent[0])
            call BlzFrameSetTexture(BackdropPrivateTalent[0], "CustomFrame.png", 0, true)
            set TriggerPrivateTalent[0] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPrivateTalent[0], PrivateTalent[0], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPrivateTalent[0], function PrivateTalent00Func) 

            set PrivateTalent[1] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PrivateTalent[1], FRAMEPOINT_TOPLEFT, 0.685000, 0.280000)
            call BlzFrameSetAbsPoint(PrivateTalent[1], FRAMEPOINT_BOTTOMRIGHT, 0.715000, 0.250000)

            set BackdropPrivateTalent[1] = BlzCreateFrameByType("BACKDROP", "BackdropPrivateTalent[1]", PrivateTalent[1], "", 0)
            call BlzFrameSetAllPoints(BackdropPrivateTalent[1], PrivateTalent[1])
            call BlzFrameSetTexture(BackdropPrivateTalent[1], "CustomFrame.png", 0, true)
            set TriggerPrivateTalent[1] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPrivateTalent[1], PrivateTalent[1], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPrivateTalent[1], function PrivateTalent01Func) 

            set PrivateTalent[2] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PrivateTalent[2], FRAMEPOINT_TOPLEFT, 0.720000, 0.280000)
            call BlzFrameSetAbsPoint(PrivateTalent[2], FRAMEPOINT_BOTTOMRIGHT, 0.750000, 0.250000)

            set BackdropPrivateTalent[2] = BlzCreateFrameByType("BACKDROP", "BackdropPrivateTalent[2]", PrivateTalent[2], "", 0)
            call BlzFrameSetAllPoints(BackdropPrivateTalent[2], PrivateTalent[2])
            call BlzFrameSetTexture(BackdropPrivateTalent[2], "CustomFrame.png", 0, true)
            set TriggerPrivateTalent[2] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPrivateTalent[2], PrivateTalent[2], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPrivateTalent[2], function PrivateTalent02Func) 

            set PrivateTalent[3] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PrivateTalent[3], FRAMEPOINT_TOPLEFT, 0.755000, 0.280000)
            call BlzFrameSetAbsPoint(PrivateTalent[3], FRAMEPOINT_BOTTOMRIGHT, 0.785000, 0.250000)

            set BackdropPrivateTalent[3] = BlzCreateFrameByType("BACKDROP", "BackdropPrivateTalent[3]", PrivateTalent[3], "", 0)
            call BlzFrameSetAllPoints(BackdropPrivateTalent[3], PrivateTalent[3])
            call BlzFrameSetTexture(BackdropPrivateTalent[3], "CustomFrame.png", 0, true)
            set TriggerPrivateTalent[3] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPrivateTalent[3], PrivateTalent[3], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPrivateTalent[3], function PrivateTalent03Func) 

            set PrivateTalent[4] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PrivateTalent[4], FRAMEPOINT_TOPLEFT, 0.650000, 0.240000)
            call BlzFrameSetAbsPoint(PrivateTalent[4], FRAMEPOINT_BOTTOMRIGHT, 0.680000, 0.210000)

            set BackdropPrivateTalent[4] = BlzCreateFrameByType("BACKDROP", "BackdropPrivateTalent[4]", PrivateTalent[4], "", 0)
            call BlzFrameSetAllPoints(BackdropPrivateTalent[4], PrivateTalent[4])
            call BlzFrameSetTexture(BackdropPrivateTalent[4], "CustomFrame.png", 0, true)
            set TriggerPrivateTalent[4] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPrivateTalent[4], PrivateTalent[4], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPrivateTalent[4], function PrivateTalent04Func) 

            set PrivateTalent[5] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PrivateTalent[5], FRAMEPOINT_TOPLEFT, 0.685000, 0.240000)
            call BlzFrameSetAbsPoint(PrivateTalent[5], FRAMEPOINT_BOTTOMRIGHT, 0.715000, 0.210000)

            set BackdropPrivateTalent[5] = BlzCreateFrameByType("BACKDROP", "BackdropPrivateTalent[5]", PrivateTalent[5], "", 0)
            call BlzFrameSetAllPoints(BackdropPrivateTalent[5], PrivateTalent[5])
            call BlzFrameSetTexture(BackdropPrivateTalent[5], "CustomFrame.png", 0, true)
            set TriggerPrivateTalent[5] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPrivateTalent[5], PrivateTalent[5], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPrivateTalent[5], function PrivateTalent05Func) 

            set PrivateTalent[6] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PrivateTalent[6], FRAMEPOINT_TOPLEFT, 0.720000, 0.240000)
            call BlzFrameSetAbsPoint(PrivateTalent[6], FRAMEPOINT_BOTTOMRIGHT, 0.750000, 0.210000)

            set BackdropPrivateTalent[6] = BlzCreateFrameByType("BACKDROP", "BackdropPrivateTalent[6]", PrivateTalent[6], "", 0)
            call BlzFrameSetAllPoints(BackdropPrivateTalent[6], PrivateTalent[6])
            call BlzFrameSetTexture(BackdropPrivateTalent[6], "CustomFrame.png", 0, true)
            set TriggerPrivateTalent[6] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPrivateTalent[6], PrivateTalent[6], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPrivateTalent[6], function PrivateTalent06Func) 

            set PrivateTalent[7] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(PrivateTalent[7], FRAMEPOINT_TOPLEFT, 0.755000, 0.240000)
            call BlzFrameSetAbsPoint(PrivateTalent[7], FRAMEPOINT_BOTTOMRIGHT, 0.785000, 0.210000)

            set BackdropPrivateTalent[7] = BlzCreateFrameByType("BACKDROP", "BackdropPrivateTalent[7]", PrivateTalent[7], "", 0)
            call BlzFrameSetAllPoints(BackdropPrivateTalent[7], PrivateTalent[7])
            call BlzFrameSetTexture(BackdropPrivateTalent[7], "CustomFrame.png", 0, true)
            set TriggerPrivateTalent[7] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerPrivateTalent[7], PrivateTalent[7], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerPrivateTalent[7], function PrivateTalent07Func) 

            set UltimateTalent[0] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(UltimateTalent[0], FRAMEPOINT_TOPLEFT, 0.585000, 0.345000)
            call BlzFrameSetAbsPoint(UltimateTalent[0], FRAMEPOINT_BOTTOMRIGHT, 0.620000, 0.310000)

            set BackdropUltimateTalent[0] = BlzCreateFrameByType("BACKDROP", "BackdropUltimateTalent[0]", UltimateTalent[0], "", 0)
            call BlzFrameSetAllPoints(BackdropUltimateTalent[0], UltimateTalent[0])
            call BlzFrameSetTexture(BackdropUltimateTalent[0], "CustomFrame.png", 0, true)
            set TriggerUltimateTalent[0] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerUltimateTalent[0], UltimateTalent[0], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerUltimateTalent[0], function UltimateTalent00Func) 

            set UltimateTalent[1] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(UltimateTalent[1], FRAMEPOINT_TOPLEFT, 0.585000, 0.305000)
            call BlzFrameSetAbsPoint(UltimateTalent[1], FRAMEPOINT_BOTTOMRIGHT, 0.620000, 0.270000)

            set BackdropUltimateTalent[1] = BlzCreateFrameByType("BACKDROP", "BackdropUltimateTalent[1]", UltimateTalent[1], "", 0)
            call BlzFrameSetAllPoints(BackdropUltimateTalent[1], UltimateTalent[1])
            call BlzFrameSetTexture(BackdropUltimateTalent[1], "CustomFrame.png", 0, true)
            set TriggerUltimateTalent[1] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerUltimateTalent[1], UltimateTalent[1], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerUltimateTalent[1], function UltimateTalent01Func) 

            set UltimateTalent[2] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(UltimateTalent[2], FRAMEPOINT_TOPLEFT, 0.585000, 0.265000)
            call BlzFrameSetAbsPoint(UltimateTalent[2], FRAMEPOINT_BOTTOMRIGHT, 0.620000, 0.230000)

            set BackdropUltimateTalent[2] = BlzCreateFrameByType("BACKDROP", "BackdropUltimateTalent[2]", UltimateTalent[2], "", 0)
            call BlzFrameSetAllPoints(BackdropUltimateTalent[2], UltimateTalent[2])
            call BlzFrameSetTexture(BackdropUltimateTalent[2], "CustomFrame.png", 0, true)
            set TriggerUltimateTalent[2] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerUltimateTalent[2], UltimateTalent[2], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerUltimateTalent[2], function UltimateTalent02Func) 

            set UltimateTalent[3] = BlzCreateFrame("IconButtonTemplate", TalentBackground, 0, 0)
            call BlzFrameSetAbsPoint(UltimateTalent[3], FRAMEPOINT_TOPLEFT, 0.585000, 0.225000)
            call BlzFrameSetAbsPoint(UltimateTalent[3], FRAMEPOINT_BOTTOMRIGHT, 0.620000, 0.190000)

            set BackdropUltimateTalent[3] = BlzCreateFrameByType("BACKDROP", "BackdropUltimateTalent[3]", UltimateTalent[3], "", 0)
            call BlzFrameSetAllPoints(BackdropUltimateTalent[3], UltimateTalent[3])
            call BlzFrameSetTexture(BackdropUltimateTalent[3], "CustomFrame.png", 0, true)
            set TriggerUltimateTalent[3] = CreateTrigger() 
            call BlzTriggerRegisterFrameEvent(TriggerUltimateTalent[3], UltimateTalent[3], FRAMEEVENT_CONTROL_CLICK) 
            call TriggerAddActionEx(TriggerUltimateTalent[3], function UltimateTalent03Func) 

            set Text029 = BlzCreateFrameByType("TEXT", "name", TalentBackground, "", 0)
            call BlzFrameSetAbsPoint(Text029, FRAMEPOINT_TOPLEFT, 0.567500, 0.400000)
            call BlzFrameSetAbsPoint(Text029, FRAMEPOINT_BOTTOMRIGHT, 0.637500, 0.370000)
            call BlzFrameSetText(Text029, "|cffFFCC00英雄名称|r")
            call BlzFrameSetEnable(Text029, false)
            call BlzFrameSetScale(Text029, 1.29)
            call BlzFrameSetTextAlignment(Text029, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_MIDDLE)

            loop 
                exitwhen i > 3

                set TooltipBackground[i] = BlzCreateFrameByType("BACKDROP","TOOLTIPBG["+I2S(i)+"]", SelectedTalentPublic[i],"",0)
                call BlzFrameSetAbsPoint(TooltipBackground[i], FRAMEPOINT_TOPLEFT, 0.00000, 0.421000)
                call BlzFrameSetAbsPoint(TooltipBackground[i], FRAMEPOINT_BOTTOMRIGHT, 0.230000, 0.160000)
                call BlzFrameSetTexture(TooltipBackground[i], "UI\\Widgets\\EscMenu\\Human\\editbox-background.blp", 0, true)

                call BlzFrameSetTooltip(SelectedTalentPublic[i], TooltipBackground[i])

                set TooltipText[i] = BlzCreateFrameByType("TEXT", "name", TooltipBackground[i], "", 0)
                call BlzFrameSetAbsPoint(TooltipText[i], FRAMEPOINT_TOPLEFT, 0.0150000, 0.4000)
                call BlzFrameSetAbsPoint(TooltipText[i], FRAMEPOINT_BOTTOMRIGHT, 0.215000, 0.169000)
                call BlzFrameSetText(TooltipText[i], "|cffffffff天赋名称\n\n天赋效果天赋效果天赋效果|r")
                call BlzFrameSetEnable(TooltipText[i], false)
                call BlzFrameSetScale(TooltipText[i], 1.14)
                call BlzFrameSetTextAlignment(TooltipText[i], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

                set TTBGUPPER[i] = BlzCreateFrameByType("BACKDROP", "TTBGUPPER["+I2S(i)+"]", SelectedTalentPublic[i], "", 0)
                call BlzFrameSetAllPoints(TTBGUPPER[i], SelectedTalentPublic[i])
                call BlzFrameSetTexture(TTBGUPPER[i], "war3campImported\\TTIcon_Uper_Disabled.blp", 0, true)

                set i = i+1 
            endloop 
            loop 
                exitwhen i > 11

                set TooltipBackground[i] = BlzCreateFrameByType("BACKDROP","TOOLTIPBG["+I2S(i)+"]", PublicTalent[i-4],"",0)
                call BlzFrameSetAbsPoint(TooltipBackground[i], FRAMEPOINT_TOPLEFT, 0.00000, 0.421000)
                call BlzFrameSetAbsPoint(TooltipBackground[i], FRAMEPOINT_BOTTOMRIGHT, 0.230000, 0.160000)
                call BlzFrameSetTexture(TooltipBackground[i], "UI\\Widgets\\EscMenu\\Human\\editbox-background.blp", 0, true)

                call BlzFrameSetTooltip(PublicTalent[i-4], TooltipBackground[i])

                set TooltipText[i] = BlzCreateFrameByType("TEXT", "name", TooltipBackground[i], "", 0)
                call BlzFrameSetAbsPoint(TooltipText[i], FRAMEPOINT_TOPLEFT, 0.0150000, 0.4000)
                call BlzFrameSetAbsPoint(TooltipText[i], FRAMEPOINT_BOTTOMRIGHT, 0.215000, 0.169000)
                call BlzFrameSetText(TooltipText[i], "|cffffffff天赋名称\n\n天赋效果天赋效果天赋效果|r")
                call BlzFrameSetEnable(TooltipText[i], false)
                call BlzFrameSetScale(TooltipText[i], 1.14)
                call BlzFrameSetTextAlignment(TooltipText[i], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

                set i = i+1 
            endloop 
            loop 
                exitwhen i > 15

                set TooltipBackground[i] = BlzCreateFrameByType("BACKDROP","TOOLTIPBG["+I2S(i)+"]", SelectedTalentPrivate[i-12],"",0)
                call BlzFrameSetAbsPoint(TooltipBackground[i], FRAMEPOINT_TOPLEFT, 0.00000, 0.421000)
                call BlzFrameSetAbsPoint(TooltipBackground[i], FRAMEPOINT_BOTTOMRIGHT, 0.230000, 0.160000)
                call BlzFrameSetTexture(TooltipBackground[i], "UI\\Widgets\\EscMenu\\Human\\editbox-background.blp", 0, true)

                call BlzFrameSetTooltip(SelectedTalentPrivate[i-12], TooltipBackground[i])

                set TooltipText[i] = BlzCreateFrameByType("TEXT", "name", TooltipBackground[i], "", 0)
                call BlzFrameSetAbsPoint(TooltipText[i], FRAMEPOINT_TOPLEFT, 0.0150000, 0.4000)
                call BlzFrameSetAbsPoint(TooltipText[i], FRAMEPOINT_BOTTOMRIGHT, 0.215000, 0.169000)
                call BlzFrameSetText(TooltipText[i], "|cffffffff天赋名称\n\n天赋效果天赋效果天赋效果|r")
                call BlzFrameSetEnable(TooltipText[i], false)
                call BlzFrameSetScale(TooltipText[i], 1.14)
                call BlzFrameSetTextAlignment(TooltipText[i], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

                set TTBGUPPER[i] = BlzCreateFrameByType("BACKDROP", "TTBGUPPER["+I2S(i)+"]", SelectedTalentPrivate[i-12], "", 0)
                call BlzFrameSetAllPoints(TTBGUPPER[i], SelectedTalentPrivate[i-12])
                call BlzFrameSetTexture(TTBGUPPER[i], "war3campImported\\TTIcon_Uper_Disabled.blp", 0, true)

                set i = i+1 
            endloop 
            loop 
                exitwhen i > 23

                set TooltipBackground[i] = BlzCreateFrameByType("BACKDROP","TOOLTIPBG["+I2S(i)+"]", PrivateTalent[i-16],"",0)
                call BlzFrameSetAbsPoint(TooltipBackground[i], FRAMEPOINT_TOPLEFT, 0.00000, 0.421000)
                call BlzFrameSetAbsPoint(TooltipBackground[i], FRAMEPOINT_BOTTOMRIGHT, 0.230000, 0.160000)
                call BlzFrameSetTexture(TooltipBackground[i], "UI\\Widgets\\EscMenu\\Human\\editbox-background.blp", 0, true)

                call BlzFrameSetTooltip(PrivateTalent[i-16], TooltipBackground[i])

                set TooltipText[i] = BlzCreateFrameByType("TEXT", "name", TooltipBackground[i], "", 0)
                call BlzFrameSetAbsPoint(TooltipText[i], FRAMEPOINT_TOPLEFT, 0.0150000, 0.4000)
                call BlzFrameSetAbsPoint(TooltipText[i], FRAMEPOINT_BOTTOMRIGHT, 0.215000, 0.169000)
                call BlzFrameSetText(TooltipText[i], "|cffffffff天赋名称\n\n天赋效果天赋效果天赋效果|r")
                call BlzFrameSetEnable(TooltipText[i], false)
                call BlzFrameSetScale(TooltipText[i], 1.14)
                call BlzFrameSetTextAlignment(TooltipText[i], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

                set i = i+1 
            endloop 
            loop 
                exitwhen i > 27

                set TooltipBackground[i] = BlzCreateFrameByType("BACKDROP","TOOLTIPBG["+I2S(i)+"]", UltimateTalent[i-24],"",0)
                call BlzFrameSetAbsPoint(TooltipBackground[i], FRAMEPOINT_TOPLEFT, 0.00000, 0.421000)
                call BlzFrameSetAbsPoint(TooltipBackground[i], FRAMEPOINT_BOTTOMRIGHT, 0.230000, 0.160000)
                call BlzFrameSetTexture(TooltipBackground[i], "UI\\Widgets\\EscMenu\\Human\\editbox-background.blp", 0, true)

                call BlzFrameSetTooltip(UltimateTalent[i-24], TooltipBackground[i])

                set TooltipText[i] = BlzCreateFrameByType("TEXT", "name", TooltipBackground[i], "", 0)
                call BlzFrameSetAbsPoint(TooltipText[i], FRAMEPOINT_TOPLEFT, 0.0150000, 0.4000)
                call BlzFrameSetAbsPoint(TooltipText[i], FRAMEPOINT_BOTTOMRIGHT, 0.215000, 0.169000)
                call BlzFrameSetText(TooltipText[i], "|cffffffff天赋名称\n\n天赋效果天赋效果天赋效果|r")
                call BlzFrameSetEnable(TooltipText[i], false)
                call BlzFrameSetScale(TooltipText[i], 1.14)
                call BlzFrameSetTextAlignment(TooltipText[i], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

                set TTBGUPPER[i] = BlzCreateFrameByType("BACKDROP", "TTBGUPPER["+I2S(i)+"]", UltimateTalent[i-24], "", 0)
                call BlzFrameSetAllPoints(TTBGUPPER[i], UltimateTalent[i-24])
                call BlzFrameSetTexture(TTBGUPPER[i], "war3campImported\\TTIcon_Uper_Disabled.blp", 0, true)

                set i = i+1 
            endloop 
            call BlzFrameSetVisible(TalentBackground,false)
        
        endfunction
        function SetOriginFramePoints takes nothing returns nothing
            local integer i = 0
            local framehandle frame = null 
            local real width = 0.035
            local real height = 0.035
            local real x = 0.005
            local real y = 0.16
            call DestroyTimer(GetExpiredTimer())
            if Settings_OtherNewFrameMode then 
                call BlzEnableUIAutoPosition(false)
                set i = 0
                loop
                    exitwhen i > 6
                    set frame = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON,i)
                    call BlzFrameClearAllPoints(frame)
                    call BlzFrameSetAbsPoint(frame,FRAMEPOINT_TOPLEFT,x+width*I2R(i),y+height)
                    call BlzFrameSetAbsPoint(frame,FRAMEPOINT_BOTTOMRIGHT,x+width+width*I2R(i),y)

                    set frame = BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON_INDICATOR,i)
                    call BlzFrameClearAllPoints(frame)
                    call BlzFrameSetAbsPoint(frame,FRAMEPOINT_TOPLEFT,x+width*I2R(i),y+height)
                    call BlzFrameSetAbsPoint(frame,FRAMEPOINT_BOTTOMRIGHT,x+width+width*I2R(i),y)

                    set frame = BlzGetOriginFrame(ORIGIN_FRAME_HERO_HP_BAR,i)
                    call BlzFrameClearAllPoints(frame)
                    call BlzFrameSetAbsPoint(frame,FRAMEPOINT_TOPLEFT,x+width*I2R(i)+0.001,y-0.0005)
                    call BlzFrameSetAbsPoint(frame,FRAMEPOINT_BOTTOMRIGHT,x+width+width*I2R(i)-0.001,y-0.0045)

                    set frame = BlzGetOriginFrame(ORIGIN_FRAME_HERO_MANA_BAR,i)
                    call BlzFrameClearAllPoints(frame)
                    call BlzFrameSetAbsPoint(frame,FRAMEPOINT_TOPLEFT,x+width*I2R(i)+0.001,y-0.0050)
                    call BlzFrameSetAbsPoint(frame,FRAMEPOINT_BOTTOMRIGHT,x+width+width*I2R(i)-0.001,y-0.0090)
                    set i = i+1
                endloop
                
                set frame = BlzGetOriginFrame(ORIGIN_FRAME_SIMPLE_UI_PARENT,0)
                call BlzFrameClearAllPoints(BlzFrameGetChild(BlzFrameGetChild(frame,1),3))
                call BlzFrameSetAbsPoint(BlzFrameGetChild(BlzFrameGetChild(frame,1),3),FRAMEPOINT_TOPLEFT,0.49,0.140)
                call BlzFrameSetAbsPoint(BlzFrameGetChild(BlzFrameGetChild(frame,1),3),FRAMEPOINT_BOTTOMRIGHT,0.515,0.115)
            endif 

            set frame = null 
        endfunction
        function reCreateFrames takes nothing returns nothing
            
            call resetAllFrames()
            
            call createStateIcons.execute()
            call createTalentFrame.execute()

            call TimerStart(CreateTimer(),0.1,false,function SetOriginFramePoints)
        endfunction

        globals 
            private trigger PLAYER_PRESS_ALT = CreateTrigger()
            boolean SHOW_PARTY_DATAS = false 
        endglobals

        function SHOW_PARTY_DATAS_Check takes nothing returns nothing
            local integer i = 0
            if SHOW_PARTY_DATAS then 
                call BlzFrameSetText(StaticTeamState,"|cffffcc00查看属性:开(Shift+Alt)|r")
                call BlzFrameSetVisible(TooltipStaticTeamState,true)
                loop
                    exitwhen i > 4
                    call BlzFrameSetVisible(HeroStateIcon[0],true)
                    set i = i+1
                endloop
            else 
                call BlzFrameSetText(StaticTeamState,"|cffffcc00查看属性:关(Shift+Alt)|r")
                call BlzFrameSetVisible(TooltipStaticTeamState,false)
                loop
                    exitwhen i > 4
                    call BlzFrameSetVisible(HeroStateIcon[i],false)
                    set i = i+1
                endloop
            endif 
        endfunction

        function PLAYER_PRESS_ALT_Action takes nothing returns nothing
            if SHOW_PARTY_DATAS then 
                set SHOW_PARTY_DATAS = false 
            else 
                set SHOW_PARTY_DATAS = true 
            endif 
            call SHOW_PARTY_DATAS_Check.execute()
        endfunction

        private function init takes nothing returns nothing 
            local integer i = 0
            set STRING_ST_NAME[ 0] = TYPE_CORE
            set STRING_ST_NAME[ 1] = NAME_LIFE
            set STRING_ST_NAME[ 2] = NAME_MANA
            set STRING_ST_NAME[ 3] = NAME_LR
            set STRING_ST_NAME[ 4] = NAME_MR
            set STRING_ST_NAME[ 5] = NAME_STR
            set STRING_ST_NAME[ 6] = NAME_AGI
            set STRING_ST_NAME[ 7] = NAME_INT
            set STRING_ST_NAME[ 8] = NAME_MS
            set STRING_ST_NAME[ 9] = TYPE_ATK
            set STRING_ST_NAME[10] = NAME_ATK
            set STRING_ST_NAME[11] = NAME_AS
            set STRING_ST_NAME[12] = NAME_ACC
            set STRING_ST_NAME[13] = NAME_APEN
            set STRING_ST_NAME[14] = TYPE_SPELL
            set STRING_ST_NAME[15] = NAME_AP
            set STRING_ST_NAME[16] = NAME_CR
            set STRING_ST_NAME[17] = TYPE_DEFND
            set STRING_ST_NAME[18] = NAME_ARMOR
            set STRING_ST_NAME[19] = NAME_BLOCK
            set STRING_ST_NAME[20] = NAME_EVADE
            set STRING_ST_NAME[21] = NAME_RES
            set STRING_ST_NAME[22] = TYPE_SUB
            set STRING_ST_NAME[23] = NAME_CC
            set STRING_ST_NAME[24] = NAME_CP
            set STRING_ST_NAME[25] = NAME_HASTE
            set STRING_ST_NAME[26] = NAME_VER
            set STRING_ST_NAME[27] = NAME_LEECH
            set STRING_ST_NAME[28] = NAME_DMG
            set STRING_ST_NAME[29] = NAME_HEAL
            set STRING_ST_NAME[30] = NAME_SHIELD

            
            set STRING_ST_DESC[ 1] = DESC_LIFE
            set STRING_ST_DESC[ 2] = DESC_MANA
            set STRING_ST_DESC[ 3] = DESC_LR
            set STRING_ST_DESC[ 4] = DESC_MR
            set STRING_ST_DESC[ 5] = DESC_STR
            set STRING_ST_DESC[ 6] = DESC_AGI
            set STRING_ST_DESC[ 7] = DESC_INT
            set STRING_ST_DESC[ 8] = DESC_MS
            set STRING_ST_DESC[10] = DESC_ATK
            set STRING_ST_DESC[11] = DESC_AS
            set STRING_ST_DESC[12] = DESC_ACC
            set STRING_ST_DESC[13] = DESC_APEN
            set STRING_ST_DESC[15] = DESC_AP
            set STRING_ST_DESC[16] = DESC_CR
            set STRING_ST_DESC[18] = DESC_ARMOR
            set STRING_ST_DESC[19] = DESC_BLOCK
            set STRING_ST_DESC[20] = DESC_EVADE
            set STRING_ST_DESC[21] = DESC_RES
            set STRING_ST_DESC[23] = DESC_CC
            set STRING_ST_DESC[24] = DESC_CP
            set STRING_ST_DESC[25] = DESC_HASTE
            set STRING_ST_DESC[26] = DESC_VER
            set STRING_ST_DESC[27] = DESC_LEECH
            set STRING_ST_DESC[28] = DESC_DMG
            set STRING_ST_DESC[29] = DESC_HEAL
            set STRING_ST_DESC[30] = DESC_SHIELD

            call reCreateFrames()
            call BlzTriggerRegisterPlayerKeyEvent(PLAYER_PRESS_ALT,Player(0),OSKEY_LALT,5,true)
            call TriggerAddAction(PLAYER_PRESS_ALT,function PLAYER_PRESS_ALT_Action)

            call SHOW_PARTY_DATAS_Check.execute()
        endfunction 

        
    endlibrary

    library FormLib initializer init requires frame,PatrolSystem,lootPool,BossLib,Gate,ResourcePointSystem
        
        struct form
            integer skinId              = 0
            string attackMissilePath    = ""
            real attackRange            = 0.0
            integer weaponType          = 0
            real attackCooldown         = 0.0
            real attackMissileSpeed     = 0.0
            real attackMissileArc       = 0.0
            real defaultSpellTime       = 0.0

            static method create takes integer SKIN_ID,integer WEAPON_TYPE,string MISSILE_ART,real ATTACK_RANGE,real ATTACK_COOLDOWN,real MISSILE_SPEED,real MISSILE_ARC,real SPELL_TIME returns form 
                local thistype this = thistype.allocate()
                set this.skinId = SKIN_ID
                set this.weaponType = WEAPON_TYPE
                set this.attackMissilePath = MISSILE_ART
                set this.attackRange = ATTACK_RANGE
                set this.attackCooldown =  ATTACK_COOLDOWN
                set this.attackMissileSpeed = MISSILE_SPEED
                set this.attackMissileArc = MISSILE_ARC
                set this.defaultSpellTime = SPELL_TIME
                return this 
            endmethod

            method transform takes unit whichHero returns boolean
                local integer heroId = GetHeroIndex(whichHero)-1 
                local integer i = 0
                local integer k = 0
                if heroId < 0 then 
                    return false 
                endif 
                if heroNowForm[heroId] == this then 
                    return false 
                endif 
                call RefreshHeroTalent_Reset.evaluate(whichHero)
                set heroNowForm[heroId] = this 
                call BlzSetUnitSkin(whichHero,this.skinId)
                call BlzSetUnitAttackCooldown(whichHero,this.attackCooldown,0)
                call BlzSetUnitWeaponIntegerField(whichHero,UNIT_WEAPON_IF_ATTACK_WEAPON_SOUND,0,this.weaponType)
                call SetUnitAttackRange(whichHero,this.attackRange)

                if alive(whichHero) == false then 
                    call SetUnitAnimation(whichHero,"death")
                endif 
                call UnitRemoveAbility(whichHero,'AGLO')
                call UnitAddAbility(whichHero,'AGLO')
                call UnitMakeAbilityPermanent(whichHero,true,'AGLO')
                call RefreshHeroTalent_Learn.evaluate(whichHero)
                call State.checkAll.evaluate(whichHero)
                return true 
            endmethod

            static method refreshFormDatas takes unit whichHero returns boolean
                local integer heroId = GetHeroIndex(whichHero)-1 
                local integer i = 0
                local integer k = 0
                if heroId < 0 then 
                    return false 
                endif 
                if heroDefaultForm[heroId] != heroNowForm[heroId] then 
                    return false 
                endif 

                call BlzSetUnitSkin(whichHero,heroDefaultForm[heroId].skinId)
                call BlzSetUnitAttackCooldown(whichHero,heroDefaultForm[heroId].attackCooldown,0)
                call BlzSetUnitWeaponIntegerField(whichHero,UNIT_WEAPON_IF_ATTACK_WEAPON_SOUND,0,heroDefaultForm[heroId].weaponType)
                call SetUnitAttackRange(whichHero,heroDefaultForm[heroId].attackRange)

                if alive(whichHero) == false then 
                    call SetUnitAnimation(whichHero,"death")
                endif 
                call UnitRemoveAbility(whichHero,'AGLO')
                call UnitAddAbility(whichHero,'AGLO')
                call UnitMakeAbilityPermanent(whichHero,true,'AGLO')

                return true 
            endmethod
        endstruct

        globals 
            form FORM_VANGUARD_NORMAL      
            form FORM_PALADIN_NORMAL        
            form FORM_GLADIATOR_NORMAL      
            form FORM_MECHANIST_NORMAL      
            form FORM_RANGER_NORMAL        
            form FORM_ASSASSIN_NORMAL       
            form FORM_MAGE_NORMAL           
            form FORM_PRIEST_NORMAL         
            form FORM_DRUID_NORMAL          
            form FORM_DEATH_KNIGHT_NORMAL   
            form FORM_ARCANE_WARRIOR_NORMAL 
            form FORM_SHAMAN_NORMAL        
            form FORM_WARLOCK_NORMAL       
            form FORM_DEMON_HUNTER_NORMAL   
            form FORM_MONK_NORMAL          
            form FORM_SORCERESS_NORMAL  

            form FORM_DRUID_BEAR
            form FORM_DRUID_CAT
            form FORM_DRUID_MOONKIN

            form FORM_DEMON_HUNTER_DEMON 

            form array heroDefaultForm
            form array heroNowForm
        endglobals

        private function init takes nothing returns nothing
            local integer i = 0
            set FORM_VANGUARD_NORMAL       = form.create('HZ00',INT_WEAPON_TYPE_METAL_MEDIUM_SLICE,"",100,2,0,0,0)
            set FORM_PALADIN_NORMAL        = form.create('HZ01',INT_WEAPON_TYPE_METAL_HEAVY_BASH,"",100,2.1,0,0,0.4)
            set FORM_GLADIATOR_NORMAL      = form.create('HZ02',INT_WEAPON_TYPE_METAL_HEAVY_SLICE,"",100,2,0,0,0.4)
            set FORM_MECHANIST_NORMAL      = form.create('HZ03',INT_WEAPON_TYPE_WHOKNOWS,"Abilities\\Weapons\\Rifle\\RifleImpact.mdl",500,2,2500,0,0.17)
            set FORM_RANGER_NORMAL         = form.create('HZ04',INT_WEAPON_TYPE_WHOKNOWS,"Abilities\\Weapons\\MoonPriestessMissile\\MoonPriestessMissile.mdl",500,2,1000,0.1,0.4)
            set FORM_ASSASSIN_NORMAL       = form.create('HZ05',INT_WEAPON_TYPE_METAL_MEDIUM_SLICE,"",100,1.8,0,0,0.4)
            set FORM_MAGE_NORMAL           = form.create('HZ06',INT_WEAPON_TYPE_WHOKNOWS,"Abilities\\Weapons\\LichMissile\\LichMissile.mdl",450,2,1000,0,0.4)
            set FORM_PRIEST_NORMAL         = form.create('HZ07',INT_WEAPON_TYPE_WHOKNOWS,"Abilities\\Weapons\\FaerieDragonMissile\\FaerieDragonMissile.mdl",450,2.4,1000,0.05,0.4)
            set FORM_DRUID_NORMAL          = form.create('HZ08',INT_WEAPON_TYPE_WHOKNOWS,"war3campImported\\DruidMissile_small.mdl",450,2.5,1000,0,0.4)
            set FORM_DEATH_KNIGHT_NORMAL   = form.create('HZ09',INT_WEAPON_TYPE_METAL_HEAVY_SLICE,"",100,2,0,0,0.4)
            set FORM_ARCANE_WARRIOR_NORMAL = form.create('HZ0A',INT_WEAPON_TYPE_WHOKNOWS,"Abilities\\Weapons\\BloodElfSpellThiefMISSILE\\BloodElfSpellThiefMISSILE.mdl",450,2,1000,0,0.4)
            set FORM_SHAMAN_NORMAL         = form.create('HZ0B',INT_WEAPON_TYPE_WHOKNOWS,"war3campImported\\star_spirit_smaller.mdx",450,2.2,1000,0.05,0.4)
            set FORM_WARLOCK_NORMAL        = form.create('HZ0C',INT_WEAPON_TYPE_WHOKNOWS,"Abilities\\Weapons\\NecromancerMissile\\NecromancerMissile.mdl",450,2,1000,0,0.4)
            set FORM_DEMON_HUNTER_NORMAL   = form.create('HZ0D',INT_WEAPON_TYPE_METAL_MEDIUM_SLICE,"",100,1.9,0,0,0.4)
            set FORM_MONK_NORMAL           = form.create('HZ0E',INT_WEAPON_TYPE_WOOD_LIGHT_BASH,"",100,1.8,0,0,0.4)
            set FORM_SORCERESS_NORMAL      = form.create('HZ0F',INT_WEAPON_TYPE_WHOKNOWS,"Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl",450,2,1000,0,0.4)

            set FORM_DRUID_BEAR            = form.create('HS00',INT_WEAPON_TYPE_WOOD_HEAVY_BASH,"",100,1.8,0,0,0.4)
            set FORM_DRUID_CAT             = form.create('HS01',INT_WEAPON_TYPE_WOOD_MEDIUM_BASH,"",100,1.6,0,0,0.4)
            set FORM_DRUID_MOONKIN         = form.create('HS02',INT_WEAPON_TYPE_WHOKNOWS,"war3campImported\\StarArrowPlus.mdx",450,2,1000,0,0.4)

            set FORM_DEMON_HUNTER_DEMON    = form.create('HS03',INT_WEAPON_TYPE_WOOD_MEDIUM_BASH,"",100,1.9,0,0,0.4)

            set heroDefaultForm[ 0]  = FORM_VANGUARD_NORMAL
            set heroDefaultForm[ 1]  = FORM_PALADIN_NORMAL
            set heroDefaultForm[ 2]  = FORM_GLADIATOR_NORMAL
            set heroDefaultForm[ 3]  = FORM_MECHANIST_NORMAL
            set heroDefaultForm[ 4]  = FORM_RANGER_NORMAL
            set heroDefaultForm[ 5]  = FORM_ASSASSIN_NORMAL
            set heroDefaultForm[ 6]  = FORM_MAGE_NORMAL
            set heroDefaultForm[ 7]  = FORM_PRIEST_NORMAL
            set heroDefaultForm[ 8]  = FORM_DRUID_NORMAL
            set heroDefaultForm[ 9]  = FORM_DEATH_KNIGHT_NORMAL
            set heroDefaultForm[10]  = FORM_ARCANE_WARRIOR_NORMAL
            set heroDefaultForm[11]  = FORM_SHAMAN_NORMAL
            set heroDefaultForm[12]  = FORM_WARLOCK_NORMAL
            set heroDefaultForm[13]  = FORM_DEMON_HUNTER_NORMAL
            set heroDefaultForm[14]  = FORM_MONK_NORMAL
            set heroDefaultForm[15]  = FORM_SORCERESS_NORMAL
            loop 
                exitwhen i > MAX_HERO_TYPE-1
                set heroNowForm[i] = heroDefaultForm[i]
                set i = i+1
            endloop
        endfunction
    endlibrary

    library displayDps initializer init requires shared
        globals 
            private trigger rm = CreateTrigger()
            private trigger trigLoad = CreateTrigger()
        endglobals

        function damageMeterUpdate takes nothing returns nothing
            local integer i = 0
            loop 
                exitwhen i > 4
                if party[i] != null then 
                    call MultiboardSetItemStyle(damageMeter_Items[i*4+0],true,true)
                    call MultiboardSetItemIcon(damageMeter_Items[i*4+0],GetUnitIcon(party[i]))
                    if inCombat(party[i]) then 
                        set combatTime[i] = combatTime[i]+0.1
                        if GetUnitLevel(party[i]) == 20 and eliteLevel[GetHeroIndex(party[i])-1] > 0 then 
                            call MultiboardSetItemValue(damageMeter_Items[i*4+0],"|cffff0000EL."+I2S(eliteLevel[GetHeroIndex(party[i])-1])+"|r")
                        else 
                            call MultiboardSetItemValue(damageMeter_Items[i*4+0],"|cffff0000Lv."+I2S(GetUnitLevel(party[i]))+"|r")
                        endif 
                        call MultiboardSetItemValue(damageMeter_Items[i*4+1],"|cffff0000"+I2S(R2I(combatTime[i]+0.5)/3600)+":"+I2S(R2I(ModuloReal(combatTime[i]+0.5,3600))/60)+":"+I2S(R2I(ModuloReal(combatTime[i]+0.5,60)))+"|r")
                        call MultiboardSetItemValue(damageMeter_Items[i*4+2],"|cffff0000"+R2SW(damageTotal[i]/RMaxBJ(1,combatTime[i]),6,1)+"|r")
                        call MultiboardSetItemValue(damageMeter_Items[i*4+3],"|cffff0000"+R2SW(healTotal[i]/RMaxBJ(1,combatTime[i]),6,1)+"|r")
                    else 
                        if GetUnitLevel(party[i]) == 20 and eliteLevel[GetHeroIndex(party[i])-1] > 0 then 
                            call MultiboardSetItemValue(damageMeter_Items[i*4+0],"|cff88aaffEL."+I2S(eliteLevel[GetHeroIndex(party[i])-1])+"|r")
                        else 
                            call MultiboardSetItemValue(damageMeter_Items[i*4+0],"Lv."+I2S(GetUnitLevel(party[i])))
                        endif 
                        call MultiboardSetItemValue(damageMeter_Items[i*4+1],I2S(R2I(combatTime[i]+0.5)/3600)+":"+I2S(R2I(ModuloReal(combatTime[i]+0.5,3600))/60)+":"+I2S(R2I(ModuloReal(combatTime[i]+0.5,60))))
                        call MultiboardSetItemValue(damageMeter_Items[i*4+2],R2SW(damageTotal[i]/RMaxBJ(1,combatTime[i]),6,1))
                        call MultiboardSetItemValue(damageMeter_Items[i*4+3],R2SW(healTotal[i]/RMaxBJ(1,combatTime[i]),6,1))
                    endif 
                else 
                    call MultiboardSetItemStyle(damageMeter_Items[i*4+0],true,false)
                    call MultiboardSetItemValue(damageMeter_Items[i*4+0],"")
                    call MultiboardSetItemValue(damageMeter_Items[i*4+1],"")
                    call MultiboardSetItemValue(damageMeter_Items[i*4+2],"")
                    call MultiboardSetItemValue(damageMeter_Items[i*4+3],"")
                endif 
                set i = i+1
            endloop
        endfunction
        function DAMAGE_METER_INIT takes nothing returns nothing
            local integer i = 0
            call DestroyTimer(GetExpiredTimer())
            if damageMeter != null then 
                call DestroyMultiboard(damageMeter)
            endif 
            set damageMeter = CreateMultiboard()
            call MultiboardSetTitleText(damageMeter,"|cffffcc00伤害/治疗统计|r")
            call MultiboardSetColumnCount(damageMeter,4)
            call MultiboardSetRowCount(damageMeter,6)
            call MultiboardSetItemsStyle(damageMeter,true,false)
            set damageMeter_Hero_Title = MultiboardGetItem(damageMeter,0,0)
            set damageMeter_Time_Title = MultiboardGetItem(damageMeter,0,1)
            set damageMeter_Dps_Title  = MultiboardGetItem(damageMeter,0,2)
            set damageMeter_Hps_Title  = MultiboardGetItem(damageMeter,0,3)
            call MultiboardSetItemValue(damageMeter_Hero_Title,"|cffffcc00英雄|r")
            call MultiboardSetItemValue(damageMeter_Time_Title,"|cffffcc00活跃时间|r")
            call MultiboardSetItemValue(damageMeter_Dps_Title,"|cffffcc00每秒伤害|r")
            call MultiboardSetItemValue(damageMeter_Hps_Title,"|cffffcc00每秒治疗|r")
            call MultiboardSetItemWidthBJ(damageMeter,1,0,5)
            call MultiboardSetItemWidthBJ(damageMeter,2,0,5)
            call MultiboardSetItemWidthBJ(damageMeter,3,0,4)
            call MultiboardSetItemWidthBJ(damageMeter,4,0,4)
            loop 
                exitwhen i > 4
                set damageTotal[i] = 0
                set healTotal[i] = 0
                set healOverdozeTotal[i] = 0
                set combatTime[i] = 0
                set damageMeter_Items[i*4+0] = MultiboardGetItem(damageMeter,i+1,0)
                set damageMeter_Items[i*4+1] = MultiboardGetItem(damageMeter,i+1,1)
                set damageMeter_Items[i*4+2] = MultiboardGetItem(damageMeter,i+1,2)
                set damageMeter_Items[i*4+3] = MultiboardGetItem(damageMeter,i+1,3)
                set i = i+1
            endloop
            call MultiboardDisplay(damageMeter,false)
        endfunction
        function DAMAGE_METER_REINIT takes nothing returns nothing
            local integer i = 0
            call DestroyTimer(GetExpiredTimer())
            if damageMeter != null then 
                call DestroyMultiboard(damageMeter)
            endif 
            set damageMeter = CreateMultiboard()
            call MultiboardSetTitleText(damageMeter,"|cffffcc00伤害/治疗统计|r")
            call MultiboardSetColumnCount(damageMeter,4)
            call MultiboardSetRowCount(damageMeter,6)
            call MultiboardSetItemsStyle(damageMeter,true,false)
            set damageMeter_Hero_Title = MultiboardGetItem(damageMeter,0,0)
            set damageMeter_Time_Title = MultiboardGetItem(damageMeter,0,1)
            set damageMeter_Dps_Title  = MultiboardGetItem(damageMeter,0,2)
            set damageMeter_Hps_Title  = MultiboardGetItem(damageMeter,0,3)
            call MultiboardSetItemValue(damageMeter_Hero_Title,"|cffffcc00英雄|r")
            call MultiboardSetItemValue(damageMeter_Time_Title,"|cffffcc00活跃时间|r")
            call MultiboardSetItemValue(damageMeter_Dps_Title,"|cffffcc00每秒伤害|r")
            call MultiboardSetItemValue(damageMeter_Hps_Title,"|cffffcc00每秒治疗|r")
            call MultiboardSetItemWidthBJ(damageMeter,1,0,5)
            call MultiboardSetItemWidthBJ(damageMeter,2,0,5)
            call MultiboardSetItemWidthBJ(damageMeter,3,0,4)
            call MultiboardSetItemWidthBJ(damageMeter,4,0,4)
            loop 
                exitwhen i > 4
                set damageMeter_Items[i*4+0] = MultiboardGetItem(damageMeter,i+1,0)
                set damageMeter_Items[i*4+1] = MultiboardGetItem(damageMeter,i+1,1)
                set damageMeter_Items[i*4+2] = MultiboardGetItem(damageMeter,i+1,2)
                set damageMeter_Items[i*4+3] = MultiboardGetItem(damageMeter,i+1,3)
                set i = i+1
            endloop
            call MultiboardDisplay(damageMeter,false)
        endfunction
        private function rm_action takes nothing returns nothing
            local integer i = 0
            loop 
                exitwhen i > 4
                set damageTotal[i] = 0
                set healTotal[i] = 0
                set healOverdozeTotal[i] = 0
                set combatTime[i] = 0
                set i = i+1
            endloop
            call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,"|cffffcc00伤害统计已重置。|r")
        endfunction
        private function trigLoad_action takes nothing returns nothing
            call TimerStart(CreateTimer(),0,false,function DAMAGE_METER_REINIT)
            //call BJDebugMsg("LOADED!")
        endfunction
        private function init takes nothing returns nothing
            call TimerStart(CreateTimer(),0,false,function DAMAGE_METER_REINIT)
            call TriggerRegisterPlayerChatEvent(rm,PLAYER,"-rm",true)
            call TriggerRegisterPlayerChatEvent(rm,PLAYER,"重置",true)
            call TriggerAddAction(rm,function rm_action)
            call TriggerRegisterGameEvent(trigLoad,EVENT_GAME_LOADED)
            call TriggerAddAction(trigLoad,function trigLoad_action)
        endfunction
    endlibrary

    library minions initializer init requires shared 
        globals 
            hashtable minionshashtable = InitHashtable()
            trigger triggerIssueOrder = CreateTrigger()
        endglobals
        struct master 
            static master top = 0
            static master array list [8190]
            static integer index = -1
            group minions = null 
            unit masterUnit = null 
            unit lastTarget = null
            integer id = -1
            master prev 
            master next 

            static method getMasterByUnit takes unit whichUnit returns master 
                return LoadInteger(minionshashtable,'MAST',GetHandleId(whichUnit))
            endmethod

            static method create takes unit masterUnit returns master 
                local master this = thistype.getMasterByUnit(masterUnit)
                if this > 0 then 
                    return this 
                else 
                    set this = thistype.allocate()
                    set this.masterUnit = masterUnit
                    set this.minions = CreateGroup()
                    set this.prev = thistype.top
                    if this.prev > 0 then 
                        set this.prev.next = this 
                    endif 
                    set this.next = 0
                    set thistype.top = this 
                    set this.lastTarget = null 
                    call SaveInteger(minionshashtable,'MAST',GetHandleId(this.masterUnit),this)
                endif 
                return this 
            endmethod

            method onDestroy takes nothing returns nothing
                local unit U = null 
                call SaveInteger(minionshashtable,'MAST',GetHandleId(this.masterUnit),0)
                loop 
                    set U = FirstOfGroup(this.minions)
                    exitwhen U == null 
                    call GroupRemoveUnit(this.minions,U)
                    call minion.getMinionByUnit(U).destroy()
                    set U = null 
                endloop
                call DestroyGroup(this.minions)
                set this.masterUnit = null 
                set this.lastTarget = null 
                set this.id = -1
                if this == thistype.top then 
                    set thistype.top = this.prev 
                endif 
                if this.prev > 0 then 
                    set this.prev.next = this.next 
                endif 
                if this.next > 0 then 
                    set this.next.prev = this.prev 
                endif 
            endmethod

            static method updateAll takes nothing returns nothing
                local thistype this = thistype.top 
                loop 
                    exitwhen this == 0

                    set this = this.prev
                endloop
            endmethod
        endstruct

        struct minion 
            static minion top = 0
            boolean DESTROY = false 
            master mast = 0
            integer lastOrderTime = 0
            unit currentTarget = null 
            unit aimTarget = null 
            unit summon = null 
            boolean remove = false 
            string deathSFX = ""
            effect bindSFX = null 
            integer intData = 0
            real realData = 0
            boolean boolData = false
            minion prev 
            minion next

            static method getMinionByUnit takes unit whichUnit returns minion
                return LoadInteger(minionshashtable,'MINI',GetHandleId(whichUnit))
            endmethod

            static method getMinionByHandle takes integer whichHandle returns minion
                return LoadInteger(minionshashtable,'MINI',whichHandle)
            endmethod

            static method create takes unit masterUnit,integer dummyId,real x,real y returns minion 
                local thistype this = thistype.allocate()
                set this.prev = thistype.top
                if this.prev > 0 then 
                    set this.prev.next = this 
                endif 
                set this.next = 0
                set thistype.top = this 
                set this.summon = CreateUnit(GetOwningPlayer(masterUnit),dummyId,x,y,AngleByUnXY(masterUnit,x,y))
                set this.mast = master.create(masterUnit)
                call GroupAddUnit(this.mast.minions,this.summon)    
                call SaveInteger(minionshashtable,'MINI',GetHandleId(this.summon),this)
                call unitCheckState.evaluate(masterUnit)
                if GetUnitAbilityLevel(this.summon,'Aloc') == 0 then 
                    call UnitAddAbility(this.summon,'Aloc')
                    call ShowUnit(this.summon,false)
                    call ShowUnit(this.summon,true)
                    call UnitRemoveAbility(this.summon,'Aloc')
                endif 
                if inCombat(masterUnit) then 
                    call setCombat(this.summon)
                endif 
                return this 
            endmethod

            static method createWithFace takes unit masterUnit,integer dummyId,real x,real y,real facing returns minion 
                local thistype this = thistype.allocate()
                set this.prev = thistype.top
                if this.prev > 0 then 
                    set this.prev.next = this 
                endif 
                set this.next = 0
                set thistype.top = this 
                set this.summon = CreateUnit(GetOwningPlayer(masterUnit),dummyId,x,y,facing)
                set this.mast = master.create(masterUnit)
                call GroupAddUnit(this.mast.minions,this.summon)    
                call SaveInteger(minionshashtable,'MINI',GetHandleId(this.summon),this)
                call unitCheckState.evaluate(masterUnit)
                if GetUnitAbilityLevel(this.summon,'Aloc') == 0 then 
                    call UnitAddAbility(this.summon,'Aloc')
                    call ShowUnit(this.summon,false)
                    call ShowUnit(this.summon,true)
                    call UnitRemoveAbility(this.summon,'Aloc')
                endif 
                if inCombat(masterUnit) then 
                    call setCombat(this.summon)
                endif 
                return this 
            endmethod

            method update takes nothing returns nothing
                local real a = GetRandomReal(-1.5708,1.5708)
                local real d = SquareRoot(GetRandomReal(125*125,150*150))
                local unit target = this.mast.masterUnit
                if globalNowtime-this.lastOrderTime > 150 then 
                    call DisableTrigger(triggerIssueOrder)
                    if this.lastOrderTime != -65535 then 
                        set this.lastOrderTime = globalNowtime
                    endif 
                    if this.aimTarget != null and alive(this.aimTarget) and this.lastOrderTime != -65535 then 
                        set target = this.aimTarget
                    elseif inCombat(this.mast.masterUnit) and this.mast.lastTarget != null and alive(this.mast.lastTarget) then 
                        set target = this.mast.lastTarget
                    elseif inCombat(this.summon) and this.currentTarget != null and alive(this.currentTarget) then 
                        set target = this.currentTarget
                    endif 
                    if IsUnitEnemy(target,GetOwningPlayer(this.summon)) == false or IsUnitType(target,UNIT_TYPE_ANCIENT) then 
                        set target = this.mast.masterUnit
                    endif
                    if this.lastOrderTime != -65535 then 
                        if IsUnitAlly(target,GetOwningPlayer(this.summon)) then 
                            if DisByUnits(this.summon,target) > 150 or DisByUnits(this.summon,target) < 90 then 
                                call IssuePointOrderById(this.summon,ORDER_move,GetUnitX(target)+d*Cos(a+GetUnitFacing(target)/57.2958),GetUnitY(target)+d*Sin(a+GetUnitFacing(target)/57.2958))
                            endif 
                        else 
                            if DisByUnits(this.summon,target) < 75 then 
                                call IssuePointOrderById(this.summon,ORDER_move,GetUnitX(target)+d*Cos(AngleByUnits(target,this.summon)/57.2958),GetUnitY(target)+d*Sin(AngleByUnits(target,this.summon)/57.2958))
                            else  
                                call IssueTargetOrderById(this.summon,ORDER_attack,target)
                            endif 
                        endif 
                    endif 
                    if inCombat(this.summon) == false and DisByUnits(this.summon,this.mast.masterUnit) > 1350 and this.lastOrderTime != -65535 then 
                        call SetUnitX(this.summon,GetUnitX(this.mast.masterUnit)+d*Cos(a+GetUnitFacing(this.mast.masterUnit)/57.2958))
                        call SetUnitY(this.summon,GetUnitY(this.mast.masterUnit)+d*Sin(a+GetUnitFacing(this.mast.masterUnit)/57.2958))
                    endif 
                    if inCombat(this.summon) or this.lastOrderTime == -65535 then 
                        call IssueImmediateOrderById(this.summon,ORDER_fanofknives)
                    endif 
                    call EnableTrigger(triggerIssueOrder)
                endif 
                if not alive(this.summon) then 
                    call this.destroy()
                elseif this.DESTROY then 
                    call this.destroy()
                elseif GetOwningPlayer(this.summon) == PLAYER then 
                    call SetUnitState(this.summon,UNIT_STATE_LIFE,GetUnitState(this.summon,UNIT_STATE_LIFE)+0.001*GetUnitState(this.summon,UNIT_STATE_MAX_LIFE))
                endif 
                set target = null 
            endmethod

            method onDestroy takes nothing returns nothing
                call SaveInteger(minionshashtable,'MINI',GetHandleId(this.summon),0)
                if deathSFX != "" then 
                    call DestroyEffectEX(AddSpecialEffectEX(this.deathSFX,GetUnitX(this.summon),GetUnitY(this.summon)))
                endif 
                call DestroyEffectEX(this.bindSFX)
                call GroupRemoveUnit(this.mast.minions,this.summon)
                if alive(this.summon) then 
                    call KillUnit(this.summon)
                endif 
                if this.remove then 
                    call RemoveUnit(this.summon)
                endif 
                set this.summon = null 
                set this.aimTarget = null 
                set this.mast = 0 
                set this.currentTarget = null 
                if this == thistype.top then 
                    set thistype.top = this.prev 
                endif 
                if this.prev > 0 then 
                    set this.prev.next = this.next 
                endif 
                if this.next > 0 then 
                    set this.next.prev = this.prev 
                endif 
            endmethod

            static method updateAll takes nothing returns nothing
                local thistype this = thistype.top 
                loop 
                    exitwhen this == 0
                    call this.update()
                    set this = this.prev
                endloop
            endmethod
        endstruct


        function triggerIssueOrder_Action takes nothing returns nothing
            local master ma = master.getMasterByUnit(GetTriggerUnit())
            local minion mi = minion.getMinionByUnit(GetTriggerUnit())
            local group pick = null 
            if GetTriggerPlayer() == PLAYER then 
                if GetOwningPlayer(GetTriggerUnit()) == PLAYER then 
                    if ma > 0 then 
                        set pick = CreateGroup()
                        call GroupAddGroup(ma.minions,pick)
                        loop 
                            exitwhen FirstOfGroup(pick) == null 
                            if minion.getMinionByUnit(FirstOfGroup(pick)).lastOrderTime != -65535 then 
                                set minion.getMinionByUnit(FirstOfGroup(pick)).lastOrderTime = 0
                                if GetIssuedOrderId() == ORDER_holdposition then 
                                    set minion.getMinionByUnit(FirstOfGroup(pick)).currentTarget = null 
                                    set minion.getMinionByUnit(FirstOfGroup(pick)).aimTarget = null 
                                    call clearCombat(FirstOfGroup(pick))
                                    set ma.lastTarget = null 
                                endif 
                            endif 
                            call GroupRemoveUnit(pick,FirstOfGroup(pick))
                        endloop
                        call DestroyGroup(pick)
                        set pick = null 
                    endif 
                    if mi > 0 and mi.lastOrderTime != -65535 then 
                        set mi.lastOrderTime = 0
                    endif 
                endif 
            endif 
        endfunction
        private function init takes nothing returns nothing
            call TriggerRegisterAnyUnitEventBJ(triggerIssueOrder,EVENT_PLAYER_UNIT_ISSUED_ORDER)
            call TriggerRegisterAnyUnitEventBJ(triggerIssueOrder,EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
            call TriggerRegisterAnyUnitEventBJ(triggerIssueOrder,EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
            call TriggerAddActionEx(triggerIssueOrder,function triggerIssueOrder_Action)
        endfunction
    endlibrary

    globals
        constant integer ORDER_wandillusion=852274
        constant integer ORDER_absorb=852529
        constant integer ORDER_acidbomb=852662
        constant integer ORDER_acolyteharvest=852185
        constant integer ORDER_AImove=851988
        constant integer ORDER_ambush=852131
        constant integer ORDER_ancestralspirit=852490
        constant integer ORDER_ancestralspirittarget=852491
        constant integer ORDER_animatedead=852217
        constant integer ORDER_antimagicshell=852186
        constant integer ORDER_attack=851983
        constant integer ORDER_attackground=851984
        constant integer ORDER_attackonce=851985
        constant integer ORDER_attributemodskill=852576
        constant integer ORDER_auraunholy=852215
        constant integer ORDER_auravampiric=852216
        constant integer ORDER_autodispel=852132
        constant integer ORDER_autodispeloff=852134
        constant integer ORDER_autodispelon=852133
        constant integer ORDER_autoentangle=852505
        constant integer ORDER_autoentangleinstant=852506
        constant integer ORDER_autoharvestgold=852021
        constant integer ORDER_autoharvestlumber=852022
        constant integer ORDER_avatar=852086
        constant integer ORDER_avengerform=852531
        constant integer ORDER_awaken=852466
        constant integer ORDER_banish=852486
        constant integer ORDER_barkskin=852135
        constant integer ORDER_barkskinoff=852137
        constant integer ORDER_barkskinon=852136
        constant integer ORDER_battleroar=852099
        constant integer ORDER_battlestations=852099
        constant integer ORDER_bearform=852138
        constant integer ORDER_berserk=852100
        constant integer ORDER_blackarrow=852577
        constant integer ORDER_blackarrowoff=852579
        constant integer ORDER_blackarrowon=852578
        constant integer ORDER_blight=852187
        constant integer ORDER_blink=852525
        constant integer ORDER_blizzard=852089
        constant integer ORDER_bloodlust=852101
        constant integer ORDER_bloodlustoff=852103
        constant integer ORDER_bloodluston=852102
        constant integer ORDER_board=852043
        constant integer ORDER_breathoffire=852580
        constant integer ORDER_breathoffrost=852560
        constant integer ORDER_build=851994
        constant integer ORDER_burrow=852533
        constant integer ORDER_cannibalize=852188
        constant integer ORDER_carrionscarabs=852551
        constant integer ORDER_carrionscarabsinstant=852554
        constant integer ORDER_carrionscarabsoff=852553
        constant integer ORDER_carrionscarabson=852552
        constant integer ORDER_carrionswarm=852218
        constant integer ORDER_chainlightning=852119
        constant integer ORDER_channel=852600
        constant integer ORDER_charm=852581
        constant integer ORDER_chemicalrage=852663
        constant integer ORDER_cloudoffog=852473
        constant integer ORDER_clusterrockets=852652
        constant integer ORDER_coldarrows=852244
        constant integer ORDER_coldarrowstarg=852243
        constant integer ORDER_controlmagic=852474
        constant integer ORDER_corporealform=852493
        constant integer ORDER_corrosivebreath=852140
        constant integer ORDER_coupleinstant=852508
        constant integer ORDER_coupletarget=852507
        constant integer ORDER_creepanimatedead=852246
        constant integer ORDER_creepdevour=852247
        constant integer ORDER_creepheal=852248
        constant integer ORDER_creephealoff=852250
        constant integer ORDER_creephealon=852249
        constant integer ORDER_creepthunderbolt=852252
        constant integer ORDER_creepthunderclap=852253
        constant integer ORDER_cripple=852189
        constant integer ORDER_curse=852190
        constant integer ORDER_curseoff=852192
        constant integer ORDER_curseon=852191
        constant integer ORDER_cyclone=852144
        constant integer ORDER_darkconversion=852228
        constant integer ORDER_darkportal=852229
        constant integer ORDER_darkritual=852219
        constant integer ORDER_darksummoning=852220
        constant integer ORDER_deathanddecay=852221
        constant integer ORDER_deathcoil=852222
        constant integer ORDER_deathpact=852223
        constant integer ORDER_decouple=852509
        constant integer ORDER_defend=852055
        constant integer ORDER_detectaoe=852015
        constant integer ORDER_detonate=852145
        constant integer ORDER_devour=852104
        constant integer ORDER_devourmagic=852536
        constant integer ORDER_disassociate=852240
        constant integer ORDER_disenchant=852495
        constant integer ORDER_dismount=852470
        constant integer ORDER_dispel=852057
        constant integer ORDER_divineshield=852090
        constant integer ORDER_doom=852583
        constant integer ORDER_drain=852487
        constant integer ORDER_dreadlordinferno=852224
        constant integer ORDER_dropitem=852001
        constant integer ORDER_drunkenhaze=852585
        constant integer ORDER_earthquake=852121
        constant integer ORDER_eattree=852146
        constant integer ORDER_elementalfury=852586
        constant integer ORDER_ensnare=852106
        constant integer ORDER_ensnareoff=852108
        constant integer ORDER_ensnareon=852107
        constant integer ORDER_entangle=852147
        constant integer ORDER_entangleinstant=852148
        constant integer ORDER_entanglingroots=852171
        constant integer ORDER_etherealform=852496
        constant integer ORDER_evileye=852105
        constant integer ORDER_faeriefire=852149
        constant integer ORDER_faeriefireoff=852151
        constant integer ORDER_faeriefireon=852150
        constant integer ORDER_fanofknives=852526
        constant integer ORDER_farsight=852122
        constant integer ORDER_fingerofdeath=852230
        constant integer ORDER_firebolt=852231
        constant integer ORDER_flamestrike=852488
        constant integer ORDER_flamingarrows=852174
        constant integer ORDER_flamingarrowstarg=852173
        constant integer ORDER_flamingattack=852540
        constant integer ORDER_flamingattacktarg=852539
        constant integer ORDER_flare=852060
        constant integer ORDER_forceboard=852044
        constant integer ORDER_forceofnature=852176
        constant integer ORDER_forkedlightning=852586
        constant integer ORDER_freezingbreath=852195
        constant integer ORDER_frenzy=852561
        constant integer ORDER_frenzyoff=852563
        constant integer ORDER_frenzyon=852562
        constant integer ORDER_frostarmor=852225
        constant integer ORDER_frostarmoroff=852459
        constant integer ORDER_frostarmoron=852458
        constant integer ORDER_frostnova=852226
        constant integer ORDER_getitem=851981
        constant integer ORDER_gold2lumber=852233
        constant integer ORDER_grabtree=852511
        constant integer ORDER_harvest=852018
        constant integer ORDER_heal=852063
        constant integer ORDER_healingspray=852664
        constant integer ORDER_healingward=852109
        constant integer ORDER_healingwave=852501
        constant integer ORDER_healoff=852065
        constant integer ORDER_healon=852064
        constant integer ORDER_hex=852502
        constant integer ORDER_holdposition=851993
        constant integer ORDER_holybolt=852092
        constant integer ORDER_howlofterror=852588
        constant integer ORDER_humanbuild=851995
        constant integer ORDER_immolation=852177
        constant integer ORDER_impale=852555
        constant integer ORDER_incineratearrow=852670
        constant integer ORDER_incineratearrowoff=852672
        constant integer ORDER_incineratearrowon=852671
        constant integer ORDER_inferno=852232
        constant integer ORDER_innerfire=852066
        constant integer ORDER_innerfireoff=852068
        constant integer ORDER_innerfireon=852067
        constant integer ORDER_instant=852200
        constant integer ORDER_invisibility=852069
        constant integer ORDER_lavamonster=852667
        constant integer ORDER_lightningshield=852110
        constant integer ORDER_load=852046
        constant integer ORDER_loadarcher = 852142
        constant integer ORDER_loadcorpse=852050
        constant integer ORDER_loadcorpseinstant=852053
        constant integer ORDER_locustswarm=852556
        constant integer ORDER_lumber2gold=852234
        constant integer ORDER_magicdefense=852478
        constant integer ORDER_magicleash=852480
        constant integer ORDER_magicundefense=852479
        constant integer ORDER_manaburn=852179
        constant integer ORDER_manaflareoff=852513
        constant integer ORDER_manaflareon=852512
        constant integer ORDER_manashieldoff=852590
        constant integer ORDER_manashieldon=852589
        constant integer ORDER_massteleport=852093
        constant integer ORDER_mechanicalcritter=852564
        constant integer ORDER_metamorphosis=852180
        constant integer ORDER_militia=852072
        constant integer ORDER_militiaconvert=852071
        constant integer ORDER_militiaoff=852073
        constant integer ORDER_militiaunconvert=852651
        constant integer ORDER_mindrot=852565
        constant integer ORDER_mirrorimage=852123
        constant integer ORDER_monsoon=852591
        constant integer ORDER_mount=852469
        constant integer ORDER_mounthippogryph=852143
        constant integer ORDER_move=851986
        constant integer ORDER_nagabuild=852467
        constant integer ORDER_neutraldetectaoe=852023
        constant integer ORDER_neutralinteract=852566
        constant integer ORDER_neutralspell=852630
        constant integer ORDER_nightelfbuild=851997
        constant integer ORDER_orcbuild=851996
        constant integer ORDER_parasite=852601
        constant integer ORDER_parasiteoff=852603
        constant integer ORDER_parasiteon=852602
        constant integer ORDER_patrol=851990
        constant integer ORDER_phaseshift=852514
        constant integer ORDER_phaseshiftinstant=852517
        constant integer ORDER_phaseshiftoff=852516
        constant integer ORDER_phaseshifton=852515
        constant integer ORDER_phoenixfire=852481
        constant integer ORDER_phoenixmorph=852482
        constant integer ORDER_poisonarrows=852255
        constant integer ORDER_poisonarrowstarg=852254
        constant integer ORDER_polymorph=852074
        constant integer ORDER_possession=852196
        constant integer ORDER_preservation=852568
        constant integer ORDER_purge=852111
        constant integer ORDER_rainofchaos=852237
        constant integer ORDER_rainoffire=852238
        constant integer ORDER_raisedead=852197
        constant integer ORDER_raisedeadoff=852199
        constant integer ORDER_raisedeadon=852198
        constant integer ORDER_ravenform=852155
        constant integer ORDER_recharge=852157
        constant integer ORDER_rechargeoff=852159
        constant integer ORDER_rechargeon=852158
        constant integer ORDER_rejuvination=852160
        constant integer ORDER_renew=852161
        constant integer ORDER_renewoff=852163
        constant integer ORDER_renewon=852162
        constant integer ORDER_repair=852024
        constant integer ORDER_repairoff=852026
        constant integer ORDER_repairon=852025
        constant integer ORDER_replenish=852542
        constant integer ORDER_replenishlife=852545
        constant integer ORDER_replenishlifeoff=852547
        constant integer ORDER_replenishlifeon=852546
        constant integer ORDER_replenishmana=852548
        constant integer ORDER_replenishmanaoff=852550
        constant integer ORDER_replenishmanaon=852549
        constant integer ORDER_replenishoff=852544
        constant integer ORDER_replenishon=852543
        constant integer ORDER_request_hero=852239
        constant integer ORDER_requestsacrifice=852201
        constant integer ORDER_restoration=852202
        constant integer ORDER_restorationoff=852204
        constant integer ORDER_restorationon=852203
        constant integer ORDER_resumebuild=851999
        constant integer ORDER_resumeharvesting=852017
        constant integer ORDER_resurrection=852094
        constant integer ORDER_returnresources=852020
        constant integer ORDER_revenge=852241
        constant integer ORDER_revive=852039
        constant integer ORDER_roar=852164
        constant integer ORDER_robogoblin=852656
        constant integer ORDER_root=852165
        constant integer ORDER_sacrifice=852205
        constant integer ORDER_sanctuary=852569
        constant integer ORDER_scout=852181
        constant integer ORDER_selfdestruct=852040
        constant integer ORDER_selfdestructoff=852042
        constant integer ORDER_selfdestructon=852041
        constant integer ORDER_sentinel=852182
        constant integer ORDER_setrally=851980
        constant integer ORDER_shadowsight=852570
        constant integer ORDER_shadowstrike=852527
        constant integer ORDER_shockwave=852125
        constant integer ORDER_silence=852592
        constant integer ORDER_sleep=852227
        constant integer ORDER_slow=852075
        constant integer ORDER_slowoff=852077
        constant integer ORDER_slowon=852076
        constant integer ORDER_smart=851971
        constant integer ORDER_soulburn=852668
        constant integer ORDER_soulpreservation=852242
        constant integer ORDER_spellshield=852571
        constant integer ORDER_spellshieldaoe=852572
        constant integer ORDER_spellsteal=852483
        constant integer ORDER_spellstealoff=852485
        constant integer ORDER_spellstealon=852484
        constant integer ORDER_spies=852235
        constant integer ORDER_spiritlink=852499
        constant integer ORDER_spiritofvengeance=852528
        constant integer ORDER_spirittroll=852573
        constant integer ORDER_spiritwolf=852126
        constant integer ORDER_stampede=852593
        constant integer ORDER_standdown=852113
        constant integer ORDER_starfall=852183
        constant integer ORDER_stasistrap=852114
        constant integer ORDER_steal=852574
        constant integer ORDER_stomp=852127
        constant integer ORDER_stoneform=852206
        constant integer ORDER_stop=851972
        constant integer ORDER_submerge=852604
        constant integer ORDER_summonfactory=852658
        constant integer ORDER_summongrizzly=852594
        constant integer ORDER_summonphoenix=852489
        constant integer ORDER_summonquillbeast=852595
        constant integer ORDER_summonwareagle=852596
        constant integer ORDER_tankdroppilot=852079
        constant integer ORDER_tankloadpilot=852080
        constant integer ORDER_tankpilot=852081
        constant integer ORDER_taunt=852520
        constant integer ORDER_thunderbolt=852095
        constant integer ORDER_thunderclap=852096
        constant integer ORDER_tornado=852597
        constant integer ORDER_townbelloff=852083
        constant integer ORDER_townbellon=852082
        constant integer ORDER_tranquility=852184
        constant integer ORDER_transmute=852665
        constant integer ORDER_unavatar=852087
        constant integer ORDER_unavengerform=852532
        constant integer ORDER_unbearform=852139
        constant integer ORDER_unburrow=852534
        constant integer ORDER_uncoldarrows=852245
        constant integer ORDER_uncorporealform=852494
        constant integer ORDER_undeadbuild=851998
        constant integer ORDER_undefend=852056
        constant integer ORDER_undivineshield=852091
        constant integer ORDER_unetherealform=852497
        constant integer ORDER_unflamingarrows=852175
        constant integer ORDER_unflamingattack=852541
        constant integer ORDER_unholyfrenzy=852209
        constant integer ORDER_unimmolation=852178
        constant integer ORDER_unload=852047
        constant integer ORDER_unloadall=852048
        constant integer ORDER_unloadallcorpses=852054
        constant integer ORDER_unloadallinstant=852049
        constant integer ORDER_unpoisonarrows=852256
        constant integer ORDER_unravenform=852156
        constant integer ORDER_unrobogoblin=852657
        constant integer ORDER_unroot=852166
        constant integer ORDER_unstableconcoction=852500
        constant integer ORDER_unstoneform=852207
        constant integer ORDER_unsubmerge=852605
        constant integer ORDER_unsummon=852210
        constant integer ORDER_unwindwalk=852130
        constant integer ORDER_vengeance=852521
        constant integer ORDER_vengeanceinstant=852524
        constant integer ORDER_vengeanceoff=852523
        constant integer ORDER_vengeanceon=852522
        constant integer ORDER_volcano=852669
        constant integer ORDER_voodoo=852503
        constant integer ORDER_ward=852504
        constant integer ORDER_waterelemental=852097
        constant integer ORDER_wateryminion=852598
        constant integer ORDER_web=852211
        constant integer ORDER_weboff=852213
        constant integer ORDER_webon=852212
        constant integer ORDER_whirlwind=852128
        constant integer ORDER_windwalk=852129
        constant integer ORDER_wispharvest=852214

        constant integer ORDER_scrollofspeed=852285
        constant integer ORDER_cancel=851976
        constant integer ORDER_moveslot1=852002
        constant integer ORDER_moveslot2=852003
        constant integer ORDER_moveslot3=852004
        constant integer ORDER_moveslot4=852005
        constant integer ORDER_moveslot5=852006
        constant integer ORDER_moveslot6=852007
        constant integer ORDER_useslot1=852008
        constant integer ORDER_useslot2=852009
        constant integer ORDER_useslot3=852010
        constant integer ORDER_useslot4=852011
        constant integer ORDER_useslot5=852012
        constant integer ORDER_useslot6=852013
        constant integer ORDER_skillmenu=852000
        constant integer ORDER_stunned=851973
        constant integer ORDER_instant1=851991        //patrol sub-order
        constant integer ORDER_instant2=851987        //?
        constant integer ORDER_instant3=851975        //?
        constant integer ORDER_instant4=852019        //?
    endglobals

    library basic initializer init requires FormLib

        globals 

            integer globalNowtime = 0
            hashtable globalHashtable = InitHashtable()
            timer centeralTimer = CreateTimer()

            unit array party        [5]     //小队成员
            unit array hero         [MAX_HERO_TYPE]    //所有英雄
            unit array bag          [8]     //背包
            unit array bank         [8]     //银行
            //军械库
            unit armoury    = null 

            integer currentBag          = 0

            unit bankManager = null 
            unit bagFollowUnit = null 
            unit equipingUnit = null 
            item equipingItem = null 

            boolean COMBAT_LOG_ON = false 
            integer TIME_LOG_START = 0
            integer TIME_LOG_FLUSH = 0
            integer LOG_INDEX      = 0
            timer LOG_TIMER        = CreateTimer()

            boolexpr playerEnemyCombat
            boolexpr playerEnemy
            boolexpr playerAlly
            boolexpr playerHero
            boolexpr autoGateFilter
            boolexpr bossResetFilter

            boolexpr groupEnumLegal
            boolexpr groupEnumLegal_ProjBounce
            boolexpr blockMissile
            boolexpr isInnSelected

            rect loadPartyRect
            rect loadOtherHeroesRect
            real array loadBankX [8]
            real array loadBankY [8]
            real loadArmouryX = 0
            real loadArmouryY = 0
            integer enableBank 
            region wholeMapRegion

            gamecache gameCache

            trigger anyUnitDeath            = CreateTrigger()
            trigger saveCampaignFiles       = CreateTrigger()

            trigger anyUnitEnterMapZone     = CreateTrigger()
            trigger anyUnitBuyingItem       = CreateTrigger()
            trigger anyUnitSellingItem      = CreateTrigger()

            trigger anyUnitCastSpell        = CreateTrigger()
            trigger anyUnitReadyToCastSpell = CreateTrigger()
            trigger anyUnitStopCastSpell    = CreateTrigger()
            trigger anyUnitCastSpellEnd     = CreateTrigger()

            trigger anyUnitDamaging         = CreateTrigger()
            trigger anyUnitDamaged          = CreateTrigger()

            trigger anyUnitUseItem          = CreateTrigger()
            trigger anyUnitPickItem         = CreateTrigger()
            trigger anyUnitDropItem         = CreateTrigger()
            trigger anyUnitAttacking        = CreateTrigger()
            trigger tauntedUnitAimTarget    = CreateTrigger()
            trigger anyUnitIssueTargetOrder = CreateTrigger()
            trigger anyUnitIssuePointOrder  = CreateTrigger()
            trigger anyUnitIssueOrder       = CreateTrigger()

            trigger triggerHeroLevelUp      = CreateTrigger()
            trigger triggerHeroRevive       = CreateTrigger()
            
            trigger triggerLoadGame         = CreateTrigger()

            trigger triggerPressF4          = CreateTrigger()
            trigger triggerPressF5          = CreateTrigger()

            trigger triggerSelectUnit       = CreateTrigger()

            trigger triggerCombatLog        = CreateTrigger()

            group tauntTargetGroup          = CreateGroup()
            
            trigger openGameSight         = CreateTrigger()

            trigger array triggerHeroCheckState [MAX_HERO_TYPE]

            integer array placedHeroCellX[32]        // real 数组，大小 32（支持 0~31）
            integer array placedHeroCellY[32]        // real 数组，大小 32
            boolean array HeroCellUsed[64][64]
            integer placedHeroCount = 0      // integer
            
        endglobals

        globals
            constant string STATE_STR = "STR" 
            constant string STATE_AGI = "AGI" 
            constant string STATE_INT = "INT" 
            constant string STATE_MAIN = "MAIN"
            constant string STATE_MAIN_P = "MAIN_P"
            constant string STATE_ATTACK = "ATTACK" 
            constant string STATE_ABILITY_POWER = "ABILITY_POWER"
            constant string STATE_ARMOR = "ARMOR" 
            constant string STATE_LIFE = "LIFE" 
            constant string STATE_MANA = "MANA" 
            constant string STATE_MOVE_SPEED = "MOVE_SPEED"
            constant string STATE_LIFE_REGEN = "LIFE_REGEN"
            constant string STATE_MANA_REGEN = "MANA_REGEN"
            constant string STATE_BLOCK = "BLOCK" 
            constant string STATE_ARMOR_PENETRATION = "ARMOR_PENETRATION"
            constant string STATE_CRIT = "CRIT" 
            constant string STATE_CRIT_POWER = "CRIT_POWER"
            constant string STATE_HASTE = "HASTE" 
            constant string STATE_ATTACK_SPEED = "ATTACK_SPEED"
            constant string STATE_LEECH = "LEECH" 
            constant string STATE_EVADE = "EVADE" 
            constant string STATE_ACCURACY = "ACCURACY"
            constant string STATE_RESISTANCE = "RESISTANCE"
            constant string STATE_COST_REDUCE = "COST_REDUCE"
            constant string STATE_VERSATILITY = "VERSATILITY"

            constant string STATE_IMMUNE_STUN = "IMMUNE_STUN" 
            constant string STATE_IMMUNE_SNARE = "IMMUNE_SNARE" 
            constant string STATE_IMMUNE_SILENCE = "IMMUNE_SILENCE"
            constant string STATE_IMMUNE_ROOT = "IMMUNE_ROOT"
            constant string STATE_IMMUNE_COLD = "IMMUNE_COLD"

            constant string STATE_STR_P = "STR_P" 
            constant string STATE_AGI_P = "AGI_P" 
            constant string STATE_INT_P = "INT_P" 
            constant string STATE_ATTACK_P = "ATTACK_P" 
            constant string STATE_ABILITY_POWER_P = "ABILITY_POWER_P"
            constant string STATE_ARMOR_P = "ARMOR_P" 
            constant string STATE_LIFE_P = "LIFE_P" 
            constant string STATE_MANA_P = "MANA_P" 
            constant string STATE_MOVE_SPEED_P = "MOVE_SPEED_P"
            constant string STATE_LIFE_REGEN_P = "LIFE_REGEN_P"
            constant string STATE_MANA_REGEN_P = "MANA_REGEN_P"
            constant string STATE_BLOCK_P = "BLOCK_P" 
            constant string STATE_ARMOR_PENETRATION_P = "ARMOR_PENETRATION_P"
            constant string STATE_APPLY_AURA_0 = "APPLY_AURA_0"
            constant string STATE_APPLY_AURA_1 = "APPLY_AURA_1"
            constant string STATE_APPLY_AURA_2 = "APPLY_AURA_2"

            constant string STATE_MAX_ARMOR = "MAX_ARMOR"
            constant string STATE_MAX_RESISTANCE = "MAX_RESISTANCE"
            constant string STATE_MAX_BLOCK = "MAX_BLOCK"
            constant string STATE_MAX_EVADE = "MAX_EVADE"

            constant string STATE_HEAL_BONUS = "HEAL_BONUS"
            constant string STATE_SHIELD_BONUS = "SHIELD_BONUS"
            constant string STATE_DAMAGE_BONUS = "DAMAGE_BONUS"

            constant string STATE_BIND_ABILITY = "BIND_ABILITY"

            constant integer MINION_OWNER = StringHash("MINION_OWNER")

            constant string SUIT_ID = "SUIT_ID"

            integer array Item_SuitMembers 
            integer array Item_SuitStartId
            integer array Item_SuitItem 
            string array Item_SuitItem_Name
            integer array Item_SuitRank1
            integer array Item_SuitRank2
            integer array Item_SuitRank1_Buff
            string array Item_SuitRank1_BuffSet
            string array Item_SuitRank1_Description
            integer array Item_SuitRank2_Buff
            string array Item_SuitRank2_BuffSet
            string array Item_SuitRank2_Description
            mybuff Item_SuitSettingBuff
            unit checkingUnit = null 

            integer array binaryNumber [32]
        endglobals

        
        globals 
            private hashtable stateHash = InitHashtable() 
            constant integer STATE_MODE_INT = 0
            constant integer STATE_MODE_REAL = 1 
            constant integer STATE_MODE_PERCENTAGE = 2
            State eventState = 0
            unit eventUnit = null  
            boolean nowCheckAll = false 
            boolean doNotCheck = false 
            boolean nowInCheckingTrig = false 

            State ST_STR 
            State ST_AGI 
            State ST_INT 
            State ST_MAIN 
            State ST_LIFE
            State ST_MANA 
            State ST_LIFE_REGEN  
            State ST_MANA_REGEN  
            State ST_ABILITY_POWER
            State ST_ATTACK 
            State ST_ARMOR 
            State ST_HASTE 
            State ST_CRIT_CHANCE
            State ST_CRIT_POWER 
            State ST_BLOCK 
            State ST_ARMOR_PEN
            State ST_MOVE_SPEED
            State ST_EVADE 
            State ST_ACCURACY 
            State ST_RESISTANCE 
            State ST_VERSATILITY
            State ST_COST_REDUCE 
            State ST_DAMAGE_BONUS 
            State ST_HEAL_BONUS 
            State ST_SHIELD_BONUS 
            State ST_ATTACK_SPEED 
            State ST_LEECH 
            State ST_IMMUNE_COLD 
            State ST_IMMUNE_ROOT 
            State ST_IMMUNE_SILENCE 
            State ST_IMMUNE_STUN 
            State ST_IMMUNE_SNARE 
            State ST_MAX_ARMOR 
            State ST_MAX_RESISTANCE 
            State ST_MAX_BLOCK 
            State ST_MAX_EVADE
        endglobals
        struct State 
            static State top = 0
            string name     
            integer defaultSumMode
            trigger trigCheck 

            static method create takes string name,integer defaultSumMode,code action returns State
                local thistype this = thistype.allocate()
                //call BJDebugMsg("REGISTERED !")
                set this.name = name
                set this.defaultSumMode = defaultSumMode
                set this.trigCheck = CreateTrigger()
                call TriggerAddActionEx(this.trigCheck,action)
                set thistype.top = this 
                return this 
            endmethod

            method checkState takes unit whichUnit returns nothing
                local integer i = 0
                local integer heroId = GetHeroIndex(whichUnit)
                set eventState = this 
                set eventUnit = whichUnit
                call TriggerExecute(this.trigCheck)

                if nowCheckAll == false and doNotCheck == false and nowInCheckingTrig == false then 
                    set nowInCheckingTrig = true 
                    if master.getMasterByUnit(whichUnit) > 0 then 
                        call refreshMinionsState.evaluate(whichUnit)
                    endif 
                    set checkingUnit = whichUnit
                    if heroId > 0 then 
                        call TriggerExecute(triggerHeroCheckState[heroId-1])
                        set i = 0
                        loop    
                            exitwhen i > 3
                            call ExecuteFunc("PUBLIC_TALENT_CHECK_STATE_"+I2S(GetHeroTypePublicTalent(heroId,GetHeroSelectedPublicTalent(whichUnit,i))))
                            call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_CHECK_STATE_"+I2S(GetHeroSelectedPrivateTalent(whichUnit,i)))
                            set i = i+1
                        endloop
                        call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_CHECK_STATE_"+I2S(GetHeroSelectedUltimateTalent(whichUnit,0)))
                        call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_CHECK_STATE_"+I2S(GetHeroSelectedUltimateTalent(whichUnit,1)))
                    else 
                        call ExecuteFunc("CHECK_STATE_"+I2SSSS(GetUnitTypeId(whichUnit)))
                    endif 
                    set nowInCheckingTrig = false 
                endif 
            endmethod

            //////加总几部分属性，输出总值，大部分适用
            method getSummedState takes unit whichUnit returns integer 
                local integer I = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_I"))
                local integer R = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_R"))
                local integer P = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_P"))
                local real p = I2R(10000+P)/10000
                if this.defaultSumMode == STATE_MODE_INT then 
                    return R2I(I2R(I)*p+I2R(R)*p/100)
                elseif this.defaultSumMode == STATE_MODE_REAL then 
                    return R2I(I2R(I)*100*p+I2R(R)*p)
                elseif this.defaultSumMode == STATE_MODE_PERCENTAGE then 
                    return P 
                endif 
                return 0
            endmethod

            //////加总几部分属性，输出总值，对于单位拥有固有基础值的属性，例如生命法力力敏智等
            method getSummedStateEx takes unit whichUnit,integer addI,integer addR,integer addP returns integer 
                local integer I = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_I"))+addI 
                local integer R = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_R"))+addR 
                local integer P = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_P"))+addP 
                local real p = I2R(10000+P)/10000
                if this.defaultSumMode == STATE_MODE_INT then 
                    return R2I(I2R(I)*p+I2R(R)*p/100)
                elseif this.defaultSumMode == STATE_MODE_REAL then 
                    return R2I(I2R(I)*100*p+I2R(R)*p)
                elseif this.defaultSumMode == STATE_MODE_PERCENTAGE then 
                    return P 
                endif 
                return 0
            endmethod

            //////获取已经通过系统附加的总属性
            method getTotalState takes unit whichUnit returns integer 
                local integer result = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_T"))
                if minion.getMinionByUnit(whichUnit) > 0 then 
                    if this == ST_ARMOR_PEN or this == ST_HASTE or this == ST_CRIT_CHANCE or this == ST_CRIT_POWER or this == ST_DAMAGE_BONUS or this == ST_HEAL_BONUS or this == ST_SHIELD_BONUS then 
                        set result = IMaxBJ(result,LoadInteger(stateHash,GetHandleId(minion.getMinionByUnit(whichUnit).mast.masterUnit),StringHash(this.name+"_T")))
                    endif 
                endif 
                return result
            endmethod

            //////获取整数部分
            method getI takes unit whichUnit returns integer
                return LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_I"))
            endmethod
            //////获取实数部分
            method getR takes unit whichUnit returns integer
                return LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_R"))
            endmethod
            //////获取百分比部分
            method getP takes unit whichUnit returns integer
                return LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_P"))
            endmethod

            //////获取属性数值文本（用于打印）
            method getAmountString takes unit whichUnit returns string
                local string result 
                local real a = 0
                local real b = 0
                local real c = 0
                local integer i = 0
                local integer j = 0
                local integer k = 0
                local string color = "|cff888888"
                local integer heroId = GetHeroIndex(whichUnit)-1
                //特例：生命、法力、力量、敏捷、智力、攻击、护甲、移速
                if this == ST_LIFE then 
                    set a = I2R(this.getP(whichUnit))/100
                    if a > 0 then 
                        set color = "|cff20c000"
                    elseif a < 0 then 
                        set color = "|cffff4545"
                    endif 
                    set result = I2S(R2I(GetUnitState(whichUnit,UNIT_STATE_MAX_LIFE)))+color+"　(+"+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%)|r"
                    return result
                endif 
                if this == ST_MANA then 
                    set a = I2R(this.getP(whichUnit))/100
                    if a > 0 then 
                        set color = "|cff20c000"
                    elseif a < 0 then 
                        set color = "|cffff4545"
                    endif 
                    set result = I2S(R2I(GetUnitState(whichUnit,UNIT_STATE_MAX_MANA)))+color+"　(+"+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%)|r"
                    return result
                endif 
                if this == ST_STR then 
                    set a = I2R(this.getP(whichUnit))/100
                    set result = I2S(GetHeroStr(whichUnit,true))
                    if heroMainState[heroId] == STATE_STR then 
                        set a = a+I2R(ST_MAIN.getP(whichUnit))/100
                    endif 
                    if a > 0 then 
                        set color = "|cff20c000"
                    elseif a < 0 then 
                        set color = "|cffff4545"
                    endif 
                    set result = result+color+"　(+"+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%)|r"
                    return result
                endif 
                if this == ST_AGI then 
                    set a = I2R(this.getP(whichUnit))/100
                    set result = I2S(GetHeroAgi(whichUnit,true))
                    if (heroMainState[heroId] == STATE_AGI and heroId != 8) or (heroId == 8 and (heroNowForm[8] == FORM_DRUID_BEAR or heroNowForm[8] == FORM_DRUID_CAT)) then 
                        set a = a+I2R(ST_MAIN.getP(whichUnit))/100
                    endif 
                    if a > 0 then 
                        set color = "|cff20c000"
                    elseif a < 0 then 
                        set color = "|cffff4545"
                    endif 
                    set result = result+color+"　(+"+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%)"
                    return result
                endif 
                if this == ST_INT then 
                    set a = I2R(this.getP(whichUnit))/100
                    set result = I2S(GetHeroInt(whichUnit,true))
                    if (heroMainState[heroId] == STATE_INT and heroId != 8) or (heroId == 8 and (heroNowForm[8] == FORM_DRUID_NORMAL or heroNowForm[8] == FORM_DRUID_MOONKIN)) then 
                        set a = a+I2R(ST_MAIN.getP(whichUnit))/100
                    endif 
                    if a > 0 then 
                        set color = "|cff20c000"
                    elseif a < 0 then 
                        set color = "|cffff4545"
                    endif 
                    set result = result+color+"　(+"+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%)"
                    return result
                endif 
                if this == ST_ATTACK then 
                    set a = I2R(this.getP(whichUnit))/100
                    if a > 0 then 
                        set color = "|cff20c000"
                    elseif a < 0 then 
                        set color = "|cffff4545"
                    endif 
                    set result = I2S(GetUnitMinAttack(whichUnit,0))+"-"+I2S(GetUnitMaxAttack(whichUnit,0))+color+"　(+"+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%)|r"
                    return result
                endif 
                if this == ST_ARMOR then 
                    set a = BlzGetUnitArmor(whichUnit)
                    set b = 75+I2R(ST_MAX_ARMOR.getTotalState(whichUnit))/100
                    set c = 100*a/(a+25+5*I2R(UnitLevel(whichUnit)))
                    set i = R2I(a)
                    set result = I2S(i)+" / "
                    if b <= c then 
                        set result = result+"|cff20c000"+I2S(R2I(b))+"%%|r"
                    else 
                        set result = result+I2S(R2I(c))+"%%"
                    endif 
                    set a = I2R(this.getP(whichUnit))/100
                    if a > 0 then 
                        set color = "|cff20c000"
                    elseif a < 0 then 
                        set color = "|cffff4545"
                    endif 
                    set result = result+color+"　(+"+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%)|r"
                    return result
                endif 
                if this == ST_MOVE_SPEED then 
                    set a = I2R(this.getP(whichUnit))/100
                    if a > 0 then 
                        set color = "|cff20c000"
                    elseif a < 0 then 
                        set color = "|cffff4545"
                    endif 
                    set result = I2S(R2I(GetUnitMoveSpeed(whichUnit)))+color+"　(+"+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%)|r"
                    return result
                endif 
                if this == ST_CRIT_POWER then 
                    set a = I2R(this.getTotalState(whichUnit))/100
                    if a < 0 then 
                        set color = "|cffff4545"
                    else 
                        set color = "|cffffffff"
                    endif 
                    set result = color+R2S(a+100)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%|r"
                    return result
                endif 
                if this == ST_EVADE then 
                    set a = I2R(this.getTotalState(whichUnit))/100
                    set i = ST_MAX_EVADE.getTotalState(whichUnit)/100
                    set b = 50+I2R(i)
                    if a > b then 
                        set color = "|cff20c000"
                    else 
                        set color = "|cffffffff"
                    endif 
                    set result = color+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    if i > 0 then 
                        set color = "|cff20c000"
                    elseif i < 0 then 
                        set color = "|cffff4545"
                    else 
                        set color = "|cff888888"
                    endif 
                    set result = result+"%%|r"+" / "+color+I2S(R2I(b))+"%%|r"
                    return result
                endif 
                if this == ST_RESISTANCE then 
                    set a = I2R(this.getTotalState(whichUnit))/100
                    set i = ST_MAX_RESISTANCE.getTotalState(whichUnit)/100
                    set b = 50+I2R(i)
                    if a > b then 
                        set color = "|cff20c000"
                    else 
                        set color = "|cffffffff"
                    endif 
                    set result = color+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    if i > 0 then 
                        set color = "|cff20c000"
                    elseif i < 0 then 
                        set color = "|cffff4545"
                    else 
                        set color = "|cff888888"
                    endif 
                    set result = result+"%%|r"+" / "+color+I2S(R2I(b))+"%%|r"
                    return result
                endif 
                if this == ST_BLOCK then 
                    set a = I2R(this.getP(whichUnit))/100
                    set i = ST_MAX_BLOCK.getTotalState(whichUnit)/100
                    set b = 30+I2R(i)
                    set result = I2S(this.getTotalState(whichUnit))+" / "
                    if i > 0 then 
                        set color = "|cff20c000"
                    elseif i < 0 then 
                        set color = "|cffff4545"
                    else 
                        set color = "|cff888888"
                    endif 
                    set result = result+color+I2S(R2I(b))+"%%|r"
                    if a > 0 then 
                        set color = "|cff20c000"
                    elseif a < 0 then 
                        set color = "|cffff4545"
                    endif 
                    set result = result+color+"　(+"+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%)|r"
                    return result
                endif 
                if this.defaultSumMode == STATE_MODE_INT then 
                    set a = I2R(this.getP(whichUnit))/100
                    set i = this.getTotalState(whichUnit)
                    if a > 0 then 
                        set color = "|cff20c000"
                    elseif a < 0 then 
                        set color = "|cffff4545"
                    endif 
                    if i < 0 then 
                        set result = "|cffff4545"+I2S(i)+"|r"
                    else 
                        set result = "|cffffffff"+I2S(i)+"|r"
                    endif 
                    set result = result+color+"　(+"+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%)|r"
                    return result
                endif 
                if this.defaultSumMode == STATE_MODE_REAL then 
                    set a = I2R(this.getP(whichUnit))/100
                    set b = I2R(this.getTotalState(whichUnit))/100
                    if a > 0 then 
                        set color = "|cff20c000"
                    elseif a < 0 then 
                        set color = "|cffff4545"
                    endif 
                    if b < 0 then 
                        set result = "|cffff4545"+R2S(b)
                    else 
                        set result = "|cffffffff"+R2S(b)
                    endif 
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"|r"+color+"　(+"+R2S(I2R(this.getP(whichUnit))/100)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%)|r"
                    return result
                endif 
                if this.defaultSumMode == STATE_MODE_PERCENTAGE then 
                    set a = I2R(this.getTotalState(whichUnit))/100
                    if a < 0 then 
                        set color = "|cffff4545"
                    else
                        set color = "|cffffffff"
                    endif 
                    set result = color+R2S(a)
                    set result = SubString(result,0,StringLength(result)-1)
                    set result = result+"%%|r"
                    return result
                endif 
                return ""
            endmethod

            method addState takes unit whichUnit,integer whichStateMode,integer value returns boolean
                local integer I = 0
                local integer R = 0
                local integer P = 0
                if value == 0 then 
                    return false 
                endif 
                if (this == ST_STR or this == ST_AGI or this == ST_INT or this == ST_MAIN) and IsUnitType(whichUnit,UNIT_TYPE_HERO) == false then 
                    return false 
                endif 
                set I = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_I"))
                set R = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_R"))
                set P = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_P"))
                if whichStateMode == STATE_MODE_INT then 
                    set I = I+value
                elseif whichStateMode == STATE_MODE_REAL then 
                    set R = R+value
                elseif whichStateMode == STATE_MODE_PERCENTAGE then 
                    set P = P+value
                endif 
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_I"),I)
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_R"),R)
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_P"),P)
                call this.checkState(whichUnit)
                return true 
            endmethod

            method addStateSimple takes unit whichUnit,integer whichStateMode,integer value returns boolean
                local integer I = 0
                local integer R = 0
                local integer P = 0
                if value == 0 then 
                    return false 
                endif 
                if (this == ST_STR or this == ST_AGI or this == ST_INT or this == ST_MAIN) and IsUnitType(whichUnit,UNIT_TYPE_HERO) == false then 
                    return false 
                endif 
                set I = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_I"))
                set R = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_R"))
                set P = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_P"))
                if whichStateMode == STATE_MODE_INT then 
                    set I = I+value
                elseif whichStateMode == STATE_MODE_REAL then 
                    set R = R+value
                elseif whichStateMode == STATE_MODE_PERCENTAGE then 
                    set P = P+value
                endif 
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_I"),I)
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_R"),R)
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_P"),P)
                return true 
            endmethod

            method addStateWarforged takes unit whichUnit,integer whichStateMode,integer value,integer wf,boolean equiping returns boolean
                local integer I = 0
                local integer R = 0
                local integer P = 0
                if value == 0 then 
                    return false 
                endif 
                if (this == ST_STR or this == ST_AGI or this == ST_INT or this == ST_MAIN) and IsUnitType(whichUnit,UNIT_TYPE_HERO) == false then 
                    return false 
                endif 
                set I = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_I"))
                set R = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_R"))
                set P = LoadInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_P"))
                if equiping then 
                    if whichStateMode == STATE_MODE_INT then 
                        if value > 0 then
                            set R = R+value*wf
                        else
                            set R = R-value*100*wf/(100+wf)
                        endif 
                    elseif whichStateMode == STATE_MODE_REAL then 
                        if value > 0 then 
                            set R = R+value*wf/100 
                        else
                            set R = R-value*100*wf/(100+wf)/100
                        endif 
                    elseif whichStateMode == STATE_MODE_PERCENTAGE then 
                        if value > 0 then 
                            set P = P+value*wf/100
                        else 
                            set P = P-value*100*wf/(100+wf)/100
                        endif 
                    endif 
                else 
                    if whichStateMode == STATE_MODE_INT then 
                        if value < 0 then
                            set R = R+value*wf
                        else
                            set R = R-value*100*wf/(100+wf)
                        endif 
                    elseif whichStateMode == STATE_MODE_REAL then 
                        if value < 0 then 
                            set R = R+value*wf/100 
                        else 
                            set R = R-value*100*wf/(100+wf)/100
                        endif 
                    elseif whichStateMode == STATE_MODE_PERCENTAGE then 
                        if value < 0 then 
                            set P = P+value*wf/100
                        else 
                            set P = P-value*100*wf/(100+wf)/100
                        endif 
                    endif 
                endif 
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_I"),I)
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_R"),R)
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_P"),P)
                return true 
            endmethod

            method setState takes unit whichUnit,integer whichStateMode,integer value returns boolean
                local integer I = 0
                local integer R = 0
                local integer P = 0
                if (this == ST_STR or this == ST_AGI or this == ST_INT or this == ST_MAIN) and IsUnitType(whichUnit,UNIT_TYPE_HERO) == false then 
                    return false 
                endif 
                if whichStateMode == STATE_MODE_INT then 
                    set I = value
                elseif whichStateMode == STATE_MODE_REAL then 
                    set R = value
                elseif whichStateMode == STATE_MODE_PERCENTAGE then 
                    set P = value
                endif 
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_I"),I)
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_R"),R)
                call SaveInteger(stateHash,GetHandleId(whichUnit),StringHash(this.name+"_P"),P)
                call this.checkState(whichUnit)
                return true 
            endmethod

            static method modifyStateAbility takes unit whichUnit,integer idMax,integer idMin,integer binaryMax,integer targetValue returns boolean
                local integer idModifier = 0
                local integer i = binaryMax
                local integer remain = targetValue
                if targetValue > 0 then 
                    loop 
                        exitwhen i < 0
                        if i > 9 then 
                            set idModifier = i+7
                        else 
                            set idModifier = i
                        endif 
                        if remain >= binaryNumber[i] then 
                            if GetUnitAbilityLevel(whichUnit,idMax+idModifier) == 0 then 
                                call UnitAddAbility(whichUnit,idMax+idModifier)
                                call UnitMakeAbilityPermanent(whichUnit,true,idMax+idModifier)
                            endif 
                            set remain = remain-binaryNumber[i]
                        else 
                            call UnitMakeAbilityPermanent(whichUnit,false,idMax+idModifier)
                            call UnitRemoveAbility(whichUnit,idMax+idModifier)
                        endif 
                        call UnitRemoveAbility(whichUnit,idMin+idModifier)
                        set i = i-1
                    endloop
                elseif targetValue < 0 then 
                    set remain = (-1)*targetValue
                    loop 
                        exitwhen i < 0
                        if i > 9 then 
                            set idModifier = i+7
                        else 
                            set idModifier = i
                        endif 
                        if remain >= binaryNumber[i] then 
                            if GetUnitAbilityLevel(whichUnit,idMin+idModifier) == 0 then 
                                call UnitAddAbility(whichUnit,idMin+idModifier)
                                call UnitMakeAbilityPermanent(whichUnit,true,idMin+idModifier)
                            endif 
                            set remain = remain-binaryNumber[i]
                        else 
                            call UnitMakeAbilityPermanent(whichUnit,false,idMin+idModifier)
                            call UnitRemoveAbility(whichUnit,idMin+idModifier) 
                        endif 
                        call UnitRemoveAbility(whichUnit,idMax+idModifier)
                        set i = i-1
                    endloop
                else 
                    loop 
                        exitwhen i < 0
                        if i > 9 then 
                            set idModifier = i+7
                        else 
                            set idModifier = i
                        endif 
                        call UnitRemoveAbility(whichUnit,idMax+idModifier)
                        call UnitRemoveAbility(whichUnit,idMin+idModifier)
                        set i = i-1
                    endloop
                endif 
                if remain > 0 then 
                    return false 
                endif 
                return true 
            endmethod

            ///////////////////////////////////////////
            // region checkCallBacks
            ///////////////////////////////////////////
            private static method checkCommon takes nothing returns nothing
                local integer T = eventState.getSummedState(eventUnit)
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkMoveSpeed takes nothing returns nothing
                local integer base = R2I(GetUnitDefaultMoveSpeed(eventUnit))
                local integer T = eventState.getSummedStateEx(eventUnit,base,0,0)-base
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
                call SetUnitMoveSpeed(eventUnit,I2R(T)+GetUnitDefaultMoveSpeed(eventUnit))
            endmethod
            private static method checkAttackSpeed takes nothing returns nothing
                local integer t = eventState.getTotalState(eventUnit)
                local integer T = eventState.getSummedState(eventUnit)+ST_HASTE.getTotalState(eventUnit)
                if t != T then 
                    call thistype.modifyStateAbility(eventUnit,'AAS0','Aas0',8,T/100)
                endif 
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkHaste takes nothing returns nothing
                local integer T = eventState.getSummedState(eventUnit)
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
                call ST_ATTACK_SPEED.checkState(eventUnit)
            endmethod
            private static method checkVersatility takes nothing returns nothing
                local integer T = eventState.getSummedState(eventUnit)
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
                call ST_DAMAGE_BONUS.checkState(eventUnit)
                call ST_HEAL_BONUS.checkState(eventUnit)
                call ST_SHIELD_BONUS.checkState(eventUnit)
            endmethod
            private static method checkLife takes nothing returns nothing
                local integer t = eventState.getTotalState(eventUnit)
                local integer nowValue = R2I(GetUnitState(eventUnit,UNIT_STATE_MAX_LIFE))
                local integer base = nowValue-t 
                local integer T = eventState.getSummedStateEx(eventUnit,base,0,0)-base 
                if t != T then 
                    call thistype.modifyStateAbility(eventUnit,'ALI0','Ali0',22,T)
                endif 
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkMana takes nothing returns nothing
                local integer t = eventState.getTotalState(eventUnit)
                local integer nowValue = R2I(GetUnitState(eventUnit,UNIT_STATE_MAX_MANA))
                local integer base = nowValue-t 
                local integer T = eventState.getSummedStateEx(eventUnit,base,0,0)-base 
                if t != T then 
                    call thistype.modifyStateAbility(eventUnit,'AMA0','Ama0',22,T)
                endif 
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkAttack takes nothing returns nothing
                local integer t = eventState.getTotalState(eventUnit)
                local integer base = BlzGetUnitWeaponIntegerField(eventUnit,UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE,0)
                local integer T = eventState.getSummedStateEx(eventUnit,base,0,0)-base 
                if t != T then 
                    call thistype.modifyStateAbility(eventUnit,'AAT0','Aat0',15,T)
                endif 
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkArmor takes nothing returns nothing
                local integer t = eventState.getTotalState(eventUnit)
                local integer nowValue = R2I(BlzGetUnitArmor(eventUnit))
                local integer base = nowValue-t 
                local integer T = eventState.getSummedStateEx(eventUnit,base,0,0)-base
                if t != T then 
                    call thistype.modifyStateAbility(eventUnit,'AAR0','Aar0',10,T)
                endif 
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkCrit takes nothing returns nothing
                local integer base = 500
                local integer T = eventState.getSummedStateEx(eventUnit,0,0,base)
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkEvade takes nothing returns nothing
                local integer base = 500
                local integer T = eventState.getSummedStateEx(eventUnit,0,0,base)
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkCritPower takes nothing returns nothing
                local integer base = R2I(I2R(GetHeroStr(eventUnit,true))*12.5)+5000
                local integer T = eventState.getSummedStateEx(eventUnit,0,0,base)
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkArmorPen takes nothing returns nothing
                local integer base = R2I(I2R(GetHeroAgi(eventUnit,true))*12.5)
                local integer T = eventState.getSummedStateEx(eventUnit,0,base,0)
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkAbilityPower takes nothing returns nothing
                local integer base = GetHeroInt(eventUnit,true)*75+GetHeroInt(eventUnit,false)*25+GetUnitLevel(eventUnit)*50
                local integer T = 0
                set base = base+R2I(BlzGetUnitRealField(eventUnit,UNIT_RF_INTELLIGENCE_PER_LEVEL)+0.01)*500
                set T = eventState.getSummedStateEx(eventUnit,0,base,0)
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkStr takes nothing returns nothing
                local integer t = eventState.getTotalState(eventUnit)
                local integer base = GetHeroStr(eventUnit,false)
                local integer T
                local integer heroId = GetHeroIndex(eventUnit)-1
                local integer addI = 0
                local integer addR = 0
                local integer addP = 0
                local boolean mainST = false 
                if heroId >= 0 then 
                    if heroMainState[heroId] == STATE_STR then 
                        set addI = ST_MAIN.getI(eventUnit)
                        set addR = ST_MAIN.getR(eventUnit)
                        set addP = ST_MAIN.getP(eventUnit)
                        set mainST = true 
                    endif 
                endif 
                set T = eventState.getSummedStateEx(eventUnit,base+addI,addR,addP)-base 
                if t != T then 
                    call thistype.modifyStateAbility(eventUnit,'AST0','Ast0',12,T)
                endif 
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
                call ST_LIFE.checkState(eventUnit)
                if mainST then 
                    call ST_ATTACK.checkState(eventUnit)
                endif 
                call ST_CRIT_POWER.checkState(eventUnit)
            endmethod
            private static method checkAgi takes nothing returns nothing
                local integer t = eventState.getTotalState(eventUnit)
                local integer base = GetHeroAgi(eventUnit,false)
                local integer T
                local integer heroId = GetHeroIndex(eventUnit)-1
                local integer addI = 0
                local integer addR = 0
                local integer addP = 0
                local boolean mainST = false 
                if heroId >= 0 then 
                    if (heroMainState[heroId] == STATE_AGI and heroId != 8) or (heroId == 8 and (heroNowForm[8] == FORM_DRUID_BEAR or heroNowForm[8] == FORM_DRUID_CAT)) then 
                        set addI = ST_MAIN.getI(eventUnit)
                        set addR = ST_MAIN.getR(eventUnit)
                        set addP = ST_MAIN.getP(eventUnit)
                        set mainST = true 
                    endif 
                endif 
                set T = eventState.getSummedStateEx(eventUnit,base+addI,addR,addP)-base 
                if t != T then 
                    call thistype.modifyStateAbility(eventUnit,'AAG0','Aag0',12,T)
                endif 
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
                call ST_ARMOR.checkState(eventUnit)
                if mainST then 
                    call ST_ATTACK.checkState(eventUnit)
                endif 
                call ST_ARMOR_PEN.checkState(eventUnit)
            endmethod
            private static method checkInt takes nothing returns nothing
                local integer t = eventState.getTotalState(eventUnit)
                local integer base = GetHeroInt(eventUnit,false)
                local integer T
                local integer heroId = GetHeroIndex(eventUnit)-1
                local integer addI = 0
                local integer addR = 0
                local integer addP = 0
                local boolean mainST = false 
                if heroId >= 0 then 
                    if (heroMainState[heroId] == STATE_INT and heroId != 8) or (heroId == 8 and (heroNowForm[8] == FORM_DRUID_NORMAL or heroNowForm[8] == FORM_DRUID_MOONKIN)) then 
                        set addI = ST_MAIN.getI(eventUnit)
                        set addR = ST_MAIN.getR(eventUnit)
                        set addP = ST_MAIN.getP(eventUnit)
                        set mainST = true 
                    endif 
                endif 
                set T = eventState.getSummedStateEx(eventUnit,base+addI,addR,addP)-base 
                if t != T then 
                    call thistype.modifyStateAbility(eventUnit,'AIN0','Ain0',12,T)
                endif 
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
                call ST_MANA.checkState(eventUnit)
                if mainST then 
                    call ST_ATTACK.checkState(eventUnit)
                endif 
                call ST_ABILITY_POWER.checkState(eventUnit)
            endmethod
            private static method checkMain takes nothing returns nothing
                local integer heroId = GetHeroIndex(eventUnit)-1
                call ST_STR.checkState(eventUnit)
                call ST_AGI.checkState(eventUnit)
                call ST_INT.checkState(eventUnit)
            endmethod
            private static method checkDamageBonus takes nothing returns nothing
                local integer base = ST_VERSATILITY.getTotalState(eventUnit)
                local integer T = eventState.getSummedStateEx(eventUnit,0,0,base)
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkHealBonus takes nothing returns nothing
                local integer base = ST_VERSATILITY.getTotalState(eventUnit)
                local integer T = eventState.getSummedStateEx(eventUnit,0,0,base)
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            private static method checkShieldBonus takes nothing returns nothing
                local integer base = ST_VERSATILITY.getTotalState(eventUnit)
                local integer T = eventState.getSummedStateEx(eventUnit,0,0,base)
                call SaveInteger(stateHash,GetHandleId(eventUnit),StringHash(eventState.name+"_T"),T)
            endmethod
            ///////////////////////////////////////////
            // endregion 
            ///////////////////////////////////////////

            static method checkAll takes unit whichUnit returns nothing
                local integer i = 0
                local integer heroId = GetHeroIndex(whichUnit)
                //call BJDebugMsg("checkAll")
                set nowCheckAll = true 

                if IsUnitType(whichUnit,UNIT_TYPE_HERO) then 
                    call ST_MAIN.checkState(whichUnit) 
                else 
                    call ST_ATTACK.checkState(whichUnit)
                    call ST_ARMOR.checkState(whichUnit)
                    call ST_LIFE.checkState(whichUnit)
                    call ST_MANA.checkState(whichUnit)
                    call ST_ARMOR_PEN.checkState(whichUnit)
                    call ST_CRIT_POWER.checkState(whichUnit)
                    call ST_ABILITY_POWER.checkState(whichUnit)
                endif 
                call ST_LIFE_REGEN.checkState(whichUnit)  
                call ST_MANA_REGEN.checkState(whichUnit)  
                call ST_HASTE.checkState(whichUnit) 
                call ST_CRIT_CHANCE.checkState(whichUnit)
                call ST_BLOCK.checkState(whichUnit) 
                call ST_MOVE_SPEED.checkState(whichUnit)
                call ST_EVADE.checkState(whichUnit) 
                call ST_ACCURACY.checkState(whichUnit) 
                call ST_RESISTANCE.checkState(whichUnit) 
                call ST_COST_REDUCE.checkState(whichUnit) 
                call ST_VERSATILITY.checkState(whichUnit) 
                //call ST_DAMAGE_BONUS.checkState(whichUnit) 
                //call ST_HEAL_BONUS.checkState(whichUnit) 
                //call ST_SHIELD_BONUS.checkState(whichUnit) 
                call ST_LEECH.checkState(whichUnit) 
                call ST_MAX_ARMOR.checkState(whichUnit) 
                call ST_MAX_RESISTANCE.checkState(whichUnit) 
                call ST_MAX_BLOCK.checkState(whichUnit) 
                call ST_MAX_EVADE.checkState(whichUnit) 
                call ST_IMMUNE_COLD.checkState(whichUnit)
                call ST_IMMUNE_ROOT.checkState(whichUnit)
                call ST_IMMUNE_SILENCE.checkState(whichUnit)
                call ST_IMMUNE_SNARE.checkState(whichUnit)
                call ST_IMMUNE_STUN.checkState(whichUnit)

                if doNotCheck == false and nowInCheckingTrig == false then 
                    if master.getMasterByUnit(whichUnit) > 0 then 
                        call refreshMinionsState.evaluate(whichUnit)
                    endif 

                    set nowInCheckingTrig = true 
                    set checkingUnit = whichUnit
                    if heroId > 0 then 
                        call TriggerExecute(triggerHeroCheckState[heroId-1])

                        set i = 0
                        loop    
                            exitwhen i > 3
                            call ExecuteFunc("PUBLIC_TALENT_CHECK_STATE_"+I2S(GetHeroTypePublicTalent(heroId,GetHeroSelectedPublicTalent(whichUnit,i))))
                            call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_CHECK_STATE_"+I2S(GetHeroSelectedPrivateTalent(whichUnit,i)))
                            set i = i+1
                        endloop
                        call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_CHECK_STATE_"+I2S(GetHeroSelectedUltimateTalent(whichUnit,0)))
                        call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_CHECK_STATE_"+I2S(GetHeroSelectedUltimateTalent(whichUnit,1)))
                    else 
                        call ExecuteFunc("CHECK_STATE_"+I2SSSS(GetUnitTypeId(whichUnit)))
                    endif 
                    set nowInCheckingTrig = false 
                endif 
                //无需检查生命爆伤，已经在力量检查过；无需检查法力法强，已经在智力检查过；无需检查护甲破甲，已经在敏捷检查过；
                //无需检查攻击力，已经在主属性检查过；无需检查法强，已经在智力检查过；无需检查攻速，已经在急速检查过
                //无需检查增伤/治疗/护盾，全能已经检查过
                set nowCheckAll = false 
            endmethod

            static method initAll takes nothing returns nothing
                //call BJDebugMsg("initState")
                set ST_STR              = thistype.create( STATE_STR , STATE_MODE_INT , function thistype.checkStr )
                set ST_AGI              = thistype.create( STATE_AGI , STATE_MODE_INT , function thistype.checkAgi )
                set ST_INT              = thistype.create( STATE_INT , STATE_MODE_INT , function thistype.checkInt )
                set ST_MAIN             = thistype.create( STATE_MAIN , STATE_MODE_INT , function thistype.checkMain )
                set ST_LIFE             = thistype.create( STATE_LIFE , STATE_MODE_INT , function thistype.checkLife )
                set ST_MANA             = thistype.create( STATE_MANA , STATE_MODE_INT , function thistype.checkMana )
                set ST_LIFE_REGEN       = thistype.create( STATE_LIFE_REGEN , STATE_MODE_REAL , function thistype.checkCommon )
                set ST_MANA_REGEN       = thistype.create( STATE_MANA_REGEN , STATE_MODE_REAL , function thistype.checkCommon )
                set ST_ABILITY_POWER    = thistype.create( STATE_ABILITY_POWER , STATE_MODE_INT , function thistype.checkAbilityPower )
                set ST_ATTACK           = thistype.create( STATE_ATTACK , STATE_MODE_INT , function thistype.checkAttack )
                set ST_ARMOR            = thistype.create( STATE_ARMOR , STATE_MODE_INT , function thistype.checkArmor )
                set ST_HASTE            = thistype.create( STATE_HASTE, STATE_MODE_PERCENTAGE , function thistype.checkHaste )
                set ST_CRIT_CHANCE      = thistype.create( STATE_CRIT , STATE_MODE_PERCENTAGE , function thistype.checkCrit )
                set ST_CRIT_POWER       = thistype.create( STATE_CRIT_POWER , STATE_MODE_PERCENTAGE , function thistype.checkCritPower )
                set ST_BLOCK            = thistype.create( STATE_BLOCK , STATE_MODE_INT , function thistype.checkCommon )
                set ST_ARMOR_PEN        = thistype.create( STATE_ARMOR_PENETRATION , STATE_MODE_INT , function thistype.checkArmorPen )
                set ST_MOVE_SPEED       = thistype.create( STATE_MOVE_SPEED , STATE_MODE_INT , function thistype.checkMoveSpeed )
                set ST_EVADE            = thistype.create( STATE_EVADE , STATE_MODE_PERCENTAGE , function thistype.checkEvade )
                set ST_ACCURACY         = thistype.create( STATE_ACCURACY , STATE_MODE_PERCENTAGE , function thistype.checkCommon )
                set ST_VERSATILITY      = thistype.create( STATE_VERSATILITY , STATE_MODE_PERCENTAGE , function thistype.checkVersatility )
                set ST_RESISTANCE       = thistype.create( STATE_RESISTANCE , STATE_MODE_PERCENTAGE , function thistype.checkCommon )
                set ST_MAX_ARMOR        = thistype.create( STATE_MAX_ARMOR , STATE_MODE_PERCENTAGE , function thistype.checkCommon )
                set ST_MAX_RESISTANCE   = thistype.create( STATE_MAX_RESISTANCE , STATE_MODE_PERCENTAGE , function thistype.checkCommon )
                set ST_MAX_BLOCK        = thistype.create( STATE_MAX_BLOCK , STATE_MODE_PERCENTAGE , function thistype.checkCommon )
                set ST_MAX_EVADE        = thistype.create( STATE_MAX_EVADE , STATE_MODE_PERCENTAGE , function thistype.checkCommon )
                set ST_COST_REDUCE      = thistype.create( STATE_COST_REDUCE , STATE_MODE_PERCENTAGE , function thistype.checkCommon )
                set ST_DAMAGE_BONUS     = thistype.create( STATE_DAMAGE_BONUS , STATE_MODE_PERCENTAGE , function thistype.checkDamageBonus )
                set ST_HEAL_BONUS       = thistype.create( STATE_HEAL_BONUS , STATE_MODE_PERCENTAGE , function thistype.checkHealBonus )
                set ST_SHIELD_BONUS     = thistype.create( STATE_SHIELD_BONUS , STATE_MODE_PERCENTAGE , function thistype.checkShieldBonus )
                set ST_LEECH            = thistype.create( STATE_LEECH , STATE_MODE_PERCENTAGE , function thistype.checkCommon )
                set ST_ATTACK_SPEED     = thistype.create( STATE_ATTACK_SPEED , STATE_MODE_PERCENTAGE , function thistype.checkAttackSpeed )
                set ST_IMMUNE_COLD      = thistype.create( STATE_IMMUNE_COLD , STATE_MODE_INT , function thistype.checkCommon )
                set ST_IMMUNE_ROOT      = thistype.create( STATE_IMMUNE_ROOT , STATE_MODE_INT , function thistype.checkCommon )
                set ST_IMMUNE_SILENCE   = thistype.create( STATE_IMMUNE_SILENCE , STATE_MODE_INT , function thistype.checkCommon )
                set ST_IMMUNE_SNARE     = thistype.create( STATE_IMMUNE_SNARE , STATE_MODE_INT , function thistype.checkCommon )
                set ST_IMMUNE_STUN      = thistype.create( STATE_IMMUNE_STUN , STATE_MODE_INT , function thistype.checkCommon )

                
                set STATE_ST_AMOUNT[ 0] = 0
                set STATE_ST_AMOUNT[ 1] = ST_LIFE
                set STATE_ST_AMOUNT[ 2] = ST_MANA
                set STATE_ST_AMOUNT[ 3] = ST_LIFE_REGEN
                set STATE_ST_AMOUNT[ 4] = ST_MANA_REGEN
                set STATE_ST_AMOUNT[ 5] = ST_STR
                set STATE_ST_AMOUNT[ 6] = ST_AGI
                set STATE_ST_AMOUNT[ 7] = ST_INT
                set STATE_ST_AMOUNT[ 8] = ST_MOVE_SPEED
                set STATE_ST_AMOUNT[ 9] = 0
                set STATE_ST_AMOUNT[10] = ST_ATTACK
                set STATE_ST_AMOUNT[11] = ST_ATTACK_SPEED
                set STATE_ST_AMOUNT[12] = ST_ACCURACY
                set STATE_ST_AMOUNT[13] = ST_ARMOR_PEN
                set STATE_ST_AMOUNT[14] = 0
                set STATE_ST_AMOUNT[15] = ST_ABILITY_POWER
                set STATE_ST_AMOUNT[16] = ST_COST_REDUCE
                set STATE_ST_AMOUNT[17] = 0
                set STATE_ST_AMOUNT[18] = ST_ARMOR
                set STATE_ST_AMOUNT[19] = ST_BLOCK
                set STATE_ST_AMOUNT[20] = ST_EVADE
                set STATE_ST_AMOUNT[21] = ST_RESISTANCE
                set STATE_ST_AMOUNT[22] = 0
                set STATE_ST_AMOUNT[23] = ST_CRIT_CHANCE
                set STATE_ST_AMOUNT[24] = ST_CRIT_POWER
                set STATE_ST_AMOUNT[25] = ST_HASTE
                set STATE_ST_AMOUNT[26] = ST_VERSATILITY
                set STATE_ST_AMOUNT[27] = ST_LEECH
                set STATE_ST_AMOUNT[28] = ST_DAMAGE_BONUS
                set STATE_ST_AMOUNT[29] = ST_HEAL_BONUS
                set STATE_ST_AMOUNT[30] = ST_SHIELD_BONUS
            endmethod

        endstruct

        function RefreshHeroTalent_Reset takes unit whichUnit returns nothing
            local unit tempUU = currentTTOwner
            local integer i = 0
            local integer j = 0
            local integer k = 0
            if GetHeroIndex(whichUnit) != 0 then 
                set currentTTOwner = whichUnit
                set j = GetHeroIndex(whichUnit)
                loop 
                    exitwhen i > 3
                    set k = GetHeroTypePublicTalent(j,GetHeroSelectedPublicTalent(whichUnit,i))
                    call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_RESET_"+I2S(GetHeroSelectedPrivateTalent(whichUnit,i)))
                    call ExecuteFunc("PUBLIC_TALENT_RESET_"+I2S(k))
                    set i = i+1
                endloop
                call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_RESET_"+I2S(GetHeroSelectedUltimateTalent(whichUnit,0)))
                call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_RESET_"+I2S(GetHeroSelectedUltimateTalent(whichUnit,1)))
                set currentTTOwner = null 
            endif 
            set currentTTOwner = tempUU
            set tempUU = null 
        endfunction
        function RefreshHeroTalent_Learn takes unit whichUnit returns nothing
            local unit tempUU = currentTTOwner
            local integer i = 0
            local integer j = 0
            local integer k = 0
            if GetHeroIndex(whichUnit) != 0 then 
                set currentTTOwner = whichUnit
                set j = GetHeroIndex(whichUnit)
                loop 
                    exitwhen i > 3
                    set k = GetHeroTypePublicTalent(j,GetHeroSelectedPublicTalent(whichUnit,i))
                    call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_LEARN_"+I2S(GetHeroSelectedPrivateTalent(whichUnit,i)))
                    call ExecuteFunc("PUBLIC_TALENT_LEARN_"+I2S(k))
                    set i = i+1
                endloop
                call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_LEARN_"+I2S(GetHeroSelectedUltimateTalent(whichUnit,0)))
                call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_LEARN_"+I2S(GetHeroSelectedUltimateTalent(whichUnit,1)))
                set currentTTOwner = null 
            endif 
            set currentTTOwner = tempUU
            set tempUU = null 
        endfunction

        function ClearHeroGrid takes nothing returns nothing
            local integer x = 0
            local integer y = 0
            loop
                exitwhen x >= 64
                set y = 0
                loop
                    exitwhen y >= 64
                    set HeroCellUsed[x][y] = false
                    set y = y + 1
                endloop
                if x <= 31 then 
                    set placedHeroCellX[x] = -1
                    set placedHeroCellY[x] = -1
                endif 
                set x = x + 1
            endloop
        endfunction
        function ClearTargetHeroGrid takes unit u returns nothing
            local integer i = GetHeroIndex(u)-1
            local integer gx = placedHeroCellX[i]
            local integer gy = placedHeroCellY[i]
            set placedHeroCellX[i] = -1
            set placedHeroCellY[i] = -1
            if gx > -1 and gy > -1 then 
                set HeroCellUsed[gx][gy] = false
            endif 
        endfunction
        function PlaceUnselectedHeroScattered takes unit u, rect area returns nothing
            // 所有局部变量必须在这里声明
            local real     minX = GetRectMinX(area)
            local real     maxX = GetRectMaxX(area)
            local real     minY = GetRectMinY(area)
            local real     maxY = GetRectMaxY(area)
            local real     areaW = maxX - minX
            local real     areaH = maxY - minY
            local integer  gridW = R2I(areaW / 32.0) + 2    // 多算一格防止越界
            local integer  gridH = R2I(areaH / 32.0) + 2
            local integer  array candX
            local integer  array candY
            local integer  candCount = 0
            local integer  gx
            local integer  gy
            local integer  cx
            local integer  cy
            local boolean  valid
            local integer  i
            local integer  chosen
            local real     rx
            local real     ry
            
            // Step 1: 收集所有可用的 32×32 格子（自己空 + 周围 2 格内没人）
            set gx = 0
            loop
                exitwhen gx >= gridW
                set gy = 0
                loop
                    exitwhen gy >= gridH
                    
                    if not HeroCellUsed[gx][gy] then
                        set valid = true
                        
                        // 检查 7×7 范围（距离 ≤2 格）
                        set cx = gx - 3
                        loop
                            exitwhen cx > gx + 3 or not valid
                            set cy = gy - 3
                            loop
                                exitwhen cy > gy + 3 or not valid
                                if cx >= 0 and cx < gridW and cy >= 0 and cy < gridH then
                                    if HeroCellUsed[cx][cy] then
                                        set valid = false
                                    endif
                                endif
                                set cy = cy + 1
                            endloop
                            set cx = cx + 1
                        endloop
                        
                        if valid then
                            set candX[candCount] = gx
                            set candY[candCount] = gy
                            set candCount = candCount + 1
                        endif
                    endif
                    set gy = gy + 1
                endloop
                set gx = gx + 1
            endloop
            
            // Step 2: 有可用格子 → 随机选一个放
            if candCount > 0 then
                set chosen = GetRandomInt(0, candCount - 1)
                set gx = candX[chosen]
                set gy = candY[chosen]
                
                // 标记占用
                set HeroCellUsed[gx][gy] = true
                set placedHeroCellX[GetHeroIndex(u)-1] = gx 
                set placedHeroCellY[GetHeroIndex(u)-1] = gy 
                // 在格子内随机一点（更自然）
                set rx = minX + I2R(gx) * 32.0 + GetRandomReal(6.0, 26.0)
                set ry = minY + I2R(gy) * 32.0 + GetRandomReal(6.0, 26.0)
            else
                // 极端情况：格子全满 → 退化成普通随机
                set rx = minX + GetRandomReal(100.0, areaW - 100.0)
                set ry = minY + GetRandomReal(100.0, areaH - 100.0)
            endif
            // 放置 + 记录
            call IssueNeutralPointOrderById(PLAYER2,u,ORDER_move,rx,ry)
        endfunction
        function PlaceUnselectedHeroScatteredImmediate takes unit u, rect area returns nothing
            // 所有局部变量必须在这里声明
            local real     minX = GetRectMinX(area)
            local real     maxX = GetRectMaxX(area)
            local real     minY = GetRectMinY(area)
            local real     maxY = GetRectMaxY(area)
            local real     areaW = maxX - minX
            local real     areaH = maxY - minY
            local integer  gridW = R2I(areaW / 32.0) + 2    // 多算一格防止越界
            local integer  gridH = R2I(areaH / 32.0) + 2
            local integer  array candX
            local integer  array candY
            local integer  candCount = 0
            local integer  gx
            local integer  gy
            local integer  cx
            local integer  cy
            local boolean  valid
            local integer  i
            local integer  chosen
            local real     rx
            local real     ry
            local location loc = null 
            
            // Step 1: 收集所有可用的 32×32 格子（自己空 + 周围 2 格内没人）
            set gx = 0
            loop
                exitwhen gx >= gridW
                set gy = 0
                loop
                    exitwhen gy >= gridH
                    
                    if not HeroCellUsed[gx][gy] then
                        set valid = true
                        
                        // 检查 5×5 范围（距离 ≤2 格）
                        set cx = gx - 3
                        loop
                            exitwhen cx > gx + 3 or not valid
                            set cy = gy - 3
                            loop
                                exitwhen cy > gy + 3 or not valid
                                if cx >= 0 and cx < gridW and cy >= 0 and cy < gridH then
                                    if HeroCellUsed[cx][cy] then
                                        set valid = false
                                    endif
                                endif
                                set cy = cy + 1
                            endloop
                            set cx = cx + 1
                        endloop
                        
                        if valid then
                            set candX[candCount] = gx
                            set candY[candCount] = gy
                            set candCount = candCount + 1
                        endif
                    endif
                    set gy = gy + 1
                endloop
                set gx = gx + 1
            endloop
            
            // Step 2: 有可用格子 → 随机选一个放
            if candCount > 0 then
                set chosen = GetRandomInt(0, candCount - 1)
                set gx = candX[chosen]
                set gy = candY[chosen]
                
                // 标记占用
                set HeroCellUsed[gx][gy] = true
                set placedHeroCellX[GetHeroIndex(u)-1] = gx 
                set placedHeroCellY[GetHeroIndex(u)-1] = gy 
                // 在格子内随机一点（更自然）
                set rx = minX + I2R(gx) * 32.0 + GetRandomReal(6.0, 26.0)
                set ry = minY + I2R(gy) * 32.0 + GetRandomReal(6.0, 26.0)
            else
                // 极端情况：格子全满 → 退化成普通随机
                set rx = minX + GetRandomReal(100.0, areaW - 100.0)
                set ry = minY + GetRandomReal(100.0, areaH - 100.0)
            endif
            // 放置 + 记录
            call SetUnitX(u, rx)
            call SetUnitY(u, ry)
            call SetUnitFacing(u, GetRandomReal(0, 360))
            set loc = Location(rx,ry)
            call SetUnitPositionLoc(u,loc)
            call IssueNeutralImmediateOrderById(PLAYER2,u,ORDER_holdposition)
            call RemoveLocation(loc)
            set loc = null 
        endfunction

        function enableAllElements takes nothing returns nothing
            set damageTag_Arcane    = true 
            set damageTag_Cold      = true 
            set damageTag_Divine    = true 
            set damageTag_Earth     = true 
            set damageTag_Fire      = true 
            set damageTag_Lightning = true 
            set damageTag_Shadow    = true 
        endfunction
        function enableRandomElement takes nothing returns nothing
            if GetRandomReal(0,1) < 0.143 then 
                set damageTag_Arcane = true 
            elseif GetRandomReal(0,1) < 0.167 then 
                set damageTag_Cold = true 
            elseif GetRandomReal(0,1) < 0.2 then 
                set damageTag_Divine = true 
            elseif GetRandomReal(0,1) < 0.25 then 
                set damageTag_Earth = true 
            elseif GetRandomReal(0,1) < 0.333 then
                set damageTag_Fire = true 
            elseif GetRandomReal(0,1) < 0.5 then 
                set damageTag_Lightning = true 
            else 
                set damageTag_Shadow = true 
            endif
        endfunction
        function countDamageElements takes nothing returns integer 
            local integer i = 0
            if damageTag_Arcane then 
                set i = i+1
            endif 
            if damageTag_Fire then 
                set i = i+1
            endif 
            if damageTag_Cold then 
                set i = i+1
            endif 
            if damageTag_Earth then 
                set i = i+1
            endif 
            if damageTag_Shadow then 
                set i = i+1
            endif 
            if damageTag_Divine then 
                set i = i+1
            endif 
            if damageTag_Lightning then 
                set i = i+1
            endif 
            return i
        endfunction
        function ifDamageHasElement takes nothing returns boolean
            return countDamageElements > 0
        endfunction
        function GetPartyIndex takes unit whichUnit returns integer
            return GetHeroData(whichUnit,PARTY_INDEX)-1
        endfunction
        function GetEquipedItem takes unit whichUnit,integer slotIndex returns Equipment
            return LoadInteger(equipHash,GetHandleId(whichUnit),slotIndex)
        endfunction 
        function SetEquipedItem takes unit whichUnit,integer slotIndex,Equipment itemID returns nothing
            call SaveInteger(equipHash,GetHandleId(whichUnit),slotIndex,itemID)
        endfunction 

        function GetMinionOwnerUnitByUnit takes unit whichUnit returns unit 
            return minion.getMinionByUnit(whichUnit).mast.masterUnit
        endfunction
        
        function addEliteLevel takes integer k returns nothing
            local integer targetState = 0
            local integer bonusedState = GetStoredInteger(gameCache,"DATAS","HERO_"+I2S(k)+"_ELITE_LEVEL_BONUSED_STATES")
            set eliteLevel[k] = eliteLevel[k] + 1
            set targetState = eliteLevel[k]
            set targetState = targetState+2*(eliteLevel[k]/25)
            if eliteLevel[k] >= 5 then 
                set targetState = targetState+2
            endif 
            if eliteLevel[k] >= 10 then 
                set targetState = targetState+2
            endif 
            if eliteLevel[k] >= 15 then 
                set targetState = targetState+2
            endif 
            call SetHeroAgi(hero[k],GetHeroAgi(hero[k],false)+(targetState-bonusedState),true)
            call SetHeroStr(hero[k],GetHeroStr(hero[k],false)+(targetState-bonusedState),true)
            call SetHeroInt(hero[k],GetHeroInt(hero[k],false)+(targetState-bonusedState),true)
            call StoreInteger(gameCache,"DATAS","HERO_"+I2S(k)+"_ELITE_LEVEL_BONUSED_STATES",targetState)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\Levelup\\LevelupCaster.mdl",hero[k],"origin"))
            call BlzSetUnitName(hero[k],heroName[k]+"(|cff88aaff"+I2S(eliteLevel[k])+"|r)")
            call unitCheckState.evaluate(hero[k])
        endfunction
        function getXP takes integer xp returns nothing
            local integer k = 0
            local integer modifiedXp = 0
            local integer nowXp = 0
            if xp <= 0 then 
                return 
            endif 
            loop 
                exitwhen k >= MAX_HERO_TYPE
                if eliteLevel[k] < MAX_ELITE_LEVEL then  
                    set modifiedXp = IMaxBJ(0,R2I(I2R(xp)*50/(50+I2R(IMinBJ(eliteLevel[k]/ELITE_LEVEL_XP_MODIFIER,5)+1)*I2R(eliteLevel[k]))))
                    set nowXp = GetHeroXP(hero[k])
                    if modifiedXp+nowXp >= 2000000 then 
                        call AddHeroXP(hero[k],1500000-nowXp,false)
                        call addEliteLevel.evaluate(k)
                    else 
                        call AddHeroXP(hero[k],modifiedXp,true)
                    endif 
                endif 
                set k = k+1
            endloop
        endfunction
        function killingEnemy takes nothing returns nothing
            local integer level = UnitLevel(eventDyingUnit)
            local integer levelDiff = UnitLevel(party[0])-level
            local integer bonusXP = (level*level/2+level*2+6)*TEAM_XP_GAIN_RATE/10000
            local integer bonusGP = 1+level*level/4
            local integer unitId = GetUnitTypeId(eventDyingUnit)
            if IsUnitType(eventDyingUnit,UNIT_TYPE_SUMMONED) then 
                return 
            endif 
            if IsUnitBoss(eventDyingUnit) then 
                set bonusXP = bonusXP*5+level/10*1000
                set bonusGP = bonusGP*5+level/10
            elseif IsUnitElite(eventDyingUnit) then 
                set bonusXP = bonusXP*2
                set bonusGP = bonusGP*2
            else 
                set bonusXP = bonusXP*4/5
            endif
            if levelDiff > 0 then 
                set bonusXP = IMaxBJ(0,bonusXP*(10-3*levelDiff)/10)
            endif 
            call getXP(bonusXP)
            call SetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_GOLD)+bonusGP/2)
            call ExecuteFunc("ENEMY_KILLING_"+I2SSSS(unitId))
            call ExecuteFunc("ENEMY_LOOT_"+I2SSSS(unitId))
        endfunction
        function spawningEnemy takes nothing returns nothing
            local integer unitId = GetUnitTypeId(eventRespawningUnit)
            call ExecuteFunc("ENEMY_RESPAWNING_"+I2SSSS(unitId))
        endfunction
        
        globals 
            constant integer SLOT_WEAPON    = 0
            constant integer SLOT_OFFHAND   = 1
            constant integer SLOT_HELMET    = 2
            constant integer SLOT_ARMOR     = 3
            constant integer SLOT_BOOTS     = 4
            constant integer SLOT_AMULET    = 5
            constant integer SLOT_RING      = 6
            constant integer SLOT_HAND      = 8
            constant integer SLOT_BELT      = 9
        endglobals
        //武0，副1，头2，胸3，鞋4，项5，戒6&7，手8，腰9
        function itemType2Slot takes item i returns integer 
            local EquipType et = GetEquipType(GetItemTypeId(i))
            local integer result = -1 
            if GetItemType(i)==ITEM_TYPE_POWERUP then 
                set result =  0
            elseif GetItemType(i)==ITEM_TYPE_ARTIFACT then 
                set result =  1
            elseif GetItemType(i)==ITEM_TYPE_PERMANENT then 
                set result =  2
            elseif GetItemType(i)==ITEM_TYPE_PURCHASABLE then 
                set result =  3
            elseif GetItemType(i)==ITEM_TYPE_CAMPAIGN then 
                set result =  4
            elseif GetItemType(i)==ITEM_TYPE_UNKNOWN then 
                if et.class == 1 then 
                    set result = 5
                elseif et.class == 2 or et.class == 3 then 
                    set result = 6
                elseif et.class == 4 then 
                    set result = 8
                elseif et.class == 5 then 
                    set result = 9
                endif 
            endif
            return result
        endfunction
        //武0，副1，头2，胸3，鞋4，项5，戒6&7，手8，腰9
        function slot2BaseItem takes unit whichUnit,integer i returns integer 
            local integer partyIndex = GetPartyIndex(whichUnit)
            local integer result = 0 
            if partyIndex == -1 then 
                if whichUnit == armoury then 
                    set partyIndex = 17
                else
                    set result =  0
                    return result 
                endif 
            endif 
            if i==0 then
                set result =  'AWE0'+partyIndex
            elseif i==1 then
                set result =  'AOF0'+partyIndex
            elseif i==2 then 
                set result =  'AHE0'+partyIndex
            elseif i==3 then 
                set result =  'ARM0'+partyIndex
            elseif i==4 then 
                set result =  'ABO0'+partyIndex
            elseif i==5 then 
                set result =  'AAM0'+partyIndex
            elseif i==6 then 
                set result =  'AR10'+partyIndex
            elseif i==7 then 
                set result =  'AR20'+partyIndex
            elseif i==8 then 
                set result =  'AGL0'+partyIndex
            elseif i==9 then 
                set result =  'ABE0'+partyIndex
            endif
            set whichUnit = null 
            return result 
        endfunction

        function unitStartCooldown takes unit whichUnit,integer flag,integer cooldown returns nothing
            call SetHeroData(whichUnit,"COOLDOWN_"+I2S(flag),IMaxBJ(globalNowtime+cooldown,GetHeroData(whichUnit,"COOLDOWN_"+I2S(flag))))
            set whichUnit = null 
        endfunction
        function unitFlushCooldown takes unit whichUnit,integer flag returns nothing
            call SetHeroData(whichUnit,"COOLDOWN_"+I2S(flag),globalNowtime)
            set whichUnit = null 
        endfunction
        function unitCheckCooldown takes unit whichUnit,integer flag returns boolean
            local boolean bl = globalNowtime > GetHeroData(whichUnit,"COOLDOWN_"+I2S(flag))
            set whichUnit = null 
            return bl 
        endfunction

        function UnitImmuneStun takes unit whichUnit returns boolean
            local boolean result = unitGetAllBonusStateValue(whichUnit,STATE_IMMUNE_STUN) > 0
            set whichUnit = null 
            return result 
        endfunction
        function UnitImmuneSnare takes unit whichUnit returns boolean
            local boolean result = unitGetAllBonusStateValue(whichUnit,STATE_IMMUNE_SNARE) > 0
            set whichUnit = null 
            return result 
        endfunction
        function UnitImmuneSilence takes unit whichUnit returns boolean
            local boolean result = unitGetAllBonusStateValue(whichUnit,STATE_IMMUNE_SILENCE) > 0
            set whichUnit = null 
            return result 
        endfunction
        function UnitImmuneRoot takes unit whichUnit returns boolean
            local boolean result = unitGetAllBonusStateValue(whichUnit,STATE_IMMUNE_ROOT) > 0
            set whichUnit = null 
            return result 
        endfunction
        function UnitImmuneCold takes unit whichUnit returns boolean
            local boolean result = unitGetAllBonusStateValue(whichUnit,STATE_IMMUNE_COLD) > 0
            set whichUnit = null 
            return result 
        endfunction

        function unitSetBonusState takes unit whichUnit,string whichState,integer value returns nothing
            local integer i = State.top
            local State s = i 
            loop 
                exitwhen i == 0 
                set s = i 
                if whichState == s.name then 
                    call s.setState(whichUnit,s.defaultSumMode,value)
                    return 
                endif 
                if whichState == s.name+"_P" then 
                    call s.setState(whichUnit,STATE_MODE_PERCENTAGE,value)
                    return 
                endif 
                set i = i-1
            endloop
        endfunction
        function unitAddState takes unit whichUnit,string whichState,integer value returns nothing
            local integer i = State.top
            local State s = i 
            if value != 0 then 
                loop 
                    exitwhen i == 0 
                    set s = i 
                    if whichState == s.name then 
                        call s.addState(whichUnit,s.defaultSumMode,value)
                        return 
                    endif 
                    if whichState == s.name+"_P" then 
                        call s.addState(whichUnit,STATE_MODE_PERCENTAGE,value)
                        return 
                    endif 
                    set i = i-1
                endloop
            endif 
        endfunction

        //====================================================
        // region triggerHeroCheckState
        //====================================================
        function triggerHeroCheckState_Action_0 takes nothing returns nothing
            local integer heroId = 0
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S000',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01O',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01P',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01T',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01U',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01R',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01S',0,IMaxBJ(0,R2I(3*power+5000)/10000))

            call BlzSetUnitAbilityManaCost(hero[heroId],'S01T',1,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01U',1,IMaxBJ(0,R2I(3*power+5000)/10000))
            if HeroHaveTalent(hero[heroId],HERO_ULTIMATE_TALENT,10) then 
                call SetUnitAbilityLevel(hero[heroId],'S01T',2)
                call SetUnitAbilityLevel(hero[heroId],'S01U',2)
            else 
                call SetUnitAbilityLevel(hero[heroId],'S01T',1)
                call SetUnitAbilityLevel(hero[heroId],'S01U',1)
            endif 
        endfunction
        function triggerHeroCheckState_Action_1 takes nothing returns nothing
            local integer heroId = 1
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02S',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02T',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02U',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02V',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02W',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02X',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02Y',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02Z',0,IMaxBJ(0,R2I(10*power+5000)/10000))
        endfunction
        function triggerHeroCheckState_Action_2 takes nothing returns nothing
            local integer heroId = 2
            local mybuff bf 
            local aura au 
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02H',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02J',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02L',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03I',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03J',0,IMaxBJ(0,R2I(4*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03K',0,IMaxBJ(0,R2I(0*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03L',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03M',0,IMaxBJ(0,R2I(5*power+5000)/10000))
        endfunction
        function triggerHeroCheckState_Action_3 takes nothing returns nothing
            local integer heroId = 3
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04W',0,IMaxBJ(0,R2I(2.5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04X',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S050',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S051',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S052',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S053',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S054',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S055',0,IMaxBJ(0,R2I(10*power+5000)/10000))
        endfunction
        function triggerHeroCheckState_Action_4 takes nothing returns nothing
            local integer heroId = 4
            local mybuff bf 
            local aura au 
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S015',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S019',0,IMaxBJ(0,R2I(0.5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S018',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01A',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S016',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01C',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01D',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01B',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01B',1,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02M',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02O',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02O',1,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02P',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02Q',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02Q',1,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S05X',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            if HeroHaveTalent(hero[heroId],HERO_ULTIMATE_TALENT,12) then 
                call SetUnitAbilityLevel(hero[heroId],'S01B',2)
                call SetUnitAbilityLevel(hero[heroId],'S02O',2)
                call SetUnitAbilityLevel(hero[heroId],'S02Q',2)
            else 
                call SetUnitAbilityLevel(hero[heroId],'S01B',1)
                call SetUnitAbilityLevel(hero[heroId],'S02O',1)
                call SetUnitAbilityLevel(hero[heroId],'S02Q',1)
            endif 
        endfunction
        function triggerHeroCheckState_Action_5 takes nothing returns nothing
            local integer heroId = 5
            local mybuff bf 
            local aura au 
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03G',0,IMaxBJ(0,R2I(1.5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03N',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03O',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03P',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03Q',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03R',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03S',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03T',0,IMaxBJ(0,R2I(0*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03U',0,IMaxBJ(0,R2I(0*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03V',0,IMaxBJ(0,R2I(0*power+5000)/10000))
        endfunction
        function triggerHeroCheckState_Action_6 takes nothing returns nothing
            local integer heroId = 6
            local mybuff bf 
            local aura au 
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S002',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00A',0,IMaxBJ(0,R2I(20*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S007',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S009',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00C',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00D',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S004',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04U',0,IMaxBJ(0,R2I(15*power+5000)/10000))
        endfunction
        function triggerHeroCheckState_Action_7 takes nothing returns nothing
            local integer heroId = 7
            local mybuff bf 
            local aura au 
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00N',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00O',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00P',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00Q',0,IMaxBJ(0,R2I(7.5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00R',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00S',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S006',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00T',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00U',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00U',1,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04S',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04T',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00W',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00V',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00X',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00Y',0,IMaxBJ(0,R2I(15*power+5000)/10000))

            call BlzSetUnitAbilityManaCost(hero[heroId],'S00V',1,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00X',1,IMaxBJ(0,R2I(7.5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00Y',1,IMaxBJ(0,R2I(7.5*power+5000)/10000))
            if HeroHaveTalent(hero[heroId],HERO_PRIVATE_TALENT,2) then 
                call SetUnitAbilityLevel(hero[heroId],'S00U',2)
            else 
                call SetUnitAbilityLevel(hero[heroId],'S00U',1)
            endif 
            if HeroHaveTalent(hero[heroId],HERO_ULTIMATE_TALENT,12) then 
                call SetUnitAbilityLevel(hero[heroId],'S00V',2)
                call SetUnitAbilityLevel(hero[heroId],'S00X',2)
                call SetUnitAbilityLevel(hero[heroId],'S00Y',2)
            else 
                call SetUnitAbilityLevel(hero[heroId],'S00V',1)
                call SetUnitAbilityLevel(hero[heroId],'S00X',1)
                call SetUnitAbilityLevel(hero[heroId],'S00Y',1)
            endif 
        endfunction
        function triggerHeroCheckState_Action_8 takes nothing returns nothing
            local integer heroId = 8
            local mybuff bf 
            local aura au 
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            local integer i = 0
            local integer k = 0
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01W',0,IMaxBJ(0,R2I(4*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01X',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01Y',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01Z',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01Z',1,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S020',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S020',1,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S020',2,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S020',3,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S021',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S022',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S022',1,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S023',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S024',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S025',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S025',1,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S026',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S027',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S028',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S029',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02A',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02B',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02C',0,IMaxBJ(0,R2I(20*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02E',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02F',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02E',1,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02F',1,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S02G',0,IMaxBJ(0,R2I(10*power+5000)/10000))

            if mybuff.getUnitBuff(hero[heroId],BUFFTYPE_DRUID_CATFORM) > 0 and mybuff.getUnitBuff(hero[heroId],BUFFTYPE_DRUID_CATFORM).DESTROY == false then 
                set bf = mybuff.getUnitBuff(hero[heroId],BUFFTYPE_DRUID_CATFORM)
                set i = 0
                set k = 0
                if bf.bonusedAgi != GetUnitLevel(hero[heroId]) then 
                    set i = GetUnitLevel(hero[heroId])-bf.bonusedAgi
                    set bf.bonusAgi = GetUnitLevel(hero[heroId])
                    set bf.needRefreshState = true 
                endif 
                if bf.bonusedInt != 0-GetUnitLevel(hero[heroId]) then 
                    set k = bf.bonusedInt+GetUnitLevel(hero[heroId])
                    set bf.bonusInt = 0-GetUnitLevel(hero[heroId])
                    set bf.needRefreshState = true 
                endif 
                if bf.bonusedAttack != (GetHeroAgi(hero[heroId],true)+i)-(GetHeroInt(hero[heroId],true)-k) then 
                    set bf.bonusAttack = (GetHeroAgi(hero[heroId],true)+i)-(GetHeroInt(hero[heroId],true)-k)
                    set bf.needRefreshState = true 
                endif 
            endif 
            if mybuff.getUnitBuff(hero[heroId],BUFFTYPE_DRUID_BEARFORM) > 0 and mybuff.getUnitBuff(hero[heroId],BUFFTYPE_DRUID_BEARFORM).DESTROY == false then 
                set bf = mybuff.getUnitBuff(hero[heroId],BUFFTYPE_DRUID_BEARFORM)
                set i = 0
                set k = 0
                if bf.bonusedAgi != GetUnitLevel(hero[heroId]) then 
                    set i = GetUnitLevel(hero[heroId])-bf.bonusedAgi
                    set bf.bonusAgi = GetUnitLevel(hero[heroId])
                    set bf.needRefreshState = true 
                endif 
                if bf.bonusedInt != 0-GetUnitLevel(hero[heroId]) then 
                    set k = bf.bonusedInt+GetUnitLevel(hero[heroId])
                    set bf.bonusInt = 0-GetUnitLevel(hero[heroId])
                    set bf.needRefreshState = true 
                endif 
                if bf.bonusedAttack != (GetHeroAgi(hero[heroId],true)+i)-(GetHeroInt(hero[heroId],true)-k) then 
                    set bf.bonusAttack = (GetHeroAgi(hero[heroId],true)+i)-(GetHeroInt(hero[heroId],true)-k)
                    set bf.needRefreshState = true 
                endif 
            endif 
            
            if heroNowForm[heroId] == FORM_DRUID_NORMAL then 
                call SetUnitAbilityLevel(hero[heroId],'S01Z',2)
            else 
                call SetUnitAbilityLevel(hero[heroId],'S01Z',1)
            endif 
            if heroNowForm[heroId] == FORM_DRUID_NORMAL then 
                call SetUnitAbilityLevel(hero[heroId],'S020',1)
                call SetUnitAbilityLevel(hero[heroId],'S02D',1)
            elseif heroNowForm[heroId] == FORM_DRUID_BEAR then 
                call SetUnitAbilityLevel(hero[heroId],'S020',2)
                call SetUnitAbilityLevel(hero[heroId],'S02D',2)
            elseif heroNowForm[heroId] == FORM_DRUID_CAT then 
                call SetUnitAbilityLevel(hero[heroId],'S020',3)
                call SetUnitAbilityLevel(hero[heroId],'S02D',3)
            elseif heroNowForm[heroId] == FORM_DRUID_MOONKIN then 
                call SetUnitAbilityLevel(hero[heroId],'S020',4)
                call SetUnitAbilityLevel(hero[heroId],'S02D',4)
            else
                call SetUnitAbilityLevel(hero[heroId],'S020',1)
                call SetUnitAbilityLevel(hero[heroId],'S02D',1)
            endif 
            if HeroHaveTalent(hero[heroId],HERO_ULTIMATE_TALENT,11) then 
                call SetUnitAbilityLevel(hero[heroId],'S02D',GetUnitAbilityLevel(hero[heroId],'S02D')+4)
                call SetUnitAbilityLevel(hero[heroId],'S02E',2)
                call SetUnitAbilityLevel(hero[heroId],'S02F',2)
            else 
                call SetUnitAbilityLevel(hero[heroId],'S02E',1)
                call SetUnitAbilityLevel(hero[heroId],'S02F',1)
            endif 
            if heroNowForm[heroId] == FORM_DRUID_CAT then 
                call SetUnitAbilityLevel(hero[heroId],'S022',2)
            else 
                call SetUnitAbilityLevel(hero[heroId],'S022',1)
            endif 
            if heroNowForm[heroId] == FORM_DRUID_BEAR then 
                call SetUnitAbilityLevel(hero[heroId],'S025',2)
            else 
                call SetUnitAbilityLevel(hero[heroId],'S025',1)
            endif 
            call DruidCheckStarSurgeCharge.execute()
            call DruidCheckMoonPhase.execute()
        endfunction
        globals
            effect DK_Weapon = null 
        endglobals
        function triggerHeroCheckState_Action_9 takes nothing returns nothing
            local integer heroId = 9
            local mybuff bf 
            local aura au 
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            local integer i = 0
            local integer k = 0
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S033',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S034',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S035',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S036',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S037',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S038',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S039',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03A',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03B',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03C',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03D',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03E',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03F',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            if DK_Weapon == null and hero[heroId] != null and (GetOwningPlayer(hero[heroId]) == PLAYER or GetOwningPlayer(hero[heroId]) == PLAYER2) then 
                set DK_Weapon = AddSpecialEffectTargetEX("war3campImported\\HauntedSword2.mdx",hero[heroId],"hand right")
            endif 
        endfunction
        function triggerHeroCheckState_Action_10 takes nothing returns nothing
            local integer heroId = 10
            local real ap
            local real p 
            local mybuff bf 
            local string s 
            local aura au 
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            if GetUnitAbilityLevel(hero[heroId],'S05I') > 0 then 
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05J',0,0)
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05L',0,0)
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05N',0,0)
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05O',0,0)
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05P',0,0)
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05R',0,0)
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05S',0,0)
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05U',0,0)
            else 
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05J',0,IMaxBJ(0,R2I(2*power+5000)/10000))
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05L',0,IMaxBJ(0,R2I(10*power+5000)/10000))
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05N',0,IMaxBJ(0,R2I(10*power+5000)/10000))
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05O',0,IMaxBJ(0,R2I(20*power+5000)/10000))
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05P',0,IMaxBJ(0,R2I(10*power+5000)/10000))
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05R',0,IMaxBJ(0,R2I(15*power+5000)/10000))
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05S',0,IMaxBJ(0,R2I(25*power+5000)/10000))
                call BlzSetUnitAbilityManaCost(hero[heroId],'S05U',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            endif 

            if GetUnitAbilityLevel(hero[heroId],'S05K') > 0 then 
                set ap = I2R(ST_ABILITY_POWER.getTotalState(hero[heroId]))
                set p = 1+ap/(4*I2R(UnitLevel(hero[heroId]))+0.01*GetUnitState(hero[heroId],UNIT_STATE_MAX_MANA))
                if HeroHaveTalent(hero[heroId],HERO_PRIVATE_TALENT,1) then 
                    set p = p+0.5
                endif 
                set s = R2S(p)
                set s = SubString(s,0,StringLength(s)-1)
                call BlzSetAbilityExtendedTooltip('S05K',"|cffadadff冷却时间：|r15秒\n激活法力护盾，使你可以在受到伤害后，用法力抵抗至多50%%的任何伤害。\n每点法力最多可以抵抗|cffffcc001+法术强度/(英雄等级×4+法力上限×0.01)|r点伤害。\n当前吸收效率：|cff1eff00"+s+"|r",0)
                call BlzSetAbilityActivatedExtendedTooltip('S05K',"|cffadadff冷却时间：|r15秒\n取消法力护盾以停止消耗法力，并恢复因抵抗伤害而损耗法力的50%%。\n当前吸收效率：|cff1eff00"+s+"|r",0)
            endif 
            if GetUnitAbilityLevel(hero[heroId],'S05V') > 0 then 
                set ap = I2R(ST_ABILITY_POWER.getTotalState(hero[heroId]))
                set p = 1+ap/(4*I2R(UnitLevel(hero[heroId]))+0.01*GetUnitState(hero[heroId],UNIT_STATE_MAX_MANA))
                set s = R2S(p)
                set s = SubString(s,0,StringLength(s)-1)
                call BlzSetAbilityExtendedTooltip('S05V',"|cffadadff冷却时间：|r30秒\n将所有法力转化为护盾，每点法力可以转换为|cffffcc001+法术强度/(英雄等级×4+法力上限×0.01)|r的护盾值，持续15秒。\n效果消失时，剩余的吸收量会重新返还为法力。\n当前转化效率：|cff1eff00"+s+"|r\n|cff888888护盾|r",0)
            endif 

            if HeroHaveTalent(hero[heroId],HERO_PRIVATE_TALENT,4) then 
                call SetUnitAbilityLevel(hero[heroId],'S05W',2)
            else 
                call SetUnitAbilityLevel(hero[heroId],'S05W',1)
            endif 
        endfunction
        function triggerHeroCheckState_Action_11 takes nothing returns nothing
            local minion mini 
            local integer heroId = 11
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01F',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01E',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01H',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03W',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03X',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01G',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03Y',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03Z',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04P',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S03H',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S040',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S041',0,IMaxBJ(0,R2I(20*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04Q',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S042',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S043',0,IMaxBJ(0,R2I(20*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S044',0,IMaxBJ(0,R2I(20*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04R',0,IMaxBJ(0,R2I(20*power+5000)/10000))
        endfunction
        function triggerHeroCheckState_Action_12 takes nothing returns nothing
            local minion mini 
            local integer heroId = 12
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00Z',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S010',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S011',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S012',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S013',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S014',0,IMaxBJ(0,R2I(20*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01I',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01J',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01K',0,IMaxBJ(0,R2I(20*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01L',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01M',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S01N',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04V',0,IMaxBJ(0,R2I(20*power+5000)/10000))
        endfunction
        function triggerHeroCheckState_Action_13 takes nothing returns nothing
            local integer heroId = 13
            local mybuff bf 
            local aura au 
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S056',0,IMaxBJ(0,R2I(1.5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S058',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S059',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S05A',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S05B',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S05D',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S05E',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S05F',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S05G',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S05H',0,IMaxBJ(0,R2I(15*power+5000)/10000))

            call BlzSetUnitAbilityManaCost(hero[heroId],'S058',1,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S059',1,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S05A',1,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S05H',1,IMaxBJ(0,R2I(15*power+5000)/10000))
            if HeroHaveTalent(hero[heroId],HERO_PRIVATE_TALENT,4) then 
                call SetUnitAbilityLevel(hero[heroId],'S058',2)
                call SetUnitAbilityLevel(hero[heroId],'S059',2)
                call SetUnitAbilityLevel(hero[heroId],'S05A',2)
            else 
                call SetUnitAbilityLevel(hero[heroId],'S058',1)
                call SetUnitAbilityLevel(hero[heroId],'S059',1)
                call SetUnitAbilityLevel(hero[heroId],'S05A',1)
            endif 
            if HeroHaveTalent(hero[heroId],HERO_ULTIMATE_TALENT,9) then 
                call SetUnitAbilityLevel(hero[heroId],'S05H',2)
            else 
                call SetUnitAbilityLevel(hero[heroId],'S05H',1)
            endif 
        endfunction
        function triggerHeroCheckState_Action_14 takes nothing returns nothing
            local integer heroId = 14
            local mybuff bf 
            local aura au 
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            local real haste = 1
            if unitGetBonusState(hero[heroId],STATE_HASTE) >= 0 then 
                set haste = 10000/(10000+I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))
            else 
                set haste = (10000-I2R(unitGetBonusState(hero[heroId],STATE_HASTE)))/10000
            endif 
            call BlzSetUnitAbilityManaCost(hero[heroId],'S046',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S047',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S048',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S049',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04A',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04C',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04D',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04E',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04F',0,IMaxBJ(0,R2I(3*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04H',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04I',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04J',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04K',0,IMaxBJ(0,R2I(5*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04L',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04M',0,IMaxBJ(0,R2I(10*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04N',0,IMaxBJ(0,R2I(25*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S04O',0,IMaxBJ(0,R2I(10*power+5000)/10000))
        endfunction
        function triggerHeroCheckState_Action_15 takes nothing returns nothing
            local integer heroId = 15
            local mybuff bf 
            local aura au 
            local integer cr = unitGetBonusState(hero[heroId],STATE_COST_REDUCE)
            local real power = I2R(18+GetUnitLevel(hero[heroId]))/19*(1+I2R(eliteLevel[heroId])/100)*I2R(10000-cr)
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00G',0,IMaxBJ(0,R2I(2*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00H',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00I',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S008',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00M',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00B',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00E',0,IMaxBJ(0,R2I(15*power+5000)/10000))
            call BlzSetUnitAbilityManaCost(hero[heroId],'S00L',0,IMaxBJ(0,R2I(25*power+5000)/10000))
        endfunction
        //====================================================
        // endregion
        //====================================================

        function DELAY_CHECK_STATE takes nothing returns nothing
            call unitCheckState.evaluate(delayedevent.currentEvent.loadUnit("UNIT"))
        endfunction
        function delayedCheckState takes unit whichUnit returns nothing
            local delayedevent de = delayedevent.create(1,1,function DELAY_CHECK_STATE)
            call de.saveUnit("UNIT",whichUnit)
        endfunction

        function refreshMinionsState takes unit whichUnit returns nothing
            local master mast = master.getMasterByUnit(whichUnit)
            local group pick = CreateGroup()
            local delayedevent de
            call GroupAddGroup(mast.minions,pick)
            loop 
                exitwhen FirstOfGroup(pick) == null 
                set de = delayedevent.create(1,1,function DELAY_CHECK_STATE)
                call de.saveUnit("UNIT",FirstOfGroup(pick))
                call GroupRemoveUnit(pick,FirstOfGroup(pick))
            endloop
            call DestroyGroup(pick)
            set pick = null 
        endfunction
        function unitCheckState takes unit whichUnit returns nothing
            call State.checkAll.evaluate(whichUnit)
        endfunction

        function DELAYED_ORDER_TARGET takes nothing returns nothing
            local delayedevent de = delayedevent.currentEvent
            call IssueTargetOrderById(de.loadUnit("SOURCE"),de.loadInteger("ORDER"),de.loadUnit("TARGET"))
        endfunction

        struct delayedevent
            static hashtable Hashtable = InitHashtable()
            static delayedevent currentEvent
            static thistype top = 0

            integer timePeriod      = 0
            integer lastTriggerTime = 0
            integer loopCount       = 0
            integer data            = 0
            trigger trigCallBack    = null 
            trigger trigOnEnd       = null 
            boolean DESTROY         = false 

            thistype prev = 0
            thistype next = 0
            method flushTrigs takes nothing returns nothing
                if (this.trigOnEnd != null) then
                    call DestroyTriggerEx(this.trigOnEnd)
                endif
                set this.trigOnEnd = null
                if (this.trigCallBack != null) then
                    call DestroyTriggerEx(this.trigCallBack)
                endif
                set this.trigCallBack = null
            endmethod

            static method create takes integer timePeriod,integer loopCount,code callBack returns delayedevent
                local delayedevent this = delayedevent.allocate()
                call this.flushTrigs()
                set this.lastTriggerTime = globalNowtime
                set this.timePeriod = timePeriod
                set this.loopCount = loopCount
                set this.trigCallBack = CreateTrigger()
                call TriggerAddActionEx(this.trigCallBack,callBack)
                set this.prev = this.top 
                if this.prev != 0 then 
                    set this.prev.next = this 
                endif 
                set thistype.top = this 
                set this.next = 0
                return this 
            endmethod

            method addOnEnd takes code callBack returns nothing
                if this.trigOnEnd == null then 
                    set this.trigOnEnd = CreateTrigger()
                endif 
                call TriggerAddActionEx(this.trigOnEnd,callBack)
            endmethod
            method saveInteger takes string keyword,integer data returns nothing
                call SaveInteger(delayedevent.Hashtable,this,StringHash(keyword),data)
            endmethod
            method saveReal takes string keyword,real data returns nothing
                call SaveReal(delayedevent.Hashtable,this,StringHash(keyword),data)
            endmethod
            method saveBoolean takes string keyword,boolean data returns nothing
                call SaveBoolean(delayedevent.Hashtable,this,StringHash(keyword),data)
            endmethod
            method saveString takes string keyword,string data returns nothing
                call SaveStr(delayedevent.Hashtable,this,StringHash(keyword),data)
            endmethod
            method saveUnit takes string keyword,unit data returns nothing
                call SaveUnitHandle(delayedevent.Hashtable,this,StringHash(keyword),data)
                set data = null 
            endmethod
            method saveEffect takes string keyword,effect data returns nothing
                call SaveEffectHandle(delayedevent.Hashtable,this,StringHash(keyword),data)
                set data = null 
            endmethod
            method saveGroup takes string keyword,group data returns nothing
                call SaveGroupHandle(delayedevent.Hashtable,this,StringHash(keyword),data)
                set data = null 
            endmethod
            method saveItem takes string keyword,item data returns nothing
                call SaveItemHandle(delayedevent.Hashtable,this,StringHash(keyword),data)
                set data = null 
            endmethod
            method saveLightning takes string keyword,lightning data returns nothing
                call SaveLightningHandle(delayedevent.Hashtable,this,StringHash(keyword),data)
                set data = null 
            endmethod
            method saveTextTag takes string keyword,texttag data returns nothing
                call SaveTextTagHandle(delayedevent.Hashtable,this,StringHash(keyword),data)
                set data = null 
            endmethod

            method loadInteger takes string keyword returns integer
                return LoadInteger(delayedevent.Hashtable,this,StringHash(keyword))
            endmethod
            method loadReal takes string keyword returns real
                return LoadReal(delayedevent.Hashtable,this,StringHash(keyword))
            endmethod
            method loadBoolean takes string keyword returns boolean
                return LoadBoolean(delayedevent.Hashtable,this,StringHash(keyword))
            endmethod
            method loadString takes string keyword returns string
                return LoadStr(delayedevent.Hashtable,this,StringHash(keyword))
            endmethod
            method loadUnit takes string keyword returns unit
                return LoadUnitHandle(delayedevent.Hashtable,this,StringHash(keyword))
            endmethod
            method loadLightning takes string keyword returns lightning
                return LoadLightningHandle(delayedevent.Hashtable,this,StringHash(keyword))
            endmethod
            method loadEffect takes string keyword returns effect
                return LoadEffectHandle(delayedevent.Hashtable,this,StringHash(keyword))
            endmethod
            method loadGroup takes string keyword returns group
                return LoadGroupHandle(delayedevent.Hashtable,this,StringHash(keyword))
            endmethod
            method loadItem takes string keyword returns item
                return LoadItemHandle(delayedevent.Hashtable,this,StringHash(keyword))
            endmethod
            method loadTextTag takes string keyword returns texttag
                return LoadTextTagHandle(delayedevent.Hashtable,this,StringHash(keyword))
            endmethod

            method update takes nothing returns nothing
                if globalNowtime-this.lastTriggerTime >= this.timePeriod then 
                    set this.lastTriggerTime = globalNowtime
                    set this.loopCount = this.loopCount-1
                    set delayedevent.currentEvent = this 
                    if delayedevent.currentEvent.trigCallBack != null then 
                        call TriggerExecute(delayedevent.currentEvent.trigCallBack)
                    endif 
                    set delayedevent.currentEvent = 0
                    if this.loopCount==0 then 
                        set this.DESTROY = true 
                    endif 
                endif
            endmethod

            static method updateAll takes nothing returns nothing
                local thistype this = thistype.top
                local thistype prev
                loop
                    exitwhen this == 0
                    set prev=this.prev
                    call this.update()
                    if this.DESTROY then
                        call this.destroy()
                    endif
                    set this=prev
                endloop
            endmethod

            method onDestroy takes nothing returns nothing
                local thistype prev 
                local thistype next 
                local trigger endTrig = this.trigOnEnd

                set prev = this.prev 
                set next = this.next 
                if endTrig != null then 
                    set delayedevent.currentEvent = this 
                    call TriggerExecute(endTrig)
                    set delayedevent.currentEvent = 0
                endif 
                //call BJDebugMsg("DE destroy "+I2S(this)+" onEnd="+I2S(GetHandleId(this.trigOnEnd)))
                call FlushChildHashtable(delayedevent.Hashtable,this)
                
                if prev > 0 then 
                    set prev.next = next 
                endif 
                if next > 0 then 
                    set next.prev = prev 
                endif 
                if this == thistype.top then 
                    set thistype.top = prev 
                endif 
                call this.flushTrigs()
                set endTrig = null 
            endmethod

            static method onInit takes nothing returns nothing
                call TimerStart(CreateTimer(),0.01,true,function thistype.updateAll)
            endmethod
        endstruct
        
        //======================================================================
        // 创建延迟事件：period：周期；times：执行次数，0为无限执行；func：回调函数
        //======================================================================
        function CreateDelayedEvent takes integer period,integer times,code func returns delayedevent
            return delayedevent.create(period,times,func)
        endfunction

        //====================================================
        // region delayedDoThings
        //====================================================

        function DELAYED_HIDE_UNIT takes nothing returns nothing
            local delayedevent de = delayedevent.currentEvent
            local integer alpha = de.loadInteger("ALPHA")
            local integer time = de.loadInteger("TIME")
            local boolean flag = de.loadBoolean("FLAG")
            local integer nowTime = de.loopCount
            if de.loadUnit("UNIT") == null then 
                set de.DESTROY = true 
                return 
            endif 
            set alpha = alpha*nowTime/time
            call SetUnitVertexColor(de.loadUnit("UNIT"),BlzGetUnitIntegerField(de.loadUnit("UNIT"),UNIT_IF_TINTING_COLOR_RED),BlzGetUnitIntegerField(de.loadUnit("UNIT"),UNIT_IF_TINTING_COLOR_GREEN),BlzGetUnitIntegerField(de.loadUnit("UNIT"),UNIT_IF_TINTING_COLOR_BLUE),alpha)
            if nowTime <= 0 and flag then 
                call ShowUnit(de.loadUnit("UNIT"),false)
            endif 
        endfunction
        function delayedHideUnit takes unit whichUnit,integer time,boolean hide returns nothing
            local delayedevent de = delayedevent.create(1,time,function DELAYED_HIDE_UNIT)
            call de.saveUnit("UNIT",whichUnit)
            call de.saveInteger("ALPHA",BlzGetUnitIntegerField(whichUnit,UNIT_IF_TINTING_COLOR_ALPHA))
            call de.saveInteger("TIME",time)
            call de.saveBoolean("FLAG",hide)
            set whichUnit = null 
        endfunction

        function DELAYED_SHOW_UNIT takes nothing returns nothing
            local delayedevent de = delayedevent.currentEvent
            local integer alpha = de.loadInteger("ALPHA")
            local integer time = de.loadInteger("TIME")
            local integer nowTime = de.loopCount
            if de.loadUnit("UNIT") == null then 
                set de.DESTROY = true 
                return 
            endif 
            set alpha = alpha-alpha*nowTime/time
            call SetUnitVertexColor(de.loadUnit("UNIT"),BlzGetUnitIntegerField(de.loadUnit("UNIT"),UNIT_IF_TINTING_COLOR_RED),BlzGetUnitIntegerField(de.loadUnit("UNIT"),UNIT_IF_TINTING_COLOR_GREEN),BlzGetUnitIntegerField(de.loadUnit("UNIT"),UNIT_IF_TINTING_COLOR_BLUE),alpha)
        endfunction
        function delayedShowUnit takes unit whichUnit,integer time returns nothing
            local delayedevent de = delayedevent.create(1,time,function DELAYED_SHOW_UNIT)
            call de.saveUnit("UNIT",whichUnit)
            call de.saveInteger("ALPHA",BlzGetUnitIntegerField(whichUnit,UNIT_IF_TINTING_COLOR_ALPHA))
            call de.saveInteger("TIME",time)
            call SetUnitVertexColor(whichUnit,BlzGetUnitIntegerField(de.loadUnit("UNIT"),UNIT_IF_TINTING_COLOR_RED),BlzGetUnitIntegerField(de.loadUnit("UNIT"),UNIT_IF_TINTING_COLOR_GREEN),BlzGetUnitIntegerField(de.loadUnit("UNIT"),UNIT_IF_TINTING_COLOR_BLUE),0)
            set whichUnit = null 
        endfunction


        function DELAYED_DESTROY_SFX takes nothing returns nothing
            if delayedevent.currentEvent.loadEffect("SFX") == null then 
                return 
            endif 
            call DestroyEffectEX(delayedevent.currentEvent.loadEffect("SFX"))
        endfunction
        function delayedDestroyEffect takes effect sfx,integer time returns effect
            local delayedevent de = delayedevent.create(time,1,function DELAYED_DESTROY_SFX)
            call de.saveEffect("SFX",sfx)
            set sfx = null 
            return de.loadEffect("SFX")
        endfunction
        function DELAYED_REMOVE_UNIT takes nothing returns nothing
            if delayedevent.currentEvent.loadUnit("UNIT") != null then 
                call RemoveUnit(delayedevent.currentEvent.loadUnit("UNIT"))
            endif 
        endfunction
        function delayedRemoveUnit takes unit whichUnit,integer time returns nothing
            local delayedevent de = delayedevent.create(time,1,function DELAYED_REMOVE_UNIT)
            call de.saveUnit("UNIT",whichUnit)
            set whichUnit = null 
        endfunction

        function DELAYED_REMOVE_ITEM takes nothing returns nothing
            if delayedevent.currentEvent.loadItem("ITEM") != null then 
                call RemoveItem(delayedevent.currentEvent.loadItem("ITEM"))
            endif 
        endfunction
        function delayedRemoveItem takes item whichItem,integer time returns nothing
            local delayedevent de = delayedevent.create(time,1,function DELAYED_REMOVE_ITEM)
            call de.saveItem("ITEM",whichItem)
            set whichItem = null  
        endfunction

        function DELAYED_UNIT_ADD_ITEM takes nothing returns nothing
            call UnitAddItem(delayedevent.currentEvent.loadUnit("UNIT"),delayedevent.currentEvent.loadItem("ITEM"))
        endfunction
        function delayedUnitAddItem takes unit whichUnit,item whichItem returns nothing
            local delayedevent de = delayedevent.create(1,1,function DELAYED_UNIT_ADD_ITEM)
            call de.saveUnit("UNIT",whichUnit)
            call de.saveItem("ITEM",whichItem)
        endfunction

        function DELAYED_REMOVE_UNIT_ABILITY takes nothing returns nothing
            call UnitRemoveAbility(delayedevent.currentEvent.loadUnit("UNIT"),delayedevent.currentEvent.loadInteger("ABILITY"))
        endfunction
        function delayedRemoveUnitAbility takes unit whichUnit,integer abilityId,integer time returns nothing
            local delayedevent de = delayedevent.create(time,1,function DELAYED_REMOVE_UNIT_ABILITY)
            call de.saveInteger("ABILITY",abilityId)
            call de.saveUnit("UNIT",whichUnit)
            set whichUnit = null 
        endfunction
        function DELAYED_MISSILE_LAUNCH takes nothing returns nothing
            local projectile proj = delayedevent.currentEvent.loadInteger("MISSILE")
            call proj.launch()
        endfunction
        function delayedLaunchMissile takes projectile whichProj,integer time returns nothing
            local delayedevent de = delayedevent.create(time,1,function DELAYED_MISSILE_LAUNCH)
            call de.saveInteger("MISSILE",whichProj)
        endfunction
        function DELAYED_PAUSE_UNIT takes nothing returns nothing
            call PauseUnit(delayedevent.currentEvent.loadUnit("UNIT"),false)
        endfunction
        function delayedPauseUnit takes unit whichUnit,integer time returns nothing
            local delayedevent de = delayedevent.create(time,1,function DELAYED_PAUSE_UNIT)
            call de.saveUnit("UNIT",whichUnit)
            call PauseUnit(whichUnit,true)
            set whichUnit = null 
        endfunction
        function DELAYED_PLAY_ANIMATION takes nothing returns nothing
            call SetUnitAnimation(delayedevent.currentEvent.loadUnit("UNIT"),"stand")
        endfunction
        function delayedPlayAnimation takes unit whichUnit,string anim,integer time returns nothing
            local delayedevent de = delayedevent.create(time,1,function DELAYED_PLAY_ANIMATION)
            call de.saveUnit("UNIT",whichUnit)
            call SetUnitAnimation(whichUnit,anim)
            set whichUnit = null 
        endfunction
        function DELAYED_HINT takes nothing returns nothing
            call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_HINT,delayedevent.currentEvent.loadString("TEXT"))
        endfunction
        function delayedHint takes string text,integer time returns nothing
            local delayedevent de = delayedevent.create(time,1,function DELAYED_HINT)
            call de.saveString("TEXT",text)
        endfunction
        function DELAYED_TEXT takes nothing returns nothing
            call DisplayTextToPlayer(PLAYER,0,0,delayedevent.currentEvent.loadString("TEXT"))
        endfunction
        function delayedText takes string text,integer time returns nothing
            local delayedevent de = delayedevent.create(time,1,function DELAYED_TEXT)
            call de.saveString("TEXT",text)
        endfunction
        function DELAYED_DIALOG_MSG takes nothing returns nothing
            call DisplayTextToPlayer(PLAYER,0,0,delayedevent.currentEvent.loadString("TEXT"))
            call UnitAddIndicator(delayedevent.currentEvent.loadUnit("UNIT"),174,174,255,255)
        endfunction
        function delayedDialogMsg takes unit whichUnit,string text,integer time returns nothing
            local delayedevent de = delayedevent.create(time,1,function DELAYED_DIALOG_MSG)
            call de.saveUnit("UNIT",whichUnit)
            call de.saveString("TEXT",text)
        endfunction
        function DELAYED_IMMEDIATE_ORDER takes nothing returns nothing
            call IssueImmediateOrderById(delayedevent.currentEvent.loadUnit("UNIT"),delayedevent.currentEvent.loadInteger("ORDER"))
        endfunction
        function delayedIssueImmediateOrder takes unit whichUnit,integer order,integer time returns nothing
            local delayedevent de
            if whichUnit == null or alive(whichUnit) == false then 
                return 
            endif 
            set de = delayedevent.create(time,1,function DELAYED_IMMEDIATE_ORDER)
            call de.saveUnit("UNIT",whichUnit)
            call de.saveInteger("ORDER",order)
        endfunction
        function DELAYED_TARGET_ORDER takes nothing returns nothing
            call IssueTargetOrderById(delayedevent.currentEvent.loadUnit("UNIT"),delayedevent.currentEvent.loadInteger("ORDER"),delayedevent.currentEvent.loadUnit("TARGET"))
        endfunction
        function delayedIssueTargetOrder takes unit whichUnit,integer order,unit target,integer time returns nothing
            local delayedevent de 
            if whichUnit == null or alive(whichUnit) == false or target == null or alive(target) == false then 
                return 
            endif 
            set de = delayedevent.create(time,1,function DELAYED_TARGET_ORDER)
            call de.saveUnit("UNIT",whichUnit)
            call de.saveInteger("ORDER",order)
            call de.saveUnit("TARGET",target)
        endfunction
        function DELAYED_POINT_ORDER takes nothing returns nothing
            call IssuePointOrderById(delayedevent.currentEvent.loadUnit("UNIT"),delayedevent.currentEvent.loadInteger("ORDER"),delayedevent.currentEvent.loadReal("X"),delayedevent.currentEvent.loadReal("Y"))
        endfunction
        function delayedIssuePointOrder takes unit whichUnit,integer order,real x,real y,integer time returns nothing
            local delayedevent de 
            if whichUnit == null or alive(whichUnit) == false then 
                return 
            endif 
            set de = delayedevent.create(time,1,function DELAYED_POINT_ORDER)
            call de.saveUnit("UNIT",whichUnit)
            call de.saveInteger("ORDER",order)
            call de.saveReal("X",x)
            call de.saveReal("Y",y)
        endfunction
        //====================================================
        // endregion
        //====================================================

        globals
            constant integer PROJ_DUMMY_TYPE = 'hMSL'
            group wavegroupA
            projectile waveWave
            unit waveCaster
            unit waveTarget
            unit bouncePickUnit = null 
            real ProjUpdateTick = 0.03
        endglobals

        struct projectile
            static projectile top = 0
            static projectile currentProjectile

            thistype prev               
            thistype next 
            integer maxTime             = 3000
            boolean needCurve           = true 
            boolean resetHeight         = true 
            unit dummy                  = null
            effect model                = null
            effect bindSFX_0            = null 
            effect bindSFX_1            = null 
            effect bindSFX_2            = null 
            effect bindSFX_3            = null 
            effect bindSFX_4            = null 
            effect bindSFX_5            = null 
            string model_path           = ""
            string model_attach         = "chest"
            integer intData             = 0
            real realData               = 0
            boolean boolData            = false
            boolean hit                 = false 
            boolean ifDestroy           = true 
            boolean ifFaceTarget        = true 
            boolean ifCheckPath         = false 
            boolean destroyAttach       = true 
            real attachDistance         = 0
            
            unit source                 = null
            unit target                 = null
            unit bounce_lastTarget      = null 

            real speed                  = 0
            real source_x               = 0
            real source_y               = 0
            real target_x               = 0
            real target_y               = 0
            real start_x                = 0
            real start_y                = 0
            real start_z                = 0
            real end_z                  = 0
            real x                      = 0
            real y                      = 0
            real z                      = 0

            real Wave_Radius_Start      = 0
            real Wave_Radius_Add        = 0
            group Wave_Group            = null 

            trigger trigOnHit           = null
            trigger trigOnEnd           = null 

            real bezier_x0              = 0
            real bezier_y0              = 0
            real bezier_x1              = 0 
            real bezier_y1              = 0
            real bezier_x2              = 0
            real bezier_y2              = 0

            integer bezier_points       = 0
            real curve                  = 0

            boolean UNBLOCKABLE         = false 
            boolean LAUNCH_UNIT         = false
            boolean LAUNCH_LOC          = false
            boolean TARGET_UNIT         = false
            boolean TARGET_LOC          = false
            boolean TARGET_ENEMY        = false 
            boolean TARGET_ALLY         = false 
            boolean IS_WAVE             = false
            boolean LAUNCH              = false
            boolean DESTROY             = false
            projectile COPY             = 0
            projectile COPY_FROM        = 0

            integer maxBounceLimit      = 0
            integer currentBounceCount  = 0
            group bouncedUnits          = null 
            real bounceRange            = 0
            real bounceMultiplier       = 1
            boolean bounceCheckGroup    = true 

            real bonusCrit              = 0
            real bonusCritPower         = 0 
            real bonusAccuracy          = 0
            real bonusArmorPenetration  = 0
            real bonusDamage            = 1
            real bonusHeal              = 1
            boolean bounceAble          = true 
            integer flag                = 0
            boolean tag_Arcane    = false 
            boolean tag_Cold      = false 
            boolean tag_Divine    = false 
            boolean tag_Earth     = false 
            boolean tag_Fire      = false 
            boolean tag_Shadow    = false 
            boolean tag_Lightning = false 

            static method create takes unit source returns projectile 
                local projectile this = projectile.allocate()
                set this.source = source
                set source = null 
                set this.bonusCrit              = 0
                set this.bonusCritPower         = 0 
                set this.bonusAccuracy          = 0
                set this.bonusArmorPenetration  = 0
                set this.bonusDamage            = 1
                set this.bonusHeal              = 1
                set this.flag                   = 0
                set this.maxTime                = 3000
                set this.DESTROY = false 
                set this.hit = false 
                set this.prev = thistype.top 
                set this.next = 0
                set this.resetHeight = true 
                if this.prev > 0 then 
                    set this.prev.next = this 
                endif 
                set thistype.top = this 
                //////call BJDebugMsg("create")
                return this
            endmethod

            method flushTrigs takes nothing returns nothing
                if this.COPY == 0 and this.COPY_FROM == 0 then 
                    if this.trigOnEnd != null then 
                        call DestroyTriggerEx(this.trigOnEnd)
                    endif 
                    if this.trigOnHit != null then 
                        call DestroyTriggerEx(this.trigOnHit)
                    endif
                endif 
                set this.trigOnEnd = null 
                set this.trigOnHit = null 
            endmethod

            //只能有唯一动作
            method addOnHit takes code action returns nothing
                if action == null then 
                    return 
                endif 
                if this.trigOnHit == null then 
                    set this.trigOnHit = CreateTrigger()
                else 
                    call TriggerClearActionsEx(this.trigOnHit)
                endif 
                call TriggerAddActionEx(this.trigOnHit,action)
                set action = null 
            endmethod
            //只能有唯一动作
            method addOnEnd takes code action returns nothing
                if action == null then 
                    return 
                endif 
                if this.trigOnEnd == null then 
                    set this.trigOnEnd = CreateTrigger()
                else 
                    call TriggerClearActionsEx(this.trigOnEnd)
                endif 
                call TriggerAddActionEx(this.trigOnEnd,action)
                set action = null 
            endmethod

            method bounceFilter takes group whichGroup returns unit 
                local integer i = 0
                local group copyGroup = CreateGroup()
                call GroupAddGroup(whichGroup,copyGroup)
                set bouncePickUnit = null 
                loop 
                    exitwhen FirstOfGroup(whichGroup) == null 
                    if (GetMinionOwnerUnitByUnit(FirstOfGroup(whichGroup)) == this.source or GetMinionOwnerUnitByUnit(FirstOfGroup(whichGroup)) == null) and alive(FirstOfGroup(whichGroup)) and ((((IsUnitAlly(FirstOfGroup(whichGroup),GetOwningPlayer(this.source)) and this.TARGET_ALLY) or (IsUnitEnemy(FirstOfGroup(whichGroup),GetOwningPlayer(this.source)) and this.TARGET_ENEMY)) and GetUnitTypeId(FirstOfGroup(whichGroup)) != 'hBNC') or (GetUnitTypeId(FirstOfGroup(whichGroup)) == 'hBNC' and minion.getMinionByUnit(FirstOfGroup(whichGroup)) > 0 and minion.getMinionByUnit(FirstOfGroup(whichGroup)).mast.masterUnit == this.source)) then
                        set i = i+1
                        if GetRandomInt(1,i) == 1 then
                            set bouncePickUnit = FirstOfGroup(whichGroup)
                        endif 
                    endif 
                    call GroupRemoveUnit(whichGroup,FirstOfGroup(whichGroup))
                endloop
                call DestroyGroup(whichGroup)
                if bouncePickUnit == null then 
                    loop 
                        exitwhen FirstOfGroup(copyGroup) == null 
                        if alive(FirstOfGroup(copyGroup)) and ((((IsUnitAlly(FirstOfGroup(copyGroup),GetOwningPlayer(this.source)) and this.TARGET_ALLY) or (IsUnitEnemy(FirstOfGroup(copyGroup),GetOwningPlayer(this.source)) and this.TARGET_ENEMY)) and GetUnitTypeId(FirstOfGroup(copyGroup)) != 'hBNC') or (GetUnitTypeId(FirstOfGroup(copyGroup)) == 'hBNC' and minion.getMinionByUnit(FirstOfGroup(copyGroup)) > 0 and minion.getMinionByUnit(FirstOfGroup(copyGroup)).mast.masterUnit == this.source)) then
                            set i = i+1
                            if GetRandomInt(1,i) == 1 then
                                set bouncePickUnit = FirstOfGroup(copyGroup)
                            endif 
                        endif 
                        call GroupRemoveUnit(copyGroup,FirstOfGroup(copyGroup))
                    endloop
                endif 
                call DestroyGroup(copyGroup)
                set copyGroup = null 
                set whichGroup = null 
                return bouncePickUnit
            endmethod

            method copy takes nothing returns thistype
                local thistype newProj          = thistype.create(this.source)
                set newProj.model_path          = this.model_path 
                set newProj.model_attach        = this.model_attach
                set newProj.speed               = this.speed
                set newProj.curve               = this.curve
                set newProj.trigOnEnd           = this.trigOnEnd
                set newProj.trigOnHit           = this.trigOnHit
                set this.COPY                   = newProj
                set newProj.COPY_FROM           = this 

                if this.bouncedUnits != null then 
                    set newProj.bouncedUnits = CreateGroup()
                endif 
                set newProj.realData            = this.realData
                set newProj.boolData            = this.boolData
                set newProj.intData             = this.intData
                set newProj.bounceRange         = this.bounceRange
                set newProj.currentBounceCount  = this.currentBounceCount
                set newProj.maxBounceLimit      = this.maxBounceLimit
                set newProj.UNBLOCKABLE         = this.UNBLOCKABLE
                set newProj.bonusCrit              = this.bonusCrit
                set newProj.bonusCritPower         = this.bonusCritPower
                set newProj.bonusAccuracy          = this.bonusAccuracy
                set newProj.bonusArmorPenetration  = this.bonusArmorPenetration
                set newProj.bonusDamage            = this.bonusDamage
                set newProj.bonusHeal              = this.bonusHeal
                set newProj.bounceMultiplier    = this.bounceMultiplier
                set newProj.flag                = this.flag
                set newProj.IS_WAVE             = this.IS_WAVE
                set newProj.Wave_Radius_Add     = this.Wave_Radius_Add
                set newProj.Wave_Radius_Start   = this.Wave_Radius_Start
                set newProj.tag_Arcane    = this.tag_Arcane
                set newProj.tag_Cold      = this.tag_Cold
                set newProj.tag_Divine    = this.tag_Divine
                set newProj.tag_Earth     = this.tag_Earth
                set newProj.tag_Fire      = this.tag_Fire
                set newProj.tag_Shadow    = this.tag_Shadow
                set newProj.tag_Lightning = this.tag_Lightning
                set newProj.LAUNCH_LOC          = this.LAUNCH_LOC
                set newProj.LAUNCH_UNIT         = this.LAUNCH_UNIT
                set newProj.TARGET_UNIT         = this.TARGET_UNIT
                set newProj.TARGET_LOC          = this.TARGET_LOC
                return newProj
            endmethod

            method bounce takes nothing returns nothing
                local thistype newProj
                local unit lastTarget = null
                local group pick = null
                // ===== 不可重入保护 =====
                if this.DESTROY == false then
                    return
                endif
                if this.hit == false then
                    return
                endif
                set newProj = this.copy()
                set lastTarget = this.target
                set pick = CreateGroup()
                call GroupAddGroup(this.bouncedUnits,newProj.bouncedUnits)
                set newProj.currentBounceCount = newProj.currentBounceCount+1
                set newProj.source_x = this.x
                set newProj.source_y = this.y
                set newProj.LAUNCH_LOC = true 
                set newProj.LAUNCH_UNIT = false 
                set newProj.TARGET_UNIT = true 
                set newProj.TARGET_LOC = false 
                set newProj.bonusDamage = newProj.bonusDamage*newProj.bounceMultiplier
                set newProj.bonusHeal = newProj.bonusHeal*newProj.bounceMultiplier
                ////////call BJDebugMsg("BOUNCE_ACT")
                if newProj.bouncedUnits != null then 
                    call GroupAddUnit(newProj.bouncedUnits,lastTarget)
                endif 
                call GroupEnumUnitsInRange(pick,newProj.source_x,newProj.source_y,newProj.bounceRange,groupEnumLegal_ProjBounce)
                call GroupRemoveUnit(pick,lastTarget)
                if this.bounceCheckGroup then 
                    call GroupRemoveGroup(newProj.bouncedUnits,pick)
                endif 
                set newProj.target = null 
                set newProj.bounce_lastTarget = lastTarget
                set newProj.target = this.bounceFilter(pick)
                if newProj.target != null then 
                    //////call BJDebugMsg("|cffffcc00bounce success|r")
                    call newProj.launch()
                else 
                    //////call BJDebugMsg("|cffffcc00bounce fall|r")
                    set newProj.DESTROY = true 
                    set newProj.currentBounceCount = newProj.maxBounceLimit
                    //call newProj.destroy()
                endif 
                set pick = null 
                set lastTarget = null 
            endmethod

            method onDestroy takes nothing returns nothing
                local projectile p
                if this <= 0 then 
                    return 
                endif 
                // ===== 不可重入保护 =====
                if this.DESTROY == false then
                    // 理论上不应发生，但保险
                    return
                endif
                set projectile.currentProjectile = this 
                if this.IS_WAVE==false then
                    if this.hit then 
                        //////call BJDebugMsg("hit")
                        if this.ifDestroy then 
                            call MissileHit.execute()
                        endif 
                        call ProjectileRunHitFunction.execute()
                    endif 
                    if this.maxBounceLimit > 0 and this.bounceAble and this.ifDestroy then 
                        if this.hit and this.maxBounceLimit > this.currentBounceCount then 
                            //////call BJDebugMsg("bounce")
                            set this.bounceAble = false
                            call this.bounce()
                        endif
                    endif 
                    call DestroyGroup(this.bouncedUnits)
                    set this.bouncedUnits = null 
                    call ProjectileRunDeathFunction.execute()
                else 
                    call ProjectileRunDeathFunction.execute()
                    call DestroyGroup(this.Wave_Group)
                    set this.Wave_Group = null 
                endif
                set projectile.currentProjectile = 0

                call this.flushTrigs()

                if this.COPY != 0 and this.COPY_FROM != 0 then 
                    set this.COPY.COPY_FROM = this.COPY_FROM
                    set this.COPY_FROM.COPY = this.COPY
                elseif this.COPY != 0 and this.COPY_FROM == 0 then
                    set this.COPY.COPY_FROM = 0
                elseif this.COPY_FROM != 0 and this.COPY == 0 then 
                    set this.COPY_FROM.COPY = 0
                endif 

                if this == thistype.top then 
                    set thistype.top = this.prev
                endif 
                if this.next > 0 then 
                    set this.next.prev = this.prev 
                endif 
                if this.prev > 0 then 
                    set this.prev.next = this.next 
                endif 

                if destroyAttach then 
                    call DestroyEffectEX(this.model)
                endif 
                call DestroyEffectEX(this.bindSFX_0)
                call DestroyEffectEX(this.bindSFX_1)
                call DestroyEffectEX(this.bindSFX_2)
                call DestroyEffectEX(this.bindSFX_3)
                call DestroyEffectEX(this.bindSFX_4)
                call DestroyEffectEX(this.bindSFX_5)
                if this.ifDestroy then 
                    call KillUnit(this.dummy)
                elseif this.resetHeight then 
                    call SetUnitFlyHeight(this.dummy,GetUnitDefaultFlyHeight(this.dummy),0)
                endif 
                //////call BJDebugMsg("|cff00ff00destroy success|r")

                set this.dummy = null
                set this.model = null
                set this.source = null
                set this.target = null
                set this.bouncedUnits = null 
                set this.bounce_lastTarget = null 
            endmethod

            method launch takes nothing returns nothing
                local real a
                //////call BJDebugMsg("|cffff0000launch 0|r")
                if this.source==null or (this.TARGET_UNIT and this.target==null) or (this.LAUNCH_LOC==false and this.LAUNCH_UNIT==false) or (this.TARGET_LOC==false and this.TARGET_UNIT==false) then
                    call this.destroy()
                    return
                endif
                if this.LAUNCH_UNIT then
                    set this.source_x = GetUnitX(this.source)
                    set this.source_y = GetUnitY(this.source)
                endif
                if this.TARGET_UNIT then
                    set this.target_x = GetUnitX(this.target)
                    set this.target_y = GetUnitY(this.target)
                    if GetUnitTypeId(this.target) != 'hBNC' then 
                        if IsUnitEnemy(this.target,GetOwningPlayer(this.source)) then 
                            set this.TARGET_ENEMY = true 
                        else    
                            set this.TARGET_ALLY = true 
                        endif 
                    endif 
                endif
                //////call BJDebugMsg("|cffff0000launch 1|r")
                set projectile.currentProjectile = this 
                set a = AngleByXY(this.source_x,this.source_y,this.target_x,this.target_y)/57.2956
                set this.source_x = this.source_x+this.start_x*Cos(a)-this.start_y*Sin(a)
                set this.source_y = this.source_y+this.start_x*Sin(a)+this.start_y*Cos(a)
                set this.dummy = CreateUnit(GetOwningPlayer(this.source),PROJ_DUMMY_TYPE,this.source_x,this.source_y,AngleByXY(this.source_x,this.source_y,this.target_x,this.target_y))
                call MissileLaunch.execute()
                if this.TARGET_UNIT and this.bounceAble and this.ifDestroy then 
                    if this.bouncedUnits == null then 
                        set this.bouncedUnits           = CreateGroup()
                    endif 
                endif 
                if this.LAUNCH_UNIT then
                    set this.start_z = this.start_z+GetUnitDefaultFlyHeight(this.source)
                endif
                call SetUnitFlyHeight(this.dummy,this.start_z,0)
                call SetUnitTimeScale(this.dummy,12.5)
                call UnitAddAbility(this.dummy,'Arav')
                call UnitRemoveAbility(this.dummy,'Arav')
                set this.z = this.start_z
                set this.x = this.source_x 
                set this.y = this.source_y
                if this.IS_WAVE then
                    set this.Wave_Group = CreateGroup()
                endif
                set this.model = AddSpecialEffectTargetEX(this.model_path,this.dummy,this.model_attach)
                set this.LAUNCH = true
                //////call BJDebugMsg("|cffff0000launch 2|r")
                if this.bounce_lastTarget == null then 
                    set this.bounce_lastTarget = this.source
                endif 
                set projectile.currentProjectile = 0
            endmethod

            method launchWithDummy takes unit dummy,boolean ifDestroy returns nothing
                local real a
                local real z 
                //////call BJDebugMsg("|cffff0000launch 0|r")
                if this.source==null or (this.TARGET_UNIT and this.target==null) or (this.LAUNCH_LOC==false and this.LAUNCH_UNIT==false) or (this.TARGET_LOC==false and this.TARGET_UNIT==false) then
                    call this.destroy()
                    return
                endif
                set this.dummy = dummy 
                set this.ifDestroy = ifDestroy
                set this.source_x = GetUnitX(dummy)
                set this.source_y = GetUnitY(dummy)
                if this.TARGET_UNIT then
                    set this.target_x = GetUnitX(this.target)
                    set this.target_y = GetUnitY(this.target)
                    if GetUnitTypeId(this.target) != 'hBNC' then 
                        if IsUnitEnemy(this.target,GetOwningPlayer(this.source)) then 
                            set this.TARGET_ENEMY = true 
                        else    
                            set this.TARGET_ALLY = true 
                        endif 
                    endif 
                endif
                if this.TARGET_UNIT and this.bounceAble and this.ifDestroy then 
                    if this.bouncedUnits == null then 
                        set this.bouncedUnits           = CreateGroup()
                    endif 
                endif 
                //////call BJDebugMsg("|cffff0000launch 1|r")
                set a = AngleByXY(this.source_x,this.source_y,this.target_x,this.target_y)/57.2956
                set this.start_z = this.start_z+GetUnitDefaultFlyHeight(this.dummy)
                call SetUnitFlyHeight(this.dummy,this.start_z,0)
                call UnitAddAbility(this.dummy,'Arav')
                call UnitRemoveAbility(this.dummy,'Arav')
                set this.z = this.start_z
                set this.x = this.source_x 
                set this.y = this.source_y
                if this.IS_WAVE then
                    set this.Wave_Group = CreateGroup()
                endif
                set this.model = AddSpecialEffectTargetEX(this.model_path,this.dummy,this.model_attach)
                set this.LAUNCH = true
            endmethod

            method update takes nothing returns nothing
                local real tarx 
                local real tary 
                local real nowx = GetUnitX(this.dummy)
                local real nowy = GetUnitY(this.dummy)
                local real nowz = this.z
                local real nextx 
                local real nexty
                local real nextz
                local real a
                local real dist
                local real t
                local real maxdis
                local real nowdis
                local real tarz = 0
                set this.maxTime = this.maxTime-1
                // ===== 安全保护：达到最大时间 =====
                if this.maxTime < 0 then 
                    set this.DESTROY = true 
                endif 
                // ===== 安全保护：接近地图边界 =====
                if nowx > GetRectMaxX(wholeMapRect)-32 or nowx < GetRectMinX(wholeMapRect)+32 or nowy > GetRectMaxY(wholeMapRect)-32 or nowy < GetRectMinY(wholeMapRect)+32 then 
                    set this.DESTROY = true 
                endif 
                // ===== 安全保护：dummy 丢失 =====
                if this.dummy == null or GetUnitTypeId(this.dummy) == 0 then
                    set this.DESTROY = true
                    return
                endif   
                if this.DESTROY then
                    return
                endif

                // ===== TARGET_UNIT 但 target 已失效 =====
                if this.TARGET_UNIT and (this.target == null or alive(this.target) == false) then
                    set this.DESTROY = true
                    return
                endif
                if this.TARGET_UNIT then
                    set tarx = GetUnitX(this.target)
                    set tary = GetUnitY(this.target)
                    set tarz = GetUnitFlyHeight(this.target)
                else
                    set tarx = this.target_x
                    set tary = this.target_y
                endif
                set a = AngleByXY(this.x,this.y,tarx,tary)/57.2956
                set nextx = this.x+this.speed*ProjUpdateTick*Cos(a)
                set nexty = this.y+this.speed*ProjUpdateTick*Sin(a)
                if nextx < GetRectMinX(wholeMapRect)+32 or nextx > GetRectMaxX(wholeMapRect)-32 or nexty < GetRectMinY(wholeMapRect)+32 or nexty > GetRectMaxY(wholeMapRect)-32 then 
                    set this.DESTROY = true 
                    return 
                endif 
                if this.speed-1 < 0 then 
                    set this.DESTROY = true 
                    return 
                endif   
                set maxdis = DisByXY(this.source_x,this.source_y,tarx,tary)
                if maxdis-1 < 0 then
                    set this.DESTROY = true
                    set this.hit = this.TARGET_UNIT
                    return
                endif
                set nowdis = DisByXY(nextx,nexty,tarx,tary)
                ////////////call BJDebugMsg(R2S(nowdis))
                if this.IS_WAVE and this.Wave_Radius_Start-1 > 0 then 
                    set thistype.currentProjectile = this 
                    set wavegroupA = CreateGroup()
                    call GroupEnumUnitsInRangeEx(wavegroupA,GetUnitX(this.dummy),GetUnitY(this.dummy),Wave_Radius_Start,groupEnumLegal)
                    set waveWave = this 
                    set waveCaster = this.source
                    loop
                        exitwhen FirstOfGroup(wavegroupA) == null
                        if IsUnitInGroup(FirstOfGroup(wavegroupA),this.Wave_Group)==false then
                            call GroupAddUnit(this.Wave_Group,FirstOfGroup(wavegroupA))
                            set waveTarget = FirstOfGroup(wavegroupA)
                            call WaveRunHitFunction.execute()
                            set waveTarget = null
                        endif
                        call GroupRemoveUnit(wavegroupA,FirstOfGroup(wavegroupA))
                    endloop
                    set this.Wave_Radius_Start = this.Wave_Radius_Start+this.Wave_Radius_Add*ProjUpdateTick
                    call DestroyGroup(wavegroupA)
                    set wavegroupA = null 
                    set waveCaster = null 
                    set thistype.currentProjectile = 0
                endif
                if (ifCheckPath and PathCheck(nextx,nexty)) or ifCheckPath == false then 
                    if this.TARGET_UNIT then 
                        if maxdis<BlzGetUnitCollisionSize(this.target)+BlzGetUnitCollisionSize(this.dummy)+this.attachDistance+8+speed*ProjUpdateTick or nowdis<BlzGetUnitCollisionSize(this.target)+BlzGetUnitCollisionSize(this.dummy)+this.attachDistance+8+speed*ProjUpdateTick or (this.TARGET_UNIT and (this.target == null or alive(this.target)==false)) then 
                            set this.DESTROY = true
                            if this.TARGET_UNIT and this.target != null and alive(this.target) then 
                                set this.hit = true 
                            endif 
                        endif
                    else 
                        if maxdis < ProjUpdateTick*speed or nowdis < ProjUpdateTick*speed then 
                            set this.DESTROY = true
                            return
                        endif 
                    endif 
                else 
                    set this.DESTROY = true
                endif 
                set t = 1-nowdis/maxdis
                set nextz = RMinBJ(100000,maxdis*this.curve*(4*t-4*t*t)+this.start_z*(1-t)+(this.end_z+tarz)*t)
                set this.z = nextz
                call SetUnitFlyHeight(this.dummy,nextz,0)
                if GetUnitTypeId(this.dummy) == PROJ_DUMMY_TYPE and this.needCurve then 
                    call SetUnitAnimationByIndex(this.dummy,180-R2I(Atan2(DisByXY(this.x,this.y,nextx,nexty),nextz-nowz)*57.2956+0.5))
                endif 
                set this.x = nextx
                set this.y = nexty

                if this.bezier_points==3 then
                    set nextx = (1-t)*(1-t)*(1-t)*(1-t)*this.source_x+4*t*(1-t)*(1-t)*(1-t)*this.bezier_x0+6*t*t*(1-t)*(1-t)*this.bezier_x1+4*t*t*t*(1-t)*this.bezier_x2+t*t*t*t*tarx
                    set nexty = (1-t)*(1-t)*(1-t)*(1-t)*this.source_y+4*t*(1-t)*(1-t)*(1-t)*this.bezier_y0+6*t*t*(1-t)*(1-t)*this.bezier_y1+4*t*t*t*(1-t)*this.bezier_y2+t*t*t*t*tary
                elseif this.bezier_points==2 then 
                    set nextx = (1-t)*(1-t)*(1-t)*this.source_x+3*t*(1-t)*(1-t)*this.bezier_x0+3*t*t*(1-t)*this.bezier_x1+t*t*t*tarx
                    set nexty = (1-t)*(1-t)*(1-t)*this.source_y+3*t*(1-t)*(1-t)*this.bezier_y0+3*t*t*(1-t)*this.bezier_y1+t*t*t*tary
                elseif this.bezier_points==1 then
                    set nextx = (1-t)*(1-t)*this.source_x+2*t*(1-t)*this.bezier_x0+t*t*tarx
                    set nexty = (1-t)*(1-t)*this.source_y+2*t*(1-t)*this.bezier_y0+t*t*tary
                endif
                //call SetUnitFacing(this.dummy,AngleByXY(nowx,nowy,nextx,nexty))
                if ifFaceTarget then 
                    call SetUnitFacing(this.dummy,AngleByXY(nowx,nowy,tarx,tary))
                endif 
                call SetUnitX(this.dummy,nextx)
                call SetUnitY(this.dummy,nexty)
            endmethod

            method applyDamageSet takes nothing returns nothing
                set damageAddAccuracy           = this.bonusAccuracy
                set damageAddArmorPenetration   = this.bonusArmorPenetration
                set damageAddBonusDamage        = this.bonusDamage
                set damageAddCrit               = damageAddCrit+this.bonusCrit
                set damageAddCritPower          = damageAddCritPower+this.bonusCritPower
                set damageFlag                  = this.flag
                set damageTag_Arcane            = this.tag_Arcane
                set damageTag_Cold              = this.tag_Cold
                set damageTag_Fire              = this.tag_Fire
                set damageTag_Earth             = this.tag_Earth
                set damageTag_Lightning         = this.tag_Lightning
                set damageTag_Divine            = this.tag_Divine
                set damageTag_Shadow            = this.tag_Shadow
            endmethod
            method applyHealSet takes nothing returns nothing
                set healAddCrit = this.bonusCrit
                set healAddCritPower = this.bonusCritPower
                set healAddBonusHeal = this.bonusHeal
                set healFlag         = this.flag
            endmethod

            static method updateAll takes nothing returns nothing
                local thistype this = thistype.top 
                local thistype prev = 0
                loop 
                    exitwhen this == 0
                    set prev = this.prev 
                    if this.LAUNCH then 
                        call this.update()
                    endif 
                    if this.DESTROY then 
                        call this.destroy()
                    endif 
                    set this = prev 
                endloop
            endmethod

            static method onInit takes nothing returns nothing
                call TimerStart(CreateTimer(),0.03,true,function thistype.updateAll)
            endmethod
        endstruct

        //======================================================================
        // 高级击退：支持自定义速度和曲线，发射
        //======================================================================
        function KnockbackTargetEx takes unit caster, unit target, real distance, real speed, real curve returns projectile
            local projectile proj
            local real a
            local real x
            local real y
            local player p = GetOwningPlayer(caster)
            
            if target == null or not alive(target) or p == null then
                set p = null
                return 0
            endif
            
            set proj = projectile.create(target)
            set a = AngleByUnits(caster, target) / 57.2956
            set x = GetUnitX(target) + distance * Cos(a)
            set y = GetUnitY(target) + distance * Sin(a)
            
            set proj.ifCheckPath = true
            set proj.LAUNCH_UNIT = true
            set proj.TARGET_LOC = true
            set proj.ifFaceTarget = false
            set proj.target_x = x
            set proj.target_y = y 
            set proj.speed = speed
            set proj.curve = curve
            
            call proj.launchWithDummy(target, false)
            
            set p = null 
            return proj
        endfunction

        //======================================================================
        //  对点击退，发射
        //======================================================================
        function KnockbackLocEx takes unit caster, real x,real y, real speed, real curve returns projectile
            local projectile proj
            
            set proj = projectile.create(caster)
            
            set proj.ifCheckPath = true
            set proj.LAUNCH_UNIT = true
            set proj.TARGET_LOC = true
            set proj.ifFaceTarget = false 
            set proj.target_x = x
            set proj.target_y = y 
            set proj.speed = speed
            set proj.curve = curve
            
            call proj.launchWithDummy(caster, false)
            
            return proj
        endfunction


        //======================================================================
        //  冲锋（冲向目标单位方向distance距离，对点），发射
        //======================================================================
        function ChargeTargetEx takes unit caster, unit target, real distance, real waveRadius, real waveAdd, boolean checkPath, real speed, real curve, code hitFunc, code endFunc returns projectile
            local projectile proj
            local real x = GetUnitX(caster)
            local real y = GetUnitY(caster)
            local real a = AngleByUnits(caster, target)
            if caster == null or target == null or not alive(target) then
                return 0
            endif
            set x = x + distance * Cos(a / 57.2956)
            set y = y + distance * Sin(a / 57.2956)
            set proj = projectile.create(caster)
            set proj.LAUNCH_UNIT = true
            set proj.TARGET_LOC = true
            set proj.target_x = x
            set proj.target_y = y
            set proj.IS_WAVE = true
            set proj.Wave_Radius_Start = waveRadius
            set proj.Wave_Radius_Add = waveAdd
            set proj.ifCheckPath = checkPath
            set proj.ifDestroy = false
            set proj.speed = speed
            set proj.curve = curve
            call proj.addOnHit(hitFunc)
            call proj.addOnEnd(endFunc)
            call proj.launchWithDummy(caster, false)
            return proj
        endfunction

        //======================================================================
        //  冲锋（冲向目标单位，对单位），发射
        //======================================================================
        function ChargeUnit takes unit caster, unit target, real speed,real curve, real attachDist,boolean checkPath,code hitFunc, code deathFunc returns projectile
            local projectile proj

            // 基础校验
            if caster == null or target == null or alive(target) == false then
                return 0
            endif

            // 创建投射物
            set proj = projectile.create(caster)
            set proj.TARGET_UNIT     = true
            set proj.LAUNCH_UNIT     = true
            set proj.target          = target
            set proj.speed           = speed
            set proj.curve           = curve
            set proj.attachDistance  = attachDist
            set proj.ifCheckPath     = checkPath
            call proj.addOnHit(hitFunc)
            call proj.addOnEnd(deathFunc)

            // 发射（干净无痕）
            call proj.launchWithDummy(caster, false)

            return proj  // 返回 proj，外部自由 bindSFX / 动画 / 声音
        endfunction

        //======================================================================
        //  冲锋（冲向目标单位，对单位，但作为波），发射
        //======================================================================
        function ChargeUnitAsWave takes unit caster, unit target, real speed,real curve,real waveRadius,real waveAdd,real attachDist,boolean checkPath,code hitFunc, code deathFunc returns projectile
            local projectile proj

            // 基础校验
            if caster == null or target == null or alive(target) == false then
                return 0
            endif

            // 创建投射物
            set proj = projectile.create(caster)
            set proj.TARGET_UNIT     = true
            set proj.LAUNCH_UNIT     = true
            set proj.target          = target
            set proj.speed           = speed
            set proj.curve           = curve
            set proj.attachDistance  = attachDist
            set proj.ifCheckPath     = checkPath
            set proj.IS_WAVE = true
            set proj.Wave_Radius_Start = waveRadius
            set proj.Wave_Radius_Add = waveAdd
            call proj.addOnHit(hitFunc)
            call proj.addOnEnd(deathFunc)

            // 发射（干净无痕）
            call proj.launchWithDummy(caster, false)

            return proj  // 返回 proj，外部自由 bindSFX / 动画 / 声音
        endfunction

        //======================================================================
        //  通用单位对单位投射物生成，基础设置，不发射
        //======================================================================
        function CreateProjectileToUnit takes unit source, unit target,real speed,real curve,string modelPath,code hitFunc, code deathFunc returns projectile
            local projectile proj

            // 基础校验：目标存活
            if source == null or target == null or alive(target) == false then
                return 0
            endif

            // 创建投射物
            set proj = projectile.create(source)
            set proj.TARGET_UNIT     = true
            set proj.LAUNCH_UNIT     = true
            set proj.target          = target
            set proj.speed           = speed
            set proj.curve           = curve
            set proj.model_path      = modelPath
            call proj.addOnHit(hitFunc)
            call proj.addOnEnd(deathFunc)

            return proj  // 成功返回实例
        endfunction

        //======================================================================
        //  波生成，基础设置，不发射
        //======================================================================
        function CreateWave takes unit source,real tarX,real tarY,real speed,real radius,real radiusAdd,string modelPath,code hitFunc,code deathFunc returns projectile
            local projectile proj

            // 基础校验：目标存活
            if source == null then
                return 0
            endif

            // 创建投射物
            set proj = projectile.create(source)
            set proj.TARGET_LOC     = true
            set proj.LAUNCH_UNIT     = true
            set proj.target_x       = tarX
            set proj.target_y       = tarY
            set proj.speed           = speed
            set proj.Wave_Radius_Start  = radius
            set proj.Wave_Radius_Add = radiusAdd
            set proj.model_path      = modelPath
            set proj.IS_WAVE        = true 
            call proj.addOnHit(hitFunc)
            call proj.addOnEnd(deathFunc)

            return proj  // 成功返回实例
        endfunction
        //======================================================================
        //  波生成，基础设置，不发射
        //======================================================================
        function CreateWaveToTarget takes unit source,unit target,real speed,real radius,real radiusAdd,string modelPath,code hitFunc,code deathFunc returns projectile
            local projectile proj

            // 基础校验：目标存活
            if source == null then
                return 0
            endif

            // 创建投射物
            set proj = projectile.create(source)
            set proj.TARGET_UNIT     = true
            set proj.LAUNCH_UNIT     = true
            set proj.target          = target
            set proj.speed           = speed
            set proj.Wave_Radius_Start  = radius
            set proj.Wave_Radius_Add = radiusAdd
            set proj.model_path      = modelPath
            set proj.IS_WAVE        = true 
            call proj.addOnHit(hitFunc)
            call proj.addOnEnd(deathFunc)

            return proj  // 成功返回实例
        endfunction
        function CreateProjectileToLoc takes unit source, real x,real y,real speed,real curve,string modelPath,code hitFunc, code deathFunc returns projectile
            local projectile proj

            // 基础校验：目标存活
            if source == null then
                return 0
            endif

            // 创建投射物
            set proj = projectile.create(source)
            set proj.TARGET_LOC     = true
            set proj.LAUNCH_UNIT     = true
            set proj.target_x        = x
            set proj.target_y        = y
            set proj.speed           = speed
            set proj.curve           = curve
            set proj.model_path      = modelPath
            call proj.addOnHit(hitFunc)
            call proj.addOnEnd(deathFunc)

            return proj  // 成功返回实例
        endfunction
        function ProjectileRunHitFunction takes nothing returns nothing
            if projectile.currentProjectile.trigOnHit != null then 
                call TriggerExecute(projectile.currentProjectile.trigOnHit)
            endif 
        endfunction
        function ProjectileRunDeathFunction takes nothing returns nothing
            if projectile.currentProjectile.trigOnEnd != null then 
                call TriggerExecute(projectile.currentProjectile.trigOnEnd)
            endif 
        endfunction


        function WaveRunHitFunction takes nothing returns nothing
            if waveWave.trigOnHit != null then 
                call TriggerExecute(waveWave.trigOnHit)
            endif 
        endfunction

        function projectileFlush takes nothing returns nothing
            /*
            local integer i = projectile.index
            loop
                exitwhen i < 0
                if projectile.list[i].LAUNCH then
                    call projectile.list[i].update()
                endif
                //立即处理销毁
                if projectile.list[i].DESTROY then
                    call projectile.list[i].destroy()
                endif
                set i = i - 1
            endloop
            */
        endfunction

        struct bufftype 
            integer abilityId
            integer buffId
            boolean positive 
            boolean negative
            boolean dispelAble

            static method create takes integer whichAbility,integer whichBuff,boolean isPos,boolean isNeg,boolean isDispelAble returns bufftype
                local bufftype this = bufftype.allocate()
                set this.abilityId = whichAbility
                set this.buffId = whichBuff
                set this.positive = isPos
                set this.negative = isNeg 
                set this.dispelAble = isDispelAble
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,whichAbility)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,whichAbility)
                return this 
            endmethod
        endstruct
        globals
            hashtable delayedApplyHash = InitHashtable()
        endglobals
        struct mybuff
            static mybuff top = 0
            static mybuff currentBuff   = 0
            static real buffTimeScale   = 1
            static hashtable buffHashtable  = InitHashtable()

            mybuff prev 
            mybuff next 
            boolean removeWhenDeath = true
            boolean applying = false 
            // region buffSets

            unit buffSource                 = null 
            unit buffTarget                 = null 
            boolean fromAura                = false 
            integer id                      = 0
            integer buffInList              = 0
            bufftype type                   = 0
            integer periodTime              = 0
            integer lastTime                = 0
            integer remainingTime           = 0
            integer lastTriggerTime         = 0
            integer intData                 = 0
            boolean newApply                = false 
            real realData                   = 0
            boolean boolData                = false 
            effect bindSFX                  = null 
            boolean addTime                 = true 
            boolean endTick                 = true 
            boolean needRefreshState        = false 
            boolean addShield               = false 
            real addShieldMaxValue          = 0

            real shieldMaxValue             = 0
            real shieldNowValue             = 0
            real shieldBlockPercent         = 0
            boolean shieldDestroy           = false 
            real blockHealMaxValue          = 0
            real blockHealNowValue          = 0
            real blockHealBlockPercent      = 0
            boolean blockHealDestroy        = false 
            boolean checkStateWhenDestroy   = false 

            
            trigger trigBeforedamageSource
            trigger trigBeforedamageTarget 
            trigger trigPredamageSource
            trigger trigPredamageTarget
            trigger trigDamagingSource 
            trigger trigDamagingTarget
            trigger trigDamagedSource
            trigger trigDamagedTarget 
            trigger trigAfterdamageSource
            trigger trigAfterdamageTarget

            trigger trigBeforehealSource
            trigger trigBeforehealTarget 
            trigger trigPreHealSource
            trigger trigPreHealTarget
            trigger trigHealingSource 
            trigger trigHealingTarget
            trigger trigHealedSource
            trigger trigHealedTarget 
            trigger trigAfterhealSource
            trigger trigAfterhealTarget

            trigger trigAttackedSource 
            trigger trigAttackedTarget 
            trigger trigAttacking
            trigger trigMissileLaunch
            trigger trigMissileHitSource
            trigger trigMissileHitTarget 
            trigger trigSpelling 
            trigger trigPeriod 
            trigger trigEnding 

            boolean hasteAble               = false 
            boolean LAUNCH                  = false 
            boolean DESTROY                 = false 
            boolean DISPEL                  = false 

            integer bonusStr                = 0
            integer bonusStr_P              = 0
            integer bonusAgi                = 0
            integer bonusAgi_P              = 0
            integer bonusInt                = 0
            integer bonusInt_P              = 0
            integer bonusMain               = 0
            integer bonusMain_P             = 0
            integer bonusAttack             = 0
            integer bonusAttack_P           = 0
            integer bonusArmor              = 0
            integer bonusArmor_P            = 0
            integer bonusAbilityPower       = 0
            integer bonusAbilityPower_P     = 0
            integer bonusAttackSpeed        = 0
            integer bonusMoveSpeed          = 0
            integer bonusMoveSpeed_P        = 0
            integer bonusLife               = 0
            integer bonusLife_P             = 0
            integer bonusMana               = 0
            integer bonusMana_P             = 0
            integer bonusLifeRegen          = 0
            integer bonusLifeRegen_P        = 0
            integer bonusManaRegen          = 0
            integer bonusManaRegen_P        = 0
            integer bonusResistance         = 0
            integer bonusCostReduce         = 0
            integer bonusCrit               = 0
            integer bonusCritPower          = 0
            integer bonusAccuracy           = 0
            integer bonusHaste              = 0
            integer bonusEvade              = 0
            integer bonusBlock              = 0
            integer bonusBlock_P            = 0
            integer bonusArmorPenetration   = 0
            integer bonusArmorPenetration_P = 0
            integer bonusDamage             = 0
            integer bonusHeal               = 0
            integer bonusShield             = 0
            integer bonusImmune_Stun        = 0
            integer bonusImmune_Snare       = 0
            integer bonusImmune_Silence     = 0
            integer bonusImmune_Root        = 0
            integer bonusImmune_Cold        = 0
            integer bonusLeech              = 0
            integer bonusVersatility        = 0
            integer bonusMaxArmor           = 0
            integer bonusMaxResistance      = 0
            integer bonusMaxBlock           = 0
            integer bonusMaxEvade           = 0


            integer bonusedStr                = 0
            integer bonusedStr_P              = 0
            integer bonusedAgi                = 0
            integer bonusedAgi_P              = 0
            integer bonusedInt                = 0
            integer bonusedInt_P              = 0
            integer bonusedMain               = 0
            integer bonusedMain_P             = 0
            integer bonusedAttack             = 0
            integer bonusedAttack_P           = 0
            integer bonusedArmor              = 0
            integer bonusedArmor_P            = 0
            integer bonusedAbilityPower       = 0
            integer bonusedAbilityPower_P     = 0
            integer bonusedAttackSpeed        = 0
            integer bonusedMoveSpeed          = 0
            integer bonusedMoveSpeed_P        = 0
            integer bonusedLife               = 0
            integer bonusedLife_P             = 0
            integer bonusedMana               = 0
            integer bonusedMana_P             = 0
            integer bonusedLifeRegen          = 0
            integer bonusedLifeRegen_P        = 0
            integer bonusedManaRegen          = 0
            integer bonusedManaRegen_P        = 0
            integer bonusedResistance         = 0
            integer bonusedCostReduce         = 0
            integer bonusedCrit               = 0
            integer bonusedCritPower          = 0
            integer bonusedAccuracy           = 0
            integer bonusedHaste              = 0
            integer bonusedEvade              = 0
            integer bonusedBlock              = 0
            integer bonusedBlock_P            = 0
            integer bonusedArmorPenetration   = 0
            integer bonusedArmorPenetration_P = 0
            integer bonusedDamage             = 0
            integer bonusedHeal               = 0
            integer bonusedShield             = 0
            integer bonusedImmune_Stun        = 0
            integer bonusedImmune_Snare       = 0
            integer bonusedImmune_Silence     = 0
            integer bonusedImmune_Root        = 0
            integer bonusedImmune_Cold        = 0
            integer bonusedLeech              = 0
            integer bonusedVersatility        = 0
            integer bonusedMaxArmor           = 0
            integer bonusedMaxResistance      = 0
            integer bonusedMaxBlock           = 0
            integer bonusedMaxEvade           = 0

            form targetHeroNowForm            = 0
            // endregion

            method initStates takes nothing returns nothing
                set this.bonusStr                = 0
                set this.bonusStr_P              = 0
                set this.bonusAgi                = 0
                set this.bonusAgi_P              = 0
                set this.bonusInt                = 0
                set this.bonusInt_P              = 0
                set this.bonusMain               = 0
                set this.bonusMain_P             = 0
                set this.bonusAttack             = 0
                set this.bonusAttack_P           = 0
                set this.bonusArmor              = 0
                set this.bonusArmor_P            = 0
                set this.bonusAbilityPower       = 0
                set this.bonusAbilityPower_P     = 0
                set this.bonusAttackSpeed        = 0
                set this.bonusMoveSpeed          = 0
                set this.bonusMoveSpeed_P        = 0
                set this.bonusLife               = 0
                set this.bonusLife_P             = 0
                set this.bonusMana               = 0
                set this.bonusMana_P             = 0
                set this.bonusLifeRegen          = 0
                set this.bonusLifeRegen_P        = 0
                set this.bonusManaRegen          = 0
                set this.bonusManaRegen_P        = 0
                set this.bonusResistance         = 0
                set this.bonusCostReduce         = 0
                set this.bonusCrit               = 0
                set this.bonusCritPower          = 0
                set this.bonusAccuracy           = 0
                set this.bonusHaste              = 0
                set this.bonusEvade              = 0
                set this.bonusBlock              = 0
                set this.bonusBlock_P            = 0
                set this.bonusArmorPenetration   = 0
                set this.bonusArmorPenetration_P = 0
                set this.bonusDamage             = 0
                set this.bonusHeal               = 0
                set this.bonusShield             = 0
                set this.bonusImmune_Stun        = 0
                set this.bonusImmune_Snare       = 0
                set this.bonusImmune_Silence     = 0
                set this.bonusImmune_Root        = 0
                set this.bonusImmune_Cold        = 0
                set this.bonusLeech              = 0
                set this.bonusMaxArmor           = 0
                set this.bonusMaxBlock           = 0
                set this.bonusMaxEvade           = 0
                set this.bonusMaxResistance      = 0
                set this.bonusVersatility        = 0
                set this.shieldMaxValue     = 0
                call this.flushTrigs()
            endmethod

            static method getUnitBuff takes unit whichUnit,bufftype whichType returns mybuff 
                local mybuff result
                if whichUnit == null or whichType == 0 then 
                    return 0
                endif 
                set result = LoadInteger(globalHashtable,GetHandleId(whichUnit),StringHash("BUFF_"+I2S(whichType)))
                return result 
            endmethod
            static method countUnitBuff takes unit whichUnit returns integer
                local integer result = LoadInteger(mybuff.buffHashtable,GetHandleId(whichUnit),StringHash("INDEX"))
                set whichUnit = null 
                return result 
            endmethod
            static method countUnitPosBuffDispelAble takes unit whichUnit returns integer
                local integer result = LoadInteger(mybuff.buffHashtable,GetHandleId(whichUnit),StringHash("POS_COUNT"))
                set whichUnit = null 
                return result 
            endmethod
            static method countUnitNegBuffDispelAble takes unit whichUnit returns integer
                local integer result = LoadInteger(mybuff.buffHashtable,GetHandleId(whichUnit),StringHash("NEG_COUNT"))
                set whichUnit = null 
                return result 
            endmethod

            static method create takes unit source,unit target,bufftype whichType returns mybuff
                local mybuff this = mybuff.getUnitBuff(target,whichType)
                if this == 0 then 
                    set this = mybuff.allocate()
                    set this.buffSource     = source
                    set this.buffTarget     = target 
                    set this.type           = whichType
                    set this.newApply       = true 
                    set this.applying       = false 
                    set this.prev = thistype.top 
                    if this.prev > 0 then 
                        set this.prev.next = this 
                    endif 
                    set this.next = 0
                    set thistype.top = this 

                    call SaveInteger(globalHashtable,GetHandleId(target),StringHash("BUFF_"+I2S(whichType)),this)

                    call SaveInteger(mybuff.buffHashtable,GetHandleId(target),StringHash("INDEX"),mybuff.countUnitBuff(target)+1)
                    call SaveInteger(mybuff.buffHashtable,GetHandleId(target),mybuff.countUnitBuff(target),this)
                    set this.buffInList = mybuff.countUnitBuff(target)
                    if whichType.positive and whichType.dispelAble then 
                        call SaveInteger(mybuff.buffHashtable,GetHandleId(target),StringHash("POS_COUNT"),mybuff.countUnitPosBuffDispelAble(target)+1)
                    endif 
                    if whichType.negative and whichType.dispelAble then 
                        call SaveInteger(mybuff.buffHashtable,GetHandleId(target),StringHash("NEG_COUNT"),mybuff.countUnitNegBuffDispelAble(target)+1)
                    endif

                    //////////call BJDebugMsg("create:"+I2S(this)+GetAbilityName(this.type.abilityId)+" ,size:"+I2S(mybuff.index))
                else 
                    set this.buffSource     = source
                    set this.buffTarget     = target 
                    if this.applying == false then 
                        set this.newApply       = false 
                    endif 
                    set this.applying = false 
                    call this.initStates()
                    call this.flushTrigs()
                    call DestroyEffectEX(this.bindSFX)
                endif 
                if GetHeroIndex(this.buffTarget) > 0 then 
                    set this.targetHeroNowForm = heroNowForm[GetHeroIndex(this.buffTarget)-1]
                endif 
                set this.DESTROY = false 
                set source = null 
                set target = null 
                return this 
            endmethod

            method flushTrigs takes nothing returns nothing
                
                if (this.trigBeforedamageSource != null) then
                    call DestroyTriggerEx(this.trigBeforedamageSource)
                    set this.trigBeforedamageSource = null
                endif
                if (this.trigBeforedamageTarget != null) then
                    call DestroyTriggerEx(this.trigBeforedamageTarget)
                    set this.trigBeforedamageTarget = null
                endif
                if (this.trigPredamageSource != null) then
                    call DestroyTriggerEx(this.trigPredamageSource)
                    set this.trigPredamageSource = null
                endif
                if (this.trigPredamageTarget != null) then
                    call DestroyTriggerEx(this.trigPredamageTarget)
                    set this.trigPredamageTarget = null
                endif
                if (this.trigDamagingSource != null) then
                    call DestroyTriggerEx(this.trigDamagingSource)
                    set this.trigDamagingSource = null
                endif
                if (this.trigDamagingTarget != null) then
                    call DestroyTriggerEx(this.trigDamagingTarget)
                    set this.trigDamagingTarget = null
                endif
                if (this.trigDamagedSource != null) then
                    call DestroyTriggerEx(this.trigDamagedSource)
                    set this.trigDamagedSource = null
                endif
                if (this.trigDamagedTarget != null) then
                    call DestroyTriggerEx(this.trigDamagedTarget)
                    set this.trigDamagedTarget = null
                endif
                if (this.trigAfterdamageSource != null) then
                    call DestroyTriggerEx(this.trigAfterdamageSource)
                    set this.trigAfterdamageSource = null
                endif
                if (this.trigAfterdamageTarget != null) then
                    call DestroyTriggerEx(this.trigAfterdamageTarget)
                    set this.trigAfterdamageTarget = null
                endif
                if (this.trigBeforehealSource != null) then
                    call DestroyTriggerEx(this.trigBeforehealSource)
                    set this.trigBeforehealSource = null
                endif
                if (this.trigBeforehealTarget != null) then
                    call DestroyTriggerEx(this.trigBeforehealTarget)
                    set this.trigBeforehealTarget = null
                endif
                if (this.trigPreHealSource != null) then
                    call DestroyTriggerEx(this.trigPreHealSource)
                    set this.trigPreHealSource = null
                endif
                if (this.trigPreHealTarget != null) then
                    call DestroyTriggerEx(this.trigPreHealTarget)
                    set this.trigPreHealTarget = null
                endif
                if (this.trigHealingSource != null) then
                    call DestroyTriggerEx(this.trigHealingSource)
                    set this.trigHealingSource = null
                endif
                if (this.trigHealingTarget != null) then
                    call DestroyTriggerEx(this.trigHealingTarget)
                    set this.trigHealingTarget = null
                endif
                if (this.trigHealedSource != null) then
                    call DestroyTriggerEx(this.trigHealedSource)
                    set this.trigHealedSource = null
                endif
                if (this.trigHealedTarget != null) then
                    call DestroyTriggerEx(this.trigHealedTarget)
                    set this.trigHealedTarget = null
                endif
                if (this.trigAfterhealSource != null) then
                    call DestroyTriggerEx(this.trigAfterhealSource)
                    set this.trigAfterhealSource = null
                endif
                if (this.trigAfterhealTarget != null) then
                    call DestroyTriggerEx(this.trigAfterhealTarget)
                    set this.trigAfterhealTarget = null
                endif
                if (this.trigAttackedSource != null) then
                    call DestroyTriggerEx(this.trigAttackedSource)
                    set this.trigAttackedSource = null
                endif
                if (this.trigAttackedTarget != null) then
                    call DestroyTriggerEx(this.trigAttackedTarget)
                    set this.trigAttackedTarget = null
                endif
                if (this.trigAttacking != null) then
                    call DestroyTriggerEx(this.trigAttacking)
                    set this.trigAttacking = null
                endif
                if (this.trigMissileLaunch != null) then
                    call DestroyTriggerEx(this.trigMissileLaunch)
                    set this.trigMissileLaunch = null
                endif
                if (this.trigMissileHitSource != null) then
                    call DestroyTriggerEx(this.trigMissileHitSource)
                    set this.trigMissileHitSource = null
                endif
                if (this.trigMissileHitTarget != null) then
                    call DestroyTriggerEx(this.trigMissileHitTarget)
                    set this.trigMissileHitTarget = null
                endif
                if (this.trigSpelling != null) then
                    call DestroyTriggerEx(this.trigSpelling)
                    set this.trigSpelling = null
                endif
                if (this.trigPeriod != null) then
                    call DestroyTriggerEx(this.trigPeriod)
                    set this.trigPeriod = null
                endif
                if (this.trigEnding != null) then
                    call DestroyTriggerEx(this.trigEnding)
                    set this.trigEnding = null
                endif
            endmethod

            method onDestroy takes nothing returns nothing
                local integer i
                local integer k
                local integer p
                local mybuff stacktopBuff

                if this == 0 then 
                    return 
                endif 

                //0.结算结束函数
                call ExecuteEndingFunc.evaluate(this)

                //////////call BJDebugMsg("time="+I2S(globalNowtime)+" :BUFF_"+I2S(this)+":onDestroy: from"+GetUnitName(this.buffTarget)+"abilityId="+I2S(this.type.abilityId)+"  buffId="+I2S(this.type.buffId))
                if this.buffTarget != null then 
                    
                    call UnitRemoveAbility(this.buffTarget,this.type.abilityId)
                    call UnitMakeAbilityPermanent(this.buffTarget,false,this.type.abilityId)
                    call UnitRemoveAbility(this.buffTarget,this.type.buffId)
                    
                    call this.stateRemove()

                    set p = mybuff.countUnitBuff(this.buffTarget)
                    // 1. 清理单位关联的buff
                    call SaveInteger(globalHashtable, GetHandleId(this.buffTarget), StringHash("BUFF_"+I2S(this.type)), 0)
                
                    // 2. 更新单位buff列表
                    if p > 0 then
                        set stacktopBuff = LoadInteger(mybuff.buffHashtable, GetHandleId(this.buffTarget), p)
                        if stacktopBuff != 0 and stacktopBuff != this then
                            call SaveInteger(mybuff.buffHashtable, GetHandleId(this.buffTarget), this.buffInList, stacktopBuff)
                            set stacktopBuff.buffInList = this.buffInList
                        endif
                        call SaveInteger(mybuff.buffHashtable, GetHandleId(this.buffTarget), p, 0)
                        call SaveInteger(mybuff.buffHashtable, GetHandleId(this.buffTarget), StringHash("INDEX"), p-1)
                    endif
                    if this.type.positive and this.type.dispelAble then 
                        call SaveInteger(mybuff.buffHashtable,GetHandleId(this.buffTarget),StringHash("POS_COUNT"),mybuff.countUnitPosBuffDispelAble(this.buffTarget)-1)
                    endif 
                    if this.type.negative and this.type.dispelAble then 
                        call SaveInteger(mybuff.buffHashtable,GetHandleId(this.buffTarget),StringHash("NEG_COUNT"),mybuff.countUnitNegBuffDispelAble(this.buffTarget)-1)
                    endif
                    
                endif 
                // 3. 从全局列表中移除

                if this.prev > 0 then 
                    set this.prev.next = this.next 
                endif 
                if this.next > 0 then 
                    set this.next.prev = this.prev 
                endif 
                if this == thistype.top then 
                    set thistype.top = this.prev 
                endif 
            
                // 4. 清理其他数据
                if this.bindSFX != null then 
                    call DestroyEffectEX(this.bindSFX)
                endif 
                if IsUnitType(this.buffTarget,UNIT_TYPE_ANCIENT) == false and COMBAT_LOG_ON then 
                    call Preload("R|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(this.buffTarget))+"|"+I2S(GetHandleId(this.buffTarget)-1050000)+"|"+I2SSSS(this.type.abilityId))
                endif 
                set this.bindSFX = null
                set this.buffSource = null 
                set this.buffTarget = null
                call this.flushTrigs()
            endmethod

            method update takes nothing returns nothing
                local integer nowPeriodTime = this.periodTime
                local integer haste = unitGetAllBonusStateValue(this.buffSource,STATE_HASTE)
                set this.remainingTime = this.remainingTime-1
                if GetHeroIndex(this.buffTarget) > 0 then 
                    if this.targetHeroNowForm != heroNowForm[GetHeroIndex(this.buffTarget)-1] then 
                        set this.targetHeroNowForm = heroNowForm[GetHeroIndex(this.buffTarget)-1]
                        call UnitRemoveAbility(this.buffTarget,this.type.abilityId)
                        call UnitAddAbility(this.buffTarget,this.type.abilityId)
                        call UnitMakeAbilityPermanent(this.buffTarget,true,this.type.abilityId)
                    endif 
                endif 
                if this.needRefreshState then 
                    set this.needRefreshState = false 
                    set doNotCheck = true 
                    call this.refreshStates()
                    set doNotCheck = false 
                endif 
                if hasteAble then 
                    if haste >= 0 then 
                        set nowPeriodTime = nowPeriodTime*10000/(10000+haste)
                    else
                        set nowPeriodTime = nowPeriodTime*(10000-haste)/10000
                    endif
                endif 
                if this.periodTime != 0 and globalNowtime-this.lastTriggerTime >= nowPeriodTime then 
                    set this.lastTriggerTime = globalNowtime
                    if this.trigPeriod != null then 
                        set mybuff.currentBuff = this 
                        call TriggerExecute(this.trigPeriod)
                    endif   
                    //call ExecutePeriodFunc.evaluate(this)
                endif 
                if this.remainingTime <= 0 or (alive(this.buffTarget) == false and this.removeWhenDeath) or this.buffTarget == null then
                    set this.DESTROY = true 
                endif 
            endmethod

            static method destroyBuff takes nothing returns nothing
                local integer i = GetHandleId(GetExpiredTimer())
                local thistype this = LoadInteger(delayedApplyHash,i,0)
                call DestroyTimer(GetExpiredTimer())
                call this.destroy()
                call FlushChildHashtable(delayedApplyHash,i)
            endmethod

            static method updateAll takes nothing returns nothing
                local thistype this = thistype.top
                local thistype prev
                local timer t = null 
                local integer i = 0

                loop
                    exitwhen this == 0

                    set prev=this.prev

                    if this.LAUNCH then
                        call this.update()
                    endif

                    if this.DESTROY then
                        set t = CreateTimer()
                        set i = GetHandleId(t)
                        call TimerStart(t,0,false,function thistype.destroyBuff)
                        call SaveInteger(delayedApplyHash,i,0,this)
                    endif

                    set this=prev
                endloop

                set t = null 
            endmethod

            method stateRemove takes nothing returns nothing
                local boolean added = false 
                //call BJDebugMsg("BUFF STATE REMOVE !")
                if this.bonusedStr != 0 then 
                    call ST_STR.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedStr)
                    set this.bonusedStr = 0
                    set added = true
                endif 
                if this.bonusedStr_P != 0 then 
                    call ST_STR.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedStr_P)
                    set this.bonusedStr_P = 0
                    set added = true
                endif 
                if this.bonusedAgi != 0 then 
                    call ST_AGI.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedAgi)
                    set this.bonusedAgi = 0
                    set added = true
                endif 
                if this.bonusedAgi_P != 0 then 
                    call ST_AGI.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedAgi_P)
                    set this.bonusedAgi_P = 0
                    set added = true
                endif 
                if this.bonusedInt != 0 then 
                    call ST_INT.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedInt)
                    set this.bonusedInt = 0
                    set added = true
                endif 
                if this.bonusedInt_P != 0 then 
                    call ST_INT.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedInt_P)
                    set this.bonusedInt_P = 0
                    set added = true
                endif 
                if this.bonusedMain != 0 then 
                    call ST_MAIN.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedMain)
                    set this.bonusedMain = 0
                    set added = true
                endif 
                if this.bonusedMain_P != 0 then 
                    call ST_MAIN.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedMain_P)
                    set this.bonusedMain_P = 0
                    set added = true
                endif 
                if this.bonusedAttack != 0 then 
                    call ST_ATTACK.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedAttack)
                    set this.bonusedAttack = 0
                    set added = true
                endif 
                if this.bonusedAttack_P != 0 then 
                    call ST_ATTACK.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedAttack_P)
                    set this.bonusedAttack_P = 0
                    set added = true
                endif 
                if this.bonusedAbilityPower != 0 then 
                    call ST_ABILITY_POWER.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedAbilityPower)
                    set this.bonusedAbilityPower = 0
                    set added = true
                endif 
                if this.bonusedAbilityPower_P != 0 then 
                    call ST_ABILITY_POWER.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedAbilityPower_P)
                    set this.bonusedAbilityPower_P = 0
                    set added = true
                endif 
                if this.bonusedArmor != 0 then 
                    call ST_ARMOR.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedArmor)
                    set this.bonusedArmor = 0
                    set added = true
                endif 
                if this.bonusedArmor_P != 0 then 
                    call ST_ARMOR.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedArmor_P)
                    set this.bonusedArmor_P = 0
                    set added = true
                endif 
                if this.bonusedLife != 0 then 
                    call ST_LIFE.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedLife)
                    set this.bonusedLife = 0
                    set added = true
                endif 
                if this.bonusedLife_P != 0 then 
                    call ST_LIFE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedLife_P)
                    set this.bonusedLife_P = 0
                    set added = true
                endif 
                if this.bonusedMana != 0 then 
                    call ST_MANA.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedMana)
                    set this.bonusedMana = 0
                    set added = true
                endif 
                if this.bonusedMana_P != 0 then 
                    call ST_MANA.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedMana_P)
                    set this.bonusedMana_P = 0
                    set added = true
                endif 
                if this.bonusedAttackSpeed != 0 then 
                    call ST_ATTACK_SPEED.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedAttackSpeed)
                    set this.bonusedAttackSpeed = 0
                    set added = true
                endif 
                if this.bonusedMoveSpeed != 0 then 
                    call ST_MOVE_SPEED.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedMoveSpeed)
                    set this.bonusedMoveSpeed = 0
                    set added = true
                endif 
                if this.bonusedMoveSpeed_P != 0 then 
                    call ST_MOVE_SPEED.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedMoveSpeed_P)
                    set this.bonusedMoveSpeed_P = 0
                    set added = true
                endif 
                if this.bonusedArmorPenetration != 0 then 
                    call ST_ARMOR_PEN.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedArmorPenetration)
                    set this.bonusedArmorPenetration = 0
                    set added = true
                endif 
                if this.bonusedArmorPenetration_P != 0 then 
                    call ST_ARMOR_PEN.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedArmorPenetration_P)
                    set this.bonusedArmorPenetration_P = 0
                    set added = true
                endif 
                if this.bonusedAccuracy != 0 then 
                    call ST_ACCURACY.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedAccuracy)
                    set this.bonusedAccuracy = 0
                    set added = true
                endif 
                if this.bonusedHaste != 0 then 
                    call ST_HASTE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedHaste)
                    set this.bonusedHaste = 0
                    set added = true
                endif 
                if this.bonusedEvade != 0 then 
                    call ST_EVADE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedEvade)
                    set this.bonusedEvade = 0
                    set added = true
                endif 
                if this.bonusedCrit != 0 then 
                    call ST_CRIT_CHANCE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedCrit)
                    set this.bonusedCrit = 0
                    set added = true
                endif 
                if this.bonusedCritPower != 0 then 
                    call ST_CRIT_POWER.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedCritPower)
                    set this.bonusedCritPower = 0
                    set added = true
                endif 
                if this.bonusedBlock != 0 then 
                    call ST_BLOCK.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedBlock)
                    set this.bonusedBlock = 0
                    set added = true
                endif 
                if this.bonusedBlock_P != 0 then 
                    call ST_BLOCK.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedBlock_P)
                    set this.bonusedBlock_P = 0
                    set added = true
                endif 
                if this.bonusedLifeRegen != 0 then 
                    call ST_LIFE_REGEN.addStateSimple(this.buffTarget,STATE_MODE_REAL,0-this.bonusedLifeRegen)
                    set this.bonusedLifeRegen = 0
                    set added = true
                endif 
                if this.bonusedLifeRegen_P != 0 then 
                    call ST_LIFE_REGEN.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedLifeRegen_P)
                    set this.bonusedLifeRegen_P = 0
                    set added = true
                endif 
                if this.bonusedManaRegen != 0 then 
                    call ST_MANA_REGEN.addStateSimple(this.buffTarget,STATE_MODE_REAL,0-this.bonusedManaRegen)
                    set this.bonusedManaRegen = 0
                    set added = true
                endif 
                if this.bonusedManaRegen_P != 0 then 
                    call ST_MANA_REGEN.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedManaRegen_P)
                    set this.bonusedManaRegen_P = 0 
                    set added = true
                endif 
                if this.bonusedResistance != 0 then 
                    call ST_RESISTANCE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedResistance)
                    set this.bonusedResistance = 0
                    set added = true
                endif 
                if this.bonusedDamage != 0 then 
                    call ST_DAMAGE_BONUS.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedDamage)
                    set this.bonusedDamage = 0
                    set added = true
                endif 
                if this.bonusedHeal != 0 then 
                    call ST_HEAL_BONUS.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedHeal)
                    set this.bonusedHeal = 0
                    set added = true
                endif 
                if this.bonusedShield != 0 then 
                    call ST_SHIELD_BONUS.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedShield)
                    set this.bonusedShield = 0
                    set added = true
                endif 
                if this.bonusedImmune_Cold != 0 then 
                    call ST_IMMUNE_COLD.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedImmune_Cold)
                    set this.bonusedImmune_Cold = 0
                    set added = true
                endif 
                if this.bonusedImmune_Silence != 0 then 
                    call ST_IMMUNE_SILENCE.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedImmune_Silence)
                    set this.bonusedImmune_Silence = 0
                    set added = true
                endif 
                if this.bonusedImmune_Snare != 0 then 
                    call ST_IMMUNE_SNARE.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedImmune_Snare)
                    set this.bonusedImmune_Snare = 0
                    set added = true
                endif 
                if this.bonusedImmune_Stun != 0 then 
                    call ST_IMMUNE_STUN.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedImmune_Stun)
                    set this.bonusedImmune_Stun = 0
                    set added = true
                endif 
                if this.bonusedImmune_Root != 0 then 
                    call ST_IMMUNE_ROOT.addStateSimple(this.buffTarget,STATE_MODE_INT,0-this.bonusedImmune_Root)
                    set this.bonusedImmune_Root = 0
                    set added = true
                endif 
                if this.bonusedCostReduce != 0 then 
                    call ST_COST_REDUCE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedCostReduce)
                    set this.bonusedCostReduce = 0
                    set added = true
                endif 
                if this.bonusedLeech != 0 then 
                    call ST_LEECH.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedLeech)
                    set this.bonusedLeech = 0
                    set added = true
                endif 
                if this.bonusedVersatility != 0 then 
                    call ST_VERSATILITY.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedVersatility)
                    set this.bonusedVersatility = 0
                    set added = true
                endif 
                if this.bonusedMaxArmor != 0 then 
                    call ST_MAX_ARMOR.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedMaxArmor)
                    set this.bonusedMaxArmor = 0
                    set added = true
                endif 
                if this.bonusedMaxResistance != 0 then 
                    call ST_MAX_RESISTANCE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedMaxResistance)
                    set this.bonusedMaxResistance = 0
                    set added = true
                endif 
                if this.bonusedMaxBlock != 0 then 
                    call ST_MAX_BLOCK.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedMaxBlock)
                    set this.bonusedMaxBlock = 0
                    set added = true
                endif 
                if this.bonusedMaxEvade != 0 then 
                    call ST_MAX_EVADE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,0-this.bonusedMaxEvade)
                    set this.bonusedMaxEvade = 0
                    set added = true
                endif 
                if this.checkStateWhenDestroy then 
                    set added = true
                endif 
                if added then 
                    //call BJDebugMsg("BUFF STATE REMOVED !")
                    call State.checkAll.evaluate(this.buffTarget)
                endif 
            endmethod
            method stateBonus takes nothing returns nothing
                local boolean added = false 
                if this.bonusStr != 0 then 
                    call ST_STR.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusStr)
                    set this.bonusedStr = this.bonusStr
                    set added = true
                endif 
                if this.bonusStr_P != 0 then 
                    call ST_STR.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusStr_P)
                    set this.bonusedStr_P = this.bonusStr_P
                    set added = true
                endif 
                if this.bonusAgi != 0 then 
                    call ST_AGI.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusAgi)
                    set this.bonusedAgi = this.bonusAgi
                    set added = true
                endif 
                if this.bonusAgi_P != 0 then 
                    call ST_AGI.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusAgi_P)
                    set this.bonusedAgi_P = this.bonusAgi_P
                    set added = true
                endif 
                if this.bonusInt != 0 then 
                    call ST_INT.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusInt)
                    set this.bonusedInt = this.bonusInt
                    set added = true
                endif 
                if this.bonusInt_P != 0 then 
                    call ST_INT.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusInt_P)
                    set this.bonusedInt_P = this.bonusInt_P
                    set added = true
                endif 
                if this.bonusMain != 0 then 
                    call ST_MAIN.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusMain)
                    set this.bonusedMain = this.bonusMain
                    set added = true
                endif 
                if this.bonusMain_P != 0 then 
                    call ST_MAIN.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusMain_P)
                    set this.bonusedMain_P = this.bonusMain_P
                    set added = true
                endif 
                if this.bonusAttack != 0 then 
                    call ST_ATTACK.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusAttack)
                    set this.bonusedAttack = this.bonusAttack
                    set added = true
                endif 
                if this.bonusAttack_P != 0 then 
                    call ST_ATTACK.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusAttack_P)
                    set this.bonusedAttack_P = this.bonusAttack_P
                    set added = true
                endif 
                if this.bonusAbilityPower != 0 then 
                    call ST_ABILITY_POWER.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusAbilityPower)
                    set this.bonusedAbilityPower = this.bonusAbilityPower
                    set added = true
                endif 
                if this.bonusAbilityPower_P != 0 then 
                    call ST_ABILITY_POWER.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusAbilityPower_P)
                    set this.bonusedAbilityPower_P = this.bonusAbilityPower_P
                    set added = true
                endif 
                if this.bonusArmor != 0 then 
                    call ST_ARMOR.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusArmor)
                    set this.bonusedArmor = this.bonusArmor
                    set added = true
                endif 
                if this.bonusArmor_P != 0 then 
                    call ST_ARMOR.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusArmor_P)
                    set this.bonusedArmor_P = this.bonusArmor_P
                    set added = true
                endif 
                if this.bonusLife != 0 then 
                    call ST_LIFE.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusLife)
                    set this.bonusedLife = this.bonusLife
                    set added = true
                endif 
                if this.bonusLife_P != 0 then 
                    call ST_LIFE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusLife_P)
                    set this.bonusedLife_P = this.bonusLife_P
                    set added = true
                endif 
                if this.bonusMana != 0 then 
                    call ST_MANA.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusMana)
                    set this.bonusedMana = this.bonusMana
                    set added = true
                endif 
                if this.bonusMana_P != 0 then 
                    call ST_MANA.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusMana_P)
                    set this.bonusedMana_P = this.bonusMana_P
                    set added = true
                endif 
                if this.bonusAttackSpeed != 0 then 
                    call ST_ATTACK_SPEED.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusAttackSpeed)
                    set this.bonusedAttackSpeed = this.bonusAttackSpeed
                    set added = true
                endif 
                if this.bonusMoveSpeed != 0 then 
                    call ST_MOVE_SPEED.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusMoveSpeed)
                    set this.bonusedMoveSpeed = this.bonusMoveSpeed
                    set added = true
                endif 
                if this.bonusMoveSpeed_P != 0 then 
                    call ST_MOVE_SPEED.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusMoveSpeed_P)
                    set this.bonusedMoveSpeed_P = this.bonusMoveSpeed_P
                    set added = true
                endif 
                if this.bonusArmorPenetration != 0 then 
                    call ST_ARMOR_PEN.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusArmorPenetration)
                    set this.bonusedArmorPenetration = this.bonusArmorPenetration
                    set added = true
                endif 
                if this.bonusArmorPenetration_P != 0 then 
                    call ST_ARMOR_PEN.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusArmorPenetration_P)
                    set this.bonusedArmorPenetration_P = this.bonusArmorPenetration_P
                    set added = true
                endif 
                if this.bonusAccuracy != 0 then 
                    call ST_ACCURACY.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusAccuracy)
                    set this.bonusedAccuracy = this.bonusAccuracy
                    set added = true
                endif 
                if this.bonusHaste != 0 then 
                    call ST_HASTE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusHaste)
                    set this.bonusedHaste = this.bonusHaste
                    set added = true
                endif 
                if this.bonusEvade != 0 then 
                    call ST_EVADE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusEvade)
                    set this.bonusedEvade = this.bonusEvade
                    set added = true
                endif 
                if this.bonusCrit != 0 then 
                    call ST_CRIT_CHANCE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusCrit)
                    set this.bonusedCrit = this.bonusCrit
                    set added = true
                endif 
                if this.bonusCritPower != 0 then 
                    call ST_CRIT_POWER.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusCritPower)
                    set this.bonusedCritPower = this.bonusCritPower
                    set added = true
                endif 
                if this.bonusBlock != 0 then 
                    call ST_BLOCK.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusBlock)
                    set this.bonusedBlock = this.bonusBlock
                    set added = true
                endif 
                if this.bonusBlock_P != 0 then 
                    call ST_BLOCK.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusBlock_P)
                    set this.bonusedBlock_P = this.bonusBlock_P
                    set added = true
                endif 
                if this.bonusLifeRegen != 0 then 
                    call ST_LIFE_REGEN.addStateSimple(this.buffTarget,STATE_MODE_REAL,this.bonusLifeRegen)
                    set this.bonusedLifeRegen = this.bonusLifeRegen
                    set added = true
                endif 
                if this.bonusLifeRegen_P != 0 then 
                    call ST_LIFE_REGEN.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusLifeRegen_P)
                    set this.bonusedLifeRegen_P = this.bonusLifeRegen_P
                    set added = true
                endif 
                if this.bonusManaRegen != 0 then 
                    call ST_MANA_REGEN.addStateSimple(this.buffTarget,STATE_MODE_REAL,this.bonusManaRegen)
                    set this.bonusedManaRegen = this.bonusManaRegen
                    set added = true
                endif 
                if this.bonusManaRegen_P != 0 then 
                    call ST_MANA_REGEN.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusManaRegen_P)
                    set this.bonusedManaRegen_P = this.bonusManaRegen_P 
                    set added = true
                endif 
                if this.bonusResistance != 0 then 
                    call ST_RESISTANCE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusResistance)
                    set this.bonusedResistance = this.bonusResistance
                    set added = true
                endif 
                if this.bonusDamage != 0 then 
                    call ST_DAMAGE_BONUS.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusDamage)
                    set this.bonusedDamage = this.bonusDamage
                    set added = true
                endif 
                if this.bonusHeal != 0 then 
                    call ST_HEAL_BONUS.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusHeal)
                    set this.bonusedHeal = this.bonusHeal
                    set added = true
                endif 
                if this.bonusShield != 0 then 
                    call ST_SHIELD_BONUS.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusShield)
                    set this.bonusedShield = this.bonusShield
                    set added = true
                endif 
                if this.bonusImmune_Cold != 0 then 
                    call ST_IMMUNE_COLD.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusImmune_Cold)
                    set this.bonusedImmune_Cold = this.bonusImmune_Cold
                    set added = true
                endif 
                if this.bonusImmune_Silence != 0 then 
                    call ST_IMMUNE_SILENCE.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusImmune_Silence)
                    set this.bonusedImmune_Silence = this.bonusImmune_Silence
                    set added = true
                endif 
                if this.bonusImmune_Snare != 0 then 
                    call ST_IMMUNE_SNARE.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusImmune_Snare)
                    set this.bonusedImmune_Snare = this.bonusImmune_Snare
                    set added = true
                endif 
                if this.bonusImmune_Stun != 0 then 
                    call ST_IMMUNE_STUN.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusImmune_Stun)
                    set this.bonusedImmune_Stun = this.bonusImmune_Stun
                    set added = true
                endif 
                if this.bonusImmune_Root != 0 then 
                    call ST_IMMUNE_ROOT.addStateSimple(this.buffTarget,STATE_MODE_INT,this.bonusImmune_Root)
                    set this.bonusedImmune_Root = this.bonusImmune_Root
                    set added = true
                endif 
                if this.bonusCostReduce != 0 then 
                    call ST_COST_REDUCE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusCostReduce)
                    set this.bonusedCostReduce = this.bonusCostReduce
                    set added = true
                endif 
                if this.bonusLeech != 0 then 
                    call ST_LEECH.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusLeech)
                    set this.bonusedLeech = this.bonusLeech
                    set added = true
                endif 
                if this.bonusVersatility != 0 then 
                    call ST_VERSATILITY.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusVersatility)
                    set this.bonusedVersatility = this.bonusVersatility
                    set added = true
                endif 
                if this.bonusMaxArmor != 0 then 
                    call ST_MAX_ARMOR.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusMaxArmor)
                    set this.bonusedMaxArmor = this.bonusMaxArmor
                    set added = true
                endif 
                if this.bonusMaxResistance != 0 then 
                    call ST_MAX_RESISTANCE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusMaxResistance)
                    set this.bonusedMaxResistance = this.bonusMaxResistance
                    set added = true
                endif 
                if this.bonusMaxBlock != 0 then 
                    call ST_MAX_BLOCK.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusMaxBlock)
                    set this.bonusedMaxBlock = this.bonusMaxBlock
                    set added = true
                endif 
                if this.bonusMaxEvade != 0 then 
                    call ST_MAX_EVADE.addStateSimple(this.buffTarget,STATE_MODE_PERCENTAGE,this.bonusMaxEvade)
                    set this.bonusedMaxEvade = this.bonusedMaxEvade
                    set added = true
                endif 
                if added then 
                    call State.checkAll.evaluate(this.buffTarget)
                endif 
            endmethod
            //! textmacro BONUS_REFRESH takes FIELDNAME, STATE_OBJ, MODE
                if this.bonus$FIELDNAME$ != this.bonused$FIELDNAME$ then
                    set diff = this.bonus$FIELDNAME$ - this.bonused$FIELDNAME$
                    call $STATE_OBJ$.addStateSimple(this.buffTarget, $MODE$, diff)
                    //call BJDebugMsg("unit "+GetUnitName(this.buffTarget)+" , buff type "+I2S(this.type)+" need refresh "+I2S(globalNowtime)+" ST "+I2S($STATE_OBJ$)+" UNEQUAL !")
                    //call BJDebugMsg("debug: bonus = "+I2S(this.bonus$FIELDNAME$)+" , bonused = "+I2S(this.bonused$FIELDNAME$)+" , diff = "+I2S(diff))
                    set this.bonused$FIELDNAME$ = this.bonus$FIELDNAME$
                    set needRefresh = true
                endif
            //! endtextmacro
            method refreshStates takes nothing returns nothing
                local boolean needRefresh = false
                local integer diff
                
                //! runtextmacro BONUS_REFRESH("Str",                "ST_STR",               "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Str_P",              "ST_STR",               "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Agi",                "ST_AGI",               "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Agi_P",              "ST_AGI",               "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Int",                "ST_INT",               "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Int_P",              "ST_INT",               "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Main",               "ST_MAIN",              "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Main_P",             "ST_MAIN",              "STATE_MODE_PERCENTAGE")
                
                //! runtextmacro BONUS_REFRESH("Attack",            "ST_ATTACK",            "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Attack_P",          "ST_ATTACK",            "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("AbilityPower",      "ST_ABILITY_POWER",     "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("AbilityPower_P",    "ST_ABILITY_POWER",     "STATE_MODE_PERCENTAGE")
                
                //! runtextmacro BONUS_REFRESH("Armor",              "ST_ARMOR",             "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Armor_P",            "ST_ARMOR",             "STATE_MODE_PERCENTAGE")
                
                //! runtextmacro BONUS_REFRESH("Life",               "ST_LIFE",              "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Life_P",             "ST_LIFE",              "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Mana",               "ST_MANA",              "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Mana_P",             "ST_MANA",              "STATE_MODE_PERCENTAGE")
                
                //! runtextmacro BONUS_REFRESH("AttackSpeed",        "ST_ATTACK_SPEED",      "STATE_MODE_PERCENTAGE")
                
                //! runtextmacro BONUS_REFRESH("MoveSpeed",          "ST_MOVE_SPEED",        "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("MoveSpeed_P",        "ST_MOVE_SPEED",        "STATE_MODE_PERCENTAGE")
                
                //! runtextmacro BONUS_REFRESH("ArmorPenetration",   "ST_ARMOR_PEN",         "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("ArmorPenetration_P", "ST_ARMOR_PEN",         "STATE_MODE_PERCENTAGE")
                
                //! runtextmacro BONUS_REFRESH("Accuracy",           "ST_ACCURACY",          "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Haste",              "ST_HASTE",             "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Evade",              "ST_EVADE",             "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Crit",               "ST_CRIT_CHANCE",       "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("CritPower",          "ST_CRIT_POWER",        "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Versatility",        "ST_VERSATILITY",       "STATE_MODE_PERCENTAGE")
                
                //! runtextmacro BONUS_REFRESH("Block",              "ST_BLOCK",             "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Block_P",            "ST_BLOCK",             "STATE_MODE_PERCENTAGE")
                
                //! runtextmacro BONUS_REFRESH("LifeRegen",          "ST_LIFE_REGEN",        "STATE_MODE_REAL")
                //! runtextmacro BONUS_REFRESH("LifeRegen_P",        "ST_LIFE_REGEN",        "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("ManaRegen",          "ST_MANA_REGEN",        "STATE_MODE_REAL")
                //! runtextmacro BONUS_REFRESH("ManaRegen_P",        "ST_MANA_REGEN",        "STATE_MODE_PERCENTAGE")
                
                //! runtextmacro BONUS_REFRESH("Resistance",         "ST_RESISTANCE",        "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Damage",             "ST_DAMAGE_BONUS",      "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Heal",               "ST_HEAL_BONUS",        "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Shield",             "ST_SHIELD_BONUS",      "STATE_MODE_PERCENTAGE")

                //! runtextmacro BONUS_REFRESH("MaxBlock",           "ST_MAX_BLOCK",         "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("MaxResistance",      "ST_MAX_RESISTANCE",    "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("MaxArmor",           "ST_MAX_ARMOR",         "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("MaxEvade",           "ST_MAX_EVADE",         "STATE_MODE_PERCENTAGE")
                
                // 免疫类（都是整数开关）
                //! runtextmacro BONUS_REFRESH("Immune_Cold",        "ST_IMMUNE_COLD",       "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Immune_Silence",    "ST_IMMUNE_SILENCE",    "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Immune_Snare",      "ST_IMMUNE_SNARE",      "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Immune_Stun",       "ST_IMMUNE_STUN",       "STATE_MODE_INT")
                //! runtextmacro BONUS_REFRESH("Immune_Root",       "ST_IMMUNE_ROOT",       "STATE_MODE_INT")
                
                //! runtextmacro BONUS_REFRESH("CostReduce",         "ST_COST_REDUCE",       "STATE_MODE_PERCENTAGE")
                //! runtextmacro BONUS_REFRESH("Leech",              "ST_LEECH",             "STATE_MODE_PERCENTAGE")
                
                // 最后统一刷新（只在真正有变化时调用一次）
                if needRefresh then
                    //call BJDebugMsg("unit "+GetUnitName(this.buffTarget)+" , buff type "+I2S(this.type)+" need refresh "+I2S(globalNowtime))
                    call State.checkAll.evaluate(this.buffTarget)
                endif
            endmethod
            method apply_new takes nothing returns nothing
                if this == 0 or this.buffTarget == null or alive(this.buffTarget) == false then 
                    return 
                endif 
                if this.lastTime == 0 then 
                    set this.DESTROY = true 
                else 
                    set this.DESTROY = false
                    if this.addTime then 
                        set this.remainingTime = IMinBJ(IMaxBJ(this.lastTime*5/4,this.remainingTime),this.remainingTime+this.lastTime)
                        set this.lastTime = this.remainingTime
                    else 
                        set this.remainingTime = this.lastTime
                        set this.lastTime = this.remainingTime
                    endif 
                    set this.addTime = true 
                    if this.newApply then 
                        set this.lastTriggerTime = globalNowtime
                        
                        if GetUnitAbilityLevel(this.buffTarget,this.type.abilityId) == 0 and this.type.abilityId != 0 then 
                            call UnitAddAbilityEx(this.buffTarget,this.type.abilityId)
                            call UnitMakeAbilityPermanent(this.buffTarget,true,this.type.abilityId)
                        endif
                        
                        set this.LAUNCH = true 
                    endif 
                    call this.refreshStates()
                endif 
                if this.shieldMaxValue > 0 then 
                    if this.addShield then 
                        set this.shieldNowValue = RMinBJ(this.addShieldMaxValue,this.shieldNowValue+this.shieldMaxValue*(1+I2R(ST_SHIELD_BONUS.getTotalState(this.buffSource))/10000))
                        if random.get(this.buffSource,I2R(ST_CRIT_CHANCE.getTotalState(this.buffSource))/10000,this.type.abilityId) then 
                            set this.shieldNowValue = this.shieldNowValue*(1+I2R(ST_CRIT_POWER.getTotalState(this.buffSource))/10000)
                        endif 
                    else 
                        set this.shieldNowValue = this.shieldMaxValue*(1+I2R(ST_SHIELD_BONUS.getTotalState(this.buffSource))/10000)
                    endif 
                endif 
                if IsUnitType(this.buffTarget,UNIT_TYPE_ANCIENT) == false and COMBAT_LOG_ON then 
                    if this.fromAura == false or (this.fromAura and this.newApply) then 
                        call Preload("B|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(this.buffSource))+"|"+I2S(GetHandleId(this.buffSource)-1050000)+"|"+I2SSSS(this.type.abilityId)+"|"+I2SSSS(GetUnitTypeId(this.buffTarget))+"|"+I2S(GetHandleId(this.buffTarget)-1050000))
                    endif 
                endif 
                set this.applying = false 
                //call BJDebugMsg("BUFF = "+I2S(this)+" : APPLYED")
            endmethod

            static method applyBuff takes nothing returns nothing
                local integer i = GetHandleId(GetExpiredTimer())
                local thistype this = LoadInteger(delayedApplyHash,i,0)
                call DestroyTimer(GetExpiredTimer())
                call this.apply_new()
                call FlushChildHashtable(delayedApplyHash,i)
            endmethod

            method apply takes nothing returns nothing
                local timer t = null
                local integer i = 0
                if this.applying then 
                    return 
                endif 
                set this.applying = true 
                set t = CreateTimer()
                set i = GetHandleId(t)
                call TimerStart(t,0,false,function thistype.applyBuff)
                call SaveInteger(delayedApplyHash,i,0,this)
                set t = null 
                //call BJDebugMsg("BUFF = "+I2S(this)+" : APPLY")
            endmethod

            method addPeriod takes code action returns nothing
                local trigger newTrig = this.trigPeriod
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPeriod = newTrig
                set newTrig = null 
            endmethod
            method addEnding takes code action returns nothing
                local trigger newTrig = this.trigEnding
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigEnding = newTrig
                set newTrig = null 
            endmethod

            method addBefDmg_S takes code action returns nothing
                local trigger newTrig = this.trigBeforedamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforedamageSource = newTrig
                set newTrig = null 
            endmethod
            method addBefDmg_T takes code action returns nothing
                local trigger newTrig = this.trigBeforedamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforedamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addPreDmg_S takes code action returns nothing
                local trigger newTrig = this.trigPredamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPredamageSource = newTrig
                set newTrig = null 
            endmethod
            method addPreDmg_T takes code action returns nothing
                local trigger newTrig = this.trigPredamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPredamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addDmging_S takes code action returns nothing
                local trigger newTrig = this.trigDamagingSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagingSource = newTrig
                set newTrig = null 
            endmethod
            method addDmging_T takes code action returns nothing
                local trigger newTrig = this.trigDamagingTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagingTarget = newTrig
                set newTrig = null 
            endmethod

            method addDmged_S takes code action returns nothing
                local trigger newTrig = this.trigDamagedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagedSource = newTrig
                set newTrig = null 
            endmethod
            method addDmged_T takes code action returns nothing
                local trigger newTrig = this.trigDamagedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagedTarget = newTrig
                set newTrig = null 
            endmethod

            method addAftDmg_S takes code action returns nothing
                local trigger newTrig = this.trigAfterdamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterdamageSource = newTrig
                set newTrig = null 
            endmethod
            method addAftDmg_T takes code action returns nothing
                local trigger newTrig = this.trigAfterdamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterdamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addBefHeal_S takes code action returns nothing
                local trigger newTrig = this.trigBeforehealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforehealSource = newTrig
                set newTrig = null 
            endmethod
            method addBefHeal_T takes code action returns nothing
                local trigger newTrig = this.trigBeforehealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforehealTarget = newTrig
                set newTrig = null 
            endmethod

            method addPreHeal_S takes code action returns nothing
                local trigger newTrig = this.trigPreHealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPreHealSource = newTrig
                set newTrig = null 
            endmethod
            method addPreHeal_T takes code action returns nothing
                local trigger newTrig = this.trigPreHealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPreHealTarget = newTrig
                set newTrig = null 
            endmethod

            method addHealing_S takes code action returns nothing
                local trigger newTrig = this.trigHealingSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealingSource = newTrig
                set newTrig = null 
            endmethod
            method addHealing_T takes code action returns nothing
                local trigger newTrig = this.trigHealingTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealingTarget = newTrig
                set newTrig = null 
            endmethod

            method addHealed_S takes code action returns nothing
                local trigger newTrig = this.trigHealedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealedSource = newTrig
                set newTrig = null 
            endmethod
            method addHealed_T takes code action returns nothing
                local trigger newTrig = this.trigHealedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealedTarget = newTrig
                set newTrig = null 
            endmethod

            method addAftHeal_S takes code action returns nothing
                local trigger newTrig = this.trigAfterhealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterhealSource = newTrig
                set newTrig = null 
            endmethod
            method addAftHeal_T takes code action returns nothing
                local trigger newTrig = this.trigAfterhealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterhealTarget = newTrig
                set newTrig = null 
            endmethod

            method addAtking takes code action returns nothing
                local trigger newTrig = this.trigAttacking
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttacking = newTrig
                set newTrig = null 
            endmethod

            method addAtked_S takes code action returns nothing
                local trigger newTrig = this.trigAttackedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttackedSource = newTrig
                set newTrig = null 
            endmethod
            method addAtked_T takes code action returns nothing
                local trigger newTrig = this.trigAttackedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttackedTarget = newTrig
                set newTrig = null 
            endmethod

            method addMslLnch takes code action returns nothing
                local trigger newTrig = this.trigMissileLaunch
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileLaunch = newTrig
                set newTrig = null 
            endmethod
            method addSpelling takes code action returns nothing
                local trigger newTrig = this.trigSpelling
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigSpelling = newTrig
                set newTrig = null 
            endmethod

            method addMslHit_S takes code action returns nothing
                local trigger newTrig = this.trigMissileHitSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileHitSource = newTrig
                set newTrig = null 
            endmethod
            method addMslHit_T takes code action returns nothing
                local trigger newTrig = this.trigMissileHitTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileHitTarget = newTrig
                set newTrig = null 
            endmethod

            static method onInit takes nothing returns nothing
                call TimerStart(CreateTimer(),0.01,true,function thistype.updateAll)
            endmethod
        endstruct
        function CreateBuff takes unit source,unit target,bufftype whichBuff,integer lastTime returns mybuff
            local mybuff this = mybuff.create(source,target,whichBuff)
            set this.lastTime = lastTime 
            return this 
        endfunction
        struct bufflist
            static mybuff array buffs[128]
            static integer count = 0

            static method flush takes nothing returns nothing
                local integer i = 1
                loop
                    exitwhen i > bufflist.count
                    set bufflist.buffs[i] = 0
                    set i = i + 1
                endloop
                set bufflist.count = 0
            endmethod

            static method listUnitBuffs takes unit whichUnit, boolean pos, boolean neg, boolean dispelAble returns nothing
                local integer i = mybuff.countUnitBuff(whichUnit)
                local mybuff bf
                call bufflist.flush()
                loop
                    exitwhen i <= 0
                    set bf = LoadInteger(mybuff.buffHashtable, GetHandleId(whichUnit), i)
                    if bf != 0 and (bf.type.negative == neg or bf.type.positive == pos) and bf.type.dispelAble == dispelAble then
                        set bufflist.count = bufflist.count + 1
                        set bufflist.buffs[bufflist.count] = bf
                        //call BJDebugMsg("DEBUG: LIST BUFF = "+I2SSSS(bf.type.abilityId)+", COUNT = "+I2S(bufflist.count))
                    endif
                    set i = i - 1
                endloop
                set whichUnit = null
            endmethod

            static method dispel takes nothing returns boolean
                local integer i
                local mybuff bf
                //call BJDebugMsg("DEBUG: DISPELING, NOW COUNT = "+I2S(bufflist.count))
                if bufflist.count <= 0 then
                    return false
                endif
                set i = GetRandomInt(1,bufflist.count)
                //call BJDebugMsg("DEBUG: DISPELING, RANDOM = "+I2S(i))
                set bf = bufflist.buffs[i]
                if bf != 0 then
                    //call BJDebugMsg("DEBUG: DISPEL BUFF = "+I2SSSS(bf.type.abilityId))
                    set bf.DESTROY = true
                    set bf.DISPEL = true
                endif
                // 用最后一个覆盖删除位置
                set bufflist.buffs[i] = bufflist.buffs[bufflist.count]
                set bufflist.buffs[bufflist.count] = 0
                set bufflist.count = bufflist.count - 1
                return true
            endmethod

            static method dispelMultiBuffs takes integer amount returns boolean
                local integer i = amount
                //call BJDebugMsg("DEBUG: DISPELING MULTI BUFFS, AMOUNT = "+I2S(amount))
                if bufflist.count <= 0 then
                    //call BJDebugMsg("DEBUG: DISPELING MULTI BUFFS, FAILURE!!!")
                    return false
                endif
                set i = amount
                if i > bufflist.count then
                    set i = bufflist.count
                endif
                loop
                    exitwhen i <= 0
                    //call BJDebugMsg("DEBUG: DISPELING MULTI BUFFS, LOOPING = "+I2S(i))
                    call bufflist.dispel()
                    set i = i - 1
                endloop
                return true
            endmethod

            static method dispelAllBuffs takes nothing returns nothing
                local integer i = 1
                loop
                    exitwhen i > bufflist.count
                    if bufflist.buffs[i] != 0 then
                        set bufflist.buffs[i].DESTROY = true
                        set bufflist.buffs[i].DISPEL = true
                    endif
                    set bufflist.buffs[i] = 0
                    set i = i + 1
                endloop
                set bufflist.count = 0
            endmethod
        endstruct
        struct aura 
            static integer UPDATE_TIME      = 100
            static integer BUFF_LAST        = 150
            static aura checkingAura        = 0
            static mybuff modifingAuraBuff  = 0
            static unit filterUnit          = null 
            static boolean able             = true
            static aura top             = 0
            aura prev                  
            aura next 
            unit bindUnit               = null 
            effect bindSFX              = null 
            integer id                  = 0 
            bufftype auraEnemyBuff      = 0
            trigger trigEnemySet
            bufftype auraAllyBuff       = 0
            trigger trigAllySet
            real auraRadius             = 0
            integer lastTime            = 0
            integer applyTime           = 0
            boolean DESTROY             = false 
            integer lastUpdateTime      = 0
            string auraName             = ""
            trigger trigEnemyCheck      
            trigger trigAllyCheck 
            boolean removeWhenDeath     = true 

            real realData       = 0
            integer intData     = 0
            boolean boolData    = false 

            static method getAura takes unit whichUnit,string name returns aura 
                local thistype this = thistype.top 
                loop 
                    exitwhen this == 0
                    if this.bindUnit == whichUnit and this.auraName == name then 
                        exitwhen true 
                    endif 
                    set this = this.prev 
                endloop
                return this 
            endmethod
            static method create takes unit whichUnit,string name,real radius,bufftype enemyBuff,bufftype allyBuff,string SFXPath returns aura 
                local aura this
            
                if aura.getAura(whichUnit,name) == 0 then 
                    set this = aura.allocate()
                    set this.bindUnit = whichUnit
                    set this.bindSFX = AddSpecialEffectTargetEX(SFXPath,whichUnit,"origin")
                    set this.auraName = name 
                    set this.auraRadius = radius
                    set this.auraEnemyBuff = enemyBuff
                    set this.auraAllyBuff = allyBuff
                    set this.prev = thistype.top 
                    if this.prev > 0 then 
                        set this.prev.next = this 
                    endif 
                    set this.next = 0
                    set thistype.top = this 
                else 
                    set this = aura.getAura(whichUnit,name)
                    call DestroyEffectEX(this.bindSFX)
                    set this.bindSFX = AddSpecialEffectTargetEX(SFXPath,whichUnit,"origin")
                    set this.auraName = name 
                    set this.auraRadius = radius
                    set this.auraEnemyBuff = enemyBuff
                    set this.auraAllyBuff = allyBuff
                    call this.flushTrigs()
                endif 
                return this 
            endmethod
            method flushTrigs takes nothing returns nothing
                if this.trigEnemySet != null then 
                    call DestroyTriggerEx(this.trigEnemySet)
                    set this.trigEnemySet = null 
                endif 
                if this.trigEnemyCheck != null then 
                    call DestroyTriggerEx(this.trigEnemyCheck)
                    set this.trigEnemyCheck = null 
                endif 
                if this.trigAllySet != null then 
                    call DestroyTriggerEx(this.trigAllySet)
                    set this.trigAllySet = null 
                endif 
                if this.trigAllyCheck != null then 
                    call DestroyTriggerEx(this.trigAllyCheck)
                    set this.trigAllyCheck = null 
                endif 
            endmethod
            method onDestroy takes nothing returns nothing
                call DestroyEffectEX(this.bindSFX)
                set this.bindSFX = null 
                set this.bindUnit = null 
                call this.flushTrigs()
                if this.prev > 0 then 
                    set this.prev.next = this.next 
                endif 
                if this.next > 0 then 
                    set this.next.prev = this.prev 
                endif 
                if this == thistype.top then 
                    set thistype.top = this.prev 
                endif 
            endmethod

            method addEnmSet takes code action returns nothing
                if this.trigEnemySet == null then 
                    set this.trigEnemySet = CreateTrigger()
                endif 
                call TriggerAddActionEx(this.trigEnemySet,action)
            endmethod
            method addEnmChk takes code action returns nothing
                if this.trigEnemyCheck == null then 
                    set this.trigEnemyCheck = CreateTrigger()
                endif 
                call TriggerAddActionEx(this.trigEnemyCheck,action)
            endmethod
            method addAllySet takes code action returns nothing
                if this.trigAllySet == null then 
                    set this.trigAllySet = CreateTrigger()
                endif 
                call TriggerAddActionEx(this.trigAllySet,action)
            endmethod
            method addAllyChk takes code action returns nothing
                if this.trigAllyCheck == null then 
                    set this.trigAllyCheck = CreateTrigger()
                endif 
                call TriggerAddActionEx(this.trigAllyCheck,action)
            endmethod

            method setLastTime takes integer time returns nothing
                set this.applyTime = globalNowtime
                set this.lastTime = time
            endmethod

            method applyAuraBuffs takes nothing returns nothing
                local group auraGroup = CreateGroup()
                local mybuff bf
                //////////call BJDebugMsg("AURA_APPLY_BUFF"+I2S(globalNowtime))
                set aura.checkingAura = this 
                call GroupEnumUnitsInRange(auraGroup,GetUnitX(this.bindUnit),GetUnitY(this.bindUnit),this.auraRadius,groupEnumLegal)
                loop 
                    exitwhen FirstOfGroup(auraGroup) == null 
                    if IsUnitEnemy(FirstOfGroup(auraGroup),GetOwningPlayer(this.bindUnit)) and this.auraEnemyBuff != 0 then 
                        set aura.filterUnit = FirstOfGroup(auraGroup)
                        set aura.able = true 
                        if this.trigEnemyCheck != null then  //this.enemyCheckFunc != "" then 
                            call TriggerExecute(this.trigEnemyCheck)
                            //call ExecuteFunc(this.enemyCheckFunc)
                        endif 
                        if aura.able then 
                            set bf = mybuff.create(this.bindUnit,FirstOfGroup(auraGroup),this.auraEnemyBuff)
                            set bf.fromAura = true 
                            if this.trigEnemySet != null then  //if this.enemyBuffSet != "" then
                                set aura.modifingAuraBuff = bf 
                                call TriggerExecute(this.trigEnemySet)
                                //call ExecuteFunc(this.enemyBuffSet)
                                set aura.modifingAuraBuff = 0
                            endif 
                            set bf.lastTime = aura.BUFF_LAST
                            call bf.apply()
                        endif 
                    elseif IsUnitAlly(FirstOfGroup(auraGroup),GetOwningPlayer(this.bindUnit)) and this.auraAllyBuff != 0 then 
                        set aura.filterUnit = FirstOfGroup(auraGroup)
                        set aura.able = true 
                        if this.trigAllyCheck != null then  //if this.allyCheckFunc != "" then 
                            call TriggerExecute(this.trigAllyCheck)
                            //call ExecuteFunc(this.allyCheckFunc)
                        endif 
                        if aura.able then 
                            set bf = mybuff.create(this.bindUnit,FirstOfGroup(auraGroup),this.auraAllyBuff)
                            set bf.fromAura = true 
                            if this.trigAllySet != null then  //if this.allyBuffSet != "" then
                                set aura.modifingAuraBuff = bf 
                                call TriggerExecute(this.trigAllySet)
                                //call ExecuteFunc(this.allyBuffSet)
                                set aura.modifingAuraBuff = 0
                            endif 
                            set bf.lastTime = aura.BUFF_LAST
                            call bf.apply()
                        endif 
                    endif 
                    call GroupRemoveUnit(auraGroup,FirstOfGroup(auraGroup))
                endloop
                call DestroyGroup(auraGroup)
                set auraGroup = null 
            endmethod
            method update takes nothing returns nothing
                if this.bindUnit != null and alive(this.bindUnit) then 
                    if globalNowtime-this.lastUpdateTime >= aura.UPDATE_TIME then 
                        set this.lastUpdateTime = globalNowtime
                        call this.applyAuraBuffs()
                    endif 
                else 
                    if this.bindUnit == null or this.removeWhenDeath or (globalNowtime-this.applyTime >= this.lastTime and this.applyTime > 0) then 
                        set this.DESTROY = true 
                    endif 
                endif 
            endmethod

            static method updateAll takes nothing returns nothing
                local aura this = thistype.top 
                loop 
                    exitwhen this == 0
                    call this.update()
                    if this.DESTROY then 
                        call this.destroy()
                    endif   
                    set this = this.prev 
                endloop
            endmethod

            static method onInit takes nothing returns nothing
                call TimerStart(CreateTimer(),0.1,true,function thistype.updateAll)
            endmethod
        endstruct
        function CreateAura takes unit whichUnit,string name,real radius,bufftype enemyBuff,bufftype allyBuff,string SFXPath returns aura 
            return aura.create(whichUnit,name,radius,enemyBuff,allyBuff,SFXPath)
        endfunction
        globals 
            aura eventAura = 0
        endglobals
        struct itemaura 
            string bindSFX              = ""
            bufftype auraEnemyBuff      = 0
            string enemyBuffSet         = ""
            bufftype auraAllyBuff       = 0
            string allyBuffSet          = ""
            real auraRadius             = 0
            string auraName             = ""
            trigger trigModifier    

            static method create takes string name,real radius,bufftype enemyBuff,bufftype allyBuff,string SFXPath returns thistype 
                local thistype this
                set this = thistype.allocate()
                set this.bindSFX = SFXPath
                set this.auraName = name 
                set this.auraRadius = radius
                set this.auraEnemyBuff = enemyBuff
                set this.auraAllyBuff = allyBuff
                return this 
            endmethod

            method addModifier takes code action returns nothing
                if this.trigModifier == null then 
                    set this.trigModifier = CreateTrigger()
                endif 
                call TriggerAddActionEx(this.trigModifier,action)
            endmethod

            method apply takes unit whichUnit returns nothing
                local aura au = aura.create(whichUnit,this.auraName,this.auraRadius,this.auraEnemyBuff,this.auraAllyBuff,this.bindSFX)
                if this.trigModifier != null then 
                    set eventAura = this 
                    call TriggerExecute(this.trigModifier)
                endif 
            endmethod
        endstruct         
        struct Knockup
            // 实例数据
            unit    target          = null
            real    startHeight     = 0.0
            real    peakHeight      = 0.0
            real    duration        = 0.0
            real    elapsed         = 0.0
            string  endFunc         = ""

            // 链表节点
            Knockup prev            = 0
            Knockup next            = 0

            // 静态头尾指针
            static Knockup head     = 0
            static Knockup tail     = 0

            //======================================================================
            //  创建击飞 + 防除零安全检查
            //======================================================================
            static method create takes unit target, real peakHeight, real duration, string endFunc returns Knockup
                local Knockup this

                // 【安全检查】
                if target == null or not alive(target) or duration <= 0.0 then
                    return 0  // 无效参数，直接返回 0
                endif

                set this = Knockup.allocate()

                set this.target      = target
                set this.startHeight = GetUnitDefaultFlyHeight(target)
                set this.peakHeight  = peakHeight
                set this.duration    = duration
                set this.elapsed     = 0.0
                set this.endFunc     = endFunc
                set this.prev        = 0
                set this.next        = 0

                // **一次性添加/移除 'Arav'，允许飞行**
                call UnitAddAbility(target, 'Arav')
                call UnitRemoveAbility(target, 'Arav')

                // 插入链表尾部
                if thistype.tail == 0 then
                    set thistype.head = this
                    set thistype.tail = this
                else
                    set thistype.tail.next = this
                    set this.prev = thistype.tail
                    set thistype.tail = this
                endif

                return this
            endmethod

            //======================================================================
            //  从链表中移除
            //======================================================================
            private method remove takes nothing returns nothing
                if this.prev != 0 then
                    set this.prev.next = this.next
                else
                    set thistype.head = this.next
                endif

                if this.next != 0 then
                    set this.next.prev = this.prev
                else
                    set thistype.tail = this.prev
                endif

                set this.prev = 0
                set this.next = 0
            endmethod

            //======================================================================
            //  抛物线高度（t 钳制在 0~1）
            //======================================================================
            private method getCurrentHeight takes real t returns real
                if t <= 0.0 then
                    return this.startHeight
                elseif t >= 1.0 then
                    return this.startHeight
                else
                    return this.startHeight + this.peakHeight * 4.0 * t * (1.0 - t)
                endif
            endmethod

            //======================================================================
            //  全局更新接口（防除零 + 安全 t 计算）
            //======================================================================
            static method updateAll takes nothing returns nothing
                local Knockup current = thistype.head
                local Knockup next
                local real t
                local boolean destroyThis = false 

                loop
                    exitwhen current == 0
                    set next = current.next

                    set destroyThis = false 
                    // 【防除零】：duration 已在前置检查，但 elapsed 可能超
                    if current.duration <= 0.0 then
                        set t = 1.0  // 强制结束
                    else
                        set current.elapsed = current.elapsed + 0.03
                        set t = current.elapsed / current.duration
                    endif

                    if t - 1.0 >= 0 then
                        if current.target != null then
                            // 结束：恢复高度
                            call SetUnitFlyHeight(current.target, current.startHeight, 0.0)

                            // 结束事件
                            if current.endFunc != "" then
                                call ExecuteFunc(current.endFunc)
                            endif
                        endif 
                        set destroyThis = true 
                    else
                        // 更新高度（t 安全）
                        call SetUnitFlyHeight(current.target, current.getCurrentHeight(t), 0.0)
                    endif
                    
                    // 移除并销毁
                    if destroyThis then 
                        call current.remove()
                        call current.destroy()
                    endif 
                    set current = next
                endloop
            endmethod

            //======================================================================
            //  销毁时清理
            //======================================================================
            method onDestroy takes nothing returns nothing
                set this.target = null
            endmethod
        endstruct
        struct ChaseTarget
            unit    chaser          = null
            unit    target          = null
            real    target_x        = 0.0
            real    target_y        = 0.0
            real    chaseDistance   = 0.0
            real    chaseSpeed      = 0.0
            boolean faceTarget     = false
            boolean stickOnReach   = false
            integer maxTime         = 0
            integer elapsedTicks    = 0
            boolean arrive          = false 

            boolean mode_target_loc = false 

            ChaseTarget prev        = 0
            ChaseTarget next        = 0

            static ChaseTarget head = 0
            static ChaseTarget tail = 0

            //======================================================================
            //  创建追逐（vJass 单行参数）
            //======================================================================
            static method create takes unit chaser, unit target, real chaseDistance, real chaseSpeed, boolean faceTarget, boolean stickOnReach, integer maxTime returns ChaseTarget
                local ChaseTarget this = 0

                if chaser == null or target == null or alive(chaser) == false or alive(target) == false then
                    return 0
                endif
                if chaseDistance <= 0.0 or chaseSpeed <= 0.0 then
                    return 0
                endif

                set this = ChaseTarget.allocate()
                set this.chaser         = chaser
                set this.target         = target
                set this.chaseDistance  = chaseDistance
                set this.chaseSpeed     = chaseSpeed
                set this.faceTarget     = faceTarget
                set this.stickOnReach   = stickOnReach
                set this.maxTime        = maxTime
                set this.elapsedTicks   = 0
                set this.prev           = 0
                set this.next           = 0

                if thistype.tail == 0 then
                    set thistype.head = this
                    set thistype.tail = this
                else
                    set thistype.tail.next = this
                    set this.prev = thistype.tail
                    set thistype.tail = this
                endif

                return this
            endmethod

            static method createLoc takes unit chaser, real x,real y, real chaseDistance, real chaseSpeed, boolean faceTarget, boolean stickOnReach, integer maxTime returns ChaseTarget
                local ChaseTarget this = 0

                if chaser == null or alive(chaser) == false then
                    return 0
                endif
                if chaseDistance <= 0.0 or chaseSpeed <= 0.0 then
                    return 0
                endif

                set this = ChaseTarget.allocate()
                set this.chaser         = chaser
                set this.target_x         = x
                set this.target_y         = y
                set this.chaseDistance  = chaseDistance
                set this.chaseSpeed     = chaseSpeed
                set this.faceTarget     = faceTarget
                set this.stickOnReach   = stickOnReach
                set this.maxTime        = maxTime
                set this.elapsedTicks   = 0
                set this.prev           = 0
                set this.next           = 0
                set this.mode_target_loc = true 

                if thistype.tail == 0 then
                    set thistype.head = this
                    set thistype.tail = this
                else
                    set thistype.tail.next = this
                    set this.prev = thistype.tail
                    set thistype.tail = this
                endif

                return this
            endmethod

            static method createSimple takes unit chaser,unit target,real chaseDistance,real chaseSpeed returns ChaseTarget
                return thistype.create(chaser,target,chaseDistance,chaseSpeed,true,false,0)
            endmethod
            
            static method createLocSimple takes unit chaser,real x,real y,real chaseDistance,real chaseSpeed returns ChaseTarget
                return thistype.createLoc(chaser,x,y,chaseDistance,chaseSpeed,true,false,0)
            endmethod

            //======================================================================
            //  链表移除
            //======================================================================
            private method remove takes nothing returns nothing
                if this.prev != 0 then
                    set this.prev.next = this.next
                else
                    set thistype.head = this.next
                endif
                if this.next != 0 then
                    set this.next.prev = this.prev
                else
                    set thistype.tail = this.prev
                endif
                set this.prev = 0
                set this.next = 0
            endmethod

            //======================================================================
            //  单体追逐逻辑
            //======================================================================
            private method chase takes nothing returns nothing
                local real dist = 0
                local real angle = 0
                local real col  = 0
                local real ang  = 0

                if this.mode_target_loc then 
                    set dist = DisByUnXY(this.chaser,this.target_x,this.target_y)
                    set ang  = AngleByUnXY(this.chaser,this.target_x,this.target_y)
                else 
                    set dist = DisByUnits(this.chaser,this.target)
                    set col = BlzGetUnitCollisionSize(this.target)
                    set ang = AngleByUnits(this.chaser,this.target)
                endif 
                if dist-(this.chaseDistance+BlzGetUnitCollisionSize(this.chaser)+col) > 0 then
                    set angle = ang/57.2956
                    call SetUnitX(this.chaser, GetUnitX(this.chaser) + this.chaseSpeed * 0.03 * Cos(angle))
                    call SetUnitY(this.chaser, GetUnitY(this.chaser) + this.chaseSpeed * 0.03 * Sin(angle))
                    set this.arrive = false 
                    if this.faceTarget then
                        call SetUnitFacing(this.chaser, ang)
                    endif
                else
                    set this.arrive = true 
                endif
            endmethod

            //======================================================================
            //  全局更新（每 0.03s 调用）
            //======================================================================
            static method updateAll takes nothing returns nothing
                local ChaseTarget current = thistype.head
                local ChaseTarget next
                local boolean destroy = false

                loop
                    exitwhen current == 0
                    set next = current.next

                    set destroy = false

                    if current.chaser == null or (current.mode_target_loc == false and current.target == null) or alive(current.chaser) == false or (current.mode_target_loc == false and alive(current.target) == false) then
                        set destroy = true
                    else
                        set current.elapsedTicks = current.elapsedTicks + 3
                        if current.maxTime > 0 and current.elapsedTicks >= current.maxTime then
                            set destroy = true
                        else
                            call current.chase()
                        endif
                    endif

                    if destroy or (current.arrive and current.stickOnReach == false) then
                        call current.remove()
                        call current.destroy()
                    endif

                    set current = next
                endloop
            endmethod

            //======================================================================
            //  清理
            //======================================================================
            method onDestroy takes nothing returns nothing
                set this.chaser = null
                set this.target = null
            endmethod
        endstruct
        function UnitChaseTarget takes  unit chaser, unit target, real chaseDistance, real chaseSpeed, boolean faceTarget, boolean stickOnReach, integer maxTime returns ChaseTarget
            return ChaseTarget.create(chaser,target,chaseDistance,chaseSpeed,faceTarget,stickOnReach,maxTime)
        endfunction

        globals
            private real        HOOK_PERIOD              = 0.02
            Hook eventHook = 0
        endglobals
        struct Hook
            static Hook head = 0
            Hook        next
            Hook        prev

            integer headId
            integer chainId 
            real chainDist
            real spdNormal 
            real spdDrag 
            real attachDistance

            unit    caster
            unit    dummy
            unit    target
            
            real    cx
            real    cy
            
            real    tx
            real    ty
            
            real    angle
            real    dist
            real    speed
            real    damage
            real    stun

            trigger trigOnHit 
            trigger trigOnDestroy
            
            boolean dragging
            integer chainCount
            unit    array chainLinks[100]

            static method create takes unit c returns Hook
                local Hook this = Hook.allocate()

                set this.caster     = c
                set this.cx         = GetUnitX(c)
                set this.cy         = GetUnitY(c)
                set this.dragging   = false
                set this.target     = null
                set this.dummy      = null
                set this.chainCount = 0

                set this.next = Hook.head
                if Hook.head != 0 then
                    set Hook.head.prev = this
                endif
                set Hook.head = this
                set this.prev = 0

                return this
            endmethod

            method addOnHit takes code Code returns trigger 
                if this.trigOnHit == null then 
                    set this.trigOnHit = CreateTrigger()
                endif 
                call TriggerAddActionEx(this.trigOnHit,Code)
                return this.trigOnHit
            endmethod
            method addOnDestroy takes code Code returns trigger 
                if this.trigOnDestroy == null then 
                    set this.trigOnDestroy = CreateTrigger()
                endif 
                call TriggerAddActionEx(this.trigOnDestroy,Code)
                return this.trigOnDestroy
            endmethod

            method onDestroy takes nothing returns nothing
                local integer i = 0

                if this.prev == 0 then
                    set Hook.head = this.next
                else
                    set this.prev.next = this.next
                endif
                if this.next != 0 then
                    set this.next.prev = this.prev
                endif
                if this.trigOnDestroy != null then 
                    set eventHook = this 
                    call TriggerExecute(this.trigOnDestroy)
                endif 
                call RemoveUnit(this.dummy)
                loop
                    exitwhen i >= this.chainCount
                    call RemoveUnit(this.chainLinks[i])
                    set i = i + 1
                endloop
                call DestroyTriggerEx(this.trigOnHit)
                call DestroyTriggerEx(this.trigOnDestroy)
                set this.trigOnHit = null 
                set this.trigOnDestroy = null 
                set this.caster = null
                set this.dummy  = null
                set this.target = null
                set this.trigOnHit = null 
            endmethod

            private method updateChains takes nothing returns nothing
                local real tx = GetUnitX(this.dummy)
                local real ty = GetUnitY(this.dummy)
                local real cx = GetUnitX(this.caster)
                local real cy = GetUnitY(this.caster)
                local real nowDist = SquareRoot(Pow(tx - cx, 2) + Pow(ty - cy, 2))
                local integer chainNeed = R2I(nowDist/chainDist)
                local real nx = cx
                local real ny = cy 
                local real angle = Atan2(ty-cy,tx-cx)
                local integer i = 0
                loop 
                    exitwhen (i > this.chainCount and i > chainNeed) or i > 99
                    if i <= chainNeed then 
                        if this.chainLinks[i] == null then 
                            set this.chainLinks[i] = CreateUnit(GetOwningPlayer(this.caster),chainId,nx+chainDist/2*Cos(angle),ny+chainDist/2*Sin(angle),angle*57.2956)
                        endif 
                        call SetUnitX(this.chainLinks[i],nx+chainDist/2*Cos(angle))
                        call SetUnitY(this.chainLinks[i],ny+chainDist/2*Sin(angle))
                        call SetUnitFacing(this.chainLinks[i],angle*57.2956)
                        set nx = nx+chainDist*Cos(angle)
                        set ny = ny+chainDist*Sin(angle)
                    else 
                        if this.chainLinks[i] != null then 
                            call RemoveUnit(this.chainLinks[i])
                            set this.chainLinks[i] = null 
                        endif 
                    endif 
                    set i = i+1
                endloop
                set this.chainCount = i-1
            endmethod

            private method update takes nothing returns nothing
                local real nx
                local real ny
                local real targetDist

                if this.caster == null or alive(this.caster) == false or this.target == null or alive(this.target) == false then 
                    call this.destroy()
                    return 
                endif   


                if this.dragging then
                    if DisByUnits(this.caster,this.target)-(this.attachDistance+BlzGetUnitCollisionSize(this.caster)+BlzGetUnitCollisionSize(this.target)) < 32 then
                        call this.destroy()
                        return 
                    endif 
                    set this.tx = GetUnitX(this.caster)-(this.attachDistance+BlzGetUnitCollisionSize(this.caster)+BlzGetUnitCollisionSize(this.target))*Cos(this.angle)
                    set this.ty = GetUnitY(this.caster)-(this.attachDistance+BlzGetUnitCollisionSize(this.caster)+BlzGetUnitCollisionSize(this.target))*Sin(this.angle)
                    set nx = this.tx - GetUnitX(this.target)
                    set ny = this.ty - GetUnitY(this.target)
                    call this.updateChains()
                    if SquareRoot(nx * nx + ny * ny)-spdDrag * HOOK_PERIOD <= 16 then
                        call SetUnitX(this.target, this.tx)
                        call SetUnitY(this.target, this.ty)
                        call this.destroy()
                        return
                    endif
                    set this.angle = Atan2(ny, nx)
                    call SetUnitX(this.target, GetUnitX(this.target) + spdDrag * HOOK_PERIOD * Cos(this.angle))
                    call SetUnitY(this.target, GetUnitY(this.target) + spdDrag * HOOK_PERIOD * Sin(this.angle))
                    call SetUnitX(this.dummy, GetUnitX(this.target))
                    call SetUnitY(this.dummy, GetUnitY(this.target))
                    call SetUnitFacing(this.dummy, bj_RADTODEG * Atan2(-ny,-nx))
                    return
                endif
                set this.tx = GetUnitX(this.target)
                set this.ty = GetUnitY(this.target)
                set this.cx = GetUnitX(this.caster)
                set this.cy = GetUnitY(this.caster)
                set this.angle = Atan2(this.ty-this.cy, this.tx-this.cx)
                call this.updateChains()
                set this.dist = this.dist + this.spdNormal * HOOK_PERIOD
                set targetDist = SquareRoot(Pow(this.tx - this.cx, 2) + Pow(this.ty - this.cy, 2))
                if this.dist >= targetDist then
                    if this.trigOnHit != null then 
                        set eventHook = this 
                        call TriggerExecute(this.trigOnHit)
                    endif 
                    set this.dragging = true
                    set this.tx = this.cx
                    set this.ty = this.cy
                    return
                endif

                set nx = this.cx + this.dist * Cos(this.angle)
                set ny = this.cy + this.dist * Sin(this.angle)
                call SetUnitX(this.dummy, nx)
                call SetUnitY(this.dummy, ny)
                call SetUnitFacing(this.dummy, bj_RADTODEG * this.angle)
            endmethod

            static method updateAll takes nothing returns nothing
                local Hook this = Hook.head
                local Hook nextHook

                loop
                    exitwhen this == 0
                    set nextHook = this.next
                    call this.update()
                    set this = nextHook
                endloop
            endmethod
        endstruct
        function HookTarget takes unit caster,unit target,integer headId,integer chainId,real chainDist,real spdNorm,real spdDrag,code onHit returns Hook 
            local Hook this
            set this = Hook.create(caster)
            set this.target = target
            set this.headId = headId
            set this.chainId = chainId
            set this.chainDist = chainDist
            set this.spdNormal = spdNorm
            set this.spdDrag = spdDrag
            set this.tx = GetUnitX(target)
            set this.ty = GetUnitY(target)
            set this.angle = Atan2(this.ty - this.cy, this.tx - this.cx)
            set this.dist = 0.0
            set this.dummy = CreateUnit(GetOwningPlayer(caster), this.headId, this.cx, this.cy, bj_RADTODEG * this.angle)
            if onHit != null then 
                call this.addOnHit(onHit)
            endif 
            return this 
        endfunction 

        //* 使单位向目标点突进，直到到达目标点或遇到障碍物
        //* 
        //* @param whichUnit  施法单位
        //* @param targetX    目标点X坐标
        //* @param targetY    目标点Y坐标
        //* @param maxDist    最大移动距离（0表示不限制）
        //* @return           是否成功到达目标点（true=到达，false=中途被阻挡）
        function UnitDashToPoint takes unit whichUnit, real targetX, real targetY, real maxDist returns boolean
            local real angle = AngleByUnXY(whichUnit,targetX,targetY)/57.2956
            local real totalDist = DisByUnXY(whichUnit,targetX,targetY)
            local real remaining = totalDist
            local real step
            local real nextX
            local real nextY

            if maxDist > 0 and maxDist < remaining then
                set remaining = maxDist
            endif

            loop
                exitwhen remaining <= 4
                set step = RMinBJ(8.0, remaining)
                set nextX = GetUnitX(whichUnit) + step * Cos(angle)
                set nextY = GetUnitY(whichUnit) + step * Sin(angle)

                if not PathCheck(nextX, nextY) then
                    return false
                endif

                call SetUnitX(whichUnit, nextX)
                call SetUnitY(whichUnit, nextY)
                set remaining = remaining - step
            endloop

            return true
        endfunction

        struct Bar 
            static Bar top = 0
            Bar prev 
            Bar next 
            integer timeTotal
            integer timeRemain  
            integer timeAdd     = 1
            //texttag textTag
            integer lastPer
            unit bindUnit 
            unit barDummy 
            integer colorR = 255
            integer colorG = 0
            integer colorB = 0
            integer colorA = 175

            static method create takes integer time,integer add,unit bindUnit returns Bar 
                local real x = GetUnitX(bindUnit)
                local real y = GetUnitY(bindUnit)
                local Bar this
                if time == 0 or add == 0 then 
                    return 0
                endif 
                set this = thistype.allocate()
                set this.bindUnit = bindUnit
                set this.prev = Bar.top
                if this.prev > 0 then 
                    set this.prev.next = this 
                endif 
                set this.next = 0
                set Bar.top = this 

                set this.timeAdd = add 
                set this.timeTotal = time 
                set this.timeRemain = time 
                set this.barDummy = CreateUnit(GetOwningPlayer(bindUnit),'hBAR',GetUnitX(bindUnit),GetUnitY(bindUnit),270)
                call SetUnitTimeScale(this.barDummy,1000)
                if add > 0 then 
                    set this.lastPer = 0
                    call SetUnitAnimationByIndex(this.barDummy,0)
                elseif add < 0 then 
                    set this.lastPer = 100
                    call SetUnitAnimationByIndex(this.barDummy,100)
                endif 
                call UnitAddAbility(this.barDummy,'Arav')
                call UnitRemoveAbility(this.barDummy,'Arav')
                call SetUnitFlyHeight(this.barDummy,GetUnitFlyHeight(this.bindUnit),0)
                call SetUnitVertexColor(this.barDummy,this.colorR,this.colorG,this.colorB,this.colorA)
                //call BJDebugMsg("BAR CREATED: "+I2S(this)+", UNIT HANDLE IS: "+I2S(GetHandleId(this.dummy)))
                return this 
            endmethod

            method onDestroy takes nothing returns nothing
                //call BJDebugMsg("BAR DESTROY: "+I2S(this)+", UNIT HANDLE IS: "+I2S(GetHandleId(this.dummy)))
                call RemoveUnit(this.barDummy)
                set this.barDummy = null 
                set this.bindUnit = null 
                if thistype.top == this then 
                    set thistype.top = this.prev 
                endif 
                if this.next > 0 then 
                    set this.next.prev = this.prev 
                endif 
                if this.prev > 0 then 
                    set this.prev.next = this.next 
                endif 
            endmethod

            private method update takes nothing returns nothing
                local integer animId
                local real x = GetUnitX(this.bindUnit)
                local real y = GetUnitY(this.bindUnit)

                set this.timeRemain = this.timeRemain-1
                set animId = this.timeRemain*100/this.timeTotal
                if this.timeAdd > 0 then 
                    set animId = 100-animId
                endif 
                if animId != this.lastPer then 
                    set this.lastPer = animId
                    call SetUnitAnimationByIndex(this.barDummy,animId)
                endif 
                call SetUnitX(this.barDummy,x)
                call SetUnitY(this.barDummy,y)
                call SetUnitVertexColor(this.barDummy,this.colorR,this.colorG,this.colorB,this.colorA)
                call SetUnitFlyHeight(this.barDummy,GetUnitFlyHeight(this.bindUnit),0)

                //call BJDebugMsg("BAR: "+I2S(this)+" SET ANIM TO: "+I2S(animId))
                if this.timeRemain <= 0 or this.bindUnit == null or alive(this.bindUnit) == false then 
                    call this.destroy()
                    //call BJDebugMsg("BAR: "+I2S(this)+" TIME OUT")
                endif 
            endmethod

            static method updateAll takes nothing returns nothing
                local thistype this = thistype.top 
                loop
                    exitwhen this == 0
                    call this.update()
                    set this = this.prev 
                endloop
            endmethod
        endstruct
        function CreateBar takes integer timeTotal,integer addTime,unit bindUnit returns Bar 
            return Bar.create(timeTotal,addTime,bindUnit)
        endfunction
        function SetBarColor takes Bar whichBar,integer R,integer G,integer B,integer A returns Bar 
            set whichBar.colorR = R
            set whichBar.colorG = G
            set whichBar.colorB = B
            set whichBar.colorA = A 
            return whichBar
        endfunction

        globals
            real    ORBIT_PERIOD              = 0.03
            real    ORBIT_DEFAULT_RADIUS      = 200.0
            real    ORBIT_DEFAULT_ANGULAR_SPEED = 2.0 * bj_PI / 5.0  // 5秒一圈
        endglobals
        struct Orbit
            static Orbit head = 0
            Orbit   next
            Orbit   prev

            unit    center
            integer count
            integer flag = 0
            real    radius
            real    angularSpeed
            real    currentAngle

            unit    array satellites[12]
            effect  array bindSFX[12]
            real    array offsets[12]      // 当前角度（用于平滑过渡 + 持续环绕）
            real    array targetOffsets[12] // 目标角度（等分位置）

            static method create takes unit centerUnit returns Orbit
                local Orbit this = Orbit.allocate()

                set this.center       = centerUnit
                set this.count        = 0
                set this.radius       = ORBIT_DEFAULT_RADIUS
                set this.angularSpeed = ORBIT_DEFAULT_ANGULAR_SPEED
                set this.currentAngle = GetUnitFacing(centerUnit)/57.2956

                set this.next = Orbit.head
                if Orbit.head != 0 then
                    set Orbit.head.prev = this
                endif
                set Orbit.head = this
                set this.prev = 0

                return this
            endmethod

            method destroy takes nothing returns nothing
                local integer i = 0

                if this.prev == 0 then
                    set Orbit.head = this.next
                else
                    set this.prev.next = this.next
                endif
                if this.next != 0 then
                    set this.next.prev = this.prev
                endif

                loop
                    exitwhen i >= this.count
                    call DestroyEffectEX(this.bindSFX[i])
                    call RemoveUnit(this.satellites[i])
                    set i = i + 1
                endloop

                set this.center       = null
                set this.count        = 0
                set this.radius       = 0.0
                set this.angularSpeed = 0.0
            endmethod

            method addSatellite takes unit satellite returns nothing
                local integer i
                local real    angleStep

                if this.count >= 12 then
                    return
                endif

                set this.satellites[this.count] = satellite
                set this.count = this.count + 1

                // 计算等分角度步长
                set angleStep = 2.0 * bj_PI / this.count

                // 重新计算所有单位的目标角度（以 currentAngle 为基准）
                set i = 0
                loop
                    exitwhen i >= this.count
                    set this.targetOffsets[i] = this.currentAngle + angleStep * i
                    set i = i + 1
                endloop

                // 新单位立即设置到目标位置（避免初始错位）
                set this.offsets[this.count-1] = this.targetOffsets[this.count-1]
            endmethod

            method removeSatellite takes unit satellite returns nothing
                local integer i = 0
                local integer j

                loop
                    exitwhen i >= this.count
                    if this.satellites[i] == satellite then
                        exitwhen true
                    endif
                    set i = i + 1
                endloop

                if i >= this.count then
                    return
                endif

                set this.count = this.count - 1

                if this.count > 0 then
                    set j = i
                    loop
                        exitwhen j >= this.count
                        set this.satellites[j] = this.satellites[j + 1]
                        set this.offsets[j] = this.offsets[j + 1]
                        set this.targetOffsets[j] = this.targetOffsets[j + 1]
                        set j = j + 1
                    endloop

                    // 重新计算剩余单位的目标角度
                    set i = 0
                    loop
                        exitwhen i >= this.count
                        set this.targetOffsets[i] = this.currentAngle + (2.0 * bj_PI / this.count) * i
                        set i = i + 1
                    endloop
                endif
            endmethod

            method pickTopSatellite takes nothing returns unit
                return this.satellites[this.count-1]
            endmethod

            method updatePositions takes nothing returns nothing
                local integer i = 0
                local real    angle
                local real    x
                local real    y

                loop
                    exitwhen i >= this.count
                    set angle = this.offsets[i]+this.currentAngle
                    set x = GetUnitX(this.center) + this.radius * Cos(angle)
                    set y = GetUnitY(this.center) + this.radius * Sin(angle)
                    call SetUnitX(this.satellites[i], x)
                    call SetUnitY(this.satellites[i], y)
                    if this.angularSpeed > 0 then 
                        call SetUnitFacing(this.satellites[i], bj_RADTODEG * (angle+90))
                    else 
                        call SetUnitFacing(this.satellites[i], bj_RADTODEG * (angle-90))
                    endif 
                    set i = i + 1
                endloop
            endmethod

            method update takes nothing returns nothing
                local integer i

                if this.count == 0 or alive(this.center) == false or this.center == null then
                    call this.destroy()
                    return
                endif

                // 整体旋转：所有单位都跟随 currentAngle 旋转
                set this.currentAngle = this.currentAngle + this.angularSpeed * ORBIT_PERIOD

                // 平滑过渡：offsets 逐渐靠近 targetOffsets
                set i = 0
                loop
                    exitwhen i >= this.count
                    set this.offsets[i] = this.offsets[i] + (this.targetOffsets[i] - this.offsets[i]) * 0.1
                    set i = i + 1
                endloop

                call this.updatePositions()
            endmethod

            static method updateAll takes nothing returns nothing
                local Orbit this = Orbit.head
                local Orbit nextOrbit

                loop
                    exitwhen this == 0
                    set nextOrbit = this.next
                    call this.update()
                    set this = nextOrbit
                endloop
            endmethod
        endstruct
        function CreateOrbit takes unit whichUnit,real radius,real angularSpeed,integer counts,integer typeId returns Orbit
            local Orbit this = Orbit.create(whichUnit)
            set this.radius = radius
            set this.angularSpeed = angularSpeed
            loop
                exitwhen counts <= 0
                call this.addSatellite(CreateUnit(GetOwningPlayer(whichUnit),typeId,GetUnitX(whichUnit),GetUnitY(whichUnit),GetUnitFacing(whichUnit)))
                set counts = counts-1
            endloop
            set whichUnit = null 
            return this 
        endfunction

        globals
            hashtable equipHash = InitHashtable()
            Equipment eventEquipment = 0
            unit      eventEquipmentOwner = null 
        endglobals
        //装备类型，拥有至多7项属性加成，可用设置各种callback
        struct EquipType 
            // region EquipTypeSettings
            integer itemTypeId 
            integer requireLevel
            integer class 

            string desc 
            string insc
            string name 
            ItemSetType inSet

            State bonusWhichState1 
            integer bonusWhichMode1 
            integer bonusWhichValue1 
            State bonusWhichState2 
            integer bonusWhichMode2 
            integer bonusWhichValue2 
            State bonusWhichState3 
            integer bonusWhichMode3 
            integer bonusWhichValue3 
            State bonusWhichState4 
            integer bonusWhichMode4 
            integer bonusWhichValue4 
            State bonusWhichState5 
            integer bonusWhichMode5 
            integer bonusWhichValue5 
            State bonusWhichState6 
            integer bonusWhichMode6 
            integer bonusWhichValue6 
            State bonusWhichState7 
            integer bonusWhichMode7 
            integer bonusWhichValue7 
            integer amuletBindAbility

            trigger trigBeforedamageSource = null
            trigger trigBeforedamageTarget  = null
            trigger trigPredamageSource = null
            trigger trigPredamageTarget = null
            trigger trigDamagingSource  = null
            trigger trigDamagingTarget = null
            trigger trigDamagedSource = null
            trigger trigDamagedTarget  = null
            trigger trigAfterdamageSource = null
            trigger trigAfterdamageTarget = null

            trigger trigBeforehealSource = null
            trigger trigBeforehealTarget  = null
            trigger trigPreHealSource = null
            trigger trigPreHealTarget = null
            trigger trigHealingSource  = null
            trigger trigHealingTarget = null
            trigger trigHealedSource = null
            trigger trigHealedTarget  = null
            trigger trigAfterhealSource = null
            trigger trigAfterhealTarget = null

            trigger trigAttackedSource  = null
            trigger trigAttackedTarget  = null
            trigger trigAttacking = null
            trigger trigMissileLaunch = null
            trigger trigMissileHitSource = null
            trigger trigMissileHitTarget  = null
            trigger trigSpelling  = null

            trigger trigEquipOn = null
            trigger trigTakeOff = null
            // endregion 

            static method create takes integer itemTypeId returns EquipType
                local thistype this = thistype.allocate()
                set this.itemTypeId = itemTypeId
                call SaveInteger(equipHash,itemTypeId,0,this)
                return this 
            endmethod

            method setDescription takes string desc returns nothing
                set this.desc = desc 
            endmethod

            method setInscription takes string insc returns nothing
                set this.insc = "\n|cff888888"+insc+"|r"
            endmethod

            
            method addEquipOn takes code action returns nothing
                local trigger newTrig = this.trigEquipOn
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigEquipOn = newTrig
                set newTrig = null 
            endmethod
            method addTakeOff takes code action returns nothing
                local trigger newTrig = this.trigTakeOff
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigTakeOff = newTrig
                set newTrig = null 
            endmethod
            method addBefDmg_S takes code action returns nothing
                local trigger newTrig = this.trigBeforedamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforedamageSource = newTrig
                set newTrig = null 
            endmethod
            method addBefDmg_T takes code action returns nothing
                local trigger newTrig = this.trigBeforedamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforedamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addPreDmg_S takes code action returns nothing
                local trigger newTrig = this.trigPredamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPredamageSource = newTrig
                set newTrig = null 
            endmethod
            method addPreDmg_T takes code action returns nothing
                local trigger newTrig = this.trigPredamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPredamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addDmging_S takes code action returns nothing
                local trigger newTrig = this.trigDamagingSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagingSource = newTrig
                set newTrig = null 
            endmethod
            method addDmging_T takes code action returns nothing
                local trigger newTrig = this.trigDamagingTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagingTarget = newTrig
                set newTrig = null 
            endmethod

            method addDmged_S takes code action returns nothing
                local trigger newTrig = this.trigDamagedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagedSource = newTrig
                set newTrig = null 
            endmethod
            method addDmged_T takes code action returns nothing
                local trigger newTrig = this.trigDamagedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagedTarget = newTrig
                set newTrig = null 
            endmethod

            method addAftDmg_S takes code action returns nothing
                local trigger newTrig = this.trigAfterdamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterdamageSource = newTrig
                set newTrig = null 
            endmethod
            method addAftDmg_T takes code action returns nothing
                local trigger newTrig = this.trigAfterdamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterdamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addBefHeal_S takes code action returns nothing
                local trigger newTrig = this.trigBeforehealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforehealSource = newTrig
                set newTrig = null 
            endmethod
            method addBefHeal_T takes code action returns nothing
                local trigger newTrig = this.trigBeforehealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforehealTarget = newTrig
                set newTrig = null 
            endmethod

            method addPreHeal_S takes code action returns nothing
                local trigger newTrig = this.trigPreHealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPreHealSource = newTrig
                set newTrig = null 
            endmethod
            method addPreHeal_T takes code action returns nothing
                local trigger newTrig = this.trigPreHealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPreHealTarget = newTrig
                set newTrig = null 
            endmethod

            method addHealing_S takes code action returns nothing
                local trigger newTrig = this.trigHealingSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealingSource = newTrig
                set newTrig = null 
            endmethod
            method addHealing_T takes code action returns nothing
                local trigger newTrig = this.trigHealingTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealingTarget = newTrig
                set newTrig = null 
            endmethod

            method addHealed_S takes code action returns nothing
                local trigger newTrig = this.trigHealedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealedSource = newTrig
                set newTrig = null 
            endmethod
            method addHealed_T takes code action returns nothing
                local trigger newTrig = this.trigHealedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealedTarget = newTrig
                set newTrig = null 
            endmethod

            method addAftHeal_S takes code action returns nothing
                local trigger newTrig = this.trigAfterhealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterhealSource = newTrig
                set newTrig = null 
            endmethod
            method addAftHeal_T takes code action returns nothing
                local trigger newTrig = this.trigAfterhealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterhealTarget = newTrig
                set newTrig = null 
            endmethod

            method addAtking takes code action returns nothing
                local trigger newTrig = this.trigAttacking
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttacking = newTrig
                set newTrig = null 
            endmethod

            method addAtked_S takes code action returns nothing
                local trigger newTrig = this.trigAttackedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttackedSource = newTrig
                set newTrig = null 
            endmethod
            method addAtked_T takes code action returns nothing
                local trigger newTrig = this.trigAttackedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttackedTarget = newTrig
                set newTrig = null 
            endmethod

            method addMslLnch takes code action returns nothing
                local trigger newTrig = this.trigMissileLaunch
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileLaunch = newTrig
                set newTrig = null 
            endmethod
            method addSpelling takes code action returns nothing
                local trigger newTrig = this.trigSpelling
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigSpelling = newTrig
                set newTrig = null 
            endmethod

            method addMslHit_S takes code action returns nothing
                local trigger newTrig = this.trigMissileHitSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileHitSource = newTrig
                set newTrig = null 
            endmethod
            method addMslHit_T takes code action returns nothing
                local trigger newTrig = this.trigMissileHitTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileHitTarget = newTrig
                set newTrig = null 
            endmethod

        endstruct
        
        function CreateEquipType takes integer itemTypeId,integer requireLevel,integer class,integer amuletAbility,State st1,integer stMode1,integer stValue1,State st2,integer stMode2,integer stValue2,State st3,integer stMode3,integer stValue3,State st4,integer stMode4,integer stValue4,State st5,integer stMode5,integer stValue5,State st6,integer stMode6,integer stValue6,State st7,integer stMode7,integer stValue7 returns EquipType
            local EquipType this = EquipType.create(itemTypeId)
            set this.requireLevel = requireLevel
            set this.class = class 
            set this.amuletBindAbility  = amuletAbility 
            set this.bonusWhichState1   = st1 
            set this.bonusWhichMode1    = stMode1
            set this.bonusWhichValue1   = stValue1
            set this.bonusWhichState2   = st2
            set this.bonusWhichMode2    = stMode2
            set this.bonusWhichValue2   = stValue2
            set this.bonusWhichState3   = st3
            set this.bonusWhichMode3    = stMode3
            set this.bonusWhichValue3   = stValue3
            set this.bonusWhichState4   = st4
            set this.bonusWhichMode4    = stMode4
            set this.bonusWhichValue4   = stValue4
            set this.bonusWhichState5   = st5
            set this.bonusWhichMode5    = stMode5
            set this.bonusWhichValue5   = stValue5
            set this.bonusWhichState6   = st6
            set this.bonusWhichMode6    = stMode6
            set this.bonusWhichValue6   = stValue6
            set this.bonusWhichState7   = st7
            set this.bonusWhichMode7    = stMode7
            set this.bonusWhichValue7   = stValue7
            return this 
        endfunction

        globals
            hashtable encHash = InitHashtable()
        endglobals
        //附魔，拥有至多3项属性加成，可以设置各种时点callback
        struct Enchantment
            // region EquipTypeSettings
            string desc 

            State bonusWhichState1 
            integer bonusWhichMode1 
            integer bonusWhichValue1 
            State bonusWhichState2 
            integer bonusWhichMode2 
            integer bonusWhichValue2 
            State bonusWhichState3 
            integer bonusWhichMode3 
            integer bonusWhichValue3 

            trigger trigBeforedamageSource = null
            trigger trigBeforedamageTarget  = null
            trigger trigPredamageSource = null
            trigger trigPredamageTarget = null
            trigger trigDamagingSource  = null
            trigger trigDamagingTarget = null
            trigger trigDamagedSource = null
            trigger trigDamagedTarget  = null
            trigger trigAfterdamageSource = null
            trigger trigAfterdamageTarget = null

            trigger trigBeforehealSource = null
            trigger trigBeforehealTarget  = null
            trigger trigPreHealSource = null
            trigger trigPreHealTarget = null
            trigger trigHealingSource  = null
            trigger trigHealingTarget = null
            trigger trigHealedSource = null
            trigger trigHealedTarget  = null
            trigger trigAfterhealSource = null
            trigger trigAfterhealTarget = null

            trigger trigAttackedSource  = null
            trigger trigAttackedTarget  = null
            trigger trigAttacking = null
            trigger trigMissileLaunch = null
            trigger trigMissileHitSource = null
            trigger trigMissileHitTarget  = null
            trigger trigSpelling  = null

            trigger trigEquipOn = null
            trigger trigTakeOff = null
            // endregion 
            method setDescription takes string desc returns nothing
                set this.desc = desc 
            endmethod

            static method create takes integer index,State st1,integer mode1,integer value1,State st2,integer mode2,integer value2,State st3,integer mode3,integer value3 returns Enchantment
                local thistype this = thistype.allocate()
                set this.bonusWhichState1 = st1 
                set this.bonusWhichMode1 = mode1 
                set this.bonusWhichValue1 = value1
                set this.bonusWhichState2 = st2
                set this.bonusWhichMode2 = mode2
                set this.bonusWhichValue2 = value2
                set this.bonusWhichState3 = st3
                set this.bonusWhichMode3 = mode3
                set this.bonusWhichValue3 = value3
                call SaveInteger(encHash,0,index,this)
                call SaveInteger(encHash,1,this,index)
                return this
            endmethod

            
            method addEquipOn takes code action returns nothing
                local trigger newTrig = this.trigEquipOn
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigEquipOn = newTrig
                set newTrig = null 
            endmethod
            method addTakeOff takes code action returns nothing
                local trigger newTrig = this.trigTakeOff
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigTakeOff = newTrig
                set newTrig = null 
            endmethod
            method addBefDmg_S takes code action returns nothing
                local trigger newTrig = this.trigBeforedamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforedamageSource = newTrig
                set newTrig = null 
            endmethod
            method addBefDmg_T takes code action returns nothing
                local trigger newTrig = this.trigBeforedamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforedamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addPreDmg_S takes code action returns nothing
                local trigger newTrig = this.trigPredamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPredamageSource = newTrig
                set newTrig = null 
            endmethod
            method addPreDmg_T takes code action returns nothing
                local trigger newTrig = this.trigPredamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPredamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addDmging_S takes code action returns nothing
                local trigger newTrig = this.trigDamagingSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagingSource = newTrig
                set newTrig = null 
            endmethod
            method addDmging_T takes code action returns nothing
                local trigger newTrig = this.trigDamagingTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagingTarget = newTrig
                set newTrig = null 
            endmethod

            method addDmged_S takes code action returns nothing
                local trigger newTrig = this.trigDamagedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagedSource = newTrig
                set newTrig = null 
            endmethod
            method addDmged_T takes code action returns nothing
                local trigger newTrig = this.trigDamagedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagedTarget = newTrig
                set newTrig = null 
            endmethod

            method addAftDmg_S takes code action returns nothing
                local trigger newTrig = this.trigAfterdamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterdamageSource = newTrig
                set newTrig = null 
            endmethod
            method addAftDmg_T takes code action returns nothing
                local trigger newTrig = this.trigAfterdamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterdamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addBefHeal_S takes code action returns nothing
                local trigger newTrig = this.trigBeforehealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforehealSource = newTrig
                set newTrig = null 
            endmethod
            method addBefHeal_T takes code action returns nothing
                local trigger newTrig = this.trigBeforehealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforehealTarget = newTrig
                set newTrig = null 
            endmethod

            method addPreHeal_S takes code action returns nothing
                local trigger newTrig = this.trigPreHealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPreHealSource = newTrig
                set newTrig = null 
            endmethod
            method addPreHeal_T takes code action returns nothing
                local trigger newTrig = this.trigPreHealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPreHealTarget = newTrig
                set newTrig = null 
            endmethod

            method addHealing_S takes code action returns nothing
                local trigger newTrig = this.trigHealingSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealingSource = newTrig
                set newTrig = null 
            endmethod
            method addHealing_T takes code action returns nothing
                local trigger newTrig = this.trigHealingTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealingTarget = newTrig
                set newTrig = null 
            endmethod

            method addHealed_S takes code action returns nothing
                local trigger newTrig = this.trigHealedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealedSource = newTrig
                set newTrig = null 
            endmethod
            method addHealed_T takes code action returns nothing
                local trigger newTrig = this.trigHealedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealedTarget = newTrig
                set newTrig = null 
            endmethod

            method addAftHeal_S takes code action returns nothing
                local trigger newTrig = this.trigAfterhealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterhealSource = newTrig
                set newTrig = null 
            endmethod
            method addAftHeal_T takes code action returns nothing
                local trigger newTrig = this.trigAfterhealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterhealTarget = newTrig
                set newTrig = null 
            endmethod

            method addAtking takes code action returns nothing
                local trigger newTrig = this.trigAttacking
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttacking = newTrig
                set newTrig = null 
            endmethod

            method addAtked_S takes code action returns nothing
                local trigger newTrig = this.trigAttackedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttackedSource = newTrig
                set newTrig = null 
            endmethod
            method addAtked_T takes code action returns nothing
                local trigger newTrig = this.trigAttackedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttackedTarget = newTrig
                set newTrig = null 
            endmethod

            method addMslLnch takes code action returns nothing
                local trigger newTrig = this.trigMissileLaunch
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileLaunch = newTrig
                set newTrig = null 
            endmethod
            method addSpelling takes code action returns nothing
                local trigger newTrig = this.trigSpelling
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigSpelling = newTrig
                set newTrig = null 
            endmethod

            method addMslHit_S takes code action returns nothing
                local trigger newTrig = this.trigMissileHitSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileHitSource = newTrig
                set newTrig = null 
            endmethod
            method addMslHit_T takes code action returns nothing
                local trigger newTrig = this.trigMissileHitTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileHitTarget = newTrig
                set newTrig = null 
            endmethod

        endstruct
        function GetEncById takes integer i returns Enchantment
            if i == 0 then 
                return 0
            endif 
            return LoadInteger(encHash,0,i)
        endfunction
        function GetIdByEnc takes Enchantment e returns integer
            if e == 0 then 
                return 0
            endif 
            return LoadInteger(encHash,1,e)
        endfunction
        //套装效果，拥有至多3项属性加成，可以设置各种时点callback
        struct ItemSetEffect
            // region EquipTypeSettings
            string desc 

            State bonusWhichState1 
            integer bonusWhichMode1 
            integer bonusWhichValue1 
            State bonusWhichState2 
            integer bonusWhichMode2 
            integer bonusWhichValue2 
            State bonusWhichState3 
            integer bonusWhichMode3 
            integer bonusWhichValue3 

            trigger trigBeforedamageSource = null
            trigger trigBeforedamageTarget  = null
            trigger trigPredamageSource = null
            trigger trigPredamageTarget = null
            trigger trigDamagingSource  = null
            trigger trigDamagingTarget = null
            trigger trigDamagedSource = null
            trigger trigDamagedTarget  = null
            trigger trigAfterdamageSource = null
            trigger trigAfterdamageTarget = null

            trigger trigBeforehealSource = null
            trigger trigBeforehealTarget  = null
            trigger trigPreHealSource = null
            trigger trigPreHealTarget = null
            trigger trigHealingSource  = null
            trigger trigHealingTarget = null
            trigger trigHealedSource = null
            trigger trigHealedTarget  = null
            trigger trigAfterhealSource = null
            trigger trigAfterhealTarget = null

            trigger trigAttackedSource  = null
            trigger trigAttackedTarget  = null
            trigger trigAttacking = null
            trigger trigMissileLaunch = null
            trigger trigMissileHitSource = null
            trigger trigMissileHitTarget  = null
            trigger trigSpelling  = null

            trigger trigEquipOn  = null
            trigger trigTakeOff = null
            // endregion 
            static method create takes State st1,integer mode1,integer value1,State st2,integer mode2,integer value2,State st3,integer mode3,integer value3 returns ItemSetEffect
                local thistype this = thistype.allocate()
                set this.bonusWhichState1 = st1 
                set this.bonusWhichMode1 = mode1 
                set this.bonusWhichValue1 = value1
                set this.bonusWhichState2 = st2
                set this.bonusWhichMode2 = mode2 
                set this.bonusWhichValue2 = value2
                set this.bonusWhichState3 = st3
                set this.bonusWhichMode3 = mode3 
                set this.bonusWhichValue3 = value3

                return this 
            endmethod

            method setDescription takes string desc returns nothing
                set this.desc = desc 
            endmethod

            method applyState takes unit whichUnit returns nothing
                if whichUnit == armoury then 
                    return 
                endif 
                call this.bonusWhichState1.addStateSimple(whichUnit,this.bonusWhichMode1,this.bonusWhichValue1)
                call this.bonusWhichState2.addStateSimple(whichUnit,this.bonusWhichMode2,this.bonusWhichValue2)
                call this.bonusWhichState3.addStateSimple(whichUnit,this.bonusWhichMode3,this.bonusWhichValue3)
                call State.checkAll.evaluate(whichUnit)
            endmethod
            method removeState takes unit whichUnit returns nothing
                if whichUnit == armoury then 
                    return 
                endif 
                call this.bonusWhichState1.addStateSimple(whichUnit,this.bonusWhichMode1,0-this.bonusWhichValue1)
                call this.bonusWhichState2.addStateSimple(whichUnit,this.bonusWhichMode2,0-this.bonusWhichValue2)
                call this.bonusWhichState3.addStateSimple(whichUnit,this.bonusWhichMode3,0-this.bonusWhichValue3)
                call State.checkAll.evaluate(whichUnit)
            endmethod
            

            method addEquipOn takes code action returns nothing
                local trigger newTrig = this.trigEquipOn
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigEquipOn = newTrig
                set newTrig = null 
            endmethod
            method addTakeOff takes code action returns nothing
                local trigger newTrig = this.trigTakeOff
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigTakeOff = newTrig
                set newTrig = null 
            endmethod

            method addBefDmg_S takes code action returns nothing
                local trigger newTrig = this.trigBeforedamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforedamageSource = newTrig
                set newTrig = null 
            endmethod
            method addBefDmg_T takes code action returns nothing
                local trigger newTrig = this.trigBeforedamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforedamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addPreDmg_S takes code action returns nothing
                local trigger newTrig = this.trigPredamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPredamageSource = newTrig
                set newTrig = null 
            endmethod
            method addPreDmg_T takes code action returns nothing
                local trigger newTrig = this.trigPredamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPredamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addDmging_S takes code action returns nothing
                local trigger newTrig = this.trigDamagingSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagingSource = newTrig
                set newTrig = null 
            endmethod
            method addDmging_T takes code action returns nothing
                local trigger newTrig = this.trigDamagingTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagingTarget = newTrig
                set newTrig = null 
            endmethod

            method addDmged_S takes code action returns nothing
                local trigger newTrig = this.trigDamagedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagedSource = newTrig
                set newTrig = null 
            endmethod
            method addDmged_T takes code action returns nothing
                local trigger newTrig = this.trigDamagedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagedTarget = newTrig
                set newTrig = null 
            endmethod

            method addAftDmg_S takes code action returns nothing
                local trigger newTrig = this.trigAfterdamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterdamageSource = newTrig
                set newTrig = null 
            endmethod
            method addAftDmg_T takes code action returns nothing
                local trigger newTrig = this.trigAfterdamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterdamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addBefHeal_S takes code action returns nothing
                local trigger newTrig = this.trigBeforehealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforehealSource = newTrig
                set newTrig = null 
            endmethod
            method addBefHeal_T takes code action returns nothing
                local trigger newTrig = this.trigBeforehealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforehealTarget = newTrig
                set newTrig = null 
            endmethod

            method addPreHeal_S takes code action returns nothing
                local trigger newTrig = this.trigPreHealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPreHealSource = newTrig
                set newTrig = null 
            endmethod
            method addPreHeal_T takes code action returns nothing
                local trigger newTrig = this.trigPreHealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPreHealTarget = newTrig
                set newTrig = null 
            endmethod

            method addHealing_S takes code action returns nothing
                local trigger newTrig = this.trigHealingSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealingSource = newTrig
                set newTrig = null 
            endmethod
            method addHealing_T takes code action returns nothing
                local trigger newTrig = this.trigHealingTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealingTarget = newTrig
                set newTrig = null 
            endmethod

            method addHealed_S takes code action returns nothing
                local trigger newTrig = this.trigHealedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealedSource = newTrig
                set newTrig = null 
            endmethod
            method addHealed_T takes code action returns nothing
                local trigger newTrig = this.trigHealedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealedTarget = newTrig
                set newTrig = null 
            endmethod

            method addAftHeal_S takes code action returns nothing
                local trigger newTrig = this.trigAfterhealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterhealSource = newTrig
                set newTrig = null 
            endmethod
            method addAftHeal_T takes code action returns nothing
                local trigger newTrig = this.trigAfterhealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterhealTarget = newTrig
                set newTrig = null 
            endmethod

            method addAtking takes code action returns nothing
                local trigger newTrig = this.trigAttacking
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttacking = newTrig
                set newTrig = null 
            endmethod

            method addAtked_S takes code action returns nothing
                local trigger newTrig = this.trigAttackedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttackedSource = newTrig
                set newTrig = null 
            endmethod
            method addAtked_T takes code action returns nothing
                local trigger newTrig = this.trigAttackedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttackedTarget = newTrig
                set newTrig = null 
            endmethod

            method addMslLnch takes code action returns nothing
                local trigger newTrig = this.trigMissileLaunch
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileLaunch = newTrig
                set newTrig = null 
            endmethod
            method addSpelling takes code action returns nothing
                local trigger newTrig = this.trigSpelling
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigSpelling = newTrig
                set newTrig = null 
            endmethod

            method addMslHit_S takes code action returns nothing
                local trigger newTrig = this.trigMissileHitSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileHitSource = newTrig
                set newTrig = null 
            endmethod
            method addMslHit_T takes code action returns nothing
                local trigger newTrig = this.trigMissileHitTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileHitTarget = newTrig
                set newTrig = null 
            endmethod

        endstruct
        //套装，可拥有2/4/6件套效果，并注册至多40件装备
        struct ItemSetType 
            string name 
            //2件效果
            ItemSetEffect eff2
            //4件效果
            ItemSetEffect eff4
            //6件套效
            ItemSetEffect eff6

            static method create takes string name returns ItemSetType
                local thistype this = thistype.allocate()
                set this.name = name 
                return this 
            endmethod

            method get takes unit whichUnit returns thistype
                return LoadInteger(equipHash,GetHandleId(whichUnit),100+this)
            endmethod

            method setEff2 takes ItemSetEffect eff returns nothing
                set this.eff2 = eff
            endmethod
            method setEff4 takes ItemSetEffect eff returns nothing
                set this.eff4 = eff
            endmethod
            method setEff6 takes ItemSetEffect eff returns nothing
                set this.eff6 = eff
            endmethod

            static method delayedChangeEquipmentAbility takes nothing returns nothing
                local delayedevent de = delayedevent.currentEvent
                local Equipment eq = de.loadInteger("EQUIP")
                local integer baseItem = slot2BaseItem(eq.bindUnit,eq.bindSlot)
                call BlzSetAbilityExtendedTooltip(baseItem,eq.getDesc(),0)
            endmethod

            method checkSet takes unit whichHero returns integer
                local integer i = 0 
                local integer count = 0
                local delayedevent de
                local EquipType et
                loop 
                    exitwhen i > 9
                    set et = GetEquipedItem(whichHero,i).type
                    if et > 0 and et.inSet == this then 
                        set count = count+1
                        set de = delayedevent.create(1,1,function thistype.delayedChangeEquipmentAbility)
                        call de.saveInteger("EQUIP",GetEquipedItem(whichHero,i))
                    endif 
                    set i = i+1
                endloop
                return count
            endmethod

            method getDesc takes nothing returns string
                local string color2 = ""
                local string color4 = ""
                local string color6 = ""
                local string desc2  = ""
                local string desc4  = ""
                local string desc6  = "" 
                if this.eff2 != 0 then 
                    set color2 = "\n|cff888888(2)"
                    set desc2 = color2+this.eff2.desc+"|r"
                endif 
                if this.eff4 != 0 then 
                    set color4 = "\n|cff888888(4)"
                    set desc4 = color4+this.eff4.desc+"|r"
                endif 
                if this.eff6 != 0 then 
                    set color6 = "\n|cff888888(6)"
                    set desc6 = color6+this.eff6.desc+"|r"
                endif 
                return "\n\n|cff1eff00套装："+this.name+"|r"+desc2+desc4+desc6
            endmethod
        endstruct   
        struct ItemSet
            ItemSetType type 
            unit bindUnit = null 
            boolean addedEffSt2 = false 
            boolean addedEffSt4 = false 
            boolean addedEffSt6 = false 

            static method create takes unit bindUnit,ItemSetType whichType returns ItemSet 
                local thistype this = LoadInteger(equipHash,GetHandleId(bindUnit),100+whichType)
                if this == 0 then 
                    set this = thistype.allocate()
                    set this.bindUnit = bindUnit
                    set this.type = whichType
                    call SaveInteger(equipHash,GetHandleId(bindUnit),100+whichType,this)
                endif 
                return this 
            endmethod

            method onDestroy takes nothing returns nothing
                call SaveInteger(equipHash,GetHandleId(bindUnit),100+this.type,0)
            endmethod

            method checkSet takes integer now returns nothing
                local integer count = now+this.type.checkSet(this.bindUnit)
                if count >= 2 and this.addedEffSt2 == false then 
                    set this.addedEffSt2 = true 
                    call this.type.eff2.applyState(this.bindUnit)
                    if this.type.eff2.trigEquipOn != null then 
                        call TriggerExecute(this.type.eff2.trigEquipOn)
                    endif 
                elseif count < 2 and this.addedEffSt2 == true then 
                    set this.addedEffSt2 = false 
                    call this.type.eff2.removeState(this.bindUnit)
                    if this.type.eff2.trigTakeOff != null then 
                        call TriggerExecute(this.type.eff2.trigTakeOff)
                    endif 
                endif 
                if count >= 4 and this.addedEffSt4 == false then 
                    set this.addedEffSt4 = true 
                    call this.type.eff4.applyState(this.bindUnit)
                    if this.type.eff4.trigEquipOn != null then 
                        call TriggerExecute(this.type.eff4.trigEquipOn)
                    endif 
                elseif count < 4 and this.addedEffSt4 == true then 
                    set this.addedEffSt4 = false 
                    call this.type.eff4.removeState(this.bindUnit)
                    if this.type.eff4.trigTakeOff != null then 
                        call TriggerExecute(this.type.eff4.trigTakeOff)
                    endif 
                endif 
                if count >= 6 and this.addedEffSt6 == false then 
                    set this.addedEffSt6 = true 
                    call this.type.eff6.applyState(this.bindUnit)
                    if this.type.eff6.trigEquipOn != null then 
                        call TriggerExecute(this.type.eff6.trigEquipOn)
                    endif 
                elseif count < 6 and this.addedEffSt6 == true then 
                    set this.addedEffSt6 = false 
                    call this.type.eff6.removeState(this.bindUnit)
                    if this.type.eff6.trigTakeOff != null then 
                        call TriggerExecute(this.type.eff6.trigTakeOff)
                    endif 
                endif 
                if count == 0 then 
                    call this.destroy()
                endif 
            endmethod

            method getDesc takes nothing returns string
                local string color2 = ""
                local string color4 = ""
                local string color6 = ""
                local string desc2  = ""
                local string desc4  = ""
                local string desc6  = "" 
                if this.type.eff2 != 0 then 
                    if this.addedEffSt2 then 
                        set color2 = "\n|cfffeebbe(2)"
                    else 
                        set color2 = "\n|cff888888(2)"
                    endif 
                    set desc2 = color2+this.type.eff2.desc+"|r"
                endif 
                if this.type.eff4 != 0 then 
                    if this.addedEffSt4 then 
                        set color4 = "\n|cfffeebbe(4)"
                    else 
                        set color4 = "\n|cff888888(4)"
                    endif 
                    set desc4 = color4+this.type.eff4.desc+"|r"
                endif 
                if this.type.eff6 != 0 then 
                    if this.addedEffSt6 then 
                        set color6 = "\n|cfffeebbe(6)"
                    else 
                        set color6 = "\n|cff888888(6)"
                    endif 
                    set desc6 = color6+this.type.eff6.desc+"|r"
                endif 
                return "\n\n|cff1eff00套装："+this.type.name+"|r"+desc2+desc4+desc6
            endmethod
        endstruct
        //装备，设定对应的类型、附魔，能设置在物品栏/在装备栏，并对应不同绑定形式
        struct Equipment 
            // region EquipTypeSettings
            EquipType type
            ItemSet inSet 
            unit bindUnit 
            item bindItem
            integer bindSlot
            boolean addedState = false 
            Enchantment enc
            integer warForged
            Enchantment craft_0
            Enchantment craft_1
            Enchantment craft_2 

            real realData       = 0
            integer intData     = 0
            boolean boolData    = false 

            trigger trigBeforedamageSource
            trigger trigBeforedamageTarget 
            trigger trigPredamageSource
            trigger trigPredamageTarget
            trigger trigDamagingSource 
            trigger trigDamagingTarget
            trigger trigDamagedSource
            trigger trigDamagedTarget 
            trigger trigAfterdamageSource
            trigger trigAfterdamageTarget

            trigger trigBeforehealSource
            trigger trigBeforehealTarget 
            trigger trigPreHealSource
            trigger trigPreHealTarget
            trigger trigHealingSource 
            trigger trigHealingTarget
            trigger trigHealedSource
            trigger trigHealedTarget 
            trigger trigAfterhealSource
            trigger trigAfterhealTarget

            trigger trigAttackedSource 
            trigger trigAttackedTarget 
            trigger trigAttacking
            trigger trigMissileLaunch
            trigger trigMissileHitSource
            trigger trigMissileHitTarget 
            trigger trigSpelling 
            // endregion 

            // region callBacks
            //! textmacro ItemCallBacks takes Name,whichTime
            static method callBack_$Name$ takes nothing returns nothing
                if eventEquipment.type.$whichTime$ != null then 
                    call TriggerExecute(eventEquipment.type.$whichTime$)
                endif 
                if eventEquipment.craft_0.$whichTime$ != null then 
                    call TriggerExecute(eventEquipment.craft_0.$whichTime$)
                endif 
                if eventEquipment.craft_1.$whichTime$ != null then 
                    call TriggerExecute(eventEquipment.craft_1.$whichTime$)
                endif 
                if eventEquipment.craft_2.$whichTime$ != null then 
                    call TriggerExecute(eventEquipment.craft_2.$whichTime$)
                endif 
                if eventEquipment.enc.$whichTime$ != null then 
                    call TriggerExecute(eventEquipment.enc.$whichTime$)
                endif 
                /*
                if eventEquipment.warForged.$whichTime$ != null then 
                    call TriggerExecute(eventEquipment.warForged.$whichTime$)
                endif 
                */
            endmethod
            //! endtextmacro

            //! runtextmacro ItemCallBacks("EquipOn","trigEquipOn")
            //! runtextmacro ItemCallBacks("TakeOff","trigTakeOff")
            //! runtextmacro ItemCallBacks("BefDmg_S","trigBeforedamageSource")
            //! runtextmacro ItemCallBacks("PreDmg_S","trigPredamageSource")
            //! runtextmacro ItemCallBacks("Dmging_S","trigDamagingSource")
            //! runtextmacro ItemCallBacks("Dmged_S","trigDamagedSource")
            //! runtextmacro ItemCallBacks("AftDmg_S","trigAfterdamageSource")
            //! runtextmacro ItemCallBacks("BefDmg_T","trigBeforedamageTarget")
            //! runtextmacro ItemCallBacks("PreDmg_T","trigPredamageTarget")
            //! runtextmacro ItemCallBacks("Dmging_T","trigDamagingTarget")
            //! runtextmacro ItemCallBacks("Dmged_T","trigDamagedTarget")
            //! runtextmacro ItemCallBacks("AftDmg_T","trigAfterdamageTarget")
            //! runtextmacro ItemCallBacks("BefHeal_S","trigBeforehealSource")
            //! runtextmacro ItemCallBacks("PreHeal_S","trigPreHealSource")
            //! runtextmacro ItemCallBacks("Healing_S","trigHealingSource")
            //! runtextmacro ItemCallBacks("Healed_S","trigHealedSource")
            //! runtextmacro ItemCallBacks("AftHeal_S","trigAfterhealSource")
            //! runtextmacro ItemCallBacks("BefHeal_T","trigBeforehealTarget")
            //! runtextmacro ItemCallBacks("PreHeal_T","trigPreHealTarget")
            //! runtextmacro ItemCallBacks("Healing_T","trigHealingTarget")
            //! runtextmacro ItemCallBacks("Healed_T","trigHealedTarget")
            //! runtextmacro ItemCallBacks("AftHeal_T","trigAfterhealTarget")
            //! runtextmacro ItemCallBacks("Atked_S","trigAttackedSource")
            //! runtextmacro ItemCallBacks("Atked_T","trigAttackedTarget")
            //! runtextmacro ItemCallBacks("MslHit_S","trigMissileHitSource")
            //! runtextmacro ItemCallBacks("MslHit_T","trigMissileHitTarget")
            //! runtextmacro ItemCallBacks("Spelling","trigSpelling")
            //! runtextmacro ItemCallBacks("Atking","trigAttacking")
            //! runtextmacro ItemCallBacks("MslLnch","trigMissileLaunch")

            // endregion
            method randomEnchantment takes nothing returns nothing
                local integer r
                if this.type.itemTypeId <= 'I68Y' and this.type.itemTypeId >= 'I643' then
                    set r = GetLootNumberEx(36)+1000
                    call this.setEnc(r)
                endif 
                if this.type.itemTypeId == 'I69U' then 
                    set r = GetLootNumberEx(2)+8
                    call this.setEnc(r)
                endif 
            endmethod
            method randomWarForged takes nothing returns nothing
                local integer r
                if GetLootNumberEx(1000) < R2I(GLOBAL_WAR_FORGE_RATE*(1+0.05*I2R(MAP_EXTRA_LEVEL))*I2R((5*this.type.requireLevel+15*MAP_EXTRA_LEVEL)*TEAM_ITEM_FOUND_RATE)/10000) then
                    set r = (IMinBJ(1+GetLootNumberEx(100+GLOBAL_WAR_FORGE_BONUS+5*MAP_EXTRA_LEVEL),IMaxBJ(1+GetLootNumberEx(100),1+GetLootNumberEx(IMaxBJ(1,5*MAP_EXTRA_LEVEL+GLOBAL_WAR_FORGE_BONUS))))+5)/5
                    call this.setWF(r)
                endif 
            endmethod

            static method create takes EquipType whichType returns Equipment 
                local thistype this = thistype.allocate()
                //call BJDebugMsg("DEBUG: EQUIPMENT CREATE !"+I2S(this))
                set this.type = whichType
                set this.bindSlot = -1 
                set this.inSet = 0
                set this.bindItem = null 
                call this.addBefDmg_S(function thistype.callBack_BefDmg_S)
                call this.addBefDmg_T(function thistype.callBack_BefDmg_T)
                call this.addPreDmg_S(function thistype.callBack_PreDmg_S)
                call this.addPreDmg_T(function thistype.callBack_PreDmg_T)
                call this.addDmging_S(function thistype.callBack_Dmging_S)
                call this.addDmging_T(function thistype.callBack_Dmging_T)
                call this.addDmged_S(function thistype.callBack_Dmged_S)
                call this.addDmged_T(function thistype.callBack_Dmged_T)
                call this.addAftDmg_S(function thistype.callBack_AftDmg_S)
                call this.addAftDmg_T(function thistype.callBack_AftDmg_T)
                call this.addBefHeal_S(function thistype.callBack_BefHeal_S)
                call this.addBefHeal_T(function thistype.callBack_BefHeal_T)
                call this.addPreHeal_S(function thistype.callBack_PreHeal_S)
                call this.addPreHeal_T(function thistype.callBack_PreHeal_T)
                call this.addHealing_S(function thistype.callBack_Healing_S)
                call this.addHealing_T(function thistype.callBack_Healing_T)
                call this.addHealed_S(function thistype.callBack_Healed_S)
                call this.addHealed_T(function thistype.callBack_Healed_T)
                call this.addAftHeal_S(function thistype.callBack_AftHeal_S)
                call this.addAftHeal_T(function thistype.callBack_AftHeal_T)
                call this.addAtked_S(function thistype.callBack_Atked_S)
                call this.addAtked_T(function thistype.callBack_Atked_T)
                call this.addMslHit_S(function thistype.callBack_MslHit_S)
                call this.addMslHit_T(function thistype.callBack_MslHit_T)
                call this.addSpelling(function thistype.callBack_Spelling)
                call this.addAtking(function thistype.callBack_Atking)
                call this.addMslLnch(function thistype.callBack_MslLnch)
                set this.enc = 0
                set this.warForged = 0
                set this.craft_0 = 0
                set this.craft_1 = 0
                set this.craft_2 = 0
                call this.randomEnchantment()
                call this.randomWarForged()
                return this 
            endmethod

            method flushTrigs takes nothing returns nothing
                if (this.trigBeforedamageSource != null) then
                    call DestroyTriggerEx(this.trigBeforedamageSource)
                    set this.trigBeforedamageSource = null
                endif
                if (this.trigBeforedamageTarget != null) then
                    call DestroyTriggerEx(this.trigBeforedamageTarget)
                    set this.trigBeforedamageTarget = null
                endif
                if (this.trigPredamageSource != null) then
                    call DestroyTriggerEx(this.trigPredamageSource)
                    set this.trigPredamageSource = null
                endif
                if (this.trigPredamageTarget != null) then
                    call DestroyTriggerEx(this.trigPredamageTarget)
                    set this.trigPredamageTarget = null
                endif
                if (this.trigDamagingSource != null) then
                    call DestroyTriggerEx(this.trigDamagingSource)
                    set this.trigDamagingSource = null
                endif
                if (this.trigDamagingTarget != null) then
                    call DestroyTriggerEx(this.trigDamagingTarget)
                    set this.trigDamagingTarget = null
                endif
                if (this.trigDamagedSource != null) then
                    call DestroyTriggerEx(this.trigDamagedSource)
                    set this.trigDamagedSource = null
                endif
                if (this.trigDamagedTarget != null) then
                    call DestroyTriggerEx(this.trigDamagedTarget)
                    set this.trigDamagedTarget = null
                endif
                if (this.trigAfterdamageSource != null) then
                    call DestroyTriggerEx(this.trigAfterdamageSource)
                    set this.trigAfterdamageSource = null
                endif
                if (this.trigAfterdamageTarget != null) then
                    call DestroyTriggerEx(this.trigAfterdamageTarget)
                    set this.trigAfterdamageTarget = null
                endif
                if (this.trigBeforehealSource != null) then
                    call DestroyTriggerEx(this.trigBeforehealSource)
                    set this.trigBeforehealSource = null
                endif
                if (this.trigBeforehealTarget != null) then
                    call DestroyTriggerEx(this.trigBeforehealTarget)
                    set this.trigBeforehealTarget = null
                endif
                if (this.trigPreHealSource != null) then
                    call DestroyTriggerEx(this.trigPreHealSource)
                    set this.trigPreHealSource = null
                endif
                if (this.trigPreHealTarget != null) then
                    call DestroyTriggerEx(this.trigPreHealTarget)
                    set this.trigPreHealTarget = null
                endif
                if (this.trigHealingSource != null) then
                    call DestroyTriggerEx(this.trigHealingSource)
                    set this.trigHealingSource = null
                endif
                if (this.trigHealingTarget != null) then
                    call DestroyTriggerEx(this.trigHealingTarget)
                    set this.trigHealingTarget = null
                endif
                if (this.trigHealedSource != null) then
                    call DestroyTriggerEx(this.trigHealedSource)
                    set this.trigHealedSource = null
                endif
                if (this.trigHealedTarget != null) then
                    call DestroyTriggerEx(this.trigHealedTarget)
                    set this.trigHealedTarget = null
                endif
                if (this.trigAfterhealSource != null) then
                    call DestroyTriggerEx(this.trigAfterhealSource)
                    set this.trigAfterhealSource = null
                endif
                if (this.trigAfterhealTarget != null) then
                    call DestroyTriggerEx(this.trigAfterhealTarget)
                    set this.trigAfterhealTarget = null
                endif
                if (this.trigAttackedSource != null) then
                    call DestroyTriggerEx(this.trigAttackedSource)
                    set this.trigAttackedSource = null
                endif
                if (this.trigAttackedTarget != null) then
                    call DestroyTriggerEx(this.trigAttackedTarget)
                    set this.trigAttackedTarget = null
                endif
                if (this.trigAttacking != null) then
                    call DestroyTriggerEx(this.trigAttacking)
                    set this.trigAttacking = null
                endif
                if (this.trigMissileLaunch != null) then
                    call DestroyTriggerEx(this.trigMissileLaunch)
                    set this.trigMissileLaunch = null
                endif
                if (this.trigMissileHitSource != null) then
                    call DestroyTriggerEx(this.trigMissileHitSource)
                    set this.trigMissileHitSource = null
                endif
                if (this.trigMissileHitTarget != null) then
                    call DestroyTriggerEx(this.trigMissileHitTarget)
                    set this.trigMissileHitTarget = null
                endif
                if (this.trigSpelling != null) then
                    call DestroyTriggerEx(this.trigSpelling)
                    set this.trigSpelling = null
                endif
            endmethod

            method onDestroy takes nothing returns nothing
                //call BJDebugMsg("DEBUG: EQUIPMENT DESTROY !"+I2S(this))
                call this.clearBind()
                call this.flushTrigs()
            endmethod

            private method clearBind takes nothing returns nothing
                if this.bindSlot != -1 then 
                    call SaveInteger(equipHash,GetHandleId(this.bindUnit),this.bindSlot,0)
                    set this.bindSlot = -1
                    set this.bindUnit = null 
                endif
                if this.bindItem != null then 
                    call SaveInteger(equipHash,GetHandleId(this.bindItem),99,0)
                    set this.bindItem = null 
                endif 
            endmethod

            method bindOnItem takes item whichItem returns item 
                call this.clearBind()
                set this.bindItem = whichItem 
                call SaveInteger(equipHash,GetHandleId(this.bindItem),99,this)
                call BlzSetItemDescription(whichItem,this.getDesc())
                call BlzSetItemExtendedTooltip(whichItem,this.getDesc())
                
                if this.warForged > 0 and this.bindItem != null then 
                    if this.warForged >= 20  then 
                        call BlzSetItemName(this.bindItem,"|cffe6cc80*|r"+this.type.name)
                        call BlzSetItemTooltip(this.bindItem,"|cffe6cc80*|r"+this.type.name)
                    else 
                        call BlzSetItemName(this.bindItem,"|cffff8800*|r"+this.type.name)
                        call BlzSetItemTooltip(this.bindItem,"|cffff8800*|r"+this.type.name)
                    endif 
                else 
                    call BlzSetItemName(this.bindItem,this.type.name)
                    call BlzSetItemTooltip(this.bindItem,this.type.name)
                endif 
                return whichItem
            endmethod

            method bindOnSlot takes unit whichUnit,integer slot returns nothing
                call this.clearBind()
                set this.bindSlot = slot 
                set this.bindUnit = whichUnit
                if this.inSet == 0 and this.type.inSet > 0 then 
                    if this.type.inSet.get(this.bindUnit) > 0 then 
                        set this.inSet = this.type.inSet.get(this.bindUnit)
                    else 
                        set this.inSet = ItemSet.create(this.bindUnit,this.type.inSet)
                    endif 
                endif 
                call SaveInteger(equipHash,GetHandleId(this.bindUnit),this.bindSlot,this)
            endmethod

            method applyStates takes nothing returns nothing
                if this.addedState or this.bindUnit == armoury then 
                    return 
                endif 
                set this.addedState = true 
                call this.type.bonusWhichState1.addStateSimple(this.bindUnit,this.type.bonusWhichMode1,this.type.bonusWhichValue1)
                call this.type.bonusWhichState2.addStateSimple(this.bindUnit,this.type.bonusWhichMode2,this.type.bonusWhichValue2)
                call this.type.bonusWhichState3.addStateSimple(this.bindUnit,this.type.bonusWhichMode3,this.type.bonusWhichValue3)
                call this.type.bonusWhichState4.addStateSimple(this.bindUnit,this.type.bonusWhichMode4,this.type.bonusWhichValue4)
                call this.type.bonusWhichState5.addStateSimple(this.bindUnit,this.type.bonusWhichMode5,this.type.bonusWhichValue5)
                call this.type.bonusWhichState6.addStateSimple(this.bindUnit,this.type.bonusWhichMode6,this.type.bonusWhichValue6)
                call this.type.bonusWhichState7.addStateSimple(this.bindUnit,this.type.bonusWhichMode7,this.type.bonusWhichValue7)
                if this.enc != 0 then 
                    call this.enc.bonusWhichState1.addStateSimple(this.bindUnit,this.enc.bonusWhichMode1,this.enc.bonusWhichValue1)
                    call this.enc.bonusWhichState2.addStateSimple(this.bindUnit,this.enc.bonusWhichMode2,this.enc.bonusWhichValue2)
                    call this.enc.bonusWhichState3.addStateSimple(this.bindUnit,this.enc.bonusWhichMode3,this.enc.bonusWhichValue3)
                endif 
                if this.craft_0 != 0 then 
                    call this.craft_0.bonusWhichState1.addStateSimple(this.bindUnit,this.craft_0.bonusWhichMode1,this.craft_0.bonusWhichValue1)
                    call this.craft_0.bonusWhichState2.addStateSimple(this.bindUnit,this.craft_0.bonusWhichMode2,this.craft_0.bonusWhichValue2)
                    call this.craft_0.bonusWhichState3.addStateSimple(this.bindUnit,this.craft_0.bonusWhichMode3,this.craft_0.bonusWhichValue3)
                endif 
                if this.craft_1 != 0 then 
                    call this.craft_1.bonusWhichState1.addStateSimple(this.bindUnit,this.craft_1.bonusWhichMode1,this.craft_1.bonusWhichValue1)
                    call this.craft_1.bonusWhichState2.addStateSimple(this.bindUnit,this.craft_1.bonusWhichMode2,this.craft_1.bonusWhichValue2)
                    call this.craft_1.bonusWhichState3.addStateSimple(this.bindUnit,this.craft_1.bonusWhichMode3,this.craft_1.bonusWhichValue3)
                endif 
                if this.craft_2 != 0 then 
                    call this.craft_2.bonusWhichState1.addStateSimple(this.bindUnit,this.craft_2.bonusWhichMode1,this.craft_2.bonusWhichValue1)
                    call this.craft_2.bonusWhichState2.addStateSimple(this.bindUnit,this.craft_2.bonusWhichMode2,this.craft_2.bonusWhichValue2)
                    call this.craft_2.bonusWhichState3.addStateSimple(this.bindUnit,this.craft_2.bonusWhichMode3,this.craft_2.bonusWhichValue3)
                endif
                if this.warForged != 0 then 
                    call this.type.bonusWhichState1.addStateWarforged(this.bindUnit,this.type.bonusWhichMode1,this.type.bonusWhichValue1,this.warForged,true)
                    call this.type.bonusWhichState2.addStateWarforged(this.bindUnit,this.type.bonusWhichMode2,this.type.bonusWhichValue2,this.warForged,true)
                    call this.type.bonusWhichState3.addStateWarforged(this.bindUnit,this.type.bonusWhichMode3,this.type.bonusWhichValue3,this.warForged,true)
                    call this.type.bonusWhichState4.addStateWarforged(this.bindUnit,this.type.bonusWhichMode4,this.type.bonusWhichValue4,this.warForged,true)
                    call this.type.bonusWhichState5.addStateWarforged(this.bindUnit,this.type.bonusWhichMode5,this.type.bonusWhichValue5,this.warForged,true)
                    call this.type.bonusWhichState6.addStateWarforged(this.bindUnit,this.type.bonusWhichMode6,this.type.bonusWhichValue6,this.warForged,true)
                    call this.type.bonusWhichState7.addStateWarforged(this.bindUnit,this.type.bonusWhichMode7,this.type.bonusWhichValue7,this.warForged,true)
                    if this.enc != 0 then 
                        call this.enc.bonusWhichState1.addStateWarforged(this.bindUnit,this.enc.bonusWhichMode1,this.enc.bonusWhichValue1,this.warForged,true)
                        call this.enc.bonusWhichState2.addStateWarforged(this.bindUnit,this.enc.bonusWhichMode2,this.enc.bonusWhichValue2,this.warForged,true)
                        call this.enc.bonusWhichState3.addStateWarforged(this.bindUnit,this.enc.bonusWhichMode3,this.enc.bonusWhichValue3,this.warForged,true)
                    endif 
                    if this.craft_0 != 0 then 
                        call this.craft_0.bonusWhichState1.addStateWarforged(this.bindUnit,this.craft_0.bonusWhichMode1,this.craft_0.bonusWhichValue1,this.warForged,true)
                        call this.craft_0.bonusWhichState2.addStateWarforged(this.bindUnit,this.craft_0.bonusWhichMode2,this.craft_0.bonusWhichValue2,this.warForged,true)
                        call this.craft_0.bonusWhichState3.addStateWarforged(this.bindUnit,this.craft_0.bonusWhichMode3,this.craft_0.bonusWhichValue3,this.warForged,true)
                    endif 
                    if this.craft_1 != 0 then 
                        call this.craft_1.bonusWhichState1.addStateWarforged(this.bindUnit,this.craft_1.bonusWhichMode1,this.craft_1.bonusWhichValue1,this.warForged,true)
                        call this.craft_1.bonusWhichState2.addStateWarforged(this.bindUnit,this.craft_1.bonusWhichMode2,this.craft_1.bonusWhichValue2,this.warForged,true)
                        call this.craft_1.bonusWhichState3.addStateWarforged(this.bindUnit,this.craft_1.bonusWhichMode3,this.craft_1.bonusWhichValue3,this.warForged,true)
                    endif 
                    if this.craft_2 != 0 then 
                        call this.craft_2.bonusWhichState1.addStateWarforged(this.bindUnit,this.craft_2.bonusWhichMode1,this.craft_2.bonusWhichValue1,this.warForged,true)
                        call this.craft_2.bonusWhichState2.addStateWarforged(this.bindUnit,this.craft_2.bonusWhichMode2,this.craft_2.bonusWhichValue2,this.warForged,true)
                        call this.craft_2.bonusWhichState3.addStateWarforged(this.bindUnit,this.craft_2.bonusWhichMode3,this.craft_2.bonusWhichValue3,this.warForged,true)
                    endif 
                endif 
                if this.type.amuletBindAbility != 0 then 
                    call UnitAddAbility(this.bindUnit,this.type.amuletBindAbility)
                    call UnitMakeAbilityPermanent(this.bindUnit,true,this.type.amuletBindAbility)
                    call BlzStartUnitAbilityCooldown(this.bindUnit,this.type.amuletBindAbility,15.0)
                endif 
                call State.checkAll.evaluate(this.bindUnit)
            endmethod

            method removeStates takes nothing returns nothing
                if this.addedState == false or this.bindUnit == armoury then 
                    return 
                endif 
                set this.addedState = false
                call this.type.bonusWhichState1.addStateSimple(this.bindUnit,this.type.bonusWhichMode1,0-this.type.bonusWhichValue1)
                call this.type.bonusWhichState2.addStateSimple(this.bindUnit,this.type.bonusWhichMode2,0-this.type.bonusWhichValue2)
                call this.type.bonusWhichState3.addStateSimple(this.bindUnit,this.type.bonusWhichMode3,0-this.type.bonusWhichValue3)
                call this.type.bonusWhichState4.addStateSimple(this.bindUnit,this.type.bonusWhichMode4,0-this.type.bonusWhichValue4)
                call this.type.bonusWhichState5.addStateSimple(this.bindUnit,this.type.bonusWhichMode5,0-this.type.bonusWhichValue5)
                call this.type.bonusWhichState6.addStateSimple(this.bindUnit,this.type.bonusWhichMode6,0-this.type.bonusWhichValue6)
                call this.type.bonusWhichState7.addStateSimple(this.bindUnit,this.type.bonusWhichMode7,0-this.type.bonusWhichValue7)
                if this.enc != 0 then 
                    call this.enc.bonusWhichState1.addStateSimple(this.bindUnit,this.enc.bonusWhichMode1,0-this.enc.bonusWhichValue1)
                    call this.enc.bonusWhichState2.addStateSimple(this.bindUnit,this.enc.bonusWhichMode2,0-this.enc.bonusWhichValue2)
                    call this.enc.bonusWhichState3.addStateSimple(this.bindUnit,this.enc.bonusWhichMode3,0-this.enc.bonusWhichValue3)
                endif 
                if this.craft_0 != 0 then 
                    call this.craft_0.bonusWhichState1.addStateSimple(this.bindUnit,this.craft_0.bonusWhichMode1,0-this.craft_0.bonusWhichValue1)
                    call this.craft_0.bonusWhichState2.addStateSimple(this.bindUnit,this.craft_0.bonusWhichMode2,0-this.craft_0.bonusWhichValue2)
                    call this.craft_0.bonusWhichState3.addStateSimple(this.bindUnit,this.craft_0.bonusWhichMode3,0-this.craft_0.bonusWhichValue3)
                endif 
                if this.craft_1 != 0 then 
                    call this.craft_1.bonusWhichState1.addStateSimple(this.bindUnit,this.craft_1.bonusWhichMode1,0-this.craft_1.bonusWhichValue1)
                    call this.craft_1.bonusWhichState2.addStateSimple(this.bindUnit,this.craft_1.bonusWhichMode2,0-this.craft_1.bonusWhichValue2)
                    call this.craft_1.bonusWhichState3.addStateSimple(this.bindUnit,this.craft_1.bonusWhichMode3,0-this.craft_1.bonusWhichValue3)
                endif 
                if this.craft_2 != 0 then 
                    call this.craft_2.bonusWhichState1.addStateSimple(this.bindUnit,this.craft_2.bonusWhichMode1,0-this.craft_2.bonusWhichValue1)
                    call this.craft_2.bonusWhichState2.addStateSimple(this.bindUnit,this.craft_2.bonusWhichMode2,0-this.craft_2.bonusWhichValue2)
                    call this.craft_2.bonusWhichState3.addStateSimple(this.bindUnit,this.craft_2.bonusWhichMode3,0-this.craft_2.bonusWhichValue3)
                endif 
                if this.warForged != 0 then 
                    call this.type.bonusWhichState1.addStateWarforged(this.bindUnit,this.type.bonusWhichMode1,0-this.type.bonusWhichValue1,this.warForged,false)
                    call this.type.bonusWhichState2.addStateWarforged(this.bindUnit,this.type.bonusWhichMode2,0-this.type.bonusWhichValue2,this.warForged,false)
                    call this.type.bonusWhichState3.addStateWarforged(this.bindUnit,this.type.bonusWhichMode3,0-this.type.bonusWhichValue3,this.warForged,false)
                    call this.type.bonusWhichState4.addStateWarforged(this.bindUnit,this.type.bonusWhichMode4,0-this.type.bonusWhichValue4,this.warForged,false)
                    call this.type.bonusWhichState5.addStateWarforged(this.bindUnit,this.type.bonusWhichMode5,0-this.type.bonusWhichValue5,this.warForged,false)
                    call this.type.bonusWhichState6.addStateWarforged(this.bindUnit,this.type.bonusWhichMode6,0-this.type.bonusWhichValue6,this.warForged,false)
                    call this.type.bonusWhichState7.addStateWarforged(this.bindUnit,this.type.bonusWhichMode7,0-this.type.bonusWhichValue7,this.warForged,false)
                    if this.enc != 0 then 
                        call this.enc.bonusWhichState1.addStateWarforged(this.bindUnit,this.enc.bonusWhichMode1,0-this.enc.bonusWhichValue1,this.warForged,false)
                        call this.enc.bonusWhichState2.addStateWarforged(this.bindUnit,this.enc.bonusWhichMode2,0-this.enc.bonusWhichValue2,this.warForged,false)
                        call this.enc.bonusWhichState3.addStateWarforged(this.bindUnit,this.enc.bonusWhichMode3,0-this.enc.bonusWhichValue3,this.warForged,false)
                    endif 
                    if this.craft_0 != 0 then 
                        call this.craft_0.bonusWhichState1.addStateWarforged(this.bindUnit,this.craft_0.bonusWhichMode1,0-this.craft_0.bonusWhichValue1,this.warForged,false)
                        call this.craft_0.bonusWhichState2.addStateWarforged(this.bindUnit,this.craft_0.bonusWhichMode2,0-this.craft_0.bonusWhichValue2,this.warForged,false)
                        call this.craft_0.bonusWhichState3.addStateWarforged(this.bindUnit,this.craft_0.bonusWhichMode3,0-this.craft_0.bonusWhichValue3,this.warForged,false)
                    endif 
                    if this.craft_1 != 0 then 
                        call this.craft_1.bonusWhichState1.addStateWarforged(this.bindUnit,this.craft_1.bonusWhichMode1,0-this.craft_1.bonusWhichValue1,this.warForged,false)
                        call this.craft_1.bonusWhichState2.addStateWarforged(this.bindUnit,this.craft_1.bonusWhichMode2,0-this.craft_1.bonusWhichValue2,this.warForged,false)
                        call this.craft_1.bonusWhichState3.addStateWarforged(this.bindUnit,this.craft_1.bonusWhichMode3,0-this.craft_1.bonusWhichValue3,this.warForged,false)
                    endif 
                    if this.craft_2 != 0 then 
                        call this.craft_2.bonusWhichState1.addStateWarforged(this.bindUnit,this.craft_2.bonusWhichMode1,0-this.craft_2.bonusWhichValue1,this.warForged,false)
                        call this.craft_2.bonusWhichState2.addStateWarforged(this.bindUnit,this.craft_2.bonusWhichMode2,0-this.craft_2.bonusWhichValue2,this.warForged,false)
                        call this.craft_2.bonusWhichState3.addStateWarforged(this.bindUnit,this.craft_2.bonusWhichMode3,0-this.craft_2.bonusWhichValue3,this.warForged,false)
                    endif 
                endif 
                if this.type.amuletBindAbility != 0 then 
                    call UnitRemoveAbility(this.bindUnit,this.type.amuletBindAbility)
                endif 
                call State.checkAll.evaluate(this.bindUnit)
            endmethod

            method removeStates_TakeOff takes nothing returns nothing
                if this.addedState == false or eventEquipmentOwner == armoury then 
                    return 
                endif 
                set this.addedState = false
                call this.type.bonusWhichState1.addStateSimple(eventEquipmentOwner,this.type.bonusWhichMode1,0-this.type.bonusWhichValue1)
                call this.type.bonusWhichState2.addStateSimple(eventEquipmentOwner,this.type.bonusWhichMode2,0-this.type.bonusWhichValue2)
                call this.type.bonusWhichState3.addStateSimple(eventEquipmentOwner,this.type.bonusWhichMode3,0-this.type.bonusWhichValue3)
                call this.type.bonusWhichState4.addStateSimple(eventEquipmentOwner,this.type.bonusWhichMode4,0-this.type.bonusWhichValue4)
                call this.type.bonusWhichState5.addStateSimple(eventEquipmentOwner,this.type.bonusWhichMode5,0-this.type.bonusWhichValue5)
                call this.type.bonusWhichState6.addStateSimple(eventEquipmentOwner,this.type.bonusWhichMode6,0-this.type.bonusWhichValue6)
                call this.type.bonusWhichState7.addStateSimple(eventEquipmentOwner,this.type.bonusWhichMode7,0-this.type.bonusWhichValue7)
                if this.enc != 0 then 
                    call this.enc.bonusWhichState1.addStateSimple(eventEquipmentOwner,this.enc.bonusWhichMode1,0-this.enc.bonusWhichValue1)
                    call this.enc.bonusWhichState2.addStateSimple(eventEquipmentOwner,this.enc.bonusWhichMode2,0-this.enc.bonusWhichValue2)
                    call this.enc.bonusWhichState3.addStateSimple(eventEquipmentOwner,this.enc.bonusWhichMode3,0-this.enc.bonusWhichValue3)
                endif 
                if this.craft_0 != 0 then 
                    call this.craft_0.bonusWhichState1.addStateSimple(eventEquipmentOwner,this.craft_0.bonusWhichMode1,0-this.craft_0.bonusWhichValue1)
                    call this.craft_0.bonusWhichState2.addStateSimple(eventEquipmentOwner,this.craft_0.bonusWhichMode2,0-this.craft_0.bonusWhichValue2)
                    call this.craft_0.bonusWhichState3.addStateSimple(eventEquipmentOwner,this.craft_0.bonusWhichMode3,0-this.craft_0.bonusWhichValue3)
                endif 
                if this.craft_1 != 0 then 
                    call this.craft_1.bonusWhichState1.addStateSimple(eventEquipmentOwner,this.craft_1.bonusWhichMode1,0-this.craft_1.bonusWhichValue1)
                    call this.craft_1.bonusWhichState2.addStateSimple(eventEquipmentOwner,this.craft_1.bonusWhichMode2,0-this.craft_1.bonusWhichValue2)
                    call this.craft_1.bonusWhichState3.addStateSimple(eventEquipmentOwner,this.craft_1.bonusWhichMode3,0-this.craft_1.bonusWhichValue3)
                endif 
                if this.craft_2 != 0 then 
                    call this.craft_2.bonusWhichState1.addStateSimple(eventEquipmentOwner,this.craft_2.bonusWhichMode1,0-this.craft_2.bonusWhichValue1)
                    call this.craft_2.bonusWhichState2.addStateSimple(eventEquipmentOwner,this.craft_2.bonusWhichMode2,0-this.craft_2.bonusWhichValue2)
                    call this.craft_2.bonusWhichState3.addStateSimple(eventEquipmentOwner,this.craft_2.bonusWhichMode3,0-this.craft_2.bonusWhichValue3)
                endif 
                if this.warForged != 0 then 
                    call this.type.bonusWhichState1.addStateWarforged(eventEquipmentOwner,this.type.bonusWhichMode1,0-this.type.bonusWhichValue1,this.warForged,false)
                    call this.type.bonusWhichState2.addStateWarforged(eventEquipmentOwner,this.type.bonusWhichMode2,0-this.type.bonusWhichValue2,this.warForged,false)
                    call this.type.bonusWhichState3.addStateWarforged(eventEquipmentOwner,this.type.bonusWhichMode3,0-this.type.bonusWhichValue3,this.warForged,false)
                    call this.type.bonusWhichState4.addStateWarforged(eventEquipmentOwner,this.type.bonusWhichMode4,0-this.type.bonusWhichValue4,this.warForged,false)
                    call this.type.bonusWhichState5.addStateWarforged(eventEquipmentOwner,this.type.bonusWhichMode5,0-this.type.bonusWhichValue5,this.warForged,false)
                    call this.type.bonusWhichState6.addStateWarforged(eventEquipmentOwner,this.type.bonusWhichMode6,0-this.type.bonusWhichValue6,this.warForged,false)
                    call this.type.bonusWhichState7.addStateWarforged(eventEquipmentOwner,this.type.bonusWhichMode7,0-this.type.bonusWhichValue7,this.warForged,false)
                    if this.enc != 0 then 
                        call this.enc.bonusWhichState1.addStateWarforged(eventEquipmentOwner,this.enc.bonusWhichMode1,0-this.enc.bonusWhichValue1,this.warForged,false)
                        call this.enc.bonusWhichState2.addStateWarforged(eventEquipmentOwner,this.enc.bonusWhichMode2,0-this.enc.bonusWhichValue2,this.warForged,false)
                        call this.enc.bonusWhichState3.addStateWarforged(eventEquipmentOwner,this.enc.bonusWhichMode3,0-this.enc.bonusWhichValue3,this.warForged,false)
                    endif 
                    if this.craft_0 != 0 then 
                        call this.craft_0.bonusWhichState1.addStateWarforged(eventEquipmentOwner,this.craft_0.bonusWhichMode1,0-this.craft_0.bonusWhichValue1,this.warForged,false)
                        call this.craft_0.bonusWhichState2.addStateWarforged(eventEquipmentOwner,this.craft_0.bonusWhichMode2,0-this.craft_0.bonusWhichValue2,this.warForged,false)
                        call this.craft_0.bonusWhichState3.addStateWarforged(eventEquipmentOwner,this.craft_0.bonusWhichMode3,0-this.craft_0.bonusWhichValue3,this.warForged,false)
                    endif 
                    if this.craft_1 != 0 then 
                        call this.craft_1.bonusWhichState1.addStateWarforged(eventEquipmentOwner,this.craft_1.bonusWhichMode1,0-this.craft_1.bonusWhichValue1,this.warForged,false)
                        call this.craft_1.bonusWhichState2.addStateWarforged(eventEquipmentOwner,this.craft_1.bonusWhichMode2,0-this.craft_1.bonusWhichValue2,this.warForged,false)
                        call this.craft_1.bonusWhichState3.addStateWarforged(eventEquipmentOwner,this.craft_1.bonusWhichMode3,0-this.craft_1.bonusWhichValue3,this.warForged,false)
                    endif 
                    if this.craft_2 != 0 then 
                        call this.craft_2.bonusWhichState1.addStateWarforged(eventEquipmentOwner,this.craft_2.bonusWhichMode1,0-this.craft_2.bonusWhichValue1,this.warForged,false)
                        call this.craft_2.bonusWhichState2.addStateWarforged(eventEquipmentOwner,this.craft_2.bonusWhichMode2,0-this.craft_2.bonusWhichValue2,this.warForged,false)
                        call this.craft_2.bonusWhichState3.addStateWarforged(eventEquipmentOwner,this.craft_2.bonusWhichMode3,0-this.craft_2.bonusWhichValue3,this.warForged,false)
                    endif 
                endif 
                if this.type.amuletBindAbility != 0 then 
                    call UnitRemoveAbility(eventEquipmentOwner,this.type.amuletBindAbility)
                endif 
                call State.checkAll.evaluate(eventEquipmentOwner)
            endmethod

            method changeAbility takes nothing returns nothing
                local integer baseItem = slot2BaseItem(this.bindUnit,this.bindSlot)
                local item tempItem = null 
                if this.bindSlot == -1 then 
                    return 
                endif 
                call this.applyStates()
                call this.inSet.checkSet(0)
                if baseItem > 0 then
                    set tempItem = CreateItem(this.type.itemTypeId,GetUnitX(this.bindUnit),GetUnitY(this.bindUnit))
                    if this.warForged > 0 then 
                        call BlzSetAbilityTooltip(baseItem,"|cffff8800*|r"+this.type.name,0)
                    else 
                        call BlzSetAbilityTooltip(baseItem,this.type.name,0)
                    endif 
                    call BlzSetAbilityIcon(baseItem,BlzGetItemIconPath(tempItem))
                    call BlzSetAbilityExtendedTooltip(baseItem,this.getDesc(),0)
                    call RemoveItem(tempItem)
                    set tempItem = null 
                endif 
            endmethod

            method getDesc takes nothing returns string
                local string result = this.type.desc
                local string craftDesc = "|n|cffa5e3fe工艺：+"
                local integer craftCount = 0
                if this.craft_0 > 0 then 
                    set craftCount = craftCount+1
                endif 
                if this.craft_1 > 0 then 
                    set craftCount = craftCount+1
                endif 
                if this.craft_2 > 0 then 
                    set craftCount = craftCount+1
                endif 
                if craftCount > 0 then 
                    set result = result+craftDesc+I2S(craftCount)+"|r"
                    if this.craft_0 > 0 then 
                        set result = result+this.craft_0.desc
                    endif 
                    if this.craft_1 > 0 then 
                        set result = result+this.craft_1.desc
                    endif 
                    if this.craft_2 > 0 then 
                        set result = result+this.craft_2.desc
                    endif 
                endif 
                if this.enc > 0 then 
                    set result = result+this.enc.desc 
                endif 
                if this.warForged > 0 then 
                    if this.warForged >= 20 then 
                        set result = "|cffe6cc80*战火：+"+I2S(this.warForged)+"%%|n"+result
                    else 
                        set result = "|cffff8800*战火：+"+I2S(this.warForged)+"%%|n"+result
                    endif 
                endif 
                if this.inSet > 0 then 
                    set result = result+this.inSet.getDesc()
                elseif this.type.inSet > 0 then 
                    set result = result+this.type.inSet.getDesc()
                endif 
                if this.type.insc != "" then 
                    set result = result+this.type.insc
                endif 
                return result
            endmethod

            method setEnc takes integer index returns nothing
                set this.enc = GetEncById(index)
            endmethod
            method setWF takes integer index returns nothing
                set this.warForged = index 
                if index > 0 and this.bindItem != null then 
                    if this.warForged >= 20  then 
                        call BlzSetItemName(this.bindItem,"|cffe6cc80*|r"+this.type.name)
                        call BlzSetItemTooltip(this.bindItem,"|cffe6cc80*|r"+this.type.name)
                    else 
                        call BlzSetItemName(this.bindItem,"|cffff8800*|r"+this.type.name)
                        call BlzSetItemTooltip(this.bindItem,"|cffff8800*|r"+this.type.name)
                    endif 
                else 
                    call BlzSetItemName(this.bindItem,this.type.name)
                    call BlzSetItemTooltip(this.bindItem,this.type.name)
                endif 
            endmethod
            method setC0 takes integer index returns nothing
                set this.craft_0 = GetEncById(index)
            endmethod
            method setC1 takes integer index returns nothing
                set this.craft_1 = GetEncById(index)
            endmethod
            method setC2 takes integer index returns nothing
                set this.craft_2 = GetEncById(index)
            endmethod

            method updateItemDesc takes nothing returns nothing
                if this.bindItem == null then 
                    return 
                endif 
                call BlzSetItemDescription(this.bindItem,this.getDesc())
                call BlzSetItemExtendedTooltip(this.bindItem,this.getDesc())
            endmethod
            
            method craft takes integer whichEnc returns boolean
                local boolean success = true 
                if this.bindUnit != null then 
                    call this.removeStates()
                endif 
                if this.craft_0 == 0 then 
                    set this.craft_0 = GetEncById(whichEnc)
                elseif this.craft_1 == 0 then 
                    set this.craft_1 = GetEncById(whichEnc)
                elseif this.craft_2 == 0 then 
                    set this.craft_2 = GetEncById(whichEnc)
                else 
                    set success = false 
                endif 
                if this.bindUnit != null then 
                    call this.applyStates()
                endif 
                if success and this.bindItem != null then 
                    call BlzSetItemDescription(this.bindItem,this.getDesc())
                    call BlzSetItemExtendedTooltip(this.bindItem,this.getDesc())
                endif 
                return success 
            endmethod
            method enchant takes integer whichEnc returns nothing
                if GetEncById(whichEnc) == this.enc then 
                    return 
                endif 
                if this.bindUnit != null then 
                    call this.removeStates()
                endif 
                set this.enc = GetEncById(whichEnc)
                if this.bindUnit != null then 
                    call this.applyStates()
                endif 
                if this.bindItem != null then 
                    call BlzSetItemDescription(this.bindItem,this.getDesc())
                    call BlzSetItemExtendedTooltip(this.bindItem,this.getDesc())
                endif 
            endmethod
            method warForge takes integer whichEnc returns nothing
                if GetEncById(whichEnc) == this.warForged then 
                    return 
                endif 
                if this.bindUnit != null then 
                    call this.removeStates()
                endif 
                call this.setWF(whichEnc)
                if this.bindUnit != null then 
                    call this.applyStates()
                endif 
                if this.bindItem != null then 
                    call BlzSetItemDescription(this.bindItem,this.getDesc())
                    call BlzSetItemExtendedTooltip(this.bindItem,this.getDesc())
                endif 
            endmethod

            method unEquip takes unit whichUnit,integer slot returns nothing
                local item tempItem = CreateItem(this.type.itemTypeId,GetUnitX(whichUnit),GetUnitY(whichUnit))
                local integer baseItem = slot2BaseItem(whichUnit,slot)
                call delayedUnitAddItem(whichUnit,tempItem)
                call BlzSetAbilityExtendedTooltip(baseItem,INV_TOOLTIP_EXTENDED[slot],0)
                call BlzSetAbilityTooltip(baseItem,INV_TOOLTIP[slot],0)
                call BlzSetAbilityIcon(baseItem,INV_ICON[slot])
                set eventEquipment = this 
                set eventEquipmentOwner = this.bindUnit
                call this.callBack_TakeOff()
                call this.inSet.checkSet(-1)
                set this.inSet = 0
                call this.bindOnItem(tempItem)
                call this.removeStates_TakeOff()
                if this.warForged > 0 then 
                    if this.warForged >= 20  then 
                        call BlzSetItemName(this.bindItem,"|cffe6cc80*|r"+this.type.name)
                        call BlzSetItemTooltip(this.bindItem,"|cffe6cc80*|r"+this.type.name)
                    else 
                        call BlzSetItemName(this.bindItem,"|cffff8800*|r"+this.type.name)
                        call BlzSetItemTooltip(this.bindItem,"|cffff8800*|r"+this.type.name)
                    endif 
                endif 
                set tempItem = null 
                set eventEquipment = 0
                set eventEquipmentOwner = null 
            endmethod
            method equip takes unit whichUnit returns nothing
                local integer slot = itemType2Slot(this.bindItem)
                local integer itemId = this.type.itemTypeId
                local Equipment nowInSlot = GetEquipedItem(whichUnit,slot)
                local integer baseItem = slot2BaseItem(whichUnit,slot)
                local item tempItem = null 
                local boolean typeAble = false 
                local attacktype attackType 
                local defensetype armorType
                local integer iiii = 0
                local boolean ableMelee = false 
                local boolean ableSpell = false 
                local boolean ableRange = false 
                local boolean itemMelee = false 
                local boolean itemSpell = false 
                local boolean itemRange = false 
                local item bindItem = null 
                local integer class = this.type.class 
                if inCombat(whichUnit) then 
                    call DisplayErrorMsg("|cffffcc00在战斗中时不能装备物品。|r")
                    return 
                endif 
                set bindItem = this.bindItem
                if whichUnit == armoury then 
                    set typeAble = true 
                else 
                    set attackType = ConvertAttackType(BlzGetUnitWeaponIntegerField(whichUnit,UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE,0))
                    if attackType == ATTACK_TYPE_MELEE then         //近战可用：1 5 7
                        set ableMelee = true 
                    elseif attackType == ATTACK_TYPE_PIERCE then    //远程可用：2 6 7
                        set ableRange = true 
                    elseif attackType == ATTACK_TYPE_MAGIC then     //法师可用：4 5 7
                        set ableSpell = true 
                    elseif attackType == ATTACK_TYPE_CHAOS then     //战斗法师可用：1 4 5 6 7
                        set ableMelee = true 
                        set ableSpell = true 
                    endif 
                    if slot < 1 then
                        set iiii = class 
                        if iiii >= 4 then 
                            set iiii = iiii-4
                            set itemSpell = true 
                        endif 
                        if iiii >= 2 then 
                            set iiii = iiii-2
                            set itemRange = true 
                        endif 
                        if iiii >= 1 then 
                            set iiii = iiii-1
                            set itemMelee = true 
                        endif 
                        if (itemMelee and ableMelee) or (itemRange and ableRange) or (itemSpell and ableSpell) then 
                            set typeAble = true
                        endif 
                    elseif slot < 5 then
                        if slot > 1 or (slot == 1 and class > 2) then 
                            set armorType = ConvertDefenseType(BlzGetUnitIntegerField(whichUnit,UNIT_IF_DEFENSE_TYPE))
                            if armorType == DEFENSE_TYPE_LARGE then 
                                set iiii = 4
                            elseif armorType == DEFENSE_TYPE_MEDIUM then 
                                set iiii = 3
                            elseif armorType == DEFENSE_TYPE_NONE then 
                                set iiii = 2
                            else 
                                set iiii = 1
                            endif 
                            if class <= iiii then 
                                set typeAble = true
                            endif 
                        elseif slot == 1 and class == 2 then 
                            if ableMelee or ableRange then  //近战/远程可用副手武器
                                set typeAble = true 
                            endif 
                        else 
                            set typeAble = true 
                        endif 
                    else 
                        set typeAble = true 
                    endif 
                endif 
                if typeAble then 
                    if this.type.requireLevel <= GetUnitLevel(whichUnit) or whichUnit == armoury then 
                        if slot == 6 and class > 2 and (itemId == GetEquipedItem(whichUnit,6).type.itemTypeId or itemId == GetEquipedItem(whichUnit,7).type.itemTypeId) then 
                            call DisplayErrorMsg("|cffffcc00该物品装备唯一。|r")
                        else 
                            //穿上物品
                            if GetEquipedItem(whichUnit,6) != 0 and GetEquipedItem(whichUnit,7) == 0 and slot == 6 then 
                                set slot = 7
                                set baseItem = slot2BaseItem(whichUnit,slot)
                                set nowInSlot = 0
                            endif 
                            if nowInSlot != 0 then 
                                call nowInSlot.unEquip(whichUnit,slot)
                            endif 
                            if this.warForged > 0 then 
                                if this.warForged >= 20  then 
                                    call BlzSetAbilityTooltip(baseItem,"|cffe6cc80*|r"+this.type.name,0)
                                else 
                                    call BlzSetAbilityTooltip(baseItem,"|cffff8800*|r"+this.type.name,0)
                                endif 
                            else 
                                call BlzSetAbilityTooltip(baseItem,this.type.name,0)
                            endif 
                            call BlzSetAbilityIcon(baseItem,BlzGetItemIconPath(bindItem))
                            call this.bindOnSlot(whichUnit,slot)
                            call RemoveItem(bindItem)
                            call this.applyStates()
                            call this.inSet.checkSet(0)
                            call BlzSetAbilityExtendedTooltip(baseItem,this.getDesc(),0)
                            if tempItem != null then 
                                call delayedUnitAddItem(whichUnit,tempItem)
                                set tempItem = null 
                            endif 
                            set eventEquipment = this 
                            set eventEquipmentOwner = whichUnit
                            call thistype.callBack_EquipOn()
                            set eventEquipment = 0
                            set eventEquipmentOwner = null 
                        endif 
                    else 
                        call DisplayErrorMsg("|cffffcc00等级不够。|r")
                    endif 
                else 
                    call DisplayErrorMsg("|cffffcc00装备类型不符。|r")
                endif 
            endmethod

            // region functionAddCallbacks
            method addBefDmg_S takes code action returns nothing
                local trigger newTrig = this.trigBeforedamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforedamageSource = newTrig
                set newTrig = null 
            endmethod
            method addBefDmg_T takes code action returns nothing
                local trigger newTrig = this.trigBeforedamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforedamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addPreDmg_S takes code action returns nothing
                local trigger newTrig = this.trigPredamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPredamageSource = newTrig
                set newTrig = null 
            endmethod
            method addPreDmg_T takes code action returns nothing
                local trigger newTrig = this.trigPredamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPredamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addDmging_S takes code action returns nothing
                local trigger newTrig = this.trigDamagingSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagingSource = newTrig
                set newTrig = null 
            endmethod
            method addDmging_T takes code action returns nothing
                local trigger newTrig = this.trigDamagingTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagingTarget = newTrig
                set newTrig = null 
            endmethod

            method addDmged_S takes code action returns nothing
                local trigger newTrig = this.trigDamagedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagedSource = newTrig
                set newTrig = null 
            endmethod
            method addDmged_T takes code action returns nothing
                local trigger newTrig = this.trigDamagedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigDamagedTarget = newTrig
                set newTrig = null 
            endmethod

            method addAftDmg_S takes code action returns nothing
                local trigger newTrig = this.trigAfterdamageSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterdamageSource = newTrig
                set newTrig = null 
            endmethod
            method addAftDmg_T takes code action returns nothing
                local trigger newTrig = this.trigAfterdamageTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterdamageTarget = newTrig
                set newTrig = null 
            endmethod

            method addBefHeal_S takes code action returns nothing
                local trigger newTrig = this.trigBeforehealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforehealSource = newTrig
                set newTrig = null 
            endmethod
            method addBefHeal_T takes code action returns nothing
                local trigger newTrig = this.trigBeforehealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigBeforehealTarget = newTrig
                set newTrig = null 
            endmethod

            method addPreHeal_S takes code action returns nothing
                local trigger newTrig = this.trigPreHealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPreHealSource = newTrig
                set newTrig = null 
            endmethod
            method addPreHeal_T takes code action returns nothing
                local trigger newTrig = this.trigPreHealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigPreHealTarget = newTrig
                set newTrig = null 
            endmethod

            method addHealing_S takes code action returns nothing
                local trigger newTrig = this.trigHealingSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealingSource = newTrig
                set newTrig = null 
            endmethod
            method addHealing_T takes code action returns nothing
                local trigger newTrig = this.trigHealingTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealingTarget = newTrig
                set newTrig = null 
            endmethod

            method addHealed_S takes code action returns nothing
                local trigger newTrig = this.trigHealedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealedSource = newTrig
                set newTrig = null 
            endmethod
            method addHealed_T takes code action returns nothing
                local trigger newTrig = this.trigHealedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigHealedTarget = newTrig
                set newTrig = null 
            endmethod

            method addAftHeal_S takes code action returns nothing
                local trigger newTrig = this.trigAfterhealSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterhealSource = newTrig
                set newTrig = null 
            endmethod
            method addAftHeal_T takes code action returns nothing
                local trigger newTrig = this.trigAfterhealTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAfterhealTarget = newTrig
                set newTrig = null 
            endmethod

            method addAtking takes code action returns nothing
                local trigger newTrig = this.trigAttacking
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttacking = newTrig
                set newTrig = null 
            endmethod

            method addAtked_S takes code action returns nothing
                local trigger newTrig = this.trigAttackedSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttackedSource = newTrig
                set newTrig = null 
            endmethod
            method addAtked_T takes code action returns nothing
                local trigger newTrig = this.trigAttackedTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigAttackedTarget = newTrig
                set newTrig = null 
            endmethod

            method addMslLnch takes code action returns nothing
                local trigger newTrig = this.trigMissileLaunch
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileLaunch = newTrig
                set newTrig = null 
            endmethod

            method addSpelling takes code action returns nothing
                local trigger newTrig = this.trigSpelling
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigSpelling = newTrig
                set newTrig = null 
            endmethod

            method addMslHit_S takes code action returns nothing
                local trigger newTrig = this.trigMissileHitSource
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileHitSource = newTrig
                set newTrig = null 
            endmethod
            method addMslHit_T takes code action returns nothing
                local trigger newTrig = this.trigMissileHitTarget
                if newTrig == null then 
                    set newTrig = CreateTrigger()
                endif 
                call TriggerAddActionEx(newTrig,action)
                set this.trigMissileHitTarget = newTrig
                set newTrig = null 
            endmethod

            // endregion
        endstruct 

        function GetEquipment takes item whichItem returns Equipment
            local integer result = 0
            if whichItem == null then 
                set whichItem = null 
                return 0
            endif 
            set result = LoadInteger(equipHash,GetHandleId(whichItem),99)
            if result != 0 then 
                set whichItem = null 
                return result 
            endif 
                set whichItem = null 
            return 0
        endfunction

        function AnyUnitBuyingItem_action takes nothing returns nothing
            local Equipment eq 
            if GetEquipType(GetItemTypeId(GetSoldItem())) > 0 then 
                set eq = Equipment.create(GetEquipType(GetItemTypeId(GetSoldItem())))
                call eq.bindOnItem(GetSoldItem())
            endif 
            if GetItemTypeId(GetSoldItem()) == 'ICST' then 
                call KillUnit(GetTriggerUnit())
            endif 
        endfunction
        function AnyUnitSellingItem_action takes nothing returns nothing
            if GetEquipment(GetSoldItem()) > 0 then 
                call GetEquipment(GetSoldItem()).destroy()
            endif 
        endfunction

        function ResetInvDescription takes unit whichUnit,integer slot returns nothing
            local integer baseItem = slot2BaseItem(whichUnit,slot)
            call BlzSetAbilityExtendedTooltip(baseItem,INV_TOOLTIP_EXTENDED[slot],0)
            call BlzSetAbilityTooltip(baseItem,INV_TOOLTIP[slot],0)
            call BlzSetAbilityIcon(baseItem,INV_ICON[slot])
            set whichUnit = null 
        endfunction

        function ExecuteEndingFunc takes mybuff whichBuff returns nothing
            local integer nowPeriodTime = whichBuff.periodTime
            set mybuff.currentBuff = whichBuff
            if whichBuff.periodTime > 0 and whichBuff.lastTriggerTime != globalNowtime and whichBuff.endTick then
                if whichBuff.hasteAble then 
                    set nowPeriodTime = nowPeriodTime*10000/(10000+unitGetAllBonusStateValue(whichBuff.buffSource,STATE_HASTE))
                endif
                set mybuff.buffTimeScale = I2R(globalNowtime-whichBuff.lastTriggerTime)/I2R(nowPeriodTime)
                if whichBuff.DISPEL then 
                    set mybuff.buffTimeScale = 0
                endif 
                if whichBuff.trigPeriod != null then 
                    call TriggerExecute(whichBuff.trigPeriod)
                    //call ExecuteFunc(whichBuff.periodFunc)
                endif 
            endif 
            if whichBuff.trigEnding != null then 
                call TriggerExecute(whichBuff.trigEnding)
                //call ExecuteFunc(whichBuff.endingFunc)
            endif 
            set mybuff.currentBuff = 0
            set mybuff.buffTimeScale = 1
        endfunction

        function DELAYED_APPLY_BUFF takes nothing returns nothing
            local delayedevent de = delayedevent.currentEvent
            local mybuff bf = de.loadInteger("BUFF")
            call bf.apply()
        endfunction
        function delayedApplyBuff takes mybuff whichBuff returns nothing
            local delayedevent de = delayedevent.create(1,1,function DELAYED_APPLY_BUFF)
            call de.saveInteger("BUFF",whichBuff)
        endfunction
         
        //====================================================
        // region applyControlEffect
        //====================================================
        function applyCold takes unit source,unit whichUnit,integer abilityId returns boolean
            local player owner = GetOwningPlayer(source)
            local unit buffDummy = null 
            if owner == Player(PLAYER_NEUTRAL_AGGRESSIVE) then 
                set owner = Player(11)
            endif 
            if UnitImmuneCold(whichUnit) then 
                set whichUnit = null 
                set owner = null 
                set source = null 
                return false 
            else 
                set buffDummy = CreateUnit(owner,'hDMY',GetUnitX(whichUnit),GetUnitY(whichUnit),0)
                set owner = null 
                call UnitAddAbility(buffDummy,abilityId)
                //call BJDebugMsg(GetUnitName(buffDummy)+"_ABILITY_"+I2SSSS(abilityId)+"_LEVEL="+I2S(GetUnitAbilityLevel(buffDummy,abilityId))+"_TO_"+GetUnitName(whichUnit))
                call IssueTargetOrder(buffDummy,"frostnova",whichUnit)
                call UnitApplyTimedLife(buffDummy,'BHwe',0.5)
                ////call BJDebugMsg("APPLY_TO_"+GetUnitName(whichUnit)+", "+I2SSSS(abilityId))
                set buffDummy = null 
                set whichUnit = null 
                set source = null 
                return true 
            endif 
        endfunction
        function applyStun takes unit source,unit whichUnit,integer abilityId returns boolean
            local player owner = GetOwningPlayer(source)
            local unit buffDummy = null 
            if owner == Player(PLAYER_NEUTRAL_AGGRESSIVE) then 
                set owner = Player(11)
            endif 
            if UnitImmuneStun(whichUnit) then 
                set whichUnit = null 
                set owner = null 
                set source = null 
                return false 
            else 
                set buffDummy = CreateUnit(owner,'hDMY',GetUnitX(whichUnit),GetUnitY(whichUnit),0)
                set owner = null 
                call UnitAddAbility(buffDummy,abilityId)
                call IssueTargetOrder(buffDummy,"thunderbolt",whichUnit)
                call UnitApplyTimedLife(buffDummy,'BHwe',0.5)
                set buffDummy = null 
                set whichUnit = null 
                set source = null 
                return true 
            endif 
        endfunction
        function applySnare takes unit source,unit whichUnit,integer abilityId returns boolean
            local player owner = GetOwningPlayer(source)
            local unit buffDummy = null 
            if owner == Player(PLAYER_NEUTRAL_AGGRESSIVE) then 
                set owner = Player(11)
            endif 
            if UnitImmuneSnare(whichUnit) then 
                set whichUnit = null 
                set owner = null 
                set source = null 
                return false 
            else 
                set buffDummy = CreateUnit(owner,'hDMY',GetUnitX(whichUnit),GetUnitY(whichUnit),0)
                set owner = null 
                call UnitAddAbility(buffDummy,abilityId)
                call IssueTargetOrder(buffDummy,"ensnare",whichUnit)
                call UnitApplyTimedLife(buffDummy,'BHwe',0.5)
                set buffDummy = null 
                set whichUnit = null 
                set source = null 
                return true 
            endif 
        endfunction
        function applyRoot takes unit source,unit whichUnit,integer abilityId returns boolean
            local player owner = GetOwningPlayer(source)
            local unit buffDummy = null 
            if owner == Player(PLAYER_NEUTRAL_AGGRESSIVE) then 
                set owner = Player(11)
            endif 
            if UnitImmuneRoot(whichUnit) then 
                set whichUnit = null 
                set owner = null 
                set source = null 
                return false 
            else 
                set buffDummy = CreateUnit(owner,'hDMY',GetUnitX(whichUnit),GetUnitY(whichUnit),0)
                set owner = null 
                call UnitAddAbility(buffDummy,abilityId)
                call IssueTargetOrder(buffDummy,"entanglingroots",whichUnit)
                call UnitApplyTimedLife(buffDummy,'BHwe',0.5)
                set buffDummy = null 
                set whichUnit = null 
                set source = null 
                return true 
            endif 
        endfunction
        function applySilence takes unit source,unit whichUnit,integer abilityId returns boolean
            local player owner = GetOwningPlayer(source)
            local unit buffDummy = null 
            if owner == Player(PLAYER_NEUTRAL_AGGRESSIVE) then 
                set owner = Player(11)
            endif 
            if UnitImmuneSilence(whichUnit) then 
                set whichUnit = null 
                set owner = null 
                set source = null 
                return false 
            else 
                set buffDummy = CreateUnit(owner,'hDMY',GetUnitX(whichUnit),GetUnitY(whichUnit),0)
                set owner = null 
                call UnitAddAbility(buffDummy,abilityId)
                call IssueTargetOrder(buffDummy,"soulburn",whichUnit)
                call UnitApplyTimedLife(buffDummy,'BHwe',0.5)
                set buffDummy = null 
                set whichUnit = null 
                set source = null 
                return true 
            endif 
        endfunction

        function removeStun takes unit whichUnit returns nothing
            if whichUnit == null then 
                set whichUnit = null 
                return 
            endif 
            call UnitRemoveAbility(whichUnit,'BPSE')
                set whichUnit = null 
        endfunction
        function removeCold takes unit whichUnit returns nothing
            if whichUnit == null then 
                set whichUnit = null 
                return 
            endif 
            call UnitRemoveAbility(whichUnit,'Bfro')
                set whichUnit = null 
        endfunction
        function removeRoot takes unit whichUnit returns nothing
            if whichUnit == null then 
                set whichUnit = null 
                return 
            endif 
            call UnitRemoveAbility(whichUnit,'BEer')
                set whichUnit = null 
        endfunction
        function removeSilence takes unit whichUnit returns nothing
            if whichUnit == null then 
                set whichUnit = null 
                return 
            endif 
            call UnitRemoveAbility(whichUnit,'BNsi')
                set whichUnit = null 
        endfunction
        function removeSnare takes unit whichUnit returns nothing
            if whichUnit == null then 
                set whichUnit = null 
                return 
            endif 
            call UnitRemoveAbility(whichUnit,'Bena')
            call UnitRemoveAbility(whichUnit,'Beng')
            call UnitRemoveAbility(whichUnit,'BSN0')
            call UnitRemoveAbility(whichUnit,'BSN1')
                set whichUnit = null 
        endfunction
        function removeAllDisabilities takes unit whichUnit returns nothing
            if whichUnit == null then 
                set whichUnit = null 
                return 
            endif 
            call removeSilence(whichUnit)
            call removeStun(whichUnit)
            call removeSnare(whichUnit)
            call removeCold(whichUnit)
            call removeRoot(whichUnit)
                set whichUnit = null 
        endfunction

        function haveCold takes unit whichUnit returns boolean
            return GetUnitAbilityLevel(whichUnit,'Bfro') > 0
        endfunction
        function haveSnare takes unit whichUnit returns boolean
            return (GetUnitAbilityLevel(whichUnit,'Bena') > 0) or (GetUnitAbilityLevel(whichUnit,'Beng') > 0) or (GetUnitAbilityLevel(whichUnit,'BSN0') > 0) or (GetUnitAbilityLevel(whichUnit,'BSN1') > 0)
        endfunction
        function haveStun takes unit whichUnit returns boolean
            return GetUnitAbilityLevel(whichUnit,'BPSE') > 0
        endfunction
        function haveSilence takes unit whichUnit returns boolean
            return GetUnitAbilityLevel(whichUnit,'BNsi') > 0
        endfunction
        function haveRoot takes unit whichUnit returns boolean
            return GetUnitAbilityLevel(whichUnit,'BEer') > 0
        endfunction
        //====================================================
        // endregion 
        //====================================================

        function centeralTimerUpdate takes nothing returns nothing
            set globalNowtime = globalNowtime+1

            if ModuloInteger(globalNowtime,10) == 0 then 
                call damageMeterUpdate.execute()
                call minion.updateAll.execute()
            endif 
            if ModuloInteger(globalNowtime,15) == 0 then 
                call AutomaticGate.updateAll.execute()
            endif 
            if ModuloInteger(globalNowtime,20) == 0 then 
                call Enemy.updateAll.execute()
            endif 
            if ModuloInteger(globalNowtime,3) == 0 then 
                call Knockup.updateAll.execute()
                call ChaseTarget.updateAll.execute()
                call Orbit.updateAll.execute()
            endif 
            if ModuloInteger(globalNowtime,2) == 0 then 
                call Hook.updateAll.execute()
            endif 
            call Bar.updateAll.execute()
            call Lightning.updateAll.execute()
            
            call Patrol.updateAll.execute()

            if globalNowtime-globalNowtime/(Settings_OtherSaveInterval*100)*(Settings_OtherSaveInterval*100) == 0 and globalNowtime != 0 and Settings_OtherAutoSave then 
                call CheckPoint("AutoSave",true)
            endif 
            
            if Settings_OtherMusic and BGM.IsPaused then 
                call BGM.play()
            endif 

            call ItemRecallFlush.execute()
        endfunction

        //====================================================
        // region save&load
        //====================================================

        // index 0~50：分配给英雄，等于英雄编号       key 0-5 : 背包； key 10-19 : 装备栏
        // index 99: 军械库                         key 0-5 : 背包； key 10-19 : 装备栏
        // index 51: 随身背包1                      key 0-5 : 背包
        // index 52: 随身背包2                      key 0-5 : 背包
        // index 53: 随身背包3                      key 0-5 : 背包
        // index 54: 随身背包4                      key 0-5 : 背包
        // index 60: 银行1                          key 0-5 : 背包
        // index 61: 银行2                          key 0-5 : 背包
        // index 62: 银行3                          key 0-5 : 背包
        // index 63: 银行4                          key 0-5 : 背包
        // index 64: 银行5                          key 0-5 : 背包
        // index 65: 银行6                          key 0-5 : 背包
        // index 66: 银行7                          key 0-5 : 背包
        // index 67: 银行8                          key 0-5 : 背包
        function storeItem takes integer index,integer key,Equipment e returns nothing
            local string path = "ITEM_DATA"
            local string childPath = "EQUIP_INDEX_"+I2S(index)+"_KEY_"+I2S(key)+"_"
            local integer typeId = 0
            local integer enc = 0
            local integer craft_0 = 0
            local integer craft_1 = 0
            local integer craft_2 = 0
            local integer wf = 0
            local integer checker = 0
            if e > 0 then 
                set typeId = e.type.itemTypeId
                set enc = GetIdByEnc(e.enc)
                set craft_0 = GetIdByEnc(e.craft_0)
                set craft_1 = GetIdByEnc(e.craft_1)
                set craft_2 = GetIdByEnc(e.craft_2)
                set wf = e.warForged
                set checker = typeId+enc+craft_0+craft_1+craft_2+wf 
            endif 
            call StoreInteger(gameCache,path,childPath+"TYPE_ID",typeId)
            call StoreInteger(gameCache,path,childPath+"ENC",enc)
            call StoreInteger(gameCache,path,childPath+"CRAFT_0",craft_0)
            call StoreInteger(gameCache,path,childPath+"CRAFT_1",craft_1)
            call StoreInteger(gameCache,path,childPath+"CRAFT_2",craft_2)
            call StoreInteger(gameCache,path,childPath+"WARFORGED",wf)
            call StoreInteger(gameCache,path,childPath+"CHECKER",checker)
            call StoreInteger(gameCache,path,childPath+"NEWV",1)
        endfunction

        globals
            private boolean ifDebug = false 
            private integer loadingHero = 0
            private integer loadingBag  = 0
            private integer loadingBank = 0

            private integer savingHero = 0
            private integer savingBag  = 0
            private integer savingBank = 0

            private timer loadHeroT     = CreateTimer()
            private timer loadBagT      = CreateTimer()
            private timer loadBankT     = CreateTimer()
            private timer loadPartyT    = CreateTimer()
            private timer saveHeroT     = CreateTimer()
            private timer saveBagT      = CreateTimer()
            private timer saveBankT     = CreateTimer()
            private timer saveFileT     = CreateTimer()
        endglobals

        function GetHeroStackId takes unit whichHero returns integer
            local integer i = 0
            if GetHeroIndex(whichHero) <= 0 then 
                return -1
            endif 
            loop
                exitwhen i > MAX_HERO_TYPE-1
                if HERO_STACK[i] == whichHero then 
                    return i
                endif 
                set i = i+1
            endloop
            return -1
        endfunction
        function StackHero takes unit whichHero returns nothing
            set HERO_STACK[HERO_STACK_NUM] = whichHero
            set HERO_STACK_NUM = HERO_STACK_NUM+1
        endfunction
        // index 0~49：分配给英雄，等于英雄编号       key 0-5 : 背包； key 10-19 : 装备栏
        // index 99: 军械库                         key 0-5 : 背包； key 10-19 : 装备栏
        // index 50: 随身背包1                      key 0-5 : 背包
        // index 51: 随身背包2                      key 0-5 : 背包
        // index 52: 随身背包3                      key 0-5 : 背包
        // index 53: 随身背包4                      key 0-5 : 背包
        // index 60: 银行1                          key 0-5 : 背包
        // index 61: 银行2                          key 0-5 : 背包
        // index 62: 银行3                          key 0-5 : 背包
        // index 63: 银行4                          key 0-5 : 背包
        // index 64: 银行5                          key 0-5 : 背包
        // index 65: 银行6                          key 0-5 : 背包
        // index 66: 银行7                          key 0-5 : 背包
        // index 67: 银行8                          key 0-5 : 背包
        function getStoredItem takes integer index,integer key returns Equipment
            local string path = "ITEM_DATA"
            local string childPath = "EQUIP_INDEX_"+I2S(index)+"_KEY_"+I2S(key)+"_"
            local integer typeId = 0
            local Equipment e = 0
            local integer enc = 0
            local integer craft_0 = 0
            local integer craft_1 = 0
            local integer craft_2 = 0
            local integer wf = 0
            local integer checker = 0
            local integer newV = 0
            if HaveStoredInteger(gameCache,path,childPath+"TYPE_ID") then 
                set typeId = GetStoredInteger(gameCache,path,childPath+"TYPE_ID")
                if typeId > 0 then 
                    set enc = GetStoredInteger(gameCache,path,childPath+"ENC")
                    set craft_0 = GetStoredInteger(gameCache,path,childPath+"CRAFT_0")
                    set craft_1 = GetStoredInteger(gameCache,path,childPath+"CRAFT_1")
                    set craft_2 = GetStoredInteger(gameCache,path,childPath+"CRAFT_2")
                    set wf = GetStoredInteger(gameCache,path,childPath+"WARFORGED")
                    set checker = GetStoredInteger(gameCache,path,childPath+"CHECKER")
                    set newV = GetStoredInteger(gameCache,path,childPath+"NEWV")
                    if newV == 1 and checker != typeId+enc+craft_0+craft_1+craft_2+wf then 
                        return 0
                    endif 
                    set e = Equipment.create(GetEquipType(typeId))
                    call e.setEnc(enc)
                    call e.setC0(craft_0)
                    call e.setC1(craft_1)
                    call e.setC2(craft_2)
                    call e.setWF(wf)
                endif 
            endif 
            return e 
        endfunction

        function loadHeroData takes nothing returns nothing
            local integer i = loadingHero
            local real x    = 0
            local real y    = 0
            local integer k = 0
            local integer itemTypeId = 0
            local Enchantment enc 
            local Enchantment warForged
            local Enchantment craft_0 
            local Enchantment craft_1 
            local Enchantment craft_2 
            local Equipment eq
            local boolean loaded = false
            set k = 0
            loop 
                exitwhen k > 4
                if GetHeroIndex(party[k])==i+1 then 
                    set loaded = true 
                    set hero[i] = party[k]
                endif 
                set k = k+1
            endloop
            if loaded == false then 
                set x = GetRandomReal(GetRectMinX(loadOtherHeroesRect),GetRectMaxX(loadOtherHeroesRect))
                set y = GetRandomReal(GetRectMinY(loadOtherHeroesRect),GetRectMaxY(loadOtherHeroesRect))
                set hero[i] = RestoreUnit(gameCache,"UNITS","HERO_"+I2S(i),PLAYER2,x,y,GetRandomReal(0,360))
                set eliteLevel[i] = GetStoredInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_ELITE_LEVEL")
                if hero[i] == null then 
                    set hero[i] = CreateUnit(PLAYER2,HERO_DEFAULT_ID[i],x,y,GetRandomReal(0,360))
                    call SetHeroXP(hero[i],GetHeroXP(hero[0]),false)
                    set eliteLevel[i] = eliteLevel[0]
                endif 
                call StackHero(hero[i])
                call PlaceUnselectedHeroScatteredImmediate(hero[i], loadOtherHeroesRect)
                call ShowUnit(hero[i], false)
            endif 
            if NEED_REFRESH_FORM[i] then 
                call form.refreshFormDatas(hero[i])
            endif 
            set k = 0
            loop 
                exitwhen k > 5
                set eq = getStoredItem(i,k)
                if eq > 0 then 
                    if UnitItemInSlot(hero[i],k) != null then
                        call eq.bindOnItem(UnitItemInSlot(hero[i],k))
                        call eq.updateItemDesc()
                    endif 
                endif 
                set k = k+1
            endloop
            set k = 0
            loop 
                exitwhen k > 9
                set eq = getStoredItem(i,10+k)
                if eq > 0 then 
                    call eq.bindOnSlot(hero[i],k)
                    call eq.changeAbility()
                    set eventEquipment = eq
                    call Equipment.callBack_EquipOn()
                endif 
                set k = k+1
            endloop
            call SetHeroData(hero[i],"LEARNED_ABILITY_0",GetStoredInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_LEARNED_ABILITY_0"))
            call SetHeroData(hero[i],"LEARNED_ABILITY_1",GetStoredInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_LEARNED_ABILITY_1"))
            call SetHeroData(hero[i],"LEARNED_ABILITY_2",GetStoredInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_LEARNED_ABILITY_2"))
            call SetHeroData(hero[i],"LEARNED_ABILITY_3",GetStoredInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_LEARNED_ABILITY_3"))
            call SetHeroData(hero[i],"LEARNED_ABILITY_4",GetStoredInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_LEARNED_ABILITY_4"))
            call Learn.evaluate(hero[i],GetHeroData(hero[i],"LEARNED_ABILITY_0"))
            call Learn.evaluate(hero[i],GetHeroData(hero[i],"LEARNED_ABILITY_1"))
            call Learn.evaluate(hero[i],GetHeroData(hero[i],"LEARNED_ABILITY_2"))
            call Learn.evaluate(hero[i],GetHeroData(hero[i],"LEARNED_ABILITY_3"))
            call Learn.evaluate(hero[i],GetHeroData(hero[i],"LEARNED_ABILITY_4"))
            if eliteLevel[i] > 0 then 
                call BlzSetUnitName(hero[i],heroName[i]+"(|cff88aaff"+I2S(eliteLevel[i])+"|r)")
            endif 
            call CheckHeroLearnBook.evaluate(hero[i])
            set currentTTOwner = hero[i]
            call unitCheckState.evaluate(currentTTOwner)
            set k = 0
            loop 
                exitwhen k > 3
                call SetHeroSelectedPublicTalent(hero[i],k,GetStoredInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_PUBLIC_TALENT_"+I2S(k)))
                call SetHeroSelectedPrivateTalent(hero[i],k,GetStoredInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_PRIVATE_TALENT_"+I2S(k)))
                set k = k+1
            endloop
            call SetHeroSelectedUltimateTalent(hero[i],0,GetStoredInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_ULTIMATE_TALENT_0"))
            call SetHeroSelectedUltimateTalent(hero[i],1,GetStoredInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_ULTIMATE_TALENT_1"))
            if GetPartyIndex(hero[i]) > -1 then 
                call RefreshHeroTalent_Learn.evaluate(hero[i])
            endif 
            set currentTTOwner = null 

            if Settings_AutoAttack then 
                call IssueImmediateOrderById(hero[i],ORDER_blackarrowon)
            endif 
            if Settings_AutoHeal then 
                call IssueImmediateOrderById(hero[i],ORDER_healon)
            endif 
            if Settings_AutoBerserk then 
                call IssueImmediateOrderById(hero[i],ORDER_frenzyon)
            endif 

            set loadingHero = loadingHero+1
            
            if loadingHero >= MAX_HERO_TYPE then 
                call PauseTimer(loadHeroT)
            endif 
        endfunction
        function loadOtherHeroes takes nothing returns nothing
            set loadingHero = 0
            call TimerStart(loadHeroT,0.0,true,function loadHeroData)
            //call DisplayTimedTextToPlayer(PLAYER,0,0,5,"|cffffcc00英雄加载完成|r")
        endfunction
        function loadParty takes nothing returns nothing
            local real x    = 0
            local real y    = 0
            local integer i = 0
            ////////////call BJDebugMsg("loadingparty")
            loop 
                exitwhen i > 4
                set x = GetRandomReal(GetRectMinX(loadPartyRect),GetRectMaxX(loadPartyRect))
                set y = GetRandomReal(GetRectMinY(loadPartyRect),GetRectMaxY(loadPartyRect))
                set party[i] = RestoreUnit(gameCache,"UNITS","PARTY_"+I2S(i),PLAYER,x,y,GetRandomReal(0,360))
                call StackHero(party[i])
                call SetHeroData(party[i],PARTY_INDEX,i+1)
                call UnitAddAbility(party[i],'AIV0'+i)
                call UnitMakeAbilityPermanent(party[i],true,'AIV0'+i)
                call SelectUnitAddForPlayer(party[i],PLAYER)
                set i = i+1
            endloop 
            call SetCameraPosition(GetUnitX(party[0]),GetUnitY(party[0]))
            call TimerStart(loadHeroT,0.0,false,function loadOtherHeroes)
        endfunction
        function loadBagData takes nothing returns nothing
            local integer i = loadingBag
            local real x    = 0
            local real y    = 0
            local integer k = 0
            local integer itemTypeId = 0
            local Enchantment enc 
            local Enchantment warForged
            local Enchantment craft_0 
            local Enchantment craft_1 
            local Enchantment craft_2 
            local Equipment eq 
            ////////////call BJDebugMsg("loadingbags")
            set x = GetRectCenterX(loadPartyRect)
            set y = GetRectCenterY(loadPartyRect)
            
            set bag[i] = RestoreUnit(gameCache,"UNITS","BAG_"+I2S(i),NEUTRAL,x,y,0)
            if GetUnitTypeId(bag[i]) != 'hBAG' then
                call RemoveUnit(bag[i])
            endif 
            if bag[i] == null then 
                set bag[i] = CreateUnit(NEUTRAL,'hBAG',x,y,0)
            endif 
            call SetUnitPathing(bag[i],false)
            call SetUnitPropWindow(bag[i],0)
            set k = 0
            loop
                exitwhen k > 5
                set eq = getStoredItem(50+i,k)
                if eq > 0 then 
                    if UnitItemInSlot(bag[i],k) != null then 
                        call eq.bindOnItem(UnitItemInSlot(bag[i],k))
                        call eq.updateItemDesc()
                    endif 
                //elseif GetEquipType(GetItemTypeId(UnitItemInSlot(bag[i],k))) > 0 then 
                //    set eq = Equipment.create(GetEquipType(GetItemTypeId(UnitItemInSlot(bag[i],k))))
                //    call eq.bindOnItem(UnitItemInSlot(bag[i],k))
                //   call eq.updateItemDesc()
                endif 
                set k = k+1
            endloop
            
            set loadingBag = loadingBag+1
            if loadingBag > 7 then 
                call PauseTimer(loadBagT)
                call SetUnitOwner(bag[0],PLAYER,false)
                set currentBag = 0
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
            endif 
        endfunction
        function loadBankData takes nothing returns nothing
            local integer i = loadingBank
            local integer k = 0
            local integer itemTypeId = 0
            local Enchantment enc 
            local Enchantment warForged
            local Enchantment craft_0 
            local Enchantment craft_1 
            local Enchantment craft_2 
            local Equipment eq 
            set bank[i] = RestoreUnit(gameCache,"UNITS","BANK_"+I2S(i),NEUTRAL,loadBankX[i],loadBankY[i],315)
            if bank[i] == null then 
                set bank[i] = CreateUnit(NEUTRAL,'hBNK',loadBankX[i],loadBankY[i],315)
            endif 
            call UnitRemoveAbility(bank[i],'Amov')
            call ShowUnit(bank[i],false)
            set k = 0
            loop
                exitwhen k > 5
                set eq = getStoredItem(60+i,k)
                if eq > 0 then 
                    if UnitItemInSlot(bank[i],k) != null then 
                        call eq.bindOnItem(UnitItemInSlot(bank[i],k))
                        call eq.updateItemDesc()
                    endif 
                //elseif GetEquipType(GetItemTypeId(UnitItemInSlot(bank[i],k))) > 0 then 
                //    set eq = Equipment.create(GetEquipType(GetItemTypeId(UnitItemInSlot(bank[i],k))))
                //    call eq.bindOnItem(UnitItemInSlot(bank[i],k))
                //    call eq.updateItemDesc()
                endif 
                set k = k+1
            endloop

            if i < enableBank and MAP_IS_DUNGEON == false then 
               call ShowUnit(bank[i],true)
               call SetUnitOwner(bank[i],PLAYER,true)
            endif 

            set loadingBank = loadingBank+1
            if loadingBank > 7 then 
                call PauseTimer(loadBankT)
            endif 
        endfunction
        function loadBags takes nothing returns nothing
            local real x    = 0
            local real y    = 0
            local integer i = 0
            local integer k = 0
            local integer itemTypeId = 0
            local Enchantment enc 
            local Enchantment warForged
            local Enchantment craft_0 
            local Enchantment craft_1 
            local Enchantment craft_2 
            local Equipment eq 

            call TimerStart(loadBagT,0,true,function loadBagData)
            call TimerStart(loadBankT,0,true,function loadBankData)

            set armoury = RestoreUnit(gameCache,"UNITS","ARMOURY",NEUTRAL,loadArmouryX,loadArmouryY,135)
            if GetUnitTypeId(armoury) != 'hARM' then 
                call RemoveUnit(armoury)
            endif 
            if armoury == null then 
                set armoury = CreateUnit(NEUTRAL,'hARM',loadArmouryX,loadArmouryY,135)
            endif 
            call UnitRemoveAbility(armoury,'Amov')
            if GetStoredInteger(gameCache,"DATAS","HINT_UNLOCK_ARMOURY") == 1 then
                call SetUnitOwner(armoury,PLAYER,true)
            endif 

            set k = 0
            loop
                exitwhen k > 5
                set eq = getStoredItem(99,k)
                if eq > 0 then 
                    if UnitItemInSlot(armoury,k) != null then 
                        call eq.bindOnItem(UnitItemInSlot(armoury,k))
                        call eq.updateItemDesc()
                    endif 
                //elseif GetEquipType(GetItemTypeId(UnitItemInSlot(armoury,k))) > 0 then 
                //    set eq = Equipment.create(GetEquipType(GetItemTypeId(UnitItemInSlot(armoury,k))))
                //    call eq.bindOnItem(UnitItemInSlot(armoury,k))
                //    call eq.updateItemDesc()
                endif 
                set k = k+1
            endloop

            set k = 0
            loop
                exitwhen k > 9
                set eq = getStoredItem(99,10+k)
                if eq > 0 then 
                    call eq.bindOnSlot(armoury,k)
                    call eq.changeAbility()
                endif 
                set k = k+1
            endloop


            call ShowUnit(armoury,false)
            ////////////call BJDebugMsg("loadbags")
        endfunction
        function loadCampaignDatas takes nothing returns nothing
            local integer i = 0
            local boolean haveSaveData = GetStoredBoolean(gameCache,"DATAS","HAVE_SAVE_FILES")
            if haveSaveData then
                call TimerStart(loadPartyT,0.01,false,function loadParty)
                call TimerStart(loadBagT,0.02,false,function loadBags)
                call SetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_GOLD,GetStoredInteger(gameCache,"DATAS","GOLD"))
                call SetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_LUMBER,GetStoredInteger(gameCache,"DATAS","LUMBER"))
                set enableBank = GetStoredInteger(gameCache,"DATAS","ENABLE_BANK")
                set startTotalTime = GetStoredInteger(gameCache,"DATAS","GLOBAL_TOTAL_TIME")
            endif
            call QuestManager.loadAll()
            call LoadSeqs.execute()
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"ENTER",0)
            //call DisplayTimedTextToPlayer(PLAYER,0,0,5,"|cffffcc00战役数据加载完成|r")
            if GetStoredInteger(gameCache,"KEYS","OPEN_MAP_2") == 1 then 
                call ShowCustomCampaignButton(true,2)
            else 
                call ShowCustomCampaignButton(false,2)
            endif 

            /////////////////////////////////////////////////////////////////////////////////////////////
            if bankManager != null then 
                if enableBank > 0 then
                    if enableBank < 8 then 
                        call QuestReplaceDialog.evaluate(bankManager,'IB00','IB00'+enableBank,1)
                    else 
                        call QuestRemoveDialog.evaluate(bankManager,'IB00')
                    endif 
                else 
                    call QuestAddDialog.evaluate(bankManager,'IB00',1)
                endif 
            endif 

            if haveSaveData then 
                set Settings_FloatDamage = GetStoredBoolean(gameCache,"DATAS","SETTINGS_FLOAT_DAMAGE")
                set Settings_FloatHeal = GetStoredBoolean(gameCache,"DATAS","SETTINGS_FLOAT_HEAL")
                set Settings_FloatDot = GetStoredBoolean(gameCache,"DATAS","SETTINGS_FLOAT_DOT")
                set Settings_FloatMinionDamage = GetStoredBoolean(gameCache,"DATAS","SETTINGS_FLOAT_MINION_DAMAGE")
                set Settings_FloatHot = GetStoredBoolean(gameCache,"DATAS","SETTINGS_FLOAT_HOT")
                set Settings_FloatMinionHeal = GetStoredBoolean(gameCache,"DATAS","SETTINGS_FLOAT_MINION_HEAL")
                set Settings_FloatNoCrit = GetStoredBoolean(gameCache,"DATAS","SETTINGS_FLOAT_NO_CRIT")

                set Settings_CombatBossStart = GetStoredBoolean(gameCache,"DATAS","SETTINGS_LOG_BOSS_START")
                set Settings_CombatBossEnd = GetStoredBoolean(gameCache,"DATAS","SETTINGS_LOG_BOSS_END")

                set Settings_AutoAttack = GetStoredBoolean(gameCache,"DATAS","SETTINGS_AUTO_ATTACK")
                set Settings_AutoHeal = GetStoredBoolean(gameCache,"DATAS","SETTINGS_AUTO_HEAL")
                set Settings_AutoBerserk = GetStoredBoolean(gameCache,"DATAS","SETTINGS_AUTO_BERSERK")

                set Settings_OtherFullMap = GetStoredBoolean(gameCache,"DATAS","SETTINGS_OTHER_FULL_MAP")
                set Settings_OtherMusic = GetStoredBoolean(gameCache,"DATAS","SETTINGS_OTHER_MUSIC")
                set Settings_OtherMusicMode = GetStoredInteger(gameCache,"DATAS","SETTINGS_OTHER_MUSIC_MODE")
                set Settings_OtherAutoSave = GetStoredBoolean(gameCache,"DATAS","SETTINGS_OTHER_AUTO_SAVE")
                set Settings_OtherSaveInterval = IMaxBJ(30,GetStoredInteger(gameCache,"DATAS","SETTINGS_OTHER_SAVE_INTERVAL"))
                set Settings_OtherSaveLimit = IMaxBJ(1,GetStoredInteger(gameCache,"DATAS","SETTINGS_OTHER_SAVE_LIMIT"))
                set Settings_OtherCloseSearch = GetStoredBoolean(gameCache,"DATAS","SETTINGS_OTHER_CLOSE_SEARCH")
                set Settings_OtherNewFrameMode = GetStoredBoolean(gameCache,"DATAS","SETTINGS_OTHER_NEW_FRAME_MODE")
                if Settings_OtherFullMap then 
                    call Cheat("iseedeadpeople")
                endif 
                call SetMaxCheckpointSaves(Settings_OtherSaveLimit)
            endif 
        endfunction
        
        function saveHeroData takes nothing returns nothing
            local integer i = savingHero
            local integer k = 0
            call StoreUnit(gameCache,"UNITS","HERO_"+I2S(i),hero[i])
            call StoreInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_LEARNED_ABILITY_0",GetHeroData(hero[i],"LEARNED_ABILITY_0"))
            call StoreInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_LEARNED_ABILITY_1",GetHeroData(hero[i],"LEARNED_ABILITY_1"))
            call StoreInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_LEARNED_ABILITY_2",GetHeroData(hero[i],"LEARNED_ABILITY_2"))
            call StoreInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_LEARNED_ABILITY_3",GetHeroData(hero[i],"LEARNED_ABILITY_3"))
            call StoreInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_LEARNED_ABILITY_4",GetHeroData(hero[i],"LEARNED_ABILITY_4"))
            call StoreInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_ELITE_LEVEL",eliteLevel[i])
            set k = 0
            loop 
                exitwhen k > 3
                call StoreInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_PUBLIC_TALENT_"+I2S(k),GetHeroSelectedPublicTalent(hero[i],k))
                call StoreInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_PRIVATE_TALENT_"+I2S(k),GetHeroSelectedPrivateTalent(hero[i],k))
                set k = k+1
            endloop
            call StoreInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_ULTIMATE_TALENT_0",GetHeroSelectedUltimateTalent(hero[i],0))
            call StoreInteger(gameCache,"DATAS","HERO_"+I2S(i)+"_ULTIMATE_TALENT_1",GetHeroSelectedUltimateTalent(hero[i],1))

            set k = 0
            loop
                exitwhen k > 5
                call storeItem(i,k,GetEquipment(UnitItemInSlot(hero[i],k)))
                set k = k+1
            endloop
            set k = 0
            loop
                exitwhen k > 9
                call storeItem(i,10+k,GetEquipedItem(hero[i],k))
                set k = k+1
            endloop

            set savingHero = savingHero+1
            if savingHero >= MAX_HERO_TYPE then 
                call PauseTimer(saveHeroT)
            endif 
        endfunction
        function saveBagData takes nothing returns nothing
            local integer i = savingBag
            local integer k = 0
            call StoreUnit(gameCache,"UNITS","BAG_"+I2S(i),bag[i])
            loop
                exitwhen k > 5
                call storeItem(50+i,k,GetEquipment(UnitItemInSlot(bag[i],k)))
                set k = k+1
            endloop
            
            set savingBag = savingBag+1
            if savingBag > 7 then 
                call PauseTimer(saveBagT)
            endif 
        endfunction
        function saveBankData takes nothing returns nothing
            local integer i = savingBank
            local integer k = 0
            call StoreUnit(gameCache,"UNITS","BANK_"+I2S(i),bank[i])
            loop
                exitwhen k > 5
                call storeItem(60+i,k,GetEquipment(UnitItemInSlot(bank[i],k)))
                set k = k+1
            endloop

            set savingBank = savingBank+1
            if savingBank > 7 then 
                call PauseTimer(saveBankT)
            endif 
        endfunction
        function saveToDisk takes nothing returns nothing
            call SaveGameCache(gameCache)
            set isSavingCampaign = false
        endfunction
        function saveCampaignDatas takes nothing returns nothing
            // 如果分段写入尚未完成则延迟重试，保证所有 Store* 操作完成后再真正写入 cache
            if savingHero < MAX_HERO_TYPE or savingBag <= 3 or savingBank <= 7 then
                call TimerStart(saveFileT,0.1,false,function saveCampaignDatas)
                return
            endif
            call saveToDisk()
        endfunction
        function save takes nothing returns nothing
            local integer i = 0
            local integer k = 0

            set savingHero = 0
            set savingBag = 0
            set savingBank = 0
            // 标记正在进行分段存档，避免同时触发 checkpoint/save 导致冲突
            set isSavingCampaign = true
            call TimerStart(saveHeroT,0.01,true,function saveHeroData)
            call TimerStart(saveBagT,0.01,true,function saveBagData)
            call TimerStart(saveBankT,0.01,true,function saveBankData)

            set i = 0
            loop 
                exitwhen i > 4
                call StoreUnit(gameCache,"UNITS","PARTY_"+I2S(i),party[i])
                set i = i+1
            endloop
            call StoreUnit(gameCache,"UNITS","ARMOURY",armoury)
            set k = 0
            loop
                exitwhen k > 5
                call storeItem(99,k,GetEquipment(UnitItemInSlot(armoury,k)))
                set k = k+1
            endloop
            set k = 0
            loop
                exitwhen k > 9
                call storeItem(99,10+k,GetEquipedItem(armoury,k))
                set k = k+1
            endloop

            call StoreInteger(gameCache,"DATAS","GOLD",GetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_GOLD))
            call StoreInteger(gameCache,"DATAS","LUMBER",GetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_LUMBER))
            call StoreBoolean(gameCache,"DATAS","HAVE_SAVE_FILES",true)
            call StoreInteger(gameCache,"DATAS","VERSION",VERSION)
            call StoreInteger(gameCache,"DATAS","ENABLE_BANK",enableBank)
            call StoreInteger(gameCache,"DATAS","GLOBAL_TOTAL_TIME",startTotalTime+globalNowtime/10)

            call StoreBoolean(gameCache,"DATAS","SETTINGS_FLOAT_DAMAGE", Settings_FloatDamage)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_FLOAT_HEAL", Settings_FloatHeal)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_FLOAT_DOT", Settings_FloatDot)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_FLOAT_MINION_DAMAGE", Settings_FloatMinionDamage)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_FLOAT_HOT", Settings_FloatHot)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_FLOAT_MINION_HEAL", Settings_FloatMinionHeal)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_FLOAT_NO_CRIT", Settings_FloatNoCrit)

            call StoreBoolean(gameCache,"DATAS","SETTINGS_LOG_BOSS_START", Settings_CombatBossStart)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_LOG_BOSS_END", Settings_CombatBossEnd)

            call StoreBoolean(gameCache,"DATAS","SETTINGS_AUTO_ATTACK", Settings_AutoAttack)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_AUTO_HEAL", Settings_AutoHeal)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_AUTO_BERSERK", Settings_AutoBerserk)

            call StoreBoolean(gameCache,"DATAS","SETTINGS_OTHER_FULL_MAP", Settings_OtherFullMap)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_OTHER_MUSIC", Settings_OtherMusic)
            call StoreInteger(gameCache,"DATAS","SETTINGS_OTHER_MUSIC_MODE", Settings_OtherMusicMode)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_OTHER_AUTO_SAVE", Settings_OtherAutoSave)
            call StoreInteger(gameCache,"DATAS","SETTINGS_OTHER_SAVE_INTERVAL", Settings_OtherSaveInterval)
            call StoreInteger(gameCache,"DATAS","SETTINGS_OTHER_SAVE_LIMIT", Settings_OtherSaveLimit)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_OTHER_CLOSE_SEARCH", Settings_OtherCloseSearch)
            call StoreBoolean(gameCache,"DATAS","SETTINGS_OTHER_NEW_FRAME_MODE",Settings_OtherNewFrameMode)
            
            call TimerStart(saveFileT,0.3,false,function saveCampaignDatas)
        endfunction
        function saveCampaignFiles_Action takes nothing returns nothing
            if MAP_INDEX == 9999 then 
                return 
            endif 
            call save()
            call QuestMessageBJ(bj_FORCE_ALL_PLAYERS,bj_QUESTMESSAGE_ALWAYSHINT,"|cffffcc00存档完成！|r")
        endfunction
        //====================================================
        // endregion
        //====================================================

        globals
            string array frameText [5]
        endglobals

        globals
            unit spellCaster                        = null 
            unit spellTarget                        = null 
            item spellTargetItem                    = null 
            destructable SpellTargetDestructable    = null
            real spellTargetX           = 0
            real spellTargetY           = 0
            real spellCooldown          = 0
            integer spellCost           = 0
            integer castingSpell        = 0
            integer spellAbilityLevel   = 0

            unit damageSource           = null
            unit damageMaster           = null 
            unit damageTarget           = null
            unit damageMinionOwner      = null 
            real damageDamage           = 0
            real damageBonusDamage      = 0
            real damageBlockDamage      = 0
            real damageArmorK           = 0
            real damageMaxBlockRate     = 0
            real damageMaxArmorResit    = 0
            real damageMaxResitance     = 0
            real damageMaxEvadeChance   = 0 
            real eventBonusLeech        = 0
            boolean damageCanEvade      = true 
            boolean damageIsMelee       = false
            boolean damageIsExtra       = false 
            boolean damageIsAOE         = false 
            boolean damageIsDOT         = false 
            boolean damageIsCrush       = false 
            boolean damageTag_Cold      = false 
            boolean damageTag_Fire      = false 
            boolean damageTag_Shadow    = false 
            boolean damageTag_Divine    = false 
            boolean damageTag_Arcane    = false 
            boolean damageTag_Posion    = false 
            boolean damageTag_Lightning = false 
            boolean damageTag_Earth     = false 
            boolean damageTag_Attack    = false 
            boolean damageTag_Bleed     = false 
            boolean damageTag_Ignite    = false 
            boolean damageTag_Special   = false 
            damagetype damageDamageType 
            attacktype damageAttackType 
            weapontype damageWeaponType 
            real damageAddCrit          = 0
            real damageAddCritPower     = 0
            real damageAddAccuracy      = 0
            real damageAddArmorPenetration = 0
            real damageAddBonusDamage   = 1
            boolean damageIfEvade       = false 
            boolean damageIfCrit        = false 
            real damageCritChance       = 0
            real damageCritChanceFix    = 0
            integer damageExtraCritTime = 0
            real damageCritPower        = 0 
            real damageArmor            = 0 
            real damageResistance       = 0
            real damageBlock            = 0 
            real damageEvade            = 0 
            real damageAccuracy         = 0
            real damageArmorPenetration = 0 
            real damageFinalDamage      = 0 
            real damageCrushRate        = 0
            integer damageFlag          = 0

            unit healSource             = null
            unit healTarget             = null
            unit healMaster             = null 
            unit healMinionOwner        = null 
            real healHeal               = 0
            real healEffective          = 0
            real healOverdoze           = 0
            real healBonusHeal          = 0
            real healAddBonusHeal       = 1
            boolean healIsExtra         = false 
            boolean healIsAOE           = false 
            boolean healIsDOT           = false 
            real healAddCrit            = 0
            real healAddCritPower       = 0
            boolean healIfCrit          = false 
            real healCritChance         = 0
            integer healExtraCritTime   = 0
            real healCritPower          = 0 
            real healFinalHeal          = 0 
            integer healFlag            = 0

            projectile attackingMissile = 0

            unit itemTriggerUnit        = null 
            item itemTriggerItem        = null 
            unit itemEquipingUnit       = null 
            unit itemEquipingItem       = null 
        endglobals

        function globalUpdate takes nothing returns nothing
            local integer i = 0
            local integer p = 0
            if loadinggame then 
                set loadinggame = false 
                return 
            endif 
            set i = 0
            loop
                exitwhen i > 4 or bagFollowUnit != null 
                set bagFollowUnit = party[i]
                set i = i+1
            endloop
            loop 
                exitwhen i > 4
                if party[i] != null then 
                    call MultiboardDisplay(damageMeter,true)
                    if SHOW_PARTY_DATAS then 
                        call BlzFrameSetVisible(HeroStateIcon[i],true)
                    endif 
                    call BlzFrameSetTexture(HeroStateIcon[i],GetUnitIcon(party[i]),0,true)
                    call BlzFrameSetText(HeroName[i],"|cffffcc00"+heroName[GetHeroIndex(party[i])-1]+" - 等级：|r"+I2S(GetUnitLevel(party[i])))
                    set p = 0
                    loop
                        exitwhen p > 30
                        if STATE_ST_AMOUNT[p] > 0 then 
                            call BlzFrameSetText(HeroStateAmount[i*31+p],STATE_ST_AMOUNT[p].getAmountString(party[i]))
                        else 
                            call BlzFrameSetText(HeroStateAmount[i*31+p],"")
                        endif 
                        set p = p+1
                    endloop
                    call AddUnitLife(party[i],I2R(GLOBAL_UPDATE_PERIOD*unitGetAllBonusStateValue(party[i],STATE_LIFE_REGEN))/10000)
                    call AddUnitMana(party[i],I2R(GLOBAL_UPDATE_PERIOD*unitGetAllBonusStateValue(party[i],STATE_MANA_REGEN))/10000)
                    if inCombat(party[i]) == false then 
                        call AddUnitLife(party[i],I2R(GLOBAL_UPDATE_PERIOD)/100*GetUnitState(party[i],UNIT_STATE_MAX_LIFE)*0.01)
                        call AddUnitMana(party[i],I2R(GLOBAL_UPDATE_PERIOD)/100*GetUnitState(party[i],UNIT_STATE_MAX_MANA)*0.01)
                    endif 
                    if Settings_OtherCloseSearch then 
                        call UnitAddAbilityEx(party[i],'SINV')
                    else 
                        call UnitRemoveAbilityEx(party[i],'SINV')
                    endif 
                else
                    call BlzFrameSetVisible(HeroStateIcon[i],false)
                endif 
                set i = i+1
            endloop
            //call IssueImmediateOrderById(bag[currentBag],ORDER_cancel)
            call SetCameraQuickPosition(GetUnitX(party[0]),GetUnitY(party[0]))
            if GetUnitCurrentOrder(bag[currentBag]) == ORDER_move then 
                call IssueImmediateOrderById(bag[currentBag],ORDER_stop)
            endif 
            call SetUnitX(bag[currentBag],GetUnitX(bagFollowUnit)-16)
            call SetUnitY(bag[currentBag],GetUnitY(bagFollowUnit)-16)
            call SetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_FOOD_USED,TEAM_ITEM_FOUND_RATE/100)
            call SetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_FOOD_CAP,TEAM_XP_GAIN_RATE/100)
        endfunction

        function initItemDatas takes nothing returns nothing
        endfunction
        //#endregion

        function anyUnitEnterMapZone_Action takes nothing returns nothing
            if (IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) == false) then 
                call unitCheckState(GetTriggerUnit())
                ////////////call BJDebugMsg(GetUnitName(GetTriggerUnit()))
            endif 
        endfunction
        function initializeUnits_Action takes nothing returns boolean
            if (IsUnitType(GetFilterUnit(),UNIT_TYPE_ANCIENT) == false) then 
                if IsUnitEnemy(GetFilterUnit(),PLAYER) then 
                    call RegisterEnemy(GetFilterUnit())
                else
                    call unitCheckState(GetFilterUnit())
                endif 
            endif 
            return true
        endfunction

        //====================================================
        // region globalEvents
        //====================================================
        function openGameSight_Action takes nothing returns nothing
            call Cheat("iseedeadpeople")
        endfunction

        globals
            string array INV_TOOLTIP [8]
            string array INV_TOOLTIP_EXTENDED [8]
            string array INV_ICON [8]
        endglobals

        function AnyUnitEquipItem takes unit whichUnit,item whichItem returns nothing
            call GetEquipment(whichItem).equip(whichUnit)
            set whichUnit = null 
            set whichItem = null 
        endfunction

        function TEXTTAG_RESIZED takes nothing returns nothing
            local delayedevent de = delayedevent.currentEvent
            local integer change = de.loadInteger("CHANGE")
            local real size = de.loadReal("SIZE")
            local string text = de.loadString("TEXT")
            local integer time = de.loadInteger("TIME")
            local real x = I2R(time)
            if change == 0 then 
                set size = TextTagSize2Height(size)
                call SetTextTagText(de.loadTextTag("TEXTTAG"),text,size)
                set de.DESTROY = true 
                return 
            else 
                set size = size+9*(2*x/15-x*x/225)
                set size = TextTagSize2Height(size)
                call SetTextTagText(de.loadTextTag("TEXTTAG"),text,size)
                call de.saveInteger("TIME",time+1)
            endif 
        endfunction
        function TEXTTAG_REMOVE takes nothing returns nothing
            call DestroyTextTag(delayedevent.currentEvent.loadTextTag("TEXTTAG"))
        endfunction
        function damageNheal_textTagDisplay takes integer flag,unit whichUnit,real data,boolean isEvade,boolean isCrit returns nothing
            local delayedevent de
            local texttag tt = CreateTextTag()
            local real x = GetUnitX(whichUnit)+GetRandomReal(-15,15)
            local real y = GetUnitY(whichUnit)+GetRandomReal(-15,15)
            local real x_velocity = GetRandomReal(5,10)
            local real y_velocity = 90
            local string color = ""
            //////////call BJDebugMsg(I2S(flag))
            if flag == 1 then 
                set color = "|cff00ff00"
            elseif damageFlag == 'Aatk' then 
                set color = "|cffffffff"
                set x_velocity = 20
                set y_velocity = -30
            else 
                set color = "|cffffff00"
            endif
            set de = delayedevent.create(1,30,function TEXTTAG_RESIZED)
            call de.saveTextTag("TEXTTAG",tt)
            call SetTextTagPos(tt,x,y,0)
            if isEvade then 
                call de.saveString("TEXT","|cffff0000闪避|r")
                call de.saveReal("SIZE",9)
                call de.saveInteger("CHANGE",0)
                call de.saveInteger("TIME",0)
            elseif isCrit then 
                call de.saveString("TEXT",color+I2S(R2I(data+0.5))+"|r")
                call de.saveReal("SIZE",10)
                call de.saveInteger("CHANGE",1)
                call de.saveInteger("TIME",0)
            else 
                call de.saveString("TEXT",color+I2S(R2I(data+0.5))+"|r")
                call de.saveReal("SIZE",9)
                call de.saveInteger("CHANGE",0)
                call de.saveInteger("TIME",0)
            endif 
            call SetTextTagLifespan(tt,0.8)
            call SetTextTagPermanent(tt,false)
            call SetTextTagFadepoint(tt,0.5)
            call SetTextTagVelocity(tt,TextTagSpeed2Velocity(x_velocity),TextTagSpeed2Velocity(y_velocity))
            call SetTextTagVisibility(tt,true)
            set tt = null 
            set whichUnit = null 
        endfunction
        function damageNhealBlocked_textTagDisplay takes integer flag,unit whichUnit,real data returns nothing
            local delayedevent de
            local texttag tt = CreateTextTag()
            local real x = GetUnitX(whichUnit)+GetRandomReal(-15,15)
            local real y = GetUnitY(whichUnit)+GetRandomReal(-15,15)
            local real x_velocity = GetRandomReal(-10,-5)
            local real y_velocity = GetRandomReal(-20,-10)
            local string color = ""
            //////////call BJDebugMsg(I2S(flag))
            if flag == 0 then 
                set color = "|cff888888"
            elseif flag == 1 then 
                set color = "|cff332288"
            else 
                call DestroyTextTag(tt)
                set tt = null 
                return 
            endif 
            set de = delayedevent.create(1,30,function TEXTTAG_RESIZED)
            call de.saveTextTag("TEXTTAG",tt)
            call SetTextTagPos(tt,x,y,0)
            call de.saveString("TEXT",color+I2S(R2I(data+0.5))+"|r")
            call de.saveReal("SIZE",9)
            call de.saveInteger("CHANGE",0)
            call de.saveInteger("TIME",0)
            call SetTextTagLifespan(tt,0.8)
            call SetTextTagPermanent(tt,false)
            call SetTextTagFadepoint(tt,0.5)
            call SetTextTagVisibility(tt,true)
            call SetTextTagVelocity(tt,TextTagSpeed2Velocity(x_velocity),TextTagSpeed2Velocity(y_velocity))
            set tt = null 
            set whichUnit = null 
        endfunction

        function MissileLaunch takes nothing returns nothing
            local integer i = 0
            local integer k = 0
            local mybuff bf 
            local integer heroId = GetHeroIndex(projectile.currentProjectile.source)
            call ItemRecallFlush.execute()
            if heroId > 0 then
                call ExecuteFunc("HERO_"+I2S(heroId)+"_MISSILE_LAUNCH")
                set i = 0
                loop 
                    exitwhen i > 9
                    if GetEquipedItem(projectile.currentProjectile.source,i) > 0 then 
                        set eventEquipment = GetEquipedItem(projectile.currentProjectile.source,i)
                        call TriggerExecute(GetEquipedItem(projectile.currentProjectile.source,i).trigMissileLaunch)
                    endif 
                    if i < 4 then  
                        call ExecuteFunc("PUBLIC_TALENT_MISSILE_LAUNCH_"+I2S(GetHeroTypePublicTalent(heroId,GetHeroSelectedPublicTalent(projectile.currentProjectile.source,i))))
                        call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_MISSILE_LAUNCH_"+I2S(GetHeroSelectedPrivateTalent(projectile.currentProjectile.source,i)))
                    endif 
                    set i = i+1
                endloop
                call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_MISSILE_LAUNCH_"+I2S(GetHeroSelectedUltimateTalent(projectile.currentProjectile.source,0)))
                call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_MISSILE_LAUNCH_"+I2S(GetHeroSelectedUltimateTalent(projectile.currentProjectile.source,1)))
            else 
                call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(projectile.currentProjectile.source))+"_MISSILE_LAUNCH")
            endif 
            set k = mybuff.countUnitBuff(projectile.currentProjectile.source)
            if k > 0 then 
                set i = 1
                loop 
                    exitwhen i > k
                    set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(projectile.currentProjectile.source),i)
                    if bf.trigMissileLaunch != null then 
                        call TriggerExecute(bf.trigMissileLaunch)
                    endif 
                    set i = i+1
                endloop
            endif 
            call ItemRecallFlush.execute()
        endfunction
        function MissileHit takes nothing returns nothing
            local integer i = 0
            local integer k = 0
            local mybuff bf 
            local integer heroId = GetHeroIndex(projectile.currentProjectile.source)
            local integer heroId2 = GetHeroIndex(projectile.currentProjectile.target)
            call ItemRecallFlush.execute()
            if heroId > 0 then
                call ExecuteFunc("HERO_"+I2S(heroId)+"_MISSILE_HIT_SOURCE")
                set i = 0
                loop 
                    exitwhen i > 9
                    if GetEquipedItem(projectile.currentProjectile.source,i) > 0 then 
                        set eventEquipment = GetEquipedItem(projectile.currentProjectile.source,i)
                        call TriggerExecute(GetEquipedItem(projectile.currentProjectile.source,i).trigMissileHitSource)
                    endif   
                    if i < 4 then  
                        call ExecuteFunc("PUBLIC_TALENT_MISSILE_HIT_SOURCE_"+I2S(GetHeroTypePublicTalent(heroId,GetHeroSelectedPublicTalent(projectile.currentProjectile.source,i))))
                        call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_MISSILE_HIT_SOURCE_"+I2S(GetHeroSelectedPrivateTalent(projectile.currentProjectile.source,i)))
                    endif 
                    set i = i+1
                endloop
                call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_MISSILE_HIT_SOURCE_"+I2S(GetHeroSelectedUltimateTalent(projectile.currentProjectile.source,0)))
                call ExecuteFunc("HERO_"+I2S(heroId)+"_TALENT_MISSILE_HIT_SOURCE_"+I2S(GetHeroSelectedUltimateTalent(projectile.currentProjectile.source,1)))
            else
                call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(projectile.currentProjectile.source))+"_MISSILE_HIT_SOURCE")
            endif 
            if heroId2 > 0 then
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(projectile.currentProjectile.target))+"_MISSILE_HIT_TARGET")
                set i = 0
                loop 
                    exitwhen i > 9
                    if GetEquipedItem(projectile.currentProjectile.target,i) > 0 then 
                        set eventEquipment = GetEquipedItem(projectile.currentProjectile.target,i)
                        call TriggerExecute(GetEquipedItem(projectile.currentProjectile.target,i).trigMissileHitTarget)
                    endif   
                    if i < 4 then  
                        call ExecuteFunc("PUBLIC_TALENT_MISSILE_HIT_TARGET_"+I2S(GetHeroTypePublicTalent(heroId2,GetHeroSelectedPublicTalent(projectile.currentProjectile.target,i))))
                        call ExecuteFunc("HERO_"+I2S(heroId2)+"_TALENT_MISSILE_HIT_TARGET_"+I2S(GetHeroSelectedPrivateTalent(projectile.currentProjectile.target,i)))
                    endif 
                    set i = i+1
                endloop
                call ExecuteFunc("HERO_"+I2S(heroId2)+"_TALENT_MISSILE_HIT_TARGET_"+I2S(GetHeroSelectedUltimateTalent(projectile.currentProjectile.target,0)))
                call ExecuteFunc("HERO_"+I2S(heroId2)+"_TALENT_MISSILE_HIT_TARGET_"+I2S(GetHeroSelectedUltimateTalent(projectile.currentProjectile.target,1)))
            elseif GetUnitTypeId(projectile.currentProjectile.target) != 'hBNC' then 
                call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(projectile.currentProjectile.target))+"_MISSILE_HIT_TARGET")
            else 
                call ExecuteFunc("DUMMY_"+I2SSSS(GetUnitUserData(projectile.currentProjectile.target))+"_MISSILE_HIT_TARGET")
            endif
            set k = mybuff.countUnitBuff(damageSource)
            if k > 0 then 
                set i = 1
                loop 
                    exitwhen i > k
                    set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(damageSource),i)
                    if bf.trigMissileHitSource != null then 
                        call TriggerExecute(bf.trigMissileHitSource)
                    endif 
                    set i = i+1
                endloop
            endif 
            set k = mybuff.countUnitBuff(projectile.currentProjectile.target)
            if k > 0 then 
                set i = 1
                loop 
                    exitwhen i > k
                    set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(projectile.currentProjectile.target),i)
                    if bf.trigMissileHitTarget != null then 
                        call TriggerExecute(bf.trigMissileHitTarget)
                    endif 
                    set i = i+1
                endloop
            endif 
            call ItemRecallFlush.execute()
        endfunction
        
        function EventBlockDamage takes unit damager,unit masterUnit,unit sourceUnit,unit targetUnit,real amount,integer flag returns nothing
            if inCombat(sourceUnit) and IsUnitEnemy(damager,GetOwningPlayer(targetUnit)) and GetPartyIndex(sourceUnit) > -1 then 
                set healTotal[GetPartyIndex(sourceUnit)] = healTotal[GetPartyIndex(sourceUnit)]+amount
            endif
            if amount > 0.005 and COMBAT_LOG_ON and IsUnitType(targetUnit,UNIT_TYPE_ANCIENT) == false then 
                if GetOwningPlayer(sourceUnit) == PLAYER or GetOwningPlayer(targetUnit) == PLAYER or GetOwningPlayer(damager) == PLAYER then
                    call Preload("L|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(sourceUnit))+"|"+I2S(GetHandleId(sourceUnit)-1050000)+"|"+R2S(amount)+"|"+I2SSSS(GetUnitTypeId(targetUnit))+"|"+I2S(GetHandleId(targetUnit)-1050000)+"|"+I2SSSS(flag))
                endif 
            endif 
            set damager = null 
            set masterUnit = null 
            set sourceUnit = null 
            set targetUnit = null 
        endfunction
        function Leech takes unit whichUnit,real amount,integer flag returns nothing
            local integer LEECH = unitGetAllBonusStateValue(whichUnit,STATE_LEECH)
            local real leech = eventBonusLeech+I2R(LEECH)/10000
            local real heal = amount*leech
            local real effHeal = RMinBJ(heal,GetUnitState(whichUnit,UNIT_STATE_MAX_LIFE)-GetUnitState(whichUnit,UNIT_STATE_LIFE))
            local real overHeal = heal-effHeal
            if effHeal < 0.05 then 
                set whichUnit = null 
                return 
            endif 
            call AddUnitLife(whichUnit,effHeal)
            if COMBAT_LOG_ON and IsUnitType(damageTarget,UNIT_TYPE_ANCIENT) == false and GetOwningPlayer(whichUnit) == PLAYER then 
                call Preload("E|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(whichUnit))+"|"+I2S(GetHandleId(whichUnit)-1050000)+"|"+R2S(effHeal)+"|"+R2S(overHeal)+"|"+I2SSSS(flag))
            endif 
            set eventBonusLeech = 0
            set whichUnit = null 
        endfunction
        function DamageBlock takes nothing returns nothing
            local integer i = 0
            local integer k = mybuff.countUnitBuff(damageTarget)
            local mybuff bf 
            local real blockAmount = 0
            if k > 0 then 
                set i = 1
                loop 
                    exitwhen i > k
                    set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(damageTarget),i)
                    set blockAmount = 0
                    set blockAmount = RMinBJ(bf.shieldNowValue,bf.shieldBlockPercent*damageFinalDamage)
                    set damageBlockDamage = damageBlockDamage+blockAmount
                    set damageFinalDamage = damageFinalDamage-blockAmount
                    set bf.shieldNowValue = bf.shieldNowValue-blockAmount
                    if bf.shieldNowValue < 0.5 and bf.shieldDestroy then 
                        set bf.DESTROY = true 
                    endif 
                    call EventBlockDamage(damageSource,damageMaster,bf.buffSource,damageTarget,blockAmount,bf.type.abilityId)
                    /*
                    if inCombat(bf.buffSource) and IsUnitEnemy(damageMaster,GetOwningPlayer(damageTarget)) and GetPartyIndex(bf.buffSource) > -1 then 
                        set damageTotal[GetPartyIndex(bf.buffSource)] = damageTotal[GetPartyIndex(bf.buffSource)]+blockAmount
                    endif
                    if blockAmount > 0.005 and COMBAT_LOG_ON and IsUnitType(damageTarget,UNIT_TYPE_ANCIENT) == false then 
                        if GetOwningPlayer(damageSource) == PLAYER or GetOwningPlayer(damageTarget) == PLAYER or GetOwningPlayer(damageMaster) == PLAYER then
                            call Preload("L|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(bf.buffSource))+"|"+I2S(GetHandleId(bf.buffSource)-1050000)+"|"+R2S(blockAmount)+"|"+I2SSSS(GetUnitTypeId(damageTarget))+"|"+I2S(GetHandleId(damageTarget)-1050000)+"|"+I2SSSS(bf.type.abilityId))
                        endif 
                    endif 
                    */
                    set i = i+1
                endloop
            endif 
        endfunction

        //! textmacro DAMAGE_CALLBACK_FUNCTION takes NAME,UBERNAME
            function $NAME$ takes nothing returns nothing
                local integer i = 0
                local integer k = 0
                local mybuff bf 
                if GetHeroIndex(damageMaster) > 0 then
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageMaster))+"_$UBERNAME$_SOURCE")
                    set i = 0
                    loop 
                        exitwhen i > 9
                        if GetEquipedItem(damageMaster,i) > 0 then 
                            set eventEquipment = GetEquipedItem(damageMaster,i)
                            call TriggerExecute(GetEquipedItem(damageMaster,i).trig$NAME$Source)
                        endif 
                        if i < 4 then 
                            call ExecuteFunc("PUBLIC_TALENT_$UBERNAME$_SOURCE_"+I2S(GetHeroTypePublicTalent(GetHeroIndex(damageMaster),GetHeroSelectedPublicTalent(damageMaster,i))))
                            call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageMaster))+"_TALENT_$UBERNAME$_SOURCE_"+I2S(GetHeroSelectedPrivateTalent(damageMaster,i)))
                        endif 
                        set i = i+1
                    endloop
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageMaster))+"_TALENT_$UBERNAME$_SOURCE_"+I2S(GetHeroSelectedUltimateTalent(damageMaster,0)))
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageMaster))+"_TALENT_$UBERNAME$_SOURCE_"+I2S(GetHeroSelectedUltimateTalent(damageMaster,1)))
                else
                    call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(damageMaster))+"_$UBERNAME$_SOURCE")
                endif 
                if GetHeroIndex(damageTarget) > 0 then
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageTarget))+"_$UBERNAME$_TARGET")
                    set i = 0
                    loop 
                        exitwhen i > 9
                        if GetEquipedItem(damageTarget,i) > 0 then 
                            set eventEquipment = GetEquipedItem(damageTarget,i)
                            call TriggerExecute(GetEquipedItem(damageTarget,i).trig$NAME$Target)
                        endif 
                        if i < 4 then 
                            call ExecuteFunc("PUBLIC_TALENT_$UBERNAME$_TARGET_"+I2S(GetHeroTypePublicTalent(GetHeroIndex(damageTarget),GetHeroSelectedPublicTalent(damageTarget,i))))
                            call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageTarget))+"_TALENT_$UBERNAME$_TARGET_"+I2S(GetHeroSelectedPrivateTalent(damageTarget,i)))
                        endif 
                        set i = i+1
                    endloop
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageTarget))+"_TALENT_$UBERNAME$_TARGET_"+I2S(GetHeroSelectedUltimateTalent(damageTarget,0)))
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageTarget))+"_TALENT_$UBERNAME$_TARGET_"+I2S(GetHeroSelectedUltimateTalent(damageTarget,1)))
                else
                    call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(damageTarget))+"_$UBERNAME$_TARGET")
                endif
                set k = mybuff.countUnitBuff(damageMaster)
                if k > 0 then 
                    set i = 1
                    loop 
                        exitwhen i > k
                        set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(damageMaster),i)
                        set mybuff.currentBuff = bf 
                        if bf.trig$NAME$Source != null then 
                            call TriggerExecute(bf.trig$NAME$Source)
                        endif 
                        set i = i+1
                    endloop
                endif 
                set k = mybuff.countUnitBuff(damageTarget)
                if k > 0 then 
                    set i = 1
                    loop 
                        exitwhen i > k
                        set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(damageTarget),i)
                        set mybuff.currentBuff = bf 
                        if bf.trig$NAME$Target != null then 
                            call TriggerExecute(bf.trig$NAME$Target)
                        endif 
                        set i = i+1
                    endloop
                endif 
            endfunction
        //! endtextmacro

        //! runtextmacro DAMAGE_CALLBACK_FUNCTION("Damaged","DAMAGED")
        //! runtextmacro DAMAGE_CALLBACK_FUNCTION("Damaging","DAMAGING")
        //! runtextmacro DAMAGE_CALLBACK_FUNCTION("Predamage","PREDAMAGE")
        //! runtextmacro DAMAGE_CALLBACK_FUNCTION("Beforedamage","BEFOREDAMAGE")
        //! runtextmacro DAMAGE_CALLBACK_FUNCTION("Afterdamage","AFTERDAMAGE")

        function Attacked takes nothing returns nothing
            local integer i = 0
            local integer k = 0
            local mybuff bf 
            if GetHeroIndex(damageSource) > 0 then
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageSource))+"_ATTACKED_SOURCE")
                set i = 0
                loop 
                    exitwhen i > 9
                    if GetEquipedItem(damageSource,i) > 0 then 
                        set eventEquipment = GetEquipedItem(damageSource,i)
                        call TriggerExecute(GetEquipedItem(damageSource,i).trigAttackedSource)
                    endif 
                    if i < 4 then 
                        call ExecuteFunc("PUBLIC_TALENT_ATTACKED_SOURCE_"+I2S(GetHeroTypePublicTalent(GetHeroIndex(damageSource),GetHeroSelectedPublicTalent(damageSource,i))))
                        call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageSource))+"_TALENT_ATTACKED_SOURCE_"+I2S(GetHeroSelectedPrivateTalent(damageSource,i)))
                    endif 
                    set i = i+1
                endloop
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageSource))+"_TALENT_ATTACKED_SOURCE_"+I2S(GetHeroSelectedUltimateTalent(damageSource,0)))
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageSource))+"_TALENT_ATTACKED_SOURCE_"+I2S(GetHeroSelectedUltimateTalent(damageSource,1)))
            else
                call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(damageSource))+"_ATTACKED_SOURCE")
            endif 
            if GetHeroIndex(damageTarget) > 0 then
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageTarget))+"_ATTACKED_TARGET")
                set i = 0
                loop 
                    exitwhen i > 9
                    if GetEquipedItem(damageTarget,i) > 0 then 
                        set eventEquipment = GetEquipedItem(damageTarget,i)
                        call TriggerExecute(GetEquipedItem(damageTarget,i).trigAttackedTarget)
                    endif 
                    if i < 4 then 
                        call ExecuteFunc("PUBLIC_TALENT_ATTACKED_TARGET"+I2S(GetHeroTypePublicTalent(GetHeroIndex(damageTarget),GetHeroSelectedPublicTalent(damageTarget,i))))
                        call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageTarget))+"_TALENT_ATTACKED_TARGET_"+I2S(GetHeroSelectedPrivateTalent(damageTarget,i)))
                    endif 
                    set i = i+1
                endloop
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageTarget))+"_TALENT_ATTACKED_TARGET_"+I2S(GetHeroSelectedUltimateTalent(damageTarget,0)))
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageTarget))+"_TALENT_ATTACKED_TARGET_"+I2S(GetHeroSelectedUltimateTalent(damageTarget,1)))
            else
                call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(damageTarget))+"_ATTACKED_TARGET")
            endif 
            set k = mybuff.countUnitBuff(damageSource)
            if k > 0 then 
                set i = 1
                loop 
                    exitwhen i > k
                    set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(damageSource),i)
                    set mybuff.currentBuff = bf 
                    if bf.trigAttackedSource != null then 
                        call TriggerExecute(bf.trigAttackedSource)
                    endif 
                    set i = i+1
                endloop
            endif 
            set k = mybuff.countUnitBuff(damageTarget)
            if k > 0 then 
                set i = 1
                loop 
                    exitwhen i > k
                    set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(damageTarget),i)
                    set mybuff.currentBuff = bf 
                    if bf.trigAttackedTarget != null then 
                        call TriggerExecute(bf.trigAttackedTarget)
                    endif 
                    set i = i+1
                endloop
            endif 
        endfunction

        function AttackMissileHit takes nothing returns nothing
            local integer attackType = BlzGetUnitWeaponIntegerField(projectile.currentProjectile.source,UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE,0)
            call projectile.currentProjectile.applyDamageSet()
            set damageTag_Attack = true 
            set damageFlag = 'Aatk'
            ////////////call BJDebugMsg("攻击投射物命中")
            call UnitDamageTarget(projectile.currentProjectile.source,projectile.currentProjectile.target,I2R(GetUnitAttack(projectile.currentProjectile.source,0)),true,true,ConvertAttackType(attackType),DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
        endfunction
        function Attacking takes boolean isMelee returns nothing
            local integer i = 0
            local integer k = 0
            local integer heroId = GetHeroIndex(damageSource)-1
            local mybuff bf 
            //////call BJDebugMsg("|cff0000ffAttack|r")
            set attackingMissile = 0
            if not isMelee then 
                set attackingMissile = projectile.create(damageSource)
                //////call BJDebugMsg("|cff0000ffAttack Missile|r"+I2S(attackingMissile))
                set attackingMissile.target = damageTarget
                set attackingMissile.LAUNCH_UNIT = true
                set attackingMissile.TARGET_UNIT = true 
                set attackingMissile.model_path = heroNowForm[heroId].attackMissilePath
                set attackingMissile.speed = heroNowForm[heroId].attackMissileSpeed
                set attackingMissile.curve = heroNowForm[heroId].attackMissileArc
                call attackingMissile.addOnHit(function AttackMissileHit)
                set attackingMissile.flag = 'Aatk'
            else 
                //////call BJDebugMsg("ATTACK MELEE")
            endif 
            if GetHeroIndex(damageSource) > 0 then
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageSource))+"_ATTACKING")
                set i = 0
                loop 
                    exitwhen i > 9
                    if GetEquipedItem(damageSource,i) > 0 then 
                        set eventEquipment = GetEquipedItem(damageSource,i)
                        call TriggerExecute(GetEquipedItem(damageSource,i).trigAttacking)
                    endif 
                    if i < 4 then 
                        call ExecuteFunc("PUBLIC_TALENT_ATTACKING_"+I2S(GetHeroTypePublicTalent(GetHeroIndex(damageSource),GetHeroSelectedPublicTalent(damageSource,i))))
                        call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageSource))+"_TALENT_ATTACKING_"+I2S(GetHeroSelectedPrivateTalent(damageSource,i)))
                    endif 
                    set i = i+1
                endloop
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageSource))+"_TALENT_ATTACKING_"+I2S(GetHeroSelectedUltimateTalent(damageSource,0)))
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(damageSource))+"_TALENT_ATTACKING_"+I2S(GetHeroSelectedUltimateTalent(damageSource,1)))
            else 
                call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(damageSource))+"_ATTACKING")
            endif 
            set k = mybuff.countUnitBuff(damageSource)
            if k > 0 then 
                set i = 1
                loop 
                    exitwhen i > k
                    set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(damageSource),i)
                    set mybuff.currentBuff = bf 
                    if bf.trigAttacking != null then 
                        call TriggerExecute(bf.trigAttacking)
                    endif 
                    set i = i+1
                endloop
            endif 
            if attackingMissile != 0 then 
                call attackingMissile.launch()
            endif 
            set attackingMissile = 0
            if master.getMasterByUnit(damageSource) > 0 and IsUnitEnemy(damageTarget,GetOwningPlayer(damageSource)) then 
                set master.getMasterByUnit(damageSource).lastTarget = damageTarget
            endif 
            if minion.getMinionByUnit(damageSource) > 0 and IsUnitEnemy(damageTarget,GetOwningPlayer(damageSource)) then 
                set minion.getMinionByUnit(damageSource).currentTarget = damageTarget
            endif 
        endfunction

        function GetDamageTags takes nothing returns string
            local string result = ""  
            if damageIfCrit then 
                set result = result+"c"
            endif 
            if damageTag_Attack then 
                set result = result+"n"
            endif 
            if damageIfEvade then 
                set result = result+"e"
            endif 
            if damageIsAOE then 
                set result = result+"a"
            endif 
            if damageIsDOT then 
                set result = result+"d"
            endif 
            if damageIsExtra then 
                set result = result+"x"
            endif 
            if damageIsCrush then 
                set result = result+"u"
            endif 
            if damageTag_Ignite then 
                set result = result+"i"
            endif 
            if damageTag_Bleed then 
                set result = result+"b"
            endif 
            if damageTag_Posion then 
                set result = result+"t"
            endif 
            if damageTag_Arcane then 
                set result = result+"r"
            endif 
            if damageTag_Fire then 
                set result = result+"f"
            endif 
            if damageTag_Cold then 
                set result = result+"o"
            endif 
            if damageTag_Lightning then 
                set result = result+"l"
            endif 
            if damageTag_Shadow then 
                set result = result+"s"
            endif 
            if damageTag_Earth then 
                set result = result+"m"
            endif 
            if damageTag_Divine then 
                set result = result+"h"
            endif 
            return result
        endfunction
        function anyUnitDamaging_Action takes nothing returns nothing
            local boolean showTextTag       = true 
            local real damageArmorResistRate      = 0
            local real a = 0
            local real b = 0
            local real c = 0
            local real finalCrit = 0
            local integer sourceLevel
            local integer targetLevel 
            local real targetVersatility

            if GetEventDamage() <= 0 then 
                return
            endif 

            call ItemRecallFlush.execute()
            set damageIfCrit                = false
            set damageIfEvade               = false 
            set damageIsCrush               = false 
            set damageCanEvade              = true 
            set damageCritChance            = 0
            set damageCritPower             = 0
            set damageCritChanceFix         = 1
            set damageExtraCritTime         = 0
            set damageArmor                 = 0
            set damageArmorK                = 0
            set damageBlockDamage           = 0
            
            set damageResistance            = 0
            set damageBlock                 = 0
            set damageEvade                 = 0
            set damageAccuracy              = 0
            set damageArmorPenetration      = 0
            set damageFinalDamage           = 0
            set damageBonusDamage           = 0
            set damageMaxBlockRate          = MAX_BLOCK+I2R(ST_MAX_BLOCK.getTotalState(damageTarget))/10000
            set damageMaxEvadeChance        = MAX_EVADE+I2R(ST_MAX_EVADE.getTotalState(damageTarget))/10000
            set damageMaxArmorResit         = MAX_ARMOR_RESISTANCE+I2R(ST_MAX_ARMOR.getTotalState(damageTarget))/10000
            set damageMaxResitance          = MAX_RESISTANCE+I2R(ST_MAX_RESISTANCE.getTotalState(damageTarget))/10000

            set damageSource = GetEventDamageSource()
            if minion.getMinionByUnit(damageSource) > 0 then
                set damageMaster = minion.getMinionByUnit(damageSource).mast.masterUnit
            else 
                set damageMaster = damageSource
            endif 
            set sourceLevel = UnitLevel(damageSource)
            set targetLevel = UnitLevel(damageTarget)
            
            set damageArmorK = sourceLevel*5+25

            if IsUnitType(damageSource,UNIT_TYPE_SUMMONED) == false then 
                set damageMinionOwner = null 
            else 
                set damageMinionOwner = LoadUnitHandle(globalHashtable,GetHandleId(damageSource),MINION_OWNER)
            endif 
            set damageTarget        = BlzGetEventDamageTarget()
            set damageAttackType    = BlzGetEventAttackType()
            set damageDamageType    = BlzGetEventDamageType()
            set damageWeaponType    = BlzGetEventWeaponType()
            set damageDamage        = GetEventDamage()

            if BlzGetEventIsAttack() then
                if IsUnitType(damageSource,UNIT_TYPE_HERO) and damageTag_Attack == false then
                    if damageWeaponType == WEAPON_TYPE_WHOKNOWS then 
                        call BlzSetEventDamage(0)

                        ////////////call BJDebugMsg("远程射弹")

                        call Attacking.evaluate(false)

                        if IsUnitEnemy(damageTarget,GetOwningPlayer(damageSource)) then 
                            call setCombat(damageSource)
                            call setCombat(damageMaster)
                            call setCombat(damageTarget)
                        endif 

                        set damageSource        = null
                        set damageMaster        = null 
                        set damageMinionOwner   = null
                        set damageTarget        = null
                        set damageAttackType    = ATTACK_TYPE_CHAOS
                        set damageDamageType    = DAMAGE_TYPE_UNKNOWN
                        set damageWeaponType    = WEAPON_TYPE_WHOKNOWS
                        set damageDamage        = 0
                        set damageBlockDamage   = 0
                        set damageAddCrit       = 0
                        set damageAddCritPower  = 0
                        set damageFlag          = 0
                        set damageCrushRate     = 0
                        set damageMaxBlockRate  = 0
                        set eventBonusLeech    = 0
                        set damageExtraCritTime = 0
                        set damageIfCrit        = false
                        set damageIfEvade       = false 
                        set damageIsMelee       = false
                        set damageIsExtra       = false 
                        set damageIsAOE         = false 
                        set damageIsDOT         = false 
                        set damageIsCrush       = false 
                        set damageTag_Cold      = false 
                        set damageTag_Fire      = false 
                        set damageTag_Shadow    = false 
                        set damageTag_Divine    = false 
                        set damageTag_Arcane    = false 
                        set damageTag_Posion    = false 
                        set damageTag_Lightning = false 
                        set damageTag_Earth     = false 
                        set damageTag_Attack    = false 
                        set damageTag_Ignite    = false 
                        set damageTag_Bleed     = false 
                        set damageTag_Special   = false
                        set damageAddAccuracy = 0
                        set damageAddArmorPenetration = 0
                        set damageAddBonusDamage = 1
                        call ItemRecallFlush.execute()
                        return 
                    else
                        set damageFlag = 'Aatk'
                        set damageTag_Attack = true 
                        set damageIsMelee = true 
                        call Attacking.evaluate(true)
                    endif
                else 
                    set damageFlag = 'Aatk'
                    set damageTag_Attack = true 
                    if damageWeaponType != WEAPON_TYPE_WHOKNOWS then
                        set damageIsMelee = true 
                    endif 
                    call Attacking.evaluate(true)
                endif 
            endif 

            set damageBonusDamage = I2R(unitGetAllBonusStateValue(damageMaster,STATE_DAMAGE_BONUS))/10000
            set targetVersatility = I2R(unitGetAllBonusStateValue(damageTarget,STATE_VERSATILITY))/10000
            set damageArmor = BlzGetUnitArmor(damageTarget)
            set damageResistance = I2R(unitGetAllBonusStateValue(damageTarget,STATE_RESISTANCE))/10000
            if GetOwningPlayer(damageSource) == PLAYER then
                set damageCritChance          = I2R(unitGetAllBonusStateValue(damageMaster,STATE_CRIT))/10000
                set damageCritPower           = I2R(unitGetAllBonusStateValue(damageMaster,STATE_CRIT_POWER))/10000
                set damageArmorPenetration    = I2R(unitGetAllBonusStateValue(damageMaster,STATE_ARMOR_PENETRATION))
            endif 
            if GetOwningPlayer(damageTarget) == PLAYER then
                set damageBlock               = I2R(unitGetAllBonusStateValue(damageTarget,STATE_BLOCK))
            endif 
            set damageEvade                 = I2R(unitGetAllBonusStateValue(damageTarget,STATE_EVADE))/10000
            set damageAccuracy            = I2R(unitGetAllBonusStateValue(damageMaster,STATE_ACCURACY))/10000

            if damageTag_Special == false then 
                call Beforedamage.execute()
            endif 

            set damageFinalDamage = damageDamage

            if damageTag_Special == false then 
                call Predamage.execute()
            endif 

            set damageArmor = RMaxBJ(0,damageArmor-damageArmorPenetration-damageAddArmorPenetration)

            if damageTag_Special == false then 
                if damageTag_Attack then 
                    if damageCanEvade and random.get(damageTarget,RMinBJ(damageMaxEvadeChance,damageEvade)-damageAccuracy-damageAddAccuracy,'AEev') then 
                        set damageIfEvade = true 
                        set damageFinalDamage = 0
                    else    
                        set damageFinalDamage = RMaxBJ(damageFinalDamage*(1-damageMaxBlockRate),damageFinalDamage-damageBlock)
                        if GetOwningPlayer(damageTarget) == PLAYER and GetOwningPlayer(damageSource) != PLAYER then 
                            set a = damageFinalDamage/100
                            set a = a*a
                            set b = (GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE)+2*damageBlock)/100
                            set b = b*b
                            set c = 0.5*I2R(targetLevel*targetLevel)
                            set damageCrushRate = damageCrushRate+a/(2*a+2*b+c)
                        endif 
                        call Attacked.execute()
                    endif 
                endif 
            endif 

            if damageTag_Special == false then 
                if (damageDamageType == DAMAGE_TYPE_NORMAL) then
                    if GetRandomReal(0,1) < damageCrushRate then    //碾压
                        set damageArmorResistRate = RMinBJ(damageMaxArmorResit,0.5*damageArmor/(damageArmor+damageArmorK))
                        set damageIsCrush = true 
                    else
                        set damageArmorResistRate = RMinBJ(damageMaxArmorResit,damageArmor/(damageArmor+damageArmorK))
                    endif 
                    set damageFinalDamage = damageFinalDamage*(1-damageArmorResistRate)
                endif 
                if (damageAttackType == ATTACK_TYPE_NORMAL) then 
                    set damageFinalDamage = damageFinalDamage*RMinBJ(1,1-RMinBJ(damageMaxResitance,damageResistance))
                endif 

                if IsUnitType(damageTarget,UNIT_TYPE_SUMMONED) and GetOwningPlayer(damageTarget) == PLAYER and damageIsAOE then 
                    set damageFinalDamage = damageFinalDamage*0.05
                endif 
            endif 

            if damageTag_Special == false then 
                call Damaging.execute()
            endif 

            
            if damageTag_Special == false then 
                set damageCritChance = RMinBJ(1,damageCritChance+damageAddCrit)*damageCritChanceFix
                set finalCrit = damageCritChance
                loop
                    exitwhen damageExtraCritTime <= 0 or finalCrit >= 1
                    set finalCrit = finalCrit+(1-finalCrit)*damageCritChance
                    set damageExtraCritTime = damageExtraCritTime-1
                endloop
                if IsUnitEnemy(damageTarget,PLAYER) and random.get(damageSource,finalCrit,damageFlag) then 
                    if damageIfEvade == false then 
                        set damageIfCrit = true 
                        set damageFinalDamage = damageFinalDamage*(1+damageCritPower+damageAddCritPower)
                    endif
                endif 

                if IsUnitEnemy(damageTarget,GetOwningPlayer(damageMaster)) == true then 
                    set damageFinalDamage = damageFinalDamage*(1+damageBonusDamage)*damageAddBonusDamage
                endif 
                if damageTarget != damageSource then 
                    set damageFinalDamage = damageFinalDamage/(1+targetVersatility)
                endif 
            endif 
            /*
            if damageAddBonusDamage > 1 then 
                //////call BJDebugMsg("DAMAGE×"+R2S(damageAddBonusDamage))
            endif */

            if damageTag_Special == false then 
                call DamageBlock.execute()

                call Damaged.execute()
            endif 

            call BlzSetEventDamage(damageFinalDamage)

            if damageTag_Special == false then 
                call Afterdamage.execute()
            endif 

            if (damageIfEvade or damageFinalDamage > 0) and IsUnitEnemy(damageTarget,PLAYER) and GetOwningPlayer(damageSource) == PLAYER then 
                if Settings_FloatDamage == false then 
                    set showTextTag = false 
                endif 
                if Settings_FloatNoCrit and damageIfCrit == false then 
                    set showTextTag = false 
                endif 
                if Settings_FloatDot == false and damageIsDOT then 
                    set showTextTag = false 
                endif 
                if Settings_FloatMinionDamage == false and damageSource != damageMaster then 
                    set showTextTag = false 
                endif 
                if showTextTag then 
                    call damageNheal_textTagDisplay(0,damageTarget,damageFinalDamage,damageIfEvade,damageIfCrit)
                endif 
                ////call BJDebugMsg("DAMAGETAG_"+GetUnitName(damageSource)+"_TO_"+GetUnitName(damageTarget)+"_D_"+R2S(damageFinalDamage))
            endif 

            if damageBlockDamage > 0 then 
                call damageNhealBlocked_textTagDisplay(0,damageTarget,damageBlockDamage)
            endif 

            if IsUnitEnemy(damageTarget,GetOwningPlayer(damageSource)) then 
                call setCombat(damageSource)
                call setCombat(damageMaster)
                call setCombat(damageTarget)
            endif 

            if IsUnitEnemy(damageTarget,GetOwningPlayer(damageMaster)) and GetPartyIndex(damageMaster) > -1 and inCombat(damageMaster) then 
                set damageTotal[GetPartyIndex(damageMaster)] = damageTotal[GetPartyIndex(damageMaster)]+damageFinalDamage
            endif

            if COMBAT_LOG_ON and IsUnitType(damageTarget,UNIT_TYPE_ANCIENT) == false then 
                if GetOwningPlayer(damageSource) == PLAYER or GetOwningPlayer(damageTarget) == PLAYER or GetOwningPlayer(damageMaster) == PLAYER then
                    call Preload("D|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(damageMaster))+"|"+I2S(GetHandleId(damageMaster)-1050000)+"|"+I2SSSS(GetUnitTypeId(damageSource))+"|"+I2S(GetHandleId(damageSource)-1050000)+"|"+R2S(damageFinalDamage)+"|"+R2S(damageBlockDamage)+"|"+I2SSSS(GetUnitTypeId(damageTarget))+"|"+I2S(GetHandleId(damageTarget)-1050000)+"|"+I2SSSS(damageFlag)+"|"+GetDamageTags())
                    call Preload("P|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(damageTarget))+"|"+I2S(GetHandleId(damageTarget)-1050000)+"|"+R2S(GetUnitState(damageTarget,UNIT_STATE_LIFE)-damageFinalDamage)+"|"+R2S(GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE)))
                endif 
            endif 
            
            if damageTag_Special == false then 
                if damageSource != damageTarget then 
                    call Leech(damageSource,damageFinalDamage,damageFlag)
                endif 
            endif 
            if damageIfEvade then 
                call BlzSetEventWeaponType(WEAPON_TYPE_WHOKNOWS)
            endif 

            set damageSource        = null
            set damageMaster        = null 
            set damageMinionOwner   = null
            set damageTarget        = null
            set damageAttackType    = ATTACK_TYPE_CHAOS
            set damageDamageType    = DAMAGE_TYPE_UNKNOWN
            set damageWeaponType    = WEAPON_TYPE_WHOKNOWS
            set damageDamage        = 0
            set damageBlockDamage   = 0
            set damageAddCrit       = 0
            set damageAddCritPower  = 0
            set damageFlag          = 0
            set damageCrushRate     = 0
            set damageMaxBlockRate  = 0
            set eventBonusLeech    = 0
            set damageExtraCritTime = 0
            set damageIfCrit        = false
            set damageIfEvade       = false 
            set damageIsMelee       = false
            set damageIsExtra       = false 
            set damageIsAOE         = false 
            set damageIsDOT         = false 
            set damageIsCrush       = false 
            set damageTag_Cold      = false 
            set damageTag_Fire      = false 
            set damageTag_Shadow    = false 
            set damageTag_Divine    = false 
            set damageTag_Arcane    = false 
            set damageTag_Posion    = false 
            set damageTag_Lightning = false 
            set damageTag_Earth     = false 
            set damageTag_Attack    = false 
            set damageTag_Ignite    = false 
            set damageTag_Bleed     = false 
            set damageTag_Special   = false
            set damageAddAccuracy = 0
            set damageAddArmorPenetration = 0
            set damageAddBonusDamage = 1
            call ItemRecallFlush.execute()
        endfunction
        function anyUnitDamaged_Action takes nothing returns nothing
            ////////////call BJDebugMsg(R2S(GetEventDamage()))
        endfunction


        //! textmacro HEAL_CALLBACK_FUNCTION takes NAME,UBERNAME
            function $NAME$ takes nothing returns nothing
                local integer i = 0
                local integer k = 0
                local mybuff bf 
                if GetHeroIndex(healMaster) > 0 then
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(healMaster))+"_$UBERNAME$_SOURCE")
                    set i = 0
                    loop 
                        exitwhen i > 9
                        if GetEquipedItem(healMaster,i) > 0 then 
                            set eventEquipment = GetEquipedItem(healMaster,i)
                            call TriggerExecute(GetEquipedItem(healMaster,i).trig$NAME$Source)
                        endif 
                        if i < 4 then 
                            call ExecuteFunc("PUBLIC_TALENT_$UBERNAME$_SOURCE_"+I2S(GetHeroTypePublicTalent(GetHeroIndex(healMaster),GetHeroSelectedPublicTalent(healMaster,i))))
                            call ExecuteFunc("HERO_"+I2S(GetHeroIndex(healMaster))+"_TALENT_$UBERNAME$_SOURCE_"+I2S(GetHeroSelectedPrivateTalent(healMaster,i)))
                        endif 
                        set i = i+1
                    endloop
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(healMaster))+"_TALENT_$UBERNAME$_SOURCE_"+I2S(GetHeroSelectedUltimateTalent(healMaster,0)))
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(healMaster))+"_TALENT_$UBERNAME$_SOURCE_"+I2S(GetHeroSelectedUltimateTalent(healMaster,1)))
                else
                    call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(healMaster))+"_$UBERNAME$_SOURCE")
                endif 
                if GetHeroIndex(healTarget) > 0 then
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(healTarget))+"_$UBERNAME$_TARGET")
                    set i = 0
                    loop 
                        exitwhen i > 9
                        if GetEquipedItem(healTarget,i) > 0 then 
                            set eventEquipment = GetEquipedItem(healTarget,i)
                            call TriggerExecute(GetEquipedItem(healTarget,i).trig$NAME$Target)
                        endif 
                        if i < 4 then 
                            call ExecuteFunc("PUBLIC_TALENT_$UBERNAME$_TARGET_"+I2S(GetHeroTypePublicTalent(GetHeroIndex(healTarget),GetHeroSelectedPublicTalent(healTarget,i))))
                            call ExecuteFunc("HERO_"+I2S(GetHeroIndex(healTarget))+"_TALENT_$UBERNAME$_TARGET_"+I2S(GetHeroSelectedPrivateTalent(healTarget,i)))
                        endif 
                        set i = i+1
                    endloop
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(healTarget))+"_TALENT_$UBERNAME$_TARGET_"+I2S(GetHeroSelectedUltimateTalent(healTarget,0)))
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(healTarget))+"_TALENT_$UBERNAME$_TARGET_"+I2S(GetHeroSelectedUltimateTalent(healTarget,1)))
                else
                    call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(healTarget))+"_$UBERNAME$_TARGET")
                endif
                set k = mybuff.countUnitBuff(healMaster)
                if k > 0 then 
                    set i = 1
                    loop 
                        exitwhen i > k
                        set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(healMaster),i)
                        set mybuff.currentBuff = bf 
                        if bf.trig$NAME$Source != null then 
                            call TriggerExecute(bf.trig$NAME$Source)
                        endif 
                        set i = i+1
                    endloop
                endif 
                set k = mybuff.countUnitBuff(healTarget)
                if k > 0 then 
                    set i = 1
                    loop 
                        exitwhen i > k
                        set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(healTarget),i)
                        set mybuff.currentBuff = bf 
                        if bf.trig$NAME$Target != null then 
                            call TriggerExecute(bf.trig$NAME$Target)
                        endif 
                        set i = i+1
                    endloop
                endif 
            endfunction
        //! endtextmacro

        //! runtextmacro HEAL_CALLBACK_FUNCTION("Healed","HEALED")
        //! runtextmacro HEAL_CALLBACK_FUNCTION("Healing","HEALING")
        //! runtextmacro HEAL_CALLBACK_FUNCTION("PreHeal","PREHEAL")
        //! runtextmacro HEAL_CALLBACK_FUNCTION("Beforeheal","BEFOREHEAL")
        //! runtextmacro HEAL_CALLBACK_FUNCTION("Afterheal","AFTERHEAL")

        function GetHealTags takes nothing returns string
            local string result = ""  
            if healIfCrit then 
                set result = result+"c"
            endif 
            if healIsAOE then 
                set result = result+"a"
            endif 
            if healIsDOT then 
                set result = result+"d"
            endif 
            if healIsExtra then 
                set result = result+"x"
            endif 
            return result
        endfunction
        function UnitHealTarget takes unit whichUnit,unit target,real amount returns nothing
            local boolean showTextTag = true 
            local real finalCrit    = 0
            call ItemRecallFlush.execute()
            set healSource = whichUnit
            if minion.getMinionByUnit(healSource) > 0 then 
                set healMaster = minion.getMinionByUnit(healSource).mast.masterUnit
            else 
                set healMaster = healSource
            endif 
            set healTarget = target
            if IsUnitType(healSource,UNIT_TYPE_SUMMONED) == false then 
                set healMinionOwner = null 
            else 
                set healMinionOwner = LoadUnitHandle(globalHashtable,GetHandleId(healSource),MINION_OWNER)
            endif 
            set healHeal = amount
            set healOverdoze = 0
            set healEffective = 0
            set healBonusHeal = 0
            set healIfCrit = false

            call Beforeheal.execute()

            set healFinalHeal = healHeal
            
            set healBonusHeal = I2R(unitGetAllBonusStateValue(healMaster,STATE_HEAL_BONUS))/10000
            if GetOwningPlayer(healMaster) == PLAYER then
                set healCritChance          = I2R(unitGetAllBonusStateValue(healMaster,STATE_CRIT))/10000
                set healCritPower           = I2R(unitGetAllBonusStateValue(healMaster,STATE_CRIT_POWER))/10000
            endif 
            call PreHeal.execute()

            call Healing.execute()

            set finalCrit = healCritChance+healAddCrit
            loop
                exitwhen healExtraCritTime <= 0
                set finalCrit = finalCrit+(1-finalCrit)*finalCrit
                set healExtraCritTime = healExtraCritTime-1
            endloop
            if random.get(healSource,finalCrit,healFlag) then 
                set healIfCrit = true 
                set healFinalHeal = healFinalHeal*(1+healCritPower+healAddCritPower)
            endif 

            call Healed.execute()
            
            set healFinalHeal = healFinalHeal*(1+healBonusHeal)*healAddBonusHeal
            set healOverdoze = RMaxBJ(0,healFinalHeal-(GetUnitState(healTarget,UNIT_STATE_MAX_LIFE)-GetUnitState(healTarget,UNIT_STATE_LIFE)))
            set healEffective = healFinalHeal-healOverdoze

            call AddUnitLife(healTarget,healFinalHeal)

            call Afterheal.execute()

            if healFinalHeal > 0 and IsUnitAlly(healTarget,PLAYER) and GetOwningPlayer(healSource) == PLAYER and minion.getMinionByUnit(healTarget) == 0 then 
                if Settings_FloatHeal == false then 
                    set showTextTag = false 
                endif 
                if Settings_FloatNoCrit and healIfCrit == false then 
                    set showTextTag = false 
                endif 
                if Settings_FloatHot == false and healIsDOT then 
                    set showTextTag = false 
                endif 
                if Settings_FloatMinionHeal == false and healSource != healMaster then 
                    set showTextTag = false 
                endif 
                if showTextTag then 
                    call damageNheal_textTagDisplay(1,healTarget,healFinalHeal,false,healIfCrit)
                endif 
            endif 

            call setCombatTime(healSource,IMaxBJ(getCombatTime(healSource),getCombatTime(healTarget)))
            call setCombatTime(healMaster,IMaxBJ(getCombatTime(healMaster),getCombatTime(healTarget)))
            call setCombatTime(healTarget,IMaxBJ(IMaxBJ(getCombatTime(healSource),getCombatTime(healMaster)),getCombatTime(healTarget)))

            if IsUnitAlly(healTarget,GetOwningPlayer(healMaster)) and GetPartyIndex(healMaster) > -1 and inCombat(healMaster) then 
                set healTotal[GetPartyIndex(healMaster)] = healTotal[GetPartyIndex(healMaster)]+healEffective
                set healOverdozeTotal[GetPartyIndex(healMaster)] = healOverdozeTotal[GetPartyIndex(healMaster)]+healOverdoze
            endif

            if COMBAT_LOG_ON and IsUnitType(damageTarget,UNIT_TYPE_ANCIENT) == false then 
                if GetOwningPlayer(healSource) == PLAYER or GetOwningPlayer(healTarget) == PLAYER or GetOwningPlayer(healMaster) == PLAYER or (inCombat(healMaster) and inCombat(healTarget)) then
                    call Preload("H|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(healMaster))+"|"+I2S(GetHandleId(healMaster)-1050000)+"|"+I2SSSS(GetUnitTypeId(healSource))+"|"+I2S(GetHandleId(healSource)-1050000)+"|"+R2S(healEffective)+"|"+R2S(healOverdoze)+"|"+I2SSSS(GetUnitTypeId(healTarget))+"|"+I2S(GetHandleId(healTarget)-1050000)+"|"+I2SSSS(healFlag)+"|"+GetHealTags())
                    call Preload("P|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(healTarget))+"|"+I2S(GetHandleId(healTarget)-1050000)+"|"+R2S(GetUnitState(healTarget,UNIT_STATE_LIFE))+"|"+R2S(GetUnitState(healTarget,UNIT_STATE_MAX_LIFE)))
                endif 
            endif 
            if healSource != healTarget then 
                call Leech(healSource,healFinalHeal,healFlag)
            endif 

            set healSource          = null 
            set healTarget          = null 
            set healMaster          = null 
            set healMinionOwner     = null 
            set healHeal            = 0
            set healOverdoze        = 0
            set healEffective       = 0
            set eventBonusLeech     = 0
            set healExtraCritTime   = 0
            set healIsExtra         = false 
            set healIsAOE           = false 
            set healIsDOT           = false 
            set healAddCrit         = 0
            set healAddCritPower    = 0
            set healIfCrit          = false 
            set healCritChance      = 0
            set healCritPower       = 0 
            set healFinalHeal       = 0 
            set healFlag            = 0
            set healAddBonusHeal    = 1

            set whichUnit = null 
            set target = null 
            call ItemRecallFlush.execute()
        endfunction

        globals
            item eventStackItem  = null
            unit eventStackUnit  = null  
            item eventPickedItem = null 
            unit eventPickUnit   = null 
            boolean stackSuccess = false 
        endglobals
        function StackItem takes nothing returns nothing
            local integer i = 0
            local integer k = 0
            local boolean unique = true 
            local integer itemId
            local integer charges
            local integer maxStack
            local integer currentCharges
            local integer canAdd
            local item    slotItem

            if eventStackItem == null or eventStackUnit == null then 
                return 
            endif 

            set stackSuccess = false 
            set itemId   = GetItemTypeId(eventStackItem)
            set charges  = GetItemCharges(eventStackItem)
            set maxStack = GetItemStackLimit(itemId)  // 从哈希表获取上限，未注册为0（无限制）
            
            set i = 0
            loop
                exitwhen i > 5
                set slotItem = UnitItemInSlot(eventStackUnit, i)
                if slotItem != eventStackItem and GetItemTypeId(slotItem) == itemId then
                    set currentCharges = GetItemCharges(slotItem)
                    
                    if maxStack == 0 then
                        // 无上限：直接全部叠加
                        call SetItemCharges(slotItem, currentCharges + charges)
                        call RemoveItem(eventStackItem)
                        set slotItem = null 
                        return  // 完全叠加完成，退出函数
                    else
                        // 有上限：计算能叠加多少
                        if currentCharges < maxStack then
                            set canAdd = maxStack - currentCharges
                            if canAdd >= charges then
                                // 可以全部叠加
                                call SetItemCharges(slotItem, currentCharges + charges)
                                call RemoveItem(eventStackItem)
                                set stackSuccess = true 
                                set slotItem = null 
                                return
                            else
                                // 只能叠加部分
                                call SetItemCharges(slotItem, maxStack)
                                set charges = charges - canAdd
                                // charges 还有剩余，继续尝试下一个槽位
                            endif
                        endif
                    endif
                endif
                set i = i + 1
            endloop
            call SetItemCharges(eventStackItem, charges)
            // 如果循环结束还有 charges > 0，说明无法再叠加，新物品保留（成为新的一组）
            set slotItem = null 
        endfunction
        function PickItemHint takes nothing returns nothing
            local integer i = 0
            local integer iii = 0
            local integer k = 0
            local boolean added = false 
            call DestroyTimer(GetExpiredTimer())
            if eventPickedItem == null or GetWidgetLife(eventPickedItem) < 0.5 or eventPickUnit == null then 
                return 
            endif 
            if GetUnitAbilityLevel(eventPickUnit,'ABAG') > 0 and BlzGetItemBooleanField(eventPickedItem,ITEM_BF_USE_AUTOMATICALLY_WHEN_ACQUIRED) then 
                call SetItemUserData(eventPickedItem,0)
                call DisplayErrorMsg("|cffffcc00该单位不能拾取这件物品。|r")
                return 
            endif 
            if UnitHasItem(eventPickUnit,eventPickedItem) == false and UnitHasItem(bag[0],eventPickedItem) == false and UnitHasItem(bag[1],eventPickedItem) == false and UnitHasItem(bag[2],eventPickedItem) == false and UnitHasItem(bag[3],eventPickedItem) == false and UnitHasItem(bag[4],eventPickedItem) == false and UnitHasItem(bag[5],eventPickedItem) == false and UnitHasItem(bag[6],eventPickedItem) == false and UnitHasItem(bag[7],eventPickedItem) == false then
                if GetPartyIndex(eventPickUnit) > -1 then 
                    set added = false 
                    set i = 0
                    loop
                        exitwhen i > 7
                        if GetItemType(eventPickedItem) == ITEM_TYPE_CHARGED and GetItemCharges(eventPickedItem) > 0 then 
                            set eventStackItem = eventPickedItem
                            set eventStackUnit = bag[ModuloInteger(i+currentBag,8)]
                            call StackItem()
                        else 
                            set stackSuccess = false 
                        endif
                        if stackSuccess then 
                            return 
                        endif 
                        set i = i+1
                    endloop
                    set i = 0
                    loop 
                        exitwhen i > 7 or added
                        set k = 0 
                        loop 
                            exitwhen k > 5
                            if UnitItemInSlot(bag[ModuloInteger(i+currentBag,8)],k) == null then 
                                call UnitAddItem(bag[ModuloInteger(i+currentBag,8)],eventPickedItem)
                                set added = true 
                                exitwhen true 
                            endif 
                            set k = k+1
                        endloop
                        set i = i+1
                    endloop
                endif 
                if added == false then 
                    call SetItemUserData(eventPickedItem,0)
                    call DisplayErrorMsg("|cffffcc00物品栏已满。|r")
                endif 
            endif
        endfunction
        function anyUnitReadyToCastSpell_Action takes nothing returns nothing
            local integer charges = 0
            local Equipment eq = 0
            local integer typeId = 0
            local real x = 0
            local real y = 0

            if IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) and GetUnitTypeId(GetTriggerUnit()) != 'hBAG' and GetUnitTypeId(GetTriggerUnit()) != 'hAVT' then 
                return 
            endif 

            call DisableTrigger(GetTriggeringTrigger())
            //call BJDebugMsg(GetUnitName(GetTriggerUnit())+"_READY_TO_CAST_"+I2SSSS(GetSpellAbilityId())+"_TO_"+GetUnitName(GetSpellTargetUnit()))
            set spellCaster             = GetTriggerUnit()
            set spellTarget             = GetSpellTargetUnit()
            set spellTargetItem         = GetSpellTargetItem()
            set SpellTargetDestructable = GetSpellTargetDestructable()
            set spellTargetX            = GetSpellTargetX()
            set spellTargetY            = GetSpellTargetY()
            set castingSpell            = GetSpellAbilityId()
            set spellAbilityLevel       = GetUnitAbilityLevel(spellCaster,castingSpell)
            
            call ExecuteFunc("SPELL_READY_"+I2SSSS(castingSpell))
            call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(spellCaster))+"_SPELL_READY")
            
            if SubString(GetAbilityName(castingSpell),0,5) == "learn" and globalNowtime-LastLearnTime > 10 then
                call Learn.evaluate(spellCaster,castingSpell)
                set LastLearnTime = globalNowtime
            endif

            if castingSpell == 'APIC' then 
                set eventPickedItem = spellTargetItem
                set eventPickUnit = spellCaster
                
                call BlzUnitForceStopOrder(eventPickUnit,false)
                if GetItemUserData(eventPickedItem) == 0 then 
                    call SetItemUserData(eventPickedItem,1)
                    if BlzGetItemBooleanField(eventPickedItem,ITEM_BF_USE_AUTOMATICALLY_WHEN_ACQUIRED) == false then 
                        set charges = GetItemCharges(eventPickedItem)
                        set eq = GetEquipment(eventPickedItem)
                        set typeId = GetItemTypeId(eventPickedItem)
                        set x = GetWidgetX(eventPickedItem)
                        set y = GetWidgetY(eventPickedItem)
                        call delayedRemoveItem(eventPickedItem,2)
                        set eventPickedItem = CreateItemEx(typeId,x,y)
                        call SetItemCharges(eventPickedItem,charges)
                        if eq > 0 then 
                            call eq.bindOnItem(eventPickedItem)
                        endif 
                    endif 
                    if GetItemCharges(eventPickedItem) > 0 and GetItemType(eventPickedItem) == ITEM_TYPE_CHARGED then 
                        set eventStackUnit = eventPickUnit
                        set eventStackItem = eventPickedItem
                        call StackItem()
                    else 
                        set stackSuccess = false 
                    endif 
                    if stackSuccess == false then 
                        call UnitAddItem(eventPickUnit,eventPickedItem)
                        call TimerStart(CreateTimer(),0,false,function PickItemHint)
                    endif 
                endif 
            endif 
            call EnableTrigger(GetTriggeringTrigger())
        endfunction

        function Cast takes nothing returns nothing
            local integer i = 0
            local integer k = 0
            local mybuff bf 
            call ItemRecallFlush.execute()
            call ExecuteFunc("SPELL_"+I2SSSS(castingSpell))
            if castingSpell-'S000' >= 0 then 
                if GetHeroIndex(spellCaster) > 0 then
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(spellCaster))+"_SPELLING")
                    set i = 0
                    loop 
                        exitwhen i > 9
                        if GetEquipedItem(spellCaster,i) > 0 then 
                            set eventEquipment = GetEquipedItem(spellCaster,i)
                            call TriggerExecute(GetEquipedItem(spellCaster,i).trigSpelling)
                        endif 
                        if i < 4 then 
                            call ExecuteFunc("PUBLIC_TALENT_SPELLING_"+I2S(GetHeroTypePublicTalent(GetHeroIndex(spellCaster),GetHeroSelectedPublicTalent(spellCaster,i))))
                            call ExecuteFunc("HERO_"+I2S(GetHeroIndex(spellCaster))+"_TALENT_SPELLING_"+I2S(GetHeroSelectedPrivateTalent(spellCaster,i)))
                        endif 
                        set i = i+1
                    endloop
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(spellCaster))+"_TALENT_SPELLING_"+I2S(GetHeroSelectedUltimateTalent(spellCaster,0)))
                    call ExecuteFunc("HERO_"+I2S(GetHeroIndex(spellCaster))+"_TALENT_SPELLING_"+I2S(GetHeroSelectedUltimateTalent(spellCaster,1)))
                else
                    call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(spellCaster))+"_SPELLING")
                endif 
            endif 
            if castingSpell-'S000' >= 0 or (castingSpell-'AP00' >= 0 and castingSpell-'AP9Z' < 0) or (castingSpell-'ABC0' >= 0 and castingSpell-'AC00' < 0) or (castingSpell-'AA00' >= 0 and castingSpell-'AAZZ' < 0) then 
                set k = mybuff.countUnitBuff(spellCaster)
                if k > 0 then 
                    set i = 1
                    loop 
                        exitwhen i > k
                        set bf = LoadInteger(mybuff.buffHashtable,GetHandleId(spellCaster),i)
                        set mybuff.currentBuff = bf 
                        if bf.trigSpelling != null then 
                            call TriggerExecute(bf.trigSpelling)
                        endif 
                        set i = i+1
                    endloop
                endif 
                if COMBAT_LOG_ON and IsUnitType(spellCaster,UNIT_TYPE_ANCIENT) == false then 
                    call Preload("C|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(spellCaster))+"|"+I2S(GetHandleId(spellCaster)-1050000)+"|"+I2SSSS(castingSpell))
                endif 
            endif 
            call ItemRecallFlush.execute()
        endfunction
        function anyUnitCastSpell_Action takes nothing returns nothing
            //call BJDebugMsg(GetUnitName(GetTriggerUnit())+"_CASTING_"+I2SSSS(GetSpellAbilityId())+"_TO_"+GetUnitName(GetSpellTargetUnit()))
            if IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) and GetUnitTypeId(GetTriggerUnit()) != 'hBAG' and GetUnitTypeId(GetTriggerUnit()) != 'hAVT' then 
                return 
            endif 
            call DisableTrigger(GetTriggeringTrigger())
            set spellCaster             = GetTriggerUnit()
            set spellTarget             = GetSpellTargetUnit()
            set spellTargetItem         = GetSpellTargetItem()
            set SpellTargetDestructable = GetSpellTargetDestructable()
            set spellTargetX            = GetSpellTargetX()
            set spellTargetY            = GetSpellTargetY()
            set castingSpell            = GetSpellAbilityId()
            set spellAbilityLevel       = GetUnitAbilityLevel(spellCaster,castingSpell)
            set spellCooldown           = BlzGetUnitAbilityCooldown(spellCaster,castingSpell,spellAbilityLevel-1)
            set spellCost               = BlzGetUnitAbilityManaCost(spellCaster,castingSpell,spellAbilityLevel-1)

            if SubString(GetAbilityName(castingSpell),0,5) != "learn" then
                call Cast.execute()
            endif 
            call EnableTrigger(GetTriggeringTrigger())
        endfunction
        function anyUnitStopCastSpell_Action takes nothing returns nothing
            //call BJDebugMsg(GetUnitName(GetTriggerUnit())+"_STOP_CAST_"+I2SSSS(GetSpellAbilityId())+"_TO_"+GetUnitName(GetSpellTargetUnit()))
            if IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) then 
                return 
            endif 
            call DisableTrigger(GetTriggeringTrigger())
            set spellCaster             = GetTriggerUnit()
            set spellTarget             = GetSpellTargetUnit()
            set spellTargetItem         = GetSpellTargetItem()
            set SpellTargetDestructable = GetSpellTargetDestructable()
            set spellTargetX            = GetSpellTargetX()
            set spellTargetY            = GetSpellTargetY()
            set castingSpell            = GetSpellAbilityId()
            set spellAbilityLevel       = GetUnitAbilityLevel(spellCaster,castingSpell)

            call ExecuteFunc("SPELL_STOP_"+I2SSSS(castingSpell))
            call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(spellCaster))+"_SPELL_STOP")
            call EnableTrigger(GetTriggeringTrigger())
        endfunction
        function anyUnitCastSpellEnd_Action takes nothing returns nothing
            //call BJDebugMsg(GetUnitName(GetTriggerUnit())+"_CAST_END_"+I2SSSS(GetSpellAbilityId())+"_TO_"+GetUnitName(GetSpellTargetUnit()))
            if IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) then 
                return 
            endif 
            call DisableTrigger(GetTriggeringTrigger())
            set spellCaster             = GetTriggerUnit()
            set spellTarget             = GetSpellTargetUnit()
            set spellTargetItem         = GetSpellTargetItem()
            set SpellTargetDestructable = GetSpellTargetDestructable()
            set spellTargetX            = GetSpellTargetX()
            set spellTargetY            = GetSpellTargetY()
            set castingSpell            = GetSpellAbilityId()
            set spellAbilityLevel       = GetUnitAbilityLevel(spellCaster,castingSpell)

            call ExecuteFunc("SPELL_END_"+I2SSSS(castingSpell))
            call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(spellCaster))+"_SPELL_END")
            call EnableTrigger(GetTriggeringTrigger())
        endfunction
        function anyUnitUseItem_Action takes nothing returns nothing
            set itemTriggerUnit = GetTriggerUnit()
            set itemTriggerItem = GetManipulatedItem()
            ////////call BJDebugMsg(GetUnitName(itemTriggerUnit)+" :使用事件: "+GetItemName(itemTriggerItem))
            if GetEquipment(itemTriggerItem) > 0 then
                call AnyUnitEquipItem(itemTriggerUnit,itemTriggerItem)
            else
                ////////call BJDebugMsg(GetUnitName(itemTriggerUnit)+" :使用可充: "+GetItemName(itemTriggerItem))
                call ExecuteFunc("ITEM_"+I2SSSS(GetItemTypeId(itemTriggerItem))+"_USE")
            endif
        endfunction
        function anyUnitPickItem_Action takes nothing returns nothing
            local integer i = 0
            local integer k = 0
            local boolean unique = true 
            local integer itemId
            local integer charges
            local integer maxStack
            local integer currentCharges
            local integer canAdd
            local item    slotItem
            
            set itemTriggerUnit = GetTriggerUnit()
            set itemTriggerItem = GetManipulatedItem()
            call ExecuteFunc("ITEM_PICK_"+I2SSSS(GetItemTypeId(itemTriggerItem)))
            //call BJDebugMsg(GetUnitName(itemTriggerUnit)+" :拾取事件: "+GetItemName(itemTriggerItem))
            if GetItemTypeId(itemTriggerItem) == 'IREA' then 
                call Retrain.evaluate(itemTriggerUnit)
            endif
            
            // 优化后的消耗品叠加逻辑
            if GetItemType(itemTriggerItem) == ITEM_TYPE_CHARGED and GetItemCharges(itemTriggerItem) > 0 then 
                set eventStackItem = itemTriggerItem
                set eventStackUnit = itemTriggerUnit
                call StackItem()
            endif

            
            if BlzGetItemBooleanField(eventPickedItem,ITEM_BF_USE_AUTOMATICALLY_WHEN_ACQUIRED) then 
                call delayedRemoveItem(itemTriggerItem,400)
            endif 
        endfunction

        function anyUnitDropItem_Action takes nothing returns nothing
            set itemTriggerUnit = GetTriggerUnit()
            set itemTriggerItem = GetManipulatedItem()
            call SetItemUserData(itemTriggerItem,0)
        endfunction
        function anyUnitDeath_Action takes nothing returns nothing
            local unit owner 
            local integer i = 0
            local integer k = 0
            local integer j = 0
            local unit tempUU = currentTTOwner
            set eventDyingUnit = GetTriggerUnit()
            set owner = GetMinionOwnerUnitByUnit(eventDyingUnit)
            call GroupAddUnit(deathUnits,eventDyingUnit)
            if owner != null and GetHeroIndex(owner) > 0 then 
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(owner))+"_MINION_DEATH")
            endif 
            if GetHeroIndex(owner) > 0 then 
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(owner))+"_DEATH")
            endif 
            call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(eventDyingUnit))+"_DEATH")
            if master.getMasterByUnit(GetTriggerUnit()) > 0 then 
                call master.getMasterByUnit(GetTriggerUnit()).destroy()
            endif 
            if minion.getMinionByUnit(GetTriggerUnit()) > 0 then 
                call minion.getMinionByUnit(GetTriggerUnit()).destroy()
            endif 
            if COMBAT_LOG_ON and IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) == false then 
                call Preload("K|"+I2S(globalNowtime-TIME_LOG_START)+"|"+I2SSSS(GetUnitTypeId(GetTriggerUnit()))+"|"+I2S(GetHandleId(GetTriggerUnit())-1050000))
            endif 
            if GetHeroIndex(GetTriggerUnit()) != 0 then 
                set currentTTOwner = GetTriggerUnit()
                set j = GetHeroIndex(GetTriggerUnit())
                loop 
                    exitwhen i > 3
                    set k = GetHeroTypePublicTalent(j,GetHeroSelectedPublicTalent(GetTriggerUnit(),i))
                    call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_RESET_"+I2S(GetHeroSelectedPrivateTalent(GetTriggerUnit(),i)))
                    call ExecuteFunc("PUBLIC_TALENT_RESET_"+I2S(k))
                    set i = i+1
                endloop
                call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_RESET_"+I2S(GetHeroSelectedUltimateTalent(GetTriggerUnit(),0)))
                call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_RESET_"+I2S(GetHeroSelectedUltimateTalent(GetTriggerUnit(),1)))
                set currentTTOwner = null 
            endif 
            if IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) == false then 
                call FlushChildHashtable(globalHashtable,GetHandleId(GetTriggerUnit()))
                call FlushChildHashtable(stateHash,GetHandleId(GetTriggerUnit()))
                call FlushChildHashtable(mybuff.buffHashtable,GetHandleId(GetTriggerUnit()))
                call delayedRemoveUnit(GetTriggerUnit(),3000)
            endif 
            set currentTTOwner = tempUU
            set tempUU = null 
            set owner = null 
            set eventDyingUnit = null 
        endfunction
        function triggerHeroLevelUp_Action takes nothing returns nothing
            local integer i = GetHeroIndex(GetTriggerUnit())
            if GetHeroIndex(GetTriggerUnit()) != 0 then 
                call CheckHeroLearnBook.evaluate(hero[i-1])
                if GetTriggerUnit() == currentTTOwner then 
                    call TTUpdate.execute()
                endif 
            endif 
            call unitCheckState.evaluate(GetTriggerUnit())
        endfunction
        function triggerHeroRevive_Action takes nothing returns nothing
            local integer i = 0
            local itemaura ia = 0
            local integer k = 0
            local integer j = 0
            local unit tempUU = currentTTOwner
            call unitCheckState.evaluate(GetRevivingUnit())
            call GroupRemoveUnit(deathUnits,GetRevivingUnit())
            if GetHeroIndex(GetRevivingUnit()) == 0 then 
                set tempUU = null 
                return 
            endif 
            set i = 0
            set j = GetHeroIndex(GetRevivingUnit())
            set currentTTOwner = GetRevivingUnit()
            loop 
                exitwhen i > 3
                set k = GetHeroTypePublicTalent(j,GetHeroSelectedPublicTalent(GetRevivingUnit(),i))
                call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_LEARN_"+I2S(GetHeroSelectedPrivateTalent(GetRevivingUnit(),i)))
                call ExecuteFunc("PUBLIC_TALENT_LEARN_"+I2S(k))
                set i = i+1
            endloop
            call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_LEARN_"+I2S(GetHeroSelectedUltimateTalent(GetRevivingUnit(),0)))
            call ExecuteFunc("HERO_"+I2S(j)+"_TALENT_LEARN_"+I2S(GetHeroSelectedUltimateTalent(GetRevivingUnit(),1)))
            set currentTTOwner = tempUU
            set tempUU = null 
        endfunction
        function DELAYED_ATTACK_ORDER takes nothing returns nothing
            local delayedevent de = delayedevent.currentEvent
            call IssueTargetOrderById(de.loadUnit("ATTACKER"),ORDER_attack,de.loadUnit("TARGET"))
        endfunction

        function GetUnitTaunter takes unit whichUnit returns unit 
            local mybuff bf = mybuff.getUnitBuff(whichUnit,BUFFTYPE_TAUNT)
            if bf == 0 then 
                return null 
            endif 
            set whichUnit = null 
            return bf.buffSource
        endfunction

        globals
            unit eventAttacker = null 
            unit eventAttackedUnit = null 
        endglobals
        function anyUnitAttacking_Action takes nothing returns nothing
            local mybuff bf = mybuff.getUnitBuff(GetAttacker(),BUFFTYPE_TAUNT)
            local integer Q = 0
            set eventAttacker = GetAttacker()
            set eventAttackedUnit = GetTriggerUnit()
            if IsUnitType(GetAttacker(),UNIT_TYPE_ANCIENT) then 
                return 
            endif 
            if bf != 0 then 
                if GetTriggerUnit() != bf.buffSource and alive(bf.buffSource) and bf.buffSource != null and DisByUnits(bf.buffSource,GetAttacker()) < 900 then 
                    call IssueTargetOrderById(GetAttacker(),ORDER_attack,bf.buffSource)
                endif 
            endif 
            if master.getMasterByUnit(GetAttacker()) > 0 and IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker())) then 
                set master.getMasterByUnit(GetAttacker()).lastTarget = GetTriggerUnit()
            endif 
            if minion.getMinionByUnit(GetAttacker()) > 0 and IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker())) then 
                set minion.getMinionByUnit(GetAttacker()).currentTarget = GetTriggerUnit()
            endif 
            
            if GetHeroIndex(GetAttacker()) > 0 then
                call ExecuteFunc("HERO_"+I2S(GetHeroIndex(GetAttacker()))+"_PRE_ATTACK")
            else
                call ExecuteFunc("UNIT_"+I2SSSS(GetUnitTypeId(GetAttacker()))+"_PRE_ATTACK")
            endif 
            
            set eventAttacker = null 
            set eventAttackedUnit = null 
        endfunction
        function tauntedUnitAimTarget_Action takes nothing returns nothing
            local mybuff bf = mybuff.getUnitBuff(GetTriggerUnit(),BUFFTYPE_TAUNT)
            local delayedevent de
            if IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) then 
                return 
            endif 
            if bf != 0 then 
                if GetEventTargetUnit() != bf.buffSource and alive(bf.buffSource) and bf.buffSource != null and DisByUnits(bf.buffSource,GetTriggerUnit()) < 900 then 
                    set de = delayedevent.create(5,1,function DELAYED_ATTACK_ORDER)
                    call de.saveUnit("ATTACKER",GetTriggerUnit())
                    call de.saveUnit("TARGET",bf.buffSource)
                endif 
            endif 
        endfunction
        function CheckPosition takes unit whichUnit returns boolean
            local boolean result = false 
            local mybuff bf = mybuff.getUnitBuff(whichUnit,BUFFTYPE_TAUNT)
            if bf != 0 then 
                call IssueTargetOrderById(whichUnit,ORDER_attack,bf.buffSource)
                set result = true 
            else 
                call IssuePointOrderById(whichUnit,ORDER_attack,GetUnitX(whichUnit),GetUnitY(whichUnit))
            endif 
            set whichUnit = null 
            return result
        endfunction
        globals
            private timer bagCancelOrder = CreateTimer()
        endglobals
        private function bagCancelOrder_Action takes nothing returns nothing
            call IssueImmediateOrderById(bag[0],ORDER_stop)
            call IssueImmediateOrderById(bag[1],ORDER_stop)
            call IssueImmediateOrderById(bag[2],ORDER_stop)
            call IssueImmediateOrderById(bag[3],ORDER_stop)
            call IssueImmediateOrderById(bag[4],ORDER_stop)
            call IssueImmediateOrderById(bag[5],ORDER_stop)
            call IssueImmediateOrderById(bag[6],ORDER_stop)
            call IssueImmediateOrderById(bag[7],ORDER_stop)
        endfunction
        function anyUnitIssueTargetOrder_Action takes nothing returns nothing
            local integer order = GetIssuedOrderId()
            local mybuff bf = mybuff.getUnitBuff(GetTriggerUnit(),BUFFTYPE_TAUNT)
            local delayedevent de
            local integer whichSlot
            local integer iii = IMaxBJ(0,GetPartyIndex(bagFollowUnit))
            local integer i = 0
            local integer k = 0
            local boolean added = false 
            if GetIssuedOrderId() == ORDER_moveslot1 or GetIssuedOrderId() == ORDER_moveslot2 or GetIssuedOrderId() == ORDER_moveslot3 or GetIssuedOrderId() == ORDER_moveslot4 or GetIssuedOrderId() == ORDER_moveslot5 or GetIssuedOrderId() == ORDER_moveslot6 then 
                //call BJDebugMsg(I2S(GetIssuedOrderId()))
                set whichSlot = GetIssuedOrderId()-852002
                if UnitItemInSlot(GetTriggerUnit(),whichSlot) == GetOrderTargetItem() then 
                    if GetUnitTypeId(GetTriggerUnit()) == 'hBAG' then 
                        set added = false 
                        set i = 0
                        loop 
                            exitwhen i > 4 or added
                            if GetItemType(GetOrderTargetItem()) == ITEM_TYPE_CHARGED and GetItemCharges(GetOrderTargetItem()) > 0 then 
                                set eventStackItem = GetOrderTargetItem()
                                set eventStackUnit = party[ModuloInteger(i+iii,5)]
                                call StackItem()
                            else 
                                set stackSuccess = false 
                            endif
                            if stackSuccess then  
                                return 
                            endif 
                            if party[ModuloInteger(i+iii,5)] != null and alive(party[ModuloInteger(i+iii,5)]) then 
                                set k = 0 
                                loop 
                                    exitwhen k > 5
                                    if UnitItemInSlot(party[ModuloInteger(i+iii,5)],k) == null then 
                                        call UnitAddItem(party[ModuloInteger(i+iii,5)],GetOrderTargetItem())
                                        set added = true 
                                        exitwhen true 
                                    endif 
                                    set k = k+1
                                endloop
                            endif 
                            set i = i+1
                        endloop
                    else 
                        set added = false 
                        set i = 0
                        loop
                            exitwhen i > 7
                            if GetItemType(GetOrderTargetItem()) == ITEM_TYPE_CHARGED and GetItemCharges(GetOrderTargetItem()) > 0 then 
                                set eventStackItem = GetOrderTargetItem()
                                set eventStackUnit = bag[ModuloInteger(i+currentBag,8)]
                                call StackItem()
                            else 
                                set stackSuccess = false 
                            endif
                            if stackSuccess then 
                                return 
                            endif 
                            set i = i+1
                        endloop
                        set i = 0
                        loop 
                            exitwhen i > 7 or added
                            set k = 0 
                            loop 
                                exitwhen k > 5
                                if UnitItemInSlot(bag[ModuloInteger(i+currentBag,8)],k) == null then 
                                    call UnitAddItem(bag[ModuloInteger(i+currentBag,8)],GetOrderTargetItem())
                                    set added = true 
                                    exitwhen true 
                                endif 
                                set k = k+1
                            endloop
                            set i = i+1
                        endloop
                    endif 
                endif 
            endif 
            if GetUnitTypeId(GetTriggerUnit()) == 'hBAG' then 
                call TimerStart(bagCancelOrder,0.5,false,function bagCancelOrder_Action)
            endif 
            if IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) then 
                return 
            endif 
            if bf != 0 then 
                if GetIssuedOrderId() == ORDER_attack and GetOrderTargetUnit() != bf.buffSource and alive(bf.buffSource) and bf.buffSource != null and DisByUnits(bf.buffSource,GetTriggerUnit()) < 900 then 
                    set de = delayedevent.create(5,1,function DELAYED_ATTACK_ORDER)
                    call de.saveUnit("ATTACKER",GetTriggerUnit())
                    call de.saveUnit("TARGET",bf.buffSource)
                endif 
            endif 
        endfunction
        function anyUnitIssuePointOrder_Action takes nothing returns nothing
            local integer order = GetIssuedOrderId()
            local integer whichSlot
            if GetUnitTypeId(GetTriggerUnit()) == 'hBAG' then 
                call TimerStart(bagCancelOrder,0.5,false,function bagCancelOrder_Action)
            endif 
            if IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) then 
                return 
            endif
        endfunction
        function anyUnitIssueOrder_Action takes nothing returns nothing
            local integer order = GetIssuedOrderId()
            if GetUnitTypeId(GetTriggerUnit()) == 'hBAG' then 
                call TimerStart(bagCancelOrder,0.5,false,function bagCancelOrder_Action)
            endif 
            if IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) then 
                return 
            endif
        endfunction
        function Taunt takes unit whichUnit,unit targetUnit returns nothing
            local mybuff bf
            if IsUnitType(targetUnit,UNIT_TYPE_ANCIENT) then 
                set whichUnit = null 
                set targetUnit = null 
                return 
            endif 
            if alive(whichUnit) and whichUnit != null then 
                set bf = mybuff.create(whichUnit,targetUnit,BUFFTYPE_TAUNT)
                set bf.lastTime = 1000
                call bf.apply()
                if GetUnitCurrentOrder(whichUnit) == ORDER_AImove or GetUnitCurrentOrder(whichUnit) == ORDER_patrol or GetUnitCurrentOrder(whichUnit) == ORDER_holdposition or GetUnitCurrentOrder(whichUnit) == ORDER_stop or GetUnitCurrentOrder(whichUnit) == ORDER_move then 
                    call IssueTargetOrderById(whichUnit,ORDER_attack,whichUnit)
                endif 
                if IsUnitInGroup(targetUnit,tauntTargetGroup) == false then 
                    call GroupAddUnit(tauntTargetGroup,targetUnit)
                    call TriggerRegisterUnitEvent(tauntedUnitAimTarget,targetUnit,EVENT_UNIT_ACQUIRED_TARGET)
                endif 
            endif 
            set whichUnit = null 
            set targetUnit = null 
        endfunction
        //====================================================
        // endregion
        //====================================================
        function triggerPressF4_action takes nothing returns nothing
            local unit array stacker
            local integer j
            local integer minIdx
            local integer minId
            local integer curId
            local unit temp
            local boolean mode = false 
            local integer i = 0
            loop
                exitwhen i > 4
                set stacker[i] = party[i]
                set i = i+1
            endloop
            set i = 0
            set j = 0
            loop
                exitwhen i >= 4                // 只需排前4个，最后一个自动归位
                set minIdx = i
                set minId = GetHeroStackId(stacker[i])
                set j = i + 1
                loop
                    exitwhen j >= 5
                    set curId = GetHeroStackId(stacker[j])
                    if curId < minId then
                        set minIdx = j
                        set minId = curId
                    endif
                    set j = j + 1
                endloop

                // 如果找到更小的，交换
                if minIdx != i then
                    set temp = stacker[i]
                    set stacker[i] = stacker[minIdx]
                    set stacker[minIdx] = temp
                endif

                set i = i + 1
            endloop

            if stacker[3] != null and alive(stacker[3]) then 
                if IsUnitSelected(stacker[3],PLAYER) then 
                    set mode = true 
                endif   
                call ClearSelection()
                call SelectUnit(stacker[3],true)
                if mode then 
                    call SetCameraPosition(GetUnitX(stacker[3]),GetUnitY(stacker[3]))
                endif 
            endif     
            
            loop
                exitwhen i > 4
                set stacker[i] = null
                set i = i+1
            endloop
            set temp = null 
        endfunction
        function triggerPressF5_action takes nothing returns nothing
            local unit array stacker
            local integer j
            local integer minIdx
            local integer minId
            local integer curId
            local unit temp
            local boolean mode = false 
            local integer i = 0
            loop
                exitwhen i > 4
                set stacker[i] = party[i]
                set i = i+1
            endloop
            set i = 0
            set j = 0
            loop
                exitwhen i >= 4                // 只需排前4个，最后一个自动归位
                set minIdx = i
                set minId = GetHeroStackId(stacker[i])
                set j = i + 1
                loop
                    exitwhen j >= 5
                    set curId = GetHeroStackId(stacker[j])
                    if curId < minId then
                        set minIdx = j
                        set minId = curId
                    endif
                    set j = j + 1
                endloop

                // 如果找到更小的，交换
                if minIdx != i then
                    set temp = stacker[i]
                    set stacker[i] = stacker[minIdx]
                    set stacker[minIdx] = temp
                endif

                set i = i + 1
            endloop

            if stacker[4] != null and alive(stacker[4]) then 
                if IsUnitSelected(stacker[4],PLAYER) then 
                    set mode = true 
                endif   
                call ClearSelection()
                call SelectUnit(stacker[4],true)
                if mode then 
                    call SetCameraPosition(GetUnitX(stacker[4]),GetUnitY(stacker[4]))
                endif 
            endif     
            
            loop
                exitwhen i > 4
                set stacker[i] = null
                set i = i+1
            endloop
            set temp = null 
        endfunction

        //学习和重置逻辑
        function CheckHeroLearnBook takes unit whichUnit returns nothing
            local integer i = GetHeroIndex(whichUnit)
            local integer k
            if i == 0 then 
                return 
            endif 
            if i <= 10 then 
                set k = i-1
            else 
                set k = i+6
            endif 
            if GetUnitLevel(hero[i-1]) >= 1 and GetHeroData(hero[i-1],"LEARNED_ABILITY_0") == 0 then
                if GetUnitAbilityLevel(hero[i-1],'SL00'+k) == 0 then 
                    call UnitAddAbility(hero[i-1],'SL00'+k)
                    call UnitMakeAbilityPermanent(hero[i-1],true,'SL00'+k)
                endif 
            endif  
            if GetUnitLevel(hero[i-1]) >= 2 and GetHeroData(hero[i-1],"LEARNED_ABILITY_1") == 0 then
                if GetUnitAbilityLevel(hero[i-1],'SL10'+k) == 0 then 
                    call UnitAddAbility(hero[i-1],'SL10'+k)
                    call UnitMakeAbilityPermanent(hero[i-1],true,'SL10'+k)
                endif 
            endif  
            if GetUnitLevel(hero[i-1]) >= 4 and GetHeroData(hero[i-1],"LEARNED_ABILITY_2") == 0 then
                if GetUnitAbilityLevel(hero[i-1],'SL20'+k) == 0 then 
                    call UnitAddAbility(hero[i-1],'SL20'+k)
                    call UnitMakeAbilityPermanent(hero[i-1],true,'SL20'+k)
                endif 
            endif  
            if GetUnitLevel(hero[i-1]) >= 6 and GetHeroData(hero[i-1],"LEARNED_ABILITY_3") == 0 then
                if GetUnitAbilityLevel(hero[i-1],'SL30'+k) == 0 then 
                    call UnitAddAbility(hero[i-1],'SL30'+k)
                    call UnitMakeAbilityPermanent(hero[i-1],true,'SL30'+k)
                endif 
            endif  
            if GetUnitLevel(hero[i-1]) >= 10 and GetHeroData(hero[i-1],"LEARNED_ABILITY_4") == 0 then
                if GetUnitAbilityLevel(hero[i-1],'SL40'+k) == 0 then 
                    call UnitAddAbility(hero[i-1],'SL40'+k)
                    call UnitMakeAbilityPermanent(hero[i-1],true,'SL40'+k)
                endif 
            endif  
            set whichUnit = null 
        endfunction
        globals
            integer LastLearnTime = 0
        endglobals
        function Learn takes unit whichUnit,integer whichAbility returns nothing
            local integer targetAbility = whichAbility-2752512
            local integer learnBook
            local integer heroId        = GetHeroIndex(whichUnit)
            local integer learningAbilityIndex
            if whichAbility-'SZ00' <0 or heroId == 0 then
                return 
            endif
            if BlzGetAbilityPosX(targetAbility) == 0 and BlzGetAbilityPosY(targetAbility) == 2 then 
                //Q
                set learnBook = 'SL00'
                set learningAbilityIndex = 0
            elseif BlzGetAbilityPosX(targetAbility) == 1 and BlzGetAbilityPosY(targetAbility) == 2 then 
                //W
                set learnBook = 'SL10'
                set learningAbilityIndex = 1
            elseif BlzGetAbilityPosX(targetAbility) == 2 and BlzGetAbilityPosY(targetAbility) == 2 then 
                //E
                set learnBook = 'SL20'
                set learningAbilityIndex = 2
            elseif BlzGetAbilityPosX(targetAbility) == 3 and BlzGetAbilityPosY(targetAbility) == 2 then 
                //R
                set learnBook = 'SL30'
                set learningAbilityIndex = 3
            elseif BlzGetAbilityPosX(targetAbility) == 2 and BlzGetAbilityPosY(targetAbility) == 1 then 
                //F
                set learnBook = 'SL40'
                set learningAbilityIndex = 4
            else
                return 
            endif 
            if heroId <= 10 then
                set learnBook = learnBook+heroId-1
            else 
                set learnBook = learnBook+heroId+6
            endif 
            call IssueImmediateOrderById(whichUnit,ORDER_stop)
            call delayedRemoveUnitAbility(whichUnit,learnBook,1)
            call UnitAddAbility(whichUnit,targetAbility)
            call UnitMakeAbilityPermanent(whichUnit,true,targetAbility)
            call ExecuteFunc("HERO_"+I2S(heroId)+"_LEARN_"+I2SSSS(targetAbility))
            call SetHeroData(whichUnit,"LEARNED_ABILITY_"+I2S(learningAbilityIndex),whichAbility)

            call unitCheckState.evaluate(whichUnit)
            set whichUnit = null 
        endfunction
        function Retrain takes unit whichUnit returns nothing
            local integer whichAbility
            local integer targetAbility
            local integer heroId = GetHeroIndex(whichUnit)
            local integer modifier
            local integer i = 0
            if heroId == 0 then
                return 
            endif 
            if heroId <= 10 then
                set modifier = heroId-1
            else 
                set modifier = heroId+6
            endif 
            loop 
                exitwhen i > 4
                set whichAbility = GetHeroData(whichUnit,"LEARNED_ABILITY_"+I2S(i))
                set targetAbility = whichAbility-2752512
                call UnitRemoveAbility(whichUnit,targetAbility)
                call ExecuteFunc("HERO_"+I2S(heroId)+"_RETRAIN_"+I2SSSS(targetAbility))
                call SetHeroData(whichUnit,"LEARNED_ABILITY_"+I2S(i),0)
                set i = i+1
            endloop

            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl",GetUnitX(whichUnit),GetUnitY(whichUnit)))
            call CheckHeroLearnBook.evaluate(whichUnit)
            if master.getMasterByUnit(whichUnit) > 0 then 
                call master.getMasterByUnit(whichUnit).destroy()
            endif 
            call ExecuteFunc("HERO_"+I2S(heroId)+"_RETRAIN")
            call unitCheckState.evaluate(whichUnit)
            set whichUnit = null 
        endfunction

        function FlushCombatLog takes nothing returns nothing
            call Preload("\\")
            call PreloadGenEnd("NiLiuZhiZhan\\CombatLog\\"+I2S(TIME_LOG_START)+"\\CombatLog_"+I2S(LOG_INDEX*60)+"s_"+I2S(LOG_INDEX*60+TIME_LOG_FLUSH/10)+"s.txt")
            call PreloadGenClear()
            call PreloadGenStart()
            call Preload("\\")
            set LOG_INDEX = LOG_INDEX+1
            set TIME_LOG_FLUSH = 0
        endfunction
        function CombatLogCheck takes nothing returns nothing
            if COMBAT_LOG_ON then 
                set TIME_LOG_FLUSH = TIME_LOG_FLUSH+1
                if TIME_LOG_FLUSH == 600 then 
                    call FlushCombatLog.execute()
                endif 
            else 
                call PauseTimer(LOG_TIMER)
            endif 
        endfunction
        function triggerCombatLog_Action takes nothing returns nothing
            if not COMBAT_LOG_ON then 
                set COMBAT_LOG_ON = true 
                set TIME_LOG_START = globalNowtime
                set TIME_LOG_FLUSH = 0
                set LOG_INDEX = 0
                call PreloadGenClear()
                call PreloadGenStart()
                call Preload("COMBAT_LOG_START:"+I2S(globalNowtime))
                call Preload("---------------------------------------------------")
                call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00已开始战斗记录|r("+I2S(TIME_LOG_START)+")")
                call TimerStart(LOG_TIMER,0.1,true,function CombatLogCheck)
            else 
                set COMBAT_LOG_ON = false 
                call PauseTimer(LOG_TIMER)
                call FlushCombatLog.execute()
                call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00战斗记录已输出至：|r文档\\Warcraft III\\CustomMapData\\NiLiuZhiZhan\\CombatLog\\|cffffcc00"+I2S(TIME_LOG_START)+"|r")
            endif   
        endfunction
        function triggerLoadGame_Action takes nothing returns nothing
            set loadinggame = true 
            call TimerStart(CreateTimer(),0,false,function reCreateFrames)
        endfunction
        function SelectUnit_Action takes nothing returns nothing
            if GetPartyIndex(GetTriggerUnit()) > -1 then 
                set bagFollowUnit = GetTriggerUnit()
            endif 
        endfunction

        function ModifyEnemyState takes unit whichUnit returns nothing
            local real savedLifeScale = GetHeroRealData(whichUnit,"LIFE_MULTIPLE_SCALE")
            local real savedAttackScale = GetHeroRealData(whichUnit,"ATTACK_MULTIPLE_SCALE")
            local real savedArmorScale = GetHeroRealData(whichUnit,"ARMOR_MULTIPLE_SCALE")
            local integer savedResistance = GetHeroData(whichUnit,"BASE_RESISTANCE_MODIFIED")
            local integer savedEvade = GetHeroData(whichUnit,"BASE_EVADE_MODIFIED")
            local integer level = UnitLevel(whichUnit)-1
            local real lifeScale = LEVEL_LIFE_MULTIPLE[level]*Pow(MAP_DIFFICULTY_MULTIPLE,MAP_EXTRA_LEVEL)
            local real attackScale = LEVEL_DAMAGE_MULTIPLE[level]*Pow(MAP_DIFFICULTY_MULTIPLE,MAP_EXTRA_LEVEL)
            local real armorScale = LEVEL_LIFE_MULTIPLE[level]*2/5
            local integer baseResistance = GetUnitPointValue(whichUnit)+50*level
            local integer baseEvade = 0

            if GetUnitAbilityLevel(whichUnit,'AEV0') > 0 then 
                set baseEvade = baseEvade+500
            endif 
            if GetUnitAbilityLevel(whichUnit,'AEV1') > 0 then 
                set baseEvade = baseEvade+1000
            endif
            if GetUnitAbilityLevel(whichUnit,'AEV2') > 0 then 
                set baseEvade = baseEvade+1500
            endif
            if GetUnitAbilityLevel(whichUnit,'AEV3') > 0 then 
                set baseEvade = baseEvade+2000
            endif
            if GetUnitAbilityLevel(whichUnit,'AEV4') > 0 then 
                set baseEvade = baseEvade+2500
            endif
            
            call SetHeroRealData(whichUnit,"LIFE_MULTIPLE_SCALE",lifeScale)
            call SetHeroRealData(whichUnit,"ATTACK_MULTIPLE_SCALE",attackScale)
            call SetHeroRealData(whichUnit,"ARMOR_MULTIPLE_SCALE",armorScale)
            call SetHeroData(whichUnit,"BASE_RESISTANCE_MODIFIED",baseResistance)
            call SetHeroData(whichUnit,"BASE_EVADE_MODIFIED",baseEvade)
            if savedLifeScale > 0 then 
                set lifeScale = lifeScale/savedLifeScale
            endif 
            if savedAttackScale > 0 then 
                set attackScale = attackScale/savedAttackScale
            endif 
            if savedArmorScale > 0 then 
                set armorScale = armorScale/savedArmorScale
            endif
            if savedResistance > 0 then 
                set baseResistance = baseResistance-savedResistance
            endif 
            if savedEvade > 0 then 
                set baseEvade = baseEvade-savedEvade
            endif 
            call BlzSetUnitMaxHP(whichUnit,R2I(0.5+GetUnitState(whichUnit,UNIT_STATE_MAX_LIFE)*lifeScale))
            call SetUnitState(whichUnit,UNIT_STATE_LIFE,GetUnitState(whichUnit,UNIT_STATE_MAX_LIFE))
            call BlzSetUnitArmor(whichUnit,armorScale*BlzGetUnitArmor(whichUnit))
            call BlzSetUnitBaseDamage(whichUnit,R2I(0.5+BlzGetUnitBaseDamage(whichUnit,0)*attackScale),0)
            call BlzSetUnitBaseDamage(whichUnit,R2I(0.5+BlzGetUnitBaseDamage(whichUnit,1)*attackScale),1)
            call unitAddState(whichUnit,STATE_RESISTANCE,baseResistance)
            call unitAddState(whichUnit,STATE_EVADE,baseEvade)

            call BlzSetUnitIntegerField(whichUnit,UNIT_IF_LEVEL,level+1)
            set whichUnit = null 
        endfunction

        function initializeUnits takes nothing returns nothing
            local group allUnits = CreateGroup()
            call State.initAll()
            call GroupEnumUnitsInRect(allUnits,wholeMapRect,Condition(function initializeUnits_Action))
            call DestroyGroup(allUnits)
            set allUnits = null 
            call TriggerRegisterEnterRectSimple(anyUnitEnterMapZone,wholeMapRect)
            call TriggerAddActionEx(anyUnitEnterMapZone,function anyUnitEnterMapZone_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitDamaging,EVENT_PLAYER_UNIT_DAMAGING)
            call TriggerAddActionEx(anyUnitDamaging,function anyUnitDamaging_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitDamaged,EVENT_PLAYER_UNIT_DAMAGED)
            call TriggerAddActionEx(anyUnitDamaged,function anyUnitDamaged_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitReadyToCastSpell,EVENT_PLAYER_UNIT_SPELL_CHANNEL)
            call TriggerAddActionEx(anyUnitReadyToCastSpell,function anyUnitReadyToCastSpell_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitCastSpell,EVENT_PLAYER_UNIT_SPELL_EFFECT)
            call TriggerAddActionEx(anyUnitCastSpell,function anyUnitCastSpell_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitStopCastSpell,EVENT_PLAYER_UNIT_SPELL_ENDCAST)
            call TriggerAddActionEx(anyUnitStopCastSpell,function anyUnitStopCastSpell_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitCastSpellEnd,EVENT_PLAYER_UNIT_SPELL_FINISH)
            call TriggerAddActionEx(anyUnitCastSpellEnd,function anyUnitCastSpellEnd_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitUseItem,EVENT_PLAYER_UNIT_USE_ITEM)
            call TriggerAddActionEx(anyUnitUseItem,function anyUnitUseItem_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitPickItem,EVENT_PLAYER_UNIT_PICKUP_ITEM)
            call TriggerAddActionEx(anyUnitPickItem,function anyUnitPickItem_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitDropItem,EVENT_PLAYER_UNIT_DROP_ITEM)
            call TriggerAddActionEx(anyUnitDropItem,function anyUnitDropItem_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitDeath,EVENT_PLAYER_UNIT_DEATH)
            call TriggerAddActionEx(anyUnitDeath,function anyUnitDeath_Action)
            call TriggerRegisterPlayerChatEvent(saveCampaignFiles,PLAYER,"save",true)
            call TriggerRegisterPlayerChatEvent(saveCampaignFiles,PLAYER,"存档",true)
            call TriggerAddActionEx(saveCampaignFiles,function saveCampaignFiles_Action)
            call TriggerRegisterPlayerChatEvent(openGameSight,PLAYER," ",true)
            call TriggerAddActionEx(openGameSight,function openGameSight_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitAttacking,EVENT_PLAYER_UNIT_ATTACKED)
            call TriggerAddActionEx(anyUnitAttacking,function anyUnitAttacking_Action)
            call TriggerAddActionEx(tauntedUnitAimTarget,function tauntedUnitAimTarget_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitIssueTargetOrder,EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
            call TriggerAddActionEx(anyUnitIssueTargetOrder,function anyUnitIssueTargetOrder_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitIssueOrder,EVENT_PLAYER_UNIT_ISSUED_ORDER)
            call TriggerAddActionEx(anyUnitIssueOrder,function anyUnitIssueOrder_Action)
            call TriggerRegisterAnyUnitEventBJ(anyUnitIssuePointOrder,EVENT_PLAYER_UNIT_ISSUED_ORDER)
            call TriggerAddActionEx(anyUnitIssuePointOrder,function anyUnitIssuePointOrder_Action)
            set INV_ICON[0]             = "replaceabletextures\\commandbuttons\\mainhand.blp" 
            set INV_TOOLTIP[0]          = "武器"
            set INV_TOOLTIP_EXTENDED[0] = "未装备武器。"
            set INV_ICON[1]             = "replaceabletextures\\commandbuttons\\offhand.blp" 
            set INV_TOOLTIP[1]          = "副手物品"
            set INV_TOOLTIP_EXTENDED[1] = "未装备副手物品。"
            set INV_ICON[2]             = "replaceabletextures\\commandbuttons\\head.blp" 
            set INV_TOOLTIP[2]          = "头盔"
            set INV_TOOLTIP_EXTENDED[2] = "未装备头盔。"
            set INV_ICON[3]             = "replaceabletextures\\commandbuttons\\chest.blp" 
            set INV_TOOLTIP[3]          = "护甲"
            set INV_TOOLTIP_EXTENDED[3] = "未装备护甲。"
            set INV_ICON[4]             = "replaceabletextures\\commandbuttons\\feet.blp" 
            set INV_TOOLTIP[4]          = "鞋"
            set INV_TOOLTIP_EXTENDED[4] = "未装备鞋。"
            set INV_ICON[5]             = "replaceabletextures\\commandbuttons\\neck.blp" 
            set INV_TOOLTIP[5]          = "护符"
            set INV_TOOLTIP_EXTENDED[5] = "未装备护符。"
            set INV_ICON[6]             = "replaceabletextures\\commandbuttons\\ring.blp" 
            set INV_TOOLTIP[6]          = "戒指"
            set INV_TOOLTIP_EXTENDED[6] = "未装备戒指。"
            set INV_ICON[7]             = "replaceabletextures\\commandbuttons\\ring.blp"
            set INV_TOOLTIP[7]          = "戒指"
            set INV_TOOLTIP_EXTENDED[7] = "未装备戒指。"
            set INV_ICON[8]             = "replaceabletextures\\commandbuttons\\hand.blp"
            set INV_TOOLTIP[8]          = "手部"
            set INV_TOOLTIP_EXTENDED[8] = "手部未装备。"
            set INV_ICON[9]             = "replaceabletextures\\commandbuttons\\belt.blp"
            set INV_TOOLTIP[9]          = "腰部"
            set INV_TOOLTIP_EXTENDED[9] = "腰部未装备。"
            set heroMainState[ 0]        = STATE_STR
            set heroMainState[ 1]        = STATE_STR
            set heroMainState[ 2]        = STATE_STR
            set heroMainState[ 3]        = STATE_STR
            set heroMainState[ 4]        = STATE_AGI
            set heroMainState[ 5]        = STATE_AGI
            set heroMainState[ 6]        = STATE_INT
            set heroMainState[ 7]        = STATE_INT
            set heroMainState[ 8]        = STATE_INT
            set heroMainState[ 9]        = STATE_STR
            set heroMainState[10]        = STATE_INT
            set heroMainState[11]        = STATE_INT
            set heroMainState[12]        = STATE_INT
            set heroMainState[13]        = STATE_AGI
            set heroMainState[14]        = STATE_AGI
            set heroMainState[15]        = STATE_INT
            set HERO_DEFAULT_ID[ 0]      = 'HZ00'      
            set HERO_DEFAULT_ID[ 1]      = 'HZ01'      
            set HERO_DEFAULT_ID[ 2]      = 'HZ02'      
            set HERO_DEFAULT_ID[ 3]      = 'HZ03'      
            set HERO_DEFAULT_ID[ 4]      = 'HZ04'      
            set HERO_DEFAULT_ID[ 5]      = 'HZ05'      
            set HERO_DEFAULT_ID[ 6]      = 'HZ06'      
            set HERO_DEFAULT_ID[ 7]      = 'HZ07'      
            set HERO_DEFAULT_ID[ 8]      = 'HZ08'      
            set HERO_DEFAULT_ID[ 9]      = 'HZ09'      
            set HERO_DEFAULT_ID[10]      = 'HZ0A'      
            set HERO_DEFAULT_ID[11]      = 'HZ0B'      
            set HERO_DEFAULT_ID[12]      = 'HZ0C'      
            set HERO_DEFAULT_ID[13]      = 'HZ0D'      
            set HERO_DEFAULT_ID[14]      = 'HZ0E'      
            set HERO_DEFAULT_ID[15]      = 'HZ0F'         
            set DRUID_ICON_PATH_STAR_SURGE_Q[0] = "ReplaceableTextures\\CommandButtonsAuto\\BTNdruid_icon_20.blp"
            set DRUID_ICON_PATH_STAR_SURGE_Q[1] = "ReplaceableTextures\\CommandButtons\\Druid\\1\\BTNstarsurge.blp"
            set DRUID_ICON_PATH_STAR_SURGE_Q[2] = "ReplaceableTextures\\CommandButtons\\Druid\\2\\BTNstarsurge.blp"
            set DRUID_ICON_PATH_STAR_SURGE_Q[3] = "ReplaceableTextures\\CommandButtons\\Druid\\3\\BTNstarsurge.blp"
            set DRUID_ICON_PATH_STAR_SURGE_Q[4] = "ReplaceableTextures\\CommandButtons\\Druid\\4\\BTNstarsurge.blp"
            set DRUID_ICON_PATH_STAR_SURGE_Q[5] = "ReplaceableTextures\\CommandButtons\\Druid\\5\\BTNstarsurge.blp"
            set DRUID_ICON_PATH_STAR_SURGE_Q[6] = "ReplaceableTextures\\CommandButtons\\Druid\\6\\BTNstarsurge.blp"
            set DRUID_ICON_PATH_STAR_SURGE_Q[7] = "ReplaceableTextures\\CommandButtons\\Druid\\7\\BTNstarsurge.blp"
            set DRUID_ICON_PATH_STAR_SURGE_Q[8] = "ReplaceableTextures\\CommandButtons\\Druid\\8\\BTNstarsurge.blp"
            set DRUID_ICON_PATH_STAR_SURGE_Q[9] = "ReplaceableTextures\\CommandButtons\\Druid\\9\\BTNstarsurge.blp"
            set DRUID_ICON_PATH_MOON_PHASE_W[0] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_35_0.blp"
            set DRUID_ICON_PATH_MOON_PHASE_W[1] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_35_1.blp"
            set DRUID_ICON_PATH_MOON_PHASE_W[2] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_35_2.blp"
            set DRUID_ICON_PATH_MOON_PHASE_W[3] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_35_3.blp"
            set DRUID_ICON_PATH_MOON_PHASE_W[4] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_35_4.blp"
            set DRUID_ICON_PATH_MOON_PHASE_W[5] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_35_5.blp"
            set DRUID_ICON_PATH_MOON_PHASE_E[0] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_19_0.blp"
            set DRUID_ICON_PATH_MOON_PHASE_E[1] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_19_1.blp"
            set DRUID_ICON_PATH_MOON_PHASE_E[2] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_19_2.blp"
            set DRUID_ICON_PATH_MOON_PHASE_E[3] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_19_3.blp"
            set DRUID_ICON_PATH_MOON_PHASE_E[4] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_19_4.blp"
            set DRUID_ICON_PATH_MOON_PHASE_E[5] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_19_5.blp"
            set DRUID_ICON_PATH_MOON_PHASE_R[0] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_34_0.blp"
            set DRUID_ICON_PATH_MOON_PHASE_R[1] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_34_1.blp"
            set DRUID_ICON_PATH_MOON_PHASE_R[2] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_34_2.blp"
            set DRUID_ICON_PATH_MOON_PHASE_R[3] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_34_3.blp"
            set DRUID_ICON_PATH_MOON_PHASE_R[4] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_34_4.blp"
            set DRUID_ICON_PATH_MOON_PHASE_R[5] = "ReplaceableTextures\\CommandButtons\\Druid\\BTNdruid_icon_34_5.blp"
        endfunction

        function SetDestInvulnerable takes nothing returns nothing
            call SetDestructableInvulnerable(GetEnumDestructable(),true)
        endfunction

        private function init takes nothing returns nothing
            local integer i = 0
            local integer bonusAbilityId_POS
            local integer bonusAbilityId_NEG
            local integer maxBinary
            local integer k = 0

            call SetMaxCheckpointSaves(1)
            call SetPlayerController(Player(PLAYER_NEUTRAL_AGGRESSIVE),MAP_CONTROL_USER)
            call StartMeleeAI(Player(PLAYER_NEUTRAL_AGGRESSIVE),"")
            //call DisplayTimedTextToPlayer(PLAYER,0,0,5,"|cff191918正在初始化...|r")
            
            set LEVEL_LIFE_MULTIPLE  [0]  = 1
            set LEVEL_DAMAGE_MULTIPLE[0]  = 1
            set LEVEL_LIFE_MULTIPLE  [1]  = 1.5
            set LEVEL_DAMAGE_MULTIPLE[1]  = 1.25
            set LEVEL_LIFE_MULTIPLE  [2]  = 2
            set LEVEL_DAMAGE_MULTIPLE[2]  = 1.5
            set LEVEL_LIFE_MULTIPLE  [3]  = 2.5
            set LEVEL_DAMAGE_MULTIPLE[3]  = 2
            set LEVEL_LIFE_MULTIPLE  [4]  = 3
            set LEVEL_DAMAGE_MULTIPLE[4]  = 2.5
            set LEVEL_LIFE_MULTIPLE  [5]  = 3.5
            set LEVEL_DAMAGE_MULTIPLE[5]  = 3
            set LEVEL_LIFE_MULTIPLE  [6]  = 4
            set LEVEL_DAMAGE_MULTIPLE[6]  = 4
            set LEVEL_LIFE_MULTIPLE  [7]  = 6
            set LEVEL_DAMAGE_MULTIPLE[7]  = 5
            set LEVEL_LIFE_MULTIPLE  [8]  = 8
            set LEVEL_DAMAGE_MULTIPLE[8]  = 6
            set LEVEL_LIFE_MULTIPLE  [9]  = 10
            set LEVEL_DAMAGE_MULTIPLE[9]  = 7
            set LEVEL_LIFE_MULTIPLE  [10] = 12.5
            set LEVEL_DAMAGE_MULTIPLE[10] = 8
            set LEVEL_LIFE_MULTIPLE  [11] = 15
            set LEVEL_DAMAGE_MULTIPLE[11] = 10
            set LEVEL_LIFE_MULTIPLE  [12] = 17.5
            set LEVEL_DAMAGE_MULTIPLE[12] = 12
            set LEVEL_LIFE_MULTIPLE  [13] = 20
            set LEVEL_DAMAGE_MULTIPLE[13] = 14
            set LEVEL_LIFE_MULTIPLE  [14] = 23
            set LEVEL_DAMAGE_MULTIPLE[14] = 16
            set LEVEL_LIFE_MULTIPLE  [15] = 26
            set LEVEL_DAMAGE_MULTIPLE[15] = 18
            set LEVEL_LIFE_MULTIPLE  [16] = 30
            set LEVEL_DAMAGE_MULTIPLE[16] = 20
            set LEVEL_LIFE_MULTIPLE  [17] = 35
            set LEVEL_DAMAGE_MULTIPLE[17] = 25
            set LEVEL_LIFE_MULTIPLE  [18] = 40
            set LEVEL_DAMAGE_MULTIPLE[18] = 30
            set LEVEL_LIFE_MULTIPLE  [19] = 45
            set LEVEL_DAMAGE_MULTIPLE[19] = 35
            set LEVEL_LIFE_MULTIPLE  [20] = 50
            set LEVEL_DAMAGE_MULTIPLE[20] = 40
            set LEVEL_LIFE_MULTIPLE  [21] = 55
            set LEVEL_DAMAGE_MULTIPLE[21] = 45
            set LEVEL_LIFE_MULTIPLE  [22] = 60
            set LEVEL_DAMAGE_MULTIPLE[22] = 50
            set LEVEL_LIFE_MULTIPLE  [23] = 65
            set LEVEL_DAMAGE_MULTIPLE[23] = 55
            set LEVEL_LIFE_MULTIPLE  [24] = 70
            set LEVEL_DAMAGE_MULTIPLE[24] = 60


            set wholeMapRect = GetWorldBounds()
            set wholeMapRegion = CreateRegion()

            
            call GroupEnumUnitsInRect(allReviveStones,wholeMapRect,Condition(function isReviveStone))

            call RegionAddRect(wholeMapRegion,wholeMapRect)

            call TimerStart(centeralTimer,0.01,true,function centeralTimerUpdate)

            set playerEnemyCombat = Condition(function Condition_playerEnemyCombat)
            set playerEnemy = Condition(function Condition_playerEnemy)
            set playerAlly = Condition(function Condition_playerAlly)
            set playerHero = Condition(function Condition_playerHero)
            set bossResetFilter = Condition(function Condition_bossResetFilter)
            set autoGateFilter = Condition(function Condition_autoGateFilter)
            set isInnSelected = Condition(function Condition_isInnSelected)

            set groupEnumLegal = Condition(function Condition_groupEnumLegal)
            set groupEnumLegal_ProjBounce = Condition(function Condition_groupEnumLegal_Bounce)
            set blockMissile = Condition(function Condition_blockMissile)

            set gameCache = InitGameCache(GAME_CACHE_NAME)

            call delayedevent.create(GLOBAL_UPDATE_PERIOD,0,function globalUpdate)

            call delayedevent.create(2,1,function loadCampaignDatas)

            set PRELOAD_ABILITY_DUMMY = CreateUnit(NEUTRAL,'hPRE',0,0,0)
            set PATH_CHECKER = CreateItem('IPTH',0,0)
            call SetItemInvulnerable(PATH_CHECKER,true)
            call SetItemVisible(PATH_CHECKER,false)

            call initUnitDatas.execute()
            call initItemDatas.execute()
            call initBuffDatas.execute()
            ////////////call BJDebugMsg(I2S('H00A'-'H009'))
            call BlzSetUnitWeaponRealField(PRELOAD_ABILITY_DUMMY,UNIT_WEAPON_RF_ATTACK_RANGE,0,200)
            if BlzGetUnitWeaponRealField(PRELOAD_ABILITY_DUMMY,UNIT_WEAPON_RF_ATTACK_RANGE,0) < 101 then 
                set ATTACK_RANGE_SET_FIXED = false 
            else 
                set ATTACK_RANGE_SET_FIXED = true 
            endif 

            set binaryNumber[0] = 1
            loop 
                exitwhen i > 29
                set binaryNumber[i+1] = binaryNumber[i]*2
                set i = i+1
            endloop

            call TriggerRegisterAnyUnitEventBJ(triggerHeroLevelUp,EVENT_PLAYER_HERO_LEVEL)
            call TriggerAddActionEx(triggerHeroLevelUp,function triggerHeroLevelUp_Action)

            call initializeUnits.execute()

            set i = 0
            loop
                exitwhen i > MAX_HERO_TYPE-1
                set triggerHeroCheckState[i] = CreateTrigger()
                set NEED_REFRESH_FORM[i] = false 
                set i = i+1
            endloop

            call EnumDestructablesInRectAll(wholeMapRect,function SetDestInvulnerable)

            call TriggerAddActionEx(triggerHeroCheckState[0],function triggerHeroCheckState_Action_0)
            call TriggerAddActionEx(triggerHeroCheckState[1],function triggerHeroCheckState_Action_1)
            call TriggerAddActionEx(triggerHeroCheckState[2],function triggerHeroCheckState_Action_2)
            call TriggerAddActionEx(triggerHeroCheckState[3],function triggerHeroCheckState_Action_3)
            call TriggerAddActionEx(triggerHeroCheckState[4],function triggerHeroCheckState_Action_4)
            call TriggerAddActionEx(triggerHeroCheckState[5],function triggerHeroCheckState_Action_5)
            call TriggerAddActionEx(triggerHeroCheckState[6],function triggerHeroCheckState_Action_6)
            call TriggerAddActionEx(triggerHeroCheckState[7],function triggerHeroCheckState_Action_7)
            call TriggerAddActionEx(triggerHeroCheckState[8],function triggerHeroCheckState_Action_8)
            call TriggerAddActionEx(triggerHeroCheckState[9],function triggerHeroCheckState_Action_9)
            call TriggerAddActionEx(triggerHeroCheckState[10],function triggerHeroCheckState_Action_10)
            call TriggerAddActionEx(triggerHeroCheckState[11],function triggerHeroCheckState_Action_11)
            call TriggerAddActionEx(triggerHeroCheckState[12],function triggerHeroCheckState_Action_12)
            call TriggerAddActionEx(triggerHeroCheckState[13],function triggerHeroCheckState_Action_13)
            call TriggerAddActionEx(triggerHeroCheckState[14],function triggerHeroCheckState_Action_14)
            call TriggerAddActionEx(triggerHeroCheckState[15],function triggerHeroCheckState_Action_15)

            call TriggerRegisterPlayerChatEvent(triggerCombatLog,PLAYER,"-log",true)
            call TriggerRegisterPlayerChatEvent(triggerCombatLog,PLAYER,"日志",true)
            call TriggerAddActionEx(triggerCombatLog,function triggerCombatLog_Action)

            call TriggerRegisterAnyUnitEventBJ(triggerHeroRevive,EVENT_PLAYER_HERO_REVIVE_FINISH)
            call TriggerAddActionEx(triggerHeroRevive,function triggerHeroRevive_Action)

            call TriggerRegisterGameLoadedEventBJ(triggerLoadGame)
            call TriggerAddActionEx(triggerLoadGame,function triggerLoadGame_Action)

            call TriggerRegisterAnyUnitEventBJ(anyUnitBuyingItem,EVENT_PLAYER_UNIT_SELL_ITEM)
            call TriggerAddActionEx(anyUnitBuyingItem,function AnyUnitBuyingItem_action)

            call TriggerRegisterAnyUnitEventBJ(anyUnitSellingItem,EVENT_PLAYER_UNIT_PAWN_ITEM)
            call TriggerAddActionEx(anyUnitSellingItem,function AnyUnitSellingItem_action)

            call BlzTriggerRegisterPlayerKeyEvent(triggerPressF4,PLAYER,OSKEY_F4,0,true)
            call TriggerAddAction(triggerPressF4,function triggerPressF4_action)
            call BlzTriggerRegisterPlayerKeyEvent(triggerPressF5,PLAYER,OSKEY_F5,0,true)
            call TriggerAddAction(triggerPressF5,function triggerPressF5_action)

            call TriggerRegisterPlayerSelectionEventBJ(triggerSelectUnit,PLAYER,true)
            call TriggerAddAction(triggerSelectUnit,function SelectUnit_Action)
            //检查力量
            set bonusAbilityId_POS = 'AST0'
            set bonusAbilityId_NEG = 'Ast0'
            set maxBinary = 12
            set k = maxBinary
            loop 
                exitwhen k < 0
                if k > 9 then 
                    set i = k+7
                else 
                    set i = k
                endif 
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                set k = k-1
            endloop 

            //检查敏捷
            set bonusAbilityId_POS = 'AAG0'
            set bonusAbilityId_NEG = 'Aag0'
            set maxBinary = 12
            set k = maxBinary
            loop 
                exitwhen k < 0
                if k > 9 then 
                    set i = k+7
                else 
                    set i = k
                endif 
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                set k = k-1
            endloop 

            //检查智力
            set bonusAbilityId_POS = 'AIN0'
            set bonusAbilityId_NEG = 'Ain0'
            set maxBinary = 12
            set k = maxBinary
            loop 
                exitwhen k < 0
                if k > 9 then 
                    set i = k+7
                else 
                    set i = k
                endif 
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                set k = k-1
            endloop 

            //检查攻击
            set bonusAbilityId_POS = 'AAT0'
            set bonusAbilityId_NEG = 'Aat0'
            set maxBinary = 15
            set k = maxBinary
            loop 
                exitwhen k < 0
                if k > 9 then 
                    set i = k+7
                else 
                    set i = k
                endif 
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                set k = k-1
            endloop 

            //检查护甲
            set bonusAbilityId_POS = 'AAR0'
            set bonusAbilityId_NEG = 'Aar0'
            set maxBinary = 10
            set k = maxBinary
            loop 
                exitwhen k < 0
                if k > 9 then 
                    set i = k+7
                else 
                    set i = k
                endif 
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                set k = k-1
            endloop 

            //检查攻击速度
            set bonusAbilityId_POS = 'AAS0'
            set bonusAbilityId_NEG = 'Aas0'
            set maxBinary = 8
            set k = maxBinary
            loop 
                exitwhen k < 0
                if k > 9 then 
                    set i = k+7
                else 
                    set i = k
                endif 
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                set k = k-1
            endloop 

            //检查生命
            set bonusAbilityId_POS = 'ALI0'
            set bonusAbilityId_NEG = 'Ali0'
            set maxBinary = 22
            set k = maxBinary
            loop 
                exitwhen k < 0
                if k > 9 then 
                    set i = k+7
                else 
                    set i = k
                endif 
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                set k = k-1
            endloop 

            //检查法力
            set bonusAbilityId_POS = 'AMA0'
            set bonusAbilityId_NEG = 'Ama0'
            set maxBinary = 12
            set k = maxBinary
            loop 
                exitwhen k < 0
                if k > 9 then 
                    set i = k+7
                else 
                    set i = k
                endif 
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_NEG+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,bonusAbilityId_POS+i)
                set k = k-1
            endloop 

            set k = 0
            loop 
                exitwhen k >= MAX_HERO_TYPE
                if k > 9 then 
                    set i = k+7
                else 
                    set i = k
                endif 
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,'SL00'+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,'SL10'+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,'SL20'+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,'SL30'+i)
                call UnitAddAbility(PRELOAD_ABILITY_DUMMY,'SL40'+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,'SL00'+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,'SL10'+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,'SL20'+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,'SL30'+i)
                call UnitRemoveAbility(PRELOAD_ABILITY_DUMMY,'SL40'+i)
                set k = k+1
            endloop 

            call RemoveUnit(PRELOAD_ABILITY_DUMMY)
            call ClearHeroGrid.execute()

            //call DisplayTimedTextToPlayer(PLAYER,0,0,5,"|cffffcc00预载完成|r")
        endfunction

    endlibrary

library BackGroundMusic initializer Init

    /*
    // 动态添加新歌
    local BGM newSong = BGM.create("Sound\\Music\\mp3Music\\NewSong.mp3")

    // 删除指定歌曲（假设你保存了某个BGM实例）
    call someBGM.destroy()

    // 清空整个歌单
    call BGM.clearAll()

    // 暂停 / 恢复
    call BGM.pause()
    call BGM.resume()

    // 调整音量
    call BGM.setVolume(100)   // 更大声
    call BGM.setVolume(50)    // 更小声
    call BGM.setVolume(0)     // 静音

    // 其他原有功能
    call BGM.setPlayMode(2)      // 随机
    call BGM.playNext()
    */

    globals
        private timer MusicTimer = CreateTimer()
        
        private constant integer MODE_ORDER     = 0
        private constant integer MODE_SINGLE    = 1
        private constant integer MODE_RANDOM    = 2
        
        private integer PlayMode = MODE_ORDER
        
        private integer GlobalVolume = 67  // 默认音量（0-127），可动态修改
    endglobals

    struct BGM
        static boolean IsPlaying = false
        static boolean IsPaused  = false  // 新增：是否暂停
        static BGM head = 0
        static BGM tail = 0
        static BGM current = 0
        
        static BGM array songList[200]   // 最大支持200首（可自行扩大）
        static integer songCount = 0
        
        BGM prev
        BGM next
        sound snd
        integer index  // 在 songList 中的位置

        // ==================== 创建并添加歌曲 ====================
        static method create takes string filePath returns BGM
            local thistype this = thistype.allocate()

            set this.snd = CreateSound(filePath, false, false, false, 10, 10, "")
            call SetSoundVolume(this.snd, GlobalVolume)
            call SetSoundChannel(this.snd, 0)

            // 插入双向链表尾部
            set this.prev = thistype.tail
            set this.next = 0
            if thistype.tail != 0 then
                set thistype.tail.next = this
            endif
            set thistype.tail = this
            if thistype.head == 0 then
                set thistype.head = this
            endif

            // 登记到数组（用于随机访问）
            set this.index = thistype.songCount
            set thistype.songList[thistype.songCount] = this
            set thistype.songCount = thistype.songCount + 1

            return this
        endmethod

        // ==================== 动态删除单首歌曲 ====================
        method destroy takes nothing returns nothing
            local integer i = this.index + 1
            
            // 从链表中移除
            if this.prev != 0 then
                set this.prev.next = this.next
            else
                set thistype.head = this.next
            endif
            if this.next != 0 then
                set this.next.prev = this.prev
            else
                set thistype.tail = this.prev
            endif

            // 如果删除的是当前播放的歌曲，切换到下一首
            if thistype.current == this then
                call StopSound(this.snd, false, false)
                set thistype.current = this.getNextSong()
                if thistype.current != 0 and BGM.IsPlaying and not BGM.IsPaused then
                    call StartSound(thistype.current.snd)
                endif
            endif

            // 从数组中移除（将最后一个元素移到当前位置）
            set thistype.songCount = thistype.songCount - 1
            if this.index != thistype.songCount then
                set thistype.songList[this.index] = thistype.songList[thistype.songCount]
                set thistype.songList[this.index].index = this.index
            endif
            set thistype.songList[thistype.songCount] = 0

            // 清理sound（推荐）
            call KillSoundWhenDone(this.snd)
            set this.snd = null

            call this.deallocate()
        endmethod

        // ==================== 清空整个歌单 ====================
        static method clearAll takes nothing returns nothing
            local thistype node = thistype.head
            local thistype next
            
            call thistype.stop()  // 先停止播放
            
            loop
                exitwhen node == 0
                set next = node.next
                call node.destroy()  // 会自动清理链表和数组
                set node = next
            endloop
            
            set thistype.head = 0
            set thistype.tail = 0
            set thistype.current = 0
            set thistype.songCount = 0
        endmethod

        // ==================== 获取下一首（根据模式） ====================
        private method getNextSong takes nothing returns BGM
            local integer rnd
            
            if PlayMode == MODE_SINGLE then
                return this
                
            elseif PlayMode == MODE_RANDOM then
                if thistype.songCount <= 1 then
                    return this
                endif
                loop
                    set rnd = GetRandomInt(0, thistype.songCount - 1)
                    exitwhen thistype.songList[rnd] != this
                endloop
                return thistype.songList[rnd]
                
            else  // ORDER
                if this.next != 0 then
                    return this.next
                endif
                return thistype.head
            endif
        endmethod

        // ==================== 定时器检测切歌 ====================
        private static method onTimer takes nothing returns nothing
            if Settings_OtherMusic == false and BGM.IsPlaying then 
                call thistype.stop()
            endif 
            if Settings_OtherMusicMode == 0 then 
                set PlayMode = MODE_ORDER
            else 
                set PlayMode = MODE_RANDOM
            endif 
            if thistype.current == 0 or BGM.IsPaused then
                return
            endif

            if not GetSoundIsLoading(thistype.current.snd) and not GetSoundIsPlaying(thistype.current.snd) then
                call StopSound(thistype.current.snd, false, false)
                set thistype.current = thistype.current.getNextSong()
                if thistype.current != 0 then
                    call StartSound(thistype.current.snd)
                endif
            endif
        endmethod

        // ==================== 播放控制 ====================
        static method play takes nothing returns nothing
            if thistype.head == 0 then
                return
            endif
            if not BGM.IsPlaying then
                set thistype.current = thistype.head
                call StartSound(thistype.current.snd)
                call TimerStart(MusicTimer, 0.03, true, function thistype.onTimer)
                set BGM.IsPlaying = true
                set BGM.IsPaused = false
            elseif BGM.IsPaused then
                call thistype.resume()  // 如果只是暂停，直接恢复
            endif
        endmethod

        static method stop takes nothing returns nothing
            if thistype.current != 0 then
                call StopSound(thistype.current.snd, false, false)
                set thistype.current = 0
            endif
            call PauseTimer(MusicTimer)
            set BGM.IsPlaying = false
            set BGM.IsPaused = true 
        endmethod

        // 新增：暂停（保留当前歌曲位置）
        static method pause takes nothing returns nothing
            if thistype.current != 0 and BGM.IsPlaying then
                call StopSound(thistype.current.snd,false,true) //PauseSound(thistype.current.snd)  // 原生暂停函数（Reforged支持较好）
                // 如果旧版本不支持PauseSound，可用StopSound + 记录进度（复杂），这里优先用原生
                set BGM.IsPaused = true
            endif
        endmethod

        // 新增：恢复播放
        static method resume takes nothing returns nothing
            if thistype.current != 0 and BGM.IsPlaying and BGM.IsPaused then
                call StartSoundEx(thistype.current.snd,true)// ResumeSound(thistype.current.snd)
                set BGM.IsPaused = false
            endif
        endmethod

        // 新增：调整全局音量（0-127）
        static method setVolume takes integer volume returns nothing
            local thistype node
            if volume < 0 then
                set volume = 0
            elseif volume > 100 then
                set volume = 100
            endif
            set GlobalVolume = volume
            
            // 立即应用到当前播放的
            if thistype.current != 0 then
                call SetSoundVolume(thistype.current.snd, volume)
            endif
            
            // 可选：遍历所有已创建的sound调整（如果想预加载或保持一致）
            set node = thistype.head
            loop
                exitwhen node == 0
                call SetSoundVolume(node.snd, volume)
                set node = node.next
            endloop
        endmethod

        static method getVolume takes nothing returns integer
            return GlobalVolume
        endmethod

        // ==================== 其他控制 ====================
        static method setPlayMode takes integer mode returns nothing
            if mode == MODE_ORDER or mode == MODE_SINGLE or mode == MODE_RANDOM then
                set PlayMode = mode
            endif
        endmethod

        static method playNext takes nothing returns nothing
            if thistype.current == 0 or not BGM.IsPlaying then
                return
            endif
            call StopSound(thistype.current.snd, false, false)
            set thistype.current = thistype.current.getNextSong()
            call StartSound(thistype.current.snd)
        endmethod

        static method playPrevious takes nothing returns nothing
            local thistype temp
            if thistype.current == 0 or not BGM.IsPlaying or PlayMode != MODE_ORDER then
                return
            endif
            if thistype.current == thistype.head then
                set thistype.current = thistype.tail
            else
                set temp = thistype.head
                loop
                    exitwhen temp.next == thistype.current
                    set temp = temp.next
                endloop
                set thistype.current = temp
            endif
            call StopSound(thistype.current.snd, false, false)
            call StartSound(thistype.current.snd)
        endmethod
    endstruct

    private function Init takes nothing returns nothing
        call ClearMapMusic()
        call StopMusic(false)

        call BGM.create("Sound\\Music\\mp3Music\\Comradeship.mp3")
        call BGM.create("Sound\\Music\\mp3Music\\Mainscreen.mp3")
        call BGM.create("Sound\\Music\\mp3Music\\TragicConfrontation.mp3")
        call BGM.create("Sound\\Music\\mp3Music\\BloodElfTheme.mp3")
        call BGM.create("Sound\\Music\\mp3Music\\War2IntroMusic.mp3")

        call BGM.play()
    endfunction

endlibrary
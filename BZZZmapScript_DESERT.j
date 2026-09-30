
library MapTrig initializer init requires talentlib 
    globals
        trigger array QuestTrig [50]

        Entrance enterDungeon00 
        Entrance enterDungeon01
        Entrance enterDesert 

        trigger unlockReviveStone1 = CreateTrigger()
        trigger unlockReviveStone2 = CreateTrigger()
        trigger unlockReviveStone3 = CreateTrigger()
        trigger unlockReviveStone4 = CreateTrigger()
        trigger unlockReviveStone5 = CreateTrigger()

        group CinematicGroup1 = CreateGroup()

        group allInns = CreateGroup()
        trigger bindHearthStone = CreateTrigger()
        integer lastSummonHydra = 0
        timer timerSummonHydra = CreateTimer()
    endglobals

    function Play_GoblinBoat_5300 takes nothing returns nothing
        call ShowUnit(gg_unit_o601_1039,false)
    endfunction
    function Play_GoblinBoat_4300 takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(1000,1,function Play_GoblinBoat_5300)
        call IssuePointOrderById(gg_unit_o601_1039,ORDER_move,952,-28493)
        call ShowUnit(gg_unit_o602_1040,true)
    endfunction
    function Play_GoblinBoat_4200 takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(100,1,function Play_GoblinBoat_4300)
        local integer i = 0
        call PlaySndEx(SND_LOAD)
        call ResetToGameCamera(0)
        call SetCameraPosition(GetUnitX(gg_unit_o601_1039),GetUnitY(gg_unit_o601_1039))
        loop
            exitwhen i > 4
            call SetUnitX(party[i],GetRandomReal(8384,8608))
            call SetUnitY(party[i],GetRandomReal(-30496,-30144))
            call ShowUnit(party[i],true)
            call PauseUnit(party[i],false)
            set i = i+1
        endloop
        if sideQuest[43].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[43].obj2.addProgress()
        endif 
    endfunction
    function Play_GoblinBoat_4100 takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(100,1,function Play_GoblinBoat_4200)
        call SetUnitFacingTimed(gg_unit_o601_1039,260,1)
    endfunction
    function Play_GoblinBoat_100 takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(4000,1,function Play_GoblinBoat_4100)
        call IssuePointOrderById(gg_unit_o601_1039,ORDER_move,8220,-30202)
    endfunction
    function Play_GoblinBoat takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(100,1,function Play_GoblinBoat_100)
        local integer i = 0
        call SetUnitX(gg_unit_o601_1039,952)
        call SetUnitY(gg_unit_o601_1039,-28493)
        call BlzSetUnitFacingEx(gg_unit_o601_1039,339)
        call ShowUnit(gg_unit_o601_1039,true)
        loop
            exitwhen i > 4
            call ShowUnit(party[i],false)
            call PauseUnit(party[i],true)
            set i = i+1
        endloop
        call PlaySndEx(SND_LOAD)
        call SetCameraTargetController(gg_unit_o601_1039,0,0,false)
    endfunction
    
    function Play_GoblinBoatBack_101 takes nothing returns nothing
        call QuestAddDialog(sideQuest[43].anotherOwner,'iq0O',1)
    endfunction
    function Play_GoblinBoatBack_100 takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(IMaxBJ(1,30000+lastSummonHydra-globalNowtime),1,function Play_GoblinBoatBack_101)
        local integer i = 0
        call CinematicFadeBJ( bj_CINEFADETYPE_FADEIN, 1.00, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 0, 0, 0, 0 )
        loop
            exitwhen i > 4
            call SetUnitX(party[i],GetRandomReal(576,960))
            call SetUnitY(party[i],GetRandomReal(-26528,-26144))
            set i = i+1
        endloop
        call SetCameraPosition(768,-26336)
    endfunction

    function QuestTrig0_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IQ2L' then 
            call DisableTrigger(GetTriggeringTrigger())
            set EnterDungeon03.active = true 
            call delayedHint("|cffadadff提示：|r现在可以进入冥火石窟了。",200)
        endif 
    endfunction
    function QuestTrig1_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IQ2N' then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetPlayerTechResearched(Player(2),'R603',1)
        endif 
    endfunction
    function QuestTrig2_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'IQ3M' then 
            call DisableTrigger(GetTriggeringTrigger())
            call QuestRemoveDialog(sideQuest[43].anotherOwner,'IQ3M')
            call Play_GoblinBoat.execute()
            call sideQuest[43].obj1.addProgress()
        endif 
    endfunction
    function QuestTrig3_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'iq0O' then 
            call QuestRemoveDialog(sideQuest[43].anotherOwner,'iq0O')
            call Play_GoblinBoat.execute()
        endif 
    endfunction
    function QuestTrig4_Action takes nothing returns nothing
        local delayedevent de = 0
        if GetItemTypeId(GetManipulatedItem()) == 'iq0P' then 
            call CinematicFadeBJ( bj_CINEFADETYPE_FADEOUT, 1.00, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 0, 0, 0, 0 )
            set de = CreateDelayedEvent(100,1,function Play_GoblinBoatBack_100)
        endif 
    endfunction

    function unlockReviveStone1_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0829,PLAYER,true)
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_1",1)
            call AddUnitAnimationProperties(gg_unit_hAVT_0829,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0829,174,174,255,255)
        endif 
    endfunction
    function unlockReviveStone2_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0830,PLAYER,true)
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_2",1)
            call AddUnitAnimationProperties(gg_unit_hAVT_0830,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0830,174,174,255,255)
        endif 
    endfunction
    function unlockReviveStone3_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0831,PLAYER,true)
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_3",1)
            call AddUnitAnimationProperties(gg_unit_hAVT_0831,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0831,174,174,255,255)
        endif 
    endfunction
    function unlockReviveStone4_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0832,PLAYER,true)
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_4",1)
            call AddUnitAnimationProperties(gg_unit_hAVT_0832,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0832,174,174,255,255)
        endif 
    endfunction
    function unlockReviveStone5_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0833,PLAYER,true)
            call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_5",1)
            call AddUnitAnimationProperties(gg_unit_hAVT_0833,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0833,174,174,255,255)
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
            if GetUnitTypeId(GetTriggerUnit()) == 'hN18' and GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") != 0 then 
                call ForGroup(allInns,function resetInnsSelected)
                call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME",0)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl",GetTriggerUnit(),"origin"))
                call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00绑定旅店：避风港湾|r")
                call SetUnitOwner(gg_unit_ugol_0567,Player(2),true)
            elseif GetUnitTypeId(GetTriggerUnit()) == 'hN19' and GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") != 1 then 
                call ForGroup(allInns,function resetInnsSelected)
                call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME",1)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl",GetTriggerUnit(),"origin"))
                call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00绑定旅店：繁盛哨所|r")
                call SetUnitOwner(gg_unit_ugol_0568,Player(2),true)
            elseif GetUnitTypeId(GetTriggerUnit()) == 'hN1W' and GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") != 1 then 
                call ForGroup(allInns,function resetInnsSelected)
                call StoreInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME",2)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl",GetTriggerUnit(),"origin"))
                call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00绑定旅店：沙漠之星度假区|r")
                call SetUnitOwner(gg_unit_ugol_1042,Player(2),true)
            endif 
        endif 
    endfunction

    function DelayedSummonHydra takes nothing returns nothing
        call BossAncientHydra_boss.initialize()
        call BossAncientHydra_boss.activate()
        call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl",GetUnitX(BossAncientHydra_boss.u[0]),GetUnitY(BossAncientHydra_boss.u[0])))
    endfunction
    function SummonHydra_SFX takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        if ModuloInteger(de.loopCount,2) == 0 then 
            set y = y-75
        else 
            set y = y+75
        endif 
        call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl",x,y))
        set x = x-150
        call de.saveReal("X",x)
    endfunction
    function SummonHydra takes nothing returns nothing
        local delayedevent de = 0
        local boolean summon = false 
        local group pick = null 
        if sideQuest[43].state == QUEST_STATE_NONE then 
            return 
        endif 
        if lastSummonHydra > 0 and globalNowtime-lastSummonHydra < 30000 then 
            return 
        endif 

        set pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,gg_rct_HydraSummonArea,playerHero)
        if CountUnitsInGroup(pick) > 0 then 
            set summon = true 
        endif 
        call DestroyGroup(pick)
        set pick = null 
        if summon then 
            call PauseTimer(timerSummonHydra)
            set de = CreateDelayedEvent(20,8,function SummonHydra_SFX)
            call de.saveReal("X",13424)
            call de.saveReal("Y",-30182)
            call de.addOnEnd(function DelayedSummonHydra)
        endif 
        call PauseUnit(gg_unit_o602_1040,true)
    endfunction

    private function init takes nothing returns nothing
        
        set QuestTrig[0] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[0],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[0],function QuestTrig0_Action)
        set QuestTrig[1] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[1],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[1],function QuestTrig1_Action)
        set QuestTrig[2] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[2],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[2],function QuestTrig2_Action)
        set QuestTrig[3] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[3],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[3],function QuestTrig3_Action)
        set QuestTrig[4] = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(QuestTrig[4],EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddActionEx(QuestTrig[4],function QuestTrig4_Action)

        call TriggerRegisterAnyUnitEventBJ(bindHearthStone,EVENT_PLAYER_UNIT_SELL_ITEM)
        call TriggerAddAction(bindHearthStone,function bindHearthStone_Action)

        call TriggerRegisterUnitInRangeSimple(unlockReviveStone1,350,gg_unit_hAVT_0829)
        call TriggerAddAction(unlockReviveStone1,function unlockReviveStone1_Action)
        call TriggerRegisterUnitInRangeSimple(unlockReviveStone2,350,gg_unit_hAVT_0830)
        call TriggerAddAction(unlockReviveStone2,function unlockReviveStone2_Action)
        call TriggerRegisterUnitInRangeSimple(unlockReviveStone3,350,gg_unit_hAVT_0831)
        call TriggerAddAction(unlockReviveStone3,function unlockReviveStone3_Action)
        call TriggerRegisterUnitInRangeSimple(unlockReviveStone4,350,gg_unit_hAVT_0832)
        call TriggerAddAction(unlockReviveStone4,function unlockReviveStone4_Action)
        call TriggerRegisterUnitInRangeSimple(unlockReviveStone5,350,gg_unit_hAVT_0833)
        call TriggerAddAction(unlockReviveStone5,function unlockReviveStone5_Action)
        
        call AddUnitAnimationProperties(gg_unit_hAVT_0828,"alternate",true)
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_1") > 0 then 
            call DisableTrigger(unlockReviveStone1)
            call SetUnitOwner(gg_unit_hAVT_0829,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0829,"alternate",true)
        endif 
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_2") > 0 then 
            call DisableTrigger(unlockReviveStone2)
            call SetUnitOwner(gg_unit_hAVT_0830,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0830,"alternate",true)
        endif 
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_3") > 0 then 
            call DisableTrigger(unlockReviveStone3)
            call SetUnitOwner(gg_unit_hAVT_0831,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0831,"alternate",true)
        endif 
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_4") > 0 then 
            call DisableTrigger(unlockReviveStone4)
            call SetUnitOwner(gg_unit_hAVT_0832,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0832,"alternate",true)
        endif 
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"REVIVE_STONE_5") > 0 then 
            call DisableTrigger(unlockReviveStone5)
            call SetUnitOwner(gg_unit_hAVT_0833,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0833,"alternate",true)
        endif 

    endfunction
endlibrary

library MapLoot initializer init requires MapTrig

    globals 
        LootPool EliteLoot_Common_10
        LootPool EliteLoot_Common_14

        LootPool EliteLoot_Orc
        LootPool EliteLoot_Arachnathid
        LootPool EliteLoot_Razorback
        LootPool EliteLoot_Harpy
        LootPool EliteLoot_Centaur
        LootPool EliteLoot_DragonSpawn
        LootPool EliteLoot_2
        LootPool EliteLoot_3
        LootPool EliteLoot_4

        LootPool BossLoot_1
        LootPool BossLoot_Hydra

        LootPool BossDropPlatinum

        LootPool Loot_Leather_1
        LootPool Loot_Fabric_1
        LootPool Loot_DemonBone
        LootPool Loot_MonsterBlood

        LootPool Loot_Gem_R
        LootPool Loot_Gem_B
        LootPool Loot_Gem_Y
        LootPool Loot_Gem_K
        LootPool Loot_Gem_Level_1

        LootPool Loot_Chest 
    endglobals

    function ENEMY_LOOT_n63L takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Gem_B,0,0.3)
    endfunction
    function ENEMY_LOOT_n633 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Gem_R,0,0.3)
    endfunction
    function ENEMY_LOOT_n634 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Gem_R,0,0.3)
    endfunction
    function ENEMY_LOOT_n63M takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Gem_K,0,0.3)
    endfunction
    function ENEMY_LOOT_n63N takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Gem_Y,0,0.3)
    endfunction

    function ENEMY_LOOT_n630 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.13)
    endfunction
    function ENEMY_LOOT_n631 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.13)
    endfunction
    function ENEMY_LOOT_n632 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.13)
    endfunction
    function ENEMY_LOOT_n63H takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.13)
    endfunction
    function ENEMY_LOOT_n63E takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.13)
    endfunction
    function ENEMY_LOOT_n63D takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Fabric_1,0,0.13)
    endfunction

    function ENEMY_LOOT_n63F takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n63B takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n63A takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,0.15)
    endfunction
    function ENEMY_LOOT_n63T takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,0.3)
    endfunction
    function ENEMY_LOOT_n63U takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Leather_1,0,0.15)
    endfunction

    function UNIT_hMC0_DEATH takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Common_10,1,0.25)
        call EnemyLoot(eventDyingUnit,EliteLoot_Common_14,0,0.25)
        call EnemyLoot(eventDyingUnit,Loot_Chest,0,1)
    endfunction

    function ENEMY_LOOT_n63Q takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_DemonBone,0,0.1)
    endfunction
    function ENEMY_LOOT_n63R takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_DemonBone,0,0.1)
    endfunction
    function ENEMY_LOOT_n61V takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_DemonBone,0,0.1)
    endfunction
    function ENEMY_LOOT_n63S takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Common_14,1,0.25)
        call EnemyLoot(eventDyingUnit,EliteLoot_Orc,0,1)
        call EnemyLoot(eventDyingUnit,Loot_DemonBone,0,1)
    endfunction
    function ENEMY_LOOT_n63C takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Common_10,1,0.25)
        call EnemyLoot(eventDyingUnit,EliteLoot_Arachnathid,0,1)
    endfunction
    function ENEMY_LOOT_n63G takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Common_10,1,0.25)
        call EnemyLoot(eventDyingUnit,EliteLoot_Razorback,0,1)
    endfunction
    function ENEMY_LOOT_n635 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Common_10,1,0.25)
        call EnemyLoot(eventDyingUnit,EliteLoot_Centaur,0,1)
    endfunction
    function ENEMY_LOOT_n639 takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Common_10,1,0.25)
        call EnemyLoot(eventDyingUnit,EliteLoot_Harpy,0,1)
    endfunction
    function ENEMY_LOOT_n63V takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,EliteLoot_Common_14,1,0.25)
        call EnemyLoot(eventDyingUnit,EliteLoot_DragonSpawn,0,1)
    endfunction

    function UNIT_hMO0_DEATH takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Gem_Level_1,0,0.5)
    endfunction
    function UNIT_hMO1_DEATH takes nothing returns nothing
        call EnemyLoot(eventDyingUnit,Loot_Gem_Level_1,0,0.5)
    endfunction

    function DefeatBossHydra takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_Hydra,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)
        call EnemyLoot(eventBoss.u[0],Loot_MonsterBlood,0,1)
        call EnemyLoot(eventBoss.u[0],EliteLoot_Common_14,0,1)
        set lastSummonHydra = globalNowtime
        call TimerStart(timerSummonHydra,0.5,true,function SummonHydra)
        call PauseUnit(gg_unit_o602_1040,false)
    endfunction
    function ResetBossHydra takes nothing returns nothing
        call TimerStart(timerSummonHydra,0.5,true,function SummonHydra)
        call PauseUnit(gg_unit_o602_1040,false)
        call ShowUnit(gg_unit_o602_1040,false)
        call QuestAddDialog(sideQuest[43].anotherOwner,'iq0O',1)
    endfunction
    private function init takes nothing returns nothing
        local LootPool whichPool

        set whichPool = CreateLootPool()
        // region 10 MagicItems
        call whichPool.addItem('I643',4)
        call whichPool.addItem('I644',5)
        call whichPool.addItem('I645',3)
        call whichPool.addItem('I646',4)
        call whichPool.addItem('I647',5)
        call whichPool.addItem('I648',3)
        call whichPool.addItem('I649',4)
        call whichPool.addItem('I64A',5)
        call whichPool.addItem('I64B',3)
        call whichPool.addItem('I64C',4)
        call whichPool.addItem('I64D',5)
        call whichPool.addItem('I64E',3)
        call whichPool.addItem('I64F',4)
        call whichPool.addItem('I64G',5)
        call whichPool.addItem('I64H',3)
        call whichPool.addItem('I64I',4)
        call whichPool.addItem('I64J',5)
        call whichPool.addItem('I64K',3)

        call whichPool.addItem('I663',2)
        call whichPool.addItem('I664',2)
        call whichPool.addItem('I665',2)
        call whichPool.addItem('I666',2)

        call whichPool.addItem('I66J',2)
        call whichPool.addItem('I66K',2)
        call whichPool.addItem('I66L',2)
        call whichPool.addItem('I66M',2)

        call whichPool.addItem('I66Z',6)
        call whichPool.addItem('I670',6)
        call whichPool.addItem('I671',6)

        call whichPool.addItem('I67B',4)
        call whichPool.addItem('I67C',4)
        call whichPool.addItem('I67D',4)
        call whichPool.addItem('I67E',4)
        call whichPool.addItem('I67F',4)
        call whichPool.addItem('I67G',4)
        call whichPool.addItem('I67H',4)
        call whichPool.addItem('I67I',4)

        call whichPool.addItem('I687',2)
        call whichPool.addItem('I688',2)
        call whichPool.addItem('I689',2)
        call whichPool.addItem('I68A',2)
        call whichPool.addItem('I68B',2)
        call whichPool.addItem('I68C',2)
        call whichPool.addItem('I68D',2)
        // endregion 
        set EliteLoot_Common_10 = whichPool

        set whichPool = CreateLootPool()
        // region 14 MagicItems
        call whichPool.addItem('I64L',4)
        call whichPool.addItem('I64M',5)
        call whichPool.addItem('I64N',3)
        call whichPool.addItem('I64O',4)
        call whichPool.addItem('I64P',5)
        call whichPool.addItem('I64Q',3)
        call whichPool.addItem('I64R',4)
        call whichPool.addItem('I64S',5)
        call whichPool.addItem('I64T',3)
        call whichPool.addItem('I64U',4)
        call whichPool.addItem('I64V',5)
        call whichPool.addItem('I64W',3)
        call whichPool.addItem('I64X',4)
        call whichPool.addItem('I64Y',5)
        call whichPool.addItem('I64Z',3)
        call whichPool.addItem('I650',4)
        call whichPool.addItem('I651',5)
        call whichPool.addItem('I652',3)

        call whichPool.addItem('I667',2)
        call whichPool.addItem('I668',2)
        call whichPool.addItem('I669',2)
        call whichPool.addItem('I66A',2)

        call whichPool.addItem('I66N',2)
        call whichPool.addItem('I66O',2)
        call whichPool.addItem('I66P',2)
        call whichPool.addItem('I66Q',2)

        call whichPool.addItem('I672',6)
        call whichPool.addItem('I673',6)
        call whichPool.addItem('I674',6)

        call whichPool.addItem('I67J',4)
        call whichPool.addItem('I67K',4)
        call whichPool.addItem('I67L',4)
        call whichPool.addItem('I67M',4)
        call whichPool.addItem('I67N',4)
        call whichPool.addItem('I67O',4)
        call whichPool.addItem('I67P',4)
        call whichPool.addItem('I67Q',4)

        call whichPool.addItem('I68E',2)
        call whichPool.addItem('I68F',2)
        call whichPool.addItem('I68G',2)
        call whichPool.addItem('I68H',2)
        call whichPool.addItem('I68I',2)
        call whichPool.addItem('I68J',2)
        call whichPool.addItem('I68K',2)
        // endregion 
        set EliteLoot_Common_14 = whichPool


        set whichPool = CreateLootPool()
        call whichPool.addItem(0,73)
        call whichPool.addItem('Ic00',11)
        call whichPool.addItem('Ic01',11)
        call whichPool.addItem('Ic02',11)
        call whichPool.addItem('Ic03',11)
        call whichPool.addItemEx('IML0',5,3)
        call whichPool.addItemEx('IML0',13,2)
        call whichPool.addItemEx('IML0',12,1)
        call whichPool.addItemEx('IMF1',5,3)
        call whichPool.addItemEx('IMF1',13,2)
        call whichPool.addItemEx('IMF1',12,1)
        set Loot_Chest = whichPool

        
        set whichPool = CreateLootPool()
        call whichPool.addItem(0,13)
        call whichPool.addItem('I690',5)
        set EliteLoot_Centaur = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,13)
        call whichPool.addItem('I693',8)
        set EliteLoot_Razorback = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,13)
        call whichPool.addItem('I692',8)
        set EliteLoot_Arachnathid = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,13)
        call whichPool.addItem('I691',8)
        set EliteLoot_Orc = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,13)
        call whichPool.addItem('I68Z',8)
        set EliteLoot_Harpy = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,13)
        call whichPool.addItem('I694',8)
        set EliteLoot_DragonSpawn = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I69P',13)
        call whichPool.addItem('I69Q',13)
        call whichPool.addItem('I69R',13)
        call whichPool.addItem('I69S',7)
        set BossLoot_Hydra = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,7)
        call whichPool.addItem('Ic00',5)
        set Loot_Gem_Y = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,7)
        call whichPool.addItem('Ic01',5)
        set Loot_Gem_B = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,7)
        call whichPool.addItem('Ic02',5)
        set Loot_Gem_K = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,7)
        call whichPool.addItem('Ic03',5)
        set Loot_Gem_R = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,17)
        call whichPool.addItemEx('IML0',5,3)
        call whichPool.addItemEx('IML0',13,2)
        call whichPool.addItemEx('IML0',12,1)
        set Loot_Leather_1 = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,17)
        call whichPool.addItemEx('IMF1',5,3)
        call whichPool.addItemEx('IMF1',13,2)
        call whichPool.addItemEx('IMF1',12,1)
        set Loot_Fabric_1 = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,37)
        call whichPool.addItem('Ic00',10)
        call whichPool.addItem('Ic01',10)
        call whichPool.addItem('Ic02',10)
        call whichPool.addItem('Ic03',10)
        set Loot_Gem_Level_1 = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('IMOZ',10)
        set Loot_DemonBone = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('IM01',10)
        set Loot_MonsterBlood = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('ipl1',13)
        call whichPool.addItem('ipl2',5)
        set BossDropPlatinum = whichPool
    endfunction
endlibrary

library mapscript initializer init requires MapLoot

    globals
        constant integer MAP_INDEX = 2
        trigger swapHero_OutInn = CreateTrigger()
        trigger swapHero_EnterInn = CreateTrigger()

        Entrance EnterIntro
        Entrance EnterDungeon03
        Entrance EnterNardal 

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
                    call SetUnitX(GetTriggerUnit(),GetRandomReal(GetRectMinX(gg_rct_OutInn),GetRectMaxX(gg_rct_OutInn)))
                    call SetUnitY(GetTriggerUnit(),GetRandomReal(GetRectMinY(gg_rct_OutInn),GetRectMaxY(gg_rct_OutInn)))
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
    function initNPCDatas takes nothing returns nothing
        
        call GroupClear(allInns)
        call GroupEnumUnitsInRect(allInns,wholeMapRect,isInnSelected)
        call ForGroup(allInns,function resetInnsSelected)
        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 0 then 
            call SetUnitOwner(gg_unit_ugol_0567,Player(2),true)
        elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 1 then 
            call SetUnitOwner(gg_unit_ugol_0568,Player(2),true)
        elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 2 then 
            call SetUnitOwner(gg_unit_ugol_1042,Player(2),true)
        endif 

        if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"ENTER") == 0 then 
            if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 0 then 
                set loadPartyRect = gg_rct_Home00
            elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 1 then 
                set loadPartyRect = gg_rct_Home01
            elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"HOME") == 2 then 
                set loadPartyRect = gg_rct_Home02
            endif 
        else
            if GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"ENTER") == 1 then 
                set loadPartyRect = gg_rct_LeaveIntro
            elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"ENTER") == 2 then 
                set loadPartyRect = gg_rct_LeaveDungeon3
            elseif GetStoredInteger(gameCache,"MAP_"+I2S(MAP_INDEX),"ENTER") == 3 then 
                set loadPartyRect = gg_rct_LeaveNardal
            endif 
        endif 

        set sideQuest[28].owner = gg_unit_hN1R_0072
        call QuestAddDialog(sideQuest[28].owner,'IQ2C',1)
        call NPC.addExclamation_Y(sideQuest[28].owner)
        set sideQuest[29].owner = gg_unit_hN1R_0072
        set sideQuest[30].owner = gg_unit_hN1R_0072
        set sideQuest[31].owner = gg_unit_hN1R_0072

        set sideQuest[32].owner = gg_unit_hN1L_0972
        call QuestAddDialog(sideQuest[32].owner,'IQ2O',1)
        call NPC.addExclamation_Y(sideQuest[32].owner)
        set sideQuest[33].owner = gg_unit_hN1L_0972

        set sideQuest[34].owner = gg_unit_hN1M_0971
        call QuestAddDialog(sideQuest[34].owner,'IQ2U',1)
        call NPC.addExclamation_Y(sideQuest[34].owner)
        set sideQuest[35].owner = gg_unit_hN1M_0971

        set sideQuest[36].owner = gg_unit_hN1S_0974
        call QuestAddDialog(sideQuest[36].owner,'IQ30',1)
        call NPC.addExclamation_Y(sideQuest[36].owner)
        set sideQuest[37].owner = gg_unit_hN1S_0974
        set sideQuest[38].owner = gg_unit_hN1S_0974

        set sideQuest[39].owner = gg_unit_hN1P_0976
        call QuestAddDialog(sideQuest[39].owner,'IQ39',1)
        call NPC.addExclamation_Y(sideQuest[39].owner)

        set sideQuest[40].owner = gg_unit_hN1O_0502
        call QuestAddDialog(sideQuest[40].owner,'IQ3C',1)
        call NPC.addExclamation_Y(sideQuest[40].owner)
        set sideQuest[41].owner = gg_unit_hN1O_0502
        set sideQuest[42].owner = gg_unit_hN1O_0502
        set sideQuest[43].owner = gg_unit_hN1O_0502
        set sideQuest[43].anotherOwner = gg_unit_hN1Q_0977

        set sideQuest[11].anotherOwner = gg_unit_hN1N_0975

        call ShowUnit(gg_unit_o601_1039,false)
        call ShowUnit(gg_unit_o602_1040,false)
    endfunction
    function initEnvironment takes nothing returns nothing
        local delayedevent de 
        local Boss boss 
        local integer i = 0

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
                call ShowUnit(hero[i],false)
            endif 
            set i = i+1
        endloop
        call ShowUnit(armoury,true)

        if sideQuest[31].state == QUEST_STATE_COMPLETED then 
            call SetPlayerTechResearched(Player(2),'R603',1)
        endif 
        if sideQuest[43].state == QUEST_STATE_COMPLETED then 
            call QuestReplaceDialog(sideQuest[43].anotherOwner,'IQ3M','iq0O',1)
        endif 
        //==================================================
        // region scope BossAncientHydra
        //==================================================
        call BossAncientHydra_boss.setRect(gg_rct_BossAncientHydraArea)
        call BossAncientHydra_boss.addSpawn(BossAncientHydra_bossUnitId,12224,-30182,202)
        set  BossAncientHydra_boss.autoReset = false 
        //call BossAncientHydra_boss.initialize()
        
        call BossAncientHydra_boss.regionAddRect(gg_rct_BossAncientHydraArea)
        call BossAncientHydra_boss.bindOnReset(function ResetBossHydra)
        call BossAncientHydra_boss.bindOnDefeat(function DefeatBossHydra)
        //===================================================
        // endregion
        //===================================================

        set EnterIntro = CreateEntrance(gg_rct_EnterMapIntro,"西海岸","INTRO.w3m",3,1)
        set EnterIntro.active = true
        set EnterDungeon03 = CreateEntrance(gg_rct_EnterDungeon03,"冥火石窟","DUNGEON03.w3m",0,103)
        if GetStoredInteger(gameCache,"KEY",KEY_DUNGEON_NETHERFLAMECAVERN) == 1 then 
            set EnterDungeon03.active = true
        else 
            set EnterDungeon03.active = false 
        endif 
        set EnterNardal = CreateEntrance(gg_rct_EnterNardal,"纳达尔","NARDAL.w3m",0,2)
        set EnterNardal.active = false

        call ResourceType.register('hPO0', 'hMO0', 'IMO0', 9)  // 铁矿
        call ResourceType.register('hPH3', 'hMH3', 'IMH3', 8)  // 阿伽玛甘之牙
        call ResourceType.register('hPH6', 'hMH6', 'IMH6', 8)  // 地根草
        call ResourceType.register('hPHC', 'hMHC', 'IMHC', 8)  // 太阳花
        call ResourceType.register('hPH9', 'hMH9', 'IMH9', 1)  // 黑莲花


        call ResourceType.register('hPC0', 'hMC0', 0, 1)  // 宝箱
        
        call StoreInteger(gameCache,"KEYS","OPEN_MAP_2",1)
        call ShowCustomCampaignButton(true,2)
        
        call TimerStart(timerSummonHydra,0.5,true,function SummonHydra)
    endfunction
    private function init takes nothing returns nothing
        ////////////////////////////////////////////////
        //  need to create below rects in map editor:
        ////////////////////////////////////////////////
        //  need rect : LoadBanks
        //  need rect : LoadArmoury
        //  need rect : Home
        //  need rect : inn
        //  need rect : EnterInn
        //  need rect : OutInn
        ////////////////////////////////////////////////

        local real loadBankLeftX = GetRectMinX(gg_rct_LoadBanks)
        local real loadBankTopY = GetRectMaxY(gg_rct_LoadBanks)
        local real loadBankDis = 96
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
        set loadArmouryX = GetRectMinX(gg_rct_LoadArmoury) 
        set loadArmouryY = GetRectMaxY(gg_rct_LoadArmoury) 

        set loadPartyRect = gg_rct_Home00
        set loadOtherHeroesRect = gg_rct_inn

        call delayedevent.create(1,1,function initNPCDatas)
        call delayedevent.create(10,1,function initEnvironment)

        call AutomaticGate.create( gg_dest_YTce_5517,"death alternate" )
        call AutomaticGate.create( gg_dest_YTce_5518,"death alternate" )

        set MAP_ENEMY_MIN_LEVEL = 10
        //call TriggerRegisterPlayerSelectionEventBJ(swapHero_OutInn,PLAYER,true)
        //call TriggerAddAction(swapHero_OutInn,function OutInnAction)
        //call TriggerRegisterEnterRectSimple(swapHero_EnterInn,gg_rct_EnterInn)
        //call TriggerAddAction(swapHero_EnterInn,function EnterInnAction)
    endfunction
endlibrary

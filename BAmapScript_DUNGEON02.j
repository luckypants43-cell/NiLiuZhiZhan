library MapLoot initializer init requires talentlib 
    globals 
        LootPool BossLoot_TrollAbomination
        LootPool BossLoot_TrollChampionDarkanro
        LootPool BossLoot_TrollNecroShaman
        LootPool BossLoot_TrollKing

        LootPool BossDropPlatinum
        LootPool BossDropPlatinum2
    endglobals

    private function init takes nothing returns nothing
        local LootPool whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I63Z',13)
        call whichPool.addItem('I63R',13)
        call whichPool.addItem('I63U',7)
        set BossLoot_TrollAbomination = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I63R',13)
        call whichPool.addItem('I63S',13)
        call whichPool.addItem('I63X',13)
        call whichPool.addItem('I63U',7)
        set BossLoot_TrollChampionDarkanro = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I63T',13)
        call whichPool.addItem('I63Y',13)
        call whichPool.addItem('I63W',13)
        call whichPool.addItem('I63V',2)
        set BossLoot_TrollNecroShaman = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I640',17)
        call whichPool.addItem('I641',17)
        call whichPool.addItem('I63V',5)
        call whichPool.addItem('I642',7)
        call whichPool.addItem('I63U',8)
        set BossLoot_TrollKing = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('ipl0',13)
        set BossDropPlatinum = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('ipl0',11)
        call whichPool.addItem('ipl1',11)
        set BossDropPlatinum2 = whichPool

    endfunction
endlibrary

library mapscript initializer init requires MapLoot

    globals
        constant integer MAP_INDEX = 102

        integer defeatCount = 0

        trigger trigUnitLeaveHome = CreateTrigger()

        trigger trigUnlockReviveStone1 = CreateTrigger()
        trigger trigUnlockReviveStone2 = CreateTrigger()
        
        trigger backToEntrance = CreateTrigger()
    endglobals
    function backToEntrance_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'iq0Q' then 
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl",GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit())))
            call SetUnitX(GetTriggerUnit(),866)
            call SetUnitY(GetTriggerUnit(),-935)
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl",GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit())))
        endif 
    endfunction
    function DefeatTrollAbomination takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_TrollAbomination,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)

        call GetGateFromDestructable(gg_dest_DTrc_1859).letOpen()
        call GetGateFromDestructable(gg_dest_DTrc_1858).letOpen()
        call GetGateFromDestructable(gg_dest_DTrc_1857).letOpen()
        call GetGateFromDestructable(gg_dest_DTrc_1856).letOpen()
        call GetGateFromDestructable(gg_dest_DTrc_1860).letOpen()
        call GetGateFromDestructable(gg_dest_DTrc_1861).letOpen()
    endfunction
    function DefeatTrollChampionDarkanro takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_TrollChampionDarkanro,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)

        call GetGateFromDestructable(gg_dest_Dofw_0510).letOpen()
    endfunction
    function DefeatTrollNecroShaman takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_TrollNecroShaman,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum2,0,1)
        
        call GetGateFromDestructable(gg_dest_ATg3_0938).letOpen()
    endfunction
    function DefeatTrollKing takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_TrollKing,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum2,0,1)
        if sideQuest[20].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[20].obj1.addProgress()
        endif 

        
        call UnitAddAbilityEx(gg_unit_hN24_0142,'Apit')
        call UnitAddAbilityEx(gg_unit_hN24_0142,'Aneu')
        call TriggerRegisterAnyUnitEventBJ(backToEntrance,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddAction(backToEntrance,function backToEntrance_Action)
    endfunction
    
    function trigUnlockReviveStone1_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0141,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0141,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0141,174,174,255,255)
        endif 
    endfunction

    function initEnvironment takes nothing returns nothing
        local integer i = 0
        local Boss b 

        //==================================================
        // region scope BossTrollAbomination
        //==================================================
        call BossTrollAbomination_bossGateAdd.evaluate( gg_dest_B648_1851 )

        call BossTrollAbomination_boss.setRect(gg_rct_BossTrollAbomination)
        call BossTrollAbomination_boss.addSpawn(BossTrollAbomination_bossUnitId,-194,-1242,10)
        call BossTrollAbomination_boss.initialize()
        
        call BossTrollAbomination_boss.regionAddRect(gg_rct_BossTrollAbomination)

        call BossTrollAbomination_boss.bindOnDefeat(function DefeatTrollAbomination)
        //===================================================
        // endregion
        //===================================================

        //==================================================
        // region scope BossTrollChampionDarkanro
        //==================================================
        call BossTrollChampionDarkanro_bossGateAdd.evaluate(gg_dest_Dofw_1749)

        call BossTrollChampionDarkanro_boss.setRect(gg_rct_BossTrollChampionDarkanro)
        call BossTrollChampionDarkanro_boss.addSpawn(BossTrollChampionDarkanro_bossUnitId,-4807,7999,135)
        call BossTrollChampionDarkanro_boss.initialize()

        call BossTrollChampionDarkanro_boss.regionAddRect(gg_rct_BossTrollChampionDarkanro00)
        call BossTrollChampionDarkanro_boss.regionAddRect(gg_rct_BossTrollChampionDarkanro01)
        call BossTrollChampionDarkanro_boss.regionAddRect(gg_rct_BossTrollChampionDarkanro02)
        call BossTrollChampionDarkanro_boss.regionAddRect(gg_rct_BossTrollChampionDarkanro03)
        call BossTrollChampionDarkanro_boss.regionAddRect(gg_rct_BossTrollChampionDarkanro04)
        call BossTrollChampionDarkanro_boss.regionAddRect(gg_rct_BossTrollChampionDarkanro05)
        call BossTrollChampionDarkanro_boss.regionAddRect(gg_rct_BossTrollChampionDarkanro06)
        call BossTrollChampionDarkanro_boss.regionAddRect(gg_rct_BossTrollChampionDarkanro07)
        call BossTrollChampionDarkanro_boss.regionAddRect(gg_rct_BossTrollChampionDarkanro08)
        call BossTrollChampionDarkanro_boss.regionAddRect(gg_rct_BossTrollChampionDarkanro09)

        call BossTrollChampionDarkanro_boss.bindOnDefeat(function DefeatTrollChampionDarkanro)
        //===================================================
        // endregion
        //===================================================


        //==================================================
        // region scope BossTrollNecroShaman
        //==================================================
        call BossTrollNecroShaman_bossGateAdd.evaluate(gg_dest_ATg1_0939)

        call BossTrollNecroShaman_boss.setRect(gg_rct_BossTrollNecroShaman)
        call BossTrollNecroShaman_boss.addSpawn(BossTrollNecroShaman_bossUnitId,-953,4210,0)
        call BossTrollNecroShaman_boss.initialize()

        call BossTrollNecroShaman_boss.regionAddRect(gg_rct_BossTrollNecroShaman)

        call BossTrollNecroShaman_boss.bindOnDefeat(function DefeatTrollNecroShaman)
        //===================================================
        // endregion
        //===================================================


        //==================================================
        // region scope BossTrollKing
        //==================================================
        call BossTrollKing_bossGateAdd.evaluate(gg_dest_B648_1750)

        call BossTrollKing_boss.setRect(gg_rct_BossTrollKing)
        call BossTrollKing_boss.addSpawn(BossTrollKing_bossUnitId,-261,6268,180)
        call BossTrollKing_boss.initialize()

        call BossTrollKing_boss.regionAddRect(gg_rct_BossTrollKing)

        call BossTrollKing_boss.bindOnDefeat(function DefeatTrollKing)
        //===================================================
        // endregion
        //===================================================
        
        call AutomaticGate.create( gg_dest_DTrc_1859,"death").disable()
        call AutomaticGate.create( gg_dest_DTrc_1861,"death").disable()
        call AutomaticGate.create( gg_dest_DTrc_1858,"death").disable()
        call AutomaticGate.create( gg_dest_DTrc_1860,"death").disable()
        call AutomaticGate.create( gg_dest_DTrc_1856,"death").disable()
        call AutomaticGate.create( gg_dest_DTrc_1857,"death").disable()


        call GetGateFromDestructable(gg_dest_DTrc_1859).letClose()
        call GetGateFromDestructable(gg_dest_DTrc_1858).letClose()
        call GetGateFromDestructable(gg_dest_DTrc_1857).letClose()
        call GetGateFromDestructable(gg_dest_DTrc_1856).letClose()
        call GetGateFromDestructable(gg_dest_DTrc_1860).letClose()
        call GetGateFromDestructable(gg_dest_DTrc_1861).letClose()

        call AutomaticGate.create( gg_dest_Dofw_0510,"death").disable()
        call GetGateFromDestructable(gg_dest_Dofw_0510).letClose()

        call AutomaticGate.create( gg_dest_ATg3_0938,"death").disable()
        call GetGateFromDestructable(gg_dest_ATg3_0938).letClose()
        //===================================================
        // endregion
        //===================================================
        call CreateEntrance(gg_rct_Exit,"西海岸","INTRO.w3m",4,1)
    endfunction
    private function init takes nothing returns nothing
        local integer i = 0
        loop
            exitwhen i > 7
            set loadBankX[i] = 1123
            set loadBankY[i] = -443
            set i = i+1
        endloop
        
        set loadPartyRect = gg_rct_Home00
        set loadOtherHeroesRect = gg_rct_Home00
        set MAP_IS_DUNGEON = true

        call delayedevent.create(10,1,function initEnvironment)

        call TriggerRegisterUnitInRangeSimple(trigUnlockReviveStone1,250,gg_unit_hAVT_0141)
        call TriggerAddAction(trigUnlockReviveStone1,function trigUnlockReviveStone1_Action)
        
        call AddUnitAnimationProperties(gg_unit_hAVT_0005,"alternate",true)

    endfunction

endlibrary
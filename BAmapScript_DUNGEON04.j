library MapLoot initializer init requires talentlib 
    globals 
        LootPool BossLoot_AzureWelpObi
        LootPool BossLoot_AzureLord
        LootPool BossLoot_AzureElderColles
        LootPool BossLoot_AzureGuardian

        LootPool BossDropPlatinum
        LootPool BossDropPlatinum2
    endglobals

    private function init takes nothing returns nothing
        local LootPool whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I63E',9)
        call whichPool.addItem('I63F',9)
        call whichPool.addItem('I63G',9)
        set BossLoot_AzureWelpObi = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I63H',11)
        call whichPool.addItem('I63I',11)
        call whichPool.addItem('I63J',11)
        set BossLoot_AzureLord = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I63K',7)
        call whichPool.addItem('I63L',7)
        call whichPool.addItem('I63M',7)
        set BossLoot_AzureElderColles = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I63E',5)
        call whichPool.addItem('I63F',5)
        call whichPool.addItem('I63G',5)
        call whichPool.addItem('I63H',5)
        call whichPool.addItem('I63I',5)
        call whichPool.addItem('I63J',5)
        call whichPool.addItem('I63K',5)
        call whichPool.addItem('I63L',5)
        call whichPool.addItem('I63M',5)
        call whichPool.addItem('I63N',3)
        call whichPool.addItem('I63O',3)
        call whichPool.addItem('I63P',3)
        call whichPool.addItem('I63Q',3)
        set BossLoot_AzureGuardian = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('ipl0',17)
        call whichPool.addItem('ipl1',5)
        set BossDropPlatinum = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('ipl0',17)
        call whichPool.addItem('ipl1',23)
        set BossDropPlatinum2 = whichPool

    endfunction
endlibrary

library mapscript initializer init requires MapLoot

    globals
        constant integer MAP_INDEX = 104

        integer defeatCount = 0

        trigger trigUnitLeaveHome = CreateTrigger()
        trigger trigEnterBossArea = CreateTrigger()

        trigger trigUnlockReviveStone1 = CreateTrigger()
        trigger trigUnlockReviveStone2 = CreateTrigger()
        
        trigger backToEntrance = CreateTrigger()
    endglobals


    function backToEntrance_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'iq0Q' then 
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl",GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit())))
            call SetUnitX(GetTriggerUnit(),1260)
            call SetUnitY(GetTriggerUnit(),5230)
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl",GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit())))
        endif 
    endfunction
    function DefeatChecker takes nothing returns nothing
        if defeatCount == 3 then 
            call GetGateFromDestructable(gg_dest_B648_0064).letOpen()
            call GetGateFromDestructable(gg_dest_B648_0063).letOpen()
        endif 
    endfunction

    function DefeatAzureWelpObi takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_AzureWelpObi,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)
        set defeatCount = defeatCount+1
        call DefeatChecker()

        call GetGateFromDestructable(gg_dest_B649_0039).letOpen()
    endfunction
    function DefeatAzureLord takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_AzureLord,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)
        set defeatCount = defeatCount+1
        call DefeatChecker()

        call GetGateFromDestructable(gg_dest_B648_0083).letOpen()
    endfunction
    function DefeatAzureElderColles takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_AzureElderColles,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)
        set defeatCount = defeatCount+1
        call DefeatChecker()
    endfunction
    function DefeatAzureGuardian takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_AzureGuardian,1,0.5)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum2,0,1)

        call UnitAddAbilityEx(gg_unit_hN26_0004,'Apit')
        call UnitAddAbilityEx(gg_unit_hN26_0004,'Aneu')
        call TriggerRegisterAnyUnitEventBJ(backToEntrance,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddAction(backToEntrance,function backToEntrance_Action)
    endfunction
    
    
    function trigUnlockReviveStone1_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0003,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0003,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0003,174,174,255,255)
        endif 
    endfunction

    function trigEnterBossArea_Action takes nothing returns nothing
        if IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) then 
            call DisableTrigger(GetTriggeringTrigger())
            call TriggerSleepAction(1.0)
            call PlaySndEx(SND_DING)
            call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00水晶上的雕像似乎活过来了...|r")
            call TriggerSleepAction(3.0)
            call RemoveUnit(gg_unit_n64V_0105)
            call BossAzureGuardian_boss.Enable(true)
            call BossAzureGuardian_forceActiveBoss.execute()
        endif 
    endfunction

    function initEnvironment takes nothing returns nothing
        local integer i = 0
        local Boss b 

        //==================================================
        // region scope BossAzureWelpObi
        //==================================================
        call BossAzureWelpObi_bossGateAdd.evaluate(gg_dest_B648_0038)

        call BossAzureWelpObi_boss.setRect(gg_rct_BossAzureWelpObi)
        call BossAzureWelpObi_boss.addSpawn(BossAzureWelpObi_bossUnitId,1040,10076,233)
        call BossAzureWelpObi_boss.initialize()

        call BossAzureWelpObi_boss.regionAddRect(gg_rct_BossAzureWelpObi)

        call BossAzureWelpObi_boss.bindOnDefeat(function DefeatAzureWelpObi)
        //===================================================
        // endregion
        //===================================================

        //==================================================
        // region scope BossAzureLord
        //==================================================
        call BossAzureLord_bossGateAdd.evaluate(gg_dest_B648_0023)
        call BossAzureLord_bossGateAdd.evaluate(gg_dest_B648_0012)

        call BossAzureLord_boss.setRect(gg_rct_BossAzureLord)
        call BossAzureLord_boss.addSpawn(BossAzureLord_bossUnitId,5079,9116,270)
        call BossAzureLord_boss.initialize()

        call BossAzureLord_boss.regionAddRect(gg_rct_BossAzureLord00)
        call BossAzureLord_boss.regionAddRect(gg_rct_BossAzureLord01)
        call BossAzureLord_boss.regionAddRect(gg_rct_BossAzureLord02)

        call BossAzureLord_boss.bindOnDefeat(function DefeatAzureLord)
        //===================================================
        // endregion
        //===================================================


        //==================================================
        // region scope BossAzureElderColles
        //==================================================
        call BossAzureElderColles_bossGateAdd.evaluate(gg_dest_B649_0041)

        call BossAzureElderColles_boss.setRect(gg_rct_BossAzureElderColles)
        call BossAzureElderColles_boss.addSpawn(BossAzureElderColles_bossUnitId1,10103,5399,200)
        call BossAzureElderColles_boss.addSpawn(BossAzureElderColles_bossUnitId2,10145,6625,270)
        call BossAzureElderColles_boss.initialize()

        call BossAzureElderColles_boss.regionAddRect(gg_rct_BossAzureElderColles00)
        call BossAzureElderColles_boss.regionAddRect(gg_rct_BossAzureElderColles01)
        call BossAzureElderColles_boss.regionAddRect(gg_rct_BossAzureElderColles02)
        call BossAzureElderColles_boss.regionAddRect(gg_rct_BossAzureElderColles03)

        call BossAzureElderColles_boss.bindOnDefeat(function DefeatAzureElderColles)
        //===================================================
        // endregion
        //===================================================

        //==================================================
        // region scope BossAzureGuardian
        //==================================================
        call BossAzureGuardian_bossGateAdd.evaluate(gg_dest_B648_0065)

        call BossAzureGuardian_boss.setRect(gg_rct_BossAzureGuardian)
        call BossAzureGuardian_boss.addSpawn(BossAzureGuardian_bossUnitId,10034,10321,270)
        call BossAzureGuardian_boss.initialize()

        call BossAzureGuardian_boss.regionAddRect(gg_rct_BossAzureGuardian)

        call BossAzureGuardian_boss.bindOnDefeat(function DefeatAzureGuardian)

        call BossAzureGuardian_boss.Enable(false)
        //===================================================
        // endregion
        //===================================================

        
        call AutomaticGate.create(gg_dest_B649_0039,"death").disable()
        call GetGateFromDestructable(gg_dest_B649_0039).letClose()
        call AutomaticGate.create(gg_dest_B648_0083,"death").disable()
        call GetGateFromDestructable(gg_dest_B648_0083).letClose()
        call AutomaticGate.create(gg_dest_B648_0064,"death").disable()
        call GetGateFromDestructable(gg_dest_B648_0064).letClose()
        call AutomaticGate.create(gg_dest_B648_0063,"death").disable()
        call GetGateFromDestructable(gg_dest_B648_0063).letClose()
        //===================================================
        // endregion
        //===================================================
        call CreateEntrance(gg_rct_Exit,"西海岸","INTRO.w3m",1,5)

        set MAP_ENEMY_MIN_LEVEL = IMaxBJ(9,IMinBJ(12,UnitLevel(party[0])-2))
        set Enemy.needReRegister = true 
    endfunction
    private function init takes nothing returns nothing
        local integer i = 0
        loop
            exitwhen i > 7
            set loadBankX[i] = 1633
            set loadBankY[i] = 5202
            set i = i+1
        endloop
        
        set loadPartyRect = gg_rct_Home00
        set loadOtherHeroesRect = gg_rct_Home00
        set MAP_IS_DUNGEON = true

        call delayedevent.create(10,1,function initEnvironment)

        call TriggerRegisterUnitInRangeSimple(trigUnlockReviveStone1,250,gg_unit_hAVT_0003)
        call TriggerAddAction(trigUnlockReviveStone1,function trigUnlockReviveStone1_Action)
        call TriggerRegisterUnitInRangeSimple(trigEnterBossArea,400,gg_unit_n64V_0105)
        call TriggerAddAction(trigEnterBossArea,function trigEnterBossArea_Action)
        call AddUnitAnimationProperties(gg_unit_hAVT_0002,"alternate",true)

    endfunction

endlibrary
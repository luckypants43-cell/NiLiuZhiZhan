library MapLoot initializer init requires talentlib 
    globals 
        LootPool BossLoot_Salamander
        LootPool BossLoot_TheUnquenchable
        LootPool BossLoot_FireLord
        LootPool BossLoot_Common

        LootPool BossDropPlatinum
        LootPool BossDropPlatinum2
    endglobals

    private function init takes nothing returns nothing
        local LootPool whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I634',3)
        call whichPool.addItem('I635',3)
        call whichPool.addItem('I636',3)
        set BossLoot_Salamander = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I637',13)
        call whichPool.addItem('I638',13)
        call whichPool.addItem('I639',13)
        set BossLoot_TheUnquenchable = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,42)
        call whichPool.addItem('I63A',7)
        call whichPool.addItem('I63B',7)
        call whichPool.addItem('I63C',7)
        set BossLoot_FireLord = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I634',5)
        call whichPool.addItem('I635',5)
        call whichPool.addItem('I636',5)
        call whichPool.addItem('I637',5)
        call whichPool.addItem('I638',5)
        call whichPool.addItem('I639',5)
        set BossLoot_Common = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('ipl0',13)
        call whichPool.addItem('ipl1',5)
        set BossDropPlatinum = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('ipl0',11)
        call whichPool.addItem('ipl1',31)
        set BossDropPlatinum2 = whichPool

    endfunction
endlibrary

library mapscript initializer init requires MapLoot

    globals
        constant integer MAP_INDEX = 103

        integer defeatCount = 0

        trigger trigUnitLeaveHome = CreateTrigger()

        trigger trigUnlockReviveStone1 = CreateTrigger()
        trigger trigUnlockReviveStone2 = CreateTrigger()
        
        trigger backToEntrance = CreateTrigger()
    endglobals


    function backToEntrance_Action takes nothing returns nothing
        if GetItemTypeId(GetManipulatedItem()) == 'iq0Q' then 
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl",GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit())))
            call SetUnitX(GetTriggerUnit(),-1101)
            call SetUnitY(GetTriggerUnit(),-2190)
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl",GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit())))
        endif 
    endfunction
    function DefeatChecker takes nothing returns nothing
        if defeatCount == 2 then 
            call GetGateFromDestructable(gg_dest_B648_0360).letOpen()
        endif 
    endfunction

    function DefeatSalamander takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_Salamander,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)
        set defeatCount = defeatCount+1
        call DefeatChecker()
        if sideQuest[31].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[31].obj1.addProgress()
        endif 
    endfunction
    function DefeatTheUnquenchable takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_TheUnquenchable,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)
        set defeatCount = defeatCount+1
        call DefeatChecker()
        if sideQuest[31].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[31].obj2.addProgress()
        endif 
        if sideQuest[33].state == QUEST_STATE_INPROGRESS and sideQuest[33].obj1.completed == false then 
            call CreateItemEx('iq0J',GetUnitX(eventBoss.u[0]),GetUnitY(eventBoss.u[0]))
        endif 
    endfunction
    function DefeatFireLord takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_Common,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossLoot_FireLord,0,0.5)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum2,0,1)
        set defeatCount = defeatCount+1
        call DefeatChecker()
        if sideQuest[31].state == QUEST_STATE_INPROGRESS then 
            call sideQuest[31].obj3.addProgress()
        endif 

        call UnitAddAbilityEx(gg_unit_hN25_0122,'Apit')
        call UnitAddAbilityEx(gg_unit_hN25_0122,'Aneu')
        call TriggerRegisterAnyUnitEventBJ(backToEntrance,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddAction(backToEntrance,function backToEntrance_Action)
    endfunction
    
    function trigUnlockReviveStone1_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0124,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0124,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0124,174,174,255,255)
        endif 
    endfunction
    function trigUnlockReviveStone2_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0125,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0125,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0125,174,174,255,255)
        endif 
    endfunction

    function initEnvironment takes nothing returns nothing
        local integer i = 0
        local Boss b 

        //==================================================
        // region scope BossSalamanderFlameFlash
        //==================================================
        call BossSalamanderFlameFlash_bossGateAdd.evaluate(gg_dest_B648_0359)
        call BossSalamanderFlameFlash_bossGateAdd.evaluate(gg_dest_B649_0367)

        call BossSalamanderFlameFlash_boss.setRect(gg_rct_BossSalamanderFlameFlash)
        call BossSalamanderFlameFlash_boss.addSpawn(BossSalamanderFlameFlash_bossUnitId,-3524,2356,315)
        call BossSalamanderFlameFlash_boss.initialize()
        
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash00)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash01)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash02)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash03)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash04)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash05)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash06)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash07)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash08)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash09)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash10)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash11)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash12)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash13)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash14)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash15)
        call BossSalamanderFlameFlash_boss.regionAddRect(gg_rct_BossSalamanderFlameFlash16)

        call BossSalamanderFlameFlash_boss.bindOnDefeat(function DefeatSalamander)
        //===================================================
        // endregion
        //===================================================

        //==================================================
        // region scope BossTheUnquenchable
        //==================================================
        call BossTheUnquenchable_bossGateAdd.evaluate(gg_dest_B649_0361)
        call BossTheUnquenchable_bossGateAdd.evaluate(gg_dest_B648_0362)

        call BossTheUnquenchable_boss.setRect(gg_rct_BossTheUnquenchable)
        call BossTheUnquenchable_boss.addSpawn(BossTheUnquenchable_bossUnitId,3938,-1760,260)
        call BossTheUnquenchable_boss.addSpawn('n64G',3755,-1804,260)
        call BossTheUnquenchable_boss.initialize()

        call BossTheUnquenchable_boss.regionAddRect(gg_rct_BossTheUnquenchable00)
        call BossTheUnquenchable_boss.regionAddRect(gg_rct_BossTheUnquenchable01)
        call BossTheUnquenchable_boss.regionAddRect(gg_rct_BossTheUnquenchable02)
        call BossTheUnquenchable_boss.regionAddRect(gg_rct_BossTheUnquenchable03)
        call BossTheUnquenchable_boss.regionAddRect(gg_rct_BossTheUnquenchable04)
        call BossTheUnquenchable_boss.regionAddRect(gg_rct_BossTheUnquenchable05)
        call BossTheUnquenchable_boss.regionAddRect(gg_rct_BossTheUnquenchable06)
        call BossTheUnquenchable_boss.regionAddRect(gg_rct_BossTheUnquenchable07)
        call BossTheUnquenchable_boss.regionAddRect(gg_rct_BossTheUnquenchable08)

        call BossTheUnquenchable_boss.bindOnDefeat(function DefeatTheUnquenchable)
        //===================================================
        // endregion
        //===================================================


        //==================================================
        // region scope BossFireLord
        //==================================================
        call BossFireLord_bossGateAdd.evaluate(gg_dest_B649_0365)

        call BossFireLord_boss.setRect(gg_rct_BossFireLord)
        call BossFireLord_boss.addSpawn(BossFireLord_bossUnitId,1315,1009,225)
        call BossFireLord_boss.initialize()

        call BossFireLord_boss.regionAddRect(gg_rct_BossFireLord00)
        call BossFireLord_boss.regionAddRect(gg_rct_BossFireLord01)
        call BossFireLord_boss.regionAddRect(gg_rct_BossFireLord02)
        call BossFireLord_boss.regionAddRect(gg_rct_BossFireLord03)

        call BossFireLord_boss.bindOnDefeat(function DefeatFireLord)
        //===================================================
        // endregion
        //===================================================
        
        call AutomaticGate.create(gg_dest_B648_0360,"death").disable()
        call GetGateFromDestructable(gg_dest_B648_0360).letClose()
        //===================================================
        // endregion
        //===================================================
        call CreateEntrance(gg_rct_Exit,"广大荒漠","DESERT.w3m",2,2)

        set MAP_ENEMY_MIN_LEVEL = IMaxBJ(9,IMinBJ(12,UnitLevel(party[0])-2))
        set Enemy.needReRegister = true 
    endfunction
    private function init takes nothing returns nothing
        local integer i = 0
        loop
            exitwhen i > 7
            set loadBankX[i] = -1299
            set loadBankY[i] = -2214
            set i = i+1
        endloop
        
        set loadPartyRect = gg_rct_Home00
        set loadOtherHeroesRect = gg_rct_Home00
        set MAP_IS_DUNGEON = true

        call delayedevent.create(10,1,function initEnvironment)

        call AddUnitAnimationProperties(gg_unit_hAVT_0000,"alternate",true)

        call TriggerRegisterUnitInRangeSimple(trigUnlockReviveStone1,250,gg_unit_hAVT_0124)
        call TriggerAddAction(trigUnlockReviveStone1,function trigUnlockReviveStone1_Action)
        call TriggerRegisterUnitInRangeSimple(trigUnlockReviveStone2,250,gg_unit_hAVT_0125)
        call TriggerAddAction(trigUnlockReviveStone2,function trigUnlockReviveStone2_Action)
    endfunction

endlibrary
library MapLoot initializer init requires talentlib 
    globals 
        LootPool BossLoot_Banshee
        LootPool BossLoot_CryptLord
        LootPool BossLoot_Abomination
        LootPool BossLoot_DeathKnight

        LootPool BossDropPlatinum
        LootPool BossDropPlatinum2
    endglobals

    private function init takes nothing returns nothing
        local LootPool whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I61P',3)
        call whichPool.addItem('I61T',3)
        call whichPool.addItem('I61X',3)
        set BossLoot_CryptLord = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I61R',13)
        call whichPool.addItem('I61Z',13)
        call whichPool.addItem('I61Y',13)
        set BossLoot_Banshee = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I61Q',7)
        call whichPool.addItem('I61U',7)
        call whichPool.addItem('I61W',7)
        set BossLoot_Abomination = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I61V',11)
        call whichPool.addItem('I622',11)
        call whichPool.addItem('I620',11)
        call whichPool.addItem('I621',11)
        call whichPool.addItem('I61H',7)
        set BossLoot_DeathKnight = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,59)
        call whichPool.addItem('ipl0',13)
        set BossDropPlatinum = whichPool
        set whichPool = CreateLootPool()

        call whichPool.addItem(0,13)
        call whichPool.addItem('ipl0',11)
        set BossDropPlatinum2 = whichPool

    endfunction
endlibrary

library mapscript initializer init requires MapLoot

    globals
        constant integer MAP_INDEX = 101

        integer defeatCount = 0

        trigger trigUnitLeaveHome = CreateTrigger()

        trigger trigUnlockReviveStone1 = CreateTrigger()
        trigger trigUnlockReviveStone2 = CreateTrigger()
    endglobals


    function DefeatChecker takes nothing returns nothing
        if defeatCount == 3 then 
            call GetGateFromDestructable(gg_dest_Dofw_0000).letOpen()
            call GetGateFromDestructable(gg_dest_Dofw_0001).letOpen()
            call GetGateFromDestructable(gg_dest_Dofw_0002).letOpen()
            call GetGateFromDestructable(gg_dest_Dofw_0003).letOpen()
        endif 
    endfunction

    function DefeatCryptLord takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_CryptLord,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)
        set defeatCount = defeatCount+1
        call DefeatChecker()
        if mainQuest[15].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[15].obj2.addProgress()
        endif 
        if mainQuest[15].state == QUEST_STATE_COMPLETED then 
            call CreateItemEx('iq0B',GetUnitX(eventBoss.u[0]),GetUnitY(eventBoss.u[0]))
        endif 
    endfunction
    function DefeatBanshee takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_Banshee,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)
        set defeatCount = defeatCount+1
        call DefeatChecker()
        if mainQuest[15].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[15].obj1.addProgress()
        endif 
        if mainQuest[15].state == QUEST_STATE_COMPLETED then 
            call CreateItemEx('iq0B',GetUnitX(eventBoss.u[0]),GetUnitY(eventBoss.u[0]))
        endif 
    endfunction
    function DefeatButcher takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_Abomination,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum,0,1)
        set defeatCount = defeatCount+1
        call DefeatChecker()
        if mainQuest[15].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[15].obj3.addProgress()
        endif 
        if mainQuest[15].state == QUEST_STATE_COMPLETED then 
            call CreateItemEx('iq0B',GetUnitX(eventBoss.u[0]),GetUnitY(eventBoss.u[0]))
        endif 
    endfunction
    function DefeatDeathKnight takes nothing returns nothing
        call EnemyLoot(eventBoss.u[0],BossLoot_DeathKnight,1,0.25)
        call EnemyLoot(eventBoss.u[0],BossDropPlatinum2,0,1)
        if mainQuest[15].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[15].obj4.addProgress()
        endif 
        if mainQuest[15].state == QUEST_STATE_INPROGRESS and mainQuest[15].obj5.completed == false then 
            call CreateItemEx('iq0A',GetUnitX(eventBoss.u[0]),GetUnitY(eventBoss.u[0]))
        endif 
        if mainQuest[15].state == QUEST_STATE_COMPLETED then 
            call CreateItemEx('iq0B',GetUnitX(eventBoss.u[0]),GetUnitY(eventBoss.u[0]))
        endif 
    endfunction

    function trigUnitLeaveHome_Action takes nothing returns nothing
        if IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) and IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) == false and GetOwningPlayer(GetTriggerUnit()) == PLAYER then 
            call DisableTrigger(GetTriggeringTrigger())
            call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00阿纳克领主：|r有入侵者！消灭他们，把他们的灵魂献给巫妖王！")
            //remove mythic keystone
        endif 
    endfunction
    
    function trigUnlockReviveStone1_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0121,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0121,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0121,174,174,255,255)
        endif 
    endfunction
    function trigUnlockReviveStone2_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0122,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0122,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0122,174,174,255,255)
        endif 
    endfunction

    function initEnvironment takes nothing returns nothing
        local integer i = 0
        local Boss b 

        //==================================================
        // region scope BossCryptLordAno
        //==================================================
        call BossCryptLordAno_bossGateAdd.evaluate(gg_dest_DTg1_0113)
        call BossCryptLordAno_bossGateAdd.evaluate(gg_dest_DTg3_0112)

        call BossCryptLordAno_boss.setRect(gg_rct_BossCryptLordAno)
        call BossCryptLordAno_boss.addSpawn(BossCryptLordAno_bossUnitId,4368,-4624,135)
        call BossCryptLordAno_boss.initialize()
        
        call BossCryptLordAno_boss.regionAddRect(gg_rct_BossCryptLordAno00)
        call BossCryptLordAno_boss.regionAddRect(gg_rct_BossCryptLordAno01)
        call BossCryptLordAno_boss.regionAddRect(gg_rct_BossCryptLordAno02)
        call BossCryptLordAno_boss.regionAddRect(gg_rct_BossCryptLordAno03)
        call BossCryptLordAno_boss.regionAddRect(gg_rct_BossCryptLordAno04)
        call BossCryptLordAno_boss.regionAddRect(gg_rct_BossCryptLordAno05)
        call BossCryptLordAno_boss.regionAddRect(gg_rct_BossCryptLordAno06)
        call BossCryptLordAno_boss.regionAddRect(gg_rct_BossCryptLordAno07)
        call BossCryptLordAno_boss.regionAddRect(gg_rct_BossCryptLordAno08)
        call BossCryptLordAno_boss.regionAddRect(gg_rct_BossCryptLordAno09)
        call BossCryptLordAno_boss.regionAddRect(gg_rct_BossCryptLordAno10)

        call BossCryptLordAno_boss.bindOnDefeat(function DefeatCryptLord)
        //===================================================
        // endregion
        //===================================================

        //==================================================
        // region scope BossBansheeLadyViconia
        //==================================================
        call BossBansheeLadyViconia_bossGateAdd.evaluate(gg_dest_DTg1_0117)
        call BossBansheeLadyViconia_bossGateAdd.evaluate(gg_dest_DTg3_0116)

        call BossBansheeLadyViconia_boss.setRect(gg_rct_BossBansheeLadyViconia)
        call BossBansheeLadyViconia_boss.addSpawn(BossBansheeLadyViconia_bossUnitId,-4256,4112,310)
        call BossBansheeLadyViconia_boss.initialize()

        call BossBansheeLadyViconia_boss.regionAddRect(gg_rct_BossBansheeLadyViconia00)
        call BossBansheeLadyViconia_boss.regionAddRect(gg_rct_BossBansheeLadyViconia01)
        call BossBansheeLadyViconia_boss.regionAddRect(gg_rct_BossBansheeLadyViconia02)
        call BossBansheeLadyViconia_boss.regionAddRect(gg_rct_BossBansheeLadyViconia03)
        call BossBansheeLadyViconia_boss.regionAddRect(gg_rct_BossBansheeLadyViconia04)
        call BossBansheeLadyViconia_boss.regionAddRect(gg_rct_BossBansheeLadyViconia05)
        call BossBansheeLadyViconia_boss.regionAddRect(gg_rct_BossBansheeLadyViconia06)
        call BossBansheeLadyViconia_boss.regionAddRect(gg_rct_BossBansheeLadyViconia07)
        call BossBansheeLadyViconia_boss.regionAddRect(gg_rct_BossBansheeLadyViconia08)
        call BossBansheeLadyViconia_boss.regionAddRect(gg_rct_BossBansheeLadyViconia09)
        call BossBansheeLadyViconia_boss.regionAddRect(gg_rct_BossBansheeLadyViconia10)

        call BossBansheeLadyViconia_boss.bindOnDefeat(function DefeatBanshee)
        //===================================================
        // endregion
        //===================================================


        //==================================================
        // region scope BossButcher
        //==================================================
        call BossButcher_bossGateAdd.evaluate(gg_dest_DTg1_0114)
        call BossButcher_bossGateAdd.evaluate(gg_dest_DTg3_0115)

        call BossButcher_boss.setRect(gg_rct_BossButcher)
        call BossButcher_boss.addSpawn(BossButcher_bossUnitId,4432,4144,200)
        call BossButcher_boss.initialize()

        call BossButcher_boss.regionAddRect(gg_rct_BossButcher00)
        call BossButcher_boss.regionAddRect(gg_rct_BossButcher01)
        call BossButcher_boss.regionAddRect(gg_rct_BossButcher02)
        call BossButcher_boss.regionAddRect(gg_rct_BossButcher03)
        call BossButcher_boss.regionAddRect(gg_rct_BossButcher04)
        call BossButcher_boss.regionAddRect(gg_rct_BossButcher05)
        call BossButcher_boss.regionAddRect(gg_rct_BossButcher06)
        call BossButcher_boss.regionAddRect(gg_rct_BossButcher07)
        call BossButcher_boss.regionAddRect(gg_rct_BossButcher08)
        call BossButcher_boss.regionAddRect(gg_rct_BossButcher09)
        call BossButcher_boss.regionAddRect(gg_rct_BossButcher10)

        call BossButcher_boss.bindOnDefeat(function DefeatButcher)
        //===================================================
        // endregion
        //===================================================

        //==================================================
        // region scope BossDeathKnightLordAnak
        //==================================================
        call BossDeathKnightLordAnak_bossGateAdd.evaluate(gg_dest_Dofw_0000)
        call BossDeathKnightLordAnak_bossGateAdd.evaluate(gg_dest_Dofw_0001)
        call BossDeathKnightLordAnak_bossGateAdd.evaluate(gg_dest_Dofw_0002)
        call BossDeathKnightLordAnak_bossGateAdd.evaluate(gg_dest_Dofw_0003)
        call BossDeathKnightLordAnak_bossGateAdd.evaluate(gg_dest_Dofw_0004)
        call BossDeathKnightLordAnak_bossGateAdd.evaluate(gg_dest_Dofw_0005)
        call BossDeathKnightLordAnak_bossGateAdd.evaluate(gg_dest_Dofw_0006)
        call BossDeathKnightLordAnak_bossGateAdd.evaluate(gg_dest_Dofw_0007)

        call BossDeathKnightLordAnak_boss.setRect(gg_rct_BossDeathKnightLordAnak)
        call BossDeathKnightLordAnak_boss.regionAddRect(gg_rct_BossDeathKnightLordAnak)
        call BossDeathKnightLordAnak_boss.addSpawn(BossDeathKnightLordAnak_bossUnitId,0,0,260)
        call BossDeathKnightLordAnak_boss.initialize()

        call BossDeathKnightLordAnak_boss.bindOnDefeat(function DefeatDeathKnight)

        
        call AutomaticGate.create(gg_dest_Dofw_0000,"death").disable()
        call AutomaticGate.create(gg_dest_Dofw_0001,"death").disable()
        call AutomaticGate.create(gg_dest_Dofw_0002,"death").disable()
        call AutomaticGate.create(gg_dest_Dofw_0003,"death").disable()
        call GetGateFromDestructable(gg_dest_Dofw_0000).letClose()
        call GetGateFromDestructable(gg_dest_Dofw_0001).letClose()
        call GetGateFromDestructable(gg_dest_Dofw_0002).letClose()
        call GetGateFromDestructable(gg_dest_Dofw_0003).letClose()
        //===================================================
        // endregion
        //===================================================
        call CreateEntrance(gg_rct_Exit,"西海岸","INTRO.w3m",2,1)
    endfunction
    private function init takes nothing returns nothing
        set loadBankX[0] = -3568
        set loadBankY[0] = -3952
        set loadBankX[1] = -3568
        set loadBankY[1] = -3952
        set loadBankX[2] = -3568
        set loadBankY[2] = -3952
        set loadBankX[3] = -3568
        set loadBankY[3] = -3952
        set loadBankX[4] = -3568
        set loadBankY[4] = -3952
        set loadBankX[5] = -3568
        set loadBankY[5] = -3952
        set loadBankX[6] = -3568
        set loadBankY[6] = -3952
        set loadBankX[7] = -3568
        set loadBankY[7] = -3952
        set loadPartyRect = gg_rct_Home00
        set loadOtherHeroesRect = gg_rct_Home00
        set MAP_IS_DUNGEON = true

        call TriggerAddAction(trigUnitLeaveHome,function trigUnitLeaveHome_Action)
        call TriggerRegisterLeaveRectSimple(trigUnitLeaveHome,gg_rct_LeaveHome)

        call delayedevent.create(10,1,function initEnvironment)

        call TriggerRegisterUnitInRangeSimple(trigUnlockReviveStone1,250,gg_unit_hAVT_0121)
        call TriggerAddAction(trigUnlockReviveStone1,function trigUnlockReviveStone1_Action)
        call TriggerRegisterUnitInRangeSimple(trigUnlockReviveStone2,250,gg_unit_hAVT_0122)
        call TriggerAddAction(trigUnlockReviveStone2,function trigUnlockReviveStone2_Action)
        
        call AddUnitAnimationProperties(gg_unit_hAVT_0002,"alternate",true)

    endfunction

endlibrary
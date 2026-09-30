
library MapTrig initializer init requires talentlib 
    globals
        trigger array QuestTrig [50]

        Entrance enterDungeon00 
        Entrance enterDungeon01
        Entrance enterDesert 

        group CinematicGroup1 = CreateGroup()
    endglobals

    function QuestTrig0_Action takes nothing returns nothing
        
    endfunction

    private function init takes nothing returns nothing

    endfunction
endlibrary

library MapLoot initializer init requires MapTrig

    function DefeatBoss takes nothing returns nothing
        set nowBoss = 0
    endfunction

    globals 
        LootPool Loot_Leather_1
        LootPool Loot_Fabric_1
    endglobals

    private function init takes nothing returns nothing
        local LootPool whichPool
        set whichPool = CreateLootPool()
        call whichPool.addItem(0,17)
        call whichPool.addItem('IML0',13)
        set Loot_Leather_1 = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,17)
        call whichPool.addItem('IMF1',11)
        set Loot_Fabric_1 = whichPool
    endfunction
endlibrary

library mapscript initializer init requires MapLoot

    globals
        constant integer MAP_INDEX = 9999
        trigger swapHero_OutInn = CreateTrigger()
        trigger swapHero_EnterInn = CreateTrigger()
        trigger summonBoss = CreateTrigger()
        Boss nowBoss = 0
    endglobals

    function summonBoss_action takes nothing returns nothing
        local string msg = SubString(GetEventPlayerChatString(),3,StringLength(GetEventPlayerChatString()))
        local Boss boss = 0
        if nowBoss > 0 then 
            call nowBoss.executeReset()
            set nowBoss = 0
        endif 
        if msg == "1.1" then 
            set boss = BossBanditGeneralWillad_boss
        endif 
        if msg == "1.2" then 
            set boss = BossOrgeMageTamu_boss
        endif 
        if msg == "1.3" then 
            set boss = BossGroshAndGregory_boss
        endif 
        if msg == "2.1" then 
            set boss = BossBansheeLadyViconia_boss
        endif 
        if msg == "2.2" then 
            set boss = BossCryptLordAno_boss
        endif 
        if msg == "2.3" then 
            set boss = BossButcher_boss
        endif 
        if msg == "2.4" then 
            set boss = BossDeathKnightLordAnak_boss
        endif 
        if msg == "3.1" then 
            set boss = BossSalamanderFlameFlash_boss
        endif 
        if msg == "3.2" then 
            set boss = BossTheUnquenchable_boss
        endif 
        if msg == "3.3" then 
            set boss = BossFireLord_boss
        endif 
        if msg == "4.1" then 
            set boss = BossTrollAbomination_boss
        endif 
        if msg == "4.2" then 
            set boss = BossTrollChampionDarkanro_boss
        endif 
        if msg == "4.3" then 
            set boss = BossTrollNecroShaman_boss
        endif 
        if msg == "4.4" then 
            set boss = BossTrollKing_boss
        endif 
        if msg == "5.1" then 
            set boss = BossAzureWelpObi_boss
        endif 
        if msg == "5.2" then 
            set boss = BossAzureLord_boss
        endif 
        if msg == "5.3" then 
            set boss = BossAzureElderColles_boss
        endif 
        if msg == "5.4" then 
            set boss = BossAzureGuardian_boss
        endif 
        if msg == "99.1" then 
            set boss = BossHellBringer_boss
        endif 
        if msg == "99.2" then 
            set boss = BossAncientHydra_boss
        endif 
        if boss > 0 then 
            set nowBoss = boss 
        else 
            return 
        endif 

        call boss.initialize()
        // runtextmacro RegisterBoss("BossHellBringer")
        // runtextmacro RegisterBoss("BossBanditGeneralWillad")
        // runtextmacro RegisterBoss("BossOrgeMageTamu")
        // runtextmacro RegisterBoss("BossBansheeLadyViconia")
        // runtextmacro RegisterBoss("BossCryptLordAno")
        // runtextmacro RegisterBoss("BossButcher")
        // runtextmacro RegisterBoss("BossDeathKnightLordAnak")
        // runtextmacro RegisterBoss("BossSalamanderFlameFlash")
    endfunction

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

    endfunction

    //! textmacro RegisterBoss takes args
        call $args$_bossGateAdd.evaluate( gg_dest_DTg1_0040 )
        call $args$_bossGateAdd.evaluate( gg_dest_DTg3_0041 )
        call $args$_bossGateAdd.evaluate( gg_dest_DTg1_0056 )
        call $args$_bossGateAdd.evaluate( gg_dest_DTg3_0078 )

        call $args$_boss.setRect(gg_rct_SummonedBoss)
        call $args$_boss.addSpawn($args$_bossUnitId,-704,-1536,90)
        
        set $args$_boss.autoReset = false 

        call $args$_boss.regionAddRect(gg_rct_SummonedBoss)
        
        call $args$_boss.bindOnDefeat(function DefeatBoss)
    //! endtextmacro
    //! textmacro RegisterBossMulti takes args
        call $args$_bossGateAdd.evaluate( gg_dest_DTg1_0040 )
        call $args$_bossGateAdd.evaluate( gg_dest_DTg3_0041 )
        call $args$_bossGateAdd.evaluate( gg_dest_DTg1_0056 )
        call $args$_bossGateAdd.evaluate( gg_dest_DTg3_0078 )

        call $args$_boss.setRect(gg_rct_SummonedBoss)
        call $args$_boss.addSpawn($args$_bossUnitId1,-704,-1536,90)
        call $args$_boss.addSpawn($args$_bossUnitId2,-456,-1536,90)
        call $args$_boss.addSpawn($args$_bossUnitId3,-970,-1536,90)
        call $args$_boss.addSpawn($args$_bossUnitId4,-704,-1725,90)
        
        set $args$_boss.autoReset = false 

        call $args$_boss.regionAddRect(gg_rct_SummonedBoss)
        
        call $args$_boss.bindOnDefeat(function DefeatBoss)
    //! endtextmacro

    private function RegisterAllEquipments takes nothing returns nothing
        local item i = GetEnumItem()
        local real x = GetWidgetX(i)
        local real y = GetWidgetY(i)
        local integer id = GetItemTypeId(i)
        if GetEquipType(id) > 0 then 
            call RemoveItem(i)
            call SetItemPlayer(CreateItemEx(id,x,y),PLAYER,false)
        endif 
        set i = null 
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
                call ShowUnit(hero[i],true)
            endif 
            set i = i+1
        endloop
        call ShowUnit(armoury,true)

        call EnumItemsInRect(wholeMapRect,null,function RegisterAllEquipments)

        //==================================================
        // region scope
        //==================================================
        //! runtextmacro RegisterBoss("BossHellBringer")
        //! runtextmacro RegisterBoss("BossBanditGeneralWillad")
        //! runtextmacro RegisterBoss("BossOrgeMageTamu")
        //! runtextmacro RegisterBossMulti("BossGroshAndGregory")
        //! runtextmacro RegisterBoss("BossBansheeLadyViconia")
        //! runtextmacro RegisterBoss("BossCryptLordAno")
        //! runtextmacro RegisterBoss("BossButcher")
        //! runtextmacro RegisterBoss("BossDeathKnightLordAnak")
        //! runtextmacro RegisterBoss("BossSalamanderFlameFlash")
        //! runtextmacro RegisterBoss("BossTheUnquenchable")
        //! runtextmacro RegisterBoss("BossFireLord")
        //! runtextmacro RegisterBoss("BossTrollAbomination")
        //! runtextmacro RegisterBoss("BossTrollChampionDarkanro")
        //! runtextmacro RegisterBoss("BossTrollNecroShaman")
        //! runtextmacro RegisterBoss("BossTrollKing")
        //! runtextmacro RegisterBoss("BossAncientHydra")
        //! runtextmacro RegisterBoss("BossAzureWelpObi")
        //! runtextmacro RegisterBoss("BossAzureLord")
        //! runtextmacro RegisterBossMulti("BossAzureElderColles")
        //! runtextmacro RegisterBoss("BossAzureGuardian")
        //===================================================
        // endregion
        //===================================================
        call ResourceType.register('hPH0', 'hMH0', 'IMH0', 5)  // 野钢花
        call ResourceType.register('hPH1', 'hMH1', 'IMH1', 5)  // 墓地苔
        call ResourceType.register('hPH2', 'hMH2', 'IMH2', 5)  // 荆棘藻

        call ResourceType.register('hPO0', 'hMO0', 'IMO0', 5)  // 铁矿

        call ResourceType.register('hPC0', 'hMC0', 0, 1)  // 宝箱
    endfunction
    private function init takes nothing returns nothing
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
        set loadPartyRect = gg_rct_Home
        set loadOtherHeroesRect = gg_rct_inn

        
        set GLOBAL_WAR_FORGE_BONUS = 100
        set GLOBAL_WAR_FORGE_RATE = 10

        call delayedevent.create(1,1,function initNPCDatas)
        call delayedevent.create(10,1,function initEnvironment)

        call TriggerRegisterPlayerSelectionEventBJ(swapHero_OutInn,PLAYER,true)
        call TriggerAddAction(swapHero_OutInn,function OutInnAction)
        call TriggerRegisterEnterRectSimple(swapHero_EnterInn,gg_rct_EnterInn)
        call TriggerAddAction(swapHero_EnterInn,function EnterInnAction)

        call TriggerRegisterPlayerChatEvent(summonBoss,PLAYER,"-s ",false)
        call TriggerAddAction(summonBoss,function summonBoss_action)
    endfunction
endlibrary

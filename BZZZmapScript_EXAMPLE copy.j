
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

        //==================================================
        // region scope BossHellBringer
        //==================================================
        
        //===================================================
        // endregion
        //===================================================
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
        set loadPartyRect = gg_rct_Home
        set loadOtherHeroesRect = gg_rct_inn

        call delayedevent.create(1,1,function initNPCDatas)
        call delayedevent.create(10,1,function initEnvironment)

        call TriggerRegisterPlayerSelectionEventBJ(swapHero_OutInn,PLAYER,true)
        call TriggerAddAction(swapHero_OutInn,function OutInnAction)
        call TriggerRegisterEnterRectSimple(swapHero_EnterInn,gg_rct_EnterInn)
        call TriggerAddAction(swapHero_EnterInn,function EnterInnAction)

    endfunction
endlibrary

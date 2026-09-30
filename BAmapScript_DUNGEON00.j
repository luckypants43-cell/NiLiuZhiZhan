library MapLoot initializer init requires talentlib 
    globals 
        LootPool BossLoot_Willad
        LootPool BossLoot_Tamu
        LootPool BossLoot_GroshAndGregory

        LootPool BossDropPlatinum
    endglobals

    private function init takes nothing returns nothing
        local LootPool whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I60V',11)
        call whichPool.addItem('I60W',11)
        call whichPool.addItem('I60Z',11)
        set BossLoot_Willad = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I60T',5)
        call whichPool.addItem('I60U',5)
        call whichPool.addItem('I60Y',5)
        set BossLoot_Tamu = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem('I60X',7)
        call whichPool.addItem('I612',7)
        call whichPool.addItem('I613',7)
        call whichPool.addItem('I616',3)
        set BossLoot_GroshAndGregory = whichPool

        set whichPool = CreateLootPool()
        call whichPool.addItem(0,73)
        call whichPool.addItem('ipl0',5)
        set BossDropPlatinum = whichPool

    endfunction
endlibrary

library mapscript initializer init requires MapLoot

    globals
        constant integer MAP_INDEX = 100

        private group addQuestItem = CreateGroup()

        trigger trigUnitLeaveHome = CreateTrigger()
        
        trigger trigCinematicScene1 = CreateTrigger()
        trigger trigCinematicScene2 = CreateTrigger()

        trigger trigChestLoot = CreateTrigger()

        trigger trigUnlockReviveStone1 = CreateTrigger()
        trigger trigUnlockReviveStone2 = CreateTrigger()
    endglobals

    function trigUnitLeaveHome_Action takes nothing returns nothing
        if IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) and IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) == false and GetOwningPlayer(GetTriggerUnit()) == PLAYER then 
            call DisableTrigger(GetTriggeringTrigger())
            //remove mythic keystone
        endif 
    endfunction
    function Condition_IsPlayer2 takes nothing returns boolean
        return GetOwningPlayer(GetFilterUnit()) == Player(1)
    endfunction
    function Condition_IsPlayer12 takes nothing returns boolean
        return GetOwningPlayer(GetFilterUnit()) == Player(11) or GetOwningPlayer(GetFilterUnit()) == Player(11)
    endfunction
    
    function trigCinematicScene1_Action_Delay_3110 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl",GetUnitX(gg_unit_n61F_0246),GetUnitY(gg_unit_n61F_0246)))
        call SetUnitOwner(gg_unit_n61E_0245,Player(11),false)
        call SetUnitInvulnerable(gg_unit_n61E_0245,false)
        call RemoveUnit(gg_unit_n61F_0246)
        call SetUnitAcquireRange(gg_unit_n61E_0245,2000)
        call CheckPosition(gg_unit_n61E_0245)
        call IssueNeutralTargetOrderById(Player(11),gg_unit_n61E_0245,ORDER_attack,gg_unit_hN0M_0003)
    endfunction
    function trigCinematicScene1_Action_Delay_2810 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        call PauseUnit(gg_unit_n61F_0246,true)
        call SetUnitInvulnerable(gg_unit_n61F_0246,true)
        call delayedDestroyEffect(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl",gg_unit_n61F_0246,"origin"),300)
        call TimerStart(CreateTimer(),3,false,function trigCinematicScene1_Action_Delay_3110)
    endfunction
    function trigCinematicScene1_Action_Delay_2370 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        call IssueNeutralPointOrderById(NEUTRAL,gg_unit_n61E_0245,ORDER_AImove,-323,2833)
        if DisByUnXY(gg_unit_n61E_0245,-323,2833) > 125 then 
            call TimerStart(CreateTimer(),0.5,false,function trigCinematicScene1_Action_Delay_2370)
        endif 
    endfunction
    function trigCinematicScene1_Action_Delay_2360 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        call delayedDialogMsg(gg_unit_n61F_0246,"|cffffcc00格雷戈里：|r竟然还找来一群废物帮忙，哈哈，看看我的勇士吧。",100)
        call delayedDialogMsg(gg_unit_n61F_0246,"|cffffcc00格雷戈里：|r这里就全都交给你了。",400)
        call delayedDialogMsg(gg_unit_n61E_0245,"|cffffcc00暴掠狼骑兵：|r是，主人。",700)
        call SetUnitOwner(gg_unit_n61E_0245,NEUTRAL,false)
        call SetUnitPosition(gg_unit_n61E_0245,-323,1718)
        call SetUnitX(gg_unit_n61E_0245,-323)
        call SetUnitY(gg_unit_n61E_0245,1718)
        call setCombatTime(gg_unit_n61E_0245,globalNowtime+50000)
        call IssueImmediateOrderById(gg_unit_n61E_0245,ORDER_holdposition)
        call UnitShareVision(gg_unit_n61E_0245,PLAYER,true)
        call TimerStart(CreateTimer(),0.1,false,function trigCinematicScene1_Action_Delay_2370)
        call TimerStart(CreateTimer(),4.5,false,function trigCinematicScene1_Action_Delay_2810)
    endfunction
    function trigCinematicScene1_Action_Delay_1560 takes nothing returns nothing
        local group pick = CreateGroup()
        call DestroyTimer(GetExpiredTimer())
        call GroupEnumUnitsInRect(pick,gg_rct_AllianceTeam,Condition(function Condition_IsPlayer2))
        loop 
            exitwhen FirstOfGroup(pick) == null 
            call SetUnitInvulnerable(FirstOfGroup(pick),false)
            call PauseUnit(FirstOfGroup(pick),false)
            call IssueNeutralPointOrderById(Player(1),FirstOfGroup(pick),ORDER_attack,GetRandomReal(-704,61),GetRandomReal(2752,3168))
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call GroupClear(pick)
        call GroupEnumUnitsInRect(pick,gg_rct_EnemyTeam,Condition(function Condition_IsPlayer12))
        loop 
            exitwhen FirstOfGroup(pick) == null 
            call SetUnitInvulnerable(FirstOfGroup(pick),false)
            call PauseUnit(FirstOfGroup(pick),false)
            call IssueNeutralPointOrderById(Player(11),FirstOfGroup(pick),ORDER_attack,GetRandomReal(-864,224),GetRandomReal(3616,4096))
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call TimerStart(CreateTimer(),8,false,function trigCinematicScene1_Action_Delay_2360)
    endfunction
    function trigCinematicScene1_Action takes nothing returns nothing
        if IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO) and IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) == false and GetOwningPlayer(GetTriggerUnit()) == PLAYER then 
            call DisableTrigger(GetTriggeringTrigger())
            //cinema scene 1
            //call KillUnit( gg_unit_hN0M_0003 )
            //call KillUnit( gg_unit_n61F_0246 )
            call UnitShareVision(gg_unit_hN0M_0003,PLAYER,true)
            call UnitShareVision(gg_unit_n61F_0246,PLAYER,true)
            call delayedDialogMsg(gg_unit_hN0M_0003,"|cffffcc00奥克兰.赫德：|r叛徒，我希望你能知道悔过。",100)
            call delayedDialogMsg(gg_unit_n61F_0246,"|cffffcc00格雷戈里：|r算了吧，老家伙。在这里，我找到了新的盟友和主人，应该悔过的是你！",400)
            call delayedDialogMsg(gg_unit_hN0M_0003,"|cffffcc00奥克兰.赫德：|r真不知道你是着了什么魔，但是在这里绝对不允许你们捣乱。",800)
            call delayedDialogMsg(gg_unit_n61F_0246,"|cffffcc00格雷戈里：|r快放马过来吧，主人赐予了我新的力量，你们，受死吧！",1200)
            call delayedDialogMsg(gg_unit_hN0M_0003,"|cffffcc00奥克兰.赫德：|r我们的增援来了！侍卫们，准备战斗！",1500)
            call delayedDialogMsg(gg_unit_n61F_0246,"|cffffcc00格雷戈里：|r上，干掉他们！",1550)
            call AddDualBuff(gg_unit_n61F_0246)
            call AddDualBuff(gg_unit_hN0M_0003)
            call Taunt(gg_unit_n61F_0246,gg_unit_hN0M_0003)
            call Taunt(gg_unit_hN0M_0003,gg_unit_n61F_0246)
            call TimerStart(CreateTimer(),15.6,false,function trigCinematicScene1_Action_Delay_1560)
        endif 
    endfunction

    function trigCinematicScene2_Action takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        //cinema scene 
        call IssueNeutralImmediateOrderById(Player(1),gg_unit_hN0M_0003,ORDER_stop)
        call delayedDialogMsg(gg_unit_hN0M_0003,"|cffffcc00奥克兰.赫德：|r又是这种硫磺的恶臭...看来幕后主使还没有走远。",100)
        call delayedDialogMsg(gg_unit_hN0M_0003,"|cffffcc00奥克兰.赫德：|r你们的增援正是时候，代我巡视整个监狱，挫败这群叛徒的阴谋。",400)
        call GetGateFromDestructable(gg_dest_YTce_0303).enable()
    endfunction

    function trigUnlockReviveStone1_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 and BossBanditGeneralWillad_boss.defeat then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0017,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0017,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0017,174,174,255,255)
        endif 
    endfunction
    function trigUnlockReviveStone2_Action takes nothing returns nothing
        if GetPartyIndex(GetTriggerUnit()) > -1 and BossOrgeMageTamu_boss.defeat then 
            call DisableTrigger(GetTriggeringTrigger())
            call SetUnitOwner(gg_unit_hAVT_0016,PLAYER,true)
            call AddUnitAnimationProperties(gg_unit_hAVT_0016,"alternate",true)
            call UnitAddIndicator(gg_unit_hAVT_0016,174,174,255,255)
        endif 
    endfunction

    function DefeatWillad takes nothing returns nothing
        call GetGateFromDestructable(gg_dest_DTg5_0293).forceOpen()
        call EnemyLoot(eventBoss.u[0],BossLoot_Willad,1,0.25)
    endfunction
    function DefeatTamu takes nothing returns nothing
        call GetGateFromDestructable(gg_dest_DTg5_0306).forceOpen()
        call GetGateFromDestructable(gg_dest_DTg7_0290).forceOpen()
        call EnemyLoot(eventBoss.u[0],BossLoot_Tamu,1,0.25)
    endfunction
    function trigCinematicScene3_Action_Delay_780 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl",GetUnitX(gg_unit_n615_0049),GetUnitY(gg_unit_n615_0049)))
        call RemoveUnit(gg_unit_n615_0049)
        call ShowUnit(gg_unit_hCST_0258,true)
        call PauseUnit(gg_unit_hCST_0258,false)
        call SetUnitX(gg_unit_hCST_0258,-2531)
        call SetUnitY(gg_unit_hCST_0258,1479)
    endfunction
    function trigCinematicScene3_Action_Delay_480 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        call SetUnitAnimation(gg_unit_n615_0049,"spell slam")
        call delayedDestroyEffect(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl",gg_unit_n61F_0246,"origin"),300)
        call TimerStart(CreateTimer(),3,false,function trigCinematicScene3_Action_Delay_780)
    endfunction
    function trigChestLoot_Action takes nothing returns nothing
        call EnemyLoot(GetTriggerUnit(),BossLoot_GroshAndGregory,1,0.25)
        call EnemyLoot(GetTriggerUnit(),BossDropPlatinum,0,1)
    endfunction
    function DefeatGrosh takes nothing returns nothing
        call GetGateFromDestructable(gg_dest_YTcx_0302).forceOpen()
        call ShowUnit(gg_unit_n615_0049,true)
        call UnitShareVision(gg_unit_n615_0049,PLAYER,true)
        call delayedDialogMsg(gg_unit_n615_0049,"|cffffcc00恶魔的身影：|r真是没用的家伙，你们的死一文不值。",100)
        call delayedDialogMsg(gg_unit_n615_0049,"|cffffcc00恶魔的身影：|r愚蠢的凡人还不知道自己即将大祸临头。",400)
        call delayedDialogMsg(gg_unit_n615_0049,"|cffffcc00恶魔的身影：|r来吧，来诺森德，为你们的旅程画上句号。",700)
        call TimerStart(CreateTimer(),4.8,false,function trigCinematicScene3_Action_Delay_480)
        if mainQuest[11].state == QUEST_STATE_INPROGRESS then 
            call mainQuest[11].obj1.addProgress()
        endif 
    endfunction

    function initEnvironment takes nothing returns nothing
        local integer i = 0
        local Boss b 
        local unit uu = null 

        //==================================================
        // region scope BossBanditGeneralWillad
        //==================================================
        call BossBanditGeneralWillad_bossGateAdd.evaluate( gg_dest_DTg5_0294 )

        call BossBanditGeneralWillad_boss.setRect(gg_rct_WilladWholeRect)
        call BossBanditGeneralWillad_boss.addSpawn(BossBanditGeneralWillad_bossUnitId,4150,-3657,90)
        call BossBanditGeneralWillad_boss.addSpawn('n61D',3936,-3657,80)
        call BossBanditGeneralWillad_boss.addSpawn('n61D',4384,-3657,100)
        call BossBanditGeneralWillad_boss.initialize()
        
        call BossBanditGeneralWillad_boss.regionAddRect(gg_rct_Willad1)
        call BossBanditGeneralWillad_boss.regionAddRect(gg_rct_Willad2)
        
        call BossBanditGeneralWillad_boss.bindOnDefeat(function DefeatWillad)
        //===================================================
        // endregion
        //===================================================

        //==================================================
        // region scope BossOrgeMageTamu
        //==================================================
        call BossOrgeMageTamu_bossGateAdd.evaluate(gg_dest_DTg7_0291)

        call BossOrgeMageTamu_boss.setRect(gg_rct_TamuWholeRect)
        call BossOrgeMageTamu_boss.addSpawn(BossOrgeMageTamu_bossUnitId,-347,-3329,270)
        call BossOrgeMageTamu_boss.addSpawn('n61C',-544,-3399,300)
        call BossOrgeMageTamu_boss.addSpawn('n61C',-96,-3399,240)
        call BossOrgeMageTamu_boss.initialize()

        call BossOrgeMageTamu_boss.regionAddRect(gg_rct_Tamu1)
        call BossOrgeMageTamu_boss.regionAddRect(gg_rct_Tamu2)
        call BossOrgeMageTamu_boss.regionAddRect(gg_rct_Tamu3)
        call BossOrgeMageTamu_boss.regionAddRect(gg_rct_Tamu4)

        call BossOrgeMageTamu_boss.bindOnDefeat(function DefeatTamu)
        //===================================================
        // endregion
        //===================================================


        //==================================================
        // region scope BossGroshAndGregory
        //==================================================
        call BossGroshAndGregory_bossGateAdd.evaluate(gg_dest_YTcx_0304)

        call BossGroshAndGregory_boss.setRect(gg_rct_GnGWholeRect)
        call BossGroshAndGregory_boss.addSpawn(BossGroshAndGregory_bossUnitId1,-2696,1923,270)
        call BossGroshAndGregory_boss.addSpawn(BossGroshAndGregory_bossUnitId2,-2347,1923,270)
        call BossGroshAndGregory_boss.initialize()

        call BossGroshAndGregory_boss.regionAddRect(gg_rct_GnG1)
        call BossGroshAndGregory_boss.regionAddRect(gg_rct_GnG2)
        call BossGroshAndGregory_boss.regionAddRect(gg_rct_GnG3)
        call BossGroshAndGregory_boss.regionAddRect(gg_rct_GnG4)
        call BossGroshAndGregory_boss.regionAddRect(gg_rct_GnG5)
        call BossGroshAndGregory_boss.regionAddRect(gg_rct_GnG6)
        call BossGroshAndGregory_boss.regionAddRect(gg_rct_GnG7)

        call BossGroshAndGregory_boss.bindOnDefeat(function DefeatGrosh)
        //===================================================
        // endregion
        //===================================================

        call AutomaticGate.create(gg_dest_YTce_0303,"death alternate").disable()
        call AutomaticGate.create(gg_dest_YTcx_0302,"death alternate").disable()
        call AutomaticGate.create(gg_dest_DTg5_0293,"death alternate").disable()
        call AutomaticGate.create(gg_dest_DTg5_0306,"death alternate").disable()
        call AutomaticGate.create(gg_dest_DTg7_0290,"death alternate").disable()
        call ShowUnit(gg_unit_n615_0049,false)
        call ShowUnit(gg_unit_hCST_0258,false)
        call PauseUnit(gg_unit_hCST_0258,true)
        
        call CreateEntrance(gg_rct_Exit,"西海岸","INTRO.w3m",1,1)

        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0007 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0009 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0012 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0013 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0020 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0021 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0022 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0036 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0023 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0030 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0031 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0034 )
        call GroupAddUnit(addQuestItem,gg_unit_hDMY_0035 )
        if sideQuest[4].state == QUEST_STATE_INPROGRESS or sideQuest[4].state == QUEST_STATE_COMPLETED then 
            set i = 0
            loop 
                exitwhen i > 5
                set uu = GroupPickRandomUnitEx(addQuestItem)
                call CreateItemEx('iq04',GetUnitX(uu),GetUnitY(uu))
                call GroupRemoveUnit(addQuestItem,uu)
                set uu = null 
                set i = i+1
            endloop
        endif 
    endfunction
    private function init takes nothing returns nothing
        local group pick = CreateGroup()
        set loadBankX[0] = 0
        set loadBankY[0] = 0
        set loadBankX[1] = 0
        set loadBankY[1] = 0
        set loadBankX[2] = 0
        set loadBankY[2] = 0
        set loadBankX[3] = 0
        set loadBankY[3] = 0
        set loadBankX[4] = 0
        set loadBankY[4] = 0
        set loadBankX[5] = 0
        set loadBankY[5] = 0
        set loadBankX[6] = 0
        set loadBankY[6] = 0
        set loadBankX[7] = 0
        set loadBankY[7] = 0
        set loadPartyRect = gg_rct_Home
        set loadOtherHeroesRect = gg_rct_Home
        set MAP_IS_DUNGEON = true
        call GroupEnumUnitsInRect(pick,gg_rct_AllianceTeam,Condition(function Condition_IsPlayer2))
        loop 
            exitwhen FirstOfGroup(pick) == null 
            call SetUnitInvulnerable(FirstOfGroup(pick),true)
            call PauseUnit(FirstOfGroup(pick),true)
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call GroupClear(pick)
        call GroupEnumUnitsInRect(pick,gg_rct_EnemyTeam,Condition(function Condition_IsPlayer12))
        loop 
            exitwhen FirstOfGroup(pick) == null 
            call SetUnitInvulnerable(FirstOfGroup(pick),true)
            call PauseUnit(FirstOfGroup(pick),true)
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call SetUnitInvulnerable(gg_unit_n61E_0245,true)

        call TriggerAddAction(trigUnitLeaveHome,function trigUnitLeaveHome_Action)
        call TriggerRegisterLeaveRectSimple(trigUnitLeaveHome,gg_rct_LeaveHome)

        call TriggerRegisterEnterRectSimple(trigCinematicScene1,gg_rct_CinematicZone)
        call TriggerAddAction(trigCinematicScene1,function trigCinematicScene1_Action)

        call TriggerRegisterUnitEvent(trigCinematicScene2,gg_unit_n61E_0245,EVENT_UNIT_DEATH)
        call TriggerAddAction(trigCinematicScene2,function trigCinematicScene2_Action)
        
        call TriggerRegisterUnitEvent(trigChestLoot,gg_unit_hCST_0258,EVENT_UNIT_DEATH)
        call TriggerAddAction(trigChestLoot,function trigChestLoot_Action)

        call delayedevent.create(10,1,function initEnvironment)

        call AddUnitAnimationProperties(gg_unit_hAVT_0001,"alternate",true)

        call TriggerRegisterUnitInRangeSimple(trigUnlockReviveStone1,250,gg_unit_hAVT_0017)
        call TriggerAddAction(trigUnlockReviveStone1,function trigUnlockReviveStone1_Action)
        call TriggerRegisterUnitInRangeSimple(trigUnlockReviveStone2,250,gg_unit_hAVT_0016)
        call TriggerAddAction(trigUnlockReviveStone2,function trigUnlockReviveStone2_Action)

    endfunction

endlibrary
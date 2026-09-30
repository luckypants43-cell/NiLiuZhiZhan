
//======================================================================
// region BossHellBringer
//======================================================================
scope BossHellBringer initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n62E'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [15]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossHellBringer_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
        private boolean             shockWaveCasting        = true
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    //======================================================================
    // 十字穿刺，巨大伤害+击飞+击晕，碾压物理伤害
    //======================================================================
    private function IMPALE_SFX takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local projectile proj = de.loadInteger("PROJ")
        local effect sfx 
        if proj > 0 and proj.dummy != null then 
            set sfx = AddSpecialEffectEX("Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl",GetUnitX(proj.dummy),GetUnitY(proj.dummy))
            call BlzSetSpecialEffectOrientation(sfx,GetUnitFacing(proj.dummy)/57.2956,0,0)
            call DestroyEffectEX(sfx)
            set sfx = null 
        endif
    endfunction
    private function CrossImpale_Execute takes nothing returns nothing
        local real dmg = bossAbilityRealData[3]*bossDamageMultiple
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local group pick = CreateGroup()
        call DestroyEffectEX(de.loadEffect("SFX"))
        call GroupEnumUnitsInRange(pick,x,y,100,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null
            set damageTag_Shadow = true 
            set damageFlag = 'AUdc'
            set damageIsAOE = true 
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl",GetUnitX(FirstOfGroup(pick)),GetUnitY(FirstOfGroup(pick))))
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function IMPALE_HIT takes nothing returns nothing
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        local delayedevent de 
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            call Knockup.create(waveTarget,300,0.8,"")
            set damageFlag = 'AUim' 
            set damageIsAOE = true 
            set damageCrushRate = 1000
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl",GetUnitX(waveTarget),GetUnitY(waveTarget)))
            call applyStun(waveCaster,waveTarget,'ATB0')
            if IsUnitType(waveTarget,UNIT_TYPE_SUMMONED) == false then 
                set de = delayedevent.create(500,1,function CrossImpale_Execute)
                call de.saveReal("X",GetUnitX(waveTarget))
                call de.saveReal("Y",GetUnitY(waveTarget))
                call de.saveEffect("SFX",AddSpecialEffectEX("war3mapimported\\Dark Conversion Classic.mdx",GetUnitX(waveTarget),GetUnitY(waveTarget)))
            endif 
        endif 
    endfunction
    private function spell_CrossImpale_delay25 takes nothing returns nothing
        local integer i = 0
        local delayedevent de 
        local projectile proj 
        local real a 
        loop
            exitwhen i >= 4
            set de = delayedevent.create(15,20,function IMPALE_SFX)
            set a = (GetUnitFacing(bossBindUnit)+90*I2R(i))/57.2956
            set proj = CreateWave(bossBindUnit,GetUnitX(bossBindUnit)+2100*Cos(a),GetUnitY(bossBindUnit)+2100*Sin(a),1000,50,75,"",function IMPALE_HIT,null)
            call de.saveInteger("PROJ",proj)
            call proj.launch()
            set i = i+1
        endloop
    endfunction
    private function spell_CrossImpale takes nothing returns nothing
        local real dis = 50
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        call PauseUnit(bossBindUnit,true)
        call SetUnitTimeScale(bossBindUnit,0.5)
        call SetUnitAnimation(bossBindUnit,"spell")
        loop
            exitwhen dis-1000 > 0 
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl",x+dis*Cos(a),y+dis*Sin(a)))
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl",x+dis*Cos(a+1.5708),y+dis*Sin(a+1.5708)))
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl",x+dis*Cos(a+3.1416),y+dis*Sin(a+3.1416)))
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl",x+dis*Cos(a+4.7124),y+dis*Sin(a+4.7124)))
            set dis = dis+100
        endloop
    endfunction
    //======================================================================
    // 腐臭蜂群，扇形AOE法术伤害，暗影
    //======================================================================
    private function CARRIONSWARM_HIT takes nothing returns nothing
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageTag_Shadow = true 
            set damageFlag = 'AUcs' 
            set damageIsAOE = true 
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl",GetUnitX(waveTarget),GetUnitY(waveTarget)))
        endif 
    endfunction
    private function spell_CarrionSwarm_delay3 takes nothing returns nothing
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local projectile proj = CreateWave(bossBindUnit,GetUnitX(bossBindUnit)+2100*Cos(a),GetUnitY(bossBindUnit)+2100*Sin(a),1100,100,270,"Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmMissile.mdl",function CARRIONSWARM_HIT,null)
        call proj.launch()
    endfunction
    private function spell_CarrionSwarm takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        loop 
            set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[0])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[0]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call BlzSetUnitFacingEx(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[0]))
        call SetUnitAnimation(bossBindUnit,"attack")
        call delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\Sweep_Unholy_Medium.mdx",bossBindUnit,"weapon"),40)
    endfunction
    ////////////////////////////////////////////////////
    //技能：死亡一指，单体大量伤害，打最远
    ////////////////////////////////////////////////////
    private function spell_FingerOfDeath takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[1] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        set bossPlayMan[1] = GetFarthestUnit(bossBindUnit,pick)
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[1]))
        call SetUnitAnimation(bossBindUnit,"spell")
        call delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\Sweep_Chaos_Medium.mdx",bossBindUnit,"weapon"),50)
        call UnitsAddLightningSFX(bossBindUnit,0,0,80,bossPlayMan[1],0,0,30,"AFOD",1.2,0.3,false)
    endfunction
    private function spell_FingerOfDeath_delayed3 takes nothing returns nothing
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        if bossPlayMan[1] == null then 
            return 
        endif 
        set damageTag_Shadow = true 
        set damageFlag = 'Afod'
        call UnitDamageTarget(bossBindUnit,bossPlayMan[1],dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl",bossPlayMan[1],"origin"))
    endfunction

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 38.224    //穿刺伤害
            set bossAbilityRealData[1] = 19.584    //腐臭蜂群伤害
            set bossAbilityRealData[2] = 27.444    //死亡一指伤害
            set bossAbilityRealData[3] = 166.666    //处决伤害

            set boss.timeline = 0
            set boss.timelineMax = 200
            set boss.timelineMin = 0
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(70,function spell_CrossImpale)
            call boss.addTimeline(95,function spell_CrossImpale_delay25)
            call boss.addTimeline(100,function event_ResetPause)

            call boss.addTimeline(140,function spell_CarrionSwarm)
            call boss.addTimeline(143,function spell_CarrionSwarm_delay3)
            call boss.addTimeline(149,function event_ResetPause)

            call boss.addTimeline(180,function spell_FingerOfDeath)
            call boss.addTimeline(183,function spell_FingerOfDeath_delayed3)
            call boss.addTimeline(190,function event_ResetPause)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "地狱使者"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "你的灵魂归我了！"
        set bossChatMsg[3] = "无用的尝试，我永存不灭，我将再度归来。"
        set bossChatMsg[4] = "哈哈哈哈哈..."
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

//======================================================================
// region BossBanditGeneralWillad
//======================================================================
scope BossBanditGeneralWillad initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n603'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossBanditGeneralWillad_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
        private boolean             shockWaveCasting        = true
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================
    private function CHARGE_HIT takes nothing returns nothing
        local projectile proj
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple-10
        if GetOwningPlayer(waveTarget) == PLAYER then 
            set proj = KnockbackTargetEx(waveCaster,waveTarget,200,600,0.05)
            set damageIsAOE = true 
            set damageCrushRate = 1000
            set damageFlag = 'Auco'
            call UnitDamageTarget(bossBindUnit,waveTarget,dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WOOD_LIGHT_BASH)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\StormBolt\\StormBoltMissile.mdl",waveTarget,"chest"))
        endif 
        //("CHARGE_HIT")
    endfunction
    private function CHARGE_END takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple-10
        local real dmg2 = bossAbilityRealData[3]*bossDamageMultiple-10
        if alive(proj.target) and proj.target != null and IsUnitInGroup(proj.target,proj.Wave_Group) == false then 
            call KnockbackTargetEx(proj.source,proj.target,200,600,0.05)
            set damageIsAOE = true 
            set damageCrushRate = 1000
            set damageFlag = 'Auco'
            call UnitDamageTarget(bossBindUnit,proj.target,dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WOOD_LIGHT_BASH)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\StormBolt\\StormBoltMissile.mdl",waveTarget,"chest"))
        endif 
        set damageIsAOE = true 
        set damageCrushRate = 1000
        set damageFlag = 'Auco'
        call UnitDamageTarget(bossBindUnit,proj.target,dmg2,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WOOD_LIGHT_BASH)
        call applyStun(bossBindUnit,proj.target,'ATB1')
        set boss.pauseTL = false 
        call event_ResetPause()
        //("CHARGE_END")
    endfunction
    private function Spell_Charge takes nothing returns nothing
        local projectile proj 
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        loop 
            set bossPlayMan[0] = GetFarthestUnit(bossBindUnit,pick)
            call GroupRemoveUnit(pick,bossPlayMan[0])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[0]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        if bossPlayMan[0] == null or alive(bossPlayMan[0]) == false then 
            return 
        endif 
        set boss.pauseTL = true 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[0]))
        set proj = ChargeUnit(bossBindUnit,bossPlayMan[0],2000,0,100,true,function CHARGE_HIT,function CHARGE_END)
        set proj.IS_WAVE = true 
        set proj.Wave_Radius_Start = 125
        set proj.Wave_Radius_Add = 0
        set proj.bindSFX_0 = AddSpecialEffectTargetEX("war3campImported\\Valiant Charge.mdx",bossBindUnit,"origin")
        call BlzSetSpecialEffectColor(proj.bindSFX_0,150,150,150)
        call SetUnitTimeScale(bossBindUnit,3)
        call SetUnitAnimationByIndex(bossBindUnit,0)
    endfunction

    private function SHOCKWAVE_HIT takes nothing returns nothing
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple-10
        if GetOwningPlayer(waveTarget) == PLAYER then 
            set damageIsAOE = true 
            set damageCrushRate = 1000
            set damageFlag = 'AOsh'
            call UnitDamageTarget(bossBindUnit,waveTarget,dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
        endif 
        //("CHARGE_HIT")
    endfunction
    private function Spell_ShockWave takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        loop 
            set bossPlayMan[1] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[1])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[1]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[1]))
        call SetUnitAnimationByIndex(bossBindUnit,5)
    endfunction
    private function Spell_ShockWave_Delay_5 takes nothing returns nothing
        local projectile proj = projectile.create(bossBindUnit)
        set proj.IS_WAVE = true 
        set proj.Wave_Radius_Start = 125
        set proj.Wave_Radius_Add = 0
        set proj.speed = 1200
        set proj.target_x = GetUnitX(bossBindUnit)+800*Cos(GetUnitFacing(bossBindUnit)/57.2956)
        set proj.target_y = GetUnitY(bossBindUnit)+800*Sin(GetUnitFacing(bossBindUnit)/57.2956)
        call proj.addOnHit(function SHOCKWAVE_HIT)
        set proj.TARGET_LOC = true 
        set proj.LAUNCH_UNIT = true 
        set proj.model_path = "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl" 
        set proj.model_attach = "origin"
        call proj.launch()
    endfunction

    private function Spell_Combo takes nothing returns nothing
        local group pick = null 
        set bossPlayMan[2] = GetUnitTaunter(bossBindUnit)
        if bossPlayMan[2] == null or alive(bossPlayMan[2]) == false then 
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
            loop 
                set bossPlayMan[2] = GroupPickRandomUnitEx(pick)
                call GroupRemoveUnit(pick,bossPlayMan[2])
                exitwhen IsUnitInRegion(boss.region,bossPlayMan[2]) or FirstOfGroup(pick) == null 
            endloop
            call DestroyGroup(pick)
            set pick = null 
        endif 
        if bossPlayMan[2] == null or alive(bossPlayMan[2]) == false then
            return 
        endif 
        call PauseUnit(bossBindUnit,true)
        call UnitChaseTarget(bossBindUnit,bossPlayMan[2],50,1000,true,false,30)
        call SetUnitTimeScale(bossBindUnit,1.67)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[2]))
        call SetUnitAnimation(bossBindUnit,"attack")
    endfunction
    private function Spell_Combo_Delay_3 takes nothing returns nothing
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        if alive(bossPlayMan[2]) and bossPlayMan[2] != null then 
            set damageTag_Attack = true 
            set damageFlag = 'AOcr'
            call UnitDamageTarget(bossBindUnit,bossPlayMan[2],dmg,true,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_METAL_MEDIUM_SLICE)
        endif 
        set bossPlayMan[2] = null 
    endfunction

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 12.224    //冲锋伤害
            set bossAbilityRealData[1] = 18.113    //冲击波伤害
            set bossAbilityRealData[2] = 28.177    //连斩伤害
            set bossAbilityRealData[3] = 22.224    //冲锋目标额外伤害

            set boss.timeline = 0
            set boss.timelineMax = 180
            set boss.timelineMin = 20
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(70,function Spell_ShockWave)
            call boss.addTimeline(75,function Spell_ShockWave_Delay_5)
            call boss.addTimeline(77,function Spell_ShockWave)
            call boss.addTimeline(82,function Spell_ShockWave_Delay_5)
            call boss.addTimeline(84,function Spell_ShockWave)
            call boss.addTimeline(89,function Spell_ShockWave_Delay_5)
            call boss.addTimeline(92,function event_ResetPause)

            call boss.addTimeline(120,function Spell_Charge)

            
            call boss.addTimeline(150,function Spell_Combo)
            call boss.addTimeline(153,function Spell_Combo_Delay_3)
            call boss.addTimeline(154,function Spell_Combo)
            call boss.addTimeline(157,function Spell_Combo_Delay_3)
            call boss.addTimeline(158,function Spell_Combo)
            call boss.addTimeline(161,function Spell_Combo_Delay_3)
            call boss.addTimeline(163,function event_ResetPause)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
            
            call UnitShareVision(boss.u[1], PLAYER, true)
            call PauseUnit(boss.u[1],false)
            call SetUnitInvulnerable(boss.u[1], false)
            call CheckPosition(boss.u[1])
            
            call UnitShareVision(boss.u[2], PLAYER, true)
            call PauseUnit(boss.u[2],false)
            call SetUnitInvulnerable(boss.u[2], false)
            call CheckPosition(boss.u[2])
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "叛将维拉德"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "杂碎，我要把你们的头砍下来当夜壶！"
        set bossChatMsg[3] = "不...怎么可能..."
        set bossChatMsg[4] = "呸，这种杂碎也敢来送死？"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

//======================================================================
// region BossOrgeMageTamu
//======================================================================
scope BossOrgeMageTamu initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n604'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossOrgeMageTamu_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null

        public bufftype BUFFTYPE_IGNITE
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================
    private function IGNITE_DOT takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local unit ds = bf.buffSource
        local unit dt = bf.buffTarget
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple*mybuff.buffTimeScale
        set damageFlag = 'A639'
        set damageTag_Fire = true 
        set damageTag_Ignite = true 
        set damageIsDOT = true 
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        set ds = null 
        set dt = null 
    endfunction
    private function IGNITE_HIT takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local mybuff bf 
        local unit ds = proj.source
        local unit dt = proj.target 
        local real dmg = proj.realData
        local group pick = CreateGroup()
        call proj.applyDamageSet()
        set damageFlag = 'Abof'
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call GroupEnumUnitsInRange(pick,GetUnitX(dt),GetUnitY(dt),200,playerAlly)
        loop 
            exitwhen FirstOfGroup(pick) == null 
            set bf = mybuff.create(ds,FirstOfGroup(pick),BUFFTYPE_IGNITE)
            set bf.bonusAttackSpeed = -2000
            set bf.bonusMoveSpeed_P = -2000
            set bf.lastTime = 2000
            set bf.periodTime = 200
            call bf.addPeriod(function IGNITE_DOT)
            call bf.apply()
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        set ds = null 
        set dt = null 
    endfunction
    private function spell_Ignite takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[0])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[0]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[0]))
        call SetUnitAnimation(bossBindUnit,"attack")
        call delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\Sweep_Fire_Small.mdx",bossBindUnit,"weapon"),100)
    endfunction
    private function spell_Ignite_Delayed_4 takes nothing returns nothing
        local projectile proj
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        if bossPlayMan[0] == null then 
            return 
        endif 
        set proj = CreateProjectileToUnit(bossBindUnit,bossPlayMan[0],900,0.2,"Abilities\\Weapons\\BatTrollMissile\\BatTrollMissile.mdl",function IGNITE_HIT,null)
        set proj.tag_Fire = true 
        set proj.realData = dmg 
        set proj.intData = MAP_EXTRA_LEVEL
        call proj.launch()
    endfunction

    
    private function spell_FireBlast takes nothing returns nothing
        local group pick
        set bossPlayMan[1] = GetUnitTaunter(bossBindUnit)
        if IsUnitInRegion(boss.region,bossPlayMan[1]) == false or bossPlayMan[1] == null or alive(bossPlayMan[1]) == false then 
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,boss.area,playerHero)
            if CountUnitsInGroup(pick) == 0 then 
                call DestroyGroup(pick)
                set pick = null 
                return 
            endif 
            loop 
                set bossPlayMan[1] = GroupPickRandomUnitEx(pick)
                call GroupRemoveUnit(pick,bossPlayMan[1])
                exitwhen IsUnitInRegion(boss.region,bossPlayMan[1]) or FirstOfGroup(pick) == null 
            endloop
            call DestroyGroup(pick)
            set pick = null 
        endif 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[1]))
        call SetUnitAnimation(bossBindUnit,"spell")
    endfunction
    private function spell_FireBlast_Delayed_4 takes nothing returns nothing
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        if bossPlayMan[1] == null then 
            return 
        endif 
        set damageTag_Fire = true 
        set damageFlag = 'Asdg'
        call UnitDamageTarget(bossBindUnit,bossPlayMan[1],dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl",bossPlayMan[1],"origin"))
    endfunction

    ////////////////////////////////////////////////////
    //炎爆术
    ////////////////////////////////////////////////////
    globals 
        private effect bindHandLeft = null 
        private effect bindHandRight = null 
        private Bar bar = 0
    endglobals
    private function PYROBLAST_HIT takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local unit ds = proj.source
        local unit dt = proj.target 
        local real dmg = bossAbilityRealData[3]*bossDamageMultiple-30
        call proj.applyDamageSet()
        set damageFlag = 'S00B'
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl",dt,"origin"))
        set ds = null 
        set dt = null 
    endfunction
    private function spellPyroblast_Delayd_40 takes nothing returns nothing
        local projectile proj
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif
        if GetUnitCurrentOrder(bossBindUnit) == ORDER_channel then 
            set proj = CreateProjectileToUnit(bossBindUnit,bossPlayMan[2],1000,0,"war3campImported\\Firebolt Rough Medium.mdx",function PYROBLAST_HIT,null)
            set proj.tag_Fire = true 
            call proj.launch()
        endif 
    endfunction
    function UNIT_n604_SPELL_READY takes nothing returns nothing
        if castingSpell == 'ABC1' then 
            set boss.pauseTL = true 
            call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,-1)
            call DestroyEffectEX(bindHandLeft)
            call DestroyEffectEX(bindHandRight)
            set bindHandLeft = AddSpecialEffectTargetEX("Environment\\LargeBuildingFire\\LargeBuildingFire2.mdl",bossBindUnit,"hand left")
            set bindHandRight = AddSpecialEffectTargetEX("Environment\\LargeBuildingFire\\LargeBuildingFire2.mdl",bossBindUnit,"hand right")
            call TimerStart(CreateTimer(),4,false,function spellPyroblast_Delayd_40)
            call PlaySndEx(SND_DING)
            set bar = CreateBar(400,1,bossBindUnit)
        endif 
    endfunction
    function UNIT_n604_SPELL_STOP takes nothing returns nothing
        if castingSpell == 'ABC1' then 
            set boss.pauseTL = false
            call event_ResetPause()
            set bossFocusTarget = null
            if bar > 0 then 
                call bar.destroy()
                set bar = 0
            endif 
            if bossBindUnit != null and alive(bossBindUnit) then 
                call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,1)
                //call BJDebugMsg("stop"+I2S(unitGetAllBonusStateValue(bossBindUnit,STATE_IMMUNE_SNARE)))
                call DestroyEffectEX(bindHandLeft)
                call DestroyEffectEX(bindHandRight)
            endif 
        endif 
    endfunction
    private function spell_PyroBlast takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[2] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[2] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[2])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[2]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call removeAllDisabilities(bossBindUnit)
        call UnitAddAbilityEx(bossBindUnit,'ABC1')
        call IssueTargetOrderById(bossBindUnit,ORDER_channel,bossPlayMan[2])
        set bossFocusTarget = bossPlayMan[2]
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget)
    endfunction
    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 10.03  //燃烧命中
            set bossAbilityRealData[1] = 15.23  //燃烧dot
            set bossAbilityRealData[2] = 27.67  //火焰爆轰伤害
            set bossAbilityRealData[3] = 69.87  //炎爆术伤害

            set boss.timeline = 0
            set boss.timelineMax = 220
            set boss.timelineMin = 0
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(60,function spell_FireBlast)
            call boss.addTimeline(64,function spell_FireBlast_Delayed_4)
            call boss.addTimeline(70,function event_ResetPause)

            call boss.addTimeline(90,function spell_Ignite)
            call boss.addTimeline(94,function spell_Ignite_Delayed_4)
            call boss.addTimeline(100,function event_ResetPause)

            call boss.addTimeline(120,function spell_PyroBlast)

            call boss.addTimeline(150,function spell_FireBlast)
            call boss.addTimeline(154,function spell_FireBlast_Delayed_4)
            call boss.addTimeline(156,function spell_FireBlast_Delayed_4)
            call boss.addTimeline(160,function event_ResetPause)

            call boss.addTimeline(195,function spell_Ignite)
            call boss.addTimeline(199,function spell_Ignite_Delayed_4)
            call boss.addTimeline(205,function event_ResetPause)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
            
            call UnitShareVision(boss.u[1], PLAYER, true)
            call PauseUnit(boss.u[1],false)
            call SetUnitInvulnerable(boss.u[1], false)
            call CheckPosition(boss.u[1])
            
            call UnitShareVision(boss.u[2], PLAYER, true)
            call PauseUnit(boss.u[2],false)
            call SetUnitInvulnerable(boss.u[2], false)
            call CheckPosition(boss.u[2])
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "塔穆"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "打...打死你们！"
        set bossChatMsg[3] = ""
        set bossChatMsg[4] = "不堪...堪一击"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)

        set BUFFTYPE_IGNITE = bufftype.create('A639','B63J',false,true,true)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

//======================================================================
// region BossGroshAndGregory
//======================================================================
scope BossGroshAndGregory initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId1              = 'n605'  // 模型ID
        public integer              bossUnitId2              = 'n606'  // 模型ID
        public integer              bossUnitId3              = 0  // 模型ID
        public integer              bossUnitId4              = 0  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindGrosh            = null 
        private unit                bossBindGregory          = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget1         = null 
        private unit                bossFocusTarget2         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossTemplate_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
        
        private integer             killCount               = 0
        private bufftype            BUFFTYPE_HOLYSHIELD
        private bufftype            BUFFTYPE_WRATHOFVENGENCE
        private timer               whirlWindTimer = CreateTimer()
        
        private ChaseTarget ct = 0
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction

    private function event_ResetPause1 takes nothing returns nothing
        set bossFocusTarget1 = null
        call PauseTimer(whirlWindTimer)
        if ct > 0 and ct.chaser != null and ct.chaser == bossBindGrosh then 
            call ct.destroy()
        endif 
        set ct = 0
        if alive(bossBindGrosh) == false or bossBindGrosh == null then 
            return 
        endif 
        call PauseUnit(bossBindGrosh, false)
        call SetUnitTimeScale(bossBindGrosh, 1.0)
        call SetUnitAnimation(bossBindGrosh, "stand")
        call CheckPosition(bossBindGrosh)
    endfunction
    private function event_ResetPause2 takes nothing returns nothing
        set bossFocusTarget2 = null
        if bossBindGregory == null or alive(bossBindGregory) == false then 
            return 
        endif 
        call PauseUnit(bossBindGregory, false)
        call SetUnitTimeScale(bossBindGregory, 1.0)
        call SetUnitAnimation(bossBindGregory, "stand")
        call CheckPosition(bossBindGregory)
    endfunction

    private function event_FocusOnTarget1 takes nothing returns nothing
        if bossFocusTarget1 == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindGrosh, AngleByUnits(bossBindGrosh, bossFocusTarget1))
    endfunction
    private function event_FocusOnTarget2 takes nothing returns nothing
        if bossFocusTarget2 == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindGregory, AngleByUnits(bossBindGregory, bossFocusTarget2))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    ////////////////////////////////////////////////////
    //旋风斩 追人10秒，aoe
    //Playman[0]  RealData[0]
    ////////////////////////////////////////////////////
    private function WhirlWindAOE takes nothing returns nothing
        local group pick = null 
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        if bossBindGrosh == null or alive(bossBindGrosh) == false then 
            call PauseTimer(whirlWindTimer)
            return 
        endif   
        set pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,GetUnitX(bossBindGrosh),GetUnitY(bossBindGrosh),200,playerAlly)
        loop 
            exitwhen FirstOfGroup(pick) == null 
            set damageFlag = 'AOww' 
            set damageIsAOE = true 
            set damageCrushRate = 1000
            call UnitDamageTarget(bossBindGrosh,FirstOfGroup(pick),dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_METAL_MEDIUM_SLICE)
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
    endfunction
    private function spell_WhirlWind takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[0])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[0]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindGrosh,true)
        call SetUnitAnimation(bossBindGrosh,"spin")
        call TimerStart(whirlWindTimer,0.5,true,function WhirlWindAOE)
        set ct = UnitChaseTarget(bossBindGrosh,bossPlayMan[0],100,80,false,true,10000)
    endfunction
    ////////////////////////////////////////////////////
    //连击 格洛什打T3连斩
    //Playman[1]  RealData[1]
    ////////////////////////////////////////////////////
    private function Spell_Combo takes nothing returns nothing
        local group pick = null 
        set bossPlayMan[1] = GetUnitTaunter(bossBindGrosh)
        if bossPlayMan[1] == null or alive(bossPlayMan[1]) == false then 
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
            loop 
                set bossPlayMan[1] = GroupPickRandomUnitEx(pick)
                call GroupRemoveUnit(pick,bossPlayMan[1])
                exitwhen IsUnitInRegion(boss.region,bossPlayMan[1]) or FirstOfGroup(pick) == null 
            endloop
            call DestroyGroup(pick)
            set pick = null 
        endif 
        if bossPlayMan[1] == null or alive(bossPlayMan[1]) == false then
            return 
        endif 
        call PauseUnit(bossBindGrosh,true)
        call UnitChaseTarget(bossBindGrosh,bossPlayMan[1],50,1000,true,false,30)
        call SetUnitTimeScale(bossBindGrosh,1.67)
        call SetUnitFacing(bossBindGrosh,AngleByUnits(bossBindGrosh,bossPlayMan[1]))
        call SetUnitAnimation(bossBindGrosh,"attack")
    endfunction
    private function Spell_Combo_Delay_2 takes nothing returns nothing
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        if alive(bossPlayMan[1]) and bossPlayMan[1] != null then 
            set damageTag_Attack = true 
            set damageFlag = 'AOcr'
            call UnitDamageTarget(bossBindGrosh,bossPlayMan[1],dmg,true,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_METAL_MEDIUM_CHOP)
        endif 
        set bossPlayMan[1] = null 
    endfunction

    ////////////////////////////////////////////////////
    //跳劈 格洛什打T
    //Playman[3]  RealData[3]
    ////////////////////////////////////////////////////
    private function Spell_Slam takes nothing returns nothing
        local group pick = null 
        set bossPlayMan[3] = GetUnitTaunter(bossBindGrosh)
        if bossPlayMan[3] == null or alive(bossPlayMan[3]) == false then 
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
            loop 
                set bossPlayMan[3] = GroupPickRandomUnitEx(pick)
                call GroupRemoveUnit(pick,bossPlayMan[3])
                exitwhen IsUnitInRegion(boss.region,bossPlayMan[3]) or FirstOfGroup(pick) == null 
            endloop
            call DestroyGroup(pick)
            set pick = null 
        endif 
        if bossPlayMan[3] == null or alive(bossPlayMan[3]) == false then
            return 
        endif 
        call PauseUnit(bossBindGrosh,true)
        call ChargeUnit(bossBindGrosh,bossPlayMan[3],1000,0.2,100,false,null,null)
        call SetUnitFacing(bossBindGrosh,AngleByUnits(bossBindGrosh,bossPlayMan[3]))
        call SetUnitAnimation(bossBindGrosh,"attack slam")
        call delayedDestroyEffect(AddSpecialEffectTargetEX("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl",bossBindGrosh,"weapon"),100)
    endfunction
    private function Spell_Slam_Delay_4 takes nothing returns nothing
        local real dmg = bossAbilityRealData[3]*bossDamageMultiple
        if alive(bossPlayMan[3]) and bossPlayMan[3] != null then 
            set damageTag_Fire = true 
            set damageCrushRate = 1000
            set damageFlag = 'AHbh'
            call UnitDamageTarget(bossBindGrosh,bossPlayMan[3],dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_METAL_HEAVY_CHOP)
        endif 
        set bossPlayMan[3] = null 
    endfunction

    ////////////////////////////////////////////////////
    //圣光术 单体伤害或20倍治疗格洛什，读条可打断
    //Playman[2]  RealData[2]
    ////////////////////////////////////////////////////
    globals 
        private Bar bar = 0
    endglobals
    private function spellHolyLight_Delayd_45 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindGregory) == false or bossBindGregory == null then 
            return 
        endif
        call event_ResetPause2()
    endfunction
    private function spellHolyLight_Delayd_35 takes nothing returns nothing
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindGregory) == false or bossBindGregory == null then 
            return 
        endif 
        call TimerStart(CreateTimer(),1,false,function spellHolyLight_Delayd_45)
        if bossPlayMan[2] == bossBindGrosh then 
            set healFlag = 'AHhb' 
            call UnitHealTarget(bossBindGregory,bossPlayMan[2],dmg*10)
        else 
            set damageFlag = 'AHhb' 
            set damageTag_Divine = true 
            call UnitDamageTarget(bossBindGregory,bossPlayMan[2],dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        endif
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl",bossPlayMan[2],"origin"))
    endfunction
    private function spellHolyLight_Immediate_Delayd_5 takes nothing returns nothing
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        if bossPlayMan[2] == bossBindGrosh then 
            set healFlag = 'AHhb' 
            call UnitHealTarget(bossBindGregory,bossPlayMan[2],dmg*10)
        else 
            set damageFlag = 'AHhb' 
            set damageTag_Divine = true 
            call UnitDamageTarget(bossBindGregory,bossPlayMan[2],dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        endif
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl",bossPlayMan[2],"origin"))
    endfunction
    private function spellHolyLight_Delayd_30 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindGregory) == false or bossBindGregory == null then 
            return 
        endif 
        if GetUnitCurrentOrder(bossBindGregory) == ORDER_channel then 
            call SetUnitAnimation(bossBindGregory,"spell")
            call TimerStart(CreateTimer(),0.5,false,function spellHolyLight_Delayd_35)
        endif 
    endfunction
    function UNIT_n606_SPELL_READY takes nothing returns nothing
        if castingSpell == 'ABC2' then 
            set boss.pauseTL = true 
            call unitAddState(bossBindGregory,STATE_IMMUNE_ROOT,-1)
            call unitAddState(bossBindGregory,STATE_IMMUNE_SILENCE,-1)
            call unitAddState(bossBindGregory,STATE_IMMUNE_SNARE,-1)
            call unitAddState(bossBindGregory,STATE_IMMUNE_STUN,-1)
            call TimerStart(CreateTimer(),3,false,function spellHolyLight_Delayd_30)
            call PlaySndEx(SND_DING)
            set bar = CreateBar(300,1,bossBindGregory)
        endif 
    endfunction
    function UNIT_n606_SPELL_STOP takes nothing returns nothing
        if castingSpell == 'ABC2' then 
            set boss.pauseTL = false
            call event_ResetPause2()
            set bossFocusTarget2 = null
            if bar > 0 then 
                call bar.destroy()
                set bar = 0
            endif 
            if bossBindGregory != null and alive(bossBindGregory) then 
                call unitAddState(bossBindGregory,STATE_IMMUNE_ROOT,1)
                call unitAddState(bossBindGregory,STATE_IMMUNE_SILENCE,1)
                call unitAddState(bossBindGregory,STATE_IMMUNE_SNARE,1)
                call unitAddState(bossBindGregory,STATE_IMMUNE_STUN,1)
            endif 
        endif 
    endfunction
    private function spell_HolyLight takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[2] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[2] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[2])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[2]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        if bossBindGrosh != null and alive(bossBindGrosh) and GetUnitLostLife(bossBindGrosh) > 0.2*GetUnitState(bossBindGrosh,UNIT_STATE_MAX_LIFE) then 
            set bossPlayMan[2] = bossBindGrosh
        endif 
        call removeAllDisabilities(bossBindGregory)
        call UnitAddAbilityEx(bossBindGregory,'ABC2')
        call IssueTargetOrderById(bossBindGregory,ORDER_channel,bossPlayMan[2])
        set bossFocusTarget2 = bossPlayMan[2]
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget2)
    endfunction
    private function spell_HolyLight_Immediate takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[2] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[2] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[2])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[2]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindGregory,true)
        call SetUnitAnimation(bossBindGregory,"spell")
        set bossFocusTarget2 = bossPlayMan[2]
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget2)
    endfunction
    //////////////////////////////////////
    //圣盾术 无敌，可驱散
    //////////////////////////////////////
    private function spell_HolyShield takes nothing returns nothing
        call PauseUnit(bossBindGregory,true)
        call SetUnitAnimation(bossBindGregory,"spell")
    endfunction
    private function spell_HolyShield_Delayed_5 takes nothing returns nothing
        local mybuff bf = mybuff.create(bossBindGregory,bossBindGregory,BUFFTYPE_HOLYSHIELD)
        set bf.lastTime = 1000
        set bf.shieldBlockPercent = 1
        set bf.shieldMaxValue = 10000000
        call bf.apply()
    endfunction
    //////////////////////////////////////
    //复仇之怒 强化
    //////////////////////////////////////
    private function WrathOfVengence_Attacked_Source_Delayed takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local unit dt = de.loadUnit("TARGET")
        local real dmg = bossAbilityRealData[4]*bossDamageMultiple
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl",dt,"origin"))
        set damageFlag = 'AHhb' 
        set damageTag_Divine = true 
        call UnitDamageTarget(bossBindGregory,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
    endfunction
    private function WrathOfVengence_Attacked_Source takes nothing returns nothing
        local delayedevent de = delayedevent.create(1,1,function WrathOfVengence_Attacked_Source_Delayed)
        call de.saveUnit("TARGET",damageTarget)
    endfunction
    private function spell_WrathOfVengence takes nothing returns nothing
        local mybuff bf = mybuff.create(bossBindGregory,bossBindGregory,BUFFTYPE_WRATHOFVENGENCE)
        set bf.lastTime = 100000
        set bf.bonusAttack_P = 3000
        set bf.bonusAttackSpeed = 3000
        set bf.bonusMoveSpeed_P = 3000
        call bf.addAtked_S(function WrathOfVengence_Attacked_Source)
        call bf.apply()
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl",bossBindGregory,"origin"))
    endfunction

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindGrosh = boss.u[0]
        set bossBindGregory = boss.u[1]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400,bossBindGrosh)
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400,bossBindGregory)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindGrosh, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindGregory, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)
        
        // 5大免疫
        call unitAddState(bossBindGrosh, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindGrosh, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindGrosh, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindGrosh, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindGrosh, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindGrosh)
        call unitAddState(bossBindGregory, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindGregory, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindGregory, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindGregory, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindGregory, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindGregory)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindGrosh)
        call removeAllDisabilities(bossBindGregory)
        //call BJDebugMsg(I2S(boss.timeline))
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and ((bossBindGrosh != null and alive(bossBindGrosh)) or (bossBindGregory != null and alive(bossBindGregory))) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)
            set killCount = 0

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[IMaxBJ(UnitLevel(bossBindGrosh),UnitLevel(bossBindGregory)) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 9.334 //旋风斩伤害
            set bossAbilityRealData[1] = 18.125 //连击伤害
            set bossAbilityRealData[2] = 26.615 //圣光术伤害
            set bossAbilityRealData[3] = 33.615 //跳斩伤害
            set bossAbilityRealData[4] = 8.225 //复仇之怒圣光伤害

            set boss.timeline = 0
            set boss.timelineMax = 255
            set boss.timelineMin = 20

            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()
            
            //////////////////////
            //P1
            //////////////////////
            call boss.addTimeline(60,function Spell_Combo)
            call boss.addTimeline(62,function Spell_Combo_Delay_2)
            call boss.addTimeline(63,function Spell_Combo)
            call boss.addTimeline(65,function Spell_Combo_Delay_2)
            call boss.addTimeline(66,function Spell_Combo)
            call boss.addTimeline(68,function Spell_Combo_Delay_2)
            call boss.addTimeline(72,function event_ResetPause1)

            call boss.addTimeline(80,function spell_HolyLight)

            call boss.addTimeline(100,function Spell_Combo)
            call boss.addTimeline(102,function Spell_Combo_Delay_2)
            call boss.addTimeline(103,function Spell_Combo)
            call boss.addTimeline(105,function Spell_Combo_Delay_2)
            call boss.addTimeline(106,function Spell_Combo)
            call boss.addTimeline(108,function Spell_Combo_Delay_2)
            call boss.addTimeline(112,function event_ResetPause1)

            call boss.addTimeline(150,function spell_WhirlWind)

            call boss.addTimeline(170,function spell_HolyLight)

            call boss.addTimeline(250,function event_ResetPause1)
            
            //////////////////////
            //P2 格洛什单独
            //min = 300
            //max = 680
            //////////////////////
            call boss.addTimeline(320,function Spell_Combo)
            call boss.addTimeline(322,function Spell_Combo_Delay_2)
            call boss.addTimeline(323,function Spell_Combo)
            call boss.addTimeline(325,function Spell_Combo_Delay_2)
            call boss.addTimeline(326,function Spell_Combo)
            call boss.addTimeline(328,function Spell_Combo_Delay_2)
            call boss.addTimeline(332,function event_ResetPause1)

            
            call boss.addTimeline(360,function spell_WhirlWind)
            call boss.addTimeline(460,function event_ResetPause1)

            
            call boss.addTimeline(480,function Spell_Slam)
            call boss.addTimeline(484,function Spell_Slam_Delay_4)
            call boss.addTimeline(490,function event_ResetPause1)

            call boss.addTimeline(530,function Spell_Combo)
            call boss.addTimeline(532,function Spell_Combo_Delay_2)
            call boss.addTimeline(533,function Spell_Combo)
            call boss.addTimeline(535,function Spell_Combo_Delay_2)
            call boss.addTimeline(536,function Spell_Combo)
            call boss.addTimeline(538,function Spell_Combo_Delay_2)
            call boss.addTimeline(539,function Spell_Combo)
            call boss.addTimeline(541,function Spell_Combo_Delay_2)
            call boss.addTimeline(542,function Spell_Combo)
            call boss.addTimeline(544,function Spell_Combo_Delay_2)
            call boss.addTimeline(548,function event_ResetPause1)

            call boss.addTimeline(560,function spell_WhirlWind)
            call boss.addTimeline(660,function event_ResetPause1)

            //////////////////////
            //P3 格雷戈里单独
            //min = 700
            //max = 900
            //////////////////////
            call boss.addTimeline(710,function spell_HolyLight_Immediate)
            call boss.addTimeline(715,function spellHolyLight_Immediate_Delayd_5)
            call boss.addTimeline(720,function event_ResetPause2)

            call boss.addTimeline(740,function spell_HolyShield)
            call boss.addTimeline(745,function spell_HolyShield_Delayed_5)
            call boss.addTimeline(750,function event_ResetPause2)

            call boss.addTimeline(800,function spell_HolyLight_Immediate)
            call boss.addTimeline(805,function spellHolyLight_Immediate_Delayd_5)
            call boss.addTimeline(810,function event_ResetPause2)


            call boss.activate()
            call UnitShareVision(bossBindGrosh, PLAYER, true)
            call UnitShareVision(bossBindGregory, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, "")
            call SetUnitInvulnerable(bossBindGrosh, false)
            call SetUnitInvulnerable(bossBindGregory, false)
            call event_ResetPause1()
            call event_ResetPause2()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        set killCount = killCount+1
        if killCount >= 2 then 
            call DisableTrigger(activateBoss)
            call DisableTrigger(defeatBoss)
            call boss.executeDefeat()
            if GetTriggerUnit() == bossBindGregory then 
                call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1]+bossChatMsg[6])
            elseif GetTriggerUnit() == bossBindGrosh then 
                call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[3]+bossChatMsg[7])
            endif 
        else 
            if GetTriggerUnit() == bossBindGregory then 
                set boss.pauseTL = false 
                call PauseTimer(whirlWindTimer)
                call CheckPosition(bossBindGrosh)
                set boss.timeline = 295
                set boss.timelineMin = 300
                set boss.timelineMax = 600
                call event_ResetPause1()
                call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[3]+bossChatMsg[5])
            elseif GetTriggerUnit() == bossBindGrosh then 
                set boss.pauseTL = false 
                call CheckPosition(bossBindGregory)
                set boss.timeline = 695
                set boss.timelineMin = 700
                set boss.timelineMax = 900
                call spell_WrathOfVengence() 
                call event_ResetPause2()
                call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1]+bossChatMsg[4])
            endif 
        endif 
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "格雷戈里"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "格洛什"
        set bossChatMsg[3] = "|cffffcc00" + bossChatMsg[2] + "：|r"
        set bossChatMsg[4] = "啊啊啊，我要更多力量！"
        set bossChatMsg[5] = "蝼蚁，受死吧！"
        set bossChatMsg[6] = "不！主人..."
        set bossChatMsg[7] = "为了..."
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)

        set BUFFTYPE_HOLYSHIELD = bufftype.create('A63A','B63K',true,false,true)
        set BUFFTYPE_WRATHOFVENGENCE = bufftype.create('A63B','B63L',true,false,true)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================


//======================================================================
// region BossBansheeLadyViconia
//======================================================================
scope BossBansheeLadyViconia initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n60I'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossBansheeLadyViconia_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null

        public bufftype            BUFFTYPE_CURSEOFPAIN
        public bufftype            BUFFTYPE_SHIELD 
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================
    
    ////////////////////////////////////////////////////
    //技能：痛苦诅咒
    ////////////////////////////////////////////////////
    private function CURSE_OF_PAIN_DAMAGE takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local unit ds = bf.buffSource
        local unit dt = bf.buffTarget
        local real dmg = bf.realData*mybuff.buffTimeScale
        set damageFlag = 'A62Y'
        set damageTag_Shadow = true 
        set damageIsDOT = true 
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        set ds = null 
        set dt = null 
    endfunction
    private function spell_CurseOfPain takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        if CountUnitsInGroup(pick) > 1 then 
            call GroupRemoveUnit(pick,GetUnitTaunter(bossBindUnit))
        endif 
        set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[0]))
        call SetUnitAnimation(bossBindUnit,"spell")
    endfunction
    private function spell_CurseOfPain_Delayed_5 takes nothing returns nothing
        local mybuff bf = mybuff.create(bossBindUnit,bossPlayMan[0],BUFFTYPE_CURSEOFPAIN)
        set bf.lastTime = 3000
        set bf.periodTime = 200
        call bf.addPeriod(function CURSE_OF_PAIN_DAMAGE)
        set bf.realData = bossAbilityRealData[0]*bossDamageMultiple
        set bf.intData = MAP_EXTRA_LEVEL
        set bf.bonusAccuracy = -3000
        call bf.apply()
    endfunction

    ////////////////////////////////////////////////////
    //技能：暗影箭，攻击最远单体
    ////////////////////////////////////////////////////
    private function SHADOW_MISSILE_HIT takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local unit ds = proj.source
        local unit dt = proj.target 
        local real dmg = proj.realData
        call proj.applyDamageSet()
        set damageFlag = 'AIdn'
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        //("DEATH_COIL_HIT")
        set ds = null 
        set dt = null 
    endfunction
    private function spell_ShadowMissile takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[1] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        set bossPlayMan[1] = GetFarthestUnit(bossBindUnit,pick)
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[1]))
        call SetUnitAnimation(bossBindUnit,"spell")
    endfunction
    private function spell_ShadowMissile_Delayed_5 takes nothing returns nothing
        local projectile proj
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        if bossPlayMan[1] == null then 
            return 
        endif 
        set proj = CreateProjectileToUnit(bossBindUnit,bossPlayMan[1],1000,0,"Abilities\\Spells\\Undead\\OrbOfDeath\\AnnihilationMissile.mdl",function SHADOW_MISSILE_HIT,null)
        set proj.tag_Shadow = true 
        set proj.realData = dmg 
        set proj.intData = MAP_EXTRA_LEVEL
        call proj.launch()
    endfunction

    ////////////////////////////////////////////////////
    //技能：黄泉护盾，吸收伤害
    ////////////////////////////////////////////////////
    private function spell_Shield takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"spell")
    endfunction
    private function spell_Shield_Delayed_5 takes nothing returns nothing
        local mybuff bf = mybuff.create(bossBindUnit,bossBindUnit,BUFFTYPE_SHIELD)
        set bf.lastTime = 6000
        set bf.intData = MAP_EXTRA_LEVEL
        set bf.bonusResistance = 5000
        set bf.shieldBlockPercent = 1
        set bf.shieldMaxValue = bossAbilityRealData[2]*bossDamageMultiple
        set bf.shieldDestroy = true 
        set bf.bonusImmune_Root = 1
        set bf.bonusImmune_Silence = 1
        set bf.bonusImmune_Snare = 1
        set bf.bonusImmune_Stun = 1
        call bf.apply()
    endfunction

    ////////////////////////////////////////////////////
    //技能：女妖哀嚎，持续造成伤害
    ////////////////////////////////////////////////////
    globals 
        private delayedevent ChannelEvent = 0
        private Bar bar = 0
    endglobals
    private function BANSHEE_SCREAM_PERIOD takes nothing returns nothing
        local integer time = ChannelEvent.loadInteger("TIME")
        local real dmg = bossAbilityRealData[3]*bossDamageMultiple*Pow(1.1,I2R(time))
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,boss.area,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Shadow = true 
            set damageIsAOE = true 
            set damageFlag = 'Apos'
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
        set time = time+1
        call ChannelEvent.saveInteger("TIME",time)
        call DestroyEffectEX(AddSpecialEffectTargetEX("war3campImported\\desecrate.mdx",bossBindUnit,"origin"))
    endfunction
    function UNIT_n60I_SPELL_READY takes nothing returns nothing
        if castingSpell == 'ABC0' then 
            set boss.pauseTL = true 
            set ChannelEvent = delayedevent.create(133,-1,function BANSHEE_SCREAM_PERIOD)
            call ChannelEvent.saveInteger("TIME",1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,-1)
            call PlaySndEx(SND_DING)
            set bar = CreateBar(3000,-1,bossBindUnit)
        endif 
    endfunction
    function UNIT_n60I_SPELL_STOP takes nothing returns nothing
        if castingSpell == 'ABC0' then 
            set boss.pauseTL = false
            call event_ResetPause()
            if bar > 0 then 
                call bar.destroy()
                set bar = 0
            endif 
            if ChannelEvent > 0 then
                set ChannelEvent.DESTROY = true 
            endif 
            if bossBindUnit != null and alive(bossBindUnit) then 
                call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,1)
            endif 
        endif 
    endfunction
    private function spell_BansheeScream takes nothing returns nothing
        call removeAllDisabilities(bossBindUnit)
        call UnitAddAbilityEx(bossBindUnit,'ABC0')
        call IssueImmediateOrderById(bossBindUnit,ORDER_channel)
    endfunction

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        if ChannelEvent > 0 then
            set ChannelEvent.DESTROY = true 
        endif
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 15.03  //痛苦诅咒伤害
            set bossAbilityRealData[1] = 33.23  //暗影箭伤害
            set bossAbilityRealData[2] = 232.66  //护盾生命
            set bossAbilityRealData[3] = 25  //女妖哀嚎伤害

            set boss.timeline = 0
            set boss.timelineMax = 220
            set boss.timelineMin = 20

            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(70,function spell_ShadowMissile)
            call boss.addTimeline(75,function spell_ShadowMissile_Delayed_5)
            call boss.addTimeline(80,function event_ResetPause)

            call boss.addTimeline(90,function spell_CurseOfPain)
            call boss.addTimeline(95,function spell_CurseOfPain_Delayed_5)
            call boss.addTimeline(100,function event_ResetPause)

            call boss.addTimeline(120,function spell_ShadowMissile)
            call boss.addTimeline(125,function spell_ShadowMissile_Delayed_5)
            call boss.addTimeline(130,function event_ResetPause)

            call boss.addTimeline(180,function spell_Shield)
            call boss.addTimeline(185,function spell_Shield_Delayed_5)
            call boss.addTimeline(190,function event_ResetPause)

            call boss.addTimeline(200,function spell_BansheeScream)
            call boss.addTimeline(210,function event_ResetPause)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "维康尼亚夫人"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "来吧...享受欢愉"
        set bossChatMsg[3] = "死亡台词"
        set bossChatMsg[4] = "重置台词"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)

        set BUFFTYPE_CURSEOFPAIN = bufftype.create('A62Y','B637',false,true,true)
        set BUFFTYPE_SHIELD = bufftype.create('A62Z','B638',true,false,true)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

//======================================================================
// region BossCryptLordAno
//======================================================================
scope BossCryptLordAno initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n60H'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossCryptLordAno_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null

        private bufftype            BUFFTYPE_LOCUSTSWARM    
        private trigger             trigPhaseChange         = CreateTrigger()
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return GetUnitTypeId(GetFilterUnit()) == bossAbilityIntData[0]
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    //======================================================================
    // 穿刺 前方直线物理AOE+击晕+击飞，必定碾压
    //======================================================================
    private function IMPALE_SFX takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local projectile proj = de.loadInteger("PROJ")
        local effect sfx 
        if proj > 0 and proj.dummy != null then 
            set sfx = AddSpecialEffectEX("Abilities\\Spells\\Undead\\Impale\\ImpaleMissTarget.mdl",GetUnitX(proj.dummy),GetUnitY(proj.dummy))
            call BlzSetSpecialEffectOrientation(sfx,GetUnitFacing(proj.dummy)/57.2956,0,0)
            call DestroyEffectEX(sfx)
            set sfx = null 
        endif
    endfunction
    private function IMPALE_HIT takes nothing returns nothing
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            call Knockup.create(waveTarget,300,0.8,"")
            set damageFlag = 'AUim' 
            set damageIsAOE = true 
            set damageCrushRate = 1000
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl",GetUnitX(waveTarget),GetUnitY(waveTarget)))
            call applyStun(waveCaster,waveTarget,'ATB0')
        endif 
    endfunction
    private function spell_Impale takes nothing returns nothing
        local unit tu = GetUnitTaunter(bossBindUnit)
        call PauseUnit(bossBindUnit,true)
        if tu != null then 
            call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,tu))
        endif 
        call SetUnitAnimation(bossBindUnit,"spell")
        set tu = null 
    endfunction
    private function spell_Impale_Delayed_4 takes nothing returns nothing
        local delayedevent de = delayedevent.create(15,20,function IMPALE_SFX)
        local projectile proj = projectile.create(bossBindUnit)
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        set proj.speed = 1000
        set proj.IS_WAVE = true 
        set proj.LAUNCH_UNIT = true 
        set proj.TARGET_LOC = true 
        set proj.target_x = GetUnitX(bossBindUnit)+3100*Cos(a)
        set proj.target_y = GetUnitY(bossBindUnit)+3100*Sin(a)
        set proj.Wave_Radius_Start = 120
        set proj.Wave_Radius_Add = 0 
        call proj.addOnHit(function IMPALE_HIT)
        call proj.launch()
        call de.saveInteger("PROJ",proj)
    endfunction

    //======================================================================
    // 召唤地穴甲虫
    //======================================================================
    private function spell_SummonScarab takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"spell")
    endfunction
    private function spell_SummonScarab_Delayed_4 takes nothing returns nothing
        local real x = GetRandomReal(-400,400)+GetUnitX(bossBindUnit)
        local real y = GetRandomReal(-400,400)+GetUnitY(bossBindUnit)
        local location loc = Location(x,y)
        local unit nu
        local integer i = 0
        loop 
            set i = i+1
            exitwhen i > 100 or IsLocationInRegion(boss.region,loc)
            call RemoveLocation(loc)
            set x = GetRandomReal(-300,300)+GetUnitX(bossBindUnit)
            set y = GetRandomReal(-300,300)+GetUnitY(bossBindUnit)
        endloop
        if IsLocationInRegion(boss.region,loc) then 
            set nu = CreateUnit(GetOwningPlayer(bossBindUnit),bossAbilityIntData[0],x,y,AngleByXYnU(x,y,bossBindUnit))
            call UnitApplyTimedLife(nu,'BTLF',60)
            call delayedPauseUnit(nu,99)
            call delayedPlayAnimation(nu,"Morph Alternate",100)
            if GetUnitTaunter(bossBindUnit) != null then 
                call Taunt(GetUnitTaunter(bossBindUnit),nu)
            endif 
            call UnitAddType(nu,UNIT_TYPE_SUMMONED)
            call RegisterEnemy(nu)
            call UnitShareVision(nu,PLAYER,true)
        endif 
        call RemoveLocation(loc)
        set loc = null
        set nu = null  
    endfunction

    //======================================================================
    // 蝗虫群 <50%hp施放 
    //======================================================================
    private function AURA_LOCUST_SWARM_DAMAGE takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local real dmg = bf.realData
        set damageTag_Shadow = true 
        set damageIsAOE = true 
        set damageFlag = 'AUls' 
        set eventBonusLeech = 0.15
        call UnitDamageTarget(bf.buffSource,bf.buffTarget,dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
    endfunction
    private function AURA_LOCUST_SWARM_SET takes nothing returns nothing
        local mybuff bf = aura.modifingAuraBuff
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        set bf.realData = dmg 
        set bf.periodTime = 200
        call bf.addPeriod(function AURA_LOCUST_SWARM_DAMAGE)
    endfunction
    private function spell_LocustSwarm takes nothing returns nothing
        local aura ar = aura.create(bossBindUnit,"AURA_LOCUST_SWARM",1500,BUFFTYPE_LOCUSTSWARM,0,"")
        call ar.addEnmSet(function AURA_LOCUST_SWARM_SET)
        call removeAllDisabilities(bossBindUnit)
        call UnitAddAbilityEx(bossBindUnit,'AUls')
        call IssueImmediateOrderById(bossBindUnit,ORDER_locustswarm)
    endfunction
    private function spell_LocustSwarm_Remove takes nothing returns nothing
        call UnitRemoveAbility(bossBindUnit,'AUls')
    endfunction

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitStateEvent(trigPhaseChange,bossBindUnit,UNIT_STATE_LIFE,LESS_THAN,0.5*GetUnitState(bossBindUnit,UNIT_STATE_MAX_LIFE))
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 44.7  //穿刺伤害
            set bossAbilityRealData[1] = 9.224  //蝗虫群伤害

            set bossAbilityIntData[0] = 'n60J'  //甲虫id

            set boss.timeline = 0
            set boss.timelineMax = 180
            set boss.timelineMin = 0

            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(70,function spell_Impale)
            call boss.addTimeline(74,function spell_Impale_Delayed_4)
            call boss.addTimeline(80,function event_ResetPause)

            call boss.addTimeline(130,function spell_SummonScarab)
            call boss.addTimeline(134,function spell_SummonScarab_Delayed_4)
            call boss.addTimeline(135,function spell_SummonScarab_Delayed_4)
            call boss.addTimeline(140,function event_ResetPause)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "阿努比罗斯"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "死吧，入侵者。"
        set bossChatMsg[3] = "死亡台词"
        set bossChatMsg[4] = "重置台词"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
        
        //注册buff
        set BUFFTYPE_LOCUSTSWARM = bufftype.create('A62X','B636',false,true,false)

        //特殊事件
        call TriggerAddAction(trigPhaseChange,function spell_LocustSwarm)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

//======================================================================
// region BossButcher
//======================================================================
scope BossButcher initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n60G'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossButcher_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
        
        public bufftype            BUFFTYPE_CORRUPT
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    //======================================================================
    // 钩
    //======================================================================
    private function HOOK_HIT takes nothing returns nothing  
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        set damageFlag = 'HOOK'
        set damageCrushRate = 1000
        call UnitDamageTarget(bossBindUnit,eventHook.target,dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_METAL_MEDIUM_CHOP)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl",eventHook.target,"origin"))
        call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl",eventHook.target,"chest"))
        call applyStun(bossBindUnit,eventHook.target,'ATB1')
        //call BJDebugMsg("HOOK HIT")
    endfunction
    private function HOOK_END takes nothing returns nothing
        set boss.pauseTL = false
        call event_ResetPause()
        //call BJDebugMsg("HOOK END")
    endfunction
    private function spell_Hook_delay5 takes nothing returns nothing
        local Hook this 
        if bossPlayMan[0] == null or alive(bossPlayMan[0]) == false then 
            set boss.pauseTL = false
            call event_ResetPause()
            return
        endif 
        set boss.pauseTL = true 
        call SetUnitTimeScale(bossBindUnit,0.3)
        set this = HookTarget(bossBindUnit,bossPlayMan[0],'hC00','hC01',32,1500,1200,function HOOK_HIT)
        set this.attachDistance = 100
        call this.addOnDestroy(function HOOK_END)
        call StopSound(SND_HOOK,false,false)
        call StartSound(SND_HOOK)
        call SetSoundVolume(SND_HOOK,127)
    endfunction
    private function spell_Hook takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        set bossPlayMan[0] = GetFarthestUnit(bossBindUnit,pick)
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[0]))
        call SetUnitAnimationByIndex(bossBindUnit,2)
    endfunction

    //======================================================================
    // 咬
    //======================================================================
    globals 
        private real bonusBiteDamage = 1
        private Bar bar = 0
    endglobals
    private function spell_Bite_Loop3 takes nothing returns nothing
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple*bonusBiteDamage
        if bossBindUnit == null or alive(bossBindUnit) == false then 
            call DestroyTimer(GetExpiredTimer())
            return 
        endif 
        if GetUnitCurrentOrder(bossBindUnit) != ORDER_channel or bossPlayMan[1] == null or alive(bossPlayMan[1]) == false  then 
            call DestroyTimer(GetExpiredTimer())
            set boss.pauseTL = false 
            call event_ResetPause()
        else 
            call applyStun(bossBindUnit,bossPlayMan[1],'ATB1')
            set damageFlag = 'BITE'
            set damageTag_Bleed = true 
            set damageCrushRate = 1000
            call UnitDamageTarget(bossBindUnit,bossPlayMan[1],dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WOOD_MEDIUM_BASH)
            set bonusBiteDamage = bonusBiteDamage+0.1
            call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl",bossPlayMan[1],"origin"))
        endif 
    endfunction
    function UNIT_n60G_SPELL_READY takes nothing returns nothing
        if castingSpell == 'ABC3' then 
            set boss.pauseTL = true 
            call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,-1)
            set bonusBiteDamage = 1

            call PlaySndEx(SND_DING)
            set bar = CreateBar(1000,-1,bossBindUnit)
            call TimerStart(CreateTimer(),0.3,true,function spell_Bite_Loop3)
            call spell_Bite_Loop3()
            call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl",bossPlayMan[1],"origin"))
            
            call StopSound(SND_ABOMINATION_YES_ATTACK_2,false,false)
            call StartSound(SND_ABOMINATION_YES_ATTACK_2)
            call SetSoundVolume(SND_ABOMINATION_YES_ATTACK_2,127)
        endif 
    endfunction
    function UNIT_n60G_SPELL_STOP takes nothing returns nothing
        if castingSpell == 'ABC3' then 
            set boss.pauseTL = false
            call event_ResetPause()
            set bossFocusTarget = null
            if bar > 0 then 
                call bar.destroy()
                set bar = 0
            endif 
            if bossBindUnit != null and alive(bossBindUnit) then 
                call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,1)
                //call BJDebugMsg("stop"+I2S(unitGetAllBonusStateValue(bossBindUnit,STATE_IMMUNE_SNARE)))
            endif 
        endif 
    endfunction
    private function spell_Bite takes nothing returns nothing
        set bossPlayMan[1] = bossPlayMan[0]
        if bossPlayMan[1] == null then 
            return 
        endif 
        call removeAllDisabilities(bossBindUnit)
        call UnitAddAbilityEx(bossBindUnit,'ABC3')
        call IssueTargetOrderById(bossBindUnit,ORDER_channel,bossPlayMan[1])
        set bossFocusTarget = bossPlayMan[1]
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget)
    endfunction

    //======================================================================
    // 烧
    //======================================================================
    private function CORRUPT_PERIOD takes nothing returns nothing
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local group pick 
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        local mybuff bf
        if mybuff.buffTimeScale < 0.5 then 
            return 
        endif 
        set pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,350,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Fire = true 
            set damageTag_Shadow = true 
            set damageIsAOE = true 
            set damageFlag = 'A64K'
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            set bf = mybuff.create(bossBindUnit,FirstOfGroup(pick),BUFFTYPE_SLOW)
            set bf.lastTime = 200
            set bf.bonusHaste = -2000
            set bf.bonusMoveSpeed_P = -2500
            call bf.apply()
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function spell_Corrupt takes nothing returns nothing
        local mybuff bf = CreateBuff(bossBindUnit,bossBindUnit,BUFFTYPE_CORRUPT,3000)
        set bf.periodTime = 200
        call bf.addPeriod(function CORRUPT_PERIOD)
        call bf.apply()
    endfunction

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area
        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossAbilityRealData[0] = 28.265     //肉钩伤害
            set bossAbilityRealData[1] = 5.185      //撕咬伤害
            set bossAbilityRealData[2] = 7.996      //腐烂伤害

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set boss.timeline = 0
            set boss.timelineMax = 270
            set boss.timelineMin = 0

            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(70,function spell_Hook)
            call boss.addTimeline(75,function spell_Hook_delay5)

            call boss.addTimeline(76,function spell_Corrupt)

            call boss.addTimeline(77,function spell_Bite)

            call boss.addTimeline(120,function spell_Corrupt)

            call boss.addTimeline(135,function spell_Hook)
            call boss.addTimeline(140,function spell_Hook_delay5)

            call boss.addTimeline(190,function spell_Hook)
            call boss.addTimeline(195,function spell_Hook_delay5)

            call boss.addTimeline(196,function spell_Bite)

            call boss.addTimeline(255,function spell_Hook)
            call boss.addTimeline(260,function spell_Hook_delay5)

            call boss.addTimeline(261,function spell_Corrupt)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "屠夫"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "啊...新鲜的肉..."
        set bossChatMsg[3] = "死亡台词"
        set bossChatMsg[4] = "重置台词"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)

        set BUFFTYPE_CORRUPT = bufftype.create('A64K','B64U',true,false,true)                          //腐烂
    endfunction
endscope
//======================================================================
// endregion
//======================================================================


//======================================================================
// region BossDeathKnightLordAnak
//======================================================================
scope BossDeathKnightLordAnak initializer init

    globals 
        public Boss                 boss                    = 0
        public integer              bossUnitId              = 'n60E'
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private trigger             bossCheckPhase_0        = null 
        private trigger             bossCheckPhase_1        = null 
        private trigger             bossCheckPhase_2        = null 
        private trigger             bossCheckPhase_3        = null 
        private trigger             bossCheckPhase_4        = null 
        private trigger             bossCheckPhase_5        = null 
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private boolean             bossCastingFlag         = false 
        private unit array          bossPlayMan             [10]
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossDeathKnightLordAnak_"
        private rect                bossAbilityRandomRect
        private boolexpr            isSkeleton              
    endglobals

    private function Condition_isSkeleton takes nothing returns boolean
        return alive(GetFilterUnit()) and (GetUnitTypeId(GetFilterUnit()) == bossAbilityIntData[0])
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction
    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossFocusTarget))
    endfunction
    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN,bossGate[i])
            set i = i+1
        endloop
    endfunction
    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE,bossGate[i])
            set i = i+1
        endloop
    endfunction

    ////////////////////////////////////////////////////
    //技能：凛风打击，面前锥形AOE
    ////////////////////////////////////////////////////
    private function spell_IceCone takes nothing returns nothing
        local unit tu = GetUnitTaunter(bossBindUnit)
        call PauseUnit(bossBindUnit,true)
        if tu != null then 
            call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,tu))
        endif 
        call SetUnitAnimation(bossBindUnit,"spell")
        call delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\Sweep_Black_Frost_Medium.mdx",bossBindUnit,"weapon"),100)
        set tu = null 
    endfunction
    private function spell_IceCone_Delayed_4 takes nothing returns nothing
        local group pick = CreateGroup()
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit) 
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        call DestroyEffectEX(AddSpecialEffectTargetEX("war3campImported\\Sfx_Jaina_ConeOfCold.mdx",bossBindUnit,"origin"))
        call GroupEnumUnitsInRange(pick,x,y,400,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            if Cos(AngleByUnits(bossBindUnit,FirstOfGroup(pick))/57.2956-a) > 0.866025 then 
                call DestroyEffectEX(AddSpecialEffectTargetEX("war3campImported\\Ice shatter.mdx",FirstOfGroup(pick),"chest"))
                set damageTag_Cold = true 
                set damageTag_Shadow = true 
                set damageIsAOE = true 
                set damageFlag = 'ACbf'
                call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
                call applyCold(bossBindUnit,FirstOfGroup(pick),'ACO0')
            endif 
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction

    ////////////////////////////////////////////////////
    //技能：死亡缠绕，攻击最远单体
    ////////////////////////////////////////////////////
    private function DEATH_COIL_HIT takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local unit ds = proj.source
        local unit dt = proj.target 
        local real dmg = proj.realData
        call proj.applyDamageSet()
        set damageFlag = 'AUdc'
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl",dt,"origin"))
        //("DEATH_COIL_HIT")
        set ds = null 
        set dt = null 
    endfunction
    private function spell_DeathCoil takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        set bossPlayMan[0] = GetFarthestUnit(bossBindUnit,pick)
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[0]))
        call SetUnitAnimation(bossBindUnit,"spell")
        call delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\Sweep_Soul_Medium.mdx",bossBindUnit,"weapon"),100)
    endfunction
    private function spell_DeathCoil_Delayed_4 takes nothing returns nothing
        local projectile proj
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        if bossPlayMan[0] == null then 
            return 
        endif 
        set proj = CreateProjectileToUnit(bossBindUnit,bossPlayMan[0],1000,0,"Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilMissile.mdl",function DEATH_COIL_HIT,null)
        set proj.tag_Shadow = true 
        set proj.realData = dmg 
        set proj.intData = MAP_EXTRA_LEVEL
        call proj.launch()
    endfunction

    ////////////////////////////////////////////////////
    //技能：冲锋，巨大伤害
    ////////////////////////////////////////////////////
    private function CHARGE_HIT takes nothing returns nothing
        local projectile proj
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        if GetOwningPlayer(waveTarget) == PLAYER then 
            set proj = KnockbackTargetEx(waveCaster,waveTarget,350,800,0.05)
            set damageIsAOE = true 
            set damageCrushRate = 1000
            set damageFlag = 'Auco'
            call UnitDamageTarget(bossBindUnit,waveTarget,dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WOOD_LIGHT_BASH)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\StormBolt\\StormBoltMissile.mdl",waveTarget,"chest"))
        endif 
        //("CHARGE_HIT")
    endfunction
    private function CHARGE_END takes nothing returns nothing
        set boss.pauseTL = false 
        call event_ResetPause()
        //("CHARGE_END")
    endfunction
    private function spell_Charge takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[1] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        elseif CountUnitsInGroup(pick) > 1 then
            call GroupRemoveUnit(pick,GetUnitTaunter(bossBindUnit))
        endif 
        set bossPlayMan[1] = GroupPickRandomUnitEx(pick)
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl",bossBindUnit,"origin"))
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"stand ready")
        set bossFocusTarget = bossPlayMan[1]
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[1]))
        call UnitsAddLightningSFX(bossBindUnit,0,0,50,bossPlayMan[1],0,0,50,"REBM",4.5,0.5,true)
    endfunction
    private function spell_Charge_Delayed_40 takes nothing returns nothing
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local real a = GetUnitFacing(bossBindUnit)
        local projectile proj 
        if alive(bossPlayMan[1]) and IsUnitInRegion(boss.region,bossPlayMan[1]) and bossPlayMan[1] != null then 
            set a = AngleByUnits(bossBindUnit,bossPlayMan[1])
        endif 
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        set x = x+3000*Cos(a/57.2956)
        set y = y+3000*Sin(a/57.2956)
        set boss.pauseTL = true 
        set proj = ChargeTargetEx(bossBindUnit,bossPlayMan[1],3000,145,0,true,1500,0,function CHARGE_HIT,function CHARGE_END)
        set proj.bindSFX_0 = AddSpecialEffectTargetEX("war3campImported\\Valiant Charge.mdx",bossBindUnit,"origin")
        set proj.bindSFX_1 = AddSpecialEffectTargetEX("Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl",bossBindUnit,"origin")
        call BlzSetSpecialEffectColor(proj.bindSFX_0,150,150,150)
        call SetUnitTimeScale(bossBindUnit,5)
        call SetUnitAnimationByIndex(bossBindUnit,0)
    endfunction

    ////////////////////////////////////////////////////
    //技能：召唤骷髅
    ////////////////////////////////////////////////////
    private function spell_SummonSkeleton takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"spell")
        call delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\Sweep_Astral_Medium.mdx",bossBindUnit,"weapon"),100)
    endfunction
    private function spell_SummonSkeleton_Delayed_4_Per_1_Loop_5 takes nothing returns nothing
        local real x = GetRandomReal(GetRectMinX(bossAbilityRandomRect),GetRectMaxX(bossAbilityRandomRect))
        local real y = GetRandomReal(GetRectMinY(bossAbilityRandomRect),GetRectMaxY(bossAbilityRandomRect))
        local location loc = Location(x,y)
        local unit nu
        local integer i = 0
        loop 
            set i = i+1
            exitwhen i > 60 or IsLocationInRegion(boss.region,loc)
            call RemoveLocation(loc)
            set x = GetRandomReal(GetRectMinX(bossAbilityRandomRect),GetRectMaxX(bossAbilityRandomRect))
            set y = GetRandomReal(GetRectMinY(bossAbilityRandomRect),GetRectMaxY(bossAbilityRandomRect))
        endloop
        if IsLocationInRegion(boss.region,loc) then 
            set nu = CreateUnit(GetOwningPlayer(bossBindUnit),bossAbilityIntData[0],x,y,AngleByXYnU(x,y,bossBindUnit))
            call UnitApplyTimedLife(nu,'BTLF',60)
            call delayedPauseUnit(nu,150)
            call delayedPlayAnimation(nu,"birth",200)
            if GetUnitTaunter(bossBindUnit) != null then 
                call Taunt(GetUnitTaunter(bossBindUnit),nu)
            endif 
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl",x,y))
            call UnitAddType(nu,UNIT_TYPE_SUMMONED)
            call RegisterEnemy(nu)
            call UnitShareVision(nu,PLAYER,true)
        endif 
        call RemoveLocation(loc)
        set loc = null
        set nu = null  
    endfunction

    ////////////////////////////////////////////////////
    //技能：死亡契约，吃骷髅3倍回血
    ////////////////////////////////////////////////////
    private function spell_DeathPact takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[2] = null 
        call GroupEnumUnitsInRect(pick,boss.area,isSkeleton)
        if CountUnitsInGroup(pick) > 0 then 
            set bossPlayMan[2] = GetUnitWithHighestHealth(pick)
            call PauseUnit(bossBindUnit,true)
            call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[2]))
            call SetUnitAnimation(bossBindUnit,"spell")
            call delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\Sweep_Soul_Medium.mdx",bossBindUnit,"weapon"),100)
        endif 
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function spell_DeathPact_Delayed_4 takes nothing returns nothing
        local real heal = 0
        if bossPlayMan[2] != null and alive(bossPlayMan[2]) then 
            set heal = 3.0*GetUnitState(bossPlayMan[2],UNIT_STATE_LIFE)
            call GetEnemyFromUnit(bossPlayMan[2]).destroy()
            call KillUnit(bossPlayMan[2])
            set healFlag = 'AUdp'
            call UnitHealTarget(bossBindUnit,bossBindUnit,heal)
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl",GetUnitX(bossPlayMan[2]),GetUnitY(bossPlayMan[2])))
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\DeathPact\\DeathPactCaster.mdl",bossBindUnit,"origin"))
        endif 
    endfunction

    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area 
        call TriggerRegisterUnitInRangeSimple(activateBoss,500,bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss,bossBindUnit,EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)
        call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,1)
        call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,1)
        call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,1)
        call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,1)
        call unitAddState(bossBindUnit,STATE_IMMUNE_COLD,1)
        set i = 0
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i],true)
            set i = i+1
        endloop
        call event_OpenAllGates()
        //("bossOnInit")
    endfunction
    private function bossOnCheckReset takes nothing returns nothing

    endfunction
    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick,boss.area,isSkeleton)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick,u)
        endloop
        call DestroyGroup(pick)
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DisplayTextToPlayer(PLAYER,0,0,bossChatMsg[1]+bossChatMsg[4])
        set pick = null 
        set u = null 
    endfunction
    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = (UnitLevel(party[0])+UnitLevel(party[1])+UnitLevel(party[2])+UnitLevel(party[3])+UnitLevel(party[4]))/5-level
        local integer bonusXP = ((level*level/2+level*2+6)*TEAM_XP_GAIN_RATE/10000)*5+level/10*1000
        local integer bonusGP = (level*level/4)*5+level/10
        local group pick = CreateGroup()
        local unit u
        
        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0,bonusXP*(10-3*levelDiff)/10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_GOLD)+bonusGP/2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick,boss.area,isSkeleton)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick,u)
        endloop
        call DestroyGroup(pick)
        set pick = null 
        set u = null 
    endfunction
    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,boss.area,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(),UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit)-1]*Pow(MAP_DIFFICULTY_MULTIPLE,MAP_EXTRA_LEVEL)
            set bossAbilityRealData[0] = 48.245     //凛风冲击伤害
            set bossAbilityRealData[1] = 32.881     //死亡缠绕伤害
            set bossAbilityRealData[2] = 109.683     //冲锋伤害
            set bossAbilityRealData[3] = 8          //邪恶光环伤害

            set bossAbilityIntData[0] = 'n60F'      //骷髅召唤id

            set boss.timelineMax = 470
            set boss.timelineMin = 30
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()
            
            call boss.addTimeline(80,function spell_IceCone)
            call boss.addTimeline(84,function spell_IceCone_Delayed_4)
            call boss.addTimeline(90,function event_ResetPause)

            call boss.addTimeline(120,function spell_DeathCoil)
            call boss.addTimeline(124,function spell_DeathCoil_Delayed_4)
            call boss.addTimeline(130,function event_ResetPause)

            call boss.addTimeline(150,function spell_DeathPact)
            call boss.addTimeline(154,function spell_DeathPact_Delayed_4)
            call boss.addTimeline(160,function event_ResetPause)

            call boss.addTimeline(200,function spell_DeathCoil)
            call boss.addTimeline(204,function spell_DeathCoil_Delayed_4)
            call boss.addTimeline(210,function event_ResetPause)

            call boss.addTimeline(260,function spell_IceCone)
            call boss.addTimeline(264,function spell_IceCone_Delayed_4)
            call boss.addTimeline(270,function event_ResetPause)

            call boss.addTimeline(291,function spell_SummonSkeleton)
            call boss.addTimeline(295,function spell_SummonSkeleton_Delayed_4_Per_1_Loop_5)
            call boss.addTimeline(296,function spell_SummonSkeleton_Delayed_4_Per_1_Loop_5)
            call boss.addTimeline(297,function spell_SummonSkeleton_Delayed_4_Per_1_Loop_5)
            call boss.addTimeline(298,function spell_SummonSkeleton_Delayed_4_Per_1_Loop_5)
            call boss.addTimeline(299,function spell_SummonSkeleton_Delayed_4_Per_1_Loop_5)
            call boss.addTimeline(301,function event_ResetPause)

            call boss.addTimeline(320,function spell_IceCone)
            call boss.addTimeline(324,function spell_IceCone_Delayed_4)
            call boss.addTimeline(330,function event_ResetPause)

            call boss.addTimeline(390,function spell_Charge)
            call boss.addTimeline(430,function spell_Charge_Delayed_40)
            call boss.addTimeline(431,function event_ResetPause)

            call boss.addTimeline(450,function spell_DeathCoil)
            call boss.addTimeline(454,function spell_DeathCoil_Delayed_4)
            call boss.addTimeline(460,function event_ResetPause)

            call boss.activate()


            call UnitShareVision(bossBindUnit,PLAYER,true)

            call delayedevent.create(500,1,function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER,0,0,bossChatMsg[1]+bossChatMsg[2])

            call SetUnitInvulnerable(bossBindUnit,false)
            call event_ResetPause()
        endif 
    endfunction
    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        call DisplayTextToPlayer(PLAYER,0,0,bossChatMsg[1]+bossChatMsg[3])
    endfunction
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0]  = "阿纳克领主" 
        set bossChatMsg[1]  = "|cffffcc00"+bossChatMsg[0]+"：|r" 
        set bossChatMsg[2]  = "留下性命吧，贱种！" 
        set bossChatMsg[3]  = "不！...陛下的计划...必须..." 
        set bossChatMsg[4]  = "天灾军团会将你吞噬！" 
    endfunction
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount+1
        endif 
    endfunction

    private function init takes nothing returns nothing
        local integer i = 0
        call initBossChatMsg()

        set isSkeleton = Condition(function Condition_isSkeleton)

        call TriggerAddAction(defeatBoss,function defeatBoss_Action)
        call TriggerAddAction(activateBoss,function activateBoss_Action)

        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================


//======================================================================
// region BossSalamanderFlameFlash
//======================================================================
scope BossSalamanderFlameFlash initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n62M'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossSalamanderFlameFlash_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
        
        private effect bindHandLeft = null 
        private effect bindHandRight = null 

        private bufftype BUFFTYPE_FIRENOVA
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        if GetUnitTypeId(GetFilterUnit()) == bossAbilityIntData[0] then 
            return true 
        endif
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================
    
    //======================================================================
    // 烈焰之径
    //======================================================================
    private function FIREPATH_GROUNDSFX takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        local group pick = null 

        if alive(bossBindUnit) == false or bossBindUnit == null or de.loopCount <= 0 then 
            call DestroyEffectEX(de.loadEffect("SFX"))
            set de.DESTROY = true 
            return 
        endif 

        set pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,100,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            if unitCheckCooldown(FirstOfGroup(pick),'n62M') then 
                set damageFlag = 'AHfs' 
                set damageIsAOE = true 
                set damageIsDOT = true 
                set damageTag_Fire = true 
                call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl",FirstOfGroup(pick),"chest"))
                call unitStartCooldown(FirstOfGroup(pick),'n62M',99)
            endif
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function FIREPATH_SFX takes nothing returns nothing
        local effect sfx 
        local delayedevent de = delayedevent.currentEvent
        local projectile proj = de.loadInteger("PROJ")
        if proj > 0 and proj.dummy != null then
            if IsUnitInRegion(boss.region,proj.dummy) then  
                set sfx = AddSpecialEffectEX("Objects\\Spawnmodels\\Human\\SmallFlameSpawn\\SmallFlameSpawn.mdx",GetUnitX(proj.dummy),GetUnitY(proj.dummy))
                call BlzSetSpecialEffectTimeScale(sfx,3)
                call delayedDestroyEffect(sfx,222)
                set de = delayedevent.create(20,300,function FIREPATH_GROUNDSFX)
                call de.saveReal("X",GetUnitX(proj.dummy))
                call de.saveReal("Y",GetUnitY(proj.dummy))
                call de.saveEffect("SFX",AddSpecialEffectEX("war3campImported\\FireWall.mdx",GetUnitX(proj.dummy),GetUnitY(proj.dummy)))
                call BlzSetSpecialEffectMatrixScale(de.loadEffect("SFX"),1.1,1.1,0.3)
                return 
            endif 
        endif
        set de.DESTROY = true 
    endfunction
    private function FIREPATH_HIT takes nothing returns nothing
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageFlag = 'AHfs' 
            set damageIsAOE = true 
            set damageTag_Fire = true 
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        endif 
    endfunction
    private function spell_FirePath takes nothing returns nothing
        local unit tu = GetUnitTaunter(bossBindUnit)
        call PauseUnit(bossBindUnit,true)
        if tu != null then 
            call BlzSetUnitFacingEx(bossBindUnit,AngleByUnits(bossBindUnit,tu))
        endif 
        call SetUnitAnimation(bossBindUnit,"spell")
        set tu = null 
    endfunction
    private function spell_FirePath_Delayed_3 takes nothing returns nothing
        local delayedevent de = delayedevent.create(10,30,function FIREPATH_SFX)
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local projectile proj = CreateWave(bossBindUnit,x+3100*Cos(a),y+3100*Sin(a),1000,100,0,"",function FIREPATH_HIT,null)
        local real add = 1
        if GetRandomReal(0,1) < 0.5 then 
            set add = -1
        endif 
        set proj.bezier_points = 3
        set proj.bezier_x0 = x+600*Cos(a+0.5236*add)
        set proj.bezier_y0 = y+600*Sin(a+0.5236*add)
        set proj.bezier_x1 = x+1200*Cos(a-0.6236*add)
        set proj.bezier_y1 = y+1200*Sin(a-0.6236*add)
        set proj.bezier_x2 = x+1800*Cos(a+0.7236*add)
        set proj.bezier_y2 = y+1800*Sin(a+0.7236*add)
        call proj.launch()
        call de.saveInteger("PROJ",proj)
    endfunction

    
    //======================================================================
    // 火星速射
    //======================================================================
    private function FIREFLASH_HIT takes nothing returns nothing
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageFlag = 'ACfb' 
            set damageIsAOE = true 
            set damageTag_Fire = true 
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl",waveTarget,"chest"))
        endif 
    endfunction
    private function FireFlash_Period takes nothing returns nothing
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local projectile proj = CreateWave(bossBindUnit,x+3100*Cos(a),y+3100*Sin(a),1000,100,0,"Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl",function FIREFLASH_HIT,null)
        set proj.model_attach = "chest" 
        call proj.launch()
    endfunction
    private function spell_FireFlash_Delayed_30 takes nothing returns nothing
        local delayedevent de = 0 
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        set de = delayedevent.create(20,15,function FireFlash_Period)
        call SetUnitAnimation(bossBindUnit,"spell")
    endfunction

    private function spell_FireFlash takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        set bossPlayMan[0] = GetFarthestUnit(bossBindUnit,pick)
        call DestroyGroup(pick)
        set pick = null 
        if bossPlayMan[0] == null or IsUnitInRegion(boss.region,bossPlayMan[0]) == false then 
            return 
        endif 
        set bossFocusTarget = bossPlayMan[0]
        call UnitsAddLightningSFX(bossFocusTarget,0,0,30,bossBindUnit,100,0,100,"REBM",6,1,true)
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"stand channel")
        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)
        set bindHandLeft = AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl",bossBindUnit,"hand left")
        set bindHandRight = AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl",bossBindUnit,"hand right")
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget)
        call TimerStart(CreateTimer(),3.,false,function spell_FireFlash_Delayed_30)
    endfunction

    //======================================================================
    // 火焰新星
    //======================================================================
    private function FIRENOVA_DOT takes nothing returns nothing
        local real dmg = bossAbilityRealData[4]*bossDamageMultiple
        local mybuff bf = mybuff.currentBuff
        set damageFlag = 'ACbc' 
        set damageIsDOT = true 
        set damageTag_Ignite = true 
        set damageTag_Fire = true 
        call UnitDamageTarget(bossBindUnit,bf.buffTarget,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
    endfunction
    private function FIRENOVA_RING takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local group pick 
        local real dmg = bossAbilityRealData[5]*bossDamageMultiple
        if alive(de.loadUnit("TARGET")) == false or de.loadUnit("TARGET") == null or de.loopCount <= 0 then 
            set de.DESTROY = true 
            call DestroyEffectEX(de.loadEffect("SFX"))
            return 
        endif 
        if DisByUnXY(de.loadUnit("TARGET"),x,y) > 110 and DisByUnXY(de.loadUnit("TARGET"),x,y) < 200 then 
            set de.DESTROY = true 
            call DestroyEffectEX(de.loadEffect("SFX"))
            call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\Firenova.mdx",GetUnitX(de.loadUnit("TARGET")),GetUnitY(de.loadUnit("TARGET"))))
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerAlly)
            loop
                exitwhen FirstOfGroup(pick) == null 
                set damageFlag = 'ACbc' 
                set damageIsAOE = true 
                set damageTag_Fire = true 
                call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl",FirstOfGroup(pick),"chest"))
                call GroupRemoveUnit(pick,FirstOfGroup(pick))
            endloop
            call DestroyGroup(pick)
            set pick = null 
        endif 
    endfunction
    private function FIRENOVA_END takes nothing returns nothing
        local delayedevent de = delayedevent.create(5,70,function FIRENOVA_RING)
        local projectile proj = projectile.currentProjectile
        local mybuff bf = CreateBuff(bossBindUnit,proj.source,BUFFTYPE_FIRENOVA,300)
        set bf.periodTime = 50
        call bf.addPeriod(function FIRENOVA_DOT)
        call bf.apply()
        if IsUnitType(proj.source,UNIT_TYPE_HERO) then
            call de.saveReal("X",GetUnitX(proj.source))
            call de.saveReal("Y",GetUnitY(proj.source))
            call de.saveEffect("SFX",AddSpecialEffectEX("war3campImported\\LiquidfireLarge.mdl",GetUnitX(proj.source),GetUnitY(proj.source)))
            call de.saveUnit("TARGET",proj.source)
            call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl",GetUnitX(proj.source),GetUnitY(proj.source)))
        endif 
    endfunction
    private function spell_FireNova_Delayed_3 takes nothing returns nothing
        local projectile proj 
        local real x 
        local real y 
        local real a 
        local real d 
        local real dmg = bossAbilityRealData[3]*bossDamageMultiple
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set x = GetUnitX(FirstOfGroup(pick))
            set y = GetUnitY(FirstOfGroup(pick))
            set a = AngleByUnits(bossBindUnit,FirstOfGroup(pick))/57.2956
            set d = 200
            set proj = KnockbackLocEx(FirstOfGroup(pick),x+d*Cos(a),y+d*Sin(a),1000,0.2)
            call proj.addOnEnd(function FIRENOVA_END)
            set damageFlag = 'ACbc' 
            set damageIsAOE = true 
            set damageIsDOT = true 
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl",FirstOfGroup(pick),"chest"))
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\Firenova.mdx",GetUnitX(bossBindUnit),GetUnitY(bossBindUnit)))
    endfunction
    private function spell_FireNova takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"spell")
    endfunction

    //======================================================================
    // 火焰弹幕
    //======================================================================
    private function FIREBULLET_END takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local real x = GetUnitX(proj.dummy)
        local real y = GetUnitY(proj.dummy)
        local unit nu
        set nu = CreateUnit(GetOwningPlayer(bossBindUnit),bossAbilityIntData[0],x,y,AngleByXYnU(x,y,bossBindUnit))
        call UnitApplyTimedLife(nu,'BTLF',60)
        call delayedPauseUnit(nu,66)
        call delayedPlayAnimation(nu,"birth",66)
        if GetUnitTaunter(bossBindUnit) != null then 
            call Taunt(GetUnitTaunter(bossBindUnit),nu)
        endif 
        call UnitAddType(nu,UNIT_TYPE_SUMMONED)
        call RegisterEnemy(nu)
        call UnitShareVision(nu,PLAYER,true)
        set nu = null 
    endfunction
    private function FIREBULLET_HIT takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local real dmg = bossAbilityRealData[6]*bossDamageMultiple
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageFlag = 'ACfb' 
            set damageIsAOE = true 
            set damageTag_Fire = true 
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl",waveTarget,"chest"))
        endif 
    endfunction
    private function spell_FireBulletHell_Delayed_3 takes nothing returns nothing
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local real d = 3000
        local integer i = 0
        local integer j = 0
        local projectile proj 
        loop
            exitwhen i > 21
            set a = a+5.7+GetRandomReal(-0.299,0.299)
            set proj = CreateWave(bossBindUnit,x+d*Cos(a),y+d*Sin(a),GetRandomReal(970,1030),80,0,"Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl",function FIREBULLET_HIT,null)
            set proj.model_attach = "chest"
            call proj.launch()
            set i = i+1
        endloop
        loop
            exitwhen j > 5
            set a = a+5.7+GetRandomReal(-0.299,0.299)
            set proj = CreateWave(bossBindUnit,x+d*Cos(a),y+d*Sin(a),GetRandomReal(970,1030),80,0,"Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl",function FIREBULLET_HIT,function FIREBULLET_END)
            set proj.model_attach = "chest"
            set proj.ifCheckPath = true 
            call proj.launch()
            set j = j+1
        endloop
    endfunction 
    private function spell_FireBulletHell takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"spell")
    endfunction
    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)
        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 25.447     //火焰之径命中伤害
            set bossAbilityRealData[1] = 16.991     //火焰之径路径每秒伤害
            set bossAbilityRealData[2] = 13.641     //火焰速射伤害
            set bossAbilityRealData[3] = 13.331     //火焰新星伤害
            set bossAbilityRealData[4] = 2.115     //火焰新星DOT
            set bossAbilityRealData[5] = 40.745     //火圈伤害
            set bossAbilityRealData[6] = 5.745     //火焰弹幕伤害

            set bossAbilityIntData[0] = 'n62N'

            set boss.timeline = 0
            set boss.timelineMax = 340
            set boss.timelineMin = 0
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()
            
            call boss.addTimeline(70,function spell_FirePath)
            call boss.addTimeline(73,function spell_FirePath_Delayed_3)
            call boss.addTimeline(78,function event_ResetPause)

            call boss.addTimeline(120,function spell_FireFlash)
            call boss.addTimeline(180,function event_ResetPause)
            
            call boss.addTimeline(220,function spell_FirePath)
            call boss.addTimeline(223,function spell_FirePath_Delayed_3)
            call boss.addTimeline(228,function event_ResetPause)
            
            call boss.addTimeline(270,function spell_FireNova)
            call boss.addTimeline(273,function spell_FireNova_Delayed_3)
            call boss.addTimeline(280,function event_ResetPause)

            call boss.addTimeline(300,function spell_FireBulletHell)
            call boss.addTimeline(303,function spell_FireBulletHell_Delayed_3)
            call boss.addTimeline(310,function event_ResetPause)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "弗莱拉斯"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "有入侵者！"
        set bossChatMsg[3] = "死亡台词"
        set bossChatMsg[4] = "重置台词"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)

        set BUFFTYPE_FIRENOVA = bufftype.create('A64V','B652',false,true,true) 
        
    endfunction
endscope
//======================================================================
// endregion
//======================================================================


//======================================================================
// region BossTheUnquenchable
//======================================================================
scope BossTheUnquenchable initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n62K'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossTheUnquenchable_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null

        private bufftype            BUFFTYPE_FIREFIST
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    
    //======================================================================
    // 山崩
    //======================================================================
    private function AVALANCHE_END takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local real x = proj.target_x
        local real y = proj.target_y 
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,230,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call applyStun(bossBindUnit,FirstOfGroup(pick),'ATB0')
            set damageTag_Earth = true 
            set damageFlag = 'AOeq' 
            set damageIsAOE = true 
            set damageCrushRate = 1000
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function AVALANCHE_PERIOD takes nothing returns nothing
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local projectile proj = CreateProjectileToLoc(bossBindUnit,x+225*Cos(a)+GetRandomReal(-25,25),y+225*Sin(a)+GetRandomReal(-25,25),600,0,"Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl",null,function AVALANCHE_END)
        set proj.start_z = 150
        set proj.ifFaceTarget = false 
        set proj.needCurve = false 
        call proj.launch()
        call BlzSetUnitFacingEx(proj.dummy,GetRandomReal(0,360))
    endfunction
    private function spell_Avalanche_Delayed_2 takes nothing returns nothing
        local delayedevent de = delayedevent.create(10,10,function AVALANCHE_PERIOD)
    endfunction
    private function spell_Avalanche takes nothing returns nothing
        local unit tu = GetUnitTaunter(bossBindUnit)
        call PauseUnit(bossBindUnit,true)
        if tu != null then 
            call BlzSetUnitFacingEx(bossBindUnit,AngleByUnits(bossBindUnit,tu))
        endif 
        call SetUnitAnimation(bossBindUnit,"attack")
        set tu = null 
    endfunction
    
    //======================================================================
    // 火球术
    //======================================================================
    private function FIREBALL_FIRE takes nothing returns nothing
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local group pick = CreateGroup()

        if alive(bossBindUnit) == false or bossBindUnit == null or de.loopCount <= 0 then 
            call DestroyEffectEX(de.loadEffect("SFX"))
            set de.DESTROY = true 
            return 
        endif 

        set pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,120,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageFlag = 'AHfs' 
            set damageIsAOE = true 
            set damageIsDOT = true 
            set damageTag_Ignite = true
            set damageTag_Fire = true 
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl",FirstOfGroup(pick),"chest"))
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function FIREBALL_HIT takes nothing returns nothing
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        local projectile proj = projectile.currentProjectile
        local real x = GetUnitX(proj.target)
        local real y = GetUnitY(proj.target)
        local delayedevent de = delayedevent.create(100,60,function FIREBALL_FIRE)
        local group pick = CreateGroup()
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
        call de.saveEffect("SFX",AddSpecialEffectEX("Doodads\\Cinematic\\TownBurningFireEmitter\\TownBurningFireEmitter",x,y))
        call GroupEnumUnitsInRange(pick,x,y,200,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Fire = true 
            set damageIsAOE = true 
            set damageFlag = 'ACfb'
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\LordofFlameMissile\\LordofFlameMissile.mdl",FirstOfGroup(pick),"chest"))
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function spell_FireBall_Delayed_2 takes nothing returns nothing
        local projectile proj = 0
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        set proj = CreateProjectileToUnit(bossBindUnit,bossPlayMan[0],1000,0,"Abilities\\Weapons\\LordofFlameMissile\\LordofFlameMissile.mdl",function FIREBALL_HIT,null)
        set proj.start_z = 50
        call proj.launch()
        call SetUnitScale(proj.dummy,1.5,1.5,1.5)
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
    endfunction
    private function spell_FireBall takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[0] = GetFarthestUnit(bossBindUnit,pick)
            call GroupRemoveUnit(pick,bossPlayMan[0])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[0]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        if bossPlayMan[0] == null or IsUnitInRegion(boss.region,bossPlayMan[0]) == false then 
            return 
        endif 
        set bossFocusTarget = bossPlayMan[0]
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"attack")
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget)
        call TimerStart(CreateTimer(),0.25,false,function spell_FireBall_Delayed_2)
    endfunction
    
    //======================================================================
    // 火焰之拳
    //======================================================================
    private function spell_FireFist takes nothing returns nothing
        local mybuff bf = CreateBuff(bossBindUnit,bossBindUnit,BUFFTYPE_FIREFIST,3000)
        set bf.bonusAttackSpeed = 5000
        set bf.bonusAttack_P = 2500
        call bf.apply()
    endfunction

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 5.776      //山崩伤害
            set bossAbilityRealData[1] = 33.666      //火球伤害
            set bossAbilityRealData[2] = 19.424      //火球残火伤害

            set boss.timeline = 0
            set boss.timelineMax = 300
            set boss.timelineMin = 0
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()
            
            call boss.addTimeline(50,function spell_Avalanche)
            call boss.addTimeline(52,function spell_Avalanche_Delayed_2)
            call boss.addTimeline(62,function event_ResetPause)

            call boss.addTimeline(70,function spell_FireBall)
            call boss.addTimeline(80,function event_ResetPause)

            call boss.addTimeline(90,function spell_FireFist)

            call boss.addTimeline(120,function spell_FireBall)
            call boss.addTimeline(130,function event_ResetPause)

            call boss.addTimeline(180,function spell_FireBall)
            call boss.addTimeline(190,function event_ResetPause)
            
            call boss.addTimeline(230,function spell_Avalanche)
            call boss.addTimeline(232,function spell_Avalanche_Delayed_2)
            call boss.addTimeline(242,function event_ResetPause)

            call boss.addTimeline(280,function spell_FireBall)
            call boss.addTimeline(290,function event_ResetPause)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
            
            call UnitShareVision(boss.u[1], PLAYER, true)
            call PauseUnit(boss.u[1],false)
            call SetUnitInvulnerable(boss.u[1], false)
            call CheckPosition(boss.u[1])
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "不灭"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "激活台词"
        set bossChatMsg[3] = "死亡台词"
        set bossChatMsg[4] = "重置台词"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)

        set BUFFTYPE_FIREFIST = bufftype.create('A64W','B653',true,false,true) 
    endfunction
endscope
//======================================================================
// endregion
//======================================================================


//======================================================================
// region BossFireLord
//======================================================================
scope BossFireLord initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n62L'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossFireLord_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null

        private bufftype            BUFFTYPE_FIREIMMOLATION
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        if GetUnitTypeId(GetFilterUnit()) == bossAbilityIntData[0] then 
            return true 
        endif
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================
    
    //======================================================================
    // 火焰之环
    //======================================================================
    globals 
        private effect bindHandLeft = null 
        private effect bindHandRight = null 
        private Bar bar = 0
    endglobals
    
    private function spell_FireRing_Delayd_46 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call event_ResetPause()
    endfunction
    private function spell_FireRing_Delayd_40 takes nothing returns nothing
        local projectile proj
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local integer i = 0
        local real a = GetUnitFacing(bossBindUnit)
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        local group pick
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        if GetUnitCurrentOrder(bossBindUnit) == ORDER_channel then 
            set pick = CreateGroup()
            call DestroyEffectEX(bindHandLeft)
            call DestroyEffectEX(bindHandRight)
            set bindHandLeft = null 
            set bindHandRight = null 
            loop
                exitwhen i > 11
                set proj = CreateWave(bossBindUnit,x+2000*Cos(a),y+2000*Sin(a),2010,0,0,"Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireMissile.mdl",null,null)
                //set proj.model_attach = "origin"
                call proj.launch()
                set a = a+0.5236
                set i = i+1
            endloop
            call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerAlly)
            loop
                exitwhen FirstOfGroup(pick) == null 
                set damageTag_Fire = true 
                set damageIsAOE = true 
                set damageFlag = 'ACbc'
                call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\LordofFlameMissile\\LordofFlameMissile.mdl",FirstOfGroup(pick),"chest"))
                call GroupRemoveUnit(pick,FirstOfGroup(pick))
            endloop
            call DestroyGroup(pick)
            set pick = null 
            call TimerStart(CreateTimer(),0.6,false,function spell_FireRing_Delayd_46)
        endif 
    endfunction 
    private function spell_FireRing_Delayd_35 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        if GetUnitCurrentOrder(bossBindUnit) == ORDER_channel then 
            call SetUnitAnimation(bossBindUnit,"spell")
            call TimerStart(CreateTimer(),0.5,false,function spell_FireRing_Delayd_40)
        endif 
    endfunction
    function UNIT_n62L_SPELL_READY takes nothing returns nothing
        if castingSpell == 'ABC4' then 
            set boss.pauseTL = true 
            call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,-1)
            call DestroyEffectEX(bindHandLeft)
            call DestroyEffectEX(bindHandRight)
            set bindHandLeft = AddSpecialEffectTargetEX("war3campImported\\juggernautaghanims.mdx",bossBindUnit,"hand left")
            set bindHandRight = AddSpecialEffectTargetEX("war3campImported\\juggernautaghanims.mdx",bossBindUnit,"hand right")
            call TimerStart(CreateTimer(),3,false,function spell_FireRing_Delayd_35)
            call PlaySndEx(SND_DING)
            set bar = CreateBar(350,1,bossBindUnit)
        endif 
    endfunction
    function UNIT_n62L_SPELL_STOP takes nothing returns nothing
        if castingSpell == 'ABC4' then 
            set boss.pauseTL = false
            call event_ResetPause()
            set bossFocusTarget = null
            if bar > 0 then 
                call bar.destroy()
                set bar = 0
            endif 
            if bossBindUnit != null and alive(bossBindUnit) then 
                call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,1)
                //call BJDebugMsg("stop"+I2S(unitGetAllBonusStateValue(bossBindUnit,STATE_IMMUNE_SNARE)))
                call DestroyEffectEX(bindHandLeft)
                call DestroyEffectEX(bindHandRight)
            endif 
        endif 
    endfunction
    private function spell_FireRing takes nothing returns nothing
        local group pick = CreateGroup()
        call removeAllDisabilities(bossBindUnit)
        call UnitAddAbilityEx(bossBindUnit,'ABC4')
        call IssueImmediateOrderById(bossBindUnit,ORDER_channel)
    endfunction

    //======================================================================
    // 大炎爆
    //======================================================================
    globals
        private effect GPB_SFX = null 
        private real GPB_X = 0
        private real GPB_Y = 0
    endglobals
    private function spell_GreatPyroBlast_Delayed_40 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call event_ResetPause()
    endfunction
    private function GREATPYROBLAST_HIT takes nothing returns nothing
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        local projectile proj = projectile.currentProjectile
        local real x = proj.target_x
        local real y = proj.target_y
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,250,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Fire = true 
            set damageIsAOE = true 
            set damageFlag = 'ACfs'
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(GPB_SFX)
        call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl",x,y))
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl",x,y))
    endfunction
    private function spell_GreatPyroBlast_Delayed_35 takes nothing returns nothing
        local projectile proj = 0 
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif
        set proj = CreateProjectileToLoc(bossBindUnit,GPB_X,GPB_Y,800,0,"Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl",null,function GREATPYROBLAST_HIT)
        set proj.start_x = -18
        set proj.start_y = 100
        set proj.start_z = 50
        call proj.launch()
        set proj.bindSFX_0 = AddSpecialEffectTargetEX("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl",proj.dummy,"chest")
        call SetUnitScale(proj.dummy,2,2,2)
        call TimerStart(CreateTimer(),0.66,false,function spell_GreatPyroBlast_Delayed_40)
    endfunction
    private function spell_GreatPyroBlast_Delayed_30 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnXY(bossBindUnit,GPB_X,GPB_Y))
        call SetUnitAnimation(bossBindUnit,"attack")
        call TimerStart(CreateTimer(),0.5,false,function spell_GreatPyroBlast_Delayed_35)
    endfunction
    private function spell_GreatPyroBlast takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        call GroupRemoveUnit(pick,GetUnitTaunter(bossBindUnit))
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[0])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[0]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        if bossPlayMan[0] == null then 
            set bossPlayMan[0] = GetUnitTaunter(bossBindUnit)
        endif 
        if bossPlayMan[0] == null or IsUnitInRegion(boss.region,bossPlayMan[0]) == false then 
            return 
        endif 
        call TimerStart(CreateTimer(),3,false,function spell_GreatPyroBlast_Delayed_30)
        set GPB_X = GetUnitX(bossPlayMan[0])
        set GPB_Y = GetUnitY(bossPlayMan[0])
        set GPB_SFX = AddSpecialEffectEX("war3campImported\\VampPotionCaster.mdl",GPB_X,GPB_Y)
        call BlzSetSpecialEffectScale(GPB_SFX,2)
    endfunction
    
    //======================================================================
    // 烈焰之柱
    //======================================================================
    globals
        private real FP_X = 0
        private real FP_Y = 0
    endglobals
    private function spell_FirePillar_Delayed_30 takes nothing returns nothing
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        local real x = FP_X
        local real y = FP_Y
        local real r = 150
        local group pick = null
        local unit nu
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif
        set pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,r,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Fire = true 
            set damageIsAOE = true 
            set damageFlag = 'ANfs'
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl",x,y))

        set nu = CreateUnit(GetOwningPlayer(bossBindUnit),bossAbilityIntData[0],x,y,AngleByXYnU(x,y,bossBindUnit))
        call UnitApplyTimedLife(nu,'BTLF',60)
        call delayedPauseUnit(nu,66)
        call delayedPlayAnimation(nu,"birth",66)
        if GetUnitTaunter(bossBindUnit) != null then 
            call Taunt(GetUnitTaunter(bossBindUnit),nu)
        endif 
        call UnitAddType(nu,UNIT_TYPE_SUMMONED)
        call RegisterEnemy(nu)
        call UnitShareVision(nu,PLAYER,true)
        set nu = null 
    endfunction
    private function spell_FirePillar takes nothing returns nothing
        local effect sfx
        local real x = GetRandomReal(GetRectMinX(bossAbilityRandomRect),GetRectMaxX(bossAbilityRandomRect))
        local real y = GetRandomReal(GetRectMinY(bossAbilityRandomRect),GetRectMaxY(bossAbilityRandomRect))
        local group pick = CreateGroup()
        set bossPlayMan[1] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[1] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[1])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[1]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        if bossPlayMan[1] != null and IsUnitInRegion(boss.region,bossPlayMan[1]) then 
            set x = GetUnitX(bossPlayMan[1])+GetRandomReal(-100,100)
            set y = GetUnitY(bossPlayMan[1])+GetRandomReal(-100,100)
        endif 
        call delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\Resurrect.mdx",x,y),210)
        set FP_X = x 
        set FP_Y = y 
        call TimerStart(CreateTimer(),3,false,function spell_FirePillar_Delayed_30)
    endfunction
    
    //======================================================================
    // 火焰献祭
    //======================================================================
    private function spell_FireImmolation_Delayed_10 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif
        call event_ResetPause()
    endfunction
    private function FIREIMMOLATION_END takes nothing returns nothing
        local real dmg = bossAbilityRealData[4]*bossDamageMultiple
        local mybuff bf = mybuff.currentBuff
        local real x = GetUnitX(bf.buffTarget)
        local real y = GetUnitY(bf.buffTarget)
        local real a = GetUnitFacing(bf.buffTarget)/57.2956
        local effect sfx = AddSpecialEffectEX("war3campImported\\ronghuopenshe.mdl",x,y)
        local group pick = CreateGroup()
        call BlzSetSpecialEffectHeightEX(sfx,100)
        call BlzSetSpecialEffectYaw(sfx,a)
        call delayedDestroyEffect(sfx,35)
        call GroupEnumUnitsInRange(pick,x+900*Cos(a),y+900*Sin(a),1800,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            if RAbsBJ(DisByUnXY(FirstOfGroup(pick),x,y)*Sin(a-AngleByXYnU(x,y,FirstOfGroup(pick))/57.2956)) < 100 and Cos(a-AngleByXYnU(x,y,FirstOfGroup(pick))/57.2956) > 0 then 
                set damageTag_Fire = true 
                set damageIsAOE = true 
                set damageFlag = 'ANfs'
                if FirstOfGroup(pick) == bf.buffTarget then 
                    call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg/2,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
                else 
                    call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
                endif 
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl",FirstOfGroup(pick),"origin"))
            endif 
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
        set sfx = null 
    endfunction
    private function FIREIMMOLATION_DOT takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local real dmg = bossAbilityRealData[3]*bossDamageMultiple*bf.realData*mybuff.buffTimeScale
        set bf.realData = bf.realData*1.1

        set damageFlag = 'AEim' 
        set damageIsDOT = true 
        set damageTag_Fire = true 
        set damageTag_Ignite = true 
        call UnitDamageTarget(bossBindUnit,bf.buffTarget,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
    endfunction
    private function spell_FireImmolation_Delayed_5 takes nothing returns nothing
        local mybuff bf = 0
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif
        set bf = CreateBuff(bossBindUnit,bossPlayMan[2],BUFFTYPE_FIREIMMOLATION,1000)
        set bf.realData = RMaxBJ(1,bf.realData)
        set bf.periodTime = 50
        call bf.addPeriod(function FIREIMMOLATION_DOT)
        call bf.addEnding(function FIREIMMOLATION_END)
        call bf.apply()
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Demon\\ReviveDemon\\ReviveDemon.mdx",bossPlayMan[2],"origin"))
        call TimerStart(CreateTimer(),1,false,function spell_FireImmolation_Delayed_10)
    endfunction
    private function spell_FireImmolation takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[2] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        call GroupRemoveUnit(pick,GetUnitTaunter(bossBindUnit))
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[2] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[2])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[2]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        if bossPlayMan[2] == null then 
            set bossPlayMan[2] = GetUnitTaunter(bossBindUnit)
        endif 
        if bossPlayMan[2] == null or IsUnitInRegion(boss.region,bossPlayMan[2]) == false then 
            return 
        endif 
        set bossFocusTarget = bossPlayMan[2]
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget)
        call TimerStart(CreateTimer(),0.5,false,function spell_FireImmolation_Delayed_5)
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"spell")        
    endfunction

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
        call DestroyEffectEX(GPB_SFX)
        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call DestroyEffectEX(GPB_SFX)
        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 31.811     //火焰之环伤害
            set bossAbilityRealData[1] = 96.471     //大炎爆伤害
            set bossAbilityRealData[2] = 33.773     //烈焰之柱
            set bossAbilityRealData[3] = 5.068      //火焰献祭dot伤害
            set bossAbilityRealData[4] = 46.232     //火焰献祭喷射伤害

            set bossAbilityIntData[0] = 'n62N'

            set boss.timeline = 0
            set boss.timelineMax = 190
            set boss.timelineMin = 0
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(30,function spell_FirePillar)

            call boss.addTimeline(50,function spell_FireRing)

            call boss.addTimeline(60,function spell_GreatPyroBlast)

            call boss.addTimeline(80,function spell_FireImmolation)

            call boss.addTimeline(120,function spell_GreatPyroBlast)

            call boss.addTimeline(140,function spell_FirePillar)

            call boss.addTimeline(180,function spell_FireRing)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "辛格尔 - 火焰之王"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "化成灰烬吧！"
        set bossChatMsg[3] = "主人..."
        set bossChatMsg[4] = "不堪一击。"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)

        set BUFFTYPE_FIREIMMOLATION = bufftype.create('A64X','B654',false,true,true) 
    endfunction
endscope
//======================================================================
// endregion
//======================================================================


//======================================================================
// region BossTrollAbomination
//======================================================================
scope BossTrollAbomination initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n640'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossTrollAbomination_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    //======================================================================
    //  雷霆一击：aoe，减速，击飞
    //======================================================================
    private function Spell_ThunderClap takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"attack")
    endfunction
    private function Spell_ThunderClap_Delayed_3 takes nothing returns nothing
        local mybuff bf = 0
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        local group pick = CreateGroup()
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",bossBindUnit,"origin"))
        call GroupEnumUnitsInRange(pick,GetUnitX(bossBindUnit),GetUnitY(bossBindUnit),900,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageCrushRate = 10000
            set damageFlag = 'AHtc'
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            set bf = CreateBuff(spellCaster,FirstOfGroup(pick),BUFFTYPE_THUNDERCLAP,500)
            set bf.bonusAttackSpeed = -2500
            set bf.bonusMoveSpeed_P = -4500
            call bf.apply()
            call KnockbackTargetEx(bossBindUnit,FirstOfGroup(pick),350,550,0.3)
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction

    //======================================================================
    // 狂暴
    //======================================================================
    private function Spell_Frenzy takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"attack spell slam")
    endfunction
    private function Spell_Frenzy_Delayed_5 takes nothing returns nothing
        local mybuff bf = CreateBuff(bossBindUnit,bossBindUnit,BUFFTYPE_FRENZY,3000)
        set bf.bonusAttackSpeed = 10000
        call bf.apply()
        call PlaySndEx(SND_BLOODLUST)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl",bossBindUnit,"origin"))
    endfunction

    //======================================================================
    // 落石
    //======================================================================
    private function Spell_RockFall_Delayed takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,100,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageCrushRate = 10000
            set damageFlag = 'ACtb'
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WOOD_HEAVY_BASH)
            call applyStun(bossBindUnit,FirstOfGroup(pick),'ATB0')
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl",x+50,y+50))
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl",x-50,y+50))
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl",x+50,y-50))
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl",x-50,y-50))
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl",x,y))
    endfunction
    private function Spell_RockFall takes nothing returns nothing
        local delayedevent de = 0
        local effect sfx = null 
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop
            set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[0])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[0]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        if bossPlayMan[0] == null or alive(bossPlayMan[0]) == false or IsUnitInRegion(boss.region,bossPlayMan[0]) == false then 
            return 
        endif 
        set de = CreateDelayedEvent(370,1,function Spell_RockFall_Delayed)
        call de.saveReal("X",GetUnitX(bossPlayMan[0]))
        call de.saveReal("Y",GetUnitY(bossPlayMan[0]))
        call delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\CavernDustFallingRock.mdx",GetUnitX(bossPlayMan[0]),GetUnitY(bossPlayMan[0])),250)
        set sfx = AddSpecialEffectEX("war3campImported\\hiveNewModels\\IlluminaRing_red.mdl",GetUnitX(bossPlayMan[0]),GetUnitY(bossPlayMan[0]))
        call BlzSetSpecialEffectColor(sfx,125,0,0)
        call BlzSetSpecialEffectScale(sfx,1.75)
        call delayedDestroyEffect(sfx,370)
        set sfx = null 
    endfunction
    
    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 

        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 22.545      //雷霆一击伤害
            set bossAbilityRealData[1] = 66.545      //落石伤害

            set boss.timeline = 0
            set boss.timelineMax = 350
            set boss.timelineMin = 64
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()
            
            call boss.addTimeline(50,function Spell_ThunderClap)
            call boss.addTimeline(53,function Spell_ThunderClap_Delayed_3)
            call boss.addTimeline(60,function event_ResetPause)
            
            call boss.addTimeline(100,function Spell_Frenzy)
            call boss.addTimeline(105,function Spell_Frenzy_Delayed_5)
            call boss.addTimeline(115,function event_ResetPause)

            call boss.addTimeline(116,function Spell_RockFall)
            call boss.addTimeline(126,function Spell_RockFall)
            call boss.addTimeline(136,function Spell_RockFall)

            call boss.addTimeline(220,function Spell_ThunderClap)
            call boss.addTimeline(223,function Spell_ThunderClap_Delayed_3)
            call boss.addTimeline(230,function event_ResetPause)

            call boss.addTimeline(236,function Spell_RockFall)
            call boss.addTimeline(246,function Spell_RockFall)
            call boss.addTimeline(256,function Spell_RockFall)

            call boss.addTimeline(300,function Spell_ThunderClap)
            call boss.addTimeline(303,function Spell_ThunderClap_Delayed_3)
            call boss.addTimeline(310,function event_ResetPause)

            call boss.addTimeline(325,function Spell_RockFall)
            call boss.addTimeline(335,function Spell_RockFall)
            call boss.addTimeline(345,function Spell_RockFall)


            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "尸骸巨怪"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "激活台词"
        set bossChatMsg[3] = "死亡台词"
        set bossChatMsg[4] = "重置台词"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================


//======================================================================
// region BossTrollChampionDarkanro
//======================================================================
scope BossTrollChampionDarkanro initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n63Y'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossTrollChampionDarkanro_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        if GetUnitTypeId(GetFilterUnit()) == bossAbilityIntData[0] then 
            return true 
        endif 
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    //======================================================================
    //  技能：召唤骷髅
    //======================================================================
    private function Spell_SummonSkeleton takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"spell")
    endfunction
    private function Spell_SummonSkeleton_Delayed_10_Per_1_Loop_5 takes nothing returns nothing
        local real x = GetRandomReal(GetRectMinX(bossAbilityRandomRect),GetRectMaxX(bossAbilityRandomRect))
        local real y = GetRandomReal(GetRectMinY(bossAbilityRandomRect),GetRectMaxY(bossAbilityRandomRect))
        local location loc = Location(x,y)
        local unit nu
        local integer i = 0
        loop 
            set i = i+1
            exitwhen i > 60 or IsLocationInRegion(boss.region,loc)
            call RemoveLocation(loc)
            set x = GetRandomReal(GetRectMinX(bossAbilityRandomRect),GetRectMaxX(bossAbilityRandomRect))
            set y = GetRandomReal(GetRectMinY(bossAbilityRandomRect),GetRectMaxY(bossAbilityRandomRect))
        endloop
        if IsLocationInRegion(boss.region,loc) then 
            set nu = CreateUnit(GetOwningPlayer(bossBindUnit),bossAbilityIntData[0],x,y,AngleByXYnU(x,y,bossBindUnit))
            call UnitApplyTimedLife(nu,'BTLF',60)
            call delayedPauseUnit(nu,150)
            call delayedPlayAnimation(nu,"birth",200)
            if GetUnitTaunter(bossBindUnit) != null then 
                call Taunt(GetUnitTaunter(bossBindUnit),nu)
            endif 
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl",x,y))
            call UnitAddType(nu,UNIT_TYPE_SUMMONED)
            call RegisterEnemy(nu)
            call UnitShareVision(nu,PLAYER,true)
        endif 
        call RemoveLocation(loc)
        set loc = null
        set nu = null  
    endfunction

    //======================================================================
    // 重击，打t，巨大伤害
    //======================================================================
    private function Spell_Slam takes nothing returns nothing
        local group pick = null 
        set bossPlayMan[1] = null 
        set bossPlayMan[1] = GetUnitTaunter(bossBindUnit)
        if bossPlayMan[1] == null or alive(bossPlayMan[1]) == false then 
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
            loop 
                set bossPlayMan[1] = GroupPickRandomUnitEx(pick)
                call GroupRemoveUnit(pick,bossPlayMan[1])
                exitwhen IsUnitInRegion(boss.region,bossPlayMan[1]) or FirstOfGroup(pick) == null 
            endloop
            call DestroyGroup(pick)
            set pick = null 
        endif 
        if bossPlayMan[1] == null or alive(bossPlayMan[1]) == false then
            return 
        endif 
        call PauseUnit(bossBindUnit,true)
        call ChargeUnit(bossBindUnit,bossPlayMan[1],1000,0.2,100,false,null,null)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[1]))
        call SetUnitAnimation(bossBindUnit,"attack slam")
        call delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\Lightning Bolt.mdx",bossBindUnit,"weapon"),100)
    endfunction
    private function Spell_Slam_Delay_5 takes nothing returns nothing
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        if alive(bossPlayMan[1]) and bossPlayMan[1] != null then 
            set damageTag_Arcane = true 
            set damageTag_Lightning = true 
            set damageTag_Attack = true 
            set damageFlag = 'AHbh'
            call UnitDamageTarget(bossBindUnit,bossPlayMan[1],dmg,true,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_METAL_HEAVY_CHOP)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\Bolt\\BoltImpact.mdl",bossPlayMan[1],"origin"))
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl",bossPlayMan[1],"origin"))
        endif 
        set bossPlayMan[1] = null 
    endfunction

    //======================================================================
    // 风暴之锤，aoe，磁力吸附，静电爆炸，R=320，0.4前摇
    //======================================================================
    globals
        private real ThunderBoltX = 0
        private real ThunderBoltY = 0
        private effect ThunderBoltSFX = null 
    endglobals
    private function event_FocusOnThunderBoltTarget takes nothing returns nothing
        call SetUnitFacing(bossBindUnit, AngleByUnXY(bossBindUnit,ThunderBoltX,ThunderBoltY))
    endfunction
    private function Spell_ThunderBolt_SFX takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        if bossPlayMan[0] == null or alive(bossPlayMan[0]) == false then 
            set de.DESTROY = true 
            return 
        endif 
        set ThunderBoltX = GetUnitX(bossPlayMan[0])
        set ThunderBoltY = GetUnitY(bossPlayMan[0])
        call BlzSetSpecialEffectX(de.loadEffect("SFX"),ThunderBoltX)
        call BlzSetSpecialEffectY(de.loadEffect("SFX"),ThunderBoltY)
    endfunction
    private function Spell_ThunderBolt takes nothing returns nothing
        local delayedevent de = 0
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        elseif CountUnitsInGroup(pick) > 1 then
            call GroupRemoveUnit(pick,GetUnitTaunter(bossBindUnit))
        endif 
        set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
        set ThunderBoltX = GetUnitX(bossPlayMan[0])
        set ThunderBoltY = GetUnitY(bossPlayMan[0])
        call DestroyGroup(pick)
        set pick = null 
        set de = CreateDelayedEvent(2,125,function Spell_ThunderBolt_SFX)
        set ThunderBoltSFX = delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\magneticfield04.mdl",GetUnitX(bossPlayMan[0]),GetUnitY(bossPlayMan[0])),1000)
        call de.saveEffect("SFX",ThunderBoltSFX)
    endfunction
    private function Spell_ThunderBolt_Delayed_21 takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"spell throw")
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnThunderBoltTarget)
        call SetUnitFacing(bossBindUnit,AngleByUnXY(bossBindUnit,ThunderBoltX,ThunderBoltY))
    endfunction
    private function Spell_ThunderBoltExplosion takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,285,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageFlag = 'AHtc'
            set damageTag_Arcane = true 
            set damageTag_Lightning= true 
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call applyStun(bossBindUnit,FirstOfGroup(pick),'ATB0')
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",x,y))
    endfunction
    private function Spell_ThunderBoltHit takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(250,1,function Spell_ThunderBoltExplosion)
        local mybuff bf = 0
        local projectile proj = projectile.currentProjectile
        local real x = proj.target_x
        local real y = proj.target_y
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,320,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageCrushRate = 10000
            set damageFlag = 'AHtb'
            set damageTag_Arcane = true 
            set damageTag_Lightning= true 
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            call KnockbackLocEx(FirstOfGroup(pick),x,y,1000,0.3)
            set bf = CreateBuff(spellCaster,FirstOfGroup(pick),BUFFTYPE_THUNDERCLAP,500)
            set bf.bonusAttackSpeed = -2500
            set bf.bonusMoveSpeed_P = -4500
            call bf.apply()
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
        if ThunderBoltSFX != null then 
            call DestroyEffectEX(ThunderBoltSFX)
            set ThunderBoltSFX = null 
        endif 
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",x,y))
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
        call delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\magnetizecastaoe2.mdl",x,y),250)
        call BlzSetSpecialEffectScale(delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\OrbOfLightning.mdx",x,y),250),3)
    endfunction
    private function Spell_ThunderBolt_Delayed_25 takes nothing returns nothing
        local projectile proj = CreateProjectileToLoc(bossBindUnit,ThunderBoltX,ThunderBoltY,750,0.3,"Abilities\\Weapons\\RexxarMissile\\RexxarMissile.mdl",null,function Spell_ThunderBoltHit)
        set proj.model_attach = "origin"
        set proj.flag = 'AHtb'
        call proj.launch()
        call SetUnitScale(proj.dummy,2,2,2)
        set proj.bindSFX_0 = AddSpecialEffectTargetEX("war3campImported\\OrbOfLightning.mdx",proj.dummy,"origin")
        call PauseTimer(bossFocusTimer)
    endfunction
    
    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
        call DestroyEffectEX(ThunderBoltSFX)
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
        call DestroyEffectEX(ThunderBoltSFX)
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 

        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 34.545      //风暴之锤击中伤害
            set bossAbilityRealData[1] = 57.792      //风暴之锤爆炸伤害
            set bossAbilityRealData[2] = 99.792      //重击伤害

            set bossAbilityIntData[0] = 'n641'       //召唤骷髅

            set boss.timeline = 0
            set boss.timelineMax = 225
            set boss.timelineMin = 0
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()
            
            call boss.addTimeline(40,function Spell_ThunderBolt)
            call boss.addTimeline(61,function Spell_ThunderBolt_Delayed_21)
            call boss.addTimeline(65,function Spell_ThunderBolt_Delayed_25)
            call boss.addTimeline(69,function event_ResetPause)
            
            call boss.addTimeline(100,function Spell_Slam)
            call boss.addTimeline(105,function Spell_Slam_Delay_5)
            call boss.addTimeline(110,function event_ResetPause)
            
            call boss.addTimeline(150,function Spell_SummonSkeleton)
            call boss.addTimeline(160,function Spell_SummonSkeleton_Delayed_10_Per_1_Loop_5)
            call boss.addTimeline(161,function Spell_SummonSkeleton_Delayed_10_Per_1_Loop_5)
            call boss.addTimeline(162,function Spell_SummonSkeleton_Delayed_10_Per_1_Loop_5)
            call boss.addTimeline(163,function Spell_SummonSkeleton_Delayed_10_Per_1_Loop_5)
            call boss.addTimeline(164,function Spell_SummonSkeleton_Delayed_10_Per_1_Loop_5)
            call boss.addTimeline(165,function event_ResetPause)
            
            call boss.addTimeline(190,function Spell_Slam)
            call boss.addTimeline(195,function Spell_Slam_Delay_5)
            call boss.addTimeline(200,function event_ResetPause)


            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "达坎罗"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "献给...巫妖王...更多..."
        set bossChatMsg[3] = "我终将...永恒..."
        set bossChatMsg[4] = "献祭...继续...献祭..."
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================


//======================================================================
// region BossTrollNecroShaman
//======================================================================
scope BossTrollNecroShaman initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n63Z'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossTrollNecroShaman_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        if GetUnitTypeId(GetFilterUnit()) == bossAbilityIntData[0] then 
            return true 
        endif 
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    //======================================================================
    //  痛苦诅咒
    //======================================================================
    private function CURSE_OF_PAIN_DRAIN_LIFE takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local real heal = proj.realData*5
        set healFlag = 'A62Y'
        call UnitHealTarget(proj.target,proj.target,heal)
        call delayedDestroyEffect(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Heal\\HealTarget.mdl",proj.target,"origin"),183)
    endfunction
    private function CURSE_OF_PAIN_DAMAGE takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local unit ds = bf.buffSource
        local unit dt = bf.buffTarget
        local real dmg = bf.realData*mybuff.buffTimeScale
        local projectile proj = CreateProjectileToUnit(dt,ds,700,0.3,"war3campImported\\TrollBonecaster_Missile.mdl",function CURSE_OF_PAIN_DRAIN_LIFE,null)
        set proj.realData = dmg 
        call proj.launch()
        set damageFlag = 'A62Y'
        set damageTag_Shadow = true 
        set damageIsDOT = true 
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        set ds = null 
        set dt = null 
    endfunction
    private function Spell_CurseOfPain takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        if CountUnitsInGroup(pick) > 1 then 
            call GroupRemoveUnit(pick,GetUnitTaunter(bossBindUnit))
        endif 
        set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[0]))
        call SetUnitAnimation(bossBindUnit,"attack")
    endfunction
    private function Spell_CurseOfPain_Delayed_4 takes nothing returns nothing
        local mybuff bf = mybuff.create(bossBindUnit,bossPlayMan[0],BUFFTYPE_CURSEOFPAIN)
        set bf.lastTime = 3000
        set bf.periodTime = 200
        call bf.addPeriod(function CURSE_OF_PAIN_DAMAGE)
        set bf.realData = bossAbilityRealData[1]*bossDamageMultiple
        set bf.intData = MAP_EXTRA_LEVEL
        set bf.bonusAccuracy = -3000
        set bf.bindSFX = AddSpecialEffectTargetEX("war3campImported\\shamanyouranus-shadowymissile.mdx",bossPlayMan[0],"chest")
        call bf.apply()
    endfunction

    //======================================================================
    //  邪魂图腾，弹射攻击，法力闪耀
    //======================================================================
    private function Spell_EvilSoulTotem takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"attack")
    endfunction
    private function Spell_EvilSoulTotem_Delayed_4 takes nothing returns nothing
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local real x = GetUnitX(bossBindUnit)+275*Cos(a)
        local real y = GetUnitY(bossBindUnit)+275*Sin(a)
        local unit nu = null 
        set nu = CreateUnit(GetOwningPlayer(bossBindUnit),bossAbilityIntData[0],x,y,270)
        call UnitApplyTimedLife(nu,'BTLF',60)
        call delayedPauseUnit(nu,230)
        call delayedPlayAnimation(nu,"birth",236)
        call unitAddState(nu,STATE_RESISTANCE,5000)
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\Unsummon\\UnsummonTarget.mdl",x,y))
        call UnitAddType(nu,UNIT_TYPE_SUMMONED)
        call RegisterEnemy(nu)
        call UnitShareVision(nu,PLAYER,true)
        set nu = null 
    endfunction

    //======================================================================
    //  暗影波动，aoe+自疗，跳跃
    //======================================================================
    globals 
        private effect bindHandLeft = null 
        private effect bindHandRight = null 
        private Bar bar = 0
    endglobals
    private function SHADOWWAVE_HIT takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local unit ds = proj.source
        local unit dt = proj.target 
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        local real heal = bossAbilityRealData[0]*bossDamageMultiple*10
        if IsUnitEnemy(ds,GetOwningPlayer(dt)) then 
            call proj.applyDamageSet()
            set damageTag_Shadow = true 
            set damageFlag = 'ABC5'
            call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("war3campImported\\shamanyouranus-shadowymissile.mdx",dt,"chest"))
        else
            call proj.applyHealSet()
            set healFlag = 'ABC5'
            call UnitHealTarget(ds,dt,heal)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\AIre\\AIreTarget.mdl",dt,"origin"))
        endif 
        call UnitsAddLightningSFX(proj.bounce_lastTarget,0,0,50,dt,0,0,50,"FORK",0.75,0.33,false).setColor(1,0.7,1,0.7)
        set proj.TARGET_ALLY = true 
        set proj.TARGET_ENEMY = true 
        set ds = null 
        set dt = null 
    endfunction
    private function Spell_ShadowWave_Delayed_40 takes nothing returns nothing
        local projectile proj
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif
        if GetUnitCurrentOrder(bossBindUnit) == ORDER_channel then 
            set proj = CreateProjectileToUnit(bossBindUnit,bossPlayMan[0],2000,0,"Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl",function SHADOWWAVE_HIT,null)
            set proj.tag_Shadow = true
            set proj.flag = 'ABC5'
            set proj.maxBounceLimit = 10
            set proj.bounceRange = 650
            set proj.bounceMultiplier = 1 
            call proj.launch()
            call SetUnitScale(proj.dummy,2,2,2)
        endif 
    endfunction
    private function Spell_ShadowWave_Delayed_37 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif
        if GetUnitCurrentOrder(bossBindUnit) == ORDER_channel then 
            call SetUnitAnimation(bossBindUnit,"attack")
            call TimerStart(CreateTimer(),0.3,false,function Spell_ShadowWave_Delayed_40)
        endif 
    endfunction
    function UNIT_n63Z_SPELL_READY takes nothing returns nothing
        if castingSpell == 'ABC5' then 
            set boss.pauseTL = true 
            call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,-1)
            call DestroyEffectEX(bindHandLeft)
            call DestroyEffectEX(bindHandRight)
            set bindHandLeft = AddSpecialEffectTargetEX("war3campImported\\darkhands.mdx",bossBindUnit,"hand left")
            set bindHandRight = AddSpecialEffectTargetEX("war3campImported\\darkhands.mdx",bossBindUnit,"hand right")
            call TimerStart(CreateTimer(),3.7,false,function Spell_ShadowWave_Delayed_37)
            call PlaySndEx(SND_DING)
            set bar = CreateBar(400,1,bossBindUnit)
        endif 
    endfunction
    function UNIT_n63Z_SPELL_STOP takes nothing returns nothing
        if castingSpell == 'ABC5' then 
            set boss.pauseTL = false
            call event_ResetPause()
            set bossFocusTarget = null
            if bar > 0 then 
                call bar.destroy()
                set bar = 0
            endif 
            if bossBindUnit != null and alive(bossBindUnit) then 
                call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,1)
                //call BJDebugMsg("stop"+I2S(unitGetAllBonusStateValue(bossBindUnit,STATE_IMMUNE_SNARE)))
                call DestroyEffectEX(bindHandLeft)
                call DestroyEffectEX(bindHandRight)
            endif 
        endif 
    endfunction
    private function Spell_ShadowWave takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[0])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[0]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call removeAllDisabilities(bossBindUnit)
        call UnitAddAbilityEx(bossBindUnit,'ABC5')
        call IssueTargetOrderById(bossBindUnit,ORDER_channel,bossPlayMan[0])
        set bossFocusTarget = bossPlayMan[0]
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget)
    endfunction

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 47.545 //暗影波伤害（治疗是10倍）
            set bossAbilityRealData[1] = 12.545 //痛苦诅咒伤害

            set bossAbilityIntData[0] = 'n642'  //邪魂图腾

            set boss.timeline = 0
            set boss.timelineMax = 200
            set boss.timelineMin = 0
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(50,function Spell_ShadowWave)

            call boss.addTimeline(80,function Spell_EvilSoulTotem)
            call boss.addTimeline(84,function Spell_EvilSoulTotem_Delayed_4)
            call boss.addTimeline(89,function event_ResetPause)

            call boss.addTimeline(130,function Spell_CurseOfPain)
            call boss.addTimeline(134,function Spell_CurseOfPain_Delayed_4)
            call boss.addTimeline(139,function event_ResetPause)

            call boss.addTimeline(180,function Spell_CurseOfPain)
            call boss.addTimeline(184,function Spell_CurseOfPain_Delayed_4)
            call boss.addTimeline(189,function event_ResetPause)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "哈基德"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "让我尝一尝你们的灵魂..."
        set bossChatMsg[3] = "不！...主人...许诺的...不...朽..."
        set bossChatMsg[4] = "啊，多么鲜美！"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================


//======================================================================
// region BossTrollKing
//======================================================================
scope BossTrollKing initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n63X'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossTrollKing_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction

    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    //======================================================================
    //  闪电链，aoe
    //======================================================================
    globals 
        private effect bindHandLeft = null 
        private effect bindHandRight = null 
        private Bar bar = 0
    endglobals
    private function CHAINLIGHTNING_HIT takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local unit ds = proj.source
        local unit dt = proj.target 
        local real dmg = bossAbilityRealData[4]*bossDamageMultiple
        call proj.applyDamageSet()
        set damageTag_Lightning = true
        set damageFlag = 'ABC6'
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\Bolt\\BoltImpact.mdl",dt,"origin"))
        call UnitsAddLightningSFX(proj.bounce_lastTarget,0,0,50,dt,0,0,50,"FORK",0.75,0.33,false)
        set ds = null 
        set dt = null 
    endfunction
    private function Spell_ChainLightning_Delayed_30 takes nothing returns nothing
        local projectile proj
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif
        if GetUnitCurrentOrder(bossBindUnit) == ORDER_channel then 
            set proj = CreateProjectileToUnit(bossBindUnit,bossPlayMan[3],2000,0,"Abilities\\Spells\\Orc\\LightningBolt\\LightningBoltMissile.mdl",function CHAINLIGHTNING_HIT,null)
            set proj.tag_Shadow = true
            set proj.flag = 'ABC6'
            set proj.maxBounceLimit = 5
            set proj.bounceRange = 650
            set proj.bounceMultiplier = 0.75
            call proj.launch()
        endif 
    endfunction
    private function Spell_ChainLightning_Delayed_27 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif
        if GetUnitCurrentOrder(bossBindUnit) == ORDER_channel then 
            call SetUnitAnimation(bossBindUnit,"spell one")
            call TimerStart(CreateTimer(),0.3,false,function Spell_ChainLightning_Delayed_30)
        endif 
    endfunction
    function UNIT_n63X_SPELL_READY takes nothing returns nothing
        if castingSpell == 'ABC6' then 
            set boss.pauseTL = true 
            call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,-1)
            call DestroyEffectEX(bindHandLeft)
            call DestroyEffectEX(bindHandRight)
            set bindHandLeft = AddSpecialEffectTargetEX("war3campImported\\OrbOfLightning.mdx",bossBindUnit,"hand left")
            set bindHandRight = AddSpecialEffectTargetEX("war3campImported\\OrbOfLightning.mdx",bossBindUnit,"hand right")
            call TimerStart(CreateTimer(),2.7,false,function Spell_ChainLightning_Delayed_27)
            call PlaySndEx(SND_DING)
            set bar = CreateBar(300,1,bossBindUnit)
        endif 
    endfunction
    function UNIT_n63X_SPELL_STOP takes nothing returns nothing
        if castingSpell == 'ABC6' then 
            set boss.pauseTL = false
            call event_ResetPause()
            set bossFocusTarget = null
            if bar > 0 then 
                call bar.destroy()
                set bar = 0
            endif 
            if bossBindUnit != null and alive(bossBindUnit) then 
                call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,1)
                //call BJDebugMsg("stop"+I2S(unitGetAllBonusStateValue(bossBindUnit,STATE_IMMUNE_SNARE)))
                call DestroyEffectEX(bindHandLeft)
                call DestroyEffectEX(bindHandRight)
            endif 
        endif 
    endfunction
    private function Spell_ChainLightning takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[3] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[3] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[3])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[3]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call removeAllDisabilities(bossBindUnit)
        call UnitAddAbilityEx(bossBindUnit,'ABC6')
        call IssueTargetOrderById(bossBindUnit,ORDER_channel,bossPlayMan[3])
        set bossFocusTarget = bossPlayMan[3]
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget)
    endfunction

    //======================================================================
    //  踢飞，攻击最近非T
    //======================================================================
    private function Spell_Kick_Delayed_300 takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local real dmg = bossAbilityRealData[3]*bossDamageMultiple
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,200,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Lightning = true 
            set damageIsAOE = true 
            set damageFlag = 'AHct'
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",x,y))
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl",x,y))
    endfunction
    private function Spell_Kick_Knockbacked takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local real x = GetUnitX(proj.source)
        local real y = GetUnitY(proj.source)
        local delayedevent de = CreateDelayedEvent(300,1,function Spell_Kick_Delayed_300)
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
        call delayedDestroyEffect(AddSpecialEffectEX("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl",x,y),300)
    endfunction
    private function Spell_Kick_Hit takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local unit ds = proj.source
        local unit dt = proj.target 
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        set damageFlag = 'AHtb'
        set damageTag_Attack = true
        set damageTag_Bleed = true  
        set damageCrushRate = 10000
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WOOD_HEAVY_BASH)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",dt,"origin"))
        call KnockbackLocEx(dt,GetUnitX(dt)+350*Cos(AngleByUnits(ds,dt)/57.2956),GetUnitY(dt)+350*Sin(AngleByUnits(ds,dt)/57.2956),500,0).addOnEnd(function Spell_Kick_Knockbacked)
        call applyStun(ds,dt,'ATB1')
        set ds = null 
        set dt = null 
    endfunction
    private function Spell_Kick takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[2] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        if CountUnitsInGroup(pick) > 1 then 
            call GroupRemoveUnit(pick,GetUnitTaunter(bossBindUnit))
        endif 
        set bossPlayMan[2] = GetClosestUnit(bossBindUnit,pick)
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[2]))
        call SetUnitAnimation(bossBindUnit,"spell two")
        set ChargeUnit(bossBindUnit,bossPlayMan[2],1200,0,100,false,null,function Spell_Kick_Hit).maxTime = 75
    endfunction

    //======================================================================
    //  迅猛龙扑击，攻击最远单体，3次
    //======================================================================
    private function Spell_Charge_Hit takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local unit ds = proj.source
        local unit dt = proj.target 
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        set damageFlag = 'Auco'
        set damageTag_Attack = true
        set damageTag_Bleed = true  
        set damageCrushRate = 10000
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WOOD_HEAVY_BASH)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl",dt,"origin"))
        call KnockbackLocEx(dt,GetUnitX(dt)+150*Cos(AngleByUnits(ds,dt)/57.2956),GetUnitY(dt)+150*Sin(AngleByUnits(ds,dt)/57.2956),300,0)
        call applyStun(ds,dt,'ATB1')
        set ds = null 
        set dt = null 
    endfunction
    private function Spell_Charge takes nothing returns nothing
        local projectile proj = 0
        local group pick = CreateGroup()
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        set bossPlayMan[0] = GetFarthestUnit(bossBindUnit,pick)
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[0]))
        call SetUnitTimeScale(bossBindUnit,2)
        call SetUnitAnimation(bossBindUnit,"spell slam")
        set proj = ChargeUnit(bossBindUnit,bossPlayMan[0],1800,0.2,100,false,null,function Spell_Charge_Hit)
        set proj.maxTime = 45
        set proj.bindSFX_0 = AddSpecialEffectTargetEX("war3campImported\\Sweep_Wind_Small.mdx",bossBindUnit,"hand left")
        set proj.bindSFX_1 = AddSpecialEffectTargetEX("war3campImported\\Sweep_Wind_Small.mdx",bossBindUnit,"hand right")
        set proj.bindSFX_2 = AddSpecialEffectTargetEX("war3campImported\\Sweep_Wind_Small.mdx",bossBindUnit,"hand chest")
    endfunction

    //======================================================================
    // 重击，打t，巨大伤害，击晕1秒
    //======================================================================
    private function Spell_Slam takes nothing returns nothing
        local group pick = null 
        set bossPlayMan[1] = null 
        set bossPlayMan[1] = GetUnitTaunter(bossBindUnit)
        if bossPlayMan[1] == null or alive(bossPlayMan[1]) == false then 
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
            loop 
                set bossPlayMan[1] = GroupPickRandomUnitEx(pick)
                call GroupRemoveUnit(pick,bossPlayMan[1])
                exitwhen IsUnitInRegion(boss.region,bossPlayMan[1]) or FirstOfGroup(pick) == null 
            endloop
            call DestroyGroup(pick)
            set pick = null 
        endif 
        if bossPlayMan[1] == null or alive(bossPlayMan[1]) == false then
            return 
        endif 
        call PauseUnit(bossBindUnit,true)
        call ChargeUnit(bossBindUnit,bossPlayMan[1],2000,0,100,false,null,null)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[1]))
        call SetUnitAnimationByIndex(bossBindUnit,17)
        call delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\Sweep_Blood_Large.mdx",bossBindUnit,"weapon"),100)
        call delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\BloodStrikeSmall.mdx",bossBindUnit,"weapon"),100)
    endfunction
    private function Spell_Slam_Delay_4 takes nothing returns nothing
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        if alive(bossPlayMan[1]) and bossPlayMan[1] != null then 
            set damageTag_Bleed = true 
            set damageTag_Attack = true 
            set damageFlag = 'AHbh'
            call UnitDamageTarget(bossBindUnit,bossPlayMan[1],dmg,true,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_METAL_HEAVY_CHOP)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl",bossPlayMan[1],"origin"))  
            call DestroyEffectEX(AddSpecialEffectTargetEX("war3campImported\\axeultimsfx_01.mdx",bossPlayMan[1],"origin"))  
            call applyStun(bossBindUnit,bossPlayMan[1],'ATB1')
        endif 
        set bossPlayMan[1] = null 
    endfunction

    
    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u
        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 

        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call DestroyEffectEX(bindHandLeft)
        call DestroyEffectEX(bindHandRight)
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 31.145       //迅猛龙扑击伤害
            set bossAbilityRealData[1] = 105.545      //重击打T伤害
            set bossAbilityRealData[2] = 25.145       //踢飞伤害
            set bossAbilityRealData[3] = 96.357       //踢飞雷击
            set bossAbilityRealData[4] = 51.657       //闪电链

            set boss.timeline = 0
            set boss.timelineMax = 200
            set boss.timelineMin = 0
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()
            
            call boss.addTimeline(40,function Spell_Slam)
            call boss.addTimeline(44,function Spell_Slam_Delay_4)
            call boss.addTimeline(49,function event_ResetPause)
            
            call boss.addTimeline(80,function Spell_Charge)
            call boss.addTimeline(85,function Spell_Charge)
            call boss.addTimeline(90,function Spell_Charge)
            call boss.addTimeline(95,function event_ResetPause)

            call boss.addTimeline(130,function Spell_Kick)
            call boss.addTimeline(139,function event_ResetPause)

            call boss.addTimeline(167,function Spell_ChainLightning)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "玛尔克拉基"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "见证帝王的怒火吧！"
        set bossChatMsg[3] = "我会在彼界等你...僭越者..."
        set bossChatMsg[4] = "我的王国终将复兴！"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================


//======================================================================
// region BossAncientHydra
//======================================================================
scope BossAncientHydra initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n63I'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossAncientHydra_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction

    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    //======================================================================
    // 大电球
    //======================================================================
    globals
        private effect GPB_SFX0 = null 
        private effect GPB_SFX1 = null 
        private effect GPB_SFX2 = null 
        private effect GPB_SFX3 = null 
        private effect GPB_SFX4 = null 
        private effect GPB_SFX5 = null 
        private real GPB_X = 0
        private real GPB_Y = 0
    endglobals
    private function Spell_GreatThunderBolt_Delayed_40 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call event_ResetPause()
    endfunction
    private function GREATTHUNDERBOLT_HIT takes nothing returns nothing
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        local projectile proj = projectile.currentProjectile
        local real x = proj.target_x
        local real y = proj.target_y
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,215,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Lightning = true 
            set damageIsAOE = true 
            set damageFlag = 'ACfs'
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(GPB_SFX0)
        call DestroyEffectEX(GPB_SFX1)
        call DestroyEffectEX(GPB_SFX2)
        call DestroyEffectEX(GPB_SFX3)
        call DestroyEffectEX(GPB_SFX4)
        call DestroyEffectEX(GPB_SFX5)
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",x,y))
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl",x,y))
    endfunction
    private function Spell_GreatThunderBolt_Delayed_35 takes nothing returns nothing
        local projectile proj = 0 
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        set proj = CreateProjectileToLoc(bossBindUnit,GPB_X,GPB_Y,800,0,"war3campImported\\OrbOfLightning.mdx",null,function GREATTHUNDERBOLT_HIT)
        set proj.start_x = 4
        set proj.start_y = 150
        set proj.start_z = 65
        call proj.launch()
        set proj.bindSFX_0 = AddSpecialEffectTargetEX("war3campImported\\Lightning Bolt.mdx",proj.dummy,"chest")
        set proj.bindSFX_1 = AddSpecialEffectTargetEX("war3campImported\\OrbOfWind.mdx",proj.dummy,"chest")
        call SetUnitScale(proj.dummy,2,2,2)
        call TimerStart(CreateTimer(),0.66,false,function Spell_GreatThunderBolt_Delayed_40)
    endfunction
    private function Spell_GreatThunderBolt_Delayed_30 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnXY(bossBindUnit,GPB_X,GPB_Y))
        call SetUnitAnimation(bossBindUnit,"spell")
        call TimerStart(CreateTimer(),0.5,false,function Spell_GreatThunderBolt_Delayed_35)
    endfunction
    private function Spell_GreatThunderBolt takes nothing returns nothing
        local group pick = CreateGroup()
        local real a = 0
        local real x = 0
        local real y = 0
        set bossPlayMan[0] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        call GroupRemoveUnit(pick,GetUnitTaunter(bossBindUnit))
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        endif 
        loop 
            set bossPlayMan[0] = GetFarthestUnit(bossBindUnit,pick)
            call GroupRemoveUnit(pick,bossPlayMan[0])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[0]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        if bossPlayMan[0] == null then 
            set bossPlayMan[0] = GetUnitTaunter(bossBindUnit)
        endif 
        if bossPlayMan[0] == null or IsUnitInRegion(boss.region,bossPlayMan[0]) == false then 
            return 
        endif 
        call TimerStart(CreateTimer(),3,false,function Spell_GreatThunderBolt_Delayed_30)
        set GPB_X = GetUnitX(bossPlayMan[0])
        set GPB_Y = GetUnitY(bossPlayMan[0])
        set a = AngleByUnits(bossBindUnit,bossPlayMan[0])
        set x = GPB_X+100*Cos(a/57.2956)
        set y = GPB_Y+100*Sin(a/57.2956)
        set GPB_SFX0 = AddSpecialEffectEX("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl",x,y)
        set a = a+60
        set x = GPB_X+100*Cos(a/57.2956)
        set y = GPB_Y+100*Sin(a/57.2956)
        set GPB_SFX1 = AddSpecialEffectEX("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl",x,y)
        set a = a+60
        set x = GPB_X+100*Cos(a/57.2956)
        set y = GPB_Y+100*Sin(a/57.2956)
        set GPB_SFX2 = AddSpecialEffectEX("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl",x,y)
        set a = a+60
        set x = GPB_X+100*Cos(a/57.2956)
        set y = GPB_Y+100*Sin(a/57.2956)
        set GPB_SFX3 = AddSpecialEffectEX("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl",x,y)
        set a = a+60
        set x = GPB_X+100*Cos(a/57.2956)
        set y = GPB_Y+100*Sin(a/57.2956)
        set GPB_SFX4 = AddSpecialEffectEX("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl",x,y)
        set a = a+60
        set x = GPB_X+100*Cos(a/57.2956)
        set y = GPB_Y+100*Sin(a/57.2956)
        set GPB_SFX5 = AddSpecialEffectEX("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl",x,y)
    endfunction

    //======================================================================
    // 毒霰，正面3道
    //======================================================================
    private function Spell_ToxicMissile takes nothing returns nothing
        local group pick = null 
        set bossPlayMan[1] = null 
        set bossPlayMan[1] = GetUnitTaunter(bossBindUnit)
        if bossPlayMan[1] == null or alive(bossPlayMan[1]) == false then 
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
            loop 
                set bossPlayMan[1] = GroupPickRandomUnitEx(pick)
                call GroupRemoveUnit(pick,bossPlayMan[1])
                exitwhen IsUnitInRegion(boss.region,bossPlayMan[1]) or FirstOfGroup(pick) == null 
            endloop
            call DestroyGroup(pick)
            set pick = null 
        endif 
        if bossPlayMan[1] == null or alive(bossPlayMan[1]) == false then
            return 
        endif 
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"attack")
        set bossFocusTarget = bossPlayMan[1]
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget)
    endfunction
    private function Spell_ToxicMissile_Dot takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,75,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null
            if unitCheckCooldown(FirstOfGroup(pick),'Acor') then  
                set damageFlag = 'Acor'
                set damageIsDOT = true 
                set damageIsAOE = true 
                set damageTag_Posion = true 
                set damageTag_Earth = true 
                call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
                call unitStartCooldown(FirstOfGroup(pick),'Acor',100)
            endif 
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function Spell_ToxicMissile_Hit takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(50,10,function Spell_ToxicMissile_Dot)
        local projectile proj = projectile.currentProjectile
        local real a = GetUnitFacing(proj.dummy)/57.2956
        local real x = proj.target_x
        local real y = proj.target_y
        local real x1 = x+150*Cos(a)
        local real y1 = y+150*Sin(a)
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        local location loc = Location(x,y)
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,75,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            if unitCheckCooldown(FirstOfGroup(pick),'Acor') then  
                set damageFlag = 'Acor'
                set damageIsDOT = true 
                set damageIsAOE = true 
                set damageTag_Posion = true 
                set damageTag_Earth = true 
                call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
                call unitStartCooldown(FirstOfGroup(pick),'Acor',100)
            endif 
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
        call delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\Toxic Ground.mdx",x,y),500)
        if IsLocationInRegion(boss.region,loc) then 
            set proj = CreateProjectileToLoc(bossBindUnit,x1,y1,450,0.5,"Abilities\\Weapons\\ChimaeraAcidMissile\\ChimaeraAcidMissile.mdl",null,function Spell_ToxicMissile_Hit)
            set proj.model_attach = "origin"
            set proj.flag = 'Acor'
            set proj.LAUNCH_UNIT = false 
            set proj.LAUNCH_LOC = true 
            set proj.source_x = x
            set proj.source_y = y
            call proj.launch()
        endif 
        call RemoveLocation(loc)
        set loc = null 
    endfunction
    private function Spell_ToxicMissile_Delay_7 takes nothing returns nothing
        local projectile proj = 0
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local real x = GetUnitX(bossBindUnit)+150*Cos(a)
        local real y = GetUnitY(bossBindUnit)+150*Sin(a)
        set bossFocusTarget = null 
        call PauseTimer(bossFocusTimer)
        set proj = CreateProjectileToLoc(bossBindUnit,x,y,450,0.5,"Abilities\\Weapons\\ChimaeraAcidMissile\\ChimaeraAcidMissile.mdl",null,function Spell_ToxicMissile_Hit)
        set proj.model_attach = "origin"
        set proj.flag = 'Acor'
        call proj.launch()
        set a = (GetUnitFacing(bossBindUnit)+30)/57.2956
        set x = GetUnitX(bossBindUnit)+150*Cos(a)
        set y = GetUnitY(bossBindUnit)+150*Sin(a)
        set proj = CreateProjectileToLoc(bossBindUnit,x,y,450,0.5,"Abilities\\Weapons\\ChimaeraAcidMissile\\ChimaeraAcidMissile.mdl",null,function Spell_ToxicMissile_Hit)
        set proj.model_attach = "origin"
        set proj.flag = 'Acor'
        call proj.launch()
        set a = (GetUnitFacing(bossBindUnit)-30)/57.2956
        set x = GetUnitX(bossBindUnit)+150*Cos(a)
        set y = GetUnitY(bossBindUnit)+150*Sin(a)
        set proj = CreateProjectileToLoc(bossBindUnit,x,y,450,0.5,"Abilities\\Weapons\\ChimaeraAcidMissile\\ChimaeraAcidMissile.mdl",null,function Spell_ToxicMissile_Hit)
        set proj.model_attach = "origin"
        set proj.flag = 'Acor'
        call proj.launch()
    endfunction

    //======================================================================
    // 海龙卷，分摊R=240
    //======================================================================
    globals
        private real WaterspoutX = 0
        private real WaterspoutY = 0
        private effect WaterspoutSFX0 = null 
        private effect WaterspoutSFX1 = null 
    endglobals
    private function event_FocusOnWaterspoutTarget takes nothing returns nothing
        call SetUnitFacing(bossBindUnit, AngleByUnXY(bossBindUnit,WaterspoutX,WaterspoutY))
    endfunction
    private function Spell_Waterspout_SFX takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local location loc = null 
        if bossPlayMan[2] == null or alive(bossPlayMan[2]) == false then 
            set de.DESTROY = true 
            return 
        endif 
        set WaterspoutX = GetUnitX(bossPlayMan[2])
        set WaterspoutY = GetUnitY(bossPlayMan[2])
        set loc = Location(WaterspoutX,WaterspoutY)
        call BlzSetSpecialEffectPositionLoc(de.loadEffect("SFX0"),loc)
        call BlzSetSpecialEffectPositionLoc(de.loadEffect("SFX1"),loc)
        call RemoveLocation(loc)
        set loc = null 
    endfunction
    private function Spell_Waterspout takes nothing returns nothing
        local delayedevent de = 0
        local group pick = CreateGroup()
        set bossPlayMan[2] = null 
        call GroupEnumUnitsInRect(pick,boss.area,playerHero)
        if CountUnitsInGroup(pick) == 0 then 
            call DestroyGroup(pick)
            set pick = null 
            return 
        elseif CountUnitsInGroup(pick) > 1 then
            call GroupRemoveUnit(pick,GetUnitTaunter(bossBindUnit))
        endif 
        set bossPlayMan[2] = GroupPickRandomUnitEx(pick)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl",bossPlayMan[2],"origin"))
        set WaterspoutX = GetUnitX(bossPlayMan[2])
        set WaterspoutY = GetUnitY(bossPlayMan[2])
        call DestroyGroup(pick)
        set pick = null 
        set de = CreateDelayedEvent(2,200,function Spell_Waterspout_SFX)
        set WaterspoutSFX0 = delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\hiveNewModels\\HealingWater_Light.MDX",GetUnitX(bossPlayMan[2]),GetUnitY(bossPlayMan[2])),1000)
        call BlzSetSpecialEffectScale(WaterspoutSFX0,2)        
        call de.saveEffect("SFX0",WaterspoutSFX0)
        set WaterspoutSFX1 = delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\hiveNewModels\\IlluminaRing.mdl",GetUnitX(bossPlayMan[2]),GetUnitY(bossPlayMan[2])),1000)
        call BlzSetSpecialEffectScale(WaterspoutSFX1,4.5)
        call de.saveEffect("SFX1",WaterspoutSFX1)
    endfunction
    private function Spell_Waterspout_Delayed_41 takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"spell slam")
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnWaterspoutTarget)
        call SetUnitFacing(bossBindUnit,AngleByUnXY(bossBindUnit,WaterspoutX,WaterspoutY))
    endfunction
    private function Spell_WaterspoutExplosion takes nothing returns nothing
        local integer i = 0
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local real dmg = bossAbilityRealData[5]*bossDamageMultiple
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,400,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageFlag = 'ANto'
            set damageTag_Arcane = true 
            set damageTag_Cold = true 
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl",x,y))
        loop
            exitwhen i > 5
            call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl",x+200*Cos(I2R(i)*60/57.2956),y+200*Sin(I2R(i)*60/57.2956)))
            set i = i+1
        endloop
    endfunction
    private function Spell_WaterspoutDot takes nothing returns nothing
        local integer i = 0
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local real dmg = bossAbilityRealData[4]*bossDamageMultiple
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,400,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageFlag = 'ANto'
            set damageTag_Arcane = true 
            set damageTag_Cold = true 
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
        if ModuloInteger(de.loopCount,5) == 0 then 
            call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl",x,y))
        endif 
    endfunction
    private function Spell_WaterspoutPull takes nothing returns nothing
        local integer i = 0
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local real d = 3
        local real a = 0
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,400,playerHero)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set a = AngleByUnXY(FirstOfGroup(pick),x,y)/57.2956
            call SetUnitX(FirstOfGroup(pick),GetUnitX(FirstOfGroup(pick))+d*Cos(a))
            call SetUnitY(FirstOfGroup(pick),GetUnitY(FirstOfGroup(pick))+d*Sin(a))
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function Spell_WaterspoutHit takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(600,1,function Spell_WaterspoutExplosion)
        local mybuff bf = 0
        local projectile proj = projectile.currentProjectile
        local real x = proj.target_x
        local real y = proj.target_y
        local real dmg = bossAbilityRealData[3]*bossDamageMultiple
        local real counts = 0
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,240,playerHero)
        set counts = RMaxBJ(1,I2R(CountUnitsInGroup(pick)))
        set dmg = dmg/counts
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageFlag = 'ANto'
            set damageTag_Arcane = true 
            set damageTag_Cold = true 
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(WaterspoutSFX0)
        set WaterspoutSFX0 = null 
        call DestroyEffectEX(WaterspoutSFX1)
        set WaterspoutSFX1 = null 
        call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl",x,y))
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
        call delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\whirlpool.mdxl",x,y),600)
        set de = CreateDelayedEvent(10,60,function Spell_WaterspoutDot)
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
        set de = CreateDelayedEvent(5,120,function Spell_WaterspoutPull)
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
    endfunction
    private function Spell_Waterspout_Delayed_45 takes nothing returns nothing
        local projectile proj = CreateProjectileToLoc(bossBindUnit,WaterspoutX,WaterspoutY,1250,0.3,"Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl",null,function Spell_WaterspoutHit)
        set proj.model_attach = "origin"
        set proj.flag = 'ANfa'
        set proj.start_z = 180
        call proj.launch()
        call SetUnitScale(proj.dummy,3,3,3)
        set proj.bindSFX_0 = AddSpecialEffectTargetEX("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl",proj.dummy,"origin")
        call PauseTimer(bossFocusTimer)
    endfunction

    //======================================================================
    // 狂暴
    //======================================================================
    private function Spell_Frenzy takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"spell slam")
    endfunction
    private function Spell_Frenzy_Delayed_5 takes nothing returns nothing
        local mybuff bf = CreateBuff(bossBindUnit,bossBindUnit,BUFFTYPE_FRENZY,3000)
        set bf.bonusAttackSpeed = 5000
        call bf.apply()
        call PlaySndEx(SND_BLOODLUST)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl",bossBindUnit,"origin"))
    endfunction

    //======================================================================
    // 咬
    //======================================================================
    globals 
        private integer chargeEndTime = 0
        private boolean chargeActive = false
        private integer chargeRepeatCount = 0
        private real bonusBiteDamage = 1
        private Bar bar = 0
        private boolean needRefreshImmunity = false 
    endglobals
    private function Spell_Bite_Loop3 takes nothing returns nothing
        local real dmg = bossAbilityRealData[6]*bossDamageMultiple*bonusBiteDamage
        if bossBindUnit == null or alive(bossBindUnit) == false then 
            call DestroyTimer(GetExpiredTimer())
            return 
        endif 
        if GetUnitCurrentOrder(bossBindUnit) != ORDER_channel or bossPlayMan[3] == null or alive(bossPlayMan[3]) == false  then 
            call DestroyTimer(GetExpiredTimer())
            set boss.pauseTL = false 
            call event_ResetPause()
        else 
            call applyStun(bossBindUnit,bossPlayMan[3],'ATB1')
            set damageFlag = 'BITE'
            set damageTag_Bleed = true 
            set damageCrushRate = 1000
            call UnitDamageTarget(bossBindUnit,bossPlayMan[3],dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WOOD_MEDIUM_BASH)
            set bonusBiteDamage = bonusBiteDamage+0.1
            call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl",bossPlayMan[3],"origin"))
            call AddUnitLife(bossBindUnit,dmg*5)
            call KnockbackLocEx(bossPlayMan[3],GetUnitX(bossBindUnit)+80*Cos(GetUnitFacing(bossBindUnit)/57.2956),GetUnitY(bossBindUnit)+80*Sin(GetUnitFacing(bossBindUnit)/57.2956),2000,0)
        endif 
    endfunction
    function Spell_Bite_Delayed takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if bossBindUnit == null or alive(bossBindUnit) == false then 
            return 
        endif 
        if GetUnitCurrentOrder(bossBindUnit) != ORDER_channel then 
            return 
        endif 
        
        call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,-1)
        call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,-1)
        call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,-1)
        call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,-1)
        set needRefreshImmunity = true 
        
        call SetBarColor(bar,255,0,0,175)
    endfunction
    function UNIT_n63I_SPELL_READY takes nothing returns nothing
        if castingSpell == 'ABC7' then 
            set needRefreshImmunity = false 
            set boss.pauseTL = true 
            set bonusBiteDamage = 1

            call PlaySndEx(SND_DING)
            set bar = CreateBar(1000,-1,bossBindUnit)
            call SetBarColor(bar,125,125,255,175)
            call TimerStart(CreateTimer(),0.3,true,function Spell_Bite_Loop3)
            call TimerStart(CreateTimer(),2,false,function Spell_Bite_Delayed)
            call Spell_Bite_Loop3()
            call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl",bossPlayMan[3],"origin"))

            call SetUnitTimeScale(bossBindUnit,3.5)
        endif 
    endfunction
    function UNIT_n63I_SPELL_STOP takes nothing returns nothing
        if castingSpell == 'ABC7' then 
            set boss.pauseTL = false
            call event_ResetPause()
            set bossFocusTarget = null
            if bar > 0 then 
                call bar.destroy()
                set bar = 0
            endif 
            if bossBindUnit != null and alive(bossBindUnit) and needRefreshImmunity then 
                call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,1)
                //call BJDebugMsg("stop"+I2S(unitGetAllBonusStateValue(bossBindUnit,STATE_IMMUNE_SNARE)))
            endif 
        endif 
    endfunction
    private function Spell_Bite takes nothing returns nothing
        local group pick = null 
        set bossPlayMan[3] = GetUnitTaunter(bossBindUnit)
        if bossPlayMan[3] == null or alive(bossPlayMan[3]) == false then 
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,boss.area,playerHero)
            set bossPlayMan[3] = GetClosestUnit(bossBindUnit,pick)
            call DestroyGroup(pick)
            set pick = null 
        endif 
        if bossPlayMan[3] == null or alive(bossPlayMan[3]) == false then 
            return 
        endif 
        call removeAllDisabilities(bossBindUnit)
        call UnitAddAbilityEx(bossBindUnit,'ABC7')
        call IssueTargetOrderById(bossBindUnit,ORDER_channel,bossPlayMan[3])
        set bossFocusTarget = bossPlayMan[3]
        call TimerStart(bossFocusTimer,0.03,true,function event_FocusOnTarget)
    endfunction    

    //======================================================================
    // 冲锋
    //======================================================================
    private function CHARGE_HIT takes nothing returns nothing
        local projectile proj
        local real dmg = bossAbilityRealData[7]*bossDamageMultiple-10
        if GetOwningPlayer(waveTarget) == PLAYER then 
            set proj = KnockbackTargetEx(waveCaster,waveTarget,200,600,0.05)
            set damageIsAOE = true 
            set damageCrushRate = 1000
            set damageFlag = 'Auco'
            call UnitDamageTarget(bossBindUnit,waveTarget,dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WOOD_LIGHT_BASH)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\StormBolt\\StormBoltMissile.mdl",waveTarget,"chest"))
        endif 
        //("CHARGE_HIT")
    endfunction
    private function CHARGE_END takes nothing returns nothing
        local group pick = null 
        local projectile proj = projectile.currentProjectile
        if chargeActive == false then 
            return 
        endif 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            set chargeActive = false
            set chargeEndTime = 0
            set chargeRepeatCount = 0
            return 
        endif 
        if globalNowtime >= chargeEndTime then 
            set chargeActive = false
            set chargeRepeatCount = 0
            set boss.pauseTL = false 
            call event_ResetPause()
            set chargeEndTime = 0
        else 
            if chargeRepeatCount >= 8 then 
                set chargeActive = false
                set chargeRepeatCount = 0
                set boss.pauseTL = false 
                call event_ResetPause()
                set chargeEndTime = 0
                return
            endif 
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
            loop 
                set bossPlayMan[4] = GetFarthestUnit(bossBindUnit,pick)
                if bossPlayMan[4] == null then
                    exitwhen true
                endif
                call GroupRemoveUnit(pick,bossPlayMan[4])
                exitwhen IsUnitInRegion(boss.region,bossPlayMan[4]) or FirstOfGroup(pick) == null 
            endloop
            call DestroyGroup(pick)
            set pick = null 
            if bossPlayMan[4] == null or alive(bossPlayMan[4]) == false then 
                set chargeActive = false
                set chargeRepeatCount = 0
                set boss.pauseTL = false 
                call event_ResetPause()
                set chargeEndTime = 0
                return 
            endif 
            set chargeRepeatCount = chargeRepeatCount + 1
            set boss.pauseTL = true 
            call PauseUnit(bossBindUnit,true)
            call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[4]))
            set proj = ChargeTargetEx(bossBindUnit,bossPlayMan[4],1000,125,0,true,522,0,function CHARGE_HIT,function CHARGE_END)
            set proj.maxTime = chargeEndTime-globalNowtime+1
            call SetUnitTimeScale(bossBindUnit,2)
            call SetUnitAnimationByIndex(bossBindUnit,0)
        endif 
        //("CHARGE_END")
    endfunction
    private function Spell_Charge_Period takes nothing returns nothing
        local projectile proj = 0
        local real a = (GetUnitFacing(bossBindUnit)+GetRandomReal(-60,60))/57.2956
        local real x = GetUnitX(bossBindUnit)+GetRandomReal(250,450)*Cos(a)
        local real y = GetUnitY(bossBindUnit)+GetRandomReal(250,450)*Sin(a)
        if chargeActive == false or alive(bossBindUnit) == false or bossBindUnit == null then 
            call DestroyTimer(GetExpiredTimer())
            return 
        endif 
        set bossFocusTarget = null 
        call PauseTimer(bossFocusTimer)
        set proj = CreateProjectileToLoc(bossBindUnit,x,y,450,0.5,"Abilities\\Weapons\\ChimaeraAcidMissile\\ChimaeraAcidMissile.mdl",null,function Spell_ToxicMissile_Hit)
        set proj.model_attach = "origin"
        set proj.flag = 'Acor'
        call proj.launch()
        if chargeEndTime-globalNowtime < 30 or chargeActive == false then 
            call DestroyTimer(GetExpiredTimer())
        endif 
    endfunction
    private function Spell_Charge_SFX takes nothing returns nothing
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        if chargeActive == false or alive(bossBindUnit) == false or bossBindUnit == null then 
            call DestroyTimer(GetExpiredTimer())
            return 
        endif 
        call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl",x+GetRandomReal(-50,50),y+GetRandomReal(-50,50)))
        if chargeEndTime-globalNowtime < 10 or chargeActive == false then 
            call DestroyTimer(GetExpiredTimer())
        endif 
    endfunction
    private function Spell_Charge takes nothing returns nothing
        local projectile proj = 0
        local group pick = null 

        if chargeActive then 
            return
        endif
        set pick = CreateGroup()
        set chargeActive = true
        set chargeRepeatCount = 0
        set chargeEndTime = globalNowtime+500
        call TimerStart(CreateTimer(),0.3,true,function Spell_Charge_Period)
        call TimerStart(CreateTimer(),0.1,true,function Spell_Charge_SFX)

        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        loop 
            set bossPlayMan[4] = GetFarthestUnit(bossBindUnit,pick)
            if bossPlayMan[4] == null then
                exitwhen true
            endif
            call GroupRemoveUnit(pick,bossPlayMan[4])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[4]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        if bossPlayMan[4] == null or alive(bossPlayMan[4]) == false then 
            set chargeActive = false
            set chargeRepeatCount = 0
            set boss.pauseTL = false 
            call event_ResetPause()
            set chargeEndTime = 0
            return 
        endif 
        set boss.pauseTL = true 
        call PauseUnit(bossBindUnit,true)
        call SetUnitFacing(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[4]))
        set proj = ChargeTargetEx(bossBindUnit,bossPlayMan[4],1000,125,0,true,522,0,function CHARGE_HIT,function CHARGE_END)
        set proj.maxTime = chargeEndTime-globalNowtime+1
        call SetUnitTimeScale(bossBindUnit,2)
        call SetUnitAnimationByIndex(bossBindUnit,0)
    endfunction


    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
        call DestroyEffectEX(GPB_SFX0)
        set GPB_SFX0 = null
        call DestroyEffectEX(GPB_SFX1)
        set GPB_SFX1 = null
        call DestroyEffectEX(GPB_SFX2)
        set GPB_SFX2 = null
        call DestroyEffectEX(GPB_SFX3)
        set GPB_SFX3 = null
        call DestroyEffectEX(GPB_SFX4)
        set GPB_SFX4 = null
        call DestroyEffectEX(GPB_SFX5)
        set GPB_SFX5 = null
        call DestroyEffectEX(WaterspoutSFX0)
        set WaterspoutSFX0 = null 
        call DestroyEffectEX(WaterspoutSFX1)
        set WaterspoutSFX1 = null 
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 

        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call DestroyEffectEX(GPB_SFX0)
        set GPB_SFX0 = null
        call DestroyEffectEX(GPB_SFX1)
        set GPB_SFX1 = null
        call DestroyEffectEX(GPB_SFX2)
        set GPB_SFX2 = null
        call DestroyEffectEX(GPB_SFX3)
        set GPB_SFX3 = null
        call DestroyEffectEX(GPB_SFX4)
        set GPB_SFX4 = null
        call DestroyEffectEX(GPB_SFX5)
        set GPB_SFX5 = null
        call DestroyEffectEX(WaterspoutSFX0)
        set WaterspoutSFX0 = null 
        call DestroyEffectEX(WaterspoutSFX1)
        set WaterspoutSFX1 = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 88.275       //大电球伤害
            set bossAbilityRealData[1] = 28.413       //毒霰伤害
            set bossAbilityRealData[2] = 11.066       //毒霰dot伤害
            set bossAbilityRealData[3] = 92.014       //海龙卷击中分摊
            set bossAbilityRealData[4] = 0.514       //海龙卷吸入dot
            set bossAbilityRealData[5] = 95.018       //海龙卷最终爆炸
            set bossAbilityRealData[6] = 15.398       //咬
            set bossAbilityRealData[7] = 19.398       //冲锋

            set boss.timeline = 0
            set boss.timelineMax = 400
            set boss.timelineMin = 20
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()
            
            call boss.addTimeline(63,function Spell_GreatThunderBolt)

            call boss.addTimeline(95,function Spell_ToxicMissile)
            call boss.addTimeline(102,function Spell_ToxicMissile_Delay_7)
            call boss.addTimeline(108,function event_ResetPause)
            
            call boss.addTimeline(130,function Spell_Waterspout)
            call boss.addTimeline(171,function Spell_Waterspout_Delayed_41)
            call boss.addTimeline(175,function Spell_Waterspout_Delayed_45)
            call boss.addTimeline(179,function event_ResetPause)

            call boss.addTimeline(225,function Spell_ToxicMissile)
            call boss.addTimeline(232,function Spell_ToxicMissile_Delay_7)
            call boss.addTimeline(238,function event_ResetPause)

            call boss.addTimeline(260,function Spell_Frenzy)
            call boss.addTimeline(265,function Spell_Frenzy_Delayed_5)
            call boss.addTimeline(269,function event_ResetPause)

            call boss.addTimeline(320,function Spell_Bite)

            call boss.addTimeline(360,function Spell_Charge)
            
            call boss.addTimeline(370,function Spell_GreatThunderBolt)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "远古海兽"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = ""
        set bossChatMsg[3] = ""
        set bossChatMsg[4] = ""
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

//======================================================================
// region BossAzureWelpObi
//======================================================================
scope BossAzureWelpObi initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n64I'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossAzureWelpObi_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction

    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================
    
    //======================================================================
    //  冰波，推开+aoe+冰缓
    //======================================================================
    private function IceWave_Hit takes nothing returns nothing
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        local real x 
        local real y 
        local real a 
        local real d 
        local real xx 
        local real yy
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageTag_Cold = true 
            set damageTag_Arcane = true 
            set damageFlag = 'Afrz' 
            set damageIsAOE = true 
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl",waveTarget,"chest"))
            set x = GetUnitX(waveTarget)
            set y = GetUnitY(waveTarget)
            set a = AngleByUnits(waveWave.dummy,waveTarget)/57.2956
            set d = 150
            set xx = x+d*Cos(a)
            set yy = y+d*Sin(a)
            call KnockbackLocEx(waveTarget,xx,yy,500,0)
            call applyCold(waveCaster,waveTarget,'ACO0')
        endif 
    endfunction
    private function Spell_IceWave_delay_9 takes nothing returns nothing
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local projectile proj = CreateWave(bossBindUnit,GetUnitX(bossBindUnit)+800*Cos(a),GetUnitY(bossBindUnit)+800*Sin(a),600,125,0,"Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathMissile.mdl",function IceWave_Hit,null)
        set proj.model_attach = "origin"
        call proj.launch()
    endfunction
    private function Spell_IceWave takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        loop 
            set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[0])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[0]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call BlzSetUnitFacingEx(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[0]))
        call SetUnitAnimation(bossBindUnit,"attack")
    endfunction 

    //======================================================================
    //  电球，路径AOE，终点爆炸+击晕+烧蓝
    //======================================================================
    private function LightningBolt_End takes nothing returns nothing
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        local projectile proj = projectile.currentProjectile
        local real x = GetUnitX(proj.dummy)
        local real y = GetUnitY(proj.dummy)
        local real radius = RMinBJ(300,proj.Wave_Radius_Start*2)
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,radius,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Lightning = true  
            set damageTag_Arcane = true 
            set damageFlag = 'Aprg' 
            set damageIsAOE = true 
            call UnitDamageTarget(proj.source,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call applyStun(proj.source,FirstOfGroup(pick),'ATB1')
            call AddUnitMana(FirstOfGroup(pick),0-0.5*GetUnitState(FirstOfGroup(pick),UNIT_STATE_MAX_MANA))
            call GroupRemoveFirstUnit(pick)
        endloop 
        call DestroyGroup(pick)
        set pick = null 
        call BlzSetSpecialEffectScale(AddSpecialEffect("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",x,y),RMinBJ(1,proj.realData))
    endfunction
    private function LightningBolt_Hit takes nothing returns nothing
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageTag_Lightning = true  
            set damageTag_Arcane = true 
            set damageFlag = 'Aprg' 
            set damageIsAOE = true 
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl",waveTarget,"chest"))
        endif 
    endfunction
    private function LightningBolt_ChangeSize takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real size = de.loadReal("SIZE")
        local projectile proj = de.loadInteger("PROJ")
        local unit dummy = de.loadUnit("DUMMY")
        if dummy != null and alive(dummy) then 
            set size = size+0.03
            call SetUnitScale(dummy,size,size,size)
            call de.saveReal("SIZE",size)
            set proj.realData = size 
        else 
            set de.DESTROY = true 
        endif 
        set dummy = null 
    endfunction
    private function Spell_LightningBolt_delay_9 takes nothing returns nothing
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local delayedevent de = CreateDelayedEvent(2,66,function LightningBolt_ChangeSize)
        local projectile proj = CreateWave(bossBindUnit,GetUnitX(bossBindUnit)+700*Cos(a),GetUnitY(bossBindUnit)+700*Sin(a),450,75,75,"Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl",function LightningBolt_Hit,function LightningBolt_End)
        set proj.model_attach = "origin"
        set proj.ifCheckPath = true 
        set proj.realData = 0.5
        call proj.launch()
        call SetUnitScale(proj.dummy,0.5,0.5,0.5)
        call de.saveUnit("DUMMY",proj.dummy)
        call de.saveInteger("PROJ",proj)
        call de.saveReal("SIZE",0.5)
    endfunction
    private function Spell_LightningBolt takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        loop 
            set bossPlayMan[1] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[1])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[1]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call BlzSetUnitFacingEx(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[1]))
        call SetUnitAnimation(bossBindUnit,"attack")
    endfunction

    //======================================================================
    //  闪烁
    //======================================================================
    private function Spell_Blink takes nothing returns nothing
        local real x = boss.spawnX[0]
        local real y = boss.spawnY[0]
        local real a = 0
        local real d = 550
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        loop 
            set bossPlayMan[2] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[2])
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[2]) or FirstOfGroup(pick) == null 
        endloop
        call DestroyGroup(pick)
        set pick = null 
        set a = AngleByUnXY(bossPlayMan[2],x,y)/57.2956
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl",GetUnitX(bossBindUnit),GetUnitY(bossBindUnit)))
        set x = x+d*Cos(a)
        set y = y+d*Sin(a)
        call UnitDashToPoint(bossBindUnit,x,y,850)
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl",GetUnitX(bossBindUnit),GetUnitY(bossBindUnit)))
        call BlzSetUnitFacingEx(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[2]))
        call bufflist.listUnitBuffs(bossBindUnit,false,true,true)
        call bufflist.dispelAllBuffs()
    endfunction

    //======================================================================
    //  冰甲，吸收伤害，加护甲
    //======================================================================
    private function Spell_FrostArmor takes nothing returns nothing
        local mybuff bf = CreateBuff(bossBindUnit,bossBindUnit,BUFFTYPE_FROSTARMOR,3000)
        set bf.shieldBlockPercent = 1
        set bf.shieldMaxValue = 0.1*GetUnitState(bossBindUnit,UNIT_STATE_MAX_LIFE)
        set bf.bonusArmor_P = 5000
        set bf.bonusResistance = 5000
        call bf.apply()
    endfunction

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 

        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 19.164       //冰波伤害
            set bossAbilityRealData[1] = 8.455       //电球路径伤害
            set bossAbilityRealData[2] = 48.964       //电球爆炸伤害

            set boss.timeline = 0
            set boss.timelineMax = 340
            set boss.timelineMin = 10
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(65,function Spell_Blink)

            call boss.addTimeline(70,function Spell_IceWave)
            call boss.addTimeline(79,function Spell_IceWave_delay_9)
            call boss.addTimeline(85,function event_ResetPause)

            call boss.addTimeline(90,function Spell_LightningBolt)
            call boss.addTimeline(99,function Spell_LightningBolt_delay_9)
            call boss.addTimeline(105,function event_ResetPause)

            call boss.addTimeline(150,function Spell_FrostArmor)


            call boss.addTimeline(220,function Spell_Blink)

            call boss.addTimeline(225,function Spell_IceWave)
            call boss.addTimeline(234,function Spell_IceWave_delay_9)
            call boss.addTimeline(240,function event_ResetPause)

            call boss.addTimeline(245,function Spell_LightningBolt)
            call boss.addTimeline(254,function Spell_LightningBolt_delay_9)
            call boss.addTimeline(260,function event_ResetPause)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "奥比"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = ""
        set bossChatMsg[3] = ""
        set bossChatMsg[4] = ""
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

//======================================================================
// region BossAzureLord
//======================================================================
scope BossAzureLord initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n64K'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossAzureLord_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction

    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================
    
    //======================================================================
    //  穿刺波，击退+伤害+击晕
    //======================================================================
    private function ImpaleWave_Hit takes nothing returns nothing
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        local real x 
        local real y 
        local real a 
        local real d 
        local real xx 
        local real yy
        local real aa = (GetUnitFacing(waveWave.dummy)-AngleByUnits(waveWave.dummy,waveTarget))/57.2956
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) and Cos(aa) > 0 then 
            set damageTag_Bleed = true 
            set damageFlag = 'AUim' 
            set damageIsAOE = true 
            set damageCrushRate = 10000
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            set x = GetUnitX(waveTarget)
            set y = GetUnitY(waveTarget)
            set a = GetUnitFacing(waveWave.dummy)/57.2956
            set d = 250
            set xx = x+d*Cos(a)
            set yy = y+d*Sin(a)
            call KnockbackLocEx(waveTarget,xx,yy,500,0)
            call applyStun(waveCaster,waveTarget,'ATB1')
        endif 
    endfunction
    private function ImpaleWave_SFX takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = GetUnitX(de.loadUnit("DUMMY"))
        local real y = GetUnitY(de.loadUnit("DUMMY"))
        local real a = (GetUnitFacing(de.loadUnit("DUMMY"))+90)/57.2956
        local integer i = 0
        loop
            exitwhen i > 4
            call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\diciHitTarget.mdl",x+(75*I2R(i)-150)*Cos(a),y+(75*I2R(i)-150)*Sin(a)))
            set i = i+1
        endloop
    endfunction
    private function Spell_ImpaleWave_delay_7 takes nothing returns nothing
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local delayedevent de = CreateDelayedEvent(5,20,function ImpaleWave_SFX)
        local projectile proj = CreateWave(bossBindUnit,GetUnitX(bossBindUnit)+800*Cos(a),GetUnitY(bossBindUnit)+800*Sin(a),800,150,0,"",function ImpaleWave_Hit,null)
        call proj.launch()
        call de.saveUnit("DUMMY",proj.dummy)
    endfunction
    private function Spell_ImpaleWave takes nothing returns nothing
        local group pick = CreateGroup()
        set bossPlayMan[0] = GetUnitTaunter(bossBindUnit)
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        loop 
            exitwhen IsUnitInRegion(boss.region,bossPlayMan[0]) or FirstOfGroup(pick) == null 
            set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
            call GroupRemoveUnit(pick,bossPlayMan[0])
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call BlzSetUnitFacingEx(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[0]))
        call SetUnitAnimationByIndex(bossBindUnit,3)
    endfunction 

    //======================================================================
    //  穿刺风暴，预警，持续吸入+伤害+击晕
    //======================================================================
    private function Spell_ImpaleStorm_ApplyHaste takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local mybuff bf = CreateBuff(proj.source,proj.source,BUFFTYPE_FROSTHASTE,6000)
        set bf.bonusHaste = 5000
        call bf.apply()
    endfunction
    private function Spell_ImpaleStorm_End takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local group pick = null 
        local mybuff bf = 0
        local projectile proj = 0
        
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            set de.DESTROY = true 
            return 
        endif 
        set pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,235,playerHero)
        if CountUnitsInGroup(pick) > 0 then 
            set bf = CreateBuff(bossBindUnit,GroupPickRandomUnitEx(pick),BUFFTYPE_FROSTHASTE,500)
            set bf.bonusHaste = 5000
            call bf.apply()
        else 
            set proj = CreateProjectileToUnit(bossBindUnit,bossBindUnit,800,0,"war3campImported\\star_spirit_smaller.mdx",function Spell_ImpaleStorm_ApplyHaste,null)
            set proj.LAUNCH_LOC = true 
            set proj.LAUNCH_UNIT = false 
            set proj.source_x = x
            set proj.source_y = y 
            call proj.launch()
            call SetUnitScale(proj.dummy,1.5,1.5,1.5)
            set proj.bindSFX_0 = AddSpecialEffectTargetEX("war3campImported\\splinterblastmainprojectile_pe.mdl",proj.dummy,"chest")
        endif 
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\NightElf\\NECancelDeath\\NECancelDeath.mdl",x,y))
    endfunction
    private function Spell_ImpaleStorm_Impale takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local group pick = null 
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        local integer i = 0
        local integer j = 0
        local real a = 0
        local real d = 50
        
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            set de.DESTROY = true 
            return 
        endif 
        set pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,235,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Bleed = true 
            set damageFlag = 'AUim' 
            set damageIsAOE = true 
            set damageCrushRate = 10000
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            call KnockbackLocEx(FirstOfGroup(pick),x,y,1000,0)
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
        loop
            exitwhen i > 7
            set j = 0
            set d = 50
            loop
                exitwhen j > 3
                call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\diciHitTarget.mdl",x+d*Cos(a),y+d*Sin(a)))
                set d = d+50
                set j = j+1
            endloop
            set a = a+0.7854
            set i = i+1
        endloop
        call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\diciHitTarget.mdl",x,y))
    endfunction
    private function Spell_ImpaleStorm_delay_28 takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        set de = CreateDelayedEvent(1,1,function Spell_ImpaleStorm_Impale)
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
        set de = CreateDelayedEvent(70,5,function Spell_ImpaleStorm_Impale)
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
        set de = CreateDelayedEvent(350,1,function Spell_ImpaleStorm_End)
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
    endfunction
    private function Spell_ImpaleStorm_delay_3 takes nothing returns nothing
        local real x = GetUnitX(bossPlayMan[1])
        local real y = GetUnitY(bossPlayMan[1])
        local delayedevent de = CreateDelayedEvent(250,1,function Spell_ImpaleStorm_delay_28)
        local effect sfx = delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\hiveNewModels\\IlluminaRing_red.mdl",x,y),600)
        call BlzSetSpecialEffectScale(sfx,4)
        call BlzSetSpecialEffectColor(sfx,40,255,255)
        call delayedDestroyEffect(AddSpecialEffectEX("Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeTarget.mdl",x,y),600)
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
        set sfx = null 
    endfunction
    private function Spell_ImpaleStorm takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        loop
            exitwhen CountUnitsInGroup(pick) <= 2
            call GroupRemoveUnit(pick,GetClosestUnit(bossBindUnit,pick))
        endloop
        set bossPlayMan[1] = GroupPickRandomUnitEx(pick)
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call BlzSetUnitFacingEx(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[1]))
        call SetUnitAnimation(bossBindUnit,"spell")
    endfunction 

    //======================================================================
    // 寒冰箭雨，引导，群体aoe，连续施放2次
    //======================================================================
    globals 
        private Bar bar = 0
        private boolean fastCast = false 
        private timer castTimer = null 
    endglobals
    private function Spell_MultiIceBolt_Hit takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        call proj.applyDamageSet()
        set damageTag_Cold = true 
        set damageFlag = 'ACcb'
        call UnitDamageTarget(proj.source,proj.target,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call applyCold(proj.source,proj.target,'ACO0')
    endfunction 
    private function Spell_MultiIceBolt_Delayd_40 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call event_ResetPause()
    endfunction
    private function Spell_MultiIceBolt_Delayd_30 takes nothing returns nothing
        local projectile proj
        local group pick
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        if GetUnitCurrentOrder(bossBindUnit) == ORDER_channel then 
            set pick = CreateGroup()
            call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerAlly)
            loop
                exitwhen FirstOfGroup(pick) == null 
                set proj = CreateProjectileToUnit(bossBindUnit,FirstOfGroup(pick),1000,0,"Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl",function Spell_MultiIceBolt_Hit,null)
                set proj.flag = 'ABC8'
                call proj.launch()
                call GroupRemoveFirstUnit(pick)
            endloop
            call DestroyGroup(pick)
            set pick = null 
            call TimerStart(CreateTimer(),1,false,function Spell_MultiIceBolt_Delayd_40)
        endif 
    endfunction 
    private function Spell_MultiIceBolt_Delayd_27 takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        if GetUnitCurrentOrder(bossBindUnit) == ORDER_channel then 
            call SetUnitAnimation(bossBindUnit,"spell slam")
            call TimerStart(CreateTimer(),0.3,false,function Spell_MultiIceBolt_Delayd_30)
        endif 
    endfunction
    function UNIT_n64K_SPELL_READY takes nothing returns nothing
        local real time = 3
        local real time2 = 2.7
        if castingSpell == 'ABC8' then 
            set boss.pauseTL = true 
            if mybuff.getUnitBuff(bossBindUnit,BUFFTYPE_FROSTHASTE) > 0 then 
                set time = time/1.5
                set time2 = time-0.3
            endif 
            call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,-1)
            call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,-1)
            set castTimer = CreateTimer()
            call TimerStart(castTimer,time2,false,function Spell_MultiIceBolt_Delayd_27)
            call PlaySndEx(SND_DING)
            set bar = CreateBar(R2I(time*100),1,bossBindUnit)
        endif 
    endfunction
    function UNIT_n64K_SPELL_STOP takes nothing returns nothing
        if castingSpell == 'ABC8' then 
            set boss.pauseTL = false
            call event_ResetPause()
            set bossFocusTarget = null
            if bar > 0 then 
                call bar.destroy()
                set bar = 0
            endif 
            if bossBindUnit != null and alive(bossBindUnit) then 
                call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,1)
                //call BJDebugMsg("stop"+I2S(unitGetAllBonusStateValue(bossBindUnit,STATE_IMMUNE_SNARE)))
            endif 
            if castTimer != null then 
                call PauseTimer(castTimer)
                call DestroyTimer(castTimer)
            endif 
        endif 
    endfunction
    private function Spell_MultiIceBolt takes nothing returns nothing
        local group pick = CreateGroup()
        call removeAllDisabilities(bossBindUnit)
        call UnitAddAbilityEx(bossBindUnit,'ABC8')
        call IssueImmediateOrderById(bossBindUnit,ORDER_channel)
    endfunction

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 

        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 49.164       //穿刺波伤害
            set bossAbilityRealData[1] = 29.254       //穿刺风暴伤害
            set bossAbilityRealData[2] = 33.498       //群体寒冰箭伤害

            set boss.timeline = 0
            set boss.timelineMax = 230
            set boss.timelineMin = 10
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(50,function Spell_ImpaleWave)
            call boss.addTimeline(57,function Spell_ImpaleWave_delay_7)
            call boss.addTimeline(70,function event_ResetPause)

            call boss.addTimeline(100,function Spell_ImpaleStorm)
            call boss.addTimeline(103,function Spell_ImpaleStorm_delay_3)
            call boss.addTimeline(115,function event_ResetPause)

            call boss.addTimeline(180,function Spell_MultiIceBolt)
            call boss.addTimeline(181,function Spell_MultiIceBolt)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "阿玛克斯"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "卑贱的凡人，竟敢觊觎蓝龙军团的宝藏？"
        set bossChatMsg[3] = "不...玛里苟斯...大人..."
        set bossChatMsg[4] = "你们只有死路一条。"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

//======================================================================
// region BossAzureElderColles
//======================================================================
scope BossAzureElderColles initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId1             = 'n64J'  // 模型ID
        public integer              bossUnitId2             = 'n615'  // 模型ID
        public integer              bossUnitId3             = 0  // 模型ID
        public integer              bossUnitId4             = 0  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private boolean             forceActive             = false 
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0
        private integer             bossPhase               = 0
        private trigger             bossChangePhase         = CreateTrigger()

        private unit                bossBindUnit            = null 
        private unit                bossBindActor           = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossAzureElderColles_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction
    public function forceActiveBoss takes nothing returns nothing
        set forceActive = true 
        call TriggerExecute(activateBoss)
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    //======================================================================
    // 狂咒 施法时叠加受到的伤害
    //======================================================================
    private function ArcaneRetalition_Delay takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local unit target = de.loadUnit("TARGET")
        local real dmg = de.loadReal("DAMAGE")*bossAbilityRealData[0]*bossDamageMultiple
        set damageTag_Arcane = true 
        set damageFlag = 'A68M'
        call UnitDamageTarget(bossBindUnit,target,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("war3campImported\\hiveNewModels\\SummonWaterElementalCaster.mdx",target,"chest"))
        set target = null 
    endfunction
    private function ArcaneRetalition_Spelling takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(5,1,function ArcaneRetalition_Delay)
        local mybuff bf = mybuff.currentBuff
        set bf.realData = RMinBJ(15,bf.realData+1)
        call de.saveUnit("TARGET",bf.buffTarget)
        call de.saveReal("DAMAGE",bf.realData)
    endfunction
    private function Spell_ArcaneRetalition_delay_7 takes nothing returns nothing
        local mybuff bf = 0
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set bf = CreateBuff(bossBindUnit,FirstOfGroup(pick),BUFFTYPE_ARCANERETALITION,6000)
            call bf.addSpelling(function ArcaneRetalition_Spelling)
            call bf.apply()
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\HowlOfTerror\\HowlCaster.mdl",bossBindUnit,"origin"))
    endfunction
    private function Spell_ArcaneRetalition takes nothing returns nothing
        call PauseUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"spell")
    endfunction

    //======================================================================
    // 彗星风暴，钢条2s
    //======================================================================
    globals 
        private Bar bar = 0
        private boolean needRefreshImmunity = false 
        private group groupCometStorm = CreateGroup()
        private real cometCooldown = 0.5
    endglobals
    private function CometStorm_Hit takes nothing returns nothing
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,125,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Arcane = true 
            set damageTag_Cold = true 
            set damageFlag = 'ABC9'
            set damageIsAOE = true 
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call applyCold(bossBindUnit,FirstOfGroup(pick),'ACO0')
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function Spell_CometStorm_Loop takes nothing returns nothing
        local delayedevent de = 0
        local real x = 0
        local real y = 0
        call DestroyTimer(GetExpiredTimer())
        if bossBindUnit == null or alive(bossBindUnit) == false then 
            return 
        endif 
        if GetUnitCurrentOrder(bossBindUnit) != ORDER_channel then 
            call DestroyTimer(GetExpiredTimer())
            set boss.pauseTL = false 
            call event_ResetPause()
        else 
            if FirstOfGroup(groupCometStorm) == null then 
                call GroupClear(groupCometStorm)
                call GroupEnumUnitsInRect(groupCometStorm,bossAbilityRandomRect,playerHero)
            endif 
            set bossPlayMan[0] = GroupPickRandomUnitEx(groupCometStorm)
            if bossPlayMan[0] != null then 
                set x = GetUnitX(bossPlayMan[0])+GetRandomReal(-75,75)
                set y = GetUnitY(bossPlayMan[0])+GetRandomReal(-75,75)
                set de = CreateDelayedEvent(75,1,function CometStorm_Hit)
                call de.saveReal("X",x)
                call de.saveReal("Y",y)
                call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\CometStormTarget.mdx",x,y))
                call GroupRemoveUnit(groupCometStorm,bossPlayMan[0])
            endif 
            set cometCooldown = RMaxBJ(0.15,cometCooldown-0.05)
            call TimerStart(CreateTimer(),cometCooldown,false,function Spell_CometStorm_Loop)
        endif 
    endfunction
    function Spell_CometStorm_Delayed takes nothing returns nothing
        call DestroyTimer(GetExpiredTimer())
        if bossBindUnit == null or alive(bossBindUnit) == false then 
            return 
        endif 
        if GetUnitCurrentOrder(bossBindUnit) != ORDER_channel then 
            return 
        endif 
        
        call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,-1)
        call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,-1)
        call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,-1)
        call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,-1)
        set needRefreshImmunity = true 
        
        call SetBarColor(bar,255,0,0,175)
    endfunction
    function UNIT_n64J_SPELL_READY takes nothing returns nothing
        if castingSpell == 'ABC9' then 
            set needRefreshImmunity = false 
            set boss.pauseTL = true 

            call GroupClear(groupCometStorm)
            call PlaySndEx(SND_DING)
            set bar = CreateBar(1500,-1,bossBindUnit)
            call SetBarColor(bar,125,125,255,175)
            set cometCooldown = 0.5
            call TimerStart(CreateTimer(),cometCooldown,false,function Spell_CometStorm_Loop)
            call TimerStart(CreateTimer(),2,false,function Spell_CometStorm_Delayed)
        endif 
    endfunction
    function UNIT_n64J_SPELL_STOP takes nothing returns nothing
        if castingSpell == 'ABC9' then 
            set boss.pauseTL = false
            call event_ResetPause()
            set bossFocusTarget = null
            if bar > 0 then 
                call bar.destroy()
                set bar = 0
            endif 
            if bossBindUnit != null and alive(bossBindUnit) and needRefreshImmunity then 
                call unitAddState(bossBindUnit,STATE_IMMUNE_ROOT,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SILENCE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_SNARE,1)
                call unitAddState(bossBindUnit,STATE_IMMUNE_STUN,1)
            endif 
        endif 
    endfunction
    private function Spell_CometStorm takes nothing returns nothing
        call removeAllDisabilities(bossBindUnit)
        call UnitAddAbilityEx(bossBindUnit,'ABC9')
        call IssueImmediateOrderById(bossBindUnit,ORDER_channel)
    endfunction    

    //======================================================================
    // 阶段转换
    //======================================================================
    function UNIT_n64J_DAMAGED_TARGET takes nothing returns nothing
        if GetUnitState(bossBindUnit,UNIT_STATE_LIFE) <= 0.5*GetUnitState(bossBindUnit,UNIT_STATE_MAX_LIFE) and bossPhase < 1 then 
            set damageFinalDamage = 0
        endif   
    endfunction

    private function PhaseChange_1 takes nothing returns nothing
        set bossPhase = 1
        call PauseUnit(bossBindUnit,true)
        call SetUnitInvulnerable(bossBindUnit,true)
        call ShowUnit(bossBindActor,true)
        call delayedShowUnit(bossBindActor,100)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\Unsummon\\UnsummonTarget.mdl",bossBindActor,"origin"))
        call PanCameraToTimed(GetUnitX(bossBindActor),GetUnitY(bossBindActor),1.5)
        call DisplayTextToPlayer(PLAYER,0,0,bossChatMsg[5])
        call SetUnitFacing(bossBindActor,AngleByUnits(bossBindActor,bossBindUnit))
    endfunction

    private function PhaseChange_20 takes nothing returns nothing
        call SetUnitAnimation(bossBindActor,"spell")
    endfunction

    private function PhaseChange_Hit takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local effect sfx = null 
        if proj.target == null or alive(proj.target) == false then 
            return 
        endif 
        set sfx = AddSpecialEffectEX("units\\creeps\\AzureDragon\\AzureDragon.mdl",GetUnitX(proj.target),GetUnitY(proj.target))
        call BlzSetSpecialEffectScale(sfx,1.75)
        call BlzSetSpecialEffectHeightEX(sfx,GetUnitFlyHeight(proj.target))
        call BlzSetSpecialEffectOrientation(sfx,GetUnitFacing(proj.target)/57.2956,0,0)
        call DestroyEffect(sfx)
        set sfx = AddSpecialEffectEX("Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl",GetUnitX(proj.target),GetUnitY(proj.target))
        call BlzSetSpecialEffectScale(sfx,1.75)
        call BlzSetSpecialEffectHeightEX(sfx,GetUnitFlyHeight(proj.target))
        call DestroyEffect(sfx)
        set sfx = null 
        call ShowUnit(proj.target,false)
        call BlzSetUnitSkin(proj.target,'n64L')
        call BlzSetUnitWeaponRealField(proj.target,UNIT_WEAPON_RF_ATTACK_DAMAGE_POINT,0,0.5)
        call BlzSetUnitWeaponRealField(proj.target,UNIT_WEAPON_RF_ATTACK_BACKSWING_POINT,0,0.55)
        call BlzSetUnitWeaponRealField(proj.target,UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN,0,1.4)
        call PauseUnit(proj.target,true)
        call ShowUnit(proj.target,false)
        call SetUnitAnimation(proj.target,"death")
        call SetUnitState(proj.target,UNIT_STATE_LIFE,GetUnitState(proj.target,UNIT_STATE_MAX_LIFE))
    endfunction

    private function PhaseChange_23 takes nothing returns nothing
        local projectile proj = CreateProjectileToUnit(bossBindActor,bossBindUnit,1000,0,"war3campImported\\DeathCoilMissile.mdx",function PhaseChange_Hit,null)
        call proj.launch()
        call SetUnitScale(proj.dummy,1.5,1.5,1.5)
    endfunction

    private function PhaseChange_38 takes nothing returns nothing
        call SetUnitAnimation(bossBindActor,"stand")
    endfunction

    private function PhaseChange_SFX takes nothing returns nothing
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local real a = GetRandomReal(0,6.2832)
        local real d = SquareRoot(GetRandomReal(2500,40000))
        if bossBindUnit == null or alive(bossBindUnit) == false then 
            set delayedevent.currentEvent.DESTROY = true 
            return 
        endif
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl",x+d*Cos(a),y+d*Sin(a))) 
    endfunction
    private function PhaseChange_50 takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(5,80,function PhaseChange_SFX)
        call delayedDestroyEffect(AddSpecialEffectEX("Abilities\\Spells\\Undead\\Unsummon\\UnsummonTarget.mdl",GetUnitX(bossBindUnit),GetUnitY(bossBindUnit)),320)
    endfunction

    private function PhaseChange_55 takes nothing returns nothing
        call SetUnitAnimation(bossBindActor,"spell third")
        call delayedHideUnit(bossBindActor,293,false)
        call delayedRemoveUnit(bossBindActor,294)
        call DisplayTextToPlayer(PLAYER,0,0,bossChatMsg[6])
        call delayedDestroyEffect(AddSpecialEffectEX("Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl",GetUnitX(bossBindActor),GetUnitY(bossBindActor)),294)
    endfunction

    private function PhaseChange_82 takes nothing returns nothing
        call ShowUnit(bossBindUnit,true)
        call SetUnitAnimation(bossBindUnit,"birth")
    endfunction

    private function PhaseChange_90 takes nothing returns nothing
        call SetUnitAnimation(bossBindUnit,"stand")
        call SetUnitTimeScale(bossBindUnit,1)
        call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\hiveNewModels\\Devil Slam.mdx",GetUnitX(bossBindUnit),GetUnitY(bossBindUnit)))
    endfunction

    private function PhaseChange_95 takes nothing returns nothing
        call event_ResetPause()
        call SetUnitInvulnerable(bossBindUnit,false)
        call PlaySndEx(SND_FROST_WYRM_WARCRY_1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        set bossPhase = 2
        set boss.timeline = 1000
        set boss.timelineMax = 1250
        set boss.timelineMin = 1000
    endfunction

    private function bossChangePhase_action takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        set boss.timeline = 500
        set boss.timelineMin = 500
        set boss.timelineMax = 700
    endfunction

    //======================================================================
    // 封魔领域
    //======================================================================
    private function Spell_SilenceArea_loop takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local group pick = null 
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        local integer i = 0
        local integer j = 0
        local real a = 0
        local real d = 4
        
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            set de.DESTROY = true 
            return 
        endif 
        set pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,256,playerHero)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Arcane = true 
            set damageFlag = 'AUim' 
            set damageIsAOE = true 
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            set a = AngleByUnXY(FirstOfGroup(pick),x,y)/57.2956
            call SetUnitX(FirstOfGroup(pick),GetUnitX(FirstOfGroup(pick))+d*Cos(a))
            call SetUnitY(FirstOfGroup(pick),GetUnitY(FirstOfGroup(pick))+d*Cos(a))
            call AddUnitMana(FirstOfGroup(pick),-0.25)
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function Spell_SilenceArea_delay_5 takes nothing returns nothing
        local real x = GetUnitX(bossPlayMan[1])
        local real y = GetUnitY(bossPlayMan[1])
        local delayedevent de = CreateDelayedEvent(5,300,function Spell_SilenceArea_loop)
        local effect sfx = delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\winterscurseaoe.mdl",x,y),1500)
        call BlzSetSpecialEffectScale(sfx,0.7)
        call de.saveReal("X",x)
        call de.saveReal("Y",y)
        set sfx = null 
        call DestroyEffectEX(AddSpecialEffectEX("war3campImported\\surge.mdl",x,y))
    endfunction
    private function Spell_SilenceArea takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        loop
            exitwhen CountUnitsInGroup(pick) <= 2
            call GroupRemoveUnit(pick,GetClosestUnit(bossBindUnit,pick))
        endloop
        set bossPlayMan[1] = GroupPickRandomUnitEx(pick)
        call DestroyGroup(pick)
        set pick = null 
        call PauseUnit(bossBindUnit,true)
        call BlzSetUnitFacingEx(bossBindUnit,AngleByUnits(bossBindUnit,bossPlayMan[1]))
        call SetUnitAnimation(bossBindUnit,"attack")
    endfunction 

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        set bossBindActor = boss.u[1]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitCheckState.evaluate(bossBindUnit)

        call ShowUnit(bossBindActor,false)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if forceActive or (GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false) then 
            call DisableTrigger(activateBoss)

            set forceActive = false 

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0] = 4.025       //狂咒基础伤害
            set bossAbilityRealData[1] = 16.767       //彗星风暴
            set bossAbilityRealData[2] = 1.323       //禁法领域

            set boss.timeline = 0
            set boss.timelineMax = 230
            set boss.timelineMin = 10
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(50,function Spell_ArcaneRetalition)
            call boss.addTimeline(57,function Spell_ArcaneRetalition_delay_7)
            call boss.addTimeline(60,function event_ResetPause)

            call boss.addTimeline(120,function Spell_CometStorm)


            call boss.addTimeline(501,function PhaseChange_1)
            call boss.addTimeline(510,function PhaseChange_20)
            call boss.addTimeline(523,function PhaseChange_23)
            call boss.addTimeline(538,function PhaseChange_38)
            call boss.addTimeline(550,function PhaseChange_50)
            call boss.addTimeline(555,function PhaseChange_55)
            call boss.addTimeline(582,function PhaseChange_82)
            call boss.addTimeline(590,function PhaseChange_90)
            call boss.addTimeline(595,function PhaseChange_95)

            call boss.addTimeline(1005,function Spell_ArcaneRetalition)
            call boss.addTimeline(1010,function Spell_ArcaneRetalition_delay_7)
            call boss.addTimeline(1015,function event_ResetPause)

            call boss.addTimeline(1070,function Spell_SilenceArea)
            call boss.addTimeline(1075,function Spell_SilenceArea_delay_5)
            call boss.addTimeline(1080,function event_ResetPause)

            call boss.addTimeline(1155,function Spell_ArcaneRetalition)
            call boss.addTimeline(1160,function Spell_ArcaneRetalition_delay_7)
            call boss.addTimeline(1165,function event_ResetPause)

            call boss.addTimeline(1200,function Spell_CometStorm)

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()

            call EnableTrigger(bossChangePhase)
            call TriggerRegisterUnitStateEvent(bossChangePhase, bossBindUnit, UNIT_STATE_LIFE,LESS_THAN_OR_EQUAL,0.51*GetUnitState(bossBindUnit,UNIT_STATE_MAX_LIFE))
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "古勒斯"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "激活台词"
        set bossChatMsg[3] = "死亡台词"
        set bossChatMsg[4] = "重置台词"
        set bossChatMsg[5] = "|cffffcc00恶魔的身影：|r有趣，但你们还得在这里多待一会..."
        set bossChatMsg[6] = "|cffffcc00恶魔的身影：|r你们一定会喜欢这个新“玩具”的..."
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)
        call TriggerAddAction(bossChangePhase, function bossChangePhase_action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

//======================================================================
// region BossAzureGuardian
//======================================================================
scope BossAzureGuardian initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n64M'  // 模型ID
        public integer              bossBodyId              = 'n64N'  // 模型ID
        public integer              bossBodyId_Decay        = 'n64O'  // 模型ID
        public integer              bossGemId               = 'n64P'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private boolean             forceActive             = false 
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private trigger             trigDragonBodyDeath     = CreateTrigger()
        private integer             deathCount              = 0
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                gemModel                = null 
        private unit array          dragonBody              [20]
        private real array          dragonBody_X            [20]
        private real array          dragonBody_Y            [20]
        private real array          dragonBody_Z            [20]
        private real                dragonBody_Speed        = 0
        private timer               dragonBody_Timer        = CreateTimer()
        private timer               dragonBody_Timer2       = CreateTimer()

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossAzureGuardian_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null

        private integer             bossPhase               = 0
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction
    public function forceActiveBoss takes nothing returns nothing
        set forceActive = true 
        call TriggerExecute(activateBoss)
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================
    private function Spell_SoulShot_Hit takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local real dmg = bossAbilityRealData[2]*bossDamageMultiple
        set damageTag_Arcane = true 
        set damageTag_Cold = true 
        set damageFlag = 'ACcb' 
        call UnitDamageTarget(proj.source,proj.target,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
    endfunction
    private function Spell_SoulShot takes unit source returns nothing
        local projectile proj = 0
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        if bossPlayMan[1] != null and CountUnitsInGroup(pick) > 1 then 
            call GroupRemoveUnit(pick,bossPlayMan[1])
        endif 
        set bossPlayMan[1] = GetUnitWithHighestHealth(pick)
        call DestroyGroup(pick)
        set pick = null 
        set proj = CreateProjectileToUnit(source,bossPlayMan[1],1000,0.02,"Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl",function Spell_SoulShot_Hit,null)
        call delayedLaunchMissile(proj,ModuloInteger(globalNowtime,55))
        set source = null 
    endfunction
    private function DragonBodyUpdate takes nothing returns nothing
        local real x = dragonBody_X[0]
        local real y = dragonBody_Y[0]
        local real a = GetUnitFacing(bossBindUnit)
        local real aa = a * bj_DEGTORAD + Sin(I2R(globalNowtime) / 72) * 0.02178
        local real s = RMaxBJ(5,dragonBody_Speed-0.15)
        local real d = 45
        local real xx = x + s * Cos(aa)
        local real yy = y + s * Sin(aa)
        local integer i = 1
        local real dx
        local real dy
        local real len

        // ----- 更新头部 -----
        call SetUnitX(dragonBody[0], xx)
        call SetUnitY(dragonBody[0], yy)
        call BlzSetUnitFacingEx(dragonBody[0], AngleByXY(x, y, xx, yy))
        call SetUnitFlyHeight(bossBindUnit, 100 * Sin(I2R(globalNowtime) / 300) + 180, 0)

        // 存储头部新位置（供身体节点使用）
        set dragonBody_X[0] = xx
        set dragonBody_Y[0] = yy
        set dragonBody_Z[0] = GetUnitFlyHeight(bossBindUnit)

        call IssueImmediateOrderById(dragonBody[0],ORDER_stop)
        // ----- 更新身体节点（1 ~ 20）-----
        loop
            exitwhen i > 20
            // 计算从节点 i-1（新位置）到节点 i（旧位置）的方向
            set dx = dragonBody_X[i] - dragonBody_X[i - 1]
            set dy = dragonBody_Y[i] - dragonBody_Y[i - 1]
            set len = SquareRoot(dx * dx + dy * dy)
            if len > 0 then
                set dx = dx / len
                set dy = dy / len
            else
                // 若重合则沿用头部方向（避免除零）
                set dx = Cos(aa)
                set dy = Sin(aa)
            endif

            // 设置节点 i 的位置 = 节点 i-1 新位置 + d * 方向
            set dragonBody_X[i] = dragonBody_X[i - 1] + d * dx
            set dragonBody_Y[i] = dragonBody_Y[i - 1] + d * dy
            call SetUnitX(dragonBody[i], dragonBody_X[i])
            call SetUnitY(dragonBody[i], dragonBody_Y[i])
            if GetUnitTypeId(dragonBody[i]) == bossBodyId then 
                call UnitAddAbilityEx(dragonBody[i],'AUIW')
                call IssueImmediateOrderById(dragonBody[i],ORDER_windwalk)
            endif 
            set i = i + 1
        endloop

        // ----- 设置身体节点的朝向（指向各自前一个节点）-----
        set i = 20
        loop
            exitwhen i < 1
            call BlzSetUnitFacingEx(dragonBody[i], AngleByXY(dragonBody_X[i], dragonBody_Y[i], dragonBody_X[i - 1], dragonBody_Y[i - 1]))
            call SetUnitFlyHeight(dragonBody[i], dragonBody_Z[i - 1], 0)
            set dragonBody_Z[i] = dragonBody_Z[i - 1]
            call AddUnitMana(dragonBody[i],GetRandomReal(0.5,5))
            if GetUnitState(dragonBody[i],UNIT_STATE_MANA) > GetUnitState(dragonBody[i],UNIT_STATE_MAX_MANA)-1 then 
                call SetUnitState(dragonBody[i],UNIT_STATE_MANA,0)
                call Spell_SoulShot(dragonBody[i])
            endif 
            if GetUnitTypeId(dragonBody[i]) == bossBodyId then 
                call SetUnitVertexColor(dragonBody[i],125,125,125,125)
            endif 
            set i = i - 1
        endloop
        set dragonBody_Speed = s 
        // ----- 边界转向逻辑（保留原样）-----
        if DisByUnXY(bossBindUnit, boss.spawnX[0], boss.spawnY[0]) > 850 then
            set a = GetRandomReal(0, 6.2832)
            set x = boss.spawnX[0] + 400 * Cos(a)
            set y = boss.spawnY[0] + 400 * Sin(a)
            call BlzSetUnitFacingEx(bossBindUnit, AngleByUnXY(bossBindUnit, x, y))
            if bossPhase == 1 then 
                set dragonBody_Speed = 15
            endif 
        endif
    endfunction

    private function DragonHeadBite takes nothing returns nothing
        local real x = GetUnitX(bossBindUnit)
        local real y = GetUnitY(bossBindUnit)
        local real a = GetUnitFacing(bossBindUnit)/57.2956
        local real dmg = bossAbilityRealData[0]*bossDamageMultiple
        local group pick = CreateGroup()
        set x = x+56*Cos(a)
        set y = y+56*Sin(a)
        call GroupEnumUnitsInRange(pick,x,y,96,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null
            if unitCheckCooldown(FirstOfGroup(pick),'BITE') then  
                set a = (GetUnitFacing(bossBindUnit)-AngleByUnits(bossBindUnit,FirstOfGroup(pick)))/57.2956
                if Cos(a) > 0 then 
                    set damageTag_Bleed = true 
                    set damageIsAOE = true 
                    set damageFlag = 'BITE'
                    set damageCrushRate = 10000
                    call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WOOD_LIGHT_BASH)
                    call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl",FirstOfGroup(pick),"chest"))
                    set a = AngleByUnits(bossBindUnit,FirstOfGroup(pick))/57.2956
                    call KnockbackLocEx(FirstOfGroup(pick),x+150*Cos(a),y+150*Sin(a),600,0)
                    call unitStartCooldown(FirstOfGroup(pick),'BITE',50-bossPhase*25)
                endif   
            endif 
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function DragonBodyResetSpeed takes nothing returns nothing
        set dragonBody_Speed = 5
        call TimerStart(dragonBody_Timer2,0.11,true,function DragonHeadBite)
    endfunction

    private function DragonBodyDeath takes nothing returns nothing
        local integer i = 1
        if GetUnitTypeId(GetTriggerUnit()) != bossBodyId then 
            return 
        endif 
        loop
            exitwhen i > 20
            if GetTriggerUnit() == dragonBody[i] then 
                call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl",GetUnitX(dragonBody[i]),GetUnitY(dragonBody[i])))
                call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl",GetUnitX(dragonBody[i]),GetUnitY(dragonBody[i])))
                set dragonBody[i] = CreateUnit(Player(11),bossBodyId_Decay,dragonBody_X[i],dragonBody_Y[i],GetUnitFacing(GetTriggerUnit()))
                call UnitAddAbility(dragonBody[i],'Arav')
                call UnitRemoveAbility(dragonBody[i],'Arav')
                call SetUnitFlyHeight(dragonBody[i], dragonBody_Z[i - 1], 0)
                call SetUnitVertexColor(dragonBody[i],204,75,75,125)
                set deathCount = deathCount+1
                exitwhen true 
            endif 
            set i = i+1
        endloop
        if deathCount >= 20 and bossPhase == 0 then 
            set bossPhase = 1
            set boss.timeline = IMaxBJ(boss.timeline,50)
            set boss.timelineMin = 50
            set dragonBody_Speed = 15
            call SetUnitInvulnerable(bossBindUnit,false)
            call SetUnitVertexColor(bossBindUnit,204,75,75,125)
            call DisplayTextToPlayer(PLAYER,0,0,"|cffffcc00守护者变得狂暴了。|r")
            call PlaySndEx(SND_DING)
        endif 
    endfunction

    function Spell_Blizzard_AOE takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local group pick = CreateGroup()
        local real dmg = bossAbilityRealData[1]*bossDamageMultiple
        call GroupEnumUnitsInRange(pick,x,y,250,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageTag_Cold = true 
            set damageFlag = 'AHbz'
            call UnitDamageTarget(bossBindUnit,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction
    private function Spell_Blizzard_SFX takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local integer i = 0
        local real a
        local real d 
        local delayedevent dede 
        local location loc = Location(x,y)
        set dede = delayedevent.create(75,1,function Spell_Blizzard_AOE)
        call dede.saveReal("X",x)
        call dede.saveReal("Y",y)
        loop 
            exitwhen i > 7
            set d = SquareRoot(GetRandomReal(2500,62500))
            set a = GetRandomReal(0.7854*I2R(i),0.7854*I2R(i+1))
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl",x+d*Cos(a),y+d*Sin(a)))
            set i = i+1
        endloop
        call Play3DSndEx(SND_BLIZZARD,x,y,GetLocationZ(loc))
        call RemoveLocation(loc)
        set loc = null 
    endfunction
    private function Spell_Blizzard_delay_35 takes nothing returns nothing
        local delayedevent de = CreateDelayedEvent(1,1,function Spell_Blizzard_SFX)
        call de.saveReal("X",GetUnitX(bossPlayMan[0]))
        call de.saveReal("Y",GetUnitY(bossPlayMan[0]))
        set de = CreateDelayedEvent(100,15,function Spell_Blizzard_SFX)
        call de.saveReal("X",GetUnitX(bossPlayMan[0]))
        call de.saveReal("Y",GetUnitY(bossPlayMan[0]))
        call delayedDestroyEffect(AddSpecialEffectEX("war3campImported\\Quake_vortex.mdl",GetUnitX(bossPlayMan[0]),GetUnitY(bossPlayMan[0])),1500)
        call DestroyEffectEX(AddSpecialEffectTargetEX("war3campImported\\icenova.mdx",bossPlayMan[0],"origin"))
    endfunction
    private function Spell_Blizzard_delay_5_10_15_20_25 takes nothing returns nothing
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl",bossPlayMan[0],"origin"))
    endfunction
    private function Spell_Blizzard takes nothing returns nothing
        local group pick = CreateGroup()
        local effect sfx = null 
        call GroupEnumUnitsInRect(pick,bossAbilityRandomRect,playerHero)
        set bossPlayMan[0] = GroupPickRandomUnitEx(pick)
        call delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\icetornado.mdx",bossPlayMan[0],"origin"),350)
        set sfx = delayedDestroyEffect(AddSpecialEffectTargetEX("war3campImported\\dianmingguangzhu.mdx",bossPlayMan[0],"origin"),350)
        call BlzSetSpecialEffectColor(sfx,0,112,221)
        call BlzSetSpecialEffectAlpha(sfx,125)
        set sfx = null 
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl",bossPlayMan[0],"origin"))
        call DestroyGroup(pick)
        set pick = null 
        call PlaySndEx(SND_DING)
    endfunction
    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area
        call ShowUnit(bossBindUnit,false)
        set gemModel = CreateUnit(Player(11),bossGemId,boss.spawnX[0],boss.spawnY[0],boss.spawnF[0])
        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local integer i = 0
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
        call PauseTimer(dragonBody_Timer)
        call PauseTimer(dragonBody_Timer2)
        call DisableTrigger(trigDragonBodyDeath)
        set i = 1
        loop
            exitwhen i > 20
            call KillUnit(dragonBody[i])
            set i = i+1
        endloop
        if alive(gemModel) and gemModel != null then 
            call KillUnit(gemModel)
            set gemModel = null 
        endif 
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer i = 0
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call PauseTimer(dragonBody_Timer)
        call PauseTimer(dragonBody_Timer2)
        call DisableTrigger(trigDragonBodyDeath)
        set i = 1
        loop
            exitwhen i > 20
            call KillUnit(dragonBody[i])
            set i = i+1
        endloop
        if alive(gemModel) and gemModel != null then 
            call KillUnit(gemModel)
            set gemModel = null 
        endif 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        local integer i = 0
        if boss.enable and (forceActive or (GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false)) then 
            set forceActive = false 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set bossAbilityRealData[0]      =   7.951       //龙头撕咬伤害 
            set bossAbilityRealData[1]      =   17.447       //暴风雪伤害 
            set bossAbilityRealData[2]      =   6.723       //灵魂射击伤害 

            set boss.timeline = 0
            set boss.timelineMax = 205
            set boss.timelineMin = 0
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.addTimeline(170,function Spell_Blizzard)
            call boss.addTimeline(175,function Spell_Blizzard_delay_5_10_15_20_25)
            call boss.addTimeline(180,function Spell_Blizzard_delay_5_10_15_20_25)
            call boss.addTimeline(185,function Spell_Blizzard_delay_5_10_15_20_25)
            call boss.addTimeline(190,function Spell_Blizzard_delay_5_10_15_20_25)
            call boss.addTimeline(195,function Spell_Blizzard_delay_5_10_15_20_25)
            call boss.addTimeline(200,function Spell_Blizzard_delay_5_10_15_20_25)
            call boss.addTimeline(205,function Spell_Blizzard_delay_35)


            call boss.activate()
            call UnitApplyTimedLife(gemModel,'BHwe',0.6)
            call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\NightElf\\NECancelDeath\\NECancelDeath.mdl",GetUnitX(gemModel),GetUnitY(gemModel)))
            call ShowUnit(bossBindUnit,true)
            call SetUnitTimeScale(bossBindUnit,0)
            call SetUnitVertexColor(bossBindUnit,255,255,255,125)
            set dragonBody_Speed = 30

            call PauseUnit(bossBindUnit,false)
            call SetUnitPathing(bossBindUnit,false)
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            
            set dragonBody[0] = bossBindUnit
            set dragonBody_X[0] = GetUnitX(bossBindUnit)
            set dragonBody_Y[0] = GetUnitY(bossBindUnit)
            set dragonBody_Z[0] = GetUnitFlyHeight(bossBindUnit)
            call SetUnitInvulnerable(bossBindUnit,true)
            call SetUnitFlyHeight(bossBindUnit,561,300)
            set i = 1
            loop
                exitwhen i > 20
                set dragonBody[i] = CreateUnit(Player(11),bossBodyId,dragonBody_X[i-1],dragonBody_Y[i-1],GetUnitFacing(dragonBody[i-1]))
                call SetUnitFlyHeight(dragonBody[i],dragonBody_Z[i-1],0)
                set dragonBody_X[i] = GetUnitX(dragonBody[i])
                set dragonBody_Y[i] = GetUnitY(dragonBody[i])
                set dragonBody_Z[i] = GetUnitFlyHeight(dragonBody[i])
                call SetUnitVertexColor(dragonBody[i],125,125,125,125)
                set RegisterEnemy(dragonBody[i]).needRespawn = false
                call SetUnitPathing(dragonBody[i],false)
                call UnitShareVision(dragonBody[i],PLAYER,true)
                call unitAddState(dragonBody[i], STATE_IMMUNE_ROOT, 1)
                call unitAddState(dragonBody[i], STATE_IMMUNE_SILENCE, 1)
                call unitAddState(dragonBody[i], STATE_IMMUNE_SNARE, 1)
                call unitAddState(dragonBody[i], STATE_IMMUNE_STUN, 1)
                call unitAddState(dragonBody[i], STATE_IMMUNE_COLD, 1)
                call AddUnitMana(dragonBody[i],25*I2R(i))
                set i = i+1
            endloop
            call TimerStart(dragonBody_Timer,0.03,true,function DragonBodyUpdate)
            call TimerStart(dragonBody_Timer2,0.6,false,function DragonBodyResetSpeed)

            call EnableTrigger(trigDragonBodyDeath)
            set deathCount = 0
            set bossPhase = 0
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        //call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "守护者"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "激活台词"
        set bossChatMsg[3] = "死亡台词"
        set bossChatMsg[4] = "重置台词"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)
        call TriggerAddAction(trigDragonBodyDeath,function DragonBodyDeath)

        call TriggerRegisterPlayerUnitEventSimple(trigDragonBodyDeath,Player(11),EVENT_PLAYER_UNIT_DEATH)

        call DisableTrigger(trigDragonBodyDeath)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

//======================================================================
// region BossKoboldGuru
//======================================================================
scope BossKoboldGuru initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n64X'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossKoboldGuru_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================
    
    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set boss.timeline = 0
            set boss.timelineMax = 100
            set boss.timelineMin = 0
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "Boss名称"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "激活台词"
        set bossChatMsg[3] = "死亡台词"
        set bossChatMsg[4] = "重置台词"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

//======================================================================
// region example
//======================================================================
scope BossTemplate initializer init

    globals 
        //【必改】Boss 核心配置
        public Boss                 boss                    = 0  // 外部注入
        public integer              bossUnitId              = 'n000'  // 模型ID

        //【可选】城门系统
        private integer             bossGateCount           = 0
        private destructable array  bossGate                [10]

        //【核心变量】
        private trigger             defeatBoss              = CreateTrigger()
        private trigger             activateBoss            = CreateTrigger()
        private real array          bossAbilityRealData 
        private integer array       bossAbilityIntData  
        private string array        bossChatMsg         
        private integer             bossLevel               = 0

        private unit                bossBindUnit            = null 
        private real                bossDamageMultiple      = 0
        private unit array          bossPlayMan             [10]
        private unit                bossFocusTarget         = null 
        private timer               bossFocusTimer          = null 
        private constant string     scopePrev               = "BossTemplate_" 
        private rect                bossAbilityRandomRect   = null
        private boolexpr            isSummonedUnit          = null
    endglobals

    //======================================================================
    // 【公共接口】供地图库调用
    //======================================================================
    public function bossGateAdd takes destructable whichGate returns nothing
        if bossGateCount < 10 then 
            set bossGate[bossGateCount] = whichGate
            set bossGateCount = bossGateCount + 1
        endif 
    endfunction

    //======================================================================
    // 【通用函数】
    //======================================================================
    private function Condition_isSummonedUnit takes nothing returns boolean
        return false 
    endfunction
    
    private function event_ResetPause takes nothing returns nothing
        set bossFocusTarget = null
        call PauseTimer(bossFocusTimer)
        set bossFocusTarget = null 
        if alive(bossBindUnit) == false or bossBindUnit == null then 
            return 
        endif 
        call PauseUnit(bossBindUnit, false)
        call SetUnitTimeScale(bossBindUnit, 1.0)
        call SetUnitAnimation(bossBindUnit, "stand")
        call CheckPosition(bossBindUnit)
    endfunction

    private function event_FocusOnTarget takes nothing returns nothing
        if bossFocusTarget == null then 
            call PauseTimer(bossFocusTimer)
            return 
        endif 
        call SetUnitFacing(bossBindUnit, AngleByUnits(bossBindUnit, bossFocusTarget))
    endfunction

    private function event_OpenAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    private function event_CloseAllGates takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i == bossGateCount
            call ModifyGateBJ(bj_GATEOPERATION_CLOSE, bossGate[i])
            set i = i + 1
        endloop
    endfunction

    //======================================================================
    // 【自定义技能区】（复制粘贴你的技能）
    //======================================================================

    //======================================================================
    // 【Boss 生命周期】（外部创建后自动绑定）
    //======================================================================
    private function bossOnInit takes nothing returns nothing
        local integer i = 0
        set bossBindUnit = boss.u[0]
        if bossFocusTimer != null then 
            call DestroyTimer(bossFocusTimer)
        endif 
        set bossFocusTimer = CreateTimer()
        set bossAbilityRandomRect = boss.area

        
        call TriggerRegisterUnitInRangeSimple(activateBoss, 400, bossBindUnit)
        call TriggerRegisterUnitEvent(defeatBoss, bossBindUnit, EVENT_UNIT_DEATH)
        call EnableTrigger(activateBoss)
        call EnableTrigger(defeatBoss)

        // 5大免疫
        call unitAddState(bossBindUnit, STATE_IMMUNE_ROOT, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SILENCE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_SNARE, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_STUN, 1)
        call unitAddState(bossBindUnit, STATE_IMMUNE_COLD, 1)
        call unitCheckState.evaluate(bossBindUnit)

        // 城门无敌
        loop 
            exitwhen i == bossGateCount
            call SetDestructableInvulnerable(bossGate[i], true)
            set i = i + 1
        endloop
        call event_OpenAllGates()
    endfunction

    private function bossOnCheckReset takes nothing returns nothing

    endfunction

    private function bossOnReset takes nothing returns nothing
        local group pick = CreateGroup()
        local unit u
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call RemoveUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
        call event_OpenAllGates()
        call DisableTrigger(defeatBoss)
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[4])
    endfunction

    private function bossOnDefeat takes nothing returns nothing
        local integer level = bossLevel
        local integer levelDiff = UnitLevel(party[0]) - level
        local integer bonusXP = ((level * level / 2 + level * 2 + 6)  * 5 + level / 5 * 250 + level / 10 * 500) * TEAM_XP_GAIN_RATE / 10000
        local integer bonusGP = (level * level / 4 + level / 10 + 10) * 5
        local group pick = CreateGroup()
        local unit u

        if levelDiff > 0 then 
            set bonusXP = IMaxBJ(0, bonusXP * (10 - 3 * levelDiff) / 10)
        endif 
        call getXP(bonusXP)
        call SetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(PLAYER, PLAYER_STATE_RESOURCE_GOLD) + bonusGP / 2)

        call event_OpenAllGates()
        
        call GroupEnumUnitsInRect(pick, boss.area, isSummonedUnit)
        loop 
            set u = FirstOfGroup(pick)
            exitwhen u == null 
            call GetEnemyFromUnit(u).destroy()
            call KillUnit(u)
            call GroupRemoveUnit(pick, u)
        endloop
        call DestroyGroup(pick)
        set pick = null
        set u = null 
    endfunction

    private function bossOnUpdate takes nothing returns nothing
        local group pick = CreateGroup()
        call GroupEnumUnitsInRect(pick, boss.area, playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            call setCombat(FirstOfGroup(pick))
            call GroupRemoveUnit(pick, FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        call removeAllDisabilities(bossBindUnit)
        set pick = null 
    endfunction

    //======================================================================
    // 【激活 & 击败】
    //======================================================================
    private function activateBoss_Action takes nothing returns nothing
        if GetOwningPlayer(GetTriggerUnit()) == PLAYER and alive(GetTriggerUnit()) and bossBindUnit != null and alive(bossBindUnit) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_ANCIENT) == false then 
            call DisableTrigger(activateBoss)

            set bossDamageMultiple = LEVEL_DAMAGE_MULTIPLE[UnitLevel(bossBindUnit) - 1] * Pow(MAP_DIFFICULTY_MULTIPLE, MAP_EXTRA_LEVEL)
            // 【在此配置技能数据 & 时间线】
            set boss.timeline = 0
            set boss.timelineMax = 100
            set boss.timelineMin = 0
            
            set bossLevel = UnitLevel(boss.u[0])
            call boss.flushTimeLine()

            call boss.activate()
            call UnitShareVision(bossBindUnit, PLAYER, true)
            call delayedevent.create(500, 1, function event_CloseAllGates)
            call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[2])
            call SetUnitInvulnerable(bossBindUnit, false)
            call event_ResetPause()
        endif 
    endfunction

    private function defeatBoss_Action takes nothing returns nothing
        call DisableTrigger(activateBoss)
        call DisableTrigger(defeatBoss)
        call boss.executeDefeat()
        call DisplayTextToPlayer(PLAYER, 0, 0, bossChatMsg[1] + bossChatMsg[3])
    endfunction

    //======================================================================
    // 【文本集中管理】
    //======================================================================
    private function initBossChatMsg takes nothing returns nothing
        set bossChatMsg[0] = "Boss名称"
        set bossChatMsg[1] = "|cffffcc00" + bossChatMsg[0] + "：|r"
        set bossChatMsg[2] = "激活台词"
        set bossChatMsg[3] = "死亡台词"
        set bossChatMsg[4] = "重置台词"
    endfunction

    //======================================================================
    // 【初始化】仅注册，不创建 Boss
    //======================================================================
    private function init takes nothing returns nothing
        call initBossChatMsg()
        set isSummonedUnit = Condition(function Condition_isSummonedUnit)

        // 注册触发器（Boss 创建后自动绑定）
        call TriggerAddAction(defeatBoss, function defeatBoss_Action)
        call TriggerAddAction(activateBoss, function activateBoss_Action)

        // 创建boss实例
        set boss = Boss.createSimple()
        call boss.bindOnInit(function bossOnInit)
        call boss.bindOnResetCheck(function bossOnCheckReset)
        call boss.bindOnReset(function bossOnReset)
        call boss.bindOnDefeat(function bossOnDefeat)
        call boss.bindOnUpdate(function bossOnUpdate)
    endfunction
endscope
//======================================================================
// endregion
//======================================================================

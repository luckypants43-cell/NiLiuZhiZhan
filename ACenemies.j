
library EnemiesSettings requires initSkillDatas

    function UNIT_n642_PREDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitAbilityLevel(damageSource,'Bmfl') > 0 or GetUnitAbilityLevel(damageSource,'Bmfa') > 0 then 
            set damageTag_Arcane = true 
            set damageFlag = 'AP0M'
            set damageIsAOE = true 
        endif 
    endfunction
    function UNIT_n642_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0M') == 0 and unitCheckCooldown(damageSource,'AP0M') then 
            call IssueImmediateOrderById(damageSource,ORDER_manaflareon)
            call unitStartCooldown(damageSource,'AP0M',100)
        endif 
    endfunction


    function UNIT_n602_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP00') == 0 and unitCheckCooldown(damageTarget,'AP00') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_fingerofdeath,damageSource,15)
            call unitStartCooldown(damageTarget,'AP00',100)
        endif 
    endfunction
    function UNIT_n632_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP00') == 0 and unitCheckCooldown(damageTarget,'AP00') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_fingerofdeath,damageSource,15)
            call unitStartCooldown(damageTarget,'AP00',100)
        endif 
    endfunction
    function UNIT_n629_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP00') == 0 and unitCheckCooldown(damageTarget,'AP00') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_fingerofdeath,damageSource,15)
            call unitStartCooldown(damageTarget,'AP00',100)
        elseif GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP02') == 0 and unitCheckCooldown(damageTarget,'AP02') then 
            call IssueImmediateOrderById(damageTarget,ORDER_fanofknives)
            call unitStartCooldown(damageTarget,'AP02',150)
        endif 
    endfunction
    function UNIT_n646_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP00') == 0 and unitCheckCooldown(damageTarget,'AP00') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_fingerofdeath,damageSource,15)
            call unitStartCooldown(damageTarget,'AP00',100)
        endif 
    endfunction
    function AP00_HIT takes nothing returns nothing
        local real dmg = I2R(GetUnitAttack(projectile.currentProjectile.source,0))*2
        call projectile.currentProjectile.applyDamageSet()
        set damageFlag = 'AP00'
        call UnitDamageTarget(projectile.currentProjectile.source,projectile.currentProjectile.target,dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
        call applyStun(projectile.currentProjectile.source,projectile.currentProjectile.target,'ATB1')
        call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl",projectile.currentProjectile.target,"origin"))
    endfunction
    function SPELL_AP00 takes nothing returns nothing   //鱼叉
        local projectile proj 
        set proj = projectile.create(spellCaster)
        set proj.model_path = "abilities\\weapons\\WyvernSpear\\WyvernSpearMissile.mdl"
        set proj.speed = 900
        set proj.curve = 0.2
        set proj.flag = 'AP00'
        set proj.target = spellTarget 
        set proj.TARGET_UNIT = true 
        set proj.LAUNCH_UNIT = true 
        call proj.addOnHit(function AP00_HIT)
        call proj.launch()
    endfunction

    
    function UNIT_n644_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.66 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0P') == 0 and unitCheckCooldown(damageTarget,'AP0P') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_deathcoil,damageSource,50)
            call unitStartCooldown(damageTarget,'AP0P',100)
        elseif GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP08') == 0 and unitCheckCooldown(damageTarget,'AP08') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_fingerofdeath,damageSource,150)
            call unitStartCooldown(damageTarget,'AP08',150)
        elseif GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0Q') == 0 and unitCheckCooldown(damageTarget,'AP0Q') then 
            call delayedIssuePointOrder(damageTarget,ORDER_breathoffrost,GetUnitX(damageSource),GetUnitY(damageSource),100)
            call unitStartCooldown(damageTarget,'AP0Q',150)
        endif 
    endfunction
    function AP0P_HIT takes nothing returns nothing
        local mybuff bf = 0
        local projectile proj = projectile.currentProjectile
        local real dmg = I2R(GetUnitAttack(proj.source,0))*1.5
        call proj.applyDamageSet()
        set damageTag_Shadow = true 
        set damageFlag = 'AP0P'
        call UnitDamageTarget(proj.source,proj.target,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        set bf = CreateBuff(proj.source,proj.target,BUFFTYPE_CRIPPLE,1000)
        set bf.bonusAttack_P = -2000
        set bf.bonusAbilityPower_P = -2000
        call bf.apply()
    endfunction
    function SPELL_AP0P takes nothing returns nothing   //暗影箭
        local projectile proj = CreateProjectileToUnit(spellCaster,spellTarget,1000,0,"Abilities\\Spells\\Undead\\OrbOfDeath\\AnnihilationMissile.mdl",function AP0P_HIT,null)
        set proj.flag = 'AP0P'
        call proj.launch()
    endfunction

    function UNIT_n64H_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.66 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0R') == 0 and unitCheckCooldown(damageTarget,'AP0R') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_deathcoil,damageSource,50)
            call unitStartCooldown(damageTarget,'AP0R',100)
        endif 
    endfunction
    function AP0R_DOT takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local real dmg = I2R(GetUnitAttack(bf.buffSource,0))*0.3
        set damageTag_Fire = true
        set damageTag_Ignite = true 
        set damageIsDOT = true 
        set damageFlag = 'AP0R'
        call UnitDamageTarget(bf.buffSource,bf.buffTarget,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
    endfunction
    function AP0R_HIT takes nothing returns nothing
        local mybuff bf = 0
        local projectile proj = projectile.currentProjectile
        local real dmg = I2R(GetUnitAttack(proj.source,0))*1.5
        call proj.applyDamageSet()
        set damageTag_Fire = true
        set damageFlag = 'AP0R'
        call UnitDamageTarget(proj.source,proj.target,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        set bf = CreateBuff(proj.source,proj.target,BUFFTYPE_BURN,1000)
        set bf.periodTime = 200
        call bf.addPeriod(function AP0R_DOT)
        call bf.apply()
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl",proj.target,"origin"))
        call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl",proj.target,"origin"))
    endfunction
    function SPELL_AP0R takes nothing returns nothing   //炎爆术
        local projectile proj = CreateProjectileToUnit(spellCaster,spellTarget,1000,0,"war3campImported\\Firebolt Rough Medium.mdx",function AP0R_HIT,null)
        set proj.flag = 'AP0R'
        call proj.launch()
    endfunction
    
    function UNIT_n63M_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0E') == 0 and unitCheckCooldown(damageTarget,'AP0E') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_fingerofdeath,damageSource,15)
            call unitStartCooldown(damageTarget,'AP0E',100)
        elseif GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP02') == 0 and unitCheckCooldown(damageTarget,'AP02') then 
            call IssueImmediateOrderById(damageTarget,ORDER_fanofknives)
            call unitStartCooldown(damageTarget,'AP02',150)
        endif 
    endfunction

    
    function AP0Q_HIT takes nothing returns nothing
        local real dmg = I2R(GetUnitAttack(waveCaster,0))*1.75
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageIsAOE = true 
            set damageTag_Shadow = true 
            set damageFlag = 'AP0Q'
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl",waveTarget,"origin"))
        endif 
    endfunction
    function SPELL_AP0Q takes nothing returns nothing   //腐臭蜂群
        local real a = AngleByUnXY(spellCaster,spellTargetX,spellTargetY)
        local real x = GetUnitX(spellCaster)+700*Cos(a/57.2956)
        local real y = GetUnitY(spellCaster)+700*Sin(a/57.2956)
        local projectile proj = CreateWave(spellCaster,x,y,1050,150,180,"Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmMissile.mdl",function AP0Q_HIT,null)
        call proj.launch()
    endfunction

    
    function UNIT_n64R_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0S') == 0 and unitCheckCooldown(damageTarget,'AP0S') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_chainlightning,damageSource,15)
            call unitStartCooldown(damageTarget,'AP0S',100)
        endif 
    endfunction
    function AP0S_HIT takes nothing returns nothing
        local real dmg = I2R(GetUnitAttack(waveCaster,0))*1.55
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageIsAOE = true 
            set damageTag_Cold = true
            set damageFlag = 'AP0S'
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call applyCold(waveCaster,waveTarget,'ACO0')
        endif 
    endfunction
    function SPELL_AP0S takes nothing returns nothing   //冰霜吐息
        local real a = AngleByUnits(spellCaster,spellTarget)
        local real x = GetUnitX(spellCaster)+700*Cos(a/57.2956)
        local real y = GetUnitY(spellCaster)+700*Sin(a/57.2956)
        local projectile proj = CreateWave(spellCaster,x,y,1050,150,0,"Abilities\\Spells\\Other\\BreathOfFrost\\BreathOfFrostMissile.mdl",function AP0S_HIT,null)
        call proj.launch()
    endfunction

    
    
    function UNIT_n64D_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0E') == 0 and unitCheckCooldown(damageTarget,'AP0E') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_fingerofdeath,damageSource,15)
            call unitStartCooldown(damageTarget,'AP0E',100)
        elseif GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0F') == 0 and unitCheckCooldown(damageTarget,'AP0F') then 
            call IssueImmediateOrderById(damageTarget,ORDER_fanofknives)
            call unitStartCooldown(damageTarget,'AP0F',150)
        endif 
    endfunction
    function AP0E_HIT takes nothing returns nothing
        local real dmg = I2R(GetUnitAttack(projectile.currentProjectile.source,0))*1
        call projectile.currentProjectile.applyDamageSet()
        set damageFlag = 'AP0E'
        call UnitDamageTarget(projectile.currentProjectile.source,projectile.currentProjectile.target,dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
        call applyStun(projectile.currentProjectile.source,projectile.currentProjectile.target,'ATB0')
    endfunction
    function SPELL_AP0E takes nothing returns nothing   //投石
        local projectile proj = CreateProjectileToUnit(spellCaster,spellTarget,900,0.2,"Abilities\\Weapons\\RockBoltMissile\\RockBoltMissile.mdl",function AP0E_HIT,null)
        set proj.flag = 'AP0E'
        call proj.launch()
    endfunction

    function UNIT_n622_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.7 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP01') == 0 and unitCheckCooldown(damageSource,'AP01') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP01',150)
        endif 
    endfunction
    function UNIT_n617_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.7 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP01') == 0 and unitCheckCooldown(damageSource,'AP01') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP01',150)
        endif 
    endfunction
    function UNIT_n631_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.7 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP01') == 0 and unitCheckCooldown(damageSource,'AP01') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP01',150)
        elseif GetRandomReal(0,1) < 0.9 and BlzGetUnitAbilityCooldownRemaining(damageSource,'SE08') == 0 and unitCheckCooldown(damageSource,'SE08') then 
            call delayedIssueImmediateOrder(damageSource,ORDER_fanofknives,30)
            call unitStartCooldown(damageSource,'SE08',1000)
        endif 
    endfunction
    function UNIT_n635_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.7 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP01') == 0 and unitCheckCooldown(damageSource,'AP01') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP01',150)
        elseif GetRandomReal(0,1) < 0.9 and BlzGetUnitAbilityCooldownRemaining(damageSource,'SE08') == 0 and unitCheckCooldown(damageSource,'SE08') then 
            call delayedIssueImmediateOrder(damageSource,ORDER_fanofknives,30)
            call unitStartCooldown(damageSource,'SE08',1000)
        endif 
    endfunction
    function UNIT_n63Q_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.7 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP01') == 0 and unitCheckCooldown(damageSource,'AP01') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP01',150)
        endif 
    endfunction
    function UNIT_n64B_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.7 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP01') == 0 and unitCheckCooldown(damageSource,'AP01') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP01',150)
        elseif GetRandomReal(0,1) < 0.9 and BlzGetUnitAbilityCooldownRemaining(damageSource,'SE08') == 0 and unitCheckCooldown(damageSource,'SE08') then 
            call delayedIssueImmediateOrder(damageSource,ORDER_fanofknives,30)
            call unitStartCooldown(damageSource,'SE08',1000)
        endif 
    endfunction
    function SPELL_AP01 takes nothing returns nothing   //火焰爆轰
        set damageTag_Fire = true 
        set damageFlag = 'AP01'
        call UnitDamageTarget(spellCaster,spellTarget,I2R(GetUnitAttack(spellCaster,0))*2.5,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl",spellTarget,"origin"))
    endfunction

    
    function UNIT_n625_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP02') == 0 and unitCheckCooldown(damageTarget,'AP02') then 
            call IssueImmediateOrderById(damageTarget,ORDER_fanofknives)
            call unitStartCooldown(damageTarget,'AP02',150)
        endif 
    endfunction
    function UNIT_n62J_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP02') == 0 and unitCheckCooldown(damageTarget,'AP02') then 
            call IssueImmediateOrderById(damageTarget,ORDER_fanofknives)
            call unitStartCooldown(damageTarget,'AP02',150)
        endif 
    endfunction
    function UNIT_n64E_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP02') == 0 and unitCheckCooldown(damageTarget,'AP02') then 
            call IssueImmediateOrderById(damageTarget,ORDER_fanofknives)
            call unitStartCooldown(damageTarget,'AP02',150)
        endif 
    endfunction
    function UNIT_n625_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.7 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP07') == 0 and unitCheckCooldown(damageSource,'AP07') then 
            if mybuff.getUnitBuff(damageSource,BUFFTYPE_TAUNT) > 0 then 
                call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,GetUnitTaunter(damageSource),30)
            else 
                call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,100)
            endif 
            call unitStartCooldown(damageSource,'AP07',200)
        elseif GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP09') == 0 and unitCheckCooldown(damageSource,'AP09') then 
            call delayedIssuePointOrder(damageSource,ORDER_breathoffrost,GetUnitX(damageTarget),GetUnitY(damageTarget),30)
            call unitStartCooldown(damageSource,'AP09',200)
        endif 
    endfunction
    function UNIT_n635_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP02') == 0 and unitCheckCooldown(damageTarget,'AP02') then 
            call IssueImmediateOrderById(damageTarget,ORDER_fanofknives)
            call unitStartCooldown(damageTarget,'AP02',150)
        endif 
    endfunction
    function UNIT_n63U_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP02') == 0 and unitCheckCooldown(damageTarget,'AP02') then 
            call IssueImmediateOrderById(damageTarget,ORDER_fanofknives)
            call unitStartCooldown(damageTarget,'AP02',150)
        endif 
    endfunction

    function SPELL_AP02 takes nothing returns nothing   //战争践踏
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,GetUnitX(spellCaster),GetUnitY(spellCaster),300+BlzGetUnitCollisionSize(spellCaster),playerAlly)
        loop 
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageFlag = 'AP02'
            set damageCrushRate = 10000
            call UnitDamageTarget(spellCaster,FirstOfGroup(pick),I2R(GetUnitAttack(spellCaster,0))*1,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            call applyStun(spellCaster,FirstOfGroup(pick),'ATB1')
            call GroupRemoveUnit(pick,FirstOfGroup(pick))    
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl",spellCaster,"origin"))
    endfunction


    
    function UNIT_n634_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetUnitState(damageTarget,UNIT_STATE_LIFE)/GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE)-0.8 < 0 and GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0F') == 0 and unitCheckCooldown(damageTarget,'AP0F') then 
            call IssueImmediateOrderById(damageTarget,ORDER_fanofknives)
            call unitStartCooldown(damageTarget,'AP0F',150)
        endif 
    endfunction
    function UNIT_n645_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetUnitState(damageTarget,UNIT_STATE_LIFE)/GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE)-0.8 < 0 and GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0F') == 0 and unitCheckCooldown(damageTarget,'AP0F') then 
            call IssueImmediateOrderById(damageTarget,ORDER_fanofknives)
            call unitStartCooldown(damageTarget,'AP0F',150)
        endif 
    endfunction
    function SPELL_AP0F takes nothing returns nothing   //雷霆一击
        local mybuff bf 
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,GetUnitX(spellCaster),GetUnitY(spellCaster),300+BlzGetUnitCollisionSize(spellCaster),playerAlly)
        loop 
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageFlag = 'AP0F'
            set damageCrushRate = 10000
            call UnitDamageTarget(spellCaster,FirstOfGroup(pick),I2R(GetUnitAttack(spellCaster,0))*1.2,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            set bf = CreateBuff(spellCaster,FirstOfGroup(pick),BUFFTYPE_THUNDERCLAP,500)
            set bf.bonusAttackSpeed = -2500
            set bf.bonusMoveSpeed_P = -4500
            call bf.apply()
            call GroupRemoveUnit(pick,FirstOfGroup(pick))    
        endloop
        call DestroyGroup(pick)
        set pick = null 
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",spellCaster,"origin"))
    endfunction

    function UNIT_n61O_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.75 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP03') == 0 and unitCheckCooldown(damageSource,'AP03') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP03',150)
        endif 
    endfunction
    function UNIT_n61U_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.75 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP03') == 0 and unitCheckCooldown(damageSource,'AP03') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP03',150)
        endif 
    endfunction
    function UNIT_n60N_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.75 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP03') == 0 and unitCheckCooldown(damageSource,'AP03') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP03',150)
        endif 
    endfunction
    function UNIT_n61P_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.7 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP04') == 0 and unitCheckCooldown(damageSource,'AP04') then 
            call IssueImmediateOrderById(damageSource,ORDER_fanofknives)
            call unitStartCooldown(damageSource,'AP04',2000)
        elseif GetRandomReal(0,1) < 0.75 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP03') == 0 and unitCheckCooldown(damageSource,'AP03') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP03',150)
        endif 
    endfunction
    function UNIT_n63C_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.75 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP03') == 0 and unitCheckCooldown(damageSource,'AP03') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP03',150)
        elseif GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0A') == 0 and unitCheckCooldown(damageSource,'AP0A') then 
            call delayedIssuePointOrder(damageSource,ORDER_breathoffrost,GetUnitX(damageTarget),GetUnitY(damageTarget),30)
            call unitStartCooldown(damageSource,'AP0A',200)
        elseif GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.7 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP04') == 0 and unitCheckCooldown(damageSource,'AP04') then 
            call IssueImmediateOrderById(damageSource,ORDER_fanofknives)
            call unitStartCooldown(damageSource,'AP04',2000)
        endif  
    endfunction
    function A64F_DOT takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local unit ds = bf.buffSource   
        local unit dt = bf.buffTarget
        local real dmg = bf.realData*mybuff.buffTimeScale
        set damageFlag = 'A64F'
        set damageTag_Earth = true
        set damageTag_Posion = true  
        set damageIsDOT = true 
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        set ds = null 
        set dt = null 
    endfunction
    function AP03_HIT takes nothing returns nothing
        local real dmg = I2R(GetUnitAttack(projectile.currentProjectile.source,0))*1
        local mybuff bf = mybuff.create(projectile.currentProjectile.source,projectile.currentProjectile.target,BUFFTYPE_SHADOWSTRIKE)
        call projectile.currentProjectile.applyDamageSet()
        set damageFlag = 'AP03'
        set damageTag_Earth = true 
        set damageTag_Posion = true 
        call UnitDamageTarget(projectile.currentProjectile.source,projectile.currentProjectile.target,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        set bf.lastTime = 1500
        set bf.periodTime = 300
        call bf.addPeriod(function A64F_DOT)
        set bf.realData = I2R(GetUnitMaxAttack(projectile.currentProjectile.source,0))*0.5
        set bf.bonusHaste = -2000
        set bf.bonusMoveSpeed_P = -2000
        call bf.apply()
    endfunction
    function SPELL_AP03 takes nothing returns nothing   //暗影突袭
        local projectile proj 
        set proj = projectile.create(spellCaster)
        set proj.model_path = "Abilities\\Spells\\NightElf\\shadowstrike\\ShadowStrikeMissile.mdl"
        set proj.speed = 1200
        set proj.flag = 'AP03'
        set proj.target = spellTarget 
        set proj.TARGET_UNIT = true 
        set proj.LAUNCH_UNIT = true 
        call proj.addOnHit(function AP03_HIT)
        call proj.launch()
    endfunction

    
    function UNIT_n63H_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.75 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0D') == 0 and unitCheckCooldown(damageSource,'AP0D') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP0D',200)
        endif 
    endfunction
    function A65N_DOT takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local unit ds = bf.buffSource   
        local unit dt = bf.buffTarget
        local real dmg = bf.realData*mybuff.buffTimeScale
        set damageFlag = 'A65N'
        set damageTag_Earth = true
        set damageIsDOT = true 
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        set ds = null 
        set dt = null 
    endfunction
    function SPELL_AP0D takes nothing returns nothing       //纠缠根须
        local mybuff bf = mybuff.create(spellCaster,spellTarget,BUFFTYPE_DRUID_ENTANGLINGROOT)
        set bf.lastTime = 800
        set bf.periodTime = 200
        call bf.addPeriod(function A65N_DOT)
        set bf.bonusMoveSpeed_P = -3000
        set bf.realData = I2R(GetUnitMaxAttack(spellCaster,0))*0.4
        call bf.apply()
        call applyRoot(spellCaster,spellTarget,'AET0')
    endfunction

    
    function UNIT_n61L_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n61I_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n61O_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n61U_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n60R_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n60N_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n619_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n61P_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n63C_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n639_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n632_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n63H_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n63A_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n63B_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        endif 
    endfunction
    function UNIT_n649_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE05') == 0 and unitCheckCooldown(damageSource,'SE05') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE05',100)
        elseif BlzGetUnitAbilityCooldownRemaining(damageSource,'SE09') == 0 and unitCheckCooldown(damageSource,'SE09') then 
            call IssueImmediateOrderById(damageSource,ORDER_windwalk)
            call unitStartCooldown(damageSource,'SE09',100)
        endif 
    endfunction
    function A64H_DOT takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local unit ds = bf.buffSource   
        local unit dt = bf.buffTarget
        local real dmg = bf.realData/(I2R(bf.remainingTime)/I2R(bf.periodTime))*mybuff.buffTimeScale
        set bf.realData = bf.realData-dmg
        set damageFlag = 'A64H'
        set damageTag_Earth = true
        set damageTag_Posion = true  
        set damageIsDOT = true 
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        set ds = null 
        set dt = null 
    endfunction
    function SE05_ATKED_S takes nothing returns nothing
        local mybuff bf 
        if GetRandomReal(0,1) < 0.3 then 
            set bf = CreateBuff(damageSource,damageTarget,BUFFTYPE_POSIONATTACK,1800)
            set bf.periodTime = 300
            set bf.realData = bf.realData+2*damageDamage
            call bf.addPeriod(function A64H_DOT)
            call bf.apply()
        endif 
    endfunction
    function SPELL_SE05 takes nothing returns nothing   //毒素附魔
        local mybuff bf = mybuff.create(spellCaster,spellCaster,BUFFTYPE_POSIONENCHANT)
        set bf.lastTime = 6000
        call bf.addAtked_S(function SE05_ATKED_S)
        call bf.apply()
    endfunction


    function UNIT_n64T_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE09') == 0 and unitCheckCooldown(damageSource,'SE09') then 
            call IssueImmediateOrderById(damageSource,ORDER_windwalk)
            call unitStartCooldown(damageSource,'SE09',100)
        endif 
    endfunction
    function A670_DAMAGING_TARGET takes nothing returns nothing
        set damageFinalDamage = damageFinalDamage*0.5
    endfunction
    function SE09_ALLY_SET takes nothing returns nothing
        set aura.modifingAuraBuff.bonusImmune_Root = 1
        set aura.modifingAuraBuff.bonusImmune_Silence = 1
        set aura.modifingAuraBuff.bonusImmune_Snare = 1
        set aura.modifingAuraBuff.bonusImmune_Stun = 1
        call aura.modifingAuraBuff.addDmging_T(function A670_DAMAGING_TARGET)
    endfunction
    function SE09_ALLY_CHECK takes nothing returns nothing
        if aura.filterUnit == aura.checkingAura.bindUnit then 
            set aura.able = false 
        endif 
    endfunction
    function SPELL_SE09 takes nothing returns nothing   //虔诚光环
        local aura ar = CreateAura(spellCaster,"AURA_CREEP_DEVOTIONAURA",900,0,BUFFTYPE_DEVOTIONAURA,"Abilities\\Spells\\Human\\DevotionAura\\DevotionAura.mdl")
        call ar.addAllySet(function SE09_ALLY_SET)
        call ar.addAllyChk(function SE09_ALLY_CHECK)
    endfunction


    function UNIT_n633_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE07') == 0 and unitCheckCooldown(damageSource,'SE07') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE07',100)
        endif 
    endfunction
    function UNIT_n64C_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE07') == 0 and unitCheckCooldown(damageSource,'SE07') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE07',100)
        endif 
    endfunction
    function UNIT_n64D_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE07') == 0 and unitCheckCooldown(damageSource,'SE07') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE07',100)
        endif 
    endfunction
    function UNIT_n64G_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'SE07') == 0 and unitCheckCooldown(damageSource,'SE07') then 
            call IssueImmediateOrderById(damageSource,ORDER_berserk)
            call unitStartCooldown(damageSource,'SE07',100)
        endif 
    endfunction
    function SE07_PERIOD takes nothing returns nothing 
        local mybuff bf = mybuff.currentBuff
        local real dmg = 0.2*I2R(GetUnitMaxAttack(bf.buffSource,0))
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,GetUnitX(bf.buffSource),GetUnitY(bf.buffSource),300+BlzGetUnitCollisionSize(bf.buffSource),playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageTag_Fire = true 
            set damageTag_Ignite = true 
            set damageFlag = 'A65O'
            set damageIsAOE = true 
            call UnitDamageTarget(bf.buffSource,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedDamage.mdl",FirstOfGroup(pick),"chest"))
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick) 
        set pick = null 
    endfunction
    function SPELL_SE07 takes nothing returns nothing   //献祭
        local mybuff bf = mybuff.create(spellCaster,spellCaster,BUFFTYPE_IMMOLATION)
        set bf.lastTime = 6000
        set bf.periodTime = 200
        call bf.addPeriod(function SE07_PERIOD)
        call bf.apply()
    endfunction


    function A64G_DOT takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local unit ds = bf.buffSource   
        local unit dt = bf.buffTarget
        local real dmg = bf.realData*mybuff.buffTimeScale
        set damageFlag = 'A64G'
        set damageTag_Earth = true
        set damageTag_Posion = true  
        set damageIsDOT = true 
        call UnitDamageTarget(ds,dt,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        set ds = null 
        set dt = null 
    endfunction
    function SPELL_AP04 takes nothing returns nothing   //剧毒新星
        local mybuff bf
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,GetUnitX(spellCaster),GetUnitY(spellCaster),500+BlzGetUnitCollisionSize(spellCaster),playerAlly)
        loop 
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageTag_Earth = true 
            set damageTag_Posion = true
            set damageFlag = 'AP04'
            call UnitDamageTarget(spellCaster,FirstOfGroup(pick),I2R(GetUnitAttack(spellCaster,0))*1,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            set bf = CreateBuff(spellCaster,FirstOfGroup(pick),BUFFTYPE_POSIONNOVA,800)
            set bf.periodTime = 100
            set bf.realData = I2R(GetUnitAttack(spellCaster,0))*0.33
            call bf.addPeriod(function A64G_DOT)
            call bf.apply()
            call GroupRemoveUnit(pick,FirstOfGroup(pick))    
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction


    
    function UNIT_n61J_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.75 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP05') == 0 and unitCheckCooldown(damageSource,'AP05') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP05',150)
        endif 
    endfunction
    function UNIT_n61M_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.75 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP05') == 0 and unitCheckCooldown(damageSource,'AP05') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP05',150)
        elseif GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.6 < 0 and GetRandomReal(0,1) < 0.7 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP06') == 0 and unitCheckCooldown(damageSource,'AP06') then 
            call delayedIssueTargetOrder(damageSource,ORDER_chainlightning,damageTarget,30)
            call unitStartCooldown(damageSource,'AP06',150)
        endif 
    endfunction
    function UNIT_n63E_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.75 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP05') == 0 and unitCheckCooldown(damageSource,'AP05') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP05',150)
        elseif GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP06') == 0 and unitCheckCooldown(damageSource,'AP06') then 
            call delayedIssueTargetOrder(damageSource,ORDER_chainlightning,damageTarget,30)
            call unitStartCooldown(damageSource,'AP06',200)
        endif 
    endfunction
    function UNIT_n63G_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.75 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP05') == 0 and unitCheckCooldown(damageSource,'AP05') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP05',150)
        elseif GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP06') == 0 and unitCheckCooldown(damageSource,'AP06') then 
            call delayedIssueTargetOrder(damageSource,ORDER_chainlightning,damageTarget,30)
            call unitStartCooldown(damageSource,'AP06',200)
        elseif GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.75 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP09') == 0 and unitCheckCooldown(damageSource,'AP09') then 
            call delayedIssuePointOrder(damageSource,ORDER_breathoffrost,GetUnitX(damageTarget),GetUnitY(damageTarget),30)
            call unitStartCooldown(damageSource,'AP09',200)
        endif 
    endfunction
    function SPELL_AP05 takes nothing returns nothing   //毒蛇守卫
        local real x = GetUnitX(spellCaster)/2+GetUnitX(spellTarget)/2
        local real y = GetUnitY(spellCaster)/2+GetUnitY(spellTarget)/2
        local unit nu
        local integer i = 0
        loop 
            set i = i+1
            exitwhen i > 60 or PathCheck(x,y)
            set x = GetUnitX(spellCaster)+150*Cos((GetUnitFacing(spellCaster)+GetRandomReal(-120,120))/57.2956)
            set y = GetUnitY(spellCaster)+150*Sin((GetUnitFacing(spellCaster)+GetRandomReal(-120,120))/57.2956)
        endloop
        set nu = CreateUnit(GetOwningPlayer(spellCaster),'n62A',x,y,AngleByUnXY(spellCaster,x,y))
        call UnitApplyTimedLife(nu,'BTLF',60)
        call delayedPauseUnit(nu,100)
        call delayedPlayAnimation(nu,"birth",100)
        call UnitAddType(nu,UNIT_TYPE_SUMMONED)
        call RegisterEnemy(nu)
        set nu = null  
    endfunction 

    
    function UNIT_n62I_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP06') == 0 and unitCheckCooldown(damageSource,'AP06') then 
            call delayedIssueTargetOrder(damageSource,ORDER_chainlightning,damageTarget,30)
            call unitStartCooldown(damageSource,'AP06',200)
        endif 
    endfunction
    function UNIT_n638_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP06') == 0 and unitCheckCooldown(damageSource,'AP06') then 
            call delayedIssueTargetOrder(damageSource,ORDER_chainlightning,damageTarget,30)
            call unitStartCooldown(damageSource,'AP06',200)
        endif 
    endfunction
    function UNIT_n63N_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP06') == 0 and unitCheckCooldown(damageSource,'AP06') then 
            call delayedIssueTargetOrder(damageSource,ORDER_chainlightning,damageTarget,30)
            call unitStartCooldown(damageSource,'AP06',200)
        endif 
    endfunction
    function UNIT_n63T_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP06') == 0 and unitCheckCooldown(damageSource,'AP06') then 
            call delayedIssueTargetOrder(damageSource,ORDER_chainlightning,damageTarget,30)
            call unitStartCooldown(damageSource,'AP06',200)
        endif 
    endfunction
    function AP06_HIT takes nothing returns nothing
        local real dmg = I2R(GetUnitAttack(projectile.currentProjectile.source,0))*3
        call projectile.currentProjectile.applyDamageSet()
        set damageTag_Lightning = true 
        set damageFlag = 'AP06'
        call UnitDamageTarget(projectile.currentProjectile.source,projectile.currentProjectile.target,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\Bolt\\BoltImpact.mdl",projectile.currentProjectile.target,"origin"))
        call UnitsAddLightningSFX(projectile.currentProjectile.bounce_lastTarget,0,0,50,projectile.currentProjectile.target,0,0,50,"CLPB",3,1.5,true)
    endfunction
    function SPELL_AP06 takes nothing returns nothing   //闪电链
        local projectile proj = CreateProjectileToUnit(spellCaster,spellTarget,2000,0,"",function AP06_HIT,null)
        set proj.flag = 'AP06'
        set proj.maxBounceLimit = 5
        set proj.bounceRange = 275
        set proj.bounceMultiplier = 0.8
        call proj.launch()
    endfunction

    
    
    function UNIT_n60N_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0B') == 0 and unitCheckCooldown(damageTarget,'AP0B') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP0B',100)
        endif 
    endfunction
    function UNIT_n63D_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0B') == 0 and unitCheckCooldown(damageTarget,'AP0B') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP0B',100)
        endif 
    endfunction
    function UNIT_n61V_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0B') == 0 and unitCheckCooldown(damageTarget,'AP0B') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP0B',100)
        endif 
    endfunction
    function UNIT_n647_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0B') == 0 and unitCheckCooldown(damageTarget,'AP0B') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP0B',100)
        endif 
    endfunction
    function AP0B_HIT takes nothing returns nothing
        call applySnare(projectile.currentProjectile.source,projectile.currentProjectile.target,'ASN2')
    endfunction
    function SPELL_AP0B takes nothing returns nothing   //诱捕
        local projectile proj = CreateProjectileToUnit(spellCaster,spellTarget,1500,0,"Abilities\\Spells\\Orc\\Ensnare\\EnsnareMissile.mdl",function AP0B_HIT,null)
        call proj.launch()
    endfunction


    function UNIT_n647_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP07') == 0 and unitCheckCooldown(damageSource,'AP07') then 
            if mybuff.getUnitBuff(damageSource,BUFFTYPE_TAUNT) > 0 then 
                call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,GetUnitTaunter(damageSource),30)
            else 
                call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,100)
            endif 
            call unitStartCooldown(damageSource,'AP07',200)
        endif 
    endfunction
    function UNIT_n60Q_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.8 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP07') == 0 and unitCheckCooldown(damageSource,'AP07') then 
            if mybuff.getUnitBuff(damageSource,BUFFTYPE_TAUNT) > 0 then 
                call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,GetUnitTaunter(damageSource),30)
            else 
                call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            endif 
            call unitStartCooldown(damageSource,'AP07',200)
        endif 
    endfunction
    function UNIT_n64G_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.8 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP07') == 0 and unitCheckCooldown(damageSource,'AP07') then 
            if mybuff.getUnitBuff(damageSource,BUFFTYPE_TAUNT) > 0 then 
                call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,GetUnitTaunter(damageSource),30)
            else 
                call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            endif 
            call unitStartCooldown(damageSource,'AP07',200)
        endif 
    endfunction
    function AP07_HIT takes nothing returns nothing
        local real dmg = I2R(GetUnitAttack(projectile.currentProjectile.source,0))*3
        call projectile.currentProjectile.applyDamageSet()
        set damageTag_Fire = true  
        set damageFlag = 'AP07'
        call UnitDamageTarget(projectile.currentProjectile.source,projectile.currentProjectile.target,dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_METAL_HEAVY_CHOP)
        call applyStun(projectile.currentProjectile.source,projectile.currentProjectile.target,'ATB0')
    endfunction
    function SPELL_AP07 takes nothing returns nothing   //烈焰斩
        local projectile proj = CreateProjectileToUnit(spellCaster,spellTarget,9999,0,"Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl",function AP07_HIT,null)
        call proj.launch()
    endfunction



    function UNIT_n63S_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.75 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0L') == 0 and unitCheckCooldown(damageSource,'AP0L') then 
            call IssueImmediateOrderById(damageSource,ORDER_whirlwind)
            call unitStartCooldown(damageSource,'AP0L',100)
        endif 
    endfunction
    function AP0L_DELAYED takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local unit ds = de.loadUnit("CASTER")
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,GetUnitX(ds),GetUnitY(ds),300,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageFlag = 'AP0L'
            set damageIsAOE = true 
            set damageTag_Attack = true 
            set damageCrushRate = 10000
            call UnitDamageTarget(ds,FirstOfGroup(pick),0.75*I2R(GetUnitAttack(ds,0)),true,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_METAL_MEDIUM_SLICE)
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set ds = null 
        set pick = null 
    endfunction
    function SPELL_AP0L takes nothing returns nothing   //剑刃风暴
        local delayedevent de = delayedevent.create(100,5,function AP0L_DELAYED)
        call de.saveUnit("CASTER",spellCaster)
    endfunction

    function UNIT_n63S_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetUnitCurrentOrder(damageTarget) == ORDER_whirlwind then 
            return 
        endif 
        if GetUnitLifePercent(damageTarget) < 90 and GetRandomReal(0,1) < 0.35 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0J') == 0 and unitCheckCooldown(damageTarget,'AP0J') then 
            call IssueTargetOrderById(damageTarget,ORDER_chainlightning,damageSource)
            call unitStartCooldown(damageTarget,'AP0J',100)
        elseif GetUnitLifePercent(damageTarget) < 85 and GetRandomReal(0,1) < 0.55 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0K') == 0 and unitCheckCooldown(damageTarget,'AP0K') then 
            call IssueTargetOrderById(damageTarget,ORDER_channel,damageSource)
            call unitStartCooldown(damageTarget,'AP0K',400)
        endif 
    endfunction
    function SPELL_AP0J takes nothing returns nothing   //一闪
        local real x = GetUnitX(spellTarget)
        local real y = GetUnitY(spellTarget)
        local real a = AngleByUnits(spellCaster,spellTarget)/57.2956
        local real dis = 100+BlzGetUnitCollisionSize(spellCaster)+BlzGetUnitCollisionSize(spellTarget)
        set x = x+dis*Cos(a)
        set y = y+dis*Sin(a)
        call UnitDashToPoint(spellCaster,x,y,0)
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl",x,y))
        set damageFlag = 'AP0J'
        set damageCrushRate = 10000
        set damageTag_Attack = true 
        call UnitDamageTarget(spellCaster,spellTarget,1.5*I2R(GetUnitAttack(spellCaster,0)),true,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_METAL_MEDIUM_SLICE)
    endfunction


    function UNIT_n63W_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0N') == 0 and unitCheckCooldown(damageSource,'AP0N') then 
            call delayedIssueTargetOrder(damageSource,ORDER_chainlightning,damageTarget,300)
            call unitStartCooldown(damageSource,'AP0N',300)
        endif 
    endfunction
    function UNIT_n64A_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0N') == 0 and unitCheckCooldown(damageSource,'AP0N') then 
            call delayedIssueTargetOrder(damageSource,ORDER_chainlightning,damageTarget,300)
            call unitStartCooldown(damageSource,'AP0N',300)
        endif 
    endfunction
    function UNIT_n64U_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0N') == 0 and unitCheckCooldown(damageSource,'AP0N') then 
            call delayedIssueTargetOrder(damageSource,ORDER_chainlightning,damageTarget,300)
            call unitStartCooldown(damageSource,'AP0N',300)
        endif 
    endfunction
    function SPELL_AP0N takes nothing returns nothing   //冰霜新星
        local real x = GetUnitX(spellTarget)
        local real y = GetUnitY(spellTarget)
        local real dmg = 2*I2R(GetUnitAttack(spellCaster,0))
        local group pick = CreateGroup()
        call GroupEnumUnitsInRange(pick,x,y,250,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageFlag = 'AP0N'
            set damageIsAOE = true 
            set damageTag_Cold = true 
            if spellCaster == FirstOfGroup(pick) then 
                call UnitDamageTarget(spellCaster,FirstOfGroup(pick),dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            else 
                call UnitDamageTarget(spellCaster,FirstOfGroup(pick),0.6*dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            endif 
            call applyCold(spellCaster,FirstOfGroup(pick),'ACO0')
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set pick = null 
    endfunction

    function AP0K_DAMAGE takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local unit ds = de.loadUnit("CASTER")
        local unit dt = de.loadUnit("TARGET")
        set damageFlag = 'AP0K'
        set damageCrushRate = 10000
        call UnitDamageTarget(ds,dt,1*I2R(GetUnitAttack(ds,0)),true,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_METAL_MEDIUM_SLICE)
        set ds = null 
        set dt = null 
    endfunction
    function AP0K_REFRESH takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local unit ds = de.loadUnit("CASTER")
        
        call UnitRemoveAbilityEx(ds,'AP0K')
        call UnitAddAbilityEx(ds,'AP0K')
        call BlzStartUnitAbilityCooldown(ds,'AP0K',15)
        set ds = null 
    endfunction
    function AP0K_DELAYED_ATTACK takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local unit ds = de.loadUnit("CASTER")
        local unit dt = de.loadUnit("TARGET")
        local group pick = CreateGroup()
        local real a 
        local real d 
        call GroupEnumUnitsInRange(pick,GetUnitX(dt),GetUnitY(dt),400,playerHero)
        call GroupRemoveUnit(pick,dt)
        if GetUnitCurrentOrder(ds) == ORDER_channel and CountUnitsInGroup(pick) > 0 then 
            set dt = GroupPickRandomUnitEx(pick)
            set a = AngleByUnits(dt,ds)/57.2956
            set d = 100+BlzGetUnitCollisionSize(ds)+BlzGetUnitCollisionSize(dt)
            call UnitDashToPoint(ds,GetUnitX(dt)+d*Cos(a),GetUnitY(dt)+d*Sin(a),0)
            call BlzSetUnitFacingEx(ds,AngleByUnits(ds,dt))
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl",GetUnitX(ds),GetUnitY(ds)))
            call de.saveUnit("TARGET",dt)
            set de = delayedevent.create(33,1,function AP0K_DAMAGE)
            call SetUnitAnimation(ds,"attack")
            call de.saveUnit("CASTER",ds)
            call de.saveUnit("TARGET",dt)
        else 
            set de.DESTROY = true 
        endif 
        call DestroyGroup(pick)
        set ds = null 
        set dt = null 
        set pick = null 
    endfunction
    function SPELL_AP0K takes nothing returns nothing   //无敌斩
        local delayedevent de = delayedevent.create(30,7,function AP0K_DELAYED_ATTACK)
        local real a 
        local real d 
        set a = AngleByUnits(spellTarget,spellCaster)/57.2956
        set d = 100+BlzGetUnitCollisionSize(spellCaster)+BlzGetUnitCollisionSize(spellTarget)
        call UnitDashToPoint(spellCaster,GetUnitX(spellTarget)+d*Cos(a),GetUnitY(spellTarget)+d*Sin(a),0)
        call de.saveUnit("CASTER",spellCaster)
        call de.saveUnit("TARGET",spellTarget)
        call de.addOnEnd(function AP0K_REFRESH)
        set de = delayedevent.create(33,1,function AP0K_DAMAGE)
        call SetUnitAnimation(spellCaster,"attack")
        call de.saveUnit("CASTER",spellCaster)
        call de.saveUnit("TARGET",spellTarget)

        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl",GetUnitX(spellCaster),GetUnitY(spellCaster)))
    endfunction
    

    function UNIT_n61S_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.3 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP08') == 0 and unitCheckCooldown(damageTarget,'AP08') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP08',100)
        endif 
    endfunction
    function UNIT_n60R_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.3 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP08') == 0 and unitCheckCooldown(damageTarget,'AP08') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP08',100)
        endif 
    endfunction
    function UNIT_n60P_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.3 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP08') == 0 and unitCheckCooldown(damageTarget,'AP08') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP08',100)
        endif 
    endfunction
    function UNIT_n639_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.3 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP08') == 0 and unitCheckCooldown(damageTarget,'AP08') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP08',100)
        endif 
    endfunction
    function UNIT_n648_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.3 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP08') == 0 and unitCheckCooldown(damageTarget,'AP08') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP08',100)
        elseif GetRandomReal(0,1) < 0.66 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0P') == 0 and unitCheckCooldown(damageTarget,'AP0P') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_deathcoil,damageSource,50)
            call unitStartCooldown(damageTarget,'AP0P',100)
        endif 
    endfunction
    function UNIT_n64C_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.3 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP08') == 0 and unitCheckCooldown(damageTarget,'AP08') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP08',100)
        elseif GetRandomReal(0,1) < 0.66 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0P') == 0 and unitCheckCooldown(damageTarget,'AP0P') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_deathcoil,damageSource,50)
            call unitStartCooldown(damageTarget,'AP0P',100)
        endif 
    endfunction
    function SPELL_AP08 takes nothing returns nothing   //沉默
        call applySilence(spellCaster,spellTarget,'ASI1')
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Other\\Silence\\SilenceAreaBirth.mdl",GetUnitX(spellTarget),GetUnitY(spellTarget)))
    endfunction


    
    function UNIT_n62J_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP09') == 0 and unitCheckCooldown(damageSource,'AP09') then 
            call delayedIssuePointOrder(damageSource,ORDER_breathoffrost,GetUnitX(damageTarget),GetUnitY(damageTarget),30)
            call unitStartCooldown(damageSource,'AP09',200)
        endif 
    endfunction
    function UNIT_n63M_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP09') == 0 and unitCheckCooldown(damageSource,'AP09') then 
            call delayedIssuePointOrder(damageSource,ORDER_breathoffrost,GetUnitX(damageTarget),GetUnitY(damageTarget),30)
            call unitStartCooldown(damageSource,'AP09',200)
        endif 
    endfunction
    function UNIT_n649_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP09') == 0 and unitCheckCooldown(damageSource,'AP09') then 
            call delayedIssuePointOrder(damageSource,ORDER_breathoffrost,GetUnitX(damageTarget),GetUnitY(damageTarget),30)
            call unitStartCooldown(damageSource,'AP09',200)
        endif 
    endfunction
    function AP09_HIT takes nothing returns nothing
        local real dmg = I2R(GetUnitAttack(waveCaster,0))*1.75
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageIsAOE = true 
            set damageCrushRate = 1000
            set damageFlag = 'AP09'
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,false,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
        endif 
    endfunction
    function SPELL_AP09 takes nothing returns nothing   //震荡波
        local real a = AngleByUnXY(spellCaster,spellTargetX,spellTargetY)
        local real x = GetUnitX(spellCaster)+700*Cos(a/57.2956)
        local real y = GetUnitY(spellCaster)+700*Sin(a/57.2956)
        local projectile proj = CreateWave(spellCaster,x,y,1050,150,0,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl",function AP09_HIT,null)
        call proj.launch()
    endfunction


    function UNIT_n63N_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0I') == 0 and unitCheckCooldown(damageTarget,'AP0I') then 
            call delayedIssuePointOrder(damageTarget,ORDER_breathoffrost,GetUnitX(damageSource),GetUnitY(damageTarget),15)
            call unitStartCooldown(damageTarget,'AP0I',100)
        endif 
    endfunction
    function UNIT_n628_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0I') == 0 and unitCheckCooldown(damageTarget,'AP0I') then 
            call delayedIssuePointOrder(damageTarget,ORDER_breathoffrost,GetUnitX(damageSource),GetUnitY(damageTarget),15)
            call unitStartCooldown(damageTarget,'AP0I',100)
        endif 
    endfunction
    function UNIT_n63Q_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0I') == 0 and unitCheckCooldown(damageTarget,'AP0I') then 
            call delayedIssuePointOrder(damageTarget,ORDER_breathoffrost,GetUnitX(damageSource),GetUnitY(damageTarget),15)
            call unitStartCooldown(damageTarget,'AP0I',100)
        endif 
    endfunction
    function AP0I_AOE takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local unit caster = de.loadUnit("CASTER")
        local group pick = CreateGroup()
        local real dmg = de.loadReal("DAMAGE")
        call GroupEnumUnitsInRange(pick,x,y,250,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageTag_Lightning = true 
            set damageFlag = 'AP0I'
            call UnitDamageTarget(caster,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl",FirstOfGroup(pick),"origin"))
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set caster = null 
        set pick = null 
    endfunction
    function SPELL_AP0I takes nothing returns nothing   //季风
        local delayedevent de = delayedevent.create(200,4,function AP0I_AOE)
        call de.saveUnit("CASTER",spellCaster)
        call de.saveReal("X",spellTargetX)
        call de.saveReal("Y",spellTargetY)
        call de.saveReal("DAMAGE",I2R(GetUnitMaxAttack(spellCaster,0))*0.5)
        call delayedDestroyEffect(AddSpecialEffectEX("Abilities\\Spells\\Other\\Monsoon\\MonsoonRain.mdl",spellTargetX,spellTargetY),800)
    endfunction

    
    function UNIT_n63W_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0O') == 0 and unitCheckCooldown(damageTarget,'AP0O') then 
            call delayedIssuePointOrder(damageTarget,ORDER_breathoffrost,GetUnitX(damageSource),GetUnitY(damageTarget),15)
            call unitStartCooldown(damageTarget,'AP0O',100)
        endif 
    endfunction
    function UNIT_n64A_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0O') == 0 and unitCheckCooldown(damageTarget,'AP0O') then 
            call delayedIssuePointOrder(damageTarget,ORDER_breathoffrost,GetUnitX(damageSource),GetUnitY(damageTarget),15)
            call unitStartCooldown(damageTarget,'AP0O',100)
        endif 
    endfunction
    function UNIT_n64S_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0O') == 0 and unitCheckCooldown(damageTarget,'AP0O') then 
            call delayedIssuePointOrder(damageTarget,ORDER_breathoffrost,GetUnitX(damageSource),GetUnitY(damageTarget),15)
            call unitStartCooldown(damageTarget,'AP0O',100)
        elseif GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0S') == 0 and unitCheckCooldown(damageTarget,'AP0S') then 
            call delayedIssueTargetOrder(damageTarget,ORDER_chainlightning,damageSource,15)
            call unitStartCooldown(damageTarget,'AP0S',100)
        elseif GetRandomReal(0,1) < 0.3 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP08') == 0 and unitCheckCooldown(damageTarget,'AP08') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP08',100)
        endif 
    endfunction
    function AP0O_AOE takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local unit caster = de.loadUnit("CASTER")
        local group pick = CreateGroup()
        local real dmg = de.loadReal("DAMAGE")
        call GroupEnumUnitsInRange(pick,x,y,250,playerAlly)
        loop
            exitwhen FirstOfGroup(pick) == null 
            set damageIsAOE = true 
            set damageTag_Cold = true 
            set damageFlag = 'AP0O'
            call UnitDamageTarget(caster,FirstOfGroup(pick),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveFirstUnit(pick)
        endloop
        call DestroyGroup(pick)
        set caster = null 
        set pick = null 
    endfunction
    function AP0O_SFX takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real x = de.loadReal("X")
        local real y = de.loadReal("Y")
        local integer i = 0
        local real a
        local real d 
        local delayedevent dede 
        local location loc = Location(x,y)
        set dede = delayedevent.create(75,1,function AP0O_AOE)
        call dede.saveUnit("CASTER",de.loadUnit("CASTER"))
        call dede.saveReal("X",x)
        call dede.saveReal("Y",y)
        call dede.saveReal("DAMAGE",de.loadReal("DAMAGE"))
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
    function SPELL_AP0O takes nothing returns nothing   //暴风雪
        local delayedevent de = delayedevent.create(100,7,function AP0O_SFX)
        call de.saveUnit("CASTER",spellCaster)
        call de.saveReal("X",spellTargetX)
        call de.saveReal("Y",spellTargetY)
        call de.saveReal("DAMAGE",I2R(GetUnitMaxAttack(spellCaster,0))*0.5)

        set de = delayedevent.create(1,1,function AP0O_SFX)
        call de.saveUnit("CASTER",spellCaster)
        call de.saveReal("X",spellTargetX)
        call de.saveReal("Y",spellTargetY)
        call de.saveReal("DAMAGE",I2R(GetUnitMaxAttack(spellCaster,0))*0.5)
    endfunction
    
    function UNIT_n63L_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0G') == 0 and unitCheckCooldown(damageSource,'AP0G') then 
            call delayedIssuePointOrder(damageSource,ORDER_breathoffrost,GetUnitX(damageTarget),GetUnitY(damageTarget),30)
            call unitStartCooldown(damageSource,'AP0G',200)
        endif 
    endfunction
    function UNIT_n629_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0G') == 0 and unitCheckCooldown(damageSource,'AP0G') then 
            call delayedIssuePointOrder(damageSource,ORDER_breathoffrost,GetUnitX(damageTarget),GetUnitY(damageTarget),30)
            call unitStartCooldown(damageSource,'AP0G',200)
        endif 
    endfunction
    function AP0G_HIT takes nothing returns nothing
        local mybuff bf 
        local real dmg = I2R(GetUnitAttack(waveCaster,0))*1.5
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageIsAOE = true 
            set damageTag_Cold = true 
            set damageFlag = 'AP0G'
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            set bf = mybuff.create(waveCaster,waveTarget,BUFFTYPE_SLOW)
            set bf.lastTime = 2000
            set bf.bonusHaste = -2000
            set bf.bonusMoveSpeed_P = -2500
            call bf.apply()
        endif 
    endfunction
    function AP0G_SFX takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local projectile proj = de.loadInteger("PROJ")
        local integer i = 0
        local real x = GetUnitX(proj.dummy)
        local real y = GetUnitY(proj.dummy)
        local real x1 
        local real y1
        local real a 
        local effect sfx 
        loop
            exitwhen i > 5
            set a = (-70+20*I2R(i)+GetUnitFacing(proj.dummy))/57.2956
            set x1 = x+175*Cos(a)+GetRandomReal(-10,10)
            set y1 = y+175*Sin(a)+GetRandomReal(-10,10)
            set sfx = AddSpecialEffectEX("units\\human\\WaterElemental\\WaterElemental.mdl",x1,y1)
            call BlzSetSpecialEffectOrientation(sfx,a,0,0)
            call DestroyEffectEX(sfx)
            set i = i+1
        endloop
        set sfx = null 
    endfunction
    function SPELL_AP0G takes nothing returns nothing   //冲击波
        local real a = AngleByUnXY(spellCaster,spellTargetX,spellTargetY)
        local real x = GetUnitX(spellCaster)+700*Cos(a/57.2956)
        local real y = GetUnitY(spellCaster)+700*Sin(a/57.2956)
        local projectile proj = CreateWave(spellCaster,x,y,1000,250,0,"",function AP0G_HIT,null)
        local delayedevent de = delayedevent.create(14,5,function AP0G_SFX)
        call proj.launch()
        call de.saveInteger("PROJ",proj)
        set de = delayedevent.create(1,1,function AP0G_SFX)
        call de.saveInteger("PROJ",proj)
    endfunction


    
    function UNIT_n63L_ATTACKING takes nothing returns nothing
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0H') == 0 and unitCheckCooldown(damageSource,'AP0H') then 
            call delayedIssueTargetOrder(damageSource,ORDER_chainlightning,damageTarget,30)
            call unitStartCooldown(damageSource,'AP0H',100)
        endif 
    endfunction

    function AP0H_HIT takes nothing returns nothing
        local real dmg = I2R(GetUnitAttack(waveCaster,0))*1.75
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageIsAOE = true 
            set damageTag_Cold = true 
            set damageFlag = 'AP0G'
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl",waveTarget,"chest"))
        endif 
    endfunction
    function AP0H_END takes nothing returns nothing
        call ShowUnit(projectile.currentProjectile.source,true)
    endfunction
    function AP0H_SFX takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local unit caster = de.loadUnit("CASTER")
        call DestroyEffectEX(AddSpecialEffectEX("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl",GetUnitX(caster),GetUnitY(caster)))
        set caster = null 
    endfunction
    function SPELL_AP0H takes nothing returns nothing   //水元素冲锋
        local delayedevent de = delayedevent.create(5,10,function AP0H_SFX)
        local projectile proj = ChargeTargetEx(spellCaster,spellTarget,600,200,0,true,1200,0,function AP0H_HIT,function AP0H_END)
        call ShowUnit(spellCaster,false)
        call de.saveUnit("CASTER",spellCaster)
    endfunction


    function UNIT_n62D_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0A') == 0 and unitCheckCooldown(damageSource,'AP0A') then 
            call delayedIssuePointOrder(damageSource,ORDER_breathoffrost,GetUnitX(damageTarget),GetUnitY(damageTarget),30)
            call unitStartCooldown(damageSource,'AP0A',200)
        elseif GetRandomReal(0,1) < 0.5 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP03') == 0 and unitCheckCooldown(damageSource,'AP03') then 
            call delayedIssueTargetOrder(damageSource,ORDER_fingerofdeath,damageTarget,30)
            call unitStartCooldown(damageSource,'AP03',150)
        endif 
    endfunction 
    function UNIT_n63B_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetUnitState(damageSource,UNIT_STATE_LIFE)/GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)-0.9 < 0 and BlzGetUnitAbilityCooldownRemaining(damageSource,'AP0A') == 0 and unitCheckCooldown(damageSource,'AP0A') then 
            call delayedIssuePointOrder(damageSource,ORDER_breathoffrost,GetUnitX(damageTarget),GetUnitY(damageTarget),30)
            call unitStartCooldown(damageSource,'AP0A',200)
        endif 
    endfunction 
    function AP0A_SFX takes nothing returns nothing
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
    function AP0A_HIT takes nothing returns nothing
        local real dmg = I2R(GetUnitAttack(waveCaster,0))*1.75
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            call Knockup.create(waveTarget,300,0.8,"")
            set damageFlag = 'AP0A' 
            set damageIsAOE = true 
            set damageCrushRate = 1000
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl",GetUnitX(waveTarget),GetUnitY(waveTarget)))
            call applyStun(waveCaster,waveTarget,'ATB1')
        endif 
    endfunction
    function SPELL_AP0A takes nothing returns nothing   //穿刺
        local delayedevent de = delayedevent.create(15,20,function AP0A_SFX)
        local real a = AngleByUnXY(spellCaster,spellTargetX,spellTargetY)/57.2956
        local projectile proj = CreateWave(spellCaster,GetUnitX(spellCaster)+1100*Cos(a),GetUnitY(spellCaster)+1100*Sin(a),1000,120,0,"",function AP0A_HIT,null)
        call proj.launch()
        call de.saveInteger("PROJ",proj)
    endfunction


    function UNIT_n60M_AFTERDAMAGE_TARGET takes nothing returns nothing
        if GetRandomReal(0,1) < 0.3 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'AP0C') == 0 and unitCheckCooldown(damageTarget,'AP0C') then 
            call IssueTargetOrderById(damageTarget,ORDER_fingerofdeath,damageSource)
            call unitStartCooldown(damageTarget,'AP0C',100)
        endif 
    endfunction
    function AP0C_HIT takes nothing returns nothing
        local real dmg = I2R(GetUnitAttack(eventHook.caster,0))*2
        set damageFlag = 'AP0C' 
        set damageIsAOE = true 
        set damageCrushRate = 1000
        call UnitDamageTarget(eventHook.caster,eventHook.target,dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl",eventHook.target,"origin"))
        call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl",eventHook.target,"chest"))
        call applyStun(waveCaster,waveTarget,'ATB1')
    endfunction
    function SPELL_AP0C takes nothing returns nothing   //肉钩
        local Hook HK = HookTarget(spellCaster,spellTarget,'hC00','hC01',32,1200,1500,function AP0C_HIT)
        set HK.attachDistance = 100
    endfunction

    function UNIT_n614_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.9 and BlzGetUnitAbilityCooldownRemaining(damageSource,'SE01') == 0 and unitCheckCooldown(damageSource,'SE01') then 
            call delayedIssueImmediateOrder(damageSource,ORDER_fanofknives,30)
            call unitStartCooldown(damageSource,'SE01',100)
        endif 
    endfunction
    function UNIT_n61T_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.9 and BlzGetUnitAbilityCooldownRemaining(damageSource,'SE01') == 0 and unitCheckCooldown(damageSource,'SE01') then 
            call delayedIssueImmediateOrder(damageSource,ORDER_fanofknives,30)
            call unitStartCooldown(damageSource,'SE01',6000)
        endif 
    endfunction
    function UNIT_n60O_AFTERDAMAGE_SOURCE takes nothing returns nothing
        if GetRandomReal(0,1) < 0.9 and BlzGetUnitAbilityCooldownRemaining(damageSource,'SE01') == 0 and unitCheckCooldown(damageSource,'SE01') then 
            call delayedIssueImmediateOrder(damageSource,ORDER_fanofknives,30)
            call unitStartCooldown(damageSource,'SE01',6000)
        endif 
    endfunction
    function SPELL_SE01 takes nothing returns nothing   //召唤骷髅
        local real x = GetUnitX(spellCaster)+150*Cos((GetUnitFacing(spellCaster)+GetRandomReal(-60,60))/57.2956)
        local real y = GetUnitY(spellCaster)+150*Sin((GetUnitFacing(spellCaster)+GetRandomReal(-60,60))/57.2956)
        local unit nu
        local integer i = 0
        loop 
            set i = i+1
            exitwhen i > 60 or PathCheck(x,y)
            set x = GetUnitX(spellCaster)+150*Cos((GetUnitFacing(spellCaster)+GetRandomReal(-120,120))/57.2956)
            set y = GetUnitY(spellCaster)+150*Sin((GetUnitFacing(spellCaster)+GetRandomReal(-120,120))/57.2956)
        endloop
        set nu = CreateUnit(GetOwningPlayer(spellCaster),'n60F',x,y,AngleByUnXY(spellCaster,x,y))
        call UnitApplyTimedLife(nu,'BTLF',60)
        call delayedPauseUnit(nu,150)
        call delayedPlayAnimation(nu,"birth",200)
        call DestroyEffectEX(AddSpecialEffectEX("Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl",x,y))
        call UnitAddType(nu,UNIT_TYPE_SUMMONED)
        call RegisterEnemy(nu)
        set nu = null  
    endfunction 
    function SPELL_SE08 takes nothing returns nothing   //召唤熔岩魔
        local real x = GetUnitX(spellCaster)+150*Cos((GetUnitFacing(spellCaster)+GetRandomReal(-60,60))/57.2956)
        local real y = GetUnitY(spellCaster)+150*Sin((GetUnitFacing(spellCaster)+GetRandomReal(-60,60))/57.2956)
        local unit nu
        local integer i = 0
        loop 
            set i = i+1
            exitwhen i > 60 or PathCheck(x,y)
            set x = GetUnitX(spellCaster)+150*Cos((GetUnitFacing(spellCaster)+GetRandomReal(-120,120))/57.2956)
            set y = GetUnitY(spellCaster)+150*Sin((GetUnitFacing(spellCaster)+GetRandomReal(-120,120))/57.2956)
        endloop
        set nu = CreateUnit(GetOwningPlayer(spellCaster),'n62N',x,y,AngleByUnXY(spellCaster,x,y))
        call UnitApplyTimedLife(nu,'BTLF',60)
        call delayedPauseUnit(nu,60)
        call delayedPlayAnimation(nu,"birth",67)
        call UnitAddType(nu,UNIT_TYPE_SUMMONED)
        call RegisterEnemy(nu)
        set nu = null  
    endfunction 
    function SE00_DOT takes nothing returns nothing
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
    function SPELL_SE00 takes nothing returns nothing   //痛苦诅咒
        local mybuff bf = mybuff.create(spellCaster,spellTarget,BUFFTYPE_CURSEOFPAIN)
        set bf.lastTime = 3000
        set bf.periodTime = 200
        set bf.bindSFX = AddSpecialEffectTargetEX("war3campImported\\shamanyouranus-shadowymissile.mdx",spellTarget,"chest")
        call bf.addPeriod(function SE00_DOT)
        set bf.realData = I2R(GetUnitMaxAttack(spellCaster,0))*0.66
        set bf.bonusAccuracy = -3000
        call bf.apply()
    endfunction 
    function SPELL_SE02 takes nothing returns nothing   //狂暴
        local mybuff bf = mybuff.create(spellCaster,spellTarget,BUFFTYPE_FRENZY)
        set bf.lastTime = 1000
        set bf.bonusAttackSpeed = 5000
        set bf.bonusMoveSpeed_P = 5000
        call bf.apply()
    endfunction 
    function SE03_HOT takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local unit ds = bf.buffSource   
        local unit dt = bf.buffTarget
        local real dmg = bf.realData*mybuff.buffTimeScale
        set healFlag = 'A64D'
        set healIsDOT = true 
        call UnitHealTarget(ds,dt,dmg)
        set ds = null 
        set dt = null 
    endfunction
    function SPELL_SE03 takes nothing returns nothing   //恢复
        local mybuff bf = mybuff.create(spellCaster,spellTarget,BUFFTYPE_REGEN)
        set bf.lastTime = 3000
        set bf.periodTime = 200
        call bf.addPeriod(function SE03_HOT)
        set bf.realData = I2R(GetUnitMaxAttack(spellCaster,0))*0.85
        call bf.apply()
        set healFlag = 'SE03'
        call UnitHealTarget(spellCaster,spellTarget,I2R(GetUnitMaxAttack(spellCaster,0))*1.5)
    endfunction 
    function SPELL_SE04 takes nothing returns nothing   //减速
        local mybuff bf = mybuff.create(spellCaster,spellTarget,BUFFTYPE_SLOW)
        set bf.lastTime = 2000
        set bf.bonusHaste = -2000
        set bf.bonusMoveSpeed_P = -2500
        call bf.apply()
    endfunction 
    function SPELL_SE06 takes nothing returns nothing   //破甲
        local mybuff bf = mybuff.create(spellCaster,spellTarget,BUFFTYPE_SUNDERARMOR)
        set bf.lastTime = 2000
        set bf.bonusArmor = -5-UnitLevel(spellCaster)
        set bf.bonusArmor_P = -1000
        call bf.apply()
    endfunction 

endlibrary


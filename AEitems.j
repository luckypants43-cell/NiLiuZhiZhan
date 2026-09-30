
library RecipeSystemSettings initializer init requires basic
    globals 
        Recipe nowRecipie                = 0
        item nowResultItem               = null
        unit nowRecipieOwner             = null 

        integer array EncItemId
        integer maxEncItem
    endglobals
    function EncItemUpLevel takes nothing returns nothing
        local integer il = UnitLevel(nowRecipieOwner)
        local integer i = maxEncItem
        local integer iid = GetItemTypeId(nowResultItem)

        if il >= 20 then 
            set il = 3
        elseif il >= 18 then 
            set il = 2
        elseif il >= 14 then 
            set il = 1
        else
            set il = 0
        endif  
        if il == 0 then 
            return 
        endif 

        loop
            exitwhen i == 0
            if EncItemId[i*10] == iid then
                call RemoveItem(nowResultItem)
                set nowResultItem = CreateItemEx(EncItemId[i*10+il],GetUnitX(nowRecipieOwner),GetUnitY(nowRecipieOwner))
                exitwhen true 
            endif 
            set i = i-1
        endloop
    endfunction

    function Craft_Ic00_x3 takes nothing returns nothing
        local integer i = 0
        local integer r = 0
        loop
            exitwhen i > 2
            call craftPool.flush()
            call craftPool.add(3000,5)
            call craftPool.add(3002,5)
            call craftPool.add(3008,5)
            call craftPool.add(3011,5)
            call craftPool.add(3013,5)
            call craftPool.add(3014,3)
            call craftPool.add(3015,3)
            set r = craftPool.pick()
            call GetEquipment(nowResultItem).craft(r)
            set i = i+1
        endloop
    endfunction

    function Craft_Ic01_x2 takes nothing returns nothing
        local integer i = 0
        local integer r = 0
        loop
            exitwhen i > 1
            call craftPool.flush()
            call craftPool.add(3001,5)
            call craftPool.add(3004,5)
            call craftPool.add(3006,5)
            call craftPool.add(3012,5)
            call craftPool.add(3019,5)
            set r = craftPool.pick()
            call GetEquipment(nowResultItem).craft(r)
            set i = i+1
        endloop
    endfunction

    function Craft_Ic03_x2 takes nothing returns nothing
        local integer i = 0
        local integer r = 0
        loop
            exitwhen i > 1
            call craftPool.flush()
            call craftPool.add(3000,5)
            call craftPool.add(3003,5)
            call craftPool.add(3010,5)
            call craftPool.add(3013,5)
            call craftPool.add(3016,5)
            call craftPool.add(3017,5)
            set r = craftPool.pick()
            call GetEquipment(nowResultItem).craft(r)
            set i = i+1
        endloop
    endfunction

    function Craft_Ic02_x2 takes nothing returns nothing
        local integer i = 0
        local integer r = 0
        loop
            exitwhen i > 1
            call craftPool.flush()
            call craftPool.add(3003,5)
            call craftPool.add(3005,5)
            call craftPool.add(3007,5)
            call craftPool.add(3009,5)
            call craftPool.add(3013,5)
            call craftPool.add(3018,5)
            set r = craftPool.pick()
            call GetEquipment(nowResultItem).craft(r)
            set i = i+1
        endloop
    endfunction

    private function init takes nothing returns nothing
        set EncItemId[10] = 'I643'
        set EncItemId[11] = 'I64L'
        set EncItemId[12] = 'I653'
        set EncItemId[13] = 'I65L'

        set EncItemId[20] = 'I649'
        set EncItemId[21] = 'I64R'
        set EncItemId[22] = 'I659'
        set EncItemId[23] = 'I65R'

        set EncItemId[30] = 'I646'
        set EncItemId[31] = 'I64O'
        set EncItemId[32] = 'I656'
        set EncItemId[33] = 'I65O'

        set EncItemId[40] = 'I64F'
        set EncItemId[41] = 'I64X'
        set EncItemId[42] = 'I65F'
        set EncItemId[43] = 'I65X'

        set EncItemId[50] = 'I64I'
        set EncItemId[51] = 'I650'
        set EncItemId[52] = 'I65I'
        set EncItemId[53] = 'I660'

        set EncItemId[60] = 'I64C'
        set EncItemId[61] = 'I64U'
        set EncItemId[62] = 'I65C'
        set EncItemId[63] = 'I65U'

        set EncItemId[70] = 'I647'
        set EncItemId[71] = 'I64P'
        set EncItemId[72] = 'I657'
        set EncItemId[73] = 'I65P'

        set EncItemId[80] = 'I644'
        set EncItemId[81] = 'I64M'
        set EncItemId[82] = 'I654'
        set EncItemId[83] = 'I65M'

        set EncItemId[90] = 'I64A'
        set EncItemId[91] = 'I64S'
        set EncItemId[92] = 'I65A'
        set EncItemId[93] = 'I65S'

        set EncItemId[100] = 'I64G'
        set EncItemId[101] = 'I64Y'
        set EncItemId[102] = 'I65G'
        set EncItemId[103] = 'I65Y'

        set EncItemId[110] = 'I64J'
        set EncItemId[111] = 'I651'
        set EncItemId[112] = 'I65J'
        set EncItemId[113] = 'I661'

        set EncItemId[120] = 'I64D'
        set EncItemId[121] = 'I64V'
        set EncItemId[122] = 'I65D'
        set EncItemId[123] = 'I65V'

        set EncItemId[130] = 'I648'
        set EncItemId[131] = 'I64Q'
        set EncItemId[132] = 'I658'
        set EncItemId[133] = 'I65Q'

        set EncItemId[130] = 'I645'
        set EncItemId[131] = 'I64N'
        set EncItemId[132] = 'I655'
        set EncItemId[133] = 'I65N'

        set EncItemId[140] = 'I64B'
        set EncItemId[141] = 'I64T'
        set EncItemId[142] = 'I65B'
        set EncItemId[143] = 'I65T'

        set EncItemId[150] = 'I64H'
        set EncItemId[151] = 'I64Z'
        set EncItemId[152] = 'I65H'
        set EncItemId[153] = 'I65Z'

        set EncItemId[160] = 'I64K'
        set EncItemId[161] = 'I652'
        set EncItemId[162] = 'I65K'
        set EncItemId[163] = 'I662'

        set EncItemId[170] = 'I64E'
        set EncItemId[171] = 'I64W'
        set EncItemId[172] = 'I65E'
        set EncItemId[173] = 'I65W'

        set maxEncItem = 17
    endfunction
endlibrary

library RecipeSystem initializer Init requires RecipeSystemSettings
    globals
        private Recipe array recipes[1024]
        private integer      recipeCount = 0
    endglobals

    struct Recipe
        integer resultItem      // 合成目标物品类型ID
        integer triggerItem     // 合成按钮物品类型ID（拾取此物品触发检测）
        integer resultItemCharges
        integer goldCost        // 所需金钱
        integer lumberCost      // 所需木头

        trigger onExecute 

        integer array materials[6]   // 素材物品类型ID (0 表示无)
        integer array charges[6]     // 所需充能数量 (0 表示任意充能)

        // 创建新配方
        static method create takes integer result, integer btnItem, integer gold, integer lumber returns Recipe
            local Recipe this = Recipe.allocate()
            local integer i = 0

            set this.resultItem  = result
            set this.triggerItem = btnItem
            set this.goldCost    = gold
            set this.lumberCost  = lumber
            set this.resultItemCharges = 0

            loop
                exitwhen i >= 6
                set this.materials[i] = 0
                set this.charges[i]   = 0
                set i = i + 1
            endloop

            // 注册到全局列表
            set recipes[recipeCount] = this
            set recipeCount = recipeCount + 1

            return this
        endmethod
        static method createEx takes integer result,integer charges, integer btnItem, integer gold, integer lumber returns Recipe
            local Recipe this = Recipe.allocate()
            local integer i = 0

            set this.resultItem  = result
            set this.triggerItem = btnItem
            set this.goldCost    = gold
            set this.lumberCost  = lumber
            set this.resultItemCharges = charges

            loop
                exitwhen i >= 6
                set this.materials[i] = 0
                set this.charges[i]   = 0
                set i = i + 1
            endloop

            // 注册到全局列表
            set recipes[recipeCount] = this
            set recipeCount = recipeCount + 1

            return this
        endmethod

        // 添加素材（物品类型ID + 所需充能数量）
        method addMaterial takes integer itemId, integer requiredCharges returns nothing
            local integer i = 0
            loop
                exitwhen i >= 6
                if this.materials[i] == 0 then
                    set this.materials[i] = itemId
                    set this.charges[i]   = requiredCharges
                    return
                endif
                set i = i + 1
            endloop
        endmethod

        method addOnExecute takes code func returns nothing
            if this.onExecute == null then 
                set this.onExecute = CreateTrigger()
            endif 
            call TriggerAddAction(this.onExecute,func)
        endmethod

        // 检查单位是否满足合成条件
        method check takes unit u, player p returns boolean
            local integer gold   = GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD)
            local integer lumber = GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER)

            local integer matIdx = 0
            local integer slotIdx
            local item    it
            local integer i = 0

            if gold < this.goldCost then
                return false
            endif
            if lumber < this.lumberCost then
                return false
            endif

            loop
                exitwhen matIdx >= 6
                if this.materials[matIdx] == 0 then
                    return true
                endif

                set i = 0
                set slotIdx = 0
                loop
                    exitwhen slotIdx >= 6
                    set it = UnitItemInSlot(u, slotIdx)
                    if it != null and GetItemTypeId(it) == this.materials[matIdx] then
                        if this.charges[matIdx] == 0 or GetItemCharges(it) >= this.charges[matIdx] then
                            exitwhen true
                        else
                            set i = i+GetItemCharges(it)
                            if i >= this.charges[matIdx] then
                                exitwhen true 
                            endif 
                        endif
                    endif
                    set slotIdx = slotIdx + 1
                endloop

                if slotIdx >= 6 then
                    return false
                endif

                set matIdx = matIdx + 1
            endloop

            return true
        endmethod

        // 执行合成
        method execute takes unit u, player p returns nothing
            local integer matIdx = 0
            local integer slotIdx
            local item    it
            local integer remaining
            local integer i = 0
            local integer j = 0

            // 扣除金钱和木头
            call SetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) - this.goldCost)
            call SetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER) - this.lumberCost)

            // 扣除素材
            loop
                exitwhen matIdx >= 6
                if this.materials[matIdx] == 0 then
                    exitwhen true
                endif

                set slotIdx = 0
                set i = this.charges[matIdx]
                loop
                    exitwhen slotIdx >= 6
                    set it = UnitItemInSlot(u, slotIdx)
                    if it != null then 
                        set j = GetItemCharges(it)
                        if GetItemTypeId(it) == this.materials[matIdx] then
                            if i == j then
                                call RemoveItem(it)
                            else
                                set remaining = j - i
                                if remaining <= 0 then
                                    call RemoveItem(it)
                                else
                                    call SetItemCharges(it, remaining)
                                endif
                            endif
                            set i = i-j
                            if i <= 0 then 
                                exitwhen true
                            endif 
                        endif
                    endif 
                    set slotIdx = slotIdx + 1
                endloop

                set matIdx = matIdx + 1
            endloop

            // 给予目标物品
            set nowRecipie = this 
            set nowResultItem = CreateItemEx(this.resultItem,GetUnitX(u),GetUnitY(u))
            if this.resultItemCharges != 0 then 
                call SetItemCharges(nowResultItem,this.resultItemCharges)
            endif 
            set nowRecipieOwner = u
            if this.onExecute != null then 
                call TriggerExecute(this.onExecute)
            endif 
            call UnitAddItem(u, nowResultItem)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl",u,"origin"))
            set nowRecipie = 0
            set nowResultItem = null 
            set nowRecipieOwner = null 
        endmethod
    endstruct

    // 拾取物品事件处理
    private function onPickUp takes nothing returns nothing
        local unit    u = GetTriggerUnit()
        local item    picked = GetManipulatedItem()
        local integer itemId = GetItemTypeId(picked)
        local player  p = GetOwningPlayer(u)
        local integer i = 0
        local Recipe  r

        loop
            exitwhen i >= recipeCount
            set r = recipes[i]
            if r.triggerItem == itemId then
                if r.check(u, p) then
                    call r.execute(u, p)
                else 
                    call DisplayErrorMsg("|cffffcc00所需材料不足。|r")
                endif 
                call RemoveItem(picked)  // 移除合成按钮，防止重复
                exitwhen true 
            endif
            set i = i + 1
        endloop

        set u = null
        set picked = null
        set p = null
    endfunction

    // 示例配方（请在此处添加你的 500+ 配方）
    private function AddRecipes takes nothing returns nothing
        local Recipe r

        set r = Recipe.create('iq0D', 'IQ1M', 0, 0)
        call r.addMaterial('IMF1', 8)
        call r.addMaterial('IML0', 8)

        set r = Recipe.createEx('IMF5',1 , 'ir0X', 0, 0)
        call r.addMaterial('IMF1', 8)
        call r.addMaterial('IM01', 1)

        set r = Recipe.createEx('IE06',1 , 'ir0Y', 0, 0)
        call r.addMaterial('IML1', 1)
        call r.addMaterial('IM01', 1)
        call r.addMaterial('IMH9', 1)

        set r = Recipe.createEx('IE07',1 , 'ir0Z', 0, 0)
        call r.addMaterial('IML1', 1)
        call r.addMaterial('IM01', 1)
        call r.addMaterial('IMH9', 1)

        set r = Recipe.createEx('IE08',1 , 'ir10', 0, 0)
        call r.addMaterial('IML1', 1)
        call r.addMaterial('IM01', 1)
        call r.addMaterial('IMH9', 1)

        set r = Recipe.createEx('IE09',1 , 'ir11', 0, 0)
        call r.addMaterial('IML1', 1)
        call r.addMaterial('IM01', 1)
        call r.addMaterial('IMH9', 1)

        set r = Recipe.create('I61S', 'ir00', 800, 2)
        call r.addMaterial('IMO0', 5)
        call r.addMaterial('IML0', 5)

        set r = Recipe.createEx('IF00',2, 'ir01', 0, 0)
        call r.addMaterial('IMH1', 3)

        set r = Recipe.createEx('IF02',2, 'ir02', 0, 0)
        call r.addMaterial('IMH0', 3)

        set r = Recipe.createEx('IF01',2, 'ir03', 0, 0)
        call r.addMaterial('IMH2', 3)

        set r = Recipe.createEx('IF03',5, 'ir0O', 0, 0)
        call r.addMaterial('IMH6', 3)
        call r.addMaterial('IMHC', 3)

        set r = Recipe.createEx('IF04',2, 'ir0P', 0, 0)
        call r.addMaterial('IMH3', 3)

        set r = Recipe.createEx('IMO5', 1, 'ir04', 100, 0)
        call r.addMaterial('IMO0', 2)
        call r.addMaterial('IMOZ', 1)

        set r = Recipe.create('I698', 'ir05', 800, 2)
        call r.addMaterial('IMO5', 1)
        call r.addMaterial('IML0', 3)
        call r.addMaterial('IMF1', 8)

        set r = Recipe.create('I699', 'ir06', 800, 2)
        call r.addMaterial('IMO5', 1)
        call r.addMaterial('Ic00', 3)
        call r.addOnExecute(function Craft_Ic00_x3)

        set r = Recipe.create('I69A', 'ir07', 800, 2)
        call r.addMaterial('IMO5', 1)
        call r.addMaterial('IMO0', 8)
        call r.addMaterial('IML0', 3)

        set r = Recipe.create('I69B', 'ir08', 500, 1)
        call r.addMaterial('IMO5', 1)
        call r.addMaterial('Ic01', 2)
        call r.addOnExecute(function Craft_Ic01_x2)

        set r = Recipe.create('I69C', 'ir09', 500, 1)
        call r.addMaterial('IMO5', 1)
        call r.addMaterial('Ic03', 2)
        call r.addOnExecute(function Craft_Ic03_x2)

        set r = Recipe.create('I69D', 'ir0A', 500, 1)
        call r.addMaterial('IMO5', 1)
        call r.addMaterial('Ic02', 2)
        call r.addOnExecute(function Craft_Ic02_x2)

        set r = Recipe.create('I69T', 'ir0Q', 700, 1)
        call r.addMaterial('IMO5', 1)
        call r.addMaterial('IMO0', 5)

        set r = Recipe.create('I69U', 'ir0R', 1000, 2)
        call r.addMaterial('IMO5', 2)
        call r.addMaterial('IMO0', 8)
        call r.addMaterial('IML0', 5)

        set r = Recipe.create('I69V', 'ir0S', 1000, 2)
        call r.addMaterial('IMO5', 2)
        call r.addMaterial('IMO0', 3)
        call r.addMaterial('IMF1', 5)

        set r = Recipe.create('I69W', 'ir0T', 1000, 2)
        call r.addMaterial('IMO5', 2)
        call r.addMaterial('IMO0', 3)
        call r.addMaterial('IMF1', 5)

        set r = Recipe.create('I69X', 'ir0U', 1000, 2)
        call r.addMaterial('IMO5', 2)
        call r.addMaterial('IMO0', 8)

        set r = Recipe.create('I69Y', 'ir0V', 1000, 2)
        call r.addMaterial('IMO5', 2)
        call r.addMaterial('IMO0', 5)
        call r.addMaterial('IML0', 5)

        set r = Recipe.create('I69Z', 'ir0W', 1500, 4)
        call r.addMaterial('IMO5', 2)
        call r.addMaterial('IML0', 8)
        call r.addMaterial('IMF1', 8)

        set r = Recipe.create('I69E', 'ir0B', 700, 1)
        call r.addMaterial('IMO5', 1)
        call r.addMaterial('IML0', 10)

        set r = Recipe.createEx('IDZZ', 4, 'ir0C', 50, 0)
        call r.addMaterial('ID00', 2)
        call r.addMaterial('I60H', 2)

        set r = Recipe.create('IML1', 'ir0D', 0, 0)
        call r.addMaterial('IML0', 3)
        call r.addMaterial('IMH2', 1)

        set r = Recipe.create('I69F', 'ir0E', 200, 1)
        call r.addMaterial('IML1', 2)
        call r.addMaterial('IML0', 5)

        set r = Recipe.create('I69H', 'ir0F', 200, 1)
        call r.addMaterial('IML1', 1)
        call r.addMaterial('IML0', 3)

        set r = Recipe.create('I69J', 'ir0G', 200, 1)
        call r.addMaterial('IML1', 1)
        call r.addMaterial('IML0', 3)

        set r = Recipe.create('I69G', 'ir0H', 200, 1)
        call r.addMaterial('IML1', 2)
        call r.addMaterial('IML0', 5)

        set r = Recipe.create('I69I', 'ir0I', 200, 1)
        call r.addMaterial('IML1', 1)
        call r.addMaterial('IML0', 3)

        set r = Recipe.create('I69K', 'ir0J', 200, 1)
        call r.addMaterial('IML1', 1)
        call r.addMaterial('IML0', 3)

        set r = Recipe.create('I69L', 'ir0K', 200, 1)
        call r.addMaterial('IML1', 2)
        call r.addMaterial('IMF1', 5)

        set r = Recipe.create('I69M', 'ir0L', 200, 1)
        call r.addMaterial('IML1', 1)
        call r.addMaterial('IMF1', 3)

        set r = Recipe.create('I69N', 'ir0M', 200, 1)
        call r.addMaterial('IML1', 1)
        call r.addMaterial('IMF1', 3)

        set r = Recipe.create('I69O', 'ir0N', 200, 1)
        call r.addMaterial('IML1', 2)
        call r.addMaterial('IMO0', 5)

        set r = Recipe.create('I643', 'ir60', 300, 0)
        call r.addMaterial('IMF1', 10)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I644', 'ir61', 500, 0)
        call r.addMaterial('IMF1', 15)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I645', 'ir62', 300, 0)
        call r.addMaterial('IMF1', 10)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I646', 'ir63', 300, 0)
        call r.addMaterial('IMF1', 5)
        call r.addMaterial('IML0', 5)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I647', 'ir64', 500, 0)
        call r.addMaterial('IMF1', 8)
        call r.addMaterial('IML0', 8)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I648', 'ir65', 300, 0)
        call r.addMaterial('IMF1', 5)
        call r.addMaterial('IML0', 5)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I649', 'ir66', 300, 0)
        call r.addMaterial('IML0', 10)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I64A', 'ir67', 500, 0)
        call r.addMaterial('IML0', 15)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I64B', 'ir68', 300, 0)
        call r.addMaterial('IML0', 10)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I64C', 'ir69', 300, 0)
        call r.addMaterial('IMO0', 10)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I64D', 'ir6A', 500, 0)
        call r.addMaterial('IMO0', 15)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I64E', 'ir6B', 300, 0)
        call r.addMaterial('IMO0', 10)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I64F', 'ir6C', 300, 0)
        call r.addMaterial('IMO0', 5)
        call r.addMaterial('IML0', 5)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I64G', 'ir6D', 500, 0)
        call r.addMaterial('IMO0', 8)
        call r.addMaterial('IML0', 8)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I64H', 'ir6E', 300, 0)
        call r.addMaterial('IMO0', 5)
        call r.addMaterial('IML0', 5)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I64I', 'ir6F', 300, 0)
        call r.addMaterial('IMO0', 5)
        call r.addMaterial('IMF1', 5)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I64J', 'ir6G', 500, 0)
        call r.addMaterial('IMO0', 8)
        call r.addMaterial('IMF1', 8)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I64K', 'ir6H', 300, 0)
        call r.addMaterial('IMO0', 5)
        call r.addMaterial('IMF1', 5)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I687', 'ir6I', 500, 0)
        call r.addMaterial('IMO0', 8)
        call r.addMaterial('IML0', 8)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I688', 'ir6J', 500, 0)
        call r.addMaterial('IMO0', 8)
        call r.addMaterial('IMF1', 8)
        call r.addOnExecute(function EncItemUpLevel)

        set r = Recipe.create('I689', 'ir6K', 500, 0)
        call r.addMaterial('IMO0', 15)
        call r.addOnExecute(function EncItemUpLevel)
    endfunction

    private function Init takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer i = 0

        call TriggerRegisterPlayerUnitEvent(t, PLAYER, EVENT_PLAYER_UNIT_PICKUP_ITEM, null)

        call TriggerAddAction(t, function onPickUp)

        call AddRecipes()
    endfunction
endlibrary

library EquipmentSfxs requires basic 
    
    //====================================================
    // region ItemSFX
    //====================================================

    function ItemSFX_ArcaneResonance takes nothing returns nothing
        local integer tempAbiCode = 'i000'
        local boolean checker = ItemRecallCheck(spellCaster,tempAbiCode)
        if checker and random.get(spellCaster,0.15,tempAbiCode) then 
            call AddUnitMana(spellCaster,spellCost*0.2)
        endif 
    endfunction
    function ItemSFX_Bash takes nothing returns nothing
        local integer tempAbiCode = 'i001'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if damageSource == damageMaster and damageSource != damageTarget then 
            if checker and random.get(damageSource,0.15,tempAbiCode) then 
                set damageFinalDamage = damageFinalDamage*(1.2)
            endif 
        endif 
    endfunction
    function ItemSFX_RangedAttack takes nothing returns nothing
        local integer tempAbiCode = 'i002'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and DisByUnits(damageSource,damageTarget) > 300 then 
            set damageFinalDamage = damageFinalDamage*(1.1)
        endif 
    endfunction
    function ItemSFX_Barrier takes nothing returns nothing
        local integer tempAbiCode = 'i003'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if checker and random.get(damageTarget,0.15,tempAbiCode) then 
            set damageBlock = damageBlock*(1.2)
        endif 
    endfunction
    function ItemSFX_VigorousVitality takes nothing returns nothing
        local integer tempAbiCode = 'i004'
        local boolean checker = ItemRecallCheck(healTarget,tempAbiCode)
        if checker and GetUnitState(healTarget,UNIT_STATE_LIFE)/GetUnitState(healTarget,UNIT_STATE_MAX_LIFE) < 0.5 then 
            set healFinalHeal = healFinalHeal*(1.08)
        endif 
    endfunction
    function ItemSFX_Wove takes nothing returns nothing
        local integer tempAbiCode = 'i005'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local mybuff bf
        local integer sb
        if damageSource != damageTarget then 
            if checker and random.get(damageTarget,0.1,tempAbiCode) then 
                set bf = mybuff.create(damageTarget,damageTarget,BUFFTYPE_ITEM_WOVE)
                set sb = unitGetAllBonusStateValue(damageTarget,STATE_SHIELD_BONUS)
                set bf.lastTime = 500
                set bf.shieldDestroy = true 
                set bf.shieldBlockPercent = 1
                set bf.shieldMaxValue = GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE)*0.05
                if bf.shieldMaxValue > 0 then 
                    call bf.apply()
                else 
                    call bf.destroy()
                endif 
            endif 
        endif 
    endfunction
    function ItemSFX_Unbreakable takes nothing returns nothing
        local integer tempAbiCode = 'i006'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if checker and GetUnitState(damageTarget,UNIT_STATE_LIFE)/GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE) < 0.5 then 
            set damageBlock = damageBlock*(1.1)
        endif 
    endfunction
    function ItemSFX_ElementTuning takes nothing returns nothing
        local integer tempAbiCode = 'i007'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and ifDamageHasElement() then 
            set damageFinalDamage = damageFinalDamage*(1.02)
        endif 
    endfunction
    function ItemSFX_BlockMissile takes nothing returns nothing
        local integer tempAbiCode = 'i008'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if checker and damageIsMelee == false then 
            set damageBlock = damageBlock*(1.15)
        endif 
    endfunction
    function ItemSFX_Cushioning takes nothing returns nothing
        local integer tempAbiCode = 'i009'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageIsExtra then 
            return 
        endif 
        if checker then 
            set damageDamage = RMaxBJ(damageDamage*(0.95),damageDamage-5)
        endif 
    endfunction
    function ItemSFX_Cushioning2 takes nothing returns nothing
        local integer tempAbiCode = 'i009'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageIsExtra then 
            return 
        endif 
        if checker then 
            set damageDamage = RMaxBJ(damageDamage*(0.95),damageDamage-10)
        endif 
    endfunction
    function ItemSFX_Cushioning3 takes nothing returns nothing
        local integer tempAbiCode = 'i009'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageIsExtra then 
            return 
        endif 
        if checker then 
            set damageDamage = RMaxBJ(damageDamage*(0.95),damageDamage-20)
        endif 
    endfunction
    function ItemSFX_Cushioning4 takes nothing returns nothing
        local integer tempAbiCode = 'i009'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageIsExtra then 
            return 
        endif 
        if checker then 
            set damageDamage = RMaxBJ(damageDamage*(0.95),damageDamage-30)
        endif 
    endfunction
    function ItemSFX_Cushioning5 takes nothing returns nothing
        local integer tempAbiCode = 'i009'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageIsExtra then 
            return 
        endif 
        if checker then 
            set damageDamage = RMaxBJ(damageDamage*(0.95),damageDamage-50)
        endif 
    endfunction
    function ItemSFX_MythStep takes nothing returns nothing
        local integer tempAbiCode = 'i00A'
        local boolean checker = ItemRecallCheck(spellCaster,tempAbiCode)
        local mybuff bf
        if checker and random.get(spellCaster,0.15,tempAbiCode) then 
            set bf = mybuff.create(spellCaster,spellCaster,BUFFTYPE_ITEM_MYTHSTEP)
            set bf.bonusMoveSpeed_P = 1000
            set bf.lastTime = 500
            call bf.apply()
        endif 
    endfunction
    function ItemSFX_Firm takes nothing returns nothing
        local integer tempAbiCode = 'i00B'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageIsExtra then 
            return 
        endif 
        if unitCheckCooldown(damageTarget,tempAbiCode) and checker and GetHeroAgi(damageTarget,true) >= 25 and random.get(damageTarget,0.2,tempAbiCode) then 
            if mybuff.countUnitNegBuffDispelAble(damageTarget) > 0 then 
                call bufflist.listUnitBuffs(damageTarget,false,true,true)
                call bufflist.dispelMultiBuffs(1)
                call unitStartCooldown(damageTarget,tempAbiCode,1000)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl",damageTarget,"origin"))
            endif 
        endif 
    endfunction
    function ItemSFX_Firm2 takes nothing returns nothing
        local integer tempAbiCode = 'i00B'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageIsExtra then 
            return 
        endif 
        if unitCheckCooldown(damageTarget,tempAbiCode) and checker and GetHeroAgi(damageTarget,true) >= 50 and random.get(damageTarget,0.2,tempAbiCode) then 
            if mybuff.countUnitNegBuffDispelAble(damageTarget) > 0 then 
                call bufflist.listUnitBuffs(damageTarget,false,true,true)
                call bufflist.dispelMultiBuffs(1)
                call unitStartCooldown(damageTarget,tempAbiCode,800)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl",damageTarget,"origin"))
            endif 
        endif 
    endfunction
    function ItemSFX_Firm3 takes nothing returns nothing
        local integer tempAbiCode = 'i00B'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageIsExtra then 
            return 
        endif 
        if unitCheckCooldown(damageTarget,tempAbiCode) and checker and GetHeroAgi(damageTarget,true) >= 100 and random.get(damageTarget,0.33,tempAbiCode) then 
            if mybuff.countUnitNegBuffDispelAble(damageTarget) > 0 then 
                call bufflist.listUnitBuffs(damageTarget,false,true,true)
                call bufflist.dispelMultiBuffs(1)
                call unitStartCooldown(damageTarget,tempAbiCode,800)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl",damageTarget,"origin"))
            endif 
        endif 
    endfunction
    function ItemSFX_Firm4 takes nothing returns nothing
        local integer tempAbiCode = 'i00B'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageIsExtra then 
            return 
        endif 
        if unitCheckCooldown(damageTarget,tempAbiCode) and checker and GetHeroAgi(damageTarget,true) >= 200 and random.get(damageTarget,0.5,tempAbiCode) then 
            if mybuff.countUnitNegBuffDispelAble(damageTarget) > 0 then 
                call bufflist.listUnitBuffs(damageTarget,false,true,true)
                call bufflist.dispelMultiBuffs(1)
                call unitStartCooldown(damageTarget,tempAbiCode,800)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl",damageTarget,"origin"))
            endif 
        endif 
    endfunction
    function ItemSFX_Firm5 takes nothing returns nothing
        local integer tempAbiCode = 'i00B'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageIsExtra then 
            return 
        endif 
        if unitCheckCooldown(damageTarget,tempAbiCode) and checker and GetHeroAgi(damageTarget,true) >= 300 then 
            if mybuff.countUnitNegBuffDispelAble(damageTarget) > 0 then 
                call bufflist.listUnitBuffs(damageTarget,false,true,true)
                call bufflist.dispelMultiBuffs(1)
                call unitStartCooldown(damageTarget,tempAbiCode,1000)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl",damageTarget,"origin"))
            endif 
        endif 
    endfunction
    function SWORD_DANCE_DELAYED_DAMAGE takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        set damageTag_Attack = true 
        set damageFlag = 'i00C'
        set damageIsMelee = true 
        call UnitDamageTarget(de.loadUnit("SOURCE"),de.loadUnit("TARGET"),I2R(GetUnitAttack(de.loadUnit("SOURCE"),0)),true,false,ATTACK_TYPE_MELEE,DAMAGE_TYPE_NORMAL,ConvertWeaponType(de.loadInteger("WEAPON_TYPE")))
    endfunction
    function ItemSFX_SwordDance takes nothing returns nothing
        local integer tempAbiCode = 'i00C'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local delayedevent de
        if damageSource == damageTarget then 
            return 
        endif 
        if unitCheckCooldown(damageSource,tempAbiCode) and checker and random.get(damageSource,0.05,tempAbiCode)  then 
            set de = delayedevent.create(10,1,function SWORD_DANCE_DELAYED_DAMAGE)
            call de.saveUnit("SOURCE",damageSource)
            call de.saveUnit("TARGET",damageTarget)
            call de.saveInteger("WEAPON_TYPE",WeaponType2I(damageWeaponType))
            call unitStartCooldown(damageSource,tempAbiCode,100)
        endif 
    endfunction
    function ItemSFX_LionHeart takes nothing returns nothing
        local integer tempAbiCode = 'i00D'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local mybuff bf 
        if damageIsExtra then 
            return 
        endif 
        if checker and GetUnitState(damageTarget,UNIT_STATE_LIFE)/GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE) < 0.5 then 
            set bf = mybuff.create(damageTarget,damageTarget,BUFFTYPE_ITEM_LIONHEART)
            set bf.bonusArmor_P = 1000
            set bf.lastTime = 300
            call bf.apply()
        endif 
    endfunction
    function ItemSFX_BackStab takes nothing returns nothing
        local integer tempAbiCode = 'i00E'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and isBackStab(damageSource,damageTarget,60) then 
            set damageFinalDamage = damageFinalDamage*(1.1)
        endif 
    endfunction
    function ItemSFX_Parry takes nothing returns nothing
        local integer tempAbiCode = 'i00F'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageTarget,0.05,tempAbiCode) and damageFinalDamage > 0 and Cos((AngleByUnits(damageSource,damageTarget)-GetUnitFacing(damageTarget))/57.2956) > -0.5 and damageTag_Attack then 
            set damageFinalDamage = 0
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl",damageTarget,"origin"))
        endif 
    endfunction
    function CLEAVE_DELAYED_DAMAGE takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local group pick = CreateGroup()
        local unit ds = de.loadUnit("SOURCE")
        local unit dt = de.loadUnit("TARGET")
        local real dmg = de.loadReal("DAMAGE")
        local integer weaponType = de.loadInteger("WEAPON_TYPE")
        call GroupEnumUnitsInRange(pick,GetUnitX(dt),GetUnitY(dt),150,playerEnemy)
        loop 
            exitwhen FirstOfGroup(pick) == null 
            if FirstOfGroup(pick) != dt then 
                set damageFlag = 'i00G'
                set damageIsExtra = true 
                call UnitDamageTarget(ds,dt,dmg,true,false,ATTACK_TYPE_MELEE,DAMAGE_TYPE_NORMAL,ConvertWeaponType(weaponType))
            endif 
            call GroupRemoveUnit(pick,FirstOfGroup(pick))
        endloop
        call DestroyGroup(pick)
        set ds = null 
        set dt = null 
        set pick = null 
    endfunction
    function ItemSFX_Cleave takes nothing returns nothing
        local integer tempAbiCode = 'i00G'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local delayedevent de
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageSource,0.33,tempAbiCode) then 
            set de = delayedevent.create(1,1,function CLEAVE_DELAYED_DAMAGE)
            call de.saveUnit("SOURCE",damageSource)
            call de.saveUnit("TARGET",damageTarget)
            call de.saveReal("DAMAGE",0.3*I2R(GetUnitAttack(damageSource,0)))
            call de.saveInteger("WEAPON_TYPE",WeaponType2I(damageWeaponType))
        endif 
    endfunction
    function LACERATION_DOT takes nothing returns nothing
        local real dmg = mybuff.currentBuff.realData*I2R(GetUnitMaxAttack(mybuff.currentBuff.buffSource,0))*mybuff.buffTimeScale
        set damageTag_Bleed = true 
        set damageIsDOT = true 
        set damageFlag = 'i00H'
        call UnitDamageTarget(mybuff.currentBuff.buffSource,mybuff.currentBuff.buffTarget,dmg,false,true,ATTACK_TYPE_MELEE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
    endfunction
    function ItemSFX_Laceration takes nothing returns nothing
        local integer tempAbiCode = 'i00H'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local mybuff bf 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageSource,0.2,tempAbiCode) then 
            set bf = mybuff.create(damageSource,damageTarget,BUFFTYPE_ITEM_LACERATION)
            set bf.lastTime = 400
            set bf.periodTime = 200
            set bf.hasteAble = true 
            call bf.addPeriod(function LACERATION_DOT)
            set bf.realData = 0.15*0.5
            call bf.apply()
        endif 
    endfunction
    function TOXINBLADE_DOT takes nothing returns nothing
        local real dmg = mybuff.currentBuff.realData*I2R(GetUnitMaxAttack(mybuff.currentBuff.buffSource,0))*mybuff.buffTimeScale
        set damageTag_Posion = true
        set damageTag_Earth = true  
        set damageIsDOT = true 
        set damageFlag = 'i00I'
        call UnitDamageTarget(mybuff.currentBuff.buffSource,mybuff.currentBuff.buffTarget,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
    endfunction
    function ItemSFX_ToxinBlade takes nothing returns nothing
        local integer tempAbiCode = 'i00I'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local mybuff bf 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageSource,0.2,tempAbiCode) then 
            set bf = mybuff.create(damageSource,damageTarget,BUFFTYPE_ITEM_TOXINBLADE)
            set bf.lastTime = 600
            set bf.periodTime = 200
            set bf.hasteAble = true 
            call bf.addPeriod(function TOXINBLADE_DOT)
            set bf.realData = 0.2/3
            call bf.apply()
        endif 
    endfunction
    function SORROW_DELAYED_DAMAGE takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real dmg = de.loadReal("DAMAGE")
        set damageFlag = 'i00J'
        call UnitDamageTarget(de.loadUnit("SOURCE"),de.loadUnit("TARGET"),dmg,true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl",de.loadUnit("TARGET"),"overhead"))
    endfunction
    function ItemSFX_Sorrow takes nothing returns nothing
        local integer tempAbiCode = 'i00J'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local delayedevent de
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageSource,0.2,tempAbiCode) then 
            set de = delayedevent.create(10,1,function SORROW_DELAYED_DAMAGE)
            call de.saveUnit("SOURCE",damageSource)
            call de.saveUnit("TARGET",damageTarget)
            call de.saveReal("DAMAGE",GetRandomReal(1,1.2)*0.15*GetUnitMaxAttack(damageSource,0))
        endif 
    endfunction
    function ItemSFX_PerfectVanguard takes nothing returns nothing
        local integer tempAbiCode = 'i00K'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageFinalDamage > 0 and random.get(damageTarget,0.05,tempAbiCode) and GetUnitState(damageTarget,UNIT_STATE_LIFE)/GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE) > 0.8 and damageTag_Attack then 
            set damageFinalDamage = 0
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl",damageTarget,"origin"))
        endif 
    endfunction
    function ItemSFX_MagicCircuit takes nothing returns nothing
        local integer tempAbiCode = 'i00L'
        local boolean checker = ItemRecallCheck(spellCaster,tempAbiCode)
        if checker and random.get(spellCaster,0.1,tempAbiCode) and spellCost > 0 then 
            call AddUnitMana(spellCaster,0.01*GetUnitState(spellCaster,UNIT_STATE_MAX_MANA))
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\ReplenishMana\\SpiritTouchTarget.mdl",spellCaster,"origin"))
        endif 
    endfunction
    function ItemSFX_Shatter takes nothing returns nothing
        local integer tempAbiCode = 'i00M'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            set damageArmor = damageArmor*(0.8)
            set damageResistance = damageResistance*(0.8)
        endif 
    endfunction
    function ItemSFX_DeflictMissile takes nothing returns nothing
        local integer tempAbiCode = 'i00N'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageFinalDamage > 0 and random.get(damageTarget,0.05,tempAbiCode) and damageTag_Attack and damageIsMelee == false then 
            set damageFinalDamage = 0
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl",damageTarget,"origin"))
        endif 
    endfunction
    function ItemSFX_Execution takes nothing returns nothing
        local integer tempAbiCode = 'i00O'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and GetUnitState(damageTarget,UNIT_STATE_LIFE)/GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE) < 0.3 then 
            set damageFinalDamage = damageFinalDamage*(1.1)
        endif 
    endfunction
    function ItemSFX_GiantSlayer takes nothing returns nothing
        local integer tempAbiCode = 'i00P'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and GetUnitState(damageTarget,UNIT_STATE_LIFE)/GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE) > 0.7 then 
            set damageFinalDamage = damageFinalDamage*(1.1)
        endif 
    endfunction
    function ItemSFX_CritEnhancement takes nothing returns nothing
        local integer tempAbiCode = 'i00Q'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageIfCrit then 
            set damageFinalDamage = damageFinalDamage*(1.06)
        endif 
    endfunction
    function ItemSFX_ElementalEmpowerment takes nothing returns nothing
        local integer tempAbiCode = 'i00Q'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and ifDamageHasElement() == false then 
            set damageFinalDamage = damageFinalDamage*(1.02)
            call enableRandomElement()
        endif 
    endfunction
    function FIRE_SLAM_DELAYED_DAMAGE takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real dmg = de.loadReal("DAMAGE")
        set damageTag_Fire = true 
        set damageFlag = 'i00R'
        call UnitDamageTarget(de.loadUnit("SOURCE"),de.loadUnit("TARGET"),dmg,true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl",de.loadUnit("TARGET"),"origin"))
    endfunction
    function ItemSFX_FireSlam takes nothing returns nothing
        local integer tempAbiCode = 'i00R'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local delayedevent de
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageSource,0.15,tempAbiCode) then 
            set de = delayedevent.create(10,1,function FIRE_SLAM_DELAYED_DAMAGE)
            call de.saveUnit("SOURCE",damageSource)
            call de.saveUnit("TARGET",damageTarget)
            call de.saveReal("DAMAGE",GetRandomReal(1,1.2)*0.25*GetUnitMaxAttack(damageSource,0))
        endif 
    endfunction
    function ItemSFX_SunderStrike takes nothing returns nothing
        local integer tempAbiCode = 'i00S'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local mybuff bf 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageSource,0.15,tempAbiCode) then 
            set bf = mybuff.create(damageSource,damageTarget,BUFFTYPE_ITEM_SUNDERSTRIKE)
            set bf.bonusArmor_P = -1000
            set bf.lastTime = 1000
            call bf.apply()
        endif 
    endfunction
    function ItemSFX_ArcaneDefense takes nothing returns nothing
        local integer tempAbiCode = 'i00T'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local mybuff bf 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageTarget,0.2,tempAbiCode) and damageAttackType == ATTACK_TYPE_NORMAL then 
            set bf = mybuff.create(damageTarget,damageTarget,BUFFTYPE_ITEM_ARCANEDEFENSE)
            set bf.bonusResistance = 1500
            set bf.lastTime = 1000
            call bf.apply()
        endif 
    endfunction
    function ItemSFX_Combo takes nothing returns nothing
        local integer tempAbiCode = 'i00U'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local mybuff bf 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if mybuff.getUnitBuff(damageSource,BUFFTYPE_ITEM_COMBO) > 0 and mybuff.getUnitBuff(damageSource,BUFFTYPE_ITEM_COMBO).buffSource != damageTarget then 
                set mybuff.getUnitBuff(damageSource,BUFFTYPE_ITEM_COMBO).intData = 0
            endif 
            set bf = mybuff.create(damageTarget,damageSource,BUFFTYPE_ITEM_COMBO)
            set bf.intData = IMinBJ(10,bf.intData+1)
            set bf.bonusAttack_P = 50*bf.intData
            set bf.lastTime = 500
            call bf.apply()
        endif 
    endfunction
    function ItemSFX_Frenzy takes nothing returns nothing
        local integer tempAbiCode = 'i00V'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local mybuff bf 
        if damageSource == damageTarget then 
            return 
        endif 
        if unitCheckCooldown(damageSource,tempAbiCode) and checker and random.get(damageSource,0.15,tempAbiCode) then 
            set bf = mybuff.create(damageSource,damageSource,BUFFTYPE_ITEM_FRENZY)
            set bf.bonusAttackSpeed = 2000
            set bf.lastTime = 1000
            call bf.apply()
            call unitStartCooldown(damageSource,tempAbiCode,2000)
        endif 
    endfunction
    function ItemSFX_Concerto_Source takes nothing returns nothing
        local integer tempAbiCode = 'i00W'
        local boolean checker = ItemRecallCheck(healSource,tempAbiCode)
        local mybuff bf 
        local integer sb 
        if checker and random.get(healSource,0.1,tempAbiCode) then 
            set sb = unitGetAllBonusStateValue(healSource,STATE_SHIELD_BONUS)
            set bf = mybuff.create(healSource,healTarget,BUFFTYPE_ITEM_CONCERTO)
            set bf.shieldBlockPercent = 1
            set bf.shieldDestroy = true 
            set bf.shieldMaxValue = RMaxBJ(bf.shieldMaxValue,0.15*healFinalHeal*I2R(10000+sb)/10000)
            set bf.lastTime = 1000
            call bf.apply()
        endif 
    endfunction
    function ItemSFX_Concerto_Target takes nothing returns nothing
        local integer tempAbiCode = 'i00X'
        local boolean checker = ItemRecallCheck(healTarget,tempAbiCode)
        local mybuff bf 
        local integer sb 
        if checker and random.get(healTarget,0.1,tempAbiCode) then 
            set sb = unitGetAllBonusStateValue(healTarget,STATE_SHIELD_BONUS)
            set bf = mybuff.create(healTarget,healTarget,BUFFTYPE_ITEM_CONCERTO)
            set bf.shieldBlockPercent = 1
            set bf.shieldDestroy = true 
            set bf.shieldMaxValue = RMaxBJ(bf.shieldMaxValue,0.15*healFinalHeal*I2R(10000+sb)/10000)
            set bf.lastTime = 1000
            call bf.apply()
        endif 
    endfunction
    function CORRUPTION_DOT takes nothing returns nothing
        local real dmg = mybuff.currentBuff.realData*I2R(unitGetAllBonusStateValue(mybuff.currentBuff.buffSource,STATE_ABILITY_POWER))*mybuff.buffTimeScale
        set damageTag_Shadow = true  
        set damageIsDOT = true 
        set damageFlag = 'A635'
        call UnitDamageTarget(mybuff.currentBuff.buffSource,mybuff.currentBuff.buffTarget,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
    endfunction
    function ItemSFX_Corruption takes nothing returns nothing
        local integer tempAbiCode = 'i00Y'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local mybuff bf 
        if checker and random.get(damageSource,0.15,tempAbiCode) then 
            set bf = mybuff.create(damageSource,damageTarget,BUFFTYPE_ITEM_CORRUPTION)
            set bf.lastTime = 1200
            set bf.periodTime = 200
            set bf.hasteAble = true 
            call bf.addPeriod(function CORRUPTION_DOT)
            set bf.realData = 0.72/6
            call bf.apply()
        endif 
    endfunction
    function ItemSFX_EnhanceFire takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Fire then 
            set damageFinalDamage = damageFinalDamage*(1.03)
        endif 
    endfunction
    function ItemSFX_EnhanceFire2 takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Fire then 
            set damageFinalDamage = damageFinalDamage*(1.05)
        endif 
    endfunction
    function ItemSFX_EnhanceCold takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Cold then 
            set damageFinalDamage = damageFinalDamage*(1.03)
        endif 
    endfunction
    function ItemSFX_EnhanceCold2 takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Cold then 
            set damageFinalDamage = damageFinalDamage*(1.05)
        endif 
    endfunction
    function ItemSFX_EnhanceLightning takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Lightning then 
            set damageFinalDamage = damageFinalDamage*(1.03)
        endif 
    endfunction
    function ItemSFX_EnhanceLightning2 takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Lightning then 
            set damageFinalDamage = damageFinalDamage*(1.05)
        endif 
    endfunction
    function ItemSFX_EnhanceShadow takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Shadow then 
            set damageFinalDamage = damageFinalDamage*(1.03)
        endif 
    endfunction
    function ItemSFX_EnhanceShadow2 takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Shadow then 
            set damageFinalDamage = damageFinalDamage*(1.05)
        endif 
    endfunction
    function ItemSFX_EnhanceArcane takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Arcane then 
            set damageFinalDamage = damageFinalDamage*(1.03)
        endif 
    endfunction
    function ItemSFX_EnhanceArcane2 takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Arcane then 
            set damageFinalDamage = damageFinalDamage*(1.05)
        endif 
    endfunction
    function ItemSFX_EnhanceDivine takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Divine then 
            set damageFinalDamage = damageFinalDamage*(1.03)
        endif 
    endfunction
    function ItemSFX_EnhanceDivine2 takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Divine then 
            set damageFinalDamage = damageFinalDamage*(1.05)
        endif 
    endfunction
    function ItemSFX_EnhanceEarth takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Earth then 
            set damageFinalDamage = damageFinalDamage*(1.03)
        endif 
    endfunction
    function ItemSFX_EnhanceEarth2 takes nothing returns nothing
        local integer tempAbiCode = 'i00Z'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Earth then 
            set damageFinalDamage = damageFinalDamage*(1.05)
        endif 
    endfunction
    function ItemSFX_Entrenching takes nothing returns nothing
        local integer tempAbiCode = 'i010'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local mybuff bf 
        if checker and random.get(damageTarget,0.2,tempAbiCode) and damageIsMelee then 
            set bf = mybuff.create(damageTarget,damageSource,BUFFTYPE_ITEM_ENTRENCHING)
            set bf.bonusMoveSpeed_P = -1500
            set bf.bonusAttackSpeed = -1500
            set bf.lastTime = 500
            call bf.apply()
        endif 
    endfunction
    function ItemSFX_Crush takes nothing returns nothing
        local integer tempAbiCode = 'i011'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if damageTag_Attack == false then 
            return 
        endif 
        if checker and random.get(damageSource,0.25,tempAbiCode) then 
            set damageArmor = damageArmor*(0.5)
        endif 
    endfunction
    function ITEM_ENDURANCE_AURA_SET takes nothing returns nothing
        set aura.modifingAuraBuff.bonusMoveSpeed_P = 500
    endfunction
    function ItemSFX_EnduranceAura_On takes nothing returns nothing
        local aura ar = CreateAura(eventEquipment.bindUnit,"ITEM_ENDURANCE_AURA",900,0,BUFFTYPE_ITEM_ENDURANCEAURA,"Abilities\\Spells\\Orc\\CommandAura\\CommandAura.mdl")
        set eventEquipment.intData = ar 
        call ar.addAllySet(function ITEM_ENDURANCE_AURA_SET)
        set ar.removeWhenDeath = false 
    endfunction
    function ItemSFX_EnduranceAura_Off takes nothing returns nothing
        local aura ar = eventEquipment.intData
        if ar > 0 then 
            call ar.destroy()
        endif 
        set eventEquipment.intData = 0
    endfunction
    function ITEM_BRILLIANCE_AURA_PERIOD takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        call AddUnitMana(bf.buffTarget,0.01*GetUnitState(bf.buffTarget,UNIT_STATE_MAX_MANA))
    endfunction
    function ITEM_BRILLIANCE_AURA_SET takes nothing returns nothing
        set aura.modifingAuraBuff.periodTime = 500
        call aura.modifingAuraBuff.addPeriod(function ITEM_BRILLIANCE_AURA_PERIOD)
    endfunction
    function ItemSFX_BrillianceAura_On takes nothing returns nothing
        local aura ar = CreateAura(eventEquipment.bindUnit,"ITEM_BRILLIANCE_AURA",900,0,BUFFTYPE_ITEM_BRILLIANCEAURA,"Abilities\\Spells\\Human\\Brilliance\\Brilliance.mdl")
        set eventEquipment.intData = ar 
        call ar.addAllySet(function ITEM_BRILLIANCE_AURA_SET)
        set ar.removeWhenDeath = false 
    endfunction
    function ItemSFX_BrillianceAura_Off takes nothing returns nothing
        local aura ar = eventEquipment.intData
        if ar > 0 then 
            call ar.destroy()
        endif 
        set eventEquipment.intData = 0
    endfunction
    function A64T_PERIOD takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        local real restore = 0.004*I2R(bf.intData)*GetUnitState(bf.buffSource,UNIT_STATE_MAX_MANA)*mybuff.buffTimeScale
        call AddUnitMana(bf.buffSource,restore)
    endfunction
    function ItemSFX_Warm takes nothing returns nothing
        local integer tempAbiCode = 'i012'
        local boolean checker = ItemRecallCheck(spellCaster,tempAbiCode)
        local mybuff bf 
        if spellCost <= 0 then 
            return 
        endif 
        if checker then 
            if mybuff.getUnitBuff(spellCaster,BUFFTYPE_ITEM_WARM) > 0 then 
                if mybuff.getUnitBuff(spellCaster,BUFFTYPE_ITEM_WARM).intData >= 3 then 
                    return 
                endif 
            endif 
            set bf = CreateBuff(spellCaster,spellCaster,BUFFTYPE_ITEM_WARM,1000)
            set bf.periodTime = 500
            set bf.intData = IMinBJ(3,bf.intData+1)
            call bf.addPeriod(function A64T_PERIOD)
            call bf.apply()
        endif 
    endfunction
    function ItemSFX_MagicPenetration takes nothing returns nothing
        local integer tempAbiCode = 'i013'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            set damageResistance = damageResistance*0.75
        endif 
    endfunction
    function ItemSFX_EnhanceHeal takes nothing returns nothing
        local integer tempAbiCode = 'i013'
        local boolean checker = ItemRecallCheck(healSource,tempAbiCode)
        if checker then 
            set healFinalHeal = healFinalHeal*1.03
        endif 
    endfunction
    function ItemSFX_EnhanceHeal2 takes nothing returns nothing
        local integer tempAbiCode = 'i013'
        local boolean checker = ItemRecallCheck(healSource,tempAbiCode)
        if checker then 
            set healFinalHeal = healFinalHeal*1.05
        endif 
    endfunction
    function ItemSFX_InnerFire takes nothing returns nothing
        local integer tempAbiCode = 'i014'
        local boolean checker = ItemRecallCheck(healSource,tempAbiCode)
        local mybuff bf 
        if unitCheckCooldown(healSource,tempAbiCode) and checker and random.get(healSource,0.15,tempAbiCode) then 
            set bf = CreateBuff(healSource,healTarget,BUFFTYPE_ITEM_INNERFIRE,1000)
            set bf.bonusArmor_P = 1000
            call bf.apply()
            call unitStartCooldown(healSource,tempAbiCode,500)
        endif 
    endfunction
    function ItemSFX_Protect takes nothing returns nothing
        local integer tempAbiCode = 'i015'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageIsCrush then 
            set damageFinalDamage = damageFinalDamage*0.9
        endif 
    endfunction
    function ItemSFX_FrostAttack takes nothing returns nothing
        local integer tempAbiCode = 'i016'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageSource,0.2,tempAbiCode) then 
            call applyCold(damageSource,damageTarget,'ACO0')
        endif 
    endfunction
    function ItemSFX_EnhanceMinion takes nothing returns nothing
        local integer tempAbiCode = 'i017'
        local boolean checker = ItemRecallCheck(damageMaster,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageMaster != damageSource then 
            set damageFinalDamage = damageFinalDamage*1.03
        endif 
    endfunction
    function ItemSFX_EnhanceMinion2 takes nothing returns nothing
        local integer tempAbiCode = 'i017'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageMaster != damageSource then 
            set damageFinalDamage = damageFinalDamage*1.05
        endif 
    endfunction
    function ItemSFX_ChargeAttack takes nothing returns nothing
        local integer tempAbiCode = 'i018'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageSource,0.15,tempAbiCode) then 
            call AddUnitMana(damageSource,0.01*GetUnitState(damageSource,UNIT_STATE_MAX_MANA))
        endif 
    endfunction
    function ItemSFX_EmergencyGuardiance takes nothing returns nothing
        local integer tempAbiCode = 'i019'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and GetUnitState(damageTarget,UNIT_STATE_LIFE)/GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE)-0.3 < 0 then 
            set damageFinalDamage = damageFinalDamage*0.95
        endif 
    endfunction
    function ItemSFX_AncientProtection takes nothing returns nothing
        local integer tempAbiCode = 'i01A'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if checker and random.get(damageTarget,0.03,tempAbiCode) then 
            set damageFinalDamage = 1
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl",damageTarget,"origin"))
        endif 
    endfunction
    function ItemSFX_LifeTap takes nothing returns nothing
        local integer tempAbiCode = 'i01B'
        local boolean checker = ItemRecallCheck(spellCaster,tempAbiCode)
        local real a 
        if spellCost <= 0 then 
            return 
        endif 
        if unitCheckCooldown(spellCaster,tempAbiCode) and checker and GetUnitState(spellCaster,UNIT_STATE_MANA)/GetUnitState(spellCaster,UNIT_STATE_MAX_MANA)-0.5 < 0 then 
            set a = RMinBJ(GetUnitState(spellCaster,UNIT_STATE_LIFE)-1,GetUnitState(spellCaster,UNIT_STATE_MAX_LIFE)*0.15)
            call AddUnitLife(spellCaster,0-a)
            set a = a/GetUnitState(spellCaster,UNIT_STATE_MAX_LIFE)
            call AddUnitMana(spellCaster,a*GetUnitState(spellCaster,UNIT_STATE_MAX_MANA))
            call unitStartCooldown(spellCaster,tempAbiCode,6000)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",spellCaster,"origin"))
        endif 
    endfunction
    function ItemSFX_DefendFire takes nothing returns nothing
        local integer tempAbiCode = 'i01C'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Fire then 
            set damageFinalDamage = damageFinalDamage*0.97
        endif 
    endfunction
    function ItemSFX_DefendCold takes nothing returns nothing
        local integer tempAbiCode = 'i01D'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Cold then 
            set damageFinalDamage = damageFinalDamage*0.97
        endif 
    endfunction
    function ItemSFX_DefendLightning takes nothing returns nothing
        local integer tempAbiCode = 'i01E'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Lightning then 
            set damageFinalDamage = damageFinalDamage*0.97
        endif 
    endfunction
    function ItemSFX_DefendShadow takes nothing returns nothing
        local integer tempAbiCode = 'i01F'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Shadow then 
            set damageFinalDamage = damageFinalDamage*0.97
        endif 
    endfunction
    function ItemSFX_DefendArcane takes nothing returns nothing
        local integer tempAbiCode = 'i01G'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Arcane then 
            set damageFinalDamage = damageFinalDamage*0.97
        endif 
    endfunction
    function ItemSFX_DefendToxin takes nothing returns nothing
        local integer tempAbiCode = 'i01H'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Posion then 
            set damageFinalDamage = damageFinalDamage*0.95
        endif 
    endfunction
    function ItemSFX_DefendBleed takes nothing returns nothing
        local integer tempAbiCode = 'i01I'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Bleed then 
            set damageFinalDamage = damageFinalDamage*0.95
        endif 
    endfunction
    function ItemSFX_DefendIgnite takes nothing returns nothing
        local integer tempAbiCode = 'i01J'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Ignite then 
            set damageFinalDamage = damageFinalDamage*0.95
        endif 
    endfunction
    function ItemSFX_AOEEvade takes nothing returns nothing
        local integer tempAbiCode = 'i01K'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if checker and damageIsAOE and random.get(damageTarget,damageEvade,tempAbiCode) then 
            set damageFinalDamage = damageFinalDamage*0.7
        endif 
    endfunction
    function ItemSFX_LuckyProtect takes nothing returns nothing
        local integer tempAbiCode = 'i01L'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        if unitCheckCooldown(damageTarget,tempAbiCode) and checker and random.get(damageTarget,0.5,tempAbiCode) and damageFinalDamage > GetUnitState(damageTarget,UNIT_STATE_LIFE) then 
            set damageFinalDamage = 1
            call unitStartCooldown(damageTarget,tempAbiCode,12000)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl",damageTarget,"origin"))
        endif 
    endfunction
    
    function ITEM_WINDWALK_AURA_SET takes nothing returns nothing
        set aura.modifingAuraBuff.bonusEvade = 500
    endfunction
    function ItemSFX_WindWalkAura_On takes nothing returns nothing
        local aura ar = CreateAura(eventEquipment.bindUnit,"ITEM_WINDWALK_AURA",900,0,BUFFTYPE_ITEM_WINDWALKAURA,"Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl")
        set eventEquipment.intData = ar 
        call ar.addAllySet(function ITEM_WINDWALK_AURA_SET)
        set ar.removeWhenDeath = false 
    endfunction
    function ItemSFX_WindWalkAura_Off takes nothing returns nothing
        local aura ar = eventEquipment.intData
        if ar > 0 then 
            call ar.destroy()
        endif 
        set eventEquipment.intData = 0
    endfunction

    function ItemSFX_Torrent takes nothing returns nothing
        local integer tempAbiCode = 'i01M'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local real param 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            set param = RMinBJ(0.06,GetUnitState(damageSource,UNIT_STATE_MANA)/I2R(IMaxBJ(1,UnitLevel(damageSource)))*0.003)
            set damageFinalDamage = damageFinalDamage*(1+param)
        endif 
    endfunction

    function ItemSFX_ManaSiphon takes nothing returns nothing
        local integer tempAbiCode = 'i01N'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local real param 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageSource,0.3,tempAbiCode) then 
            call AddUnitMana(damageSource,1)
        endif 
    endfunction

    function ItemSFX_Nourish takes nothing returns nothing
        local integer tempAbiCode = 'i01O'
        local boolean checker = ItemRecallCheck(spellCaster,tempAbiCode)
        local real param 
        if spellCost == 0 then 
            return 
        endif 
        if unitCheckCooldown(spellCaster,tempAbiCode) and checker and random.get(spellCaster,0.3,tempAbiCode) then 
            call AddUnitMana(spellCaster,2*spellCost)
            call delayedDestroyEffect(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\ReplenishMana\\ReplenishManaCaster.mdl",spellCaster,"chest"),130)
            call unitStartCooldown(spellCaster,tempAbiCode,3000)
        endif 
    endfunction

    function ItemSFX_Defiance takes nothing returns nothing
        local integer tempAbiCode = 'i01P'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local real param 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and GetUnitTaunter(damageSource) == damageTarget then 
            set damageFinalDamage = damageFinalDamage*0.95
        endif 
    endfunction

    function ItemSFX_Reckless takes nothing returns nothing
        local integer tempAbiCode = 'i01Q'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local real param 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and GetUnitManaPercent(damageSource) < 50 then 
            set damageFinalDamage = damageFinalDamage*1.07
        endif 
    endfunction

    function ItemSFX_Cleanse takes nothing returns nothing
        local integer tempAbiCode = 'i01R'
        local boolean checker = ItemRecallCheck(spellCaster,tempAbiCode)
        local real param 
        if spellCost == 0 then 
            return 
        endif 
        if unitCheckCooldown(spellCaster,tempAbiCode) and checker then 
            call bufflist.listUnitBuffs(spellCaster,false,true,true)
            if bufflist.dispelMultiBuffs(1) then 
                call unitStartCooldown(spellCaster,tempAbiCode,1000)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl",spellCaster,"origin"))
            endif 
        endif 
    endfunction

    function ItemSFX_WildPower takes nothing returns nothing
        local integer tempAbiCode = 'i01S'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local real param 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Attack and random.get(damageSource,0.3,tempAbiCode) then 
            set damageDamage = damageDamage+0.03*GetUnitState(damageSource,UNIT_STATE_MAX_LIFE)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl",damageTarget,"chest"))
        endif 
    endfunction

    function ItemSFX_LightningReflexes takes nothing returns nothing
        local integer tempAbiCode = 'i01T'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local real param 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageIsAOE and random.get(damageTarget,0.05,'i01T') then 
            set damageFinalDamage = 0
        endif 
    endfunction

    function ItemSFX_Dash takes nothing returns nothing
        local integer tempAbiCode = 'i01U'
        local mybuff bf = 0
        local boolean checker = ItemRecallCheck(spellCaster,tempAbiCode)
        local real param 
        //call BJDebugMsg("1")
        if checker and BlzGetAbilityPosX(castingSpell) == 3 and BlzGetAbilityPosY(castingSpell) == 2 and spellCooldown > 0 then 
            //call BJDebugMsg("12")
            set bf = CreateBuff(spellCaster,spellCaster,BUFFTYPE_ITEM_DASH,20*R2I(spellCooldown))
            set bf.bonusMoveSpeed_P = 10000
            call bf.apply()
        endif 
    endfunction

    function ItemSFX_Mitigation takes nothing returns nothing
        local integer tempAbiCode = 'i01V'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local real param 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageTag_Attack and random.get(damageTarget,0.15,'i01V') then 
            set damageDamage = RMaxBJ(1,damageDamage-0.01*GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE))
        endif 
    endfunction

    function A66V_Damaging_Target takes nothing returns nothing
        if damageTag_Bleed then 
            set damageFinalDamage = 0
        endif 
    endfunction
    function ItemSFX_IronSkin takes nothing returns nothing
        local integer tempAbiCode = 'i01W'
        local mybuff bf = 0
        local boolean checker = ItemRecallCheck(spellCaster,tempAbiCode)
        local real param 
        if checker and BlzGetAbilityPosX(castingSpell) == 3 and BlzGetAbilityPosY(castingSpell) == 2 and spellCooldown > 0 then 
            set bf = CreateBuff(spellCaster,spellCaster,BUFFTYPE_ITEM_IRONSKIN,20*R2I(spellCooldown))
            call bf.addDmging_T(function A66V_Damaging_Target)
            call bf.apply()
        endif 
    endfunction

    function ItemSFX_Defliction takes nothing returns nothing
        local integer tempAbiCode = 'i01X'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local real param 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageAttackType == ATTACK_TYPE_NORMAL and random.get(damageTarget,0.15,tempAbiCode) then 
            set damageFinalDamage = damageFinalDamage*0.7
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl",damageTarget,"origin"))
        endif 
    endfunction

    function ItemSFX_LeechAttack takes nothing returns nothing
        local integer tempAbiCode = 'i01Y'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local real param 
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and random.get(damageSource,0.33,tempAbiCode) then 
            call AddUnitLife(damageSource,0.01*GetUnitState(damageSource,UNIT_STATE_MAX_LIFE))
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl",damageSource,"origin"))
        endif 
    endfunction

    function A671_PERIOD takes nothing returns nothing
        local mybuff bf = mybuff.currentBuff
        call AddUnitLife(bf.buffSource,0.15*GetUnitState(bf.buffSource,UNIT_STATE_MAX_LIFE)/8)
    endfunction
    function ItemSFX_Renew takes nothing returns nothing
        local integer tempAbiCode = 'i01Z'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local real param 
        local mybuff bf = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if unitCheckCooldown(damageTarget,tempAbiCode) and checker and random.get(damageTarget,0.25,tempAbiCode) then 
            set bf = CreateBuff(damageTarget,damageTarget,BUFFTYPE_ITEM_RENEW,800)
            set bf.periodTime = 100
            call bf.addPeriod(function A671_PERIOD)
            call bf.apply()
            call unitStartCooldown(damageTarget,tempAbiCode,3000)
        endif 
    endfunction

    function LifeDrain_Hit takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local real dmg = I2R(ST_ABILITY_POWER.getTotalState(proj.target))*0.3
        set healFlag = 'i020'
        call UnitHealTarget(proj.target,proj.target,dmg)
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl",proj.target,"origin"))
    endfunction
    function LifeDrain_Delayed takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local real dmg = I2R(ST_ABILITY_POWER.getTotalState(de.loadUnit("CASTER")))*0.3
        local projectile proj = CreateProjectileToUnit(de.loadUnit("TARGET"),de.loadUnit("CASTER"),600,0,"Abilities\\Weapons\\BlackKeeperMissile\\BlackKeeperMissile.mdl",function LifeDrain_Hit,null)
        call proj.launch()
        set damageFlag = 'i020'
        set damageTag_Shadow = true 
        call UnitDamageTarget(de.loadUnit("CASTER"),de.loadUnit("TARGET"),dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\BlackKeeperMissile\\BlackKeeperMissile.mdl",de.loadUnit("TARGET"),"chest"))
    endfunction
    function ItemSFX_LifeDrain takes nothing returns nothing
        local integer tempAbiCode = 'i020'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if unitCheckCooldown(damageSource,tempAbiCode) and checker and random.get(damageSource,0.25,tempAbiCode) then 
            set de = CreateDelayedEvent(1,1,function LifeDrain_Delayed)
            call de.saveUnit("CASTER",damageSource)
            call de.saveUnit("TARGET",damageTarget)
            call unitStartCooldown(damageSource,tempAbiCode,1000)
        endif 
    endfunction
    function ItemSFX_ChimeraAttack takes nothing returns nothing
        local integer tempAbiCode = 'i021'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if damageTag_Fire then 
                set damageTag_Cold = true 
            endif 
            if damageTag_Lightning then 
                set damageTag_Earth = true 
            endif 
        endif 
    endfunction 
    function ItemSFX_HellIronSkin takes nothing returns nothing
        local integer tempAbiCode = 'i022'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if damageIsCrush == false then 
                set damageFinalDamage = damageFinalDamage*0.95
            endif 
        endif 
    endfunction
    function ItemSFX_LimitedResilience takes nothing returns nothing
        local integer tempAbiCode = 'i023'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if damageDamage <= GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE)*0.1 then 
                set damageDamage = RMinBJ(damageDamage,RMaxBJ(1,damageDamage-10))
            endif 
        endif 
    endfunction
    function ItemSFX_Immortal takes nothing returns nothing
        local integer tempAbiCode = 'i023'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if unitCheckCooldown(damageTarget,tempAbiCode) and damageFinalDamage+0.5 >= GetUnitState(damageTarget,UNIT_STATE_LIFE) then 
                set damageFinalDamage = 0
                call SetUnitState(damageTarget,UNIT_STATE_LIFE,1)
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl",damageTarget,"origin"))
                call unitStartCooldown(damageTarget,tempAbiCode,12000)
            endif 
        endif 
    endfunction
    function ItemSFX_Transmute_1 takes nothing returns nothing
        if damageFlag == 'ANtm' and damageFinalDamage > GetUnitState(damageTarget,UNIT_STATE_LIFE) then 
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Other\\Transmute\\GoldBottleMissile.mdl",damageTarget,"origin"))
            call SetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_GOLD)+20*UnitLevel(damageTarget))
        endif 
    endfunction
    function ItemSFX_Transmute takes nothing returns nothing
        local integer tempAbiCode = 'i024'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if GetUnitLifePercent(damageTarget) < 0.25 and IsUnitElite(damageTarget) == false and IsUnitBoss(damageTarget) == false and unitCheckCooldown(damageSource,tempAbiCode) and random.get(damageSource,0.3,tempAbiCode) then 
                set damageFinalDamage = GetUnitState(damageTarget,UNIT_STATE_LIFE)*2
                set damageTag_Attack = false 
                set damageDamageType = DAMAGE_TYPE_MAGIC
                set damageAttackType = ATTACK_TYPE_HERO
                set damageFlag = 'ANtm'
                call unitStartCooldown(damageSource,tempAbiCode,12000)
            endif 
        endif 
    endfunction

    function ItemSFX_FrostFire takes nothing returns nothing
        local integer tempAbiCode = 'i025'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if damageTag_Fire then 
                set damageTag_Cold = true 
            endif 
            if damageTag_Cold then 
                set damageTag_Fire = true 
            endif 
        endif 
    endfunction

    function ItemSFX_EnhancePhysical takes nothing returns nothing
        local integer tempAbiCode = 'i026'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if damageDamageType == DAMAGE_TYPE_NORMAL then 
                set damageArmor = damageArmor*0.9
            endif 
        endif 
    endfunction

    function ItemSFX_EnhancePhysical_1 takes nothing returns nothing
        local integer tempAbiCode = 'i027'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if damageDamageType == DAMAGE_TYPE_NORMAL then 
                set damageFinalDamage = damageFinalDamage*1.03
            endif 
        endif 
    endfunction

    function ItemSFX_ChangeSpeed takes nothing returns nothing
        local integer tempAbiCode = 'i028'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local mybuff bf = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if unitCheckCooldown(damageSource,tempAbiCode) and checker and random.get(damageSource,0.25,tempAbiCode) then 
            set bf = CreateBuff(damageSource,damageSource,BUFFTYPE_ITEM_SPEEDCHANGE,1000)
            set bf.bonusAttackSpeed = GetRandomInt(500,3000)
            call bf.apply()
            call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\AIam\\AIamTarget.mdl",damageSource,"origin"))
            call unitStartCooldown(damageSource,tempAbiCode,3000)
        endif 
    endfunction
    
    function i029_HIT takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        call proj.applyDamageSet()
        call UnitDamageTarget(proj.source,proj.target,proj.realData,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
    endfunction
    function i029_DELAYED_A takes nothing returns nothing
        local projectile proj = delayedevent.currentEvent.loadInteger("PROJ")
        call proj.launch()
        set proj.bindSFX_0 = AddSpecialEffectTargetEX("war3campImported\\Frostfirebolt.mdl",proj.dummy,"chest")
    endfunction
    function ItemSFX_ChimeraShootA takes nothing returns nothing
        local integer tempAbiCode = 'i029'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local projectile proj = 0
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if unitCheckCooldown(damageSource,tempAbiCode) and checker and random.get(damageSource,0.25,tempAbiCode) then 
            set proj = CreateProjectileToUnit(damageSource,damageTarget,1200,0.05,"abilities\\weapons\\wyvernspear\\wyvernspearmissile.mdl",function i029_HIT,null)
            set proj.flag = 'i029'
            set proj.tag_Cold = true 
            set proj.tag_Fire = true 
            set proj.realData = I2R(GetUnitAttack(damageSource,0))*0.5
            set de = CreateDelayedEvent(15,1,function i029_DELAYED_A)
            call de.saveInteger("PROJ",proj)
            call unitStartCooldown(damageSource,tempAbiCode,1000)
        endif 
    endfunction
    function i029_DELAYED_B takes nothing returns nothing
        local projectile proj = delayedevent.currentEvent.loadInteger("PROJ")
        call proj.launch()
        set proj.bindSFX_0 = AddSpecialEffectTargetEX("war3campImported\\Lightning Missile.mdl",proj.dummy,"chest")
        set proj.bindSFX_1 = AddSpecialEffectTargetEX("war3campImported\\poisonhands.mdl",proj.dummy,"chest")
    endfunction
    function ItemSFX_ChimeraShootB takes nothing returns nothing
        local integer tempAbiCode = 'i029'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local projectile proj = 0
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if unitCheckCooldown(damageSource,tempAbiCode) and checker and random.get(damageSource,0.25,tempAbiCode) then 
            set proj = CreateProjectileToUnit(damageSource,damageTarget,1200,0.05,"abilities\\weapons\\wyvernspear\\wyvernspearmissile.mdl",function i029_HIT,null)
            set proj.flag = 'i029'
            set proj.tag_Earth = true 
            set proj.tag_Lightning = true 
            set proj.realData = I2R(GetUnitAttack(damageSource,0))*0.5
            set de = CreateDelayedEvent(15,1,function i029_DELAYED_B)
            call de.saveInteger("PROJ",proj)
            call unitStartCooldown(damageSource,tempAbiCode,1000)
        endif 
    endfunction

    function ItemSFX_ManaTide takes nothing returns nothing
        local integer tempAbiCode = 'i02A'
        local boolean checker = ItemRecallCheck(spellCaster,tempAbiCode)
        local mybuff bf = 0
        if unitCheckCooldown(spellCaster,tempAbiCode) and checker and random.get(spellCaster,0.15,tempAbiCode) then 
            set bf = CreateBuff(spellCaster,spellCaster,BUFFTYPE_ITEM_MANATIDE,1000)
            set bf.bonusManaRegen = 150
            call bf.apply()
            call unitStartCooldown(spellCaster,tempAbiCode,1500)
        endif 
    endfunction

    function i02B_HIT takes nothing returns nothing
        local projectile proj = projectile.currentProjectile
        local real dmg = proj.realData
        call proj.applyDamageSet()
        set damageTag_Lightning = true 
        set damageFlag = 'i02B'
        call UnitDamageTarget(proj.source,proj.target,dmg,false,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Weapons\\Bolt\\BoltImpact.mdl",proj.target,"origin"))
        call UnitsAddLightningSFX(proj.bounce_lastTarget,0,0,50,proj.target,0,0,50,"CHIM",1.5,0.75,true)
    endfunction
    function ItemSFX_ChainLightning takes nothing returns nothing
        local integer tempAbiCode = 'i02B'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local projectile proj = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if unitCheckCooldown(damageSource,tempAbiCode) and checker and random.get(damageSource,0.15,tempAbiCode) then 
            set proj = CreateProjectileToUnit(damageSource,damageTarget,5000,0,"Abilities\\Spells\\Orc\\LightningBolt\\LightningBoltMissile.mdl",function i02B_HIT,null)
            set proj.flag = 'i02B'
            set proj.tag_Lightning = true 
            set proj.maxBounceLimit = 5
            set proj.bounceMultiplier = 1
            set proj.bounceRange = 400
            set proj.realData = I2R(ST_ABILITY_POWER.getTotalState(damageSource))*0.5
            call delayedLaunchMissile(proj,20)
            call unitStartCooldown(damageSource,tempAbiCode,1500)
        endif 
    endfunction

    function i02C_HIT takes nothing returns nothing
        local projectile proj = waveWave
        local real dmg = proj.realData
        if IsUnitEnemy(waveTarget,GetOwningPlayer(waveCaster)) then 
            set damageIsAOE = true 
            set damageFlag = 'i02C'
            call UnitDamageTarget(waveCaster,waveTarget,dmg,false,true,ATTACK_TYPE_PIERCE,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
        endif 
    endfunction
    function ItemSFX_ShockWave takes nothing returns nothing
        local integer tempAbiCode = 'i02C'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local projectile proj = 0
        local real a = 0
        local real x = 0
        local real y = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if unitCheckCooldown(damageSource,tempAbiCode) and checker and random.get(damageSource,0.15,tempAbiCode) then 
            set a = AngleByUnits(damageSource,damageTarget)/57.2956
            set x = GetUnitX(damageSource)+600*Cos(a)
            set y = GetUnitY(damageSource)+600*Sin(a)
            set proj = CreateWave(damageSource,x,y,1050,100,0,"Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl",function i02C_HIT,null)
            set proj.realData = I2R(GetUnitMaxAttack(damageSource,0))*0.5
            call delayedLaunchMissile(proj,20)
            call unitStartCooldown(damageSource,tempAbiCode,1500)
        endif 
    endfunction
    
    function i02D_DAMAGING_TARGET_A takes nothing returns nothing
        if damageAttackType == ATTACK_TYPE_NORMAL then
            set damageFinalDamage = damageFinalDamage*0.9
        endif 
    endfunction
    function i02D_DAMAGING_TARGET_B takes nothing returns nothing
        if damageDamageType == DAMAGE_TYPE_NORMAL then
            set damageFinalDamage = damageFinalDamage*0.9
        endif 
    endfunction
    function ItemSFX_Insight takes nothing returns nothing
        local integer tempAbiCode = 'i02D'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local mybuff bf = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if unitCheckCooldown(damageTarget,tempAbiCode) and (damageAttackType == ATTACK_TYPE_NORMAL or damageDamageType == DAMAGE_TYPE_NORMAL) then 
                set bf = CreateBuff(damageTarget,damageTarget,BUFFTYPE_ITEM_INSIGHT,1000)
                if damageAttackType == ATTACK_TYPE_NORMAL then
                    call bf.addDmging_T(function i02D_DAMAGING_TARGET_B)
                    call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl",damageTarget,"origin"))
                endif 
                if damageDamageType == DAMAGE_TYPE_NORMAL then 
                    call bf.addDmging_T(function i02D_DAMAGING_TARGET_A)
                    call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl",damageTarget,"origin"))
                endif 
                call bf.apply()
                call unitStartCooldown(damageTarget,tempAbiCode,1500)
            endif 
        endif 
    endfunction

    function ItemSFX_Ascendancy takes nothing returns nothing
        local integer tempAbiCode = 'i02E'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local real param = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            set param = 1+(GetUnitLifePercent(damageSource)-GetUnitLifePercent(damageTarget))/1000
            set damageFinalDamage = damageFinalDamage*param
        endif 
    endfunction

    function ItemSFX_MythDefence takes nothing returns nothing
        local integer tempAbiCode = 'i02F'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local mybuff bf = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if unitCheckCooldown(damageTarget,tempAbiCode) and damageIsDOT == false and damageAttackType == ATTACK_TYPE_NORMAL and random.get(damageTarget,0.1,tempAbiCode) then 
                set damageFinalDamage = 0
                call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl",damageTarget,"origin"))
                call unitStartCooldown(damageTarget,tempAbiCode,3000)
            endif 
        endif 
    endfunction

    function ITEM_RENEW_AURA_SET takes nothing returns nothing
        set aura.modifingAuraBuff.bonusLifeRegen = 250
    endfunction
    function ItemSFX_RenewAura_On takes nothing returns nothing
        local aura ar = CreateAura(eventEquipment.bindUnit,"ITEM_RENEW_AURA",900,0,BUFFTYPE_ITEM_RENEWAURA,"")
        set eventEquipment.intData = ar 
        call ar.addAllySet(function ITEM_RENEW_AURA_SET)
        set ar.removeWhenDeath = false 
    endfunction
    function ItemSFX_RenewAura_Off takes nothing returns nothing
        local aura ar = eventEquipment.intData
        if ar > 0 then 
            call ar.destroy()
        endif 
        set eventEquipment.intData = 0
    endfunction

    function ItemSFX_CrystalArmor takes nothing returns nothing
        local integer tempAbiCode = 'i02G'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local mybuff bf = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if damageAttackType == ATTACK_TYPE_NORMAL then 
                set damageFinalDamage = damageFinalDamage*0.97
            endif 
        endif 
    endfunction

    function ITEM_FROST_ARMOR_DELAYED takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        call applyCold(de.loadUnit("CASTER"),de.loadUnit("TARGET"),'ACO1')
    endfunction
    function ItemSFX_FrostArmor takes nothing returns nothing
        local integer tempAbiCode = 'i02H'
        local boolean checker = ItemRecallCheck(damageTarget,tempAbiCode)
        local delayedevent de = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker then 
            if damageTag_Attack and damageIsMelee then 
                set de = CreateDelayedEvent(10,1,function ITEM_FROST_ARMOR_DELAYED)
                call de.saveUnit("CASTER",damageTarget)
                call de.saveUnit("TARGET",damageSource)
            endif 
        endif 
    endfunction

    function DeathAndDecay_Delayed takes nothing returns nothing
        local delayedevent de = delayedevent.currentEvent
        local unit ds = de.loadUnit("SOURCE")
        local unit dt = de.loadUnit("TARGET")
        local real dmg = GetUnitState(dt,UNIT_STATE_MAX_LIFE)*0.01
        set damageTag_Special = true 
        set damageTag_Shadow = true
        set damageIsExtra = true 
        set damageFlag = 'i02I'
        set damageAddCrit = -10000 
        call UnitDamageTarget(ds,dt,dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl",dt,"chest"))
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl",dt,"origin"))
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl",dt,"head"))
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl",dt,"hand left"))
        call DestroyEffectEX(AddSpecialEffectTargetEX("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl",dt,"hand right"))
        set ds = null 
        set dt = null 
    endfunction
    function ItemSFX_DeathAndDecay takes nothing returns nothing
        local integer tempAbiCode = 'i02I'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local delayedevent de = 0
        local mybuff bf = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageIfCrit then 
            set bf = mybuff.getUnitBuff(damageTarget,BUFFTYPE_ITEM_DEATHANDDECAY)
            if bf > 0 then 
                if bf.realData-GetUnitLifePercent(damageTarget) < 15 then 
                    return 
                endif 
            endif 
            if random.get(damageSource,0.15,tempAbiCode) then 
                set bf = CreateBuff(damageSource,damageTarget,BUFFTYPE_ITEM_DEATHANDDECAY,360000)
                set bf.realData = GetUnitLifePercent(damageTarget)
                set bf.intData = bf.intData+1
                call bf.apply()
                set de = CreateDelayedEvent(10,1,function DeathAndDecay_Delayed)
                call de.saveUnit("TARGET",damageTarget)
                call de.saveUnit("SOURCE",damageSource)
            endif 
        endif 
    endfunction

    function ItemSFX_DustToDust takes nothing returns nothing
        local integer tempAbiCode = 'i02J'
        local boolean checker = ItemRecallCheck(damageSource,tempAbiCode)
        local mybuff bf = 0
        if damageSource == damageTarget then 
            return 
        endif 
        if checker and damageAttackType == ATTACK_TYPE_NORMAL then 
            set bf = mybuff.getUnitBuff(damageTarget,BUFFTYPE_ITEM_DEATHANDDECAY)
            if bf == 0 then 
                return 
            endif 
            if ModuloInteger(bf.intData,2) == 1 then 
                set damageTag_Shadow = true 
            else 
                set damageTag_Divine = true 
            endif 
            set damageFinalDamage = damageFinalDamage*1.05
        endif 
    endfunction
    //====================================================
    // endregion
    //====================================================
    
endlibrary

scope ItemSettings initializer init
    struct craftPool 
        static thistype top = 0
        static integer count = 0
        thistype prev = 0
        thistype next = 0
        integer value = 0

        static method create takes integer value returns thistype
            local thistype this = thistype.allocate()
            set this.prev = thistype.top 
            if thistype.top > 0 then 
                set this.prev.next = this 
            endif 
            set thistype.top = this 
            set thistype.count = thistype.count+1 
            set this.value = value 
            return this 
        endmethod

        method onDestroy takes nothing returns nothing
            if this.prev > 0 then 
                set this.prev.next = this.next 
            endif 
            if this.next > 0 then 
                set this.next.prev = this.prev 
            endif 
            if this == thistype.top then 
                set thistype.top = this.prev 
            endif 
            set thistype.count = thistype.count-1
        endmethod

        static method add takes integer value,integer times returns nothing
            loop
                exitwhen times == 0
                call thistype.create(value)
                set times = times-1
            endloop
        endmethod

        static method remove takes integer value returns nothing
            local thistype this = thistype.top 
            local thistype prev = this.prev 
            loop
                exitwhen this == 0
                set prev = this.prev 
                if this.value == value then 
                    call this.destroy()
                endif 
                set this = prev 
            endloop
        endmethod

        static method flush takes nothing returns nothing
            loop 
                exitwhen thistype.top == 0
                call thistype.top.destroy()
            endloop
        endmethod   

        static method pick takes nothing returns integer
            local integer x = thistype.count 
            local thistype this = thistype.top 
            //call BJDebugMsg("X = "+I2S(x))
            if x == 0 then 
                return 0 
            endif 
            loop
                exitwhen this == 0
                if GetLootNumberEx(x) == 0 then
                    //call BJDebugMsg("CHOOSE = "+I2S(this)+" : "+I2S(this.value))  
                    return this.value
                endif 
                set this = this.prev 
                set x = x-1
            endloop
            return 0
        endmethod
    endstruct

    function initEquipmentTypes_0_330 takes nothing returns nothing
        local EquipType this
        call DestroyTimer(GetExpiredTimer())
        /*
        // region equip PASTE HERE
        "
I60A-轻便手斧*/
set this = CreateEquipType('I60A',1,2,0,ST_ATTACK,STATE_MODE_INT,3,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 攻击\n+5%% 攻击速度"
set this.name = "|cffffffff轻便手斧|r\n\n[武器]副手 - 等级1"
set this.inSet = 0
/*"
"
I60B-圆木盾*/
set this = CreateEquipType('I60B',1,3,0,ST_ARMOR,STATE_MODE_INT,3,ST_BLOCK,STATE_MODE_INT,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+2 格挡"
set this.name = "|cffffffff圆木盾|r\n\n[盾·轻]副手 - 等级1"
set this.inSet = 0
/*"
"
I603-钢盾*/
set this = CreateEquipType('I603',1,4,0,ST_ARMOR,STATE_MODE_INT,5,ST_BLOCK,STATE_MODE_INT,5,0,0,0,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,-500,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+5 格挡\n|cffff0000-5%% 移动速度|r"
set this.name = "|cffffffff钢盾|r\n\n[盾·重]副手 - 等级1"
set this.inSet = 0
/*"
"
I60G-粗制布袍*/
set this = CreateEquipType('I60G',1,2,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,18,ST_MANA,STATE_MODE_INT,8,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+18 生命\n+8 法力"
set this.name = "|cffffffff粗制布袍|r\n\n[轻]护甲 - 等级1"
set this.inSet = 0
/*"
"
I60F-粗制皮甲*/
set this = CreateEquipType('I60F',1,3,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+21 生命"
set this.name = "|cffffffff粗制皮甲|r\n\n[中]护甲 - 等级1"
set this.inSet = 0
/*"
"
I61B-萤石指环*/
set this = CreateEquipType('I61B',1,2,0,ST_MANA,STATE_MODE_INT,5,ST_MANA_REGEN,STATE_MODE_REAL,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 法力\n+0.05 法力恢复"
set this.name = "|cffffffff萤石指环|r\n\n戒指 - 等级1"
set this.inSet = 0
/*"
"
I60N-石英指环*/
set this = CreateEquipType('I60N',1,2,0,ST_LIFE,STATE_MODE_INT,12,ST_LIFE_REGEN,STATE_MODE_REAL,11,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 生命\n+0.11 生命恢复"
set this.name = "|cffffffff石英指环|r\n\n戒指 - 等级1"
set this.inSet = 0
/*"
"
I610-尖刺拳套*/
set this = CreateEquipType('I610',1,4,0,ST_ATTACK,STATE_MODE_INT,2,ST_ARMOR_PEN,STATE_MODE_INT,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 攻击\n+1 护甲穿透"
set this.name = "|cffffffff尖刺拳套|r\n\n手套 - 等级1"
set this.inSet = 0
/*"
"
I61C-轻布手套*/
set this = CreateEquipType('I61C',1,4,0,ST_ABILITY_POWER,STATE_MODE_INT,2,ST_INT,STATE_MODE_INT,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 法术强度\n+1 智力"
set this.name = "|cffffffff轻布手套|r\n\n手套 - 等级1"
set this.inSet = 0
/*"
"
I60S-布制头巾*/
set this = CreateEquipType('I60S',1,2,0,ST_ARMOR,STATE_MODE_INT,1,ST_LIFE,STATE_MODE_INT,8,ST_MANA,STATE_MODE_INT,3,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+1 护甲\n+8 生命\n+3 法力"
set this.name = "|cffffffff布制头巾|r\n\n[轻]头盔 - 等级1"
set this.inSet = 0
/*"
"
I60D-柳木弓*/
set this = CreateEquipType('I60D',1,2,0,ST_ATTACK,STATE_MODE_INT,5,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 攻击\n+7.5%% 攻击速度"
set this.name = "|cffffffff柳木弓|r\n\n[远]武器 - 等级1"
set this.inSet = 0
/*"
"
I60E-柳木法杖*/
set this = CreateEquipType('I60E',1,4,0,ST_ABILITY_POWER,STATE_MODE_INT,5,ST_MANA,STATE_MODE_INT,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 法术强度\n+8 法力"
set this.name = "|cffffffff柳木法杖|r\n\n[法]武器 - 等级1"
set this.inSet = 0
/*"
"
I61G-仪式匕首*/
set this = CreateEquipType('I61G',1,5,0,ST_ABILITY_POWER,STATE_MODE_INT,5,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 法术强度\n+7.5%% 攻击速度"
set this.name = "|cffffffff仪式匕首|r\n\n[近|法]武器 - 等级1"
set this.inSet = 0
/*"
"
I60C-铸铁剑*/
set this = CreateEquipType('I60C',1,1,0,ST_ATTACK,STATE_MODE_INT,5,ST_ACCURACY,STATE_MODE_PERCENTAGE,450,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 攻击\n+4.5%% 命中"
set this.name = "|cffffffff铸铁剑|r\n\n[近]武器 - 等级1"
set this.inSet = 0
/*"
"
I60J-软布裹足*/
set this = CreateEquipType('I60J',1,2,0,ST_ARMOR,STATE_MODE_INT,1,ST_MOVE_SPEED,STATE_MODE_INT,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+1 护甲\n+14 移动速度"
set this.name = "|cffffffff软布裹足|r\n\n[轻]鞋 - 等级1"
set this.inSet = 0
/*"
"
I611-粗布裹腰*/
set this = CreateEquipType('I611',1,5,0,ST_LIFE,STATE_MODE_INT,7,ST_MANA,STATE_MODE_INT,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 生命\n+3 法力"
set this.name = "|cffffffff粗布裹腰|r\n\n腰带 - 等级1"
set this.inSet = 0
/*"
"
I60R-铁质束腰*/
set this = CreateEquipType('I60R',1,5,0,ST_ARMOR,STATE_MODE_INT,1,ST_LIFE,STATE_MODE_INT,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+1 护甲\n+7 生命"
set this.name = "|cffffffff铁质束腰|r\n\n腰带 - 等级1"
set this.inSet = 0
/*"
"
I608-拉多之心*/
set this = CreateEquipType('I608',3,1,0,ST_LIFE,STATE_MODE_INT,36,ST_MANA,STATE_MODE_INT,7,ST_INT,STATE_MODE_INT,3,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,100,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+36 生命\n+7 法力\n+3 智力\n|cff20c000+1%% 暴击|r"
set this.name = "|cff20c000拉多之心|r\n\n副手 - 等级3"
set this.inSet = 0
/*"
"
I60P-疗愈小符*/
set this = CreateEquipType('I60P',3,1,0,ST_ABILITY_POWER,STATE_MODE_INT,6,ST_MANA,STATE_MODE_INT,7,ST_MANA_REGEN,STATE_MODE_REAL,6,ST_HEAL_BONUS,STATE_MODE_PERCENTAGE,100,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 法术强度\n+7 法力\n+0.06 法力恢复\n|cff20c000+1%% 治疗加成|r"
set this.name = "|cff20c000疗愈小符|r\n\n副手 - 等级3"
set this.inSet = 0
/*"
"
I60Q-锯齿匕首*/
set this = CreateEquipType('I60Q',3,2,0,ST_ATTACK,STATE_MODE_INT,6,ST_AGI,STATE_MODE_INT,3,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_HASTE,STATE_MODE_PERCENTAGE,100,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 攻击\n+3 敏捷\n+5%% 攻击速度\n|cff20c000+1%% 急速|r"
set this.name = "|cff20c000锯齿匕首|r\n\n[武器]副手 - 等级3"
set this.inSet = 0
/*"
"
I60K-瓦解护符*/
set this = CreateEquipType('I60K',3,1,'AA00',ST_LIFE,STATE_MODE_INT,54,ST_MANA,STATE_MODE_INT,11,ST_LIFE_REGEN,STATE_MODE_REAL,22,ST_RESISTANCE,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+54 生命\n+11 法力\n+0.22 生命恢复\n|cff20c000+1.5%% 法术抗性|r|N|cffffcc00赋予技能：|r|n|cff20c000瓦解之链：|r驱散目标盟友的3个不利效果或是驱散目标敌人的3个有利效果，并对召唤生物造成法术伤害。跳跃2次。"
set this.name = "|cff20c000瓦解护符|r\n\n护符 - 等级3"
set this.inSet = 0
/*"
"
I60I-染血布衣*/
set this = CreateEquipType('I60I',3,2,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,54,ST_MAIN,STATE_MODE_INT,5,ST_ARMOR,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+54 生命\n+5 主属性\n|cff20c000+1.5%% 护甲|r"
set this.name = "|cff20c000染血布衣|r\n\n[轻]护甲 - 等级3"
set this.inSet = 0
/*"
"
I609-翠绿法杖*/
set this = CreateEquipType('I609',3,4,0,ST_ABILITY_POWER,STATE_MODE_INT,9,ST_MANA,STATE_MODE_INT,11,ST_MANA_REGEN,STATE_MODE_REAL,9,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 法术强度\n+11 法力\n+0.09 法力恢复\n|cff20c000+1.5%% 法术强度|r"
set this.name = "|cff20c000翠绿法杖|r\n\n[法]武器 - 等级3"
set this.inSet = 0
/*"
"
I60L-钢铸剑*/
set this = CreateEquipType('I60L',3,1,0,ST_ATTACK,STATE_MODE_INT,9,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_ACCURACY,STATE_MODE_PERCENTAGE,480,ST_ATTACK,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 攻击\n+7.5%% 攻击速度\n+4.8%% 命中\n|cff20c000+1.5%% 攻击|r"
set this.name = "|cff20c000钢铸剑|r\n\n[近]武器 - 等级3"
set this.inSet = 0
/*"
"
I60O-长战弓*/
set this = CreateEquipType('I60O',3,2,0,ST_ATTACK,STATE_MODE_INT,9,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_ARMOR_PEN,STATE_MODE_INT,4,ST_HASTE,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 攻击\n+7.5%% 攻击速度\n+4 护甲穿透\n|cff20c000+1.5%% 急速|r"
set this.name = "|cff20c000长战弓|r\n\n[远]武器 - 等级3"
set this.inSet = 0
/*"
"
I60T-氏族巫杖*/
set this = CreateEquipType('I60T',5,4,0,ST_ABILITY_POWER,STATE_MODE_INT,13,ST_MANA,STATE_MODE_INT,15,ST_INT,STATE_MODE_INT,8,ST_MANA_REGEN,STATE_MODE_PERCENTAGE,750,ST_INT,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
call this.addSpelling( function ItemSFX_ArcaneResonance )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+13 法术强度\n+15 法力\n+8 智力\n|cff20c000+7.5%% 法力恢复|r\n|cff20c000+3%% 智力|r\n|cffffcc00效果：|r\n|cff20c000奥术共鸣：|r施法时有15%%的几率恢复所消耗法力的20%%。"
set this.name = "|cff0070dd氏族巫杖|r\n\n[法]武器 - 等级5"
set this.inSet = 0
/*"
"
I60U-食人魔战锤*/
set this = CreateEquipType('I60U',5,1,0,ST_ATTACK,STATE_MODE_INT,16,ST_ARMOR_PEN,STATE_MODE_INT,8,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,-1500,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_DAMAGE_BONUS,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
call this.addAtked_S( function ItemSFX_Bash )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+16 攻击\n+8 护甲穿透\n|cffff0000-15%% 攻击速度|r\n|cff20c000+3%% 攻击|r\n|cff20c000+3%% 伤害加成|r\n|cffffcc00效果：|r\n|cff20c000重击：|r击中时有15%%的几率额外造成20%%[x]的伤害。"
set this.name = "|cff0070dd食人魔战锤|r\n\n[近]武器 - 等级5"
set this.inSet = 0
/*"
"
I60V-追猎者轻弩*/
set this = CreateEquipType('I60V',5,2,0,ST_ATTACK,STATE_MODE_INT,13,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_ARMOR_PEN,STATE_MODE_INT,6,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
call this.addAtked_S( function ItemSFX_RangedAttack )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+13 攻击\n+7.5%% 攻击速度\n+6 护甲穿透\n|cff20c000+3%% 攻击|r\n|cff20c000+3%% 急速|r\n|cffffcc00效果：|r\n|cff20c000远距打击：|r与敌人的距离在300以上时，攻击造成的伤害提高10%%[x]。"
set this.name = "|cff0070dd追猎者轻弩|r\n\n[远]武器 - 等级5"
set this.inSet = 0
/*"
"
I60W-锁子甲*/
set this = CreateEquipType('I60W',5,4,0,ST_ARMOR,STATE_MODE_INT,10,ST_LIFE,STATE_MODE_INT,108,ST_BLOCK,STATE_MODE_INT,10,ST_ARMOR,STATE_MODE_PERCENTAGE,300,ST_LIFE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
call this.addPreDmg_T( function ItemSFX_Barrier )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+10 护甲\n+108 生命\n+10 格挡\n|cff20c000+3%% 护甲|r\n|cff20c000+3%% 生命|r\n|cffffcc00效果：|r\n|cff20c000壁垒：|r有10%%的几率使你的格挡效果提高20%%。"
set this.name = "|cff0070dd锁子甲|r\n\n[重]护甲 - 等级5"
set this.inSet = 0
/*"
"
I60X-兽皮甲*/
set this = CreateEquipType('I60X',5,3,0,ST_ARMOR,STATE_MODE_INT,7,ST_LIFE,STATE_MODE_INT,108,ST_LIFE_REGEN,STATE_MODE_REAL,30,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_EVADE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
call this.addHealing_T( function ItemSFX_VigorousVitality )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+108 生命\n+0.3 生命恢复\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 闪避|r\n|cffffcc00效果：|r\n|cff20c000旺盛生机：|r生命值低于50%%时，受到的治疗效果提高8%%[x]。"
set this.name = "|cff0070dd兽皮甲|r\n\n[中]护甲 - 等级5"
set this.inSet = 0
/*"
"
I60Y-部族法袍*/
set this = CreateEquipType('I60Y',5,2,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,99,ST_MANA,STATE_MODE_INT,15,ST_INT,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
call this.addAftDmg_T( function ItemSFX_Wove )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+99 生命\n+15 法力\n|cff20c000+3%% 智力|r\n|cff20c000+3%% 急速|r\n|cffffcc00效果：|r\n|cff20c000编织：|r受到伤害后，有10%%的几率生成一个5%%最大生命的护盾，持续5秒。"
set this.name = "|cff0070dd部族法袍|r\n\n[轻]护甲 - 等级5"
set this.inSet = 0
/*"
"
I60Z-铁意头盔*/
set this = CreateEquipType('I60Z',5,4,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,50,ST_BLOCK,STATE_MODE_INT,4,ST_LIFE_REGEN,STATE_MODE_PERCENTAGE,350,ST_BLOCK,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
call this.addPreDmg_T( function ItemSFX_Unbreakable )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+50 生命\n+4 格挡\n|cff20c000+3.5%% 生命恢复|r\n|cff20c000+1.4%% 格挡|r\n|cffffcc00效果：|r\n|cff20c000不屈：|r生命值低于50%%时，格挡效果提高10%%。"
set this.name = "|cff0070dd铁意头盔|r\n\n[重]头盔 - 等级5"
set this.inSet = 0
/*"
"
I612-勇气头巾*/
set this = CreateEquipType('I612',5,3,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,50,ST_AGI,STATE_MODE_INT,4,ST_HASTE,STATE_MODE_PERCENTAGE,140,ST_EVADE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
call this.addAftDmg_T( function ItemSFX_Firm )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+50 生命\n+4 敏捷\n|cff20c000+1.4%% 急速|r\n|cff20c000+1.4%% 闪避|r\n|cffffcc00效果：|r\n|cff20c000坚定：|r敏捷不低于25时，受到伤害后有20%%的几率驱散自身的一个负面效果。触发后有10秒冷却时间。"
set this.name = "|cff0070dd勇气头巾|r\n\n[中]头盔 - 等级5"
set this.inSet = 0
/*"
"
I613-兽皮靴*/
set this = CreateEquipType('I613',5,3,0,ST_ARMOR,STATE_MODE_INT,3,ST_MOVE_SPEED,STATE_MODE_INT,14,ST_INT,STATE_MODE_INT,4,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,140,ST_MANA,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
call this.addBefDmg_T( function ItemSFX_Cushioning )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+14 移动速度\n+4 智力\n|cff20c000+1.4%% 法术强度|r\n|cff20c000+1.4%% 法力|r\n|cffffcc00效果：|r\n|cff20c000缓震：|r受到的任何伤害降低5%%，不超过5点。"
set this.name = "|cff0070dd兽皮靴|r\n\n[中]鞋 - 等级5"
set this.inSet = 0
/*"
"
I614-织网裹足*/
set this = CreateEquipType('I614',5,2,0,ST_ARMOR,STATE_MODE_INT,2,ST_MOVE_SPEED,STATE_MODE_INT,14,ST_MANA_REGEN,STATE_MODE_REAL,4,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_INT,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
call this.addSpelling( function ItemSFX_MythStep )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+14 移动速度\n+0.04 法力恢复\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 智力|r\n|cffffcc00效果：|r\n|cff20c000魔力脚步：|r施法时有15%%的几率使移动速度提高10%%，持续5秒。"
set this.name = "|cff0070dd织网裹足|r\n\n[轻]鞋 - 等级5"
set this.inSet = 0
/*"
"
I615-精致圆盾*/
set this = CreateEquipType('I615',5,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_BLOCK,STATE_MODE_INT,14,ST_LIFE_REGEN,STATE_MODE_REAL,20,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_RESISTANCE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
call this.addPreDmg_T( function ItemSFX_BlockMissile )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+14 格挡\n+0.2 生命恢复\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 法术抗性|r\n|cffffcc00效果：|r\n|cff20c000格挡飞矢：|r受到远程攻击时，格挡效果提高15%%。"
set this.name = "|cff0070dd精致圆盾|r\n\n[盾·轻]副手 - 等级5"
set this.inSet = 0
/*"
"
I616-山丘巨人力量腰带*/
set this = CreateEquipType('I616',6,5,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,57,ST_STR,STATE_MODE_INT,14,ST_STR,STATE_MODE_PERCENTAGE,600,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+57 生命\n+14 力量\n|cff20c000+6%% 力量|r"
set this.name = "|cffa334ee山丘巨人力量腰带|r\n\n腰带 - 等级6"
set this.inSet = 0
/*"
"
I617-丝绸裹手*/
set this = CreateEquipType('I617',5,4,0,ST_ABILITY_POWER,STATE_MODE_INT,5,ST_MANA_REGEN,STATE_MODE_REAL,4,ST_INT,STATE_MODE_INT,3,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,120,ST_HASTE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
call this.addDmging_S( function ItemSFX_ElementTuning )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 法术强度\n+0.04 法力恢复\n+3 智力\n|cff20c000+1.2%% 暴击|r\n|cff20c000+1.2%% 急速|r\n|cffffcc00效果：|r\n|cff20c000元素调谐：|r造成的元素伤害提高2%%[x]。"
set this.name = "|cff0070dd丝绸裹手|r\n\n手套 - 等级5"
set this.inSet = 0
/*"
"
I618-花火之刃*/
set this = CreateEquipType('I618',5,5,0,ST_ABILITY_POWER,STATE_MODE_INT,13,ST_INT,STATE_MODE_INT,8,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_INT,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
call this.addAtked_S( function ItemSFX_SwordDance )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+13 法术强度\n+8 智力\n+7.5%% 攻击速度\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 智力|r\n|cffffcc00效果：|r\n|cff20c000剑舞：|r击中时有5%%的几率造成两次伤害。"
set this.name = "|cff0070dd花火之刃|r\n\n[近|法]武器 - 等级5"
set this.inSet = 0
/*"
"
I619-雄狮战戒*/
set this = CreateEquipType('I619',5,3,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,66,ST_BLOCK,STATE_MODE_INT,7,ST_STR,STATE_MODE_PERCENTAGE,200,ST_AGI,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
call this.addPreDmg_T( function ItemSFX_LionHeart )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+66 生命\n+7 格挡\n|cff20c000+2%% 力量|r\n|cff20c000+2%% 敏捷|r\n|cffffcc00效果：|r\n|cff20c000狮心：|r生命值低于50%%时，受到伤害前，在3秒内提高10%%的护甲。"
set this.name = "|cff0070dd雄狮战戒|r\n\n[唯一]戒指 - 等级5"
set this.inSet = 0
/*"
"
I61A-搅拌毒药的利器*/
set this = CreateEquipType('I61A',4,1,0,ST_ATTACK,STATE_MODE_INT,9,ST_AGI,STATE_MODE_INT,6,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_HASTE,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 攻击\n+6 敏捷\n+7.5%% 攻击速度\n|cff20c000+1.5%% 急速|r"
set this.name = "|cff20c000搅拌毒药的利器|r\n\n[近]武器 - 等级4"
set this.inSet = 0
/*"
"
I61M-玛瑙指环*/
set this = CreateEquipType('I61M',4,2,0,ST_MAIN,STATE_MODE_INT,4,ST_LIFE_REGEN,STATE_MODE_REAL,16,ST_MANA_REGEN,STATE_MODE_REAL,6,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,100,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 主属性\n+0.16 生命恢复\n+0.06 法力恢复\n|cff20c000+1%% 暴击|r"
set this.name = "|cff20c000玛瑙指环|r\n\n戒指 - 等级4"
set this.inSet = 0
/*"
"
I61L-丛林裹腰*/
set this = CreateEquipType('I61L',4,5,0,ST_ARMOR,STATE_MODE_INT,1,ST_LIFE,STATE_MODE_INT,25,ST_MANA,STATE_MODE_INT,4,ST_MANA,STATE_MODE_PERCENTAGE,60,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+1 护甲\n+25 生命\n+4 法力\n|cff20c000+0.6%% 法力|r"
set this.name = "|cff20c000丛林裹腰|r\n\n腰带 - 等级4"
set this.inSet = 0
/*"
"
I61J-法力手套*/
set this = CreateEquipType('I61J',4,4,0,ST_ABILITY_POWER,STATE_MODE_INT,3,ST_MANA,STATE_MODE_INT,4,ST_MANA_REGEN,STATE_MODE_REAL,3,ST_MANA,STATE_MODE_PERCENTAGE,60,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 法术强度\n+4 法力\n+0.03 法力恢复\n|cff20c000+0.6%% 法力|r"
set this.name = "|cff20c000法力手套|r\n\n手套 - 等级4"
set this.inSet = 0
/*"
"
I61K-丛林皮手套*/
set this = CreateEquipType('I61K',4,4,0,ST_ARMOR,STATE_MODE_INT,1,ST_BLOCK,STATE_MODE_INT,3,ST_ACCURACY,STATE_MODE_PERCENTAGE,195,ST_LIFE,STATE_MODE_PERCENTAGE,60,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+1 护甲\n+3 格挡\n+1.95%% 命中\n|cff20c000+0.6%% 生命|r"
set this.name = "|cff20c000丛林皮手套|r\n\n手套 - 等级4"
set this.inSet = 0
/*"
"
I606-亚麻裹巾*/
set this = CreateEquipType('I606',4,2,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,29,ST_MANA,STATE_MODE_INT,5,ST_MANA,STATE_MODE_PERCENTAGE,70,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+29 生命\n+5 法力\n|cff20c000+0.7%% 法力|r"
set this.name = "|cff20c000亚麻裹巾|r\n\n[轻]头盔 - 等级4"
set this.inSet = 0
/*"
"
I601-铜制护胫*/
set this = CreateEquipType('I601',4,4,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,29,ST_MOVE_SPEED,STATE_MODE_INT,14,ST_LIFE,STATE_MODE_PERCENTAGE,70,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+29 生命\n+14 移动速度\n|cff20c000+0.7%% 生命|r"
set this.name = "|cff20c000铜制护胫|r\n\n[重]鞋 - 等级4"
set this.inSet = 0
/*"
"
I605-迅捷皮靴*/
set this = CreateEquipType('I605',4,3,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,29,ST_MOVE_SPEED,STATE_MODE_INT,14,ST_HASTE,STATE_MODE_PERCENTAGE,70,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+29 生命\n+14 移动速度\n|cff20c000+0.7%% 急速|r"
set this.name = "|cff20c000迅捷皮靴|r\n\n[中]鞋 - 等级4"
set this.inSet = 0
/*"
"
I61E-丛林皮护甲*/
set this = CreateEquipType('I61E',4,3,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,63,ST_AGI,STATE_MODE_INT,6,ST_EVADE,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+63 生命\n+6 敏捷\n|cff20c000+1.5%% 闪避|r"
set this.name = "|cff20c000丛林皮护甲|r\n\n[中]护甲 - 等级4"
set this.inSet = 0
/*"
"
I604-丛林兜帽*/
set this = CreateEquipType('I604',4,3,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,29,ST_INT,STATE_MODE_INT,2,ST_MANA,STATE_MODE_PERCENTAGE,70,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+29 生命\n+2 智力\n|cff20c000+0.7%% 法力|r"
set this.name = "|cff20c000丛林兜帽|r\n\n[中]头盔 - 等级4"
set this.inSet = 0
/*"
"
I61N-锯齿箭*/
set this = CreateEquipType('I61N',4,1,0,ST_MAIN,STATE_MODE_INT,4,ST_ARMOR_PEN,STATE_MODE_INT,3,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,100,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 主属性\n+3 护甲穿透\n+5%% 攻击速度\n|cff20c000+1%% 暴击|r"
set this.name = "|cff20c000锯齿箭|r\n\n副手 - 等级4"
set this.inSet = 0
/*"
"
I61O-萨满匕首*/
set this = CreateEquipType('I61O',4,5,0,ST_ABILITY_POWER,STATE_MODE_INT,9,ST_INT,STATE_MODE_INT,6,ST_MANA_REGEN,STATE_MODE_REAL,9,ST_HASTE,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 法术强度\n+6 智力\n+0.09 法力恢复\n|cff20c000+1.5%% 急速|r"
set this.name = "|cff20c000萨满匕首|r\n\n[近|法]武器 - 等级4"
set this.inSet = 0
/*"
"
I61H-阿尔萨斯的馈赠*/
set this = CreateEquipType('I61H',8,1,0,ST_STR,STATE_MODE_INT,9,ST_AGI,STATE_MODE_INT,9,ST_INT,STATE_MODE_INT,9,ST_ARMOR,STATE_MODE_PERCENTAGE,300,ST_LIFE,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addSpelling( function ItemSFX_ArcaneResonance )
call this.addAtking( function ItemSFX_Sorrow )
set this.insc = "\n\n|cff888888似乎可以听见来自诺森德的召唤。|r"
set this.desc = "|cffffcc00属性：|r\n+9 力量\n+9 敏捷\n+9 智力\n|cff20c000+3%% 护甲|r\n|cff20c000+3%% 生命|r\n|cff20c000+2%% 暴击|r\n|cffffcc00效果：|r\n|cff20c000奥术共鸣：|r施法时有15%%的几率恢复所消耗法力的20%%。\n|cff20c000悲鸣：|r攻击时有20%%的几率对目标造成攻击力15%%-18%%的法术伤害。"
set this.name = "|cffa334ee阿尔萨斯的馈赠|r\n\n副手 - 等级8"
set this.inSet = 0
/*"
"
I61P-蛛魔尖刺*/
set this = CreateEquipType('I61P',7,1,0,ST_ATTACK,STATE_MODE_INT,17,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_AGI,STATE_MODE_INT,11,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
call this.addAtked_S( function ItemSFX_SunderStrike )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+17 攻击\n+7.5%% 攻击速度\n+11 敏捷\n|cff20c000+3%% 护甲穿透|r\n|cff20c000+3%% 急速|r\n|cffffcc00效果：|r\n|cff20c000裂甲刺击：|r击中时有15%%的几率使目标的护甲降低10%%，持续10秒。"
set this.name = "|cff0070dd蛛魔尖刺|r\n\n[近]武器 - 等级7"
set this.inSet = 0
/*"
"
I61T-蛛魔附肢*/
set this = CreateEquipType('I61T',7,2,0,ST_ATTACK,STATE_MODE_INT,11,ST_ARMOR_PEN,STATE_MODE_INT,5,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ATTACK,STATE_MODE_PERCENTAGE,200,ST_AGI,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
call this.addAtked_S( function ItemSFX_ToxinBlade )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+11 攻击\n+5 护甲穿透\n+5%% 攻击速度\n|cff20c000+2%% 攻击|r\n|cff20c000+2%% 敏捷|r\n|cffffcc00效果：|r\n|cff20c000毒刃：|r击中时有20%%的几率令目标中毒，在6秒内造成20%%的法术伤害(自然、中毒)。"
set this.name = "|cff0070dd蛛魔附肢|r\n\n[武器]副手 - 等级7"
set this.inSet = 0
/*"
"
I61Q-屠夫的切肉刀*/
set this = CreateEquipType('I61Q',7,1,0,ST_ATTACK,STATE_MODE_INT,17,ST_STR,STATE_MODE_INT,11,ST_ARMOR_PEN,STATE_MODE_INT,8,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
call this.addAtked_S( function ItemSFX_Laceration )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+17 攻击\n+11 力量\n+8 护甲穿透\n|cff20c000+3%% 攻击|r\n|cff20c000+3%% 暴击|r\n|cffffcc00效果：|r\n|cff20c000裂伤：|r击中时有20%%的几率撕裂目标，在4秒内造成15%%的物理伤害(流血)。"
set this.name = "|cff0070dd屠夫的切肉刀|r\n\n[近]武器 - 等级7"
set this.inSet = 0
/*"
"
I61U-肉钩*/
set this = CreateEquipType('I61U',7,2,0,ST_ATTACK,STATE_MODE_INT,11,ST_STR,STATE_MODE_INT,7,ST_ACCURACY,STATE_MODE_PERCENTAGE,365,ST_STR,STATE_MODE_PERCENTAGE,200,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,400,0,0,0,0,0,0)
call this.addAtked_S( function ItemSFX_Bash )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+11 攻击\n+7 力量\n+3.65%% 命中\n|cff20c000+2%% 力量|r\n|cff20c000+4%% 暴击伤害|r\n|cffffcc00效果：|r\n|cff20c000重击：|r击中时有15%%的几率额外造成20%%[x]的伤害。"
set this.name = "|cff0070dd肉钩|r\n\n[武器]副手 - 等级7"
set this.inSet = 0
/*"
"
I61R-灵动法杖*/
set this = CreateEquipType('I61R',7,4,0,ST_ABILITY_POWER,STATE_MODE_INT,17,ST_MANA,STATE_MODE_INT,18,ST_INT,STATE_MODE_INT,11,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
call this.addDmging_S( function ItemSFX_EnhanceCold )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+17 法术强度\n+18 法力\n+11 智力\n|cff20c000+3%% 法术强度|r\n|cff20c000+3%% 急速|r\n|cffffcc00效果：|r\n|cff20c000冰霜增效：|r冰霜伤害提高3%%[x]。"
set this.name = "|cff0070dd灵动法杖|r\n\n[法]武器 - 等级7"
set this.inSet = 0
/*"
"
I61V-悲惨者的颅骨*/
set this = CreateEquipType('I61V',7,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_BLOCK,STATE_MODE_INT,18,ST_LIFE,STATE_MODE_INT,90,ST_RESISTANCE,STATE_MODE_PERCENTAGE,200,ST_LEECH,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
call this.addPreDmg_T( function ItemSFX_ArcaneDefense )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+18 格挡\n+90 生命\n|cff20c000+2%% 法术抗性|r\n|cff20c000+2%% 吸血|r\n|cffffcc00效果：|r\n|cff20c000咒术防御：|r受到法术伤害前，有20%%的几率使你的法术抗性提高15%%，持续10秒。触发后有10秒冷却时间。"
set this.name = "|cff0070dd悲惨者的颅骨|r\n\n[盾·轻]副手 - 等级7"
set this.inSet = 0
/*"
"
I61W-尸骸巨盾*/
set this = CreateEquipType('I61W',7,4,0,ST_ARMOR,STATE_MODE_INT,7,ST_BLOCK,STATE_MODE_INT,27,ST_LIFE_REGEN,STATE_MODE_REAL,24,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,-1000,ST_BLOCK,STATE_MODE_PERCENTAGE,500,0,0,0,0,0,0)
call this.addDmged_T( function ItemSFX_PerfectVanguard )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+27 格挡\n+0.24 生命恢复\n|cffff0000-10%% 移动速度|r\n|cff20c000+5%% 格挡|r\n|cffffcc00效果：|r\n|cff20c000完美戒卫：|r生命值不低于80%%时，有5%%的几率抵消敌人的攻击(不会受到伤害)。"
set this.name = "|cff0070dd尸骸巨盾|r\n\n[盾·重]副手 - 等级7"
set this.inSet = 0
/*"
"
I61Z-侍僧圆环*/
set this = CreateEquipType('I61Z',7,5,0,ST_LIFE,STATE_MODE_INT,54,ST_MANA,STATE_MODE_INT,7,ST_MANA_REGEN,STATE_MODE_REAL,4,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,120,ST_HEAL_BONUS,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
call this.addAftHeal_S( function ItemSFX_Concerto_Source )
call this.addAftHeal_T( function ItemSFX_Concerto_Target )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+54 生命\n+7 法力\n+0.04 法力恢复\n|cff20c000+1.2%% 法术强度|r\n|cff20c000+1.2%% 治疗加成|r\n|cffffcc00效果：|r\n|cff20c000协奏：|r造成或受到治疗后，有10%%的几率使目标或来源获得相当于治疗量15%%的护盾，持续8秒。"
set this.name = "|cff0070dd侍僧圆环|r\n\n腰带 - 等级7"
set this.inSet = 0
/*"
"
I621-食尸鬼臂章*/
set this = CreateEquipType('I621',7,4,0,ST_ATTACK,STATE_MODE_INT,6,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_INT,3,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,120,ST_HASTE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
call this.addAtking( function ItemSFX_Frenzy )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 攻击\n+3%% 攻击速度\n+3 护甲穿透\n|cff20c000+1.2%% 暴击|r\n|cff20c000+1.2%% 急速|r\n|cffffcc00效果：|r\n|cff20c000狂化：|r攻击时有15%%的几率在10秒内提高自身20%%的攻击速度。触发后有20秒冷却时间。"
set this.name = "|cff0070dd食尸鬼臂章|r\n\n手套 - 等级7"
set this.inSet = 0
/*"
"
I622-死灵护手*/
set this = CreateEquipType('I622',7,4,0,ST_ARMOR,STATE_MODE_INT,2,ST_BLOCK,STATE_MODE_INT,5,ST_ACCURACY,STATE_MODE_PERCENTAGE,219,ST_BLOCK,STATE_MODE_PERCENTAGE,240,0,0,0,0,0,0,0,0,0)
call this.addDmged_T( function ItemSFX_DeflictMissile )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+5 格挡\n+2.19%% 命中\n|cff20c000+2.4%% 格挡|r\n|cffffcc00效果：|r\n|cff20c000拨挡飞弹：|r受到远程攻击时，有5%%的几率使其无效(不会受到伤害)。"
set this.name = "|cff0070dd死灵护手|r\n\n手套 - 等级7"
set this.inSet = 0
/*"
"
I61Y-侍僧兜帽*/
set this = CreateEquipType('I61Y',7,2,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,63,ST_INT,STATE_MODE_INT,5,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_DAMAGE_BONUS,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
call this.addSpelling( function ItemSFX_MagicCircuit )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+63 生命\n+5 智力\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 伤害加成|r\n|cffffcc00效果：|r\n|cff20c000魔力回路：|r施法时，有10%%的几率立即恢复最大值1%%的法力。"
set this.name = "|cff0070dd侍僧兜帽|r\n\n[轻]头盔 - 等级7"
set this.inSet = 0
/*"
"
I61X-几丁质护胫*/
set this = CreateEquipType('I61X',7,4,0,ST_ARMOR,STATE_MODE_INT,5,ST_MOVE_SPEED,STATE_MODE_INT,14,ST_BLOCK,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_PERCENTAGE,140,ST_EVADE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
call this.addAtked_T( function ItemSFX_Entrenching )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+14 移动速度\n+6 格挡\n|cff20c000+1.4%% 生命|r\n|cff20c000+1.4%% 闪避|r\n|cffffcc00效果：|r\n|cff20c000陷地：|r被近战击中时，有20%%的几率使其攻击和移动速度降低15%%，持续5秒。"
set this.name = "|cff0070dd几丁质护胫|r\n\n[重]鞋 - 等级7"
set this.inSet = 0
/*"
"
I620-魔皮束带*/
set this = CreateEquipType('I620',7,5,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,54,ST_AGI,STATE_MODE_INT,4,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,120,ST_EVADE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
call this.addPreDmg_S( function ItemSFX_ElementalEmpowerment )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+54 生命\n+4 敏捷\n|cff20c000+1.2%% 暴击|r\n|cff20c000+1.2%% 闪避|r\n|cffffcc00效果：|r\n|cff20c000元素加护：|r造成非元素的伤害时，有50%%的几率随机赋予一种元素，并使其伤害提高2%%[x]。"
set this.name = "|cff0070dd魔皮束带|r\n\n腰带 - 等级7"
set this.inSet = 0
/*"
"
I61S-觅心弩*/
set this = CreateEquipType('I61S',8,2,0,ST_ATTACK,STATE_MODE_INT,22,ST_MAIN,STATE_MODE_INT,14,ST_ARMOR_PEN,STATE_MODE_INT,10,ST_MAIN,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addDmging_S( function ItemSFX_GiantSlayer )
call this.addAtking( function ItemSFX_Combo )
set this.insc = "\n\n|cff888888一击而中。|r"
set this.desc = "|cffffcc00属性：|r\n+22 攻击\n+14 主属性\n+10 护甲穿透\n|cff20c000+3%% 主属性|r\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 急速|r\n|cffffcc00效果：|r\n|cff20c000巨人杀手：|r对生命高于70%%的目标造成的伤害提高10%%[x]。\n|cff20c000连击：|r连续攻击同一个目标时，攻击力提升0.5%%，可叠加10次。"
set this.name = "|cffa334ee觅心弩|r\n\n[远]武器 - 等级8"
set this.inSet = 0
/*"
"
I602-灼热之石*/
set this = CreateEquipType('I602',3,1,'AA01',ST_ATTACK,STATE_MODE_INT,9,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_ACCURACY,STATE_MODE_PERCENTAGE,480,ST_HASTE,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 攻击\n+7.5%% 攻击速度\n+4.8%% 命中\n|cff20c000+1.5%% 急速|r|N|cffffcc00赋予技能：|r|n|cff20c000火焰附魔：|r在一段时间内提高攻击力，并使自动攻击附加火焰元素。 "
set this.name = "|cff20c000灼热之石|r\n\n护符 - 等级3"
set this.inSet = 0
/*"
"
I60M-疗愈之石*/
set this = CreateEquipType('I60M',3,1,'AA02',ST_ABILITY_POWER,STATE_MODE_INT,9,ST_MANA,STATE_MODE_INT,11,ST_MANA_REGEN,STATE_MODE_REAL,9,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 法术强度\n+11 法力\n+0.09 法力恢复\n|cff20c000+3%% 暴击伤害|r|N|cffffcc00赋予技能：|r|n|cff20c000自我疗愈：|r立即为自己恢复生命值与法力值。"
set this.name = "|cff20c000疗愈之石|r\n\n护符 - 等级3"
set this.inSet = 0
/*"
"
I61I-硬化之石*/
set this = CreateEquipType('I61I',3,1,'AA03',ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,54,ST_LIFE_REGEN,STATE_MODE_REAL,22,ST_LIFE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+54 生命\n+0.22 生命恢复\n|cff20c000+3%% 生命|r|N|cffffcc00赋予技能：|r|n|cff20c000硬化护甲：|r在短时间内提高护甲和抗性。"
set this.name = "|cff20c000硬化之石|r\n\n护符 - 等级3"
set this.inSet = 0
/*"
"
I61D-烟尘法袍*/
set this = CreateEquipType('I61D',5,2,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,81,ST_INT,STATE_MODE_INT,7,ST_MANA,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+81 生命\n+7 智力\n|cff20c000+3%% 法力|r"
set this.name = "|cff20c000烟尘法袍|r\n\n[轻]护甲 - 等级5"
set this.inSet = 0
/*"
"
I61F-野性甲胄*/
set this = CreateEquipType('I61F',5,3,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,89,ST_AGI,STATE_MODE_INT,7,ST_EVADE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+89 生命\n+7 敏捷\n|cff20c000+3%% 闪避|r"
set this.name = "|cff20c000野性甲胄|r\n\n[中]护甲 - 等级5"
set this.inSet = 0
/*"
"
I623-干苔外套*/
set this = CreateEquipType('I623',5,3,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,89,ST_INT,STATE_MODE_INT,7,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+89 生命\n+7 智力\n|cff20c000+3%% 法术强度|r"
set this.name = "|cff20c000干苔外套|r\n\n[中]护甲 - 等级5"
set this.inSet = 0
/*"
"
I624-精兵护甲*/
set this = CreateEquipType('I624',5,4,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,89,ST_STR,STATE_MODE_INT,7,ST_BLOCK,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+89 生命\n+7 力量\n|cff20c000+3%% 格挡|r"
set this.name = "|cff20c000精兵护甲|r\n\n[重]护甲 - 等级5"
set this.inSet = 0
/*"
"
I625-止水胸甲*/
set this = CreateEquipType('I625',5,4,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,89,ST_MANA,STATE_MODE_INT,13,ST_INT,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+89 生命\n+13 法力\n|cff20c000+3%% 智力|r"
set this.name = "|cff20c000止水胸甲|r\n\n[重]护甲 - 等级5"
set this.inSet = 0
/*"
"
I626-棉布长袍*/
set this = CreateEquipType('I626',3,2,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,36,ST_INT,STATE_MODE_INT,4,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+36 生命\n+4 智力"
set this.name = "|cffffffff棉布长袍|r\n\n[轻]护甲 - 等级3"
set this.inSet = 0
/*"
"
I600-钢铁盔帽*/
set this = CreateEquipType('I600',3,4,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,18,ST_BLOCK,STATE_MODE_INT,2,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+18 生命\n+2 格挡"
set this.name = "|cffffffff钢铁盔帽|r\n\n[重]头盔 - 等级3"
set this.inSet = 0
/*"
"
I607-制式皮靴*/
set this = CreateEquipType('I607',3,3,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,18,ST_MOVE_SPEED,STATE_MODE_INT,14,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+18 生命\n+14 移动速度"
set this.name = "|cffffffff制式皮靴|r\n\n[中]鞋 - 等级3"
set this.inSet = 0
/*"
"
I627-列兵徽记*/
set this = CreateEquipType('I627',3,2,0,ST_STR,STATE_MODE_INT,2,ST_AGI,STATE_MODE_INT,2,ST_INT,STATE_MODE_INT,2,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 力量\n+2 敏捷\n+2 智力"
set this.name = "|cffffffff列兵徽记|r\n\n戒指 - 等级3"
set this.inSet = 0
/*"
"
I628-铜制护腕*/
set this = CreateEquipType('I628',3,4,0,ST_ARMOR,STATE_MODE_INT,1,ST_BLOCK,STATE_MODE_INT,2,ST_ACCURACY,STATE_MODE_PERCENTAGE,186,0,0,0,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+1 护甲\n+2 格挡\n+1.86%% 命中"
set this.name = "|cffffffff铜制护腕|r\n\n手套 - 等级3"
set this.inSet = 0
/*"
"
I629-覆网之戒*/
set this = CreateEquipType('I629',4,2,0,ST_ABILITY_POWER,STATE_MODE_INT,6,ST_AGI,STATE_MODE_INT,4,ST_INT,STATE_MODE_INT,4,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 法术强度\n+4 敏捷\n+4 智力\n|cff20c000+2%% 法力|r"
set this.name = "|cff20c000覆网之戒|r\n\n戒指 - 等级4"
set this.inSet = 0
/*"
"
I62A-蛛丝裹手*/
set this = CreateEquipType('I62A',4,4,0,ST_AGI,STATE_MODE_INT,2,ST_INT,STATE_MODE_INT,2,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,300,ST_MANA,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 敏捷\n+2 智力\n+3%% 攻击速度\n|cff20c000+1.2%% 法力|r"
set this.name = "|cff20c000蛛丝裹手|r\n\n手套 - 等级4"
set this.inSet = 0
/*"
"
I62B-毒牙*/
set this = CreateEquipType('I62B',4,1,0,ST_ATTACK,STATE_MODE_INT,9,ST_AGI,STATE_MODE_INT,6,ST_ARMOR_PEN,STATE_MODE_INT,5,ST_LEECH,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 攻击\n+6 敏捷\n+5 护甲穿透\n|cff20c000+3%% 吸血|r"
set this.name = "|cff20c000毒牙|r\n\n[近]武器 - 等级4"
set this.inSet = 0
/*"
"
I62C-白骨之盾*/
set this = CreateEquipType('I62C',6,4,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,60,ST_BLOCK,STATE_MODE_INT,19,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,-1000,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+60 生命\n+19 格挡\n|cffff0000-10%% 移动速度|r"
set this.name = "|cff20c000白骨之盾|r\n\n[盾·重]副手 - 等级6"
set this.inSet = 0
/*"
"
I62D-亡者之眼*/
set this = CreateEquipType('I62D',6,1,0,ST_ABILITY_POWER,STATE_MODE_INT,8,ST_MANA,STATE_MODE_INT,9,ST_INT,STATE_MODE_INT,5,ST_COST_REDUCE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 法术强度\n+9 法力\n+5 智力\n|cff20c000+2%% 节能施法|r"
set this.name = "|cff20c000亡者之眼|r\n\n副手 - 等级6"
set this.inSet = 0
/*"
"
I62E-幽灵束带*/
set this = CreateEquipType('I62E',6,5,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,36,ST_AGI,STATE_MODE_INT,3,ST_HASTE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+36 生命\n+3 敏捷\n|cff20c000+1.2%% 急速|r"
set this.name = "|cff20c000幽灵束带|r\n\n腰带 - 等级6"
set this.inSet = 0
/*"
"
I62F-鲍比的聪明盾*/
set this = CreateEquipType('I62F',4,3,0,ST_ARMOR,STATE_MODE_INT,4,ST_INT,STATE_MODE_INT,4,ST_MANA,STATE_MODE_INT,8,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0,0,0,0)
set this.insc = "\n\n|cff888888它将一切视为它“聪明”的杰作。|r"
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+4 智力\n+8 法力\n|cff20c000+2%% 法术强度|r"
set this.name = "|cff20c000鲍比的聪明盾|r\n\n[盾·轻]副手 - 等级4"
set this.inSet = 0
/*"
"
I62G-鲍比的投机帽*/
set this = CreateEquipType('I62G',8,2,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,60,ST_INT,STATE_MODE_INT,4,ST_MANA,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0,0,0,0)
set this.insc = "\n\n|cff888888投机让它发家，利益滋生贪欲和不法。|r"
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+60 生命\n+4 智力\n|cff20c000+1.4%% 法力|r"
set this.name = "|cff20c000鲍比的投机帽|r\n\n[轻]头盔 - 等级8"
set this.inSet = 0
/*"
"
I62H-鲍比的奴役圈*/
set this = CreateEquipType('I62H',11,3,0,ST_ABILITY_POWER,STATE_MODE_INT,16,ST_MANA,STATE_MODE_INT,16,ST_MANA_REGEN,STATE_MODE_REAL,9,ST_INT,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
call this.addDmging_S( function ItemSFX_EnhanceShadow )
set this.insc = "\n\n|cff888888它将所有人都视为奴隶和工作机器。|r"
set this.desc = "|cffffcc00属性：|r\n+16 法术强度\n+16 法力\n+0.09 法力恢复\n|cff20c000+2%% 智力|r\n|cff20c000+2%% 法力|r\n|cffffcc00效果：|r\n|cff20c000暗影增效：|r暗影伤害提高3%%[x]。"
set this.name = "|cff0070dd鲍比的奴役圈|r\n\n[唯一]戒指 - 等级11"
set this.inSet = 0
/*"
"
I62I-巨魔长矛*/
set this = CreateEquipType('I62I',4,1,0,ST_ATTACK,STATE_MODE_INT,14,ST_AGI,STATE_MODE_INT,9,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,-2250,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = "\n\n|cff888888本来是拿来扔的，可惜只有巨魔那样壮硕的身材才可以投掷，还是拿在手上吧|r"
set this.desc = "|cffffcc00属性：|r\n+14 攻击\n+9 敏捷\n|cffff0000-22.5%% 攻击速度|r\n|cff20c000+3%% 暴击|r"
set this.name = "|cff20c000巨魔长矛|r\n\n[近]武器 - 等级4"
set this.inSet = 0
/*"
"
I62J-巫术法典*/
set this = CreateEquipType('I62J',6,1,0,ST_ABILITY_POWER,STATE_MODE_INT,8,ST_MANA,STATE_MODE_INT,9,ST_INT,STATE_MODE_INT,5,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 法术强度\n+9 法力\n+5 智力\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000巫术法典|r\n\n副手 - 等级6"
set this.inSet = 0
/*"
"
I62K-几丁质甲壳*/
set this = CreateEquipType('I62K',6,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,99,ST_MAIN,STATE_MODE_INT,8,ST_RESISTANCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+99 生命\n+8 主属性\n|cff20c000+3%% 法术抗性|r"
set this.name = "|cff20c000几丁质甲壳|r\n\n[中]护甲 - 等级6"
set this.inSet = 0
/*"
"
I62L-毒腺*/
set this = CreateEquipType('I62L',4,1,0,ST_INT,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,42,ST_MANA,STATE_MODE_INT,8,ST_RESISTANCE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 智力\n+42 生命\n+8 法力\n|cff20c000+2%% 法术抗性|r"
set this.name = "|cff20c000毒腺|r\n\n副手 - 等级4"
set this.inSet = 0
/*"
"
I62M-朽坏之刃*/
set this = CreateEquipType('I62M',6,1,0,ST_ATTACK,STATE_MODE_INT,12,ST_STR,STATE_MODE_INT,8,ST_ACCURACY,STATE_MODE_PERCENTAGE,510,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 攻击\n+8 力量\n+5.1%% 命中\n|cff20c000+6%% 暴击伤害|r"
set this.name = "|cff20c000朽坏之刃|r\n\n[近]武器 - 等级6"
set this.inSet = 0
/*"
"
I62N-半人马战斧*/
set this = CreateEquipType('I62N',8,1,0,ST_ATTACK,STATE_MODE_INT,15,ST_AGI,STATE_MODE_INT,9,ST_ARMOR_PEN,STATE_MODE_INT,7,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+15 攻击\n+9 敏捷\n+7 护甲穿透\n|cff20c000+3%% 急速|r"
set this.name = "|cff20c000半人马战斧|r\n\n[近]武器 - 等级8"
set this.inSet = 0
/*"
"
I62O-防沙皮甲*/
set this = CreateEquipType('I62O',8,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,128,ST_AGI,STATE_MODE_INT,9,ST_EVADE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+128 生命\n+9 敏捷\n|cff20c000+3%% 闪避|r"
set this.name = "|cff20c000防沙皮甲|r\n\n[中]护甲 - 等级8"
set this.inSet = 0
/*"
"
I62P-沙丘战甲*/
set this = CreateEquipType('I62P',8,4,0,ST_ARMOR,STATE_MODE_INT,10,ST_LIFE,STATE_MODE_INT,128,ST_BLOCK,STATE_MODE_INT,12,ST_ARMOR,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+10 护甲\n+128 生命\n+12 格挡\n|cff20c000+3%% 护甲|r"
set this.name = "|cff20c000沙丘战甲|r\n\n[重]护甲 - 等级8"
set this.inSet = 0
/*"
"
I62Q-射手扳指*/
set this = CreateEquipType('I62Q',8,2,0,ST_AGI,STATE_MODE_INT,6,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ACCURACY,STATE_MODE_PERCENTAGE,355,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 敏捷\n+5%% 攻击速度\n+3.55%% 命中\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000射手扳指|r\n\n戒指 - 等级8"
set this.inSet = 0
/*"
"
I62R-地狱足迹*/
set this = CreateEquipType('I62R',7,2,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,63,ST_MOVE_SPEED,STATE_MODE_INT,14,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,140,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,280,0,0,0)
call this.addDmging_S( function ItemSFX_EnhanceFire )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+63 生命\n+14 移动速度\n|cff20c000+1.4%% 法术强度|r\n|cff20c000+1.4%% 法力|r\n|cff20c000+2.8%% 暴击伤害|r\n|cffffcc00效果：|r\n|cff20c000火焰增效：|r火焰伤害提高3%%[x]。"
set this.name = "|cff0070dd地狱足迹|r\n\n[轻]鞋 - 等级7"
set this.inSet = 0
/*"
"
I62S-使徒镰刀*/
set this = CreateEquipType('I62S',7,5,0,ST_ABILITY_POWER,STATE_MODE_INT,17,ST_INT,STATE_MODE_INT,11,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,ST_LEECH,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAtking( function ItemSFX_Corruption )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+17 法术强度\n+11 智力\n+7.5%% 攻击速度\n|cff20c000+3%% 法术强度|r\n|cff20c000+3%% 急速|r\n|cff20c000+3%% 吸血|r\n|cffffcc00效果：|r\n|cff20c000腐蚀术：|r攻击时，有15%%的几率在12秒内造成法术强度72%%的法术伤害(暗影)。"
set this.name = "|cff0070dd使徒镰刀|r\n\n[近|法]武器 - 等级7"
set this.inSet = 0
/*"
"
I62T-恶魔符印*/
set this = CreateEquipType('I62T',7,1,'AA04',ST_ATTACK,STATE_MODE_INT,17,ST_STR,STATE_MODE_INT,11,ST_ARMOR_PEN,STATE_MODE_INT,8,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,ST_EVADE,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addDmging_S( function ItemSFX_ElementTuning )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+17 攻击\n+11 力量\n+8 护甲穿透\n|cff20c000+3%% 暴击|r\n|cff20c000+6%% 暴击伤害|r\n|cff20c000+3%% 闪避|r\n|cffffcc00效果：|r\n|cff20c000元素调谐：|r造成的元素伤害提高2%%[x]。|N|cffffcc00赋予技能：|r|n|cff20c000静默射线：|r沉默目标，并造成法术伤害。"
set this.name = "|cff0070dd恶魔符印|r\n\n护符 - 等级7"
set this.inSet = 0
/*"
"
I62U-雪怪之角*/
set this = CreateEquipType('I62U',8,4,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,60,ST_STR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+60 生命\n+4 力量\n|cff20c000+1.4%% 生命|r"
set this.name = "|cff20c000雪怪之角|r\n\n[重]头盔 - 等级8"
set this.inSet = 0
/*"
"
I62V-霜雪护身符*/
set this = CreateEquipType('I62V',8,1,'AA05',ST_LIFE,STATE_MODE_INT,117,ST_AGI,STATE_MODE_INT,9,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_AGI,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+117 生命\n+9 敏捷\n+7.5%% 攻击速度\n|cff20c000+3%% 敏捷|r|N|cffffcc00赋予技能：|r|n|cff20c000净化：|r造成范围法术伤害，并驱散敌人的增益效果。"
set this.name = "|cff20c000霜雪护身符|r\n\n护符 - 等级8"
set this.inSet = 0
/*"
"
I62W-霜晶指环*/
set this = CreateEquipType('I62W',8,2,0,ST_ABILITY_POWER,STATE_MODE_INT,10,ST_MANA,STATE_MODE_INT,11,ST_MANA_REGEN,STATE_MODE_REAL,7,ST_HEAL_BONUS,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+10 法术强度\n+11 法力\n+0.07 法力恢复\n|cff20c000+2%% 治疗加成|r"
set this.name = "|cff20c000霜晶指环|r\n\n戒指 - 等级8"
set this.inSet = 0
/*"
"
I62X-蛮牛铁盔*/
set this = CreateEquipType('I62X',7,4,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,69,ST_STR,STATE_MODE_INT,5,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,ST_LIFE_REGEN,STATE_MODE_PERCENTAGE,350,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,280,0,0,0)
call this.addPreDmg_S( function ItemSFX_Crush )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+69 生命\n+5 力量\n|cff20c000+1.4%% 法术抗性|r\n|cff20c000+3.5%% 生命恢复|r\n|cff20c000+2.8%% 暴击伤害|r\n|cffffcc00效果：|r\n|cff20c000粉碎：|r攻击有25%%的几率无视目标50%%[x]的护甲。"
set this.name = "|cff0070dd蛮牛铁盔|r\n\n[重]头盔 - 等级7"
set this.inSet = 0
/*"
"
I62Y-收获腰带*/
set this = CreateEquipType('I62Y',7,5,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,46,ST_STR,STATE_MODE_INT,3,ST_ARMOR,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+46 生命\n+3 力量\n|cff20c000+1.2%% 护甲|r"
set this.name = "|cff20c000收获腰带|r\n\n腰带 - 等级7"
set this.inSet = 0
/*"
"
I62Z-旅者腰带*/
set this = CreateEquipType('I62Z',7,5,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,46,ST_INT,STATE_MODE_INT,3,ST_MANA,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+46 生命\n+3 智力\n|cff20c000+1.2%% 法力|r"
set this.name = "|cff20c000旅者腰带|r\n\n腰带 - 等级7"
set this.inSet = 0
/*"
"
I630-风牛“指”环*/
set this = CreateEquipType('I630',7,2,0,ST_MAIN,STATE_MODE_INT,6,ST_LIFE_REGEN,STATE_MODE_REAL,22,ST_MANA_REGEN,STATE_MODE_REAL,7,ST_HEAL_BONUS,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0,0,0,0)
set this.insc = "\n\n|cff888888风牛部落的人都戴在鼻子上|r"
set this.desc = "|cffffcc00属性：|r\n+6 主属性\n+0.22 生命恢复\n+0.07 法力恢复\n|cff20c000+2%% 治疗加成|r"
set this.name = "|cff20c000风牛“指”环|r\n\n戒指 - 等级7"
set this.inSet = 0
/*"
"
I631-风牛行者图腾*/
set this = CreateEquipType('I631',7,1,0,ST_LIFE,STATE_MODE_INT,90,ST_MANA,STATE_MODE_INT,12,ST_LIFE_REGEN,STATE_MODE_REAL,24,ST_HEAL_BONUS,STATE_MODE_PERCENTAGE,200,ST_LIFE,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addEquipOn( function ItemSFX_EnduranceAura_On )
call this.addTakeOff( function ItemSFX_EnduranceAura_Off )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+90 生命\n+12 法力\n+0.24 生命恢复\n|cff20c000+2%% 治疗加成|r\n|cff20c000+2%% 生命|r\n|cff20c000+2%% 急速|r\n|cffffcc00效果：|r\n|cff20c000耐久光环：|r为范围内的盟友提高5%%的移动速度。"
set this.name = "|cff0070dd风牛行者图腾|r\n\n副手 - 等级7"
set this.inSet = 0
/*"
"
I632-风牛祭祀之鼓*/
set this = CreateEquipType('I632',7,1,0,ST_LIFE,STATE_MODE_INT,90,ST_MANA,STATE_MODE_INT,12,ST_MANA_REGEN,STATE_MODE_REAL,7,ST_HEAL_BONUS,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addEquipOn( function ItemSFX_BrillianceAura_On )
call this.addTakeOff( function ItemSFX_BrillianceAura_Off )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+90 生命\n+12 法力\n+0.07 法力恢复\n|cff20c000+2%% 治疗加成|r\n|cff20c000+2%% 法力|r\n|cff20c000+2%% 急速|r\n|cffffcc00效果：|r\n|cff20c000辉煌光环：|r为范围内的盟友每5秒恢复1%%的法力。"
set this.name = "|cff0070dd风牛祭祀之鼓|r\n\n副手 - 等级7"
set this.inSet = 0
/*"
"
I633-牛头人战戟*/
set this = CreateEquipType('I633',8,1,0,ST_ATTACK,STATE_MODE_INT,22,ST_STR,STATE_MODE_INT,14,ST_ARMOR_PEN,STATE_MODE_INT,10,ST_STR,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_LEECH,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAtked_S( function ItemSFX_Bash )
call this.addDmging_S( function ItemSFX_Execution )
set this.insc = "\n\n|cff888888巨大的武器，只是看着就很有压迫感|r"
set this.desc = "|cffffcc00属性：|r\n+22 攻击\n+14 力量\n+10 护甲穿透\n|cff20c000+3%% 力量|r\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 吸血|r\n|cffffcc00效果：|r\n|cff20c000重击：|r击中时有15%%的几率额外造成20%%[x]的伤害。\n|cff20c000斩杀：|r对生命低于30%%的目标造成的伤害提高10%%[x]。"
set this.name = "|cffa334ee牛头人战戟|r\n\n[近]武器 - 等级8"
set this.inSet = 0
/*"
"
I634-火焰头巾*/
set this = CreateEquipType('I634',12,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,115,ST_AGI,STATE_MODE_INT,7,ST_HASTE,STATE_MODE_PERCENTAGE,140,ST_EVADE,STATE_MODE_PERCENTAGE,140,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,0,0,0)
call this.addBefDmg_T( function ItemSFX_Cushioning2 )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+115 生命\n+7 敏捷\n|cff20c000+1.4%% 急速|r\n|cff20c000+1.4%% 闪避|r\n|cff20c000+1.4%% 法术抗性|r\n|cffffcc00效果：|r\n|cff20c000缓震(II)：|r受到的任何伤害降低5%%，不超过10点。"
set this.name = "|cff0070dd火焰头巾|r\n\n[中]头盔 - 等级12"
set this.inSet = 0
/*"
"
I635-燎原足迹*/
set this = CreateEquipType('I635',12,4,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,115,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_LIFE,STATE_MODE_PERCENTAGE,140,ST_STR,STATE_MODE_PERCENTAGE,140,ST_BLOCK,STATE_MODE_PERCENTAGE,140,0,0,0)
call this.addPreDmg_T( function ItemSFX_Barrier )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+115 生命\n+15 移动速度\n|cff20c000+1.4%% 生命|r\n|cff20c000+1.4%% 力量|r\n|cff20c000+1.4%% 格挡|r\n|cffffcc00效果：|r\n|cff20c000壁垒：|r有10%%的几率使你的格挡效果提高20%%。"
set this.name = "|cff0070dd燎原足迹|r\n\n[重]鞋 - 等级12"
set this.inSet = 0
/*"
"
I636-赤晶坠饰*/
set this = CreateEquipType('I636',12,1,'AA06',ST_ABILITY_POWER,STATE_MODE_INT,26,ST_MANA,STATE_MODE_INT,25,ST_MANA_REGEN,STATE_MODE_REAL,14,ST_MANA_REGEN,STATE_MODE_PERCENTAGE,750,ST_INT,STATE_MODE_PERCENTAGE,300,ST_COST_REDUCE,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addSpelling( function ItemSFX_Warm )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+26 法术强度\n+25 法力\n+0.14 法力恢复\n|cff20c000+7.5%% 法力恢复|r\n|cff20c000+3%% 智力|r\n|cff20c000+3%% 节能施法|r\n|cffffcc00效果：|r\n|cff20c000火暖身：|r施法时，每5秒恢复0.4%%的法力值，持续10秒，可叠加3次。|N|cffffcc00赋予技能：|r|n|cff20c000火焰冲击：|r造成法术伤害，并击晕目标。"
set this.name = "|cff0070dd赤晶坠饰|r\n\n护符 - 等级12"
set this.inSet = 0
/*"
"
I637-不灭的防御碎片*/
set this = CreateEquipType('I637',12,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE_REGEN,STATE_MODE_REAL,34,ST_BLOCK,STATE_MODE_INT,14,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_LIFE,STATE_MODE_PERCENTAGE,200,ST_BLOCK,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addDmged_T( function ItemSFX_Parry )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+0.34 生命恢复\n+14 格挡\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 生命|r\n|cff20c000+2%% 格挡|r\n|cffffcc00效果：|r\n|cff20c000招架：|r面向敌人时，有5%%的几率招架敌人的攻击(不会受到伤害)。"
set this.name = "|cff0070dd不灭的防御碎片|r\n\n[唯一]戒指 - 等级12"
set this.inSet = 0
/*"
"
I638-不灭的精华碎片*/
set this = CreateEquipType('I638',12,3,0,ST_ABILITY_POWER,STATE_MODE_INT,17,ST_MANA,STATE_MODE_INT,17,ST_MANA_REGEN,STATE_MODE_REAL,9,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_HEAL_BONUS,STATE_MODE_PERCENTAGE,200,ST_SHIELD_BONUS,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addHealing_S( function ItemSFX_EnhanceHeal )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+17 法术强度\n+17 法力\n+0.09 法力恢复\n|cff20c000+2%% 法力|r\n|cff20c000+2%% 治疗加成|r\n|cff20c000+2%% 护盾加成|r\n|cffffcc00效果：|r\n|cff20c000治疗增效：|r造成的治疗效果提高3%%[x]。"
set this.name = "|cff0070dd不灭的精华碎片|r\n\n[唯一]戒指 - 等级12"
set this.inSet = 0
/*"
"
I639-不灭的威胁碎片*/
set this = CreateEquipType('I639',12,3,0,ST_ATTACK,STATE_MODE_INT,17,ST_ARMOR_PEN,STATE_MODE_INT,8,ST_ACCURACY,STATE_MODE_PERCENTAGE,415,ST_STR,STATE_MODE_PERCENTAGE,200,ST_AGI,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addPreDmg_S( function ItemSFX_Shatter )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+17 攻击\n+8 护甲穿透\n+4.15%% 命中\n|cff20c000+2%% 力量|r\n|cff20c000+2%% 敏捷|r\n|cff20c000+2%% 暴击|r\n|cffffcc00效果：|r\n|cff20c000破灭：|r造成伤害时，无视目标20%%的护甲与抗性。"
set this.name = "|cff0070dd不灭的威胁碎片|r\n\n[唯一]戒指 - 等级12"
set this.inSet = 0
/*"
"
I63A-毁灭王冠*/
set this = CreateEquipType('I63A',12,2,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,126,ST_INT,STATE_MODE_INT,9,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,280,0,0,0)
call this.addDmged_S( function ItemSFX_CritEnhancement )
call this.addPreDmg_S( function ItemSFX_MagicPenetration )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+126 生命\n+9 智力\n|cff20c000+1.4%% 法术强度|r\n|cff20c000+1.4%% 暴击|r\n|cff20c000+2.8%% 暴击伤害|r\n|cffffcc00效果：|r\n|cff20c000致命增效：|r造成暴击伤害时，伤害提高6%%[x]。\n|cff20c000魔法穿透：|r造成的伤害忽略目标25%%[x]的抗性。"
set this.name = "|cffa334ee毁灭王冠|r\n\n[轻]头盔 - 等级12"
set this.inSet = 0
/*"
"
I63B-炎魔长棍*/
set this = CreateEquipType('I63B',12,1,0,ST_ATTACK,STATE_MODE_INT,30,ST_AGI,STATE_MODE_INT,20,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAtked_S( function ItemSFX_FireSlam )
call this.addAtked_S( function ItemSFX_Cleave )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+30 攻击\n+20 敏捷\n+7.5%% 攻击速度\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 急速|r\n|cffffcc00效果：|r\n|cff20c000火焰猛击：|r击中时，有15%%的几率绽开火焰，对目标造成攻击力25%%-30%%的法术伤害(火焰)。\n|cff20c000顺势斩：|r击中时，有33%%的几率对附近的其他敌人造成30%%的物理伤害。"
set this.name = "|cffa334ee炎魔长棍|r\n\n[近]武器 - 等级12"
set this.inSet = 0
/*"
"
I63C-炎魔镣铐*/
set this = CreateEquipType('I63C',12,1,0,ST_ATTACK,STATE_MODE_INT,30,ST_STR,STATE_MODE_INT,20,ST_ARMOR_PEN,STATE_MODE_INT,13,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAtked_S( function ItemSFX_FireSlam )
call this.addAtked_S( function ItemSFX_Cleave )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+30 攻击\n+20 力量\n+13 护甲穿透\n|cff20c000+3%% 攻击|r\n|cff20c000+6%% 暴击伤害|r\n|cff20c000+3%% 护甲穿透|r\n|cffffcc00效果：|r\n|cff20c000火焰猛击：|r击中时，有15%%的几率绽开火焰，对目标造成攻击力25%%-30%%的法术伤害(火焰)。\n|cff20c000顺势斩：|r击中时，有33%%的几率对附近的其他敌人造成30%%的物理伤害。"
set this.name = "|cffa334ee炎魔镣铐|r\n\n[近]武器 - 等级12"
set this.inSet = 0
/*"
"
I63D-凝火宝珠*/
set this = CreateEquipType('I63D',12,1,0,ST_ABILITY_POWER,STATE_MODE_INT,20,ST_LIFE,STATE_MODE_INT,180,ST_INT,STATE_MODE_INT,13,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_MANA_REGEN,STATE_MODE_PERCENTAGE,500,ST_RESISTANCE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addSpelling( function ItemSFX_ArcaneResonance )
call this.addAftHeal_S( function ItemSFX_InnerFire )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+20 法术强度\n+180 生命\n+13 智力\n|cff20c000+2%% 法力|r\n|cff20c000+5%% 法力恢复|r\n|cff20c000+2%% 法术抗性|r\n|cffffcc00效果：|r\n|cff20c000奥术共鸣：|r施法时有15%%的几率恢复所消耗法力的20%%。\n|cff20c000心灵之火：|r造成治疗时，有15%%的几率使目标盟友的护甲提高10%%，持续10秒。"
set this.name = "|cffa334ee凝火宝珠|r\n\n副手 - 等级12"
set this.inSet = 0
/*"
"
I63E-践雪龙趾*/
set this = CreateEquipType('I63E',12,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,115,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_LIFE,STATE_MODE_PERCENTAGE,140,ST_AGI,STATE_MODE_PERCENTAGE,140,ST_EVADE,STATE_MODE_PERCENTAGE,140,0,0,0)
call this.addSpelling( function ItemSFX_MythStep )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+115 生命\n+15 移动速度\n|cff20c000+1.4%% 生命|r\n|cff20c000+1.4%% 敏捷|r\n|cff20c000+1.4%% 闪避|r\n|cffffcc00效果：|r\n|cff20c000魔力脚步：|r施法时有15%%的几率使移动速度提高10%%，持续5秒。"
set this.name = "|cff0070dd践雪龙趾|r\n\n[中]鞋 - 等级12"
set this.inSet = 0
/*"
"
I63F-蓝龙大颚*/
set this = CreateEquipType('I63F',12,2,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,105,ST_MANA,STATE_MODE_INT,11,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,140,ST_MANA_REGEN,STATE_MODE_PERCENTAGE,350,ST_INT,STATE_MODE_PERCENTAGE,140,0,0,0)
call this.addAftDmg_T( function ItemSFX_Wove )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+105 生命\n+11 法力\n|cff20c000+1.4%% 法术强度|r\n|cff20c000+3.5%% 法力恢复|r\n|cff20c000+1.4%% 智力|r\n|cffffcc00效果：|r\n|cff20c000编织：|r受到伤害后，有10%%的几率生成一个5%%最大生命的护盾，持续5秒。"
set this.name = "|cff0070dd蓝龙大颚|r\n\n[轻]头盔 - 等级12"
set this.inSet = 0
/*"
"
I63G-跃迁刃*/
set this = CreateEquipType('I63G',12,5,0,ST_ABILITY_POWER,STATE_MODE_INT,26,ST_INT,STATE_MODE_INT,17,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_HASTE,STATE_MODE_PERCENTAGE,300,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,300,ST_EVADE,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAtked_S( function ItemSFX_SwordDance )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+26 法术强度\n+17 智力\n+7.5%% 攻击速度\n|cff20c000+3%% 急速|r\n|cff20c000+3%% 移动速度|r\n|cff20c000+3%% 闪避|r\n|cffffcc00效果：|r\n|cff20c000剑舞：|r击中时有5%%的几率造成两次伤害。"
set this.name = "|cff0070dd跃迁刃|r\n\n[近|法]武器 - 等级12"
set this.inSet = 0
/*"
"
I63H-攻击之爪*/
set this = CreateEquipType('I63H',12,2,0,ST_ATTACK,STATE_MODE_INT,17,ST_MAIN,STATE_MODE_INT,11,ST_ARMOR_PEN,STATE_MODE_INT,8,ST_ATTACK,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addAtked_S( function ItemSFX_BackStab )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+17 攻击\n+11 主属性\n+8 护甲穿透\n|cff20c000+2%% 攻击|r\n|cff20c000+2%% 暴击|r\n|cff20c000+2%% 急速|r\n|cffffcc00效果：|r\n|cff20c000背刺：|r在敌人背后时，攻击造成的伤害提高10%%[x]。"
set this.name = "|cff0070dd攻击之爪|r\n\n[武器]副手 - 等级12"
set this.inSet = 0
/*"
"
I63I-龙王大氅*/
set this = CreateEquipType('I63I',12,2,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,247,ST_INT,STATE_MODE_INT,17,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_MANA_REGEN,STATE_MODE_PERCENTAGE,750,ST_INT,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addDmging_S( function ItemSFX_ElementTuning )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+247 生命\n+17 智力\n|cff20c000+3%% 法力|r\n|cff20c000+7.5%% 法力恢复|r\n|cff20c000+3%% 智力|r\n|cffffcc00效果：|r\n|cff20c000元素调谐：|r造成的元素伤害提高2%%[x]。"
set this.name = "|cff0070dd龙王大氅|r\n\n[轻]护甲 - 等级12"
set this.inSet = 0
/*"
"
I63J-龙皮背心*/
set this = CreateEquipType('I63J',12,3,0,ST_ARMOR,STATE_MODE_INT,10,ST_LIFE,STATE_MODE_INT,247,ST_AGI,STATE_MODE_INT,17,ST_ARMOR,STATE_MODE_PERCENTAGE,300,ST_LIFE,STATE_MODE_PERCENTAGE,300,ST_EVADE,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAftDmg_T( function ItemSFX_Firm2 )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+10 护甲\n+247 生命\n+17 敏捷\n|cff20c000+3%% 护甲|r\n|cff20c000+3%% 生命|r\n|cff20c000+3%% 闪避|r\n|cffffcc00效果：|r\n|cff20c000坚定(II)：|r敏捷不低于50时，受到伤害后有20%%的几率驱散自身的一个负面效果。触发后有8秒冷却时间。"
set this.name = "|cff0070dd龙皮背心|r\n\n[中]护甲 - 等级12"
set this.inSet = 0
/*"
"
I63K-守护胸甲*/
set this = CreateEquipType('I63K',12,4,0,ST_ARMOR,STATE_MODE_INT,13,ST_LIFE,STATE_MODE_INT,225,ST_STR,STATE_MODE_INT,17,ST_ARMOR,STATE_MODE_PERCENTAGE,300,ST_STR,STATE_MODE_PERCENTAGE,300,ST_BLOCK,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addPreDmg_T( function ItemSFX_Unbreakable )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+13 护甲\n+225 生命\n+17 力量\n|cff20c000+3%% 护甲|r\n|cff20c000+3%% 力量|r\n|cff20c000+3%% 格挡|r\n|cffffcc00效果：|r\n|cff20c000不屈：|r生命值低于50%%时，格挡效果提高10%%。"
set this.name = "|cff0070dd守护胸甲|r\n\n[重]护甲 - 等级12"
set this.inSet = 0
/*"
"
I63L-魔龙之心*/
set this = CreateEquipType('I63L',12,1,'AA0H',ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,225,ST_LIFE_REGEN,STATE_MODE_REAL,51,ST_LIFE,STATE_MODE_PERCENTAGE,300,ST_LIFE_REGEN,STATE_MODE_PERCENTAGE,750,ST_BLOCK,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addHealing_T( function ItemSFX_VigorousVitality )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+225 生命\n+0.51 生命恢复\n|cff20c000+3%% 生命|r\n|cff20c000+7.5%% 生命恢复|r\n|cff20c000+3%% 格挡|r\n|cffffcc00效果：|r\n|cff20c000旺盛生机：|r生命值低于50%%时，受到的治疗效果提高8%%[x]。|N|cffffcc00赋予技能：|r|n|cff20c000魔龙精气：|r提高生命恢复，持续驱散不效果，并免疫控制效果。"
set this.name = "|cff0070dd魔龙之心|r\n\n护符 - 等级12"
set this.inSet = 0
/*"
"
I63M-魔晶指环*/
set this = CreateEquipType('I63M',12,3,0,ST_LIFE,STATE_MODE_INT,150,ST_MANA,STATE_MODE_INT,17,ST_MANA_REGEN,STATE_MODE_REAL,9,ST_LIFE,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_MANA_REGEN,STATE_MODE_PERCENTAGE,500,0,0,0)
call this.addDmging_T( function ItemSFX_Protect )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+150 生命\n+17 法力\n+0.09 法力恢复\n|cff20c000+2%% 生命|r\n|cff20c000+2%% 法力|r\n|cff20c000+5%% 法力恢复|r\n|cffffcc00效果：|r\n|cff20c000庇护：|r受到的碾压伤害减低10%%[x]。"
set this.name = "|cff0070dd魔晶指环|r\n\n[唯一]戒指 - 等级12"
set this.inSet = 0
/*"
"
I63N-飓风*/
set this = CreateEquipType('I63N',12,2,0,ST_ATTACK,STATE_MODE_INT,30,ST_AGI,STATE_MODE_INT,20,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,0,0,0)
call this.addAtked_S( function ItemSFX_RangedAttack )
call this.addDmged_S( function ItemSFX_CritEnhancement )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+30 攻击\n+20 敏捷\n+7.5%% 攻击速度\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 护甲穿透|r\n|cff20c000+6%% 暴击伤害|r\n|cffffcc00效果：|r\n|cff20c000远距打击：|r与敌人的距离在300以上时，攻击造成的伤害提高10%%[x]。\n|cff20c000致命增效：|r造成暴击伤害时，伤害提高6%%[x]。"
set this.name = "|cffa334ee飓风|r\n\n[远]武器 - 等级12"
set this.inSet = 0
/*"
"
I63O-猎龙*/
set this = CreateEquipType('I63O',12,2,0,ST_ATTACK,STATE_MODE_INT,30,ST_STR,STATE_MODE_INT,20,ST_ACCURACY,STATE_MODE_PERCENTAGE,660,ST_STR,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAtked_S( function ItemSFX_RangedAttack )
call this.addDmged_S( function ItemSFX_CritEnhancement )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+30 攻击\n+20 力量\n+6.6%% 命中\n|cff20c000+3%% 力量|r\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 急速|r\n|cffffcc00效果：|r\n|cff20c000远距打击：|r与敌人的距离在300以上时，攻击造成的伤害提高10%%[x]。\n|cff20c000致命增效：|r造成暴击伤害时，伤害提高6%%[x]。"
set this.name = "|cffa334ee猎龙|r\n\n[远]武器 - 等级12"
set this.inSet = 0
/*"
"
I63P-蓝冰的末日*/
set this = CreateEquipType('I63P',12,3,0,ST_MANA,STATE_MODE_INT,19,ST_MAIN,STATE_MODE_INT,13,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_MAIN,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addDmging_S( function ItemSFX_EnhanceMinion )
call this.addAtking( function ItemSFX_ChargeAttack )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+19 法力\n+13 主属性\n+5%% 攻击速度\n|cff20c000+2%% 法力|r\n|cff20c000+2%% 主属性|r\n|cff20c000+2%% 急速|r\n|cffffcc00效果：|r\n|cff20c000强化仆从：|r召唤物造成的伤害提高3%%[x]。\n|cff20c000充能攻击：|r攻击时，有15%%的几率恢复1%%的法力。"
set this.name = "|cffa334ee蓝冰的末日|r\n\n[唯一]戒指 - 等级12"
set this.inSet = 0
/*"
"
I63Q-守护者短剑*/
set this = CreateEquipType('I63Q',12,1,0,ST_ATTACK,STATE_MODE_INT,30,ST_ARMOR,STATE_MODE_INT,9,ST_ACCURACY,STATE_MODE_PERCENTAGE,660,ST_ARMOR,STATE_MODE_PERCENTAGE,300,ST_LIFE,STATE_MODE_PERCENTAGE,300,ST_BLOCK,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAtked_S( function ItemSFX_FrostAttack )
call this.addPreDmg_T( function ItemSFX_BlockMissile )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+30 攻击\n+9 护甲\n+6.6%% 命中\n|cff20c000+3%% 护甲|r\n|cff20c000+3%% 生命|r\n|cff20c000+3%% 格挡|r\n|cffffcc00效果：|r\n|cff20c000覆霜：|r击中时，有20%%的几率令目标冰冻减速，持续5秒。\n|cff20c000格挡飞矢：|r受到远程攻击时，格挡效果提高15%%。"
set this.name = "|cffa334ee守护者短剑|r\n\n[近]武器 - 等级12"
set this.inSet = 0
/*"
"
I63R-庇护之手*/
set this = CreateEquipType('I63R',10,4,0,ST_ARMOR,STATE_MODE_INT,3,ST_BLOCK,STATE_MODE_INT,7,ST_ACCURACY,STATE_MODE_PERCENTAGE,237,ST_ARMOR,STATE_MODE_PERCENTAGE,120,ST_LIFE,STATE_MODE_PERCENTAGE,120,ST_BLOCK,STATE_MODE_PERCENTAGE,120,0,0,0)
call this.addDmging_T( function ItemSFX_AncientProtection )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+7 格挡\n+2.37%% 命中\n|cff20c000+1.2%% 护甲|r\n|cff20c000+1.2%% 生命|r\n|cff20c000+1.2%% 格挡|r\n|cffffcc00效果：|r\n|cff20c000古灵庇佑：|r受到伤害时，有3%%的几率使其降至1点。"
set this.name = "|cff0070dd庇护之手|r\n\n手套 - 等级10"
set this.inSet = 0
/*"
"
I63S-亘古束腰*/
set this = CreateEquipType('I63S',10,5,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,75,ST_BLOCK,STATE_MODE_INT,7,ST_ARMOR,STATE_MODE_PERCENTAGE,120,ST_LIFE,STATE_MODE_PERCENTAGE,120,ST_EVADE,STATE_MODE_PERCENTAGE,120,0,0,0)
call this.addDmging_T( function ItemSFX_EmergencyGuardiance )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+75 生命\n+7 格挡\n|cff20c000+1.2%% 护甲|r\n|cff20c000+1.2%% 生命|r\n|cff20c000+1.2%% 闪避|r\n|cffffcc00效果：|r\n|cff20c000危情守护：|r生命值低于30%%时，受到的任意伤害减低5%%[x]"
set this.name = "|cff0070dd亘古束腰|r\n\n腰带 - 等级10"
set this.inSet = 0
/*"
"
I63T-锦缎护手*/
set this = CreateEquipType('I63T',10,4,0,ST_ABILITY_POWER,STATE_MODE_INT,9,ST_MANA,STATE_MODE_INT,9,ST_MANA_REGEN,STATE_MODE_REAL,5,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,120,ST_INT,STATE_MODE_PERCENTAGE,120,ST_HASTE,STATE_MODE_PERCENTAGE,120,0,0,0)
call this.addDmging_S( function ItemSFX_ElementTuning )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 法术强度\n+9 法力\n+0.05 法力恢复\n|cff20c000+1.2%% 法术强度|r\n|cff20c000+1.2%% 智力|r\n|cff20c000+1.2%% 急速|r\n|cffffcc00效果：|r\n|cff20c000元素调谐：|r造成的元素伤害提高2%%[x]。"
set this.name = "|cff0070dd锦缎护手|r\n\n手套 - 等级10"
set this.inSet = 0
/*"
"
I63U-愚者之戒*/
set this = CreateEquipType('I63U',10,3,0,ST_STR,STATE_MODE_INT,9,ST_AGI,STATE_MODE_INT,9,ST_INT,STATE_MODE_INT,9,ST_LIFE,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_RESISTANCE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addDmging_T( function ItemSFX_DefendFire )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 力量\n+9 敏捷\n+9 智力\n|cff20c000+2%% 生命|r\n|cff20c000+2%% 法力|r\n|cff20c000+2%% 法术抗性|r\n|cffffcc00效果：|r\n|cff20c000火焰防护：|r受到的火焰伤害降低3%%[x]。"
set this.name = "|cff0070dd愚者之戒|r\n\n[唯一]戒指 - 等级10"
set this.inSet = 1
/*"
"
I63V-世界之戒*/
set this = CreateEquipType('I63V',11,3,0,ST_STR,STATE_MODE_INT,12,ST_AGI,STATE_MODE_INT,12,ST_INT,STATE_MODE_INT,12,ST_STR,STATE_MODE_PERCENTAGE,200,ST_AGI,STATE_MODE_PERCENTAGE,200,ST_INT,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addDmging_T( function ItemSFX_LuckyProtect )
call this.addDmging_T( function ItemSFX_DefendCold )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 力量\n+12 敏捷\n+12 智力\n|cff20c000+2%% 力量|r\n|cff20c000+2%% 敏捷|r\n|cff20c000+2%% 智力|r\n|cffffcc00效果：|r\n|cff20c000幸运一瞥：|r受到致命伤害时，有50%%的几率使其降至1点。触发后有120秒冷却时间。\n|cff20c000冰霜防护：|r受到的冰霜伤害降低3%%[x]。"
set this.name = "|cffa334ee世界之戒|r\n\n[唯一]戒指 - 等级11"
set this.inSet = 1
/*"
"
I63W-驱邪吊坠*/
set this = CreateEquipType('I63W',10,1,'AA07',ST_ABILITY_POWER,STATE_MODE_INT,22,ST_INT,STATE_MODE_INT,14,ST_MANA_REGEN,STATE_MODE_REAL,13,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_MANA_REGEN,STATE_MODE_PERCENTAGE,750,ST_INT,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addDmging_T( function ItemSFX_DefendShadow )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+22 法术强度\n+14 智力\n+0.13 法力恢复\n|cff20c000+3%% 法力|r\n|cff20c000+7.5%% 法力恢复|r\n|cff20c000+3%% 智力|r\n|cffffcc00效果：|r\n|cff20c000暗影防护：|r受到的暗影伤害降低3%%[x]。|N|cffffcc00赋予技能：|r|n|cff20c000驱邪术：|r驱散目标区域，并对召唤物造成神圣伤害。"
set this.name = "|cff0070dd驱邪吊坠|r\n\n护符 - 等级10"
set this.inSet = 0
/*"
"
I63X-霜铁箭*/
set this = CreateEquipType('I63X',10,1,0,ST_ATTACK,STATE_MODE_INT,15,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ACCURACY,STATE_MODE_PERCENTAGE,395,ST_HASTE,STATE_MODE_PERCENTAGE,200,ST_LEECH,STATE_MODE_PERCENTAGE,200,ST_DAMAGE_BONUS,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addAtked_S( function ItemSFX_FrostAttack )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+15 攻击\n+5%% 攻击速度\n+3.95%% 命中\n|cff20c000+2%% 急速|r\n|cff20c000+2%% 吸血|r\n|cff20c000+2%% 伤害加成|r\n|cffffcc00效果：|r\n|cff20c000覆霜：|r击中时，有20%%的几率令目标冰冻减速，持续5秒。"
set this.name = "|cff0070dd霜铁箭|r\n\n副手 - 等级10"
set this.inSet = 0
/*"
"
I63Y-暗影珍珠*/
set this = CreateEquipType('I63Y',10,1,0,ST_ABILITY_POWER,STATE_MODE_INT,15,ST_LIFE,STATE_MODE_INT,126,ST_MANA_REGEN,STATE_MODE_REAL,9,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_HEAL_BONUS,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addSpelling( function ItemSFX_ArcaneResonance )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+15 法术强度\n+126 生命\n+0.09 法力恢复\n|cff20c000+2%% 法术强度|r\n|cff20c000+2%% 法力|r\n|cff20c000+2%% 治疗加成|r\n|cffffcc00效果：|r\n|cff20c000奥术共鸣：|r施法时有15%%的几率恢复所消耗法力的20%%。"
set this.name = "|cff0070dd暗影珍珠|r\n\n副手 - 等级10"
set this.inSet = 0
/*"
"
I63Z-畸怪蹄*/
set this = CreateEquipType('I63Z',10,4,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,97,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_STR,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,ST_BLOCK,STATE_MODE_PERCENTAGE,140,0,0,0)
call this.addBefDmg_T( function ItemSFX_Cushioning2 )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+97 生命\n+15 移动速度\n|cff20c000+1.4%% 力量|r\n|cff20c000+1.4%% 暴击|r\n|cff20c000+1.4%% 格挡|r\n|cffffcc00效果：|r\n|cff20c000缓震(II)：|r受到的任何伤害降低5%%，不超过10点。"
set this.name = "|cff0070dd畸怪蹄|r\n\n[重]鞋 - 等级10"
set this.inSet = 0
/*"
"
I640-灵巧皮靴*/
set this = CreateEquipType('I640',10,3,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,97,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_LIFE,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,ST_EVADE,STATE_MODE_PERCENTAGE,140,0,0,0)
call this.addDmging_T( function ItemSFX_AOEEvade )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+97 生命\n+15 移动速度\n|cff20c000+1.4%% 生命|r\n|cff20c000+1.4%% 急速|r\n|cff20c000+1.4%% 闪避|r\n|cffffcc00效果：|r\n|cff20c000灵巧腾挪：|r你可以闪避范围伤害；成功闪避会使其降低30%%[x]。"
set this.name = "|cff0070dd灵巧皮靴|r\n\n[中]鞋 - 等级10"
set this.inSet = 0
/*"
"
I641-恶魔之手*/
set this = CreateEquipType('I641',10,4,0,ST_ATTACK,STATE_MODE_INT,9,ST_AGI,STATE_MODE_INT,5,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,300,ST_AGI,STATE_MODE_PERCENTAGE,120,ST_HASTE,STATE_MODE_PERCENTAGE,120,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,120,0,0,0)
call this.addAtking( function ItemSFX_Frenzy )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 攻击\n+5 敏捷\n+3%% 攻击速度\n|cff20c000+1.2%% 敏捷|r\n|cff20c000+1.2%% 急速|r\n|cff20c000+1.2%% 护甲穿透|r\n|cffffcc00效果：|r\n|cff20c000狂化：|r攻击时有15%%的几率在10秒内提高自身20%%的攻击速度。触发后有20秒冷却时间。"
set this.name = "|cff0070dd恶魔之手|r\n\n手套 - 等级10"
set this.inSet = 0
/*"
"
I642-堕夜法杖*/
set this = CreateEquipType('I642',11,4,0,ST_ABILITY_POWER,STATE_MODE_INT,28,ST_MANA,STATE_MODE_INT,27,ST_INT,STATE_MODE_INT,18,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,ST_LEECH,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addSpelling( function ItemSFX_LifeTap )
call this.addDmging_S( function ItemSFX_EnhanceShadow )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+28 法术强度\n+27 法力\n+18 智力\n|cff20c000+3%% 暴击|r\n|cff20c000+6%% 暴击伤害|r\n|cff20c000+3%% 吸血|r\n|cffffcc00效果：|r\n|cff20c000生命分流：|r在法力低于50%%时施法会将最多15%%的生命值置换为法力。触发后有60秒冷却时间。\n|cff20c000暗影增效：|r暗影伤害提高3%%[x]。"
set this.name = "|cffa334ee堕夜法杖|r\n\n[法]武器 - 等级11"
set this.inSet = 0
/*"
"
I643-法师头巾*/
set this = CreateEquipType('I643',10,2,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,67,ST_INT,STATE_MODE_INT,5,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+67 生命\n+5 智力\n|cff20c000+1.4%% 法术强度|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000法师头巾|r\n\n[轻]头盔 - 等级10"
set this.inSet = 2
/*"
"
I644-法师长袍*/
set this = CreateEquipType('I644',10,2,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,144,ST_INT,STATE_MODE_INT,11,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_INT,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+144 生命\n+11 智力\n|cff20c000+3%% 法力|r\n|cff20c000+3%% 智力|r"
set this.name = "|cff20c000法师长袍|r\n\n[轻]护甲 - 等级10"
set this.inSet = 2
/*"
"
I645-法师软靴*/
set this = CreateEquipType('I645',10,2,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,67,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_INT,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+67 生命\n+15 移动速度\n|cff20c000+1.4%% 智力|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000法师软靴|r\n\n[轻]鞋 - 等级10"
set this.inSet = 2
/*"
"
I646-先知皮帽*/
set this = CreateEquipType('I646',10,3,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,73,ST_INT,STATE_MODE_INT,5,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_INT,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+73 生命\n+5 智力\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 智力|r"
set this.name = "|cff20c000先知皮帽|r\n\n[中]头盔 - 等级10"
set this.inSet = 2
/*"
"
I647-先知皮甲*/
set this = CreateEquipType('I647',10,3,0,ST_ARMOR,STATE_MODE_INT,7,ST_LIFE,STATE_MODE_INT,158,ST_INT,STATE_MODE_INT,11,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+158 生命\n+11 智力\n|cff20c000+3%% 法力|r\n|cff20c000+6%% 暴击伤害|r"
set this.name = "|cff20c000先知皮甲|r\n\n[中]护甲 - 等级10"
set this.inSet = 2
/*"
"
I648-先知皮靴*/
set this = CreateEquipType('I648',10,3,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,73,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+73 生命\n+15 移动速度\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000先知皮靴|r\n\n[中]鞋 - 等级10"
set this.inSet = 2
/*"
"
I649-盗贼兜帽*/
set this = CreateEquipType('I649',10,3,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,73,ST_AGI,STATE_MODE_INT,5,ST_AGI,STATE_MODE_PERCENTAGE,140,ST_LIFE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+73 生命\n+5 敏捷\n|cff20c000+1.4%% 敏捷|r\n|cff20c000+1.4%% 生命|r"
set this.name = "|cff20c000盗贼兜帽|r\n\n[中]头盔 - 等级10"
set this.inSet = 3
/*"
"
I64A-盗贼胸甲*/
set this = CreateEquipType('I64A',10,3,0,ST_ARMOR,STATE_MODE_INT,7,ST_LIFE,STATE_MODE_INT,158,ST_AGI,STATE_MODE_INT,11,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_ARMOR,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+158 生命\n+11 敏捷\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 护甲|r"
set this.name = "|cff20c000盗贼胸甲|r\n\n[中]护甲 - 等级10"
set this.inSet = 3
/*"
"
I64B-盗贼长靴*/
set this = CreateEquipType('I64B',10,3,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,73,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_AGI,STATE_MODE_PERCENTAGE,140,ST_EVADE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+73 生命\n+15 移动速度\n|cff20c000+1.4%% 敏捷|r\n|cff20c000+1.4%% 闪避|r"
set this.name = "|cff20c000盗贼长靴|r\n\n[中]鞋 - 等级10"
set this.inSet = 3
/*"
"
I64C-防卫头盔*/
set this = CreateEquipType('I64C',10,4,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,73,ST_BLOCK,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_PERCENTAGE,140,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+73 生命\n+6 格挡\n|cff20c000+1.4%% 生命|r\n|cff20c000+1.4%% 法术抗性|r"
set this.name = "|cff20c000防卫头盔|r\n\n[重]头盔 - 等级10"
set this.inSet = 4
/*"
"
I64D-防卫胸甲*/
set this = CreateEquipType('I64D',10,4,0,ST_ARMOR,STATE_MODE_INT,9,ST_LIFE,STATE_MODE_INT,158,ST_BLOCK,STATE_MODE_INT,14,ST_LIFE,STATE_MODE_PERCENTAGE,300,ST_BLOCK,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 护甲\n+158 生命\n+14 格挡\n|cff20c000+3%% 生命|r\n|cff20c000+3%% 格挡|r"
set this.name = "|cff20c000防卫胸甲|r\n\n[重]护甲 - 等级10"
set this.inSet = 4
/*"
"
I64E-防卫护胫*/
set this = CreateEquipType('I64E',10,4,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,73,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_ARMOR,STATE_MODE_PERCENTAGE,140,ST_LIFE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+73 生命\n+15 移动速度\n|cff20c000+1.4%% 护甲|r\n|cff20c000+1.4%% 生命|r"
set this.name = "|cff20c000防卫护胫|r\n\n[重]鞋 - 等级10"
set this.inSet = 4
/*"
"
I64F-角斗头盔*/
set this = CreateEquipType('I64F',10,4,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,73,ST_STR,STATE_MODE_INT,5,ST_STR,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+73 生命\n+5 力量\n|cff20c000+1.4%% 力量|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000角斗头盔|r\n\n[重]头盔 - 等级10"
set this.inSet = 5
/*"
"
I64G-角斗胸甲*/
set this = CreateEquipType('I64G',10,4,0,ST_ARMOR,STATE_MODE_INT,9,ST_LIFE,STATE_MODE_INT,158,ST_STR,STATE_MODE_INT,11,ST_STR,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 护甲\n+158 生命\n+11 力量\n|cff20c000+3%% 力量|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000角斗胸甲|r\n\n[重]护甲 - 等级10"
set this.inSet = 5
/*"
"
I64H-角斗护胫*/
set this = CreateEquipType('I64H',10,4,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,73,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_STR,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+73 生命\n+15 移动速度\n|cff20c000+1.4%% 力量|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000角斗护胫|r\n\n[重]鞋 - 等级10"
set this.inSet = 5
/*"
"
I64I-贤明头盔*/
set this = CreateEquipType('I64I',10,4,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,73,ST_INT,STATE_MODE_INT,5,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+73 生命\n+5 智力\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 法术抗性|r"
set this.name = "|cff20c000贤明头盔|r\n\n[重]头盔 - 等级10"
set this.inSet = 2
/*"
"
I64J-贤明护胸*/
set this = CreateEquipType('I64J',10,4,0,ST_ARMOR,STATE_MODE_INT,9,ST_LIFE,STATE_MODE_INT,158,ST_INT,STATE_MODE_INT,11,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 护甲\n+158 生命\n+11 智力\n|cff20c000+3%% 法力|r\n|cff20c000+3%% 暴击|r"
set this.name = "|cff20c000贤明护胸|r\n\n[重]护甲 - 等级10"
set this.inSet = 2
/*"
"
I64K-贤明胫甲*/
set this = CreateEquipType('I64K',10,4,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,73,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_INT,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+73 生命\n+15 移动速度\n|cff20c000+1.4%% 智力|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000贤明胫甲|r\n\n[重]鞋 - 等级10"
set this.inSet = 2
/*"
"
I64L-法师头巾*/
set this = CreateEquipType('I64L',14,2,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,100,ST_INT,STATE_MODE_INT,7,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+100 生命\n+7 智力\n|cff20c000+1.4%% 法术强度|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000法师头巾|r\n\n[轻]头盔 - 等级14"
set this.inSet = 2
/*"
"
I64M-法师长袍*/
set this = CreateEquipType('I64M',14,2,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,216,ST_INT,STATE_MODE_INT,16,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_INT,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+216 生命\n+16 智力\n|cff20c000+3%% 法力|r\n|cff20c000+3%% 智力|r"
set this.name = "|cff20c000法师长袍|r\n\n[轻]护甲 - 等级14"
set this.inSet = 2
/*"
"
I64N-法师软靴*/
set this = CreateEquipType('I64N',14,2,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,100,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_INT,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+100 生命\n+15 移动速度\n|cff20c000+1.4%% 智力|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000法师软靴|r\n\n[轻]鞋 - 等级14"
set this.inSet = 2
/*"
"
I64O-先知皮帽*/
set this = CreateEquipType('I64O',14,3,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,110,ST_INT,STATE_MODE_INT,7,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_INT,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+110 生命\n+7 智力\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 智力|r"
set this.name = "|cff20c000先知皮帽|r\n\n[中]头盔 - 等级14"
set this.inSet = 2
/*"
"
I64P-先知皮甲*/
set this = CreateEquipType('I64P',14,3,0,ST_ARMOR,STATE_MODE_INT,10,ST_LIFE,STATE_MODE_INT,237,ST_INT,STATE_MODE_INT,16,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+10 护甲\n+237 生命\n+16 智力\n|cff20c000+3%% 法力|r\n|cff20c000+6%% 暴击伤害|r"
set this.name = "|cff20c000先知皮甲|r\n\n[中]护甲 - 等级14"
set this.inSet = 2
/*"
"
I64Q-先知皮靴*/
set this = CreateEquipType('I64Q',14,3,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,110,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+110 生命\n+15 移动速度\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000先知皮靴|r\n\n[中]鞋 - 等级14"
set this.inSet = 2
/*"
"
I64R-盗贼兜帽*/
set this = CreateEquipType('I64R',14,3,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,110,ST_AGI,STATE_MODE_INT,7,ST_AGI,STATE_MODE_PERCENTAGE,140,ST_LIFE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+110 生命\n+7 敏捷\n|cff20c000+1.4%% 敏捷|r\n|cff20c000+1.4%% 生命|r"
set this.name = "|cff20c000盗贼兜帽|r\n\n[中]头盔 - 等级14"
set this.inSet = 3
/*"
"
I64S-盗贼胸甲*/
set this = CreateEquipType('I64S',14,3,0,ST_ARMOR,STATE_MODE_INT,10,ST_LIFE,STATE_MODE_INT,237,ST_AGI,STATE_MODE_INT,16,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_ARMOR,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+10 护甲\n+237 生命\n+16 敏捷\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 护甲|r"
set this.name = "|cff20c000盗贼胸甲|r\n\n[中]护甲 - 等级14"
set this.inSet = 3
/*"
"
I64T-盗贼长靴*/
set this = CreateEquipType('I64T',14,3,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,110,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_AGI,STATE_MODE_PERCENTAGE,140,ST_EVADE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+110 生命\n+15 移动速度\n|cff20c000+1.4%% 敏捷|r\n|cff20c000+1.4%% 闪避|r"
set this.name = "|cff20c000盗贼长靴|r\n\n[中]鞋 - 等级14"
set this.inSet = 3
/*"
"
I64U-防卫头盔*/
set this = CreateEquipType('I64U',14,4,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,110,ST_BLOCK,STATE_MODE_INT,9,ST_LIFE,STATE_MODE_PERCENTAGE,140,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+110 生命\n+9 格挡\n|cff20c000+1.4%% 生命|r\n|cff20c000+1.4%% 法术抗性|r"
set this.name = "|cff20c000防卫头盔|r\n\n[重]头盔 - 等级14"
set this.inSet = 4
/*"
"
I64V-防卫胸甲*/
set this = CreateEquipType('I64V',14,4,0,ST_ARMOR,STATE_MODE_INT,12,ST_LIFE,STATE_MODE_INT,237,ST_BLOCK,STATE_MODE_INT,20,ST_LIFE,STATE_MODE_PERCENTAGE,300,ST_BLOCK,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 护甲\n+237 生命\n+20 格挡\n|cff20c000+3%% 生命|r\n|cff20c000+3%% 格挡|r"
set this.name = "|cff20c000防卫胸甲|r\n\n[重]护甲 - 等级14"
set this.inSet = 4
/*"
"
I64W-防卫护胫*/
set this = CreateEquipType('I64W',14,4,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,110,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_ARMOR,STATE_MODE_PERCENTAGE,140,ST_LIFE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+110 生命\n+15 移动速度\n|cff20c000+1.4%% 护甲|r\n|cff20c000+1.4%% 生命|r"
set this.name = "|cff20c000防卫护胫|r\n\n[重]鞋 - 等级14"
set this.inSet = 4
/*"
"
I64X-角斗头盔*/
set this = CreateEquipType('I64X',14,4,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,110,ST_STR,STATE_MODE_INT,7,ST_STR,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+110 生命\n+7 力量\n|cff20c000+1.4%% 力量|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000角斗头盔|r\n\n[重]头盔 - 等级14"
set this.inSet = 5
/*"
"
I64Y-角斗胸甲*/
set this = CreateEquipType('I64Y',14,4,0,ST_ARMOR,STATE_MODE_INT,12,ST_LIFE,STATE_MODE_INT,237,ST_STR,STATE_MODE_INT,16,ST_STR,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 护甲\n+237 生命\n+16 力量\n|cff20c000+3%% 力量|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000角斗胸甲|r\n\n[重]护甲 - 等级14"
set this.inSet = 5
/*"
"
I64Z-角斗护胫*/
set this = CreateEquipType('I64Z',14,4,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,110,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_STR,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+110 生命\n+15 移动速度\n|cff20c000+1.4%% 力量|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000角斗护胫|r\n\n[重]鞋 - 等级14"
set this.inSet = 5
/*"
"
I650-贤明头盔*/
set this = CreateEquipType('I650',14,4,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,110,ST_INT,STATE_MODE_INT,7,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+110 生命\n+7 智力\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 法术抗性|r"
set this.name = "|cff20c000贤明头盔|r\n\n[重]头盔 - 等级14"
set this.inSet = 2
/*"
"
I651-贤明护胸*/
set this = CreateEquipType('I651',14,4,0,ST_ARMOR,STATE_MODE_INT,12,ST_LIFE,STATE_MODE_INT,237,ST_INT,STATE_MODE_INT,16,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 护甲\n+237 生命\n+16 智力\n|cff20c000+3%% 法力|r\n|cff20c000+3%% 暴击|r"
set this.name = "|cff20c000贤明护胸|r\n\n[重]护甲 - 等级14"
set this.inSet = 2
/*"
"
I652-贤明胫甲*/
set this = CreateEquipType('I652',14,4,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,110,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_INT,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+110 生命\n+15 移动速度\n|cff20c000+1.4%% 智力|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000贤明胫甲|r\n\n[重]鞋 - 等级14"
set this.inSet = 2
/*"
"
I653-法师头巾*/
set this = CreateEquipType('I653',18,2,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,134,ST_INT,STATE_MODE_INT,9,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+134 生命\n+9 智力\n|cff20c000+1.4%% 法术强度|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000法师头巾|r\n\n[轻]头盔 - 等级18"
set this.inSet = 2
/*"
"
I654-法师长袍*/
set this = CreateEquipType('I654',18,2,0,ST_ARMOR,STATE_MODE_INT,9,ST_LIFE,STATE_MODE_INT,288,ST_INT,STATE_MODE_INT,21,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_INT,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 护甲\n+288 生命\n+21 智力\n|cff20c000+3%% 法力|r\n|cff20c000+3%% 智力|r"
set this.name = "|cff20c000法师长袍|r\n\n[轻]护甲 - 等级18"
set this.inSet = 2
/*"
"
I655-法师软靴*/
set this = CreateEquipType('I655',18,2,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,134,ST_MOVE_SPEED,STATE_MODE_INT,16,ST_INT,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+134 生命\n+16 移动速度\n|cff20c000+1.4%% 智力|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000法师软靴|r\n\n[轻]鞋 - 等级18"
set this.inSet = 2
/*"
"
I656-先知皮帽*/
set this = CreateEquipType('I656',18,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,147,ST_INT,STATE_MODE_INT,9,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_INT,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+147 生命\n+9 智力\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 智力|r"
set this.name = "|cff20c000先知皮帽|r\n\n[中]头盔 - 等级18"
set this.inSet = 2
/*"
"
I657-先知皮甲*/
set this = CreateEquipType('I657',18,3,0,ST_ARMOR,STATE_MODE_INT,12,ST_LIFE,STATE_MODE_INT,316,ST_INT,STATE_MODE_INT,21,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 护甲\n+316 生命\n+21 智力\n|cff20c000+3%% 法力|r\n|cff20c000+6%% 暴击伤害|r"
set this.name = "|cff20c000先知皮甲|r\n\n[中]护甲 - 等级18"
set this.inSet = 2
/*"
"
I658-先知皮靴*/
set this = CreateEquipType('I658',18,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,147,ST_MOVE_SPEED,STATE_MODE_INT,16,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+147 生命\n+16 移动速度\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000先知皮靴|r\n\n[中]鞋 - 等级18"
set this.inSet = 2
/*"
"
I659-盗贼兜帽*/
set this = CreateEquipType('I659',18,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,147,ST_AGI,STATE_MODE_INT,9,ST_AGI,STATE_MODE_PERCENTAGE,140,ST_LIFE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+147 生命\n+9 敏捷\n|cff20c000+1.4%% 敏捷|r\n|cff20c000+1.4%% 生命|r"
set this.name = "|cff20c000盗贼兜帽|r\n\n[中]头盔 - 等级18"
set this.inSet = 3
/*"
"
I65A-盗贼胸甲*/
set this = CreateEquipType('I65A',18,3,0,ST_ARMOR,STATE_MODE_INT,12,ST_LIFE,STATE_MODE_INT,316,ST_AGI,STATE_MODE_INT,21,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_ARMOR,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 护甲\n+316 生命\n+21 敏捷\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 护甲|r"
set this.name = "|cff20c000盗贼胸甲|r\n\n[中]护甲 - 等级18"
set this.inSet = 3
/*"
"
I65B-盗贼长靴*/
set this = CreateEquipType('I65B',18,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,147,ST_MOVE_SPEED,STATE_MODE_INT,16,ST_AGI,STATE_MODE_PERCENTAGE,140,ST_EVADE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+147 生命\n+16 移动速度\n|cff20c000+1.4%% 敏捷|r\n|cff20c000+1.4%% 闪避|r"
set this.name = "|cff20c000盗贼长靴|r\n\n[中]鞋 - 等级18"
set this.inSet = 3
/*"
"
I65C-防卫头盔*/
set this = CreateEquipType('I65C',18,4,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,147,ST_BLOCK,STATE_MODE_INT,12,ST_LIFE,STATE_MODE_PERCENTAGE,140,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+147 生命\n+12 格挡\n|cff20c000+1.4%% 生命|r\n|cff20c000+1.4%% 法术抗性|r"
set this.name = "|cff20c000防卫头盔|r\n\n[重]头盔 - 等级18"
set this.inSet = 4
/*"
"
I65D-防卫胸甲*/
set this = CreateEquipType('I65D',18,4,0,ST_ARMOR,STATE_MODE_INT,14,ST_LIFE,STATE_MODE_INT,316,ST_BLOCK,STATE_MODE_INT,26,ST_LIFE,STATE_MODE_PERCENTAGE,300,ST_BLOCK,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+14 护甲\n+316 生命\n+26 格挡\n|cff20c000+3%% 生命|r\n|cff20c000+3%% 格挡|r"
set this.name = "|cff20c000防卫胸甲|r\n\n[重]护甲 - 等级18"
set this.inSet = 4
/*"
"
I65E-防卫护胫*/
set this = CreateEquipType('I65E',18,4,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,147,ST_MOVE_SPEED,STATE_MODE_INT,16,ST_ARMOR,STATE_MODE_PERCENTAGE,140,ST_LIFE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+147 生命\n+16 移动速度\n|cff20c000+1.4%% 护甲|r\n|cff20c000+1.4%% 生命|r"
set this.name = "|cff20c000防卫护胫|r\n\n[重]鞋 - 等级18"
set this.inSet = 4
/*"
"
I65F-角斗头盔*/
set this = CreateEquipType('I65F',18,4,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,147,ST_STR,STATE_MODE_INT,9,ST_STR,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+147 生命\n+9 力量\n|cff20c000+1.4%% 力量|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000角斗头盔|r\n\n[重]头盔 - 等级18"
set this.inSet = 5
/*"
"
I65G-角斗胸甲*/
set this = CreateEquipType('I65G',18,4,0,ST_ARMOR,STATE_MODE_INT,14,ST_LIFE,STATE_MODE_INT,316,ST_STR,STATE_MODE_INT,21,ST_STR,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+14 护甲\n+316 生命\n+21 力量\n|cff20c000+3%% 力量|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000角斗胸甲|r\n\n[重]护甲 - 等级18"
set this.inSet = 5
/*"
"
I65H-角斗护胫*/
set this = CreateEquipType('I65H',18,4,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,147,ST_MOVE_SPEED,STATE_MODE_INT,16,ST_STR,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+147 生命\n+16 移动速度\n|cff20c000+1.4%% 力量|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000角斗护胫|r\n\n[重]鞋 - 等级18"
set this.inSet = 5
/*"
"
I65I-贤明头盔*/
set this = CreateEquipType('I65I',18,4,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,147,ST_INT,STATE_MODE_INT,9,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+147 生命\n+9 智力\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 法术抗性|r"
set this.name = "|cff20c000贤明头盔|r\n\n[重]头盔 - 等级18"
set this.inSet = 2
/*"
"
I65J-贤明护胸*/
set this = CreateEquipType('I65J',18,4,0,ST_ARMOR,STATE_MODE_INT,14,ST_LIFE,STATE_MODE_INT,316,ST_INT,STATE_MODE_INT,21,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+14 护甲\n+316 生命\n+21 智力\n|cff20c000+3%% 法力|r\n|cff20c000+3%% 暴击|r"
set this.name = "|cff20c000贤明护胸|r\n\n[重]护甲 - 等级18"
set this.inSet = 2
/*"
"
I65K-贤明胫甲*/
set this = CreateEquipType('I65K',18,4,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,147,ST_MOVE_SPEED,STATE_MODE_INT,16,ST_INT,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+147 生命\n+16 移动速度\n|cff20c000+1.4%% 智力|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000贤明胫甲|r\n\n[重]鞋 - 等级18"
set this.inSet = 2
/*"
"
I65L-法师头巾*/
set this = CreateEquipType('I65L',20,2,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,151,ST_INT,STATE_MODE_INT,11,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+151 生命\n+11 智力\n|cff20c000+1.4%% 法术强度|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000法师头巾|r\n\n[轻]头盔 - 等级20"
set this.inSet = 2
/*"
"
I65M-法师长袍*/
set this = CreateEquipType('I65M',20,2,0,ST_ARMOR,STATE_MODE_INT,10,ST_LIFE,STATE_MODE_INT,324,ST_INT,STATE_MODE_INT,23,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_INT,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+10 护甲\n+324 生命\n+23 智力\n|cff20c000+3%% 法力|r\n|cff20c000+3%% 智力|r"
set this.name = "|cff20c000法师长袍|r\n\n[轻]护甲 - 等级20"
set this.inSet = 2
/*"
"
I65N-法师软靴*/
set this = CreateEquipType('I65N',20,2,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,151,ST_MOVE_SPEED,STATE_MODE_INT,16,ST_INT,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+151 生命\n+16 移动速度\n|cff20c000+1.4%% 智力|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000法师软靴|r\n\n[轻]鞋 - 等级20"
set this.inSet = 2
/*"
"
I65O-先知皮帽*/
set this = CreateEquipType('I65O',20,3,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,166,ST_INT,STATE_MODE_INT,11,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_INT,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+166 生命\n+11 智力\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 智力|r"
set this.name = "|cff20c000先知皮帽|r\n\n[中]头盔 - 等级20"
set this.inSet = 2
/*"
"
I65P-先知皮甲*/
set this = CreateEquipType('I65P',20,3,0,ST_ARMOR,STATE_MODE_INT,13,ST_LIFE,STATE_MODE_INT,356,ST_INT,STATE_MODE_INT,23,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+13 护甲\n+356 生命\n+23 智力\n|cff20c000+3%% 法力|r\n|cff20c000+6%% 暴击伤害|r"
set this.name = "|cff20c000先知皮甲|r\n\n[中]护甲 - 等级20"
set this.inSet = 2
/*"
"
I65Q-先知皮靴*/
set this = CreateEquipType('I65Q',20,3,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,166,ST_MOVE_SPEED,STATE_MODE_INT,16,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+166 生命\n+16 移动速度\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000先知皮靴|r\n\n[中]鞋 - 等级20"
set this.inSet = 2
/*"
"
I65R-盗贼兜帽*/
set this = CreateEquipType('I65R',20,3,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,166,ST_AGI,STATE_MODE_INT,11,ST_AGI,STATE_MODE_PERCENTAGE,140,ST_LIFE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+166 生命\n+11 敏捷\n|cff20c000+1.4%% 敏捷|r\n|cff20c000+1.4%% 生命|r"
set this.name = "|cff20c000盗贼兜帽|r\n\n[中]头盔 - 等级20"
set this.inSet = 3
/*"
"
I65S-盗贼胸甲*/
set this = CreateEquipType('I65S',20,3,0,ST_ARMOR,STATE_MODE_INT,13,ST_LIFE,STATE_MODE_INT,356,ST_AGI,STATE_MODE_INT,23,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_ARMOR,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+13 护甲\n+356 生命\n+23 敏捷\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 护甲|r"
set this.name = "|cff20c000盗贼胸甲|r\n\n[中]护甲 - 等级20"
set this.inSet = 3
/*"
"
I65T-盗贼长靴*/
set this = CreateEquipType('I65T',20,3,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,166,ST_MOVE_SPEED,STATE_MODE_INT,16,ST_AGI,STATE_MODE_PERCENTAGE,140,ST_EVADE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+166 生命\n+16 移动速度\n|cff20c000+1.4%% 敏捷|r\n|cff20c000+1.4%% 闪避|r"
set this.name = "|cff20c000盗贼长靴|r\n\n[中]鞋 - 等级20"
set this.inSet = 3
/*"
"
I65U-防卫头盔*/
set this = CreateEquipType('I65U',20,4,0,ST_ARMOR,STATE_MODE_INT,7,ST_LIFE,STATE_MODE_INT,166,ST_BLOCK,STATE_MODE_INT,13,ST_LIFE,STATE_MODE_PERCENTAGE,140,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+166 生命\n+13 格挡\n|cff20c000+1.4%% 生命|r\n|cff20c000+1.4%% 法术抗性|r"
set this.name = "|cff20c000防卫头盔|r\n\n[重]头盔 - 等级20"
set this.inSet = 4
/*"
"
I65V-防卫胸甲*/
set this = CreateEquipType('I65V',20,4,0,ST_ARMOR,STATE_MODE_INT,16,ST_LIFE,STATE_MODE_INT,356,ST_BLOCK,STATE_MODE_INT,29,ST_LIFE,STATE_MODE_PERCENTAGE,300,ST_BLOCK,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+16 护甲\n+356 生命\n+29 格挡\n|cff20c000+3%% 生命|r\n|cff20c000+3%% 格挡|r"
set this.name = "|cff20c000防卫胸甲|r\n\n[重]护甲 - 等级20"
set this.inSet = 4
/*"
"
I65W-防卫护胫*/
set this = CreateEquipType('I65W',20,4,0,ST_ARMOR,STATE_MODE_INT,7,ST_LIFE,STATE_MODE_INT,166,ST_MOVE_SPEED,STATE_MODE_INT,16,ST_ARMOR,STATE_MODE_PERCENTAGE,140,ST_LIFE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+166 生命\n+16 移动速度\n|cff20c000+1.4%% 护甲|r\n|cff20c000+1.4%% 生命|r"
set this.name = "|cff20c000防卫护胫|r\n\n[重]鞋 - 等级20"
set this.inSet = 4
/*"
"
I65X-角斗头盔*/
set this = CreateEquipType('I65X',20,4,0,ST_ARMOR,STATE_MODE_INT,7,ST_LIFE,STATE_MODE_INT,166,ST_STR,STATE_MODE_INT,11,ST_STR,STATE_MODE_PERCENTAGE,140,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+166 生命\n+11 力量\n|cff20c000+1.4%% 力量|r\n|cff20c000+1.4%% 暴击|r"
set this.name = "|cff20c000角斗头盔|r\n\n[重]头盔 - 等级20"
set this.inSet = 5
/*"
"
I65Y-角斗胸甲*/
set this = CreateEquipType('I65Y',20,4,0,ST_ARMOR,STATE_MODE_INT,16,ST_LIFE,STATE_MODE_INT,356,ST_STR,STATE_MODE_INT,23,ST_STR,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+16 护甲\n+356 生命\n+23 力量\n|cff20c000+3%% 力量|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000角斗胸甲|r\n\n[重]护甲 - 等级20"
set this.inSet = 5
/*"
"
I65Z-角斗护胫*/
set this = CreateEquipType('I65Z',20,4,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,4,ST_MOVE_SPEED,STATE_MODE_INT,14,ST_STR,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+4 生命\n+14 移动速度\n|cff20c000+1.4%% 力量|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000角斗护胫|r\n\n[重]鞋 - 等级20"
set this.inSet = 5
/*"
"
I660-贤明头盔*/
set this = CreateEquipType('I660',20,4,0,ST_ARMOR,STATE_MODE_INT,7,ST_LIFE,STATE_MODE_INT,166,ST_INT,STATE_MODE_INT,11,ST_MANA,STATE_MODE_PERCENTAGE,140,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+166 生命\n+11 智力\n|cff20c000+1.4%% 法力|r\n|cff20c000+1.4%% 法术抗性|r"
set this.name = "|cff20c000贤明头盔|r\n\n[重]头盔 - 等级20"
set this.inSet = 2
/*"
"
I661-贤明护胸*/
set this = CreateEquipType('I661',20,4,0,ST_ARMOR,STATE_MODE_INT,16,ST_LIFE,STATE_MODE_INT,356,ST_INT,STATE_MODE_INT,23,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+16 护甲\n+356 生命\n+23 智力\n|cff20c000+3%% 法力|r\n|cff20c000+3%% 暴击|r"
set this.name = "|cff20c000贤明护胸|r\n\n[重]护甲 - 等级20"
set this.inSet = 2
/*"
"
I662-贤明胫甲*/
set this = CreateEquipType('I662',20,4,0,ST_ARMOR,STATE_MODE_INT,7,ST_LIFE,STATE_MODE_INT,166,ST_MOVE_SPEED,STATE_MODE_INT,16,ST_INT,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+166 生命\n+16 移动速度\n|cff20c000+1.4%% 智力|r\n|cff20c000+1.4%% 急速|r"
set this.name = "|cff20c000贤明胫甲|r\n\n[重]鞋 - 等级20"
set this.inSet = 2
/*"
"
I663-法师护腕*/
set this = CreateEquipType('I663',10,4,0,ST_ABILITY_POWER,STATE_MODE_INT,7,ST_INT,STATE_MODE_INT,4,ST_MANA_REGEN,STATE_MODE_REAL,4,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,120,ST_INT,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 法术强度\n+4 智力\n+0.04 法力恢复\n|cff20c000+1.2%% 法术强度|r\n|cff20c000+1.2%% 智力|r"
set this.name = "|cff20c000法师护腕|r\n\n手套 - 等级10"
set this.inSet = 2
/*"
"
I664-盗贼护手*/
set this = CreateEquipType('I664',10,4,0,ST_ATTACK,STATE_MODE_INT,7,ST_AGI,STATE_MODE_INT,4,ST_ACCURACY,STATE_MODE_PERCENTAGE,222,ST_HASTE,STATE_MODE_PERCENTAGE,120,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 攻击\n+4 敏捷\n+2.22%% 命中\n|cff20c000+1.2%% 急速|r\n|cff20c000+1.2%% 护甲穿透|r"
set this.name = "|cff20c000盗贼护手|r\n\n手套 - 等级10"
set this.inSet = 3
/*"
"
I665-防卫手甲*/
set this = CreateEquipType('I665',10,4,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,57,ST_BLOCK,STATE_MODE_INT,5,ST_ARMOR,STATE_MODE_PERCENTAGE,120,ST_LIFE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+57 生命\n+5 格挡\n|cff20c000+1.2%% 护甲|r\n|cff20c000+1.2%% 生命|r"
set this.name = "|cff20c000防卫手甲|r\n\n手套 - 等级10"
set this.inSet = 4
/*"
"
I666-角斗护腕*/
set this = CreateEquipType('I666',10,4,0,ST_ATTACK,STATE_MODE_INT,7,ST_STR,STATE_MODE_INT,4,ST_ARMOR_PEN,STATE_MODE_INT,3,ST_ATTACK,STATE_MODE_PERCENTAGE,120,ST_HASTE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 攻击\n+4 力量\n+3 护甲穿透\n|cff20c000+1.2%% 攻击|r\n|cff20c000+1.2%% 急速|r"
set this.name = "|cff20c000角斗护腕|r\n\n手套 - 等级10"
set this.inSet = 5
/*"
"
I667-法师护腕*/
set this = CreateEquipType('I667',14,4,0,ST_ABILITY_POWER,STATE_MODE_INT,10,ST_INT,STATE_MODE_INT,6,ST_MANA_REGEN,STATE_MODE_REAL,5,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,120,ST_INT,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+10 法术强度\n+6 智力\n+0.05 法力恢复\n|cff20c000+1.2%% 法术强度|r\n|cff20c000+1.2%% 智力|r"
set this.name = "|cff20c000法师护腕|r\n\n手套 - 等级14"
set this.inSet = 2
/*"
"
I668-盗贼护手*/
set this = CreateEquipType('I668',14,4,0,ST_ATTACK,STATE_MODE_INT,10,ST_AGI,STATE_MODE_INT,6,ST_ACCURACY,STATE_MODE_PERCENTAGE,246,ST_HASTE,STATE_MODE_PERCENTAGE,120,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+10 攻击\n+6 敏捷\n+2.46%% 命中\n|cff20c000+1.2%% 急速|r\n|cff20c000+1.2%% 护甲穿透|r"
set this.name = "|cff20c000盗贼护手|r\n\n手套 - 等级14"
set this.inSet = 3
/*"
"
I669-防卫手甲*/
set this = CreateEquipType('I669',14,4,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,86,ST_BLOCK,STATE_MODE_INT,8,ST_ARMOR,STATE_MODE_PERCENTAGE,120,ST_LIFE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+86 生命\n+8 格挡\n|cff20c000+1.2%% 护甲|r\n|cff20c000+1.2%% 生命|r"
set this.name = "|cff20c000防卫手甲|r\n\n手套 - 等级14"
set this.inSet = 4
/*"
"
I66A-角斗护腕*/
set this = CreateEquipType('I66A',14,4,0,ST_ATTACK,STATE_MODE_INT,10,ST_STR,STATE_MODE_INT,6,ST_ARMOR_PEN,STATE_MODE_INT,4,ST_ATTACK,STATE_MODE_PERCENTAGE,120,ST_HASTE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+10 攻击\n+6 力量\n+4 护甲穿透\n|cff20c000+1.2%% 攻击|r\n|cff20c000+1.2%% 急速|r"
set this.name = "|cff20c000角斗护腕|r\n\n手套 - 等级14"
set this.inSet = 5
/*"
"
I66B-法师护腕*/
set this = CreateEquipType('I66B',18,4,0,ST_ABILITY_POWER,STATE_MODE_INT,12,ST_INT,STATE_MODE_INT,8,ST_MANA_REGEN,STATE_MODE_REAL,6,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,120,ST_INT,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 法术强度\n+8 智力\n+0.06 法力恢复\n|cff20c000+1.2%% 法术强度|r\n|cff20c000+1.2%% 智力|r"
set this.name = "|cff20c000法师护腕|r\n\n手套 - 等级18"
set this.inSet = 2
/*"
"
I66C-盗贼护手*/
set this = CreateEquipType('I66C',18,4,0,ST_ATTACK,STATE_MODE_INT,12,ST_AGI,STATE_MODE_INT,8,ST_ACCURACY,STATE_MODE_PERCENTAGE,270,ST_HASTE,STATE_MODE_PERCENTAGE,120,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 攻击\n+8 敏捷\n+2.7%% 命中\n|cff20c000+1.2%% 急速|r\n|cff20c000+1.2%% 护甲穿透|r"
set this.name = "|cff20c000盗贼护手|r\n\n手套 - 等级18"
set this.inSet = 3
/*"
"
I66D-防卫手甲*/
set this = CreateEquipType('I66D',18,4,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,115,ST_BLOCK,STATE_MODE_INT,10,ST_ARMOR,STATE_MODE_PERCENTAGE,120,ST_LIFE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+115 生命\n+10 格挡\n|cff20c000+1.2%% 护甲|r\n|cff20c000+1.2%% 生命|r"
set this.name = "|cff20c000防卫手甲|r\n\n手套 - 等级18"
set this.inSet = 4
/*"
"
I66E-角斗护腕*/
set this = CreateEquipType('I66E',18,4,0,ST_ATTACK,STATE_MODE_INT,12,ST_STR,STATE_MODE_INT,8,ST_ARMOR_PEN,STATE_MODE_INT,5,ST_ATTACK,STATE_MODE_PERCENTAGE,120,ST_HASTE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 攻击\n+8 力量\n+5 护甲穿透\n|cff20c000+1.2%% 攻击|r\n|cff20c000+1.2%% 急速|r"
set this.name = "|cff20c000角斗护腕|r\n\n手套 - 等级18"
set this.inSet = 5
/*"
"
I66F-法师护腕*/
set this = CreateEquipType('I66F',20,4,0,ST_ABILITY_POWER,STATE_MODE_INT,14,ST_INT,STATE_MODE_INT,9,ST_MANA_REGEN,STATE_MODE_REAL,7,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,120,ST_INT,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+14 法术强度\n+9 智力\n+0.07 法力恢复\n|cff20c000+1.2%% 法术强度|r\n|cff20c000+1.2%% 智力|r"
set this.name = "|cff20c000法师护腕|r\n\n手套 - 等级20"
set this.inSet = 2
/*"
"
I66G-盗贼护手*/
set this = CreateEquipType('I66G',20,4,0,ST_ATTACK,STATE_MODE_INT,14,ST_AGI,STATE_MODE_INT,9,ST_ACCURACY,STATE_MODE_PERCENTAGE,282,ST_HASTE,STATE_MODE_PERCENTAGE,120,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+14 攻击\n+9 敏捷\n+2.82%% 命中\n|cff20c000+1.2%% 急速|r\n|cff20c000+1.2%% 护甲穿透|r"
set this.name = "|cff20c000盗贼护手|r\n\n手套 - 等级20"
set this.inSet = 3
/*"
"
I66H-防卫手甲*/
set this = CreateEquipType('I66H',20,4,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,129,ST_BLOCK,STATE_MODE_INT,11,ST_ARMOR,STATE_MODE_PERCENTAGE,120,ST_LIFE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+129 生命\n+11 格挡\n|cff20c000+1.2%% 护甲|r\n|cff20c000+1.2%% 生命|r"
set this.name = "|cff20c000防卫手甲|r\n\n手套 - 等级20"
set this.inSet = 4
/*"
"
I66I-角斗护腕*/
set this = CreateEquipType('I66I',20,4,0,ST_ATTACK,STATE_MODE_INT,14,ST_STR,STATE_MODE_INT,9,ST_ARMOR_PEN,STATE_MODE_INT,6,ST_ATTACK,STATE_MODE_PERCENTAGE,120,ST_HASTE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+14 攻击\n+9 力量\n+6 护甲穿透\n|cff20c000+1.2%% 攻击|r\n|cff20c000+1.2%% 急速|r"
set this.name = "|cff20c000角斗护腕|r\n\n手套 - 等级20"
set this.inSet = 5
/*"
"
I66J-法师束带*/
set this = CreateEquipType('I66J',10,5,0,ST_LIFE,STATE_MODE_INT,57,ST_MANA,STATE_MODE_INT,7,ST_MANA_REGEN,STATE_MODE_REAL,4,ST_MANA,STATE_MODE_PERCENTAGE,120,ST_INT,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+57 生命\n+7 法力\n+0.04 法力恢复\n|cff20c000+1.2%% 法力|r\n|cff20c000+1.2%% 智力|r"
set this.name = "|cff20c000法师束带|r\n\n腰带 - 等级10"
set this.inSet = 2
/*"
"
I66K-盗贼束带*/
set this = CreateEquipType('I66K',10,5,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,57,ST_LIFE_REGEN,STATE_MODE_REAL,15,ST_AGI,STATE_MODE_PERCENTAGE,120,ST_EVADE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+57 生命\n+0.15 生命恢复\n|cff20c000+1.2%% 敏捷|r\n|cff20c000+1.2%% 闪避|r"
set this.name = "|cff20c000盗贼束带|r\n\n腰带 - 等级10"
set this.inSet = 3
/*"
"
I66L-防卫束带*/
set this = CreateEquipType('I66L',10,5,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,57,ST_BLOCK,STATE_MODE_INT,5,ST_ARMOR,STATE_MODE_PERCENTAGE,120,ST_LIFE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+57 生命\n+5 格挡\n|cff20c000+1.2%% 护甲|r\n|cff20c000+1.2%% 生命|r"
set this.name = "|cff20c000防卫束带|r\n\n腰带 - 等级10"
set this.inSet = 4
/*"
"
I66M-角斗束带*/
set this = CreateEquipType('I66M',10,5,0,ST_ARMOR,STATE_MODE_INT,2,ST_LIFE,STATE_MODE_INT,57,ST_LIFE_REGEN,STATE_MODE_REAL,15,ST_STR,STATE_MODE_PERCENTAGE,120,ST_RESISTANCE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+57 生命\n+0.15 生命恢复\n|cff20c000+1.2%% 力量|r\n|cff20c000+1.2%% 法术抗性|r"
set this.name = "|cff20c000角斗束带|r\n\n腰带 - 等级10"
set this.inSet = 5
/*"
"
I66N-法师束带*/
set this = CreateEquipType('I66N',14,5,0,ST_LIFE,STATE_MODE_INT,86,ST_MANA,STATE_MODE_INT,9,ST_MANA_REGEN,STATE_MODE_REAL,5,ST_MANA,STATE_MODE_PERCENTAGE,120,ST_INT,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+86 生命\n+9 法力\n+0.05 法力恢复\n|cff20c000+1.2%% 法力|r\n|cff20c000+1.2%% 智力|r"
set this.name = "|cff20c000法师束带|r\n\n腰带 - 等级14"
set this.inSet = 2
/*"
"
I66O-盗贼束带*/
set this = CreateEquipType('I66O',14,5,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,86,ST_LIFE_REGEN,STATE_MODE_REAL,19,ST_AGI,STATE_MODE_PERCENTAGE,120,ST_EVADE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+86 生命\n+0.19 生命恢复\n|cff20c000+1.2%% 敏捷|r\n|cff20c000+1.2%% 闪避|r"
set this.name = "|cff20c000盗贼束带|r\n\n腰带 - 等级14"
set this.inSet = 3
/*"
"
I66P-防卫束带*/
set this = CreateEquipType('I66P',14,5,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,86,ST_BLOCK,STATE_MODE_INT,8,ST_ARMOR,STATE_MODE_PERCENTAGE,120,ST_LIFE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+86 生命\n+8 格挡\n|cff20c000+1.2%% 护甲|r\n|cff20c000+1.2%% 生命|r"
set this.name = "|cff20c000防卫束带|r\n\n腰带 - 等级14"
set this.inSet = 4
/*"
"
I66Q-角斗束带*/
set this = CreateEquipType('I66Q',14,5,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,86,ST_LIFE_REGEN,STATE_MODE_REAL,19,ST_STR,STATE_MODE_PERCENTAGE,120,ST_RESISTANCE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+86 生命\n+0.19 生命恢复\n|cff20c000+1.2%% 力量|r\n|cff20c000+1.2%% 法术抗性|r"
set this.name = "|cff20c000角斗束带|r\n\n腰带 - 等级14"
set this.inSet = 5
/*"
"
I66R-法师束带*/
set this = CreateEquipType('I66R',18,5,0,ST_LIFE,STATE_MODE_INT,115,ST_MANA,STATE_MODE_INT,12,ST_MANA_REGEN,STATE_MODE_REAL,6,ST_MANA,STATE_MODE_PERCENTAGE,120,ST_INT,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+115 生命\n+12 法力\n+0.06 法力恢复\n|cff20c000+1.2%% 法力|r\n|cff20c000+1.2%% 智力|r"
set this.name = "|cff20c000法师束带|r\n\n腰带 - 等级18"
set this.inSet = 2
/*"
"
I66S-盗贼束带*/
set this = CreateEquipType('I66S',18,5,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,115,ST_LIFE_REGEN,STATE_MODE_REAL,24,ST_AGI,STATE_MODE_PERCENTAGE,120,ST_EVADE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+115 生命\n+0.24 生命恢复\n|cff20c000+1.2%% 敏捷|r\n|cff20c000+1.2%% 闪避|r"
set this.name = "|cff20c000盗贼束带|r\n\n腰带 - 等级18"
set this.inSet = 3
/*"
"
I66T-防卫束带*/
set this = CreateEquipType('I66T',18,5,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,115,ST_BLOCK,STATE_MODE_INT,10,ST_ARMOR,STATE_MODE_PERCENTAGE,120,ST_LIFE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+115 生命\n+10 格挡\n|cff20c000+1.2%% 护甲|r\n|cff20c000+1.2%% 生命|r"
set this.name = "|cff20c000防卫束带|r\n\n腰带 - 等级18"
set this.inSet = 4
/*"
"
I66U-角斗束带*/
set this = CreateEquipType('I66U',18,5,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,115,ST_LIFE_REGEN,STATE_MODE_REAL,24,ST_STR,STATE_MODE_PERCENTAGE,120,ST_RESISTANCE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+115 生命\n+0.24 生命恢复\n|cff20c000+1.2%% 力量|r\n|cff20c000+1.2%% 法术抗性|r"
set this.name = "|cff20c000角斗束带|r\n\n腰带 - 等级18"
set this.inSet = 5
/*"
"
I66V-法师束带*/
set this = CreateEquipType('I66V',20,5,0,ST_LIFE,STATE_MODE_INT,129,ST_MANA,STATE_MODE_INT,13,ST_MANA_REGEN,STATE_MODE_REAL,7,ST_MANA,STATE_MODE_PERCENTAGE,120,ST_INT,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+129 生命\n+13 法力\n+0.07 法力恢复\n|cff20c000+1.2%% 法力|r\n|cff20c000+1.2%% 智力|r"
set this.name = "|cff20c000法师束带|r\n\n腰带 - 等级20"
set this.inSet = 2
/*"
"
I66W-盗贼束带*/
set this = CreateEquipType('I66W',20,5,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,129,ST_LIFE_REGEN,STATE_MODE_REAL,27,ST_AGI,STATE_MODE_PERCENTAGE,120,ST_EVADE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+129 生命\n+0.27 生命恢复\n|cff20c000+1.2%% 敏捷|r\n|cff20c000+1.2%% 闪避|r"
set this.name = "|cff20c000盗贼束带|r\n\n腰带 - 等级20"
set this.inSet = 3
/*"
"
I66X-防卫束带*/
set this = CreateEquipType('I66X',20,5,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,129,ST_BLOCK,STATE_MODE_INT,11,ST_ARMOR,STATE_MODE_PERCENTAGE,120,ST_LIFE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+129 生命\n+11 格挡\n|cff20c000+1.2%% 护甲|r\n|cff20c000+1.2%% 生命|r"
set this.name = "|cff20c000防卫束带|r\n\n腰带 - 等级20"
set this.inSet = 4
/*"
"
I66Y-角斗束带*/
set this = CreateEquipType('I66Y',20,5,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,129,ST_LIFE_REGEN,STATE_MODE_REAL,27,ST_STR,STATE_MODE_PERCENTAGE,120,ST_RESISTANCE,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+129 生命\n+0.27 生命恢复\n|cff20c000+1.2%% 力量|r\n|cff20c000+1.2%% 法术抗性|r"
set this.name = "|cff20c000角斗束带|r\n\n腰带 - 等级20"
set this.inSet = 5
/*"
"
I66Z-基石指环*/
set this = CreateEquipType('I66Z',10,2,0,ST_LIFE,STATE_MODE_INT,96,ST_MANA,STATE_MODE_INT,12,ST_MAIN,STATE_MODE_INT,7,ST_MAIN,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+96 生命\n+12 法力\n+7 主属性\n|cff20c000+2%% 主属性|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000基石指环|r\n\n戒指 - 等级10"
set this.inSet = 0
/*"
"
I670-通才指环*/
set this = CreateEquipType('I670',10,2,0,ST_STR,STATE_MODE_INT,7,ST_AGI,STATE_MODE_INT,7,ST_INT,STATE_MODE_INT,7,ST_LIFE,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 力量\n+7 敏捷\n+7 智力\n|cff20c000+2%% 生命|r\n|cff20c000+2%% 法力|r"
set this.name = "|cff20c000通才指环|r\n\n戒指 - 等级10"
set this.inSet = 0
/*"
"
I671-坚固指环*/
set this = CreateEquipType('I671',10,2,0,ST_ARMOR,STATE_MODE_INT,4,ST_BLOCK,STATE_MODE_INT,9,ST_ACCURACY,STATE_MODE_PERCENTAGE,370,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_RESISTANCE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+9 格挡\n+3.7%% 命中\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 法术抗性|r"
set this.name = "|cff20c000坚固指环|r\n\n戒指 - 等级10"
set this.inSet = 0
/*"
"
I672-基石指环*/
set this = CreateEquipType('I672',14,2,0,ST_LIFE,STATE_MODE_INT,144,ST_MANA,STATE_MODE_INT,16,ST_MAIN,STATE_MODE_INT,11,ST_MAIN,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+144 生命\n+16 法力\n+11 主属性\n|cff20c000+2%% 主属性|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000基石指环|r\n\n戒指 - 等级14"
set this.inSet = 0
/*"
"
I673-通才指环*/
set this = CreateEquipType('I673',14,2,0,ST_STR,STATE_MODE_INT,11,ST_AGI,STATE_MODE_INT,11,ST_INT,STATE_MODE_INT,11,ST_LIFE,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+11 力量\n+11 敏捷\n+11 智力\n|cff20c000+2%% 生命|r\n|cff20c000+2%% 法力|r"
set this.name = "|cff20c000通才指环|r\n\n戒指 - 等级14"
set this.inSet = 0
/*"
"
I674-坚固指环*/
set this = CreateEquipType('I674',14,2,0,ST_ARMOR,STATE_MODE_INT,5,ST_BLOCK,STATE_MODE_INT,13,ST_ACCURACY,STATE_MODE_PERCENTAGE,410,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_RESISTANCE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+13 格挡\n+4.1%% 命中\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 法术抗性|r"
set this.name = "|cff20c000坚固指环|r\n\n戒指 - 等级14"
set this.inSet = 0
/*"
"
I675-基石指环*/
set this = CreateEquipType('I675',18,2,0,ST_LIFE,STATE_MODE_INT,192,ST_MANA,STATE_MODE_INT,20,ST_MAIN,STATE_MODE_INT,14,ST_MAIN,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+192 生命\n+20 法力\n+14 主属性\n|cff20c000+2%% 主属性|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000基石指环|r\n\n戒指 - 等级18"
set this.inSet = 0
/*"
"
I676-通才指环*/
set this = CreateEquipType('I676',18,2,0,ST_STR,STATE_MODE_INT,14,ST_AGI,STATE_MODE_INT,14,ST_INT,STATE_MODE_INT,14,ST_LIFE,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+14 力量\n+14 敏捷\n+14 智力\n|cff20c000+2%% 生命|r\n|cff20c000+2%% 法力|r"
set this.name = "|cff20c000通才指环|r\n\n戒指 - 等级18"
set this.inSet = 0
/*"
"
I677-坚固指环*/
set this = CreateEquipType('I677',18,2,0,ST_ARMOR,STATE_MODE_INT,6,ST_BLOCK,STATE_MODE_INT,17,ST_ACCURACY,STATE_MODE_PERCENTAGE,450,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_RESISTANCE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+17 格挡\n+4.5%% 命中\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 法术抗性|r"
set this.name = "|cff20c000坚固指环|r\n\n戒指 - 等级18"
set this.inSet = 0
/*"
"
I678-基石指环*/
set this = CreateEquipType('I678',20,2,0,ST_LIFE,STATE_MODE_INT,216,ST_MANA,STATE_MODE_INT,22,ST_MAIN,STATE_MODE_INT,15,ST_MAIN,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+216 生命\n+22 法力\n+15 主属性\n|cff20c000+2%% 主属性|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000基石指环|r\n\n戒指 - 等级20"
set this.inSet = 0
/*"
"
I679-通才指环*/
set this = CreateEquipType('I679',20,2,0,ST_STR,STATE_MODE_INT,15,ST_AGI,STATE_MODE_INT,15,ST_INT,STATE_MODE_INT,15,ST_LIFE,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+15 力量\n+15 敏捷\n+15 智力\n|cff20c000+2%% 生命|r\n|cff20c000+2%% 法力|r"
set this.name = "|cff20c000通才指环|r\n\n戒指 - 等级20"
set this.inSet = 0
/*"
"
I67A-坚固指环*/
set this = CreateEquipType('I67A',20,2,0,ST_ARMOR,STATE_MODE_INT,7,ST_BLOCK,STATE_MODE_INT,19,ST_ACCURACY,STATE_MODE_PERCENTAGE,470,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_RESISTANCE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+19 格挡\n+4.7%% 命中\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 法术抗性|r"
set this.name = "|cff20c000坚固指环|r\n\n戒指 - 等级20"
set this.inSet = 0
/*"
"
I67B-优雅短剑*/
set this = CreateEquipType('I67B',10,1,0,ST_ATTACK,STATE_MODE_INT,18,ST_AGI,STATE_MODE_INT,11,ST_ACCURACY,STATE_MODE_PERCENTAGE,555,ST_HASTE,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+18 攻击\n+11 敏捷\n+5.55%% 命中\n|cff20c000+3%% 急速|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000优雅短剑|r\n\n[近]武器 - 等级10"
set this.inSet = 0
/*"
"
I67C-锋刃匕首*/
set this = CreateEquipType('I67C',10,1,0,ST_ATTACK,STATE_MODE_INT,18,ST_AGI,STATE_MODE_INT,11,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_EVADE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+18 攻击\n+11 敏捷\n+7.5%% 攻击速度\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 闪避|r"
set this.name = "|cff20c000锋刃匕首|r\n\n[近]武器 - 等级10"
set this.inSet = 0
/*"
"
I67D-矮人战斧*/
set this = CreateEquipType('I67D',10,1,0,ST_ATTACK,STATE_MODE_INT,18,ST_STR,STATE_MODE_INT,11,ST_ARMOR_PEN,STATE_MODE_INT,8,ST_STR,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+18 攻击\n+11 力量\n+8 护甲穿透\n|cff20c000+3%% 力量|r\n|cff20c000+6%% 暴击伤害|r"
set this.name = "|cff20c000矮人战斧|r\n\n[近]武器 - 等级10"
set this.inSet = 0
/*"
"
I67E-黑色战锤*/
set this = CreateEquipType('I67E',10,1,0,ST_ATTACK,STATE_MODE_INT,19,ST_STR,STATE_MODE_INT,12,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,-1500,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+19 攻击\n+12 力量\n|cffff0000-15%% 攻击速度|r\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000黑色战锤|r\n\n[近]武器 - 等级10"
set this.inSet = 0
/*"
"
I67F-劫掠之弓*/
set this = CreateEquipType('I67F',10,2,0,ST_ATTACK,STATE_MODE_INT,18,ST_AGI,STATE_MODE_INT,11,ST_ACCURACY,STATE_MODE_PERCENTAGE,555,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+18 攻击\n+11 敏捷\n+5.55%% 命中\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000劫掠之弓|r\n\n[远]武器 - 等级10"
set this.inSet = 0
/*"
"
I67G-猎人长枪*/
set this = CreateEquipType('I67G',10,2,0,ST_ATTACK,STATE_MODE_INT,18,ST_STR,STATE_MODE_INT,11,ST_ARMOR_PEN,STATE_MODE_INT,8,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+18 攻击\n+11 力量\n+8 护甲穿透\n|cff20c000+3%% 攻击|r\n|cff20c000+3%% 急速|r"
set this.name = "|cff20c000猎人长枪|r\n\n[远]武器 - 等级10"
set this.inSet = 0
/*"
"
I67H-导魔法杖*/
set this = CreateEquipType('I67H',10,4,0,ST_ABILITY_POWER,STATE_MODE_INT,18,ST_MANA,STATE_MODE_INT,18,ST_INT,STATE_MODE_INT,11,ST_HASTE,STATE_MODE_PERCENTAGE,300,ST_COST_REDUCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+18 法术强度\n+18 法力\n+11 智力\n|cff20c000+3%% 急速|r\n|cff20c000+3%% 节能施法|r"
set this.name = "|cff20c000导魔法杖|r\n\n[法]武器 - 等级10"
set this.inSet = 0
/*"
"
I67I-和谐权杖*/
set this = CreateEquipType('I67I',10,5,0,ST_ABILITY_POWER,STATE_MODE_INT,18,ST_INT,STATE_MODE_INT,11,ST_MANA_REGEN,STATE_MODE_REAL,12,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,300,ST_MANA,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+18 法术强度\n+11 智力\n+0.12 法力恢复\n|cff20c000+3%% 法术强度|r\n|cff20c000+3%% 法力|r"
set this.name = "|cff20c000和谐权杖|r\n\n[近|法]武器 - 等级10"
set this.inSet = 0
/*"
"
I67J-优雅短剑*/
set this = CreateEquipType('I67J',14,1,0,ST_ATTACK,STATE_MODE_INT,25,ST_AGI,STATE_MODE_INT,16,ST_ACCURACY,STATE_MODE_PERCENTAGE,615,ST_HASTE,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+25 攻击\n+16 敏捷\n+6.15%% 命中\n|cff20c000+3%% 急速|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000优雅短剑|r\n\n[近]武器 - 等级14"
set this.inSet = 0
/*"
"
I67K-锋刃匕首*/
set this = CreateEquipType('I67K',14,1,0,ST_ATTACK,STATE_MODE_INT,25,ST_AGI,STATE_MODE_INT,16,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_EVADE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+25 攻击\n+16 敏捷\n+7.5%% 攻击速度\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 闪避|r"
set this.name = "|cff20c000锋刃匕首|r\n\n[近]武器 - 等级14"
set this.inSet = 0
/*"
"
I67L-矮人战斧*/
set this = CreateEquipType('I67L',14,1,0,ST_ATTACK,STATE_MODE_INT,25,ST_STR,STATE_MODE_INT,16,ST_ARMOR_PEN,STATE_MODE_INT,11,ST_STR,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+25 攻击\n+16 力量\n+11 护甲穿透\n|cff20c000+3%% 力量|r\n|cff20c000+6%% 暴击伤害|r"
set this.name = "|cff20c000矮人战斧|r\n\n[近]武器 - 等级14"
set this.inSet = 0
/*"
"
I67M-黑色战锤*/
set this = CreateEquipType('I67M',14,1,0,ST_ATTACK,STATE_MODE_INT,27,ST_STR,STATE_MODE_INT,18,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,-1500,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+27 攻击\n+18 力量\n|cffff0000-15%% 攻击速度|r\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000黑色战锤|r\n\n[近]武器 - 等级14"
set this.inSet = 0
/*"
"
I67N-劫掠之弓*/
set this = CreateEquipType('I67N',14,2,0,ST_ATTACK,STATE_MODE_INT,25,ST_AGI,STATE_MODE_INT,16,ST_ACCURACY,STATE_MODE_PERCENTAGE,615,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+25 攻击\n+16 敏捷\n+6.15%% 命中\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000劫掠之弓|r\n\n[远]武器 - 等级14"
set this.inSet = 0
/*"
"
I67O-猎人长枪*/
set this = CreateEquipType('I67O',14,2,0,ST_ATTACK,STATE_MODE_INT,25,ST_STR,STATE_MODE_INT,16,ST_ARMOR_PEN,STATE_MODE_INT,11,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+25 攻击\n+16 力量\n+11 护甲穿透\n|cff20c000+3%% 攻击|r\n|cff20c000+3%% 急速|r"
set this.name = "|cff20c000猎人长枪|r\n\n[远]武器 - 等级14"
set this.inSet = 0
/*"
"
I67P-导魔法杖*/
set this = CreateEquipType('I67P',14,4,0,ST_ABILITY_POWER,STATE_MODE_INT,25,ST_MANA,STATE_MODE_INT,24,ST_INT,STATE_MODE_INT,16,ST_HASTE,STATE_MODE_PERCENTAGE,300,ST_COST_REDUCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+25 法术强度\n+24 法力\n+16 智力\n|cff20c000+3%% 急速|r\n|cff20c000+3%% 节能施法|r"
set this.name = "|cff20c000导魔法杖|r\n\n[法]武器 - 等级14"
set this.inSet = 0
/*"
"
I67Q-和谐权杖*/
set this = CreateEquipType('I67Q',14,5,0,ST_ABILITY_POWER,STATE_MODE_INT,25,ST_INT,STATE_MODE_INT,16,ST_MANA_REGEN,STATE_MODE_REAL,14,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,300,ST_MANA,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+25 法术强度\n+16 智力\n+0.14 法力恢复\n|cff20c000+3%% 法术强度|r\n|cff20c000+3%% 法力|r"
set this.name = "|cff20c000和谐权杖|r\n\n[近|法]武器 - 等级14"
set this.inSet = 0
/*"
"
I67R-优雅短剑*/
set this = CreateEquipType('I67R',18,1,0,ST_ATTACK,STATE_MODE_INT,32,ST_AGI,STATE_MODE_INT,21,ST_ACCURACY,STATE_MODE_PERCENTAGE,675,ST_HASTE,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+32 攻击\n+21 敏捷\n+6.75%% 命中\n|cff20c000+3%% 急速|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000优雅短剑|r\n\n[近]武器 - 等级18"
set this.inSet = 0
/*"
"
I67S-锋刃匕首*/
set this = CreateEquipType('I67S',18,1,0,ST_ATTACK,STATE_MODE_INT,32,ST_AGI,STATE_MODE_INT,21,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_EVADE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+32 攻击\n+21 敏捷\n+7.5%% 攻击速度\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 闪避|r"
set this.name = "|cff20c000锋刃匕首|r\n\n[近]武器 - 等级18"
set this.inSet = 0
/*"
"
I67T-矮人战斧*/
set this = CreateEquipType('I67T',18,1,0,ST_ATTACK,STATE_MODE_INT,32,ST_STR,STATE_MODE_INT,21,ST_ARMOR_PEN,STATE_MODE_INT,14,ST_STR,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+32 攻击\n+21 力量\n+14 护甲穿透\n|cff20c000+3%% 力量|r\n|cff20c000+6%% 暴击伤害|r"
set this.name = "|cff20c000矮人战斧|r\n\n[近]武器 - 等级18"
set this.inSet = 0
/*"
"
I67U-黑色战锤*/
set this = CreateEquipType('I67U',18,1,0,ST_ATTACK,STATE_MODE_INT,35,ST_STR,STATE_MODE_INT,23,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,-1500,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+35 攻击\n+23 力量\n|cffff0000-15%% 攻击速度|r\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000黑色战锤|r\n\n[近]武器 - 等级18"
set this.inSet = 0
/*"
"
I67V-劫掠之弓*/
set this = CreateEquipType('I67V',18,2,0,ST_ATTACK,STATE_MODE_INT,32,ST_AGI,STATE_MODE_INT,21,ST_ACCURACY,STATE_MODE_PERCENTAGE,675,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+32 攻击\n+21 敏捷\n+6.75%% 命中\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000劫掠之弓|r\n\n[远]武器 - 等级18"
set this.inSet = 0
/*"
"
I67W-猎人长枪*/
set this = CreateEquipType('I67W',18,2,0,ST_ATTACK,STATE_MODE_INT,32,ST_STR,STATE_MODE_INT,21,ST_ARMOR_PEN,STATE_MODE_INT,14,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+32 攻击\n+21 力量\n+14 护甲穿透\n|cff20c000+3%% 攻击|r\n|cff20c000+3%% 急速|r"
set this.name = "|cff20c000猎人长枪|r\n\n[远]武器 - 等级18"
set this.inSet = 0
/*"
"
I67X-导魔法杖*/
set this = CreateEquipType('I67X',18,4,0,ST_ABILITY_POWER,STATE_MODE_INT,32,ST_MANA,STATE_MODE_INT,30,ST_INT,STATE_MODE_INT,21,ST_HASTE,STATE_MODE_PERCENTAGE,300,ST_COST_REDUCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+32 法术强度\n+30 法力\n+21 智力\n|cff20c000+3%% 急速|r\n|cff20c000+3%% 节能施法|r"
set this.name = "|cff20c000导魔法杖|r\n\n[法]武器 - 等级18"
set this.inSet = 0
/*"
"
I67Y-和谐权杖*/
set this = CreateEquipType('I67Y',18,5,0,ST_ABILITY_POWER,STATE_MODE_INT,32,ST_INT,STATE_MODE_INT,21,ST_MANA_REGEN,STATE_MODE_REAL,16,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,300,ST_MANA,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+32 法术强度\n+21 智力\n+0.16 法力恢复\n|cff20c000+3%% 法术强度|r\n|cff20c000+3%% 法力|r"
set this.name = "|cff20c000和谐权杖|r\n\n[近|法]武器 - 等级18"
set this.inSet = 0
/*"
"
I67Z-优雅短剑*/
set this = CreateEquipType('I67Z',20,1,0,ST_ATTACK,STATE_MODE_INT,36,ST_AGI,STATE_MODE_INT,23,ST_ACCURACY,STATE_MODE_PERCENTAGE,705,ST_HASTE,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+36 攻击\n+23 敏捷\n+7.05%% 命中\n|cff20c000+3%% 急速|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000优雅短剑|r\n\n[近]武器 - 等级20"
set this.inSet = 0
/*"
"
I680-锋刃匕首*/
set this = CreateEquipType('I680',20,1,0,ST_ATTACK,STATE_MODE_INT,36,ST_AGI,STATE_MODE_INT,23,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_EVADE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+36 攻击\n+23 敏捷\n+7.5%% 攻击速度\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 闪避|r"
set this.name = "|cff20c000锋刃匕首|r\n\n[近]武器 - 等级20"
set this.inSet = 0
/*"
"
I681-矮人战斧*/
set this = CreateEquipType('I681',20,1,0,ST_ATTACK,STATE_MODE_INT,36,ST_STR,STATE_MODE_INT,23,ST_ARMOR_PEN,STATE_MODE_INT,16,ST_STR,STATE_MODE_PERCENTAGE,300,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,600,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+36 攻击\n+23 力量\n+16 护甲穿透\n|cff20c000+3%% 力量|r\n|cff20c000+6%% 暴击伤害|r"
set this.name = "|cff20c000矮人战斧|r\n\n[近]武器 - 等级20"
set this.inSet = 0
/*"
"
I682-黑色战锤*/
set this = CreateEquipType('I682',20,1,0,ST_ATTACK,STATE_MODE_INT,39,ST_STR,STATE_MODE_INT,26,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,-1500,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+39 攻击\n+26 力量\n|cffff0000-15%% 攻击速度|r\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000黑色战锤|r\n\n[近]武器 - 等级20"
set this.inSet = 0
/*"
"
I683-劫掠之弓*/
set this = CreateEquipType('I683',20,2,0,ST_ATTACK,STATE_MODE_INT,36,ST_AGI,STATE_MODE_INT,23,ST_ACCURACY,STATE_MODE_PERCENTAGE,705,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+36 攻击\n+23 敏捷\n+7.05%% 命中\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 护甲穿透|r"
set this.name = "|cff20c000劫掠之弓|r\n\n[远]武器 - 等级20"
set this.inSet = 0
/*"
"
I684-猎人长枪*/
set this = CreateEquipType('I684',20,2,0,ST_ATTACK,STATE_MODE_INT,36,ST_STR,STATE_MODE_INT,23,ST_ARMOR_PEN,STATE_MODE_INT,16,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+36 攻击\n+23 力量\n+16 护甲穿透\n|cff20c000+3%% 攻击|r\n|cff20c000+3%% 急速|r"
set this.name = "|cff20c000猎人长枪|r\n\n[远]武器 - 等级20"
set this.inSet = 0
/*"
"
I685-导魔法杖*/
set this = CreateEquipType('I685',20,4,0,ST_ABILITY_POWER,STATE_MODE_INT,36,ST_MANA,STATE_MODE_INT,33,ST_INT,STATE_MODE_INT,23,ST_HASTE,STATE_MODE_PERCENTAGE,300,ST_COST_REDUCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+36 法术强度\n+33 法力\n+23 智力\n|cff20c000+3%% 急速|r\n|cff20c000+3%% 节能施法|r"
set this.name = "|cff20c000导魔法杖|r\n\n[法]武器 - 等级20"
set this.inSet = 0
/*"
"
I686-和谐权杖*/
set this = CreateEquipType('I686',20,5,0,ST_ABILITY_POWER,STATE_MODE_INT,36,ST_INT,STATE_MODE_INT,23,ST_MANA_REGEN,STATE_MODE_REAL,18,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,300,ST_MANA,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+36 法术强度\n+23 智力\n+0.18 法力恢复\n|cff20c000+3%% 法术强度|r\n|cff20c000+3%% 法力|r"
set this.name = "|cff20c000和谐权杖|r\n\n[近|法]武器 - 等级20"
set this.inSet = 0
/*"
"
I687-抛光圆盾*/
set this = CreateEquipType('I687',10,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,96,ST_BLOCK,STATE_MODE_INT,19,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_BLOCK,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+96 生命\n+19 格挡\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 格挡|r"
set this.name = "|cff20c000抛光圆盾|r\n\n[盾·轻]副手 - 等级10"
set this.inSet = 0
/*"
"
I688-典礼圆盾*/
set this = CreateEquipType('I688',10,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_MANA,STATE_MODE_INT,12,ST_INT,STATE_MODE_INT,7,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+12 法力\n+7 智力\n|cff20c000+2%% 法术强度|r\n|cff20c000+2%% 法力|r"
set this.name = "|cff20c000典礼圆盾|r\n\n[盾·轻]副手 - 等级10"
set this.inSet = 0
/*"
"
I689-骑士之盾*/
set this = CreateEquipType('I689',10,4,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,96,ST_BLOCK,STATE_MODE_INT,28,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,-1000,ST_LIFE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+96 生命\n+28 格挡\n|cffff0000-10%% 移动速度|r\n|cff20c000+3%% 生命|r"
set this.name = "|cff20c000骑士之盾|r\n\n[盾·重]副手 - 等级10"
set this.inSet = 0
/*"
"
I68A-占卜水晶*/
set this = CreateEquipType('I68A',10,1,0,ST_ABILITY_POWER,STATE_MODE_INT,12,ST_LIFE,STATE_MODE_INT,96,ST_INT,STATE_MODE_INT,7,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 法术强度\n+96 生命\n+7 智力\n|cff20c000+2%% 法术强度|r\n|cff20c000+2%% 暴击|r"
set this.name = "|cff20c000占卜水晶|r\n\n副手 - 等级10"
set this.inSet = 0
/*"
"
I68B-精通法书*/
set this = CreateEquipType('I68B',10,1,0,ST_ABILITY_POWER,STATE_MODE_INT,12,ST_LIFE,STATE_MODE_INT,96,ST_MANA,STATE_MODE_INT,12,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 法术强度\n+96 生命\n+12 法力\n|cff20c000+2%% 法力|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000精通法书|r\n\n副手 - 等级10"
set this.inSet = 0
/*"
"
I68C-碎颅手斧*/
set this = CreateEquipType('I68C',10,2,0,ST_ATTACK,STATE_MODE_INT,12,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ARMOR_PEN,STATE_MODE_INT,5,ST_ATTACK,STATE_MODE_PERCENTAGE,200,ST_MAIN,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 攻击\n+5%% 攻击速度\n+5 护甲穿透\n|cff20c000+2%% 攻击|r\n|cff20c000+2%% 主属性|r"
set this.name = "|cff20c000碎颅手斧|r\n\n[武器]副手 - 等级10"
set this.inSet = 0
/*"
"
I68D-暗杀刺匕*/
set this = CreateEquipType('I68D',10,2,0,ST_ATTACK,STATE_MODE_INT,12,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ACCURACY,STATE_MODE_PERCENTAGE,370,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 攻击\n+5%% 攻击速度\n+3.7%% 命中\n|cff20c000+2%% 暴击|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000暗杀刺匕|r\n\n[武器]副手 - 等级10"
set this.inSet = 0
/*"
"
I68E-抛光圆盾*/
set this = CreateEquipType('I68E',14,3,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,144,ST_BLOCK,STATE_MODE_INT,27,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_BLOCK,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+144 生命\n+27 格挡\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 格挡|r"
set this.name = "|cff20c000抛光圆盾|r\n\n[盾·轻]副手 - 等级14"
set this.inSet = 0
/*"
"
I68F-典礼圆盾*/
set this = CreateEquipType('I68F',14,3,0,ST_ARMOR,STATE_MODE_INT,6,ST_MANA,STATE_MODE_INT,16,ST_INT,STATE_MODE_INT,11,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+16 法力\n+11 智力\n|cff20c000+2%% 法术强度|r\n|cff20c000+2%% 法力|r"
set this.name = "|cff20c000典礼圆盾|r\n\n[盾·轻]副手 - 等级14"
set this.inSet = 0
/*"
"
I68G-骑士之盾*/
set this = CreateEquipType('I68G',14,4,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,144,ST_BLOCK,STATE_MODE_INT,40,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,-1000,ST_LIFE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+144 生命\n+40 格挡\n|cffff0000-10%% 移动速度|r\n|cff20c000+3%% 生命|r"
set this.name = "|cff20c000骑士之盾|r\n\n[盾·重]副手 - 等级14"
set this.inSet = 0
/*"
"
I68H-占卜水晶*/
set this = CreateEquipType('I68H',14,1,0,ST_ABILITY_POWER,STATE_MODE_INT,16,ST_LIFE,STATE_MODE_INT,144,ST_INT,STATE_MODE_INT,11,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+16 法术强度\n+144 生命\n+11 智力\n|cff20c000+2%% 法术强度|r\n|cff20c000+2%% 暴击|r"
set this.name = "|cff20c000占卜水晶|r\n\n副手 - 等级14"
set this.inSet = 0
/*"
"
I68I-精通法书*/
set this = CreateEquipType('I68I',14,1,0,ST_ABILITY_POWER,STATE_MODE_INT,16,ST_LIFE,STATE_MODE_INT,144,ST_MANA,STATE_MODE_INT,16,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+16 法术强度\n+144 生命\n+16 法力\n|cff20c000+2%% 法力|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000精通法书|r\n\n副手 - 等级14"
set this.inSet = 0
/*"
"
I68J-碎颅手斧*/
set this = CreateEquipType('I68J',14,2,0,ST_ATTACK,STATE_MODE_INT,16,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ARMOR_PEN,STATE_MODE_INT,7,ST_ATTACK,STATE_MODE_PERCENTAGE,200,ST_MAIN,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+16 攻击\n+5%% 攻击速度\n+7 护甲穿透\n|cff20c000+2%% 攻击|r\n|cff20c000+2%% 主属性|r"
set this.name = "|cff20c000碎颅手斧|r\n\n[武器]副手 - 等级14"
set this.inSet = 0
/*"
"
I68K-暗杀刺匕*/
set this = CreateEquipType('I68K',14,2,0,ST_ATTACK,STATE_MODE_INT,16,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ACCURACY,STATE_MODE_PERCENTAGE,410,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+16 攻击\n+5%% 攻击速度\n+4.1%% 命中\n|cff20c000+2%% 暴击|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000暗杀刺匕|r\n\n[武器]副手 - 等级14"
set this.inSet = 0
/*"
"
I68L-抛光圆盾*/
set this = CreateEquipType('I68L',18,3,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,192,ST_BLOCK,STATE_MODE_INT,35,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_BLOCK,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+192 生命\n+35 格挡\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 格挡|r"
set this.name = "|cff20c000抛光圆盾|r\n\n[盾·轻]副手 - 等级18"
set this.inSet = 0
/*"
"
I68M-典礼圆盾*/
set this = CreateEquipType('I68M',18,3,0,ST_ARMOR,STATE_MODE_INT,8,ST_MANA,STATE_MODE_INT,20,ST_INT,STATE_MODE_INT,14,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+20 法力\n+14 智力\n|cff20c000+2%% 法术强度|r\n|cff20c000+2%% 法力|r"
set this.name = "|cff20c000典礼圆盾|r\n\n[盾·轻]副手 - 等级18"
set this.inSet = 0
/*"
"
I68N-骑士之盾*/
set this = CreateEquipType('I68N',18,4,0,ST_ARMOR,STATE_MODE_INT,9,ST_LIFE,STATE_MODE_INT,192,ST_BLOCK,STATE_MODE_INT,52,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,-1000,ST_LIFE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 护甲\n+192 生命\n+52 格挡\n|cffff0000-10%% 移动速度|r\n|cff20c000+3%% 生命|r"
set this.name = "|cff20c000骑士之盾|r\n\n[盾·重]副手 - 等级18"
set this.inSet = 0
/*"
"
I68O-占卜水晶*/
set this = CreateEquipType('I68O',18,1,0,ST_ABILITY_POWER,STATE_MODE_INT,21,ST_LIFE,STATE_MODE_INT,192,ST_INT,STATE_MODE_INT,14,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+21 法术强度\n+192 生命\n+14 智力\n|cff20c000+2%% 法术强度|r\n|cff20c000+2%% 暴击|r"
set this.name = "|cff20c000占卜水晶|r\n\n副手 - 等级18"
set this.inSet = 0
/*"
"
I68P-精通法书*/
set this = CreateEquipType('I68P',18,1,0,ST_ABILITY_POWER,STATE_MODE_INT,21,ST_LIFE,STATE_MODE_INT,192,ST_MANA,STATE_MODE_INT,20,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+21 法术强度\n+192 生命\n+20 法力\n|cff20c000+2%% 法力|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000精通法书|r\n\n副手 - 等级18"
set this.inSet = 0
/*"
"
I68Q-碎颅手斧*/
set this = CreateEquipType('I68Q',18,2,0,ST_ATTACK,STATE_MODE_INT,21,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ARMOR_PEN,STATE_MODE_INT,9,ST_ATTACK,STATE_MODE_PERCENTAGE,200,ST_MAIN,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+21 攻击\n+5%% 攻击速度\n+9 护甲穿透\n|cff20c000+2%% 攻击|r\n|cff20c000+2%% 主属性|r"
set this.name = "|cff20c000碎颅手斧|r\n\n[武器]副手 - 等级18"
set this.inSet = 0
/*"
"
I68R-暗杀刺匕*/
set this = CreateEquipType('I68R',18,2,0,ST_ATTACK,STATE_MODE_INT,21,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ACCURACY,STATE_MODE_PERCENTAGE,450,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+21 攻击\n+5%% 攻击速度\n+4.5%% 命中\n|cff20c000+2%% 暴击|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000暗杀刺匕|r\n\n[武器]副手 - 等级18"
set this.inSet = 0
/*"
"
I68S-抛光圆盾*/
set this = CreateEquipType('I68S',20,3,0,ST_ARMOR,STATE_MODE_INT,9,ST_LIFE,STATE_MODE_INT,216,ST_BLOCK,STATE_MODE_INT,39,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_BLOCK,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 护甲\n+216 生命\n+39 格挡\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 格挡|r"
set this.name = "|cff20c000抛光圆盾|r\n\n[盾·轻]副手 - 等级20"
set this.inSet = 0
/*"
"
I68T-典礼圆盾*/
set this = CreateEquipType('I68T',20,3,0,ST_ARMOR,STATE_MODE_INT,9,ST_MANA,STATE_MODE_INT,22,ST_INT,STATE_MODE_INT,15,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 护甲\n+22 法力\n+15 智力\n|cff20c000+2%% 法术强度|r\n|cff20c000+2%% 法力|r"
set this.name = "|cff20c000典礼圆盾|r\n\n[盾·轻]副手 - 等级20"
set this.inSet = 0
/*"
"
I68U-骑士之盾*/
set this = CreateEquipType('I68U',20,4,0,ST_ARMOR,STATE_MODE_INT,10,ST_LIFE,STATE_MODE_INT,216,ST_BLOCK,STATE_MODE_INT,58,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,-1000,ST_LIFE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+10 护甲\n+216 生命\n+58 格挡\n|cffff0000-10%% 移动速度|r\n|cff20c000+3%% 生命|r"
set this.name = "|cff20c000骑士之盾|r\n\n[盾·重]副手 - 等级20"
set this.inSet = 0
/*"
"
I68V-占卜水晶*/
set this = CreateEquipType('I68V',20,1,0,ST_ABILITY_POWER,STATE_MODE_INT,24,ST_LIFE,STATE_MODE_INT,216,ST_INT,STATE_MODE_INT,15,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+24 法术强度\n+216 生命\n+15 智力\n|cff20c000+2%% 法术强度|r\n|cff20c000+2%% 暴击|r"
set this.name = "|cff20c000占卜水晶|r\n\n副手 - 等级20"
set this.inSet = 0
/*"
"
I68W-精通法书*/
set this = CreateEquipType('I68W',20,1,0,ST_ABILITY_POWER,STATE_MODE_INT,24,ST_LIFE,STATE_MODE_INT,216,ST_MANA,STATE_MODE_INT,22,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+24 法术强度\n+216 生命\n+22 法力\n|cff20c000+2%% 法力|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000精通法书|r\n\n副手 - 等级20"
set this.inSet = 0
/*"
"
I68X-碎颅手斧*/
set this = CreateEquipType('I68X',20,2,0,ST_ATTACK,STATE_MODE_INT,24,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ARMOR_PEN,STATE_MODE_INT,10,ST_ATTACK,STATE_MODE_PERCENTAGE,200,ST_MAIN,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+24 攻击\n+5%% 攻击速度\n+10 护甲穿透\n|cff20c000+2%% 攻击|r\n|cff20c000+2%% 主属性|r"
set this.name = "|cff20c000碎颅手斧|r\n\n[武器]副手 - 等级20"
set this.inSet = 0
/*"
"
I68Y-暗杀刺匕*/
set this = CreateEquipType('I68Y',20,2,0,ST_ATTACK,STATE_MODE_INT,24,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ACCURACY,STATE_MODE_PERCENTAGE,470,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+24 攻击\n+5%% 攻击速度\n+4.7%% 命中\n|cff20c000+2%% 暴击|r\n|cff20c000+2%% 急速|r"
set this.name = "|cff20c000暗杀刺匕|r\n\n[武器]副手 - 等级20"
set this.inSet = 0
/*"
"
I68Z-血羽之心*/
set this = CreateEquipType('I68Z',11,1,'AA08',ST_AGI,STATE_MODE_INT,13,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_ARMOR_PEN,STATE_MODE_INT,9,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+13 敏捷\n+7.5%% 攻击速度\n+9 护甲穿透\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 暴击|r|N|cffffcc00赋予技能：|r|n|cff20c000鲜血献祭：|r牺牲生命值，提高急速和暴击。"
set this.name = "|cff20c000血羽之心|r\n\n护符 - 等级11"
set this.inSet = 0
/*"
"
I690-元素之章*/
set this = CreateEquipType('I690',11,1,'AA09',ST_INT,STATE_MODE_INT,13,ST_MANA,STATE_MODE_INT,21,ST_MANA_REGEN,STATE_MODE_REAL,12,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,300,ST_MANA_REGEN,STATE_MODE_PERCENTAGE,750,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+13 智力\n+21 法力\n+0.12 法力恢复\n|cff20c000+3%% 法术强度|r\n|cff20c000+7.5%% 法力恢复|r|N|cffffcc00赋予技能：|r|n|cff20c000元素之体：|r依照造成的伤害元素，为你提供特性。"
set this.name = "|cff20c000元素之章|r\n\n护符 - 等级11"
set this.inSet = 0
/*"
"
I691-暴掠之血*/
set this = CreateEquipType('I691',14,1,'AA0A',ST_STR,STATE_MODE_INT,16,ST_LIFE_REGEN,STATE_MODE_REAL,49,ST_BLOCK,STATE_MODE_INT,20,ST_BLOCK,STATE_MODE_PERCENTAGE,300,ST_VERSATILITY,STATE_MODE_PERCENTAGE,225,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+16 力量\n+0.49 生命恢复\n+20 格挡\n|cff20c000+3%% 格挡|r\n|cff20c000+2.25%% 全能|r|N|cffffcc00赋予技能：|r|n|cff20c000霸体：|r免疫控制并驱散不利效果，嘲讽附近的敌人。"
set this.name = "|cff20c000暴掠之血|r\n\n护符 - 等级14"
set this.inSet = 0
/*"
"
I692-沙虫塔盾*/
set this = CreateEquipType('I692',12,4,0,ST_ARMOR,STATE_MODE_INT,7,ST_BLOCK,STATE_MODE_INT,37,ST_LIFE_REGEN,STATE_MODE_REAL,31,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,-1000,ST_MAX_BLOCK,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+37 格挡\n+0.31 生命恢复\n|cffff0000-10%% 移动速度|r\n|cff20c000+2%% 格挡伤害上限|r"
set this.name = "|cff20c000沙虫塔盾|r\n\n[盾·重]副手 - 等级12"
set this.inSet = 0
/*"
"
I693-阿伽玛甘之首*/
set this = CreateEquipType('I693',12,3,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,101,ST_AGI,STATE_MODE_INT,7,ST_HASTE,STATE_MODE_PERCENTAGE,140,ST_EVADE,STATE_MODE_PERCENTAGE,140,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+101 生命\n+7 敏捷\n|cff20c000+1.4%% 急速|r\n|cff20c000+1.4%% 闪避|r"
set this.name = "|cff20c000阿伽玛甘之首|r\n\n[中]头盔 - 等级12"
set this.inSet = 0
/*"
"
I694-迷失法衣*/
set this = CreateEquipType('I694',14,2,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,216,ST_INT,STATE_MODE_INT,16,ST_VERSATILITY,STATE_MODE_PERCENTAGE,225,ST_COST_REDUCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+216 生命\n+16 智力\n|cff20c000+2.25%% 全能|r\n|cff20c000+3%% 节能施法|r"
set this.name = "|cff20c000迷失法衣|r\n\n[轻]护甲 - 等级14"
set this.inSet = 0
/*"
"
I695-蒸汽锤*/
set this = CreateEquipType('I695',11,1,0,ST_ATTACK,STATE_MODE_INT,20,ST_STR,STATE_MODE_INT,13,ST_ACCURACY,STATE_MODE_PERCENTAGE,577,ST_EVADE,STATE_MODE_PERCENTAGE,300,ST_VERSATILITY,STATE_MODE_PERCENTAGE,225,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+20 攻击\n+13 力量\n+5.77%% 命中\n|cff20c000+3%% 闪避|r\n|cff20c000+2.25%% 全能|r"
set this.name = "|cff20c000蒸汽锤|r\n\n[近]武器 - 等级11"
set this.inSet = 0
/*"
"
I696-沙暴之手*/
set this = CreateEquipType('I696',11,4,0,ST_ATTACK,STATE_MODE_INT,8,ST_ARMOR_PEN,STATE_MODE_INT,3,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,120,ST_DAMAGE_BONUS,STATE_MODE_PERCENTAGE,120,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 攻击\n+3 护甲穿透\n+3%% 攻击速度\n|cff20c000+1.2%% 暴击|r\n|cff20c000+1.2%% 伤害加成|r"
set this.name = "|cff20c000沙暴之手|r\n\n手套 - 等级11"
set this.inSet = 0
/*"

        // endregion
        */
    endfunction

    function initEquipmentTypes_331 takes nothing returns nothing
        local EquipType this
        call DestroyTimer(GetExpiredTimer())
        /*
        // region equip PASTE HERE"
        "
I697-联盟徽记*/
set this = CreateEquipType('I697',8,1,'AA0B',ST_STR,STATE_MODE_INT,12,ST_AGI,STATE_MODE_INT,12,ST_INT,STATE_MODE_INT,12,ST_MAIN,STATE_MODE_PERCENTAGE,300,ST_VERSATILITY,STATE_MODE_PERCENTAGE,225,ST_LEECH,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAtking( function ItemSFX_ManaSiphon )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+12 力量\n+12 敏捷\n+12 智力\n|cff20c000+3%% 主属性|r\n|cff20c000+2.25%% 全能|r\n|cff20c000+3%% 吸血|r\n|cffffcc00效果：|r\n|cff20c000魔力虹吸：|r攻击时，有30%%的几率回复1点法力。|N|cffffcc00赋予技能：|r|n|cff20c000英勇：|r张开光环，提高盟友的全能。"
set this.name = "|cff0070dd联盟徽记|r\n\n护符 - 等级8"
set this.inSet = 0
/*"
"
I698-法师之拳*/
set this = CreateEquipType('I698',9,4,0,ST_INT,STATE_MODE_INT,6,ST_MANA_REGEN,STATE_MODE_REAL,5,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,120,ST_HASTE,STATE_MODE_PERCENTAGE,120,ST_DAMAGE_BONUS,STATE_MODE_PERCENTAGE,120,0,0,0)
call this.addDmging_S( function ItemSFX_EnhanceFire2 )
call this.addBefDmg_S( function ItemSFX_FrostFire )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 智力\n+0.05 法力恢复\n+3%% 攻击速度\n|cff20c000+1.2%% 暴击|r\n|cff20c000+1.2%% 急速|r\n|cff20c000+1.2%% 伤害加成|r\n|cffffcc00效果：|r\n|cff20c000火焰增效(II)：|r火焰伤害提高5%%[x]。\n|cff20c000霜火：|r你的冰霜伤害也视为火焰元素，火焰伤害也视为冰霜元素。"
set this.name = "|cffa334ee法师之拳|r\n\n手套 - 等级9"
set this.inSet = 0
/*"
"
I699-猎手之眼*/
set this = CreateEquipType('I699',9,3,0,ST_AGI,STATE_MODE_INT,11,ST_ARMOR_PEN,STATE_MODE_INT,7,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_AGI,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,ST_EVADE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addDmging_S( function ItemSFX_EnhanceEarth )
call this.addDmging_T( function ItemSFX_DefendToxin )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+11 敏捷\n+7 护甲穿透\n+5%% 攻击速度\n|cff20c000+2%% 敏捷|r\n|cff20c000+2%% 急速|r\n|cff20c000+2%% 闪避|r\n|cffffcc00效果：|r\n|cff20c000自然增效：|r自然伤害提高3%%[x]。\n|cff20c000毒素防护：|r受到的中毒伤害降低5%%[x]。"
set this.name = "|cffa334ee猎手之眼|r\n\n[唯一]戒指 - 等级9"
set this.inSet = 0
/*"
"
I69A-巨人之息*/
set this = CreateEquipType('I69A',9,4,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,110,ST_STR,STATE_MODE_INT,7,ST_STR,STATE_MODE_PERCENTAGE,140,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,280,ST_VERSATILITY,STATE_MODE_PERCENTAGE,105,0,0,0)
call this.addDmging_S( function ItemSFX_EnhanceFire )
call this.addDmging_T( function ItemSFX_DefendBleed )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+110 生命\n+7 力量\n|cff20c000+1.4%% 力量|r\n|cff20c000+2.8%% 暴击伤害|r\n|cff20c000+1.05%% 全能|r\n|cffffcc00效果：|r\n|cff20c000火焰增效：|r火焰伤害提高3%%[x]。\n|cff20c000流血防护：|r受到的流血伤害降低5%%[x]。"
set this.name = "|cffa334ee巨人之息|r\n\n[重]头盔 - 等级9"
set this.inSet = 0
/*"
"
I69B-温润之玉*/
set this = CreateEquipType('I69B',9,3,0,ST_INT,STATE_MODE_INT,9,ST_MANA_REGEN,STATE_MODE_REAL,8,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addSpelling( function ItemSFX_Nourish )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 智力\n+0.08 法力恢复\n+5%% 攻击速度\n|cff20c000+2%% 法术强度|r\n|cff20c000+2%% 法力|r\n|cff20c000+2%% 急速|r\n|cffffcc00效果：|r\n|cff20c000滋养：|r施法时，有30%%的几率恢复消耗法力的200%%。触发后有30秒冷却时间。"
set this.name = "|cff0070dd温润之玉|r\n\n[唯一]戒指 - 等级9"
set this.inSet = 0
/*"
"
I69C-爆裂之石*/
set this = CreateEquipType('I69C',9,3,0,ST_STR,STATE_MODE_INT,9,ST_ARMOR_PEN,STATE_MODE_INT,6,ST_ACCURACY,STATE_MODE_PERCENTAGE,385,ST_ATTACK,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,200,ST_DAMAGE_BONUS,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addDmging_S( function ItemSFX_Reckless )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 力量\n+6 护甲穿透\n+3.85%% 命中\n|cff20c000+2%% 攻击|r\n|cff20c000+2%% 暴击|r\n|cff20c000+2%% 伤害加成|r\n|cffffcc00效果：|r\n|cff20c000无谋：|r法力不足50%%时，造成的伤害提高7%%[x]。"
set this.name = "|cff0070dd爆裂之石|r\n\n[唯一]戒指 - 等级9"
set this.inSet = 0
/*"
"
I69D-浑厚之血*/
set this = CreateEquipType('I69D',9,3,0,ST_ARMOR,STATE_MODE_INT,4,ST_LIFE,STATE_MODE_INT,114,ST_BLOCK,STATE_MODE_INT,11,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_MAIN,STATE_MODE_PERCENTAGE,200,ST_VERSATILITY,STATE_MODE_PERCENTAGE,150,0,0,0)
call this.addDmging_T( function ItemSFX_Defiance )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+4 护甲\n+114 生命\n+11 格挡\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 主属性|r\n|cff20c000+1.5%% 全能|r\n|cffffcc00效果：|r\n|cff20c000无畏：|r受到被自己嘲讽的敌人造成的伤害降低5%%[x]。"
set this.name = "|cff0070dd浑厚之血|r\n\n[唯一]戒指 - 等级9"
set this.inSet = 0
/*"
"
I69E-无侵鳞甲*/
set this = CreateEquipType('I69E',9,3,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,171,ST_LIFE_REGEN,STATE_MODE_REAL,42,ST_ARMOR,STATE_MODE_PERCENTAGE,300,ST_LIFE,STATE_MODE_PERCENTAGE,300,ST_VERSATILITY,STATE_MODE_PERCENTAGE,225,0,0,0)
call this.addSpelling( function ItemSFX_Cleanse )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+171 生命\n+0.42 生命恢复\n|cff20c000+3%% 护甲|r\n|cff20c000+3%% 生命|r\n|cff20c000+2.25%% 全能|r\n|cffffcc00效果：|r\n|cff20c000解咒：|r施法时，驱散自身1个不良效果。触发后有10秒冷却时间。"
set this.name = "|cff0070dd无侵鳞甲|r\n\n[中]护甲 - 等级9"
set this.inSet = 0
/*"
"
I69F-野性外套*/
set this = CreateEquipType('I69F',8,3,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,168,ST_AGI,STATE_MODE_INT,12,ST_AGI,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addDmging_T( function ItemSFX_LightningReflexes )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+168 生命\n+12 敏捷\n|cff20c000+3%% 敏捷|r\n|cff20c000+3%% 急速|r\n|cff20c000+3%% 暴击|r\n|cffffcc00效果：|r\n|cff20c000闪电反射：|r有5%%的几率躲避范围伤害(不会受到伤害)。"
set this.name = "|cff0070dd野性外套|r\n\n[中]护甲 - 等级8"
set this.inSet = 6
/*"
"
I69G-厚重外套*/
set this = CreateEquipType('I69G',8,3,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,168,ST_LIFE_REGEN,STATE_MODE_REAL,39,ST_LIFE,STATE_MODE_PERCENTAGE,300,ST_EVADE,STATE_MODE_PERCENTAGE,300,ST_VERSATILITY,STATE_MODE_PERCENTAGE,225,0,0,0)
call this.addBefDmg_T( function ItemSFX_Mitigation )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+168 生命\n+0.39 生命恢复\n|cff20c000+3%% 生命|r\n|cff20c000+3%% 闪避|r\n|cff20c000+2.25%% 全能|r\n|cffffcc00效果：|r\n|cff20c000消解：|r受到攻击伤害前，有15%%的几率令其降低自身生命上限1%%的伤害。伤害至少为1点。"
set this.name = "|cff0070dd厚重外套|r\n\n[中]护甲 - 等级8"
set this.inSet = 7
/*"
"
I69H-野性护手*/
set this = CreateEquipType('I69H',8,4,0,ST_ATTACK,STATE_MODE_INT,7,ST_AGI,STATE_MODE_INT,4,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,300,ST_ATTACK,STATE_MODE_PERCENTAGE,120,ST_AGI,STATE_MODE_PERCENTAGE,120,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,120,0,0,0)
call this.addBefDmg_S( function ItemSFX_WildPower )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 攻击\n+4 敏捷\n+3%% 攻击速度\n|cff20c000+1.2%% 攻击|r\n|cff20c000+1.2%% 敏捷|r\n|cff20c000+1.2%% 护甲穿透|r\n|cffffcc00效果：|r\n|cff20c000野性力量：|r造成攻击伤害前，有30%%的几率为攻击附加自身生命上限3%%的伤害。"
set this.name = "|cff0070dd野性护手|r\n\n手套 - 等级8"
set this.inSet = 6
/*"
"
I69I-厚重护手*/
set this = CreateEquipType('I69I',8,4,0,ST_ARMOR,STATE_MODE_INT,2,ST_BLOCK,STATE_MODE_INT,6,ST_ACCURACY,STATE_MODE_PERCENTAGE,225,ST_ARMOR,STATE_MODE_PERCENTAGE,120,ST_LIFE,STATE_MODE_PERCENTAGE,120,ST_LIFE_REGEN,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addSpelling( function ItemSFX_IronSkin )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+6 格挡\n+2.25%% 命中\n|cff20c000+1.2%% 护甲|r\n|cff20c000+1.2%% 生命|r\n|cff20c000+3%% 生命恢复|r\n|cffffcc00效果：|r\n|cff20c000钢铁之肤：|r施放(R)技能使你免受流血伤害。持续时间等于技能冷却的20%%。"
set this.name = "|cff0070dd厚重护手|r\n\n手套 - 等级8"
set this.inSet = 7
/*"
"
I69J-野性裹足*/
set this = CreateEquipType('I69J',8,3,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,78,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_HASTE,STATE_MODE_PERCENTAGE,140,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,350,ST_LEECH,STATE_MODE_PERCENTAGE,140,0,0,0)
call this.addSpelling( function ItemSFX_Dash )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+78 生命\n+15 移动速度\n|cff20c000+1.4%% 急速|r\n|cff20c000+3.5%% 移动速度|r\n|cff20c000+1.4%% 吸血|r\n|cffffcc00效果：|r\n|cff20c000疾跑：|r施放(R)技能使你的移动速度提高100%%。持续时间等于技能冷却的20%%。"
set this.name = "|cff0070dd野性裹足|r\n\n[中]鞋 - 等级8"
set this.inSet = 6
/*"
"
I69K-厚重皮靴*/
set this = CreateEquipType('I69K',8,3,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,78,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_ARMOR,STATE_MODE_PERCENTAGE,140,ST_EVADE,STATE_MODE_PERCENTAGE,140,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,0,0,0)
call this.addDmging_T( function ItemSFX_DefendShadow )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+78 生命\n+15 移动速度\n|cff20c000+1.4%% 护甲|r\n|cff20c000+1.4%% 闪避|r\n|cff20c000+1.4%% 法术抗性|r\n|cffffcc00效果：|r\n|cff20c000暗影防护：|r受到的暗影伤害降低3%%[x]。"
set this.name = "|cff0070dd厚重皮靴|r\n\n[中]鞋 - 等级8"
set this.inSet = 7
/*"
"
I69L-季风法袍*/
set this = CreateEquipType('I69L',8,2,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,153,ST_INT,STATE_MODE_INT,12,ST_INT,STATE_MODE_PERCENTAGE,300,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAftDmg_T( function ItemSFX_Wove )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+153 生命\n+12 智力\n|cff20c000+3%% 智力|r\n|cff20c000+3%% 法力|r\n|cff20c000+3%% 急速|r\n|cffffcc00效果：|r\n|cff20c000编织：|r受到伤害后，有10%%的几率生成一个5%%最大生命的护盾，持续5秒。"
set this.name = "|cff0070dd季风法袍|r\n\n[轻]护甲 - 等级8"
set this.inSet = 8
/*"
"
I69M-季风束腰*/
set this = CreateEquipType('I69M',8,5,0,ST_ARMOR,STATE_MODE_INT,2,ST_INT,STATE_MODE_INT,4,ST_MANA,STATE_MODE_INT,7,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,120,ST_MANA_REGEN,STATE_MODE_PERCENTAGE,300,ST_COST_REDUCE,STATE_MODE_PERCENTAGE,120,0,0,0)
call this.addDmging_T( function ItemSFX_DefendLightning )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+2 护甲\n+4 智力\n+7 法力\n|cff20c000+1.2%% 法术强度|r\n|cff20c000+3%% 法力恢复|r\n|cff20c000+1.2%% 节能施法|r\n|cffffcc00效果：|r\n|cff20c000雷电防护：|r受到的闪电伤害降低3%%[x]。"
set this.name = "|cff0070dd季风束腰|r\n\n腰带 - 等级8"
set this.inSet = 8
/*"
"
I69N-季风长靴*/
set this = CreateEquipType('I69N',8,2,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,71,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,140,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,280,ST_RESISTANCE,STATE_MODE_PERCENTAGE,140,0,0,0)
call this.addDmging_T( function ItemSFX_DefendFire )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+71 生命\n+15 移动速度\n|cff20c000+1.4%% 暴击|r\n|cff20c000+2.8%% 暴击伤害|r\n|cff20c000+1.4%% 法术抗性|r\n|cffffcc00效果：|r\n|cff20c000火焰防护：|r受到的火焰伤害降低3%%[x]。"
set this.name = "|cff0070dd季风长靴|r\n\n[轻]鞋 - 等级8"
set this.inSet = 8
/*"
"
I69O-兽皮盾*/
set this = CreateEquipType('I69O',8,3,0,ST_ARMOR,STATE_MODE_INT,5,ST_LIFE,STATE_MODE_INT,102,ST_BLOCK,STATE_MODE_INT,20,ST_LIFE,STATE_MODE_PERCENTAGE,200,ST_BLOCK,STATE_MODE_PERCENTAGE,200,ST_RESISTANCE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addDmging_T( function ItemSFX_Defliction )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+5 护甲\n+102 生命\n+20 格挡\n|cff20c000+2%% 生命|r\n|cff20c000+2%% 格挡|r\n|cff20c000+2%% 法术抗性|r\n|cffffcc00效果：|r\n|cff20c000偏斜：|r受到法术伤害时，有15%%的几率令其降低30%%。"
set this.name = "|cff0070dd兽皮盾|r\n\n[盾·轻]副手 - 等级8"
set this.inSet = 0
/*"
"
I69P-巨蛇之鳞*/
set this = CreateEquipType('I69P',14,4,0,ST_ARMOR,STATE_MODE_INT,9,ST_BLOCK,STATE_MODE_INT,48,ST_LIFE_REGEN,STATE_MODE_REAL,38,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,-1000,ST_LIFE_REGEN,STATE_MODE_PERCENTAGE,750,ST_RESISTANCE,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addDmging_T( function ItemSFX_Defliction )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+9 护甲\n+48 格挡\n+0.38 生命恢复\n|cffff0000-10%% 移动速度|r\n|cff20c000+7.5%% 生命恢复|r\n|cff20c000+3%% 法术抗性|r\n|cffffcc00效果：|r\n|cff20c000偏斜：|r受到法术伤害时，有15%%的几率令其降低30%%。"
set this.name = "|cff0070dd巨蛇之鳞|r\n\n[盾·重]副手 - 等级14"
set this.inSet = 0
/*"
"
I69Q-蛇牙*/
set this = CreateEquipType('I69Q',14,1,0,ST_ATTACK,STATE_MODE_INT,29,ST_ARMOR,STATE_MODE_INT,9,ST_BLOCK,STATE_MODE_INT,24,ST_VERSATILITY,STATE_MODE_PERCENTAGE,225,ST_EVADE,STATE_MODE_PERCENTAGE,300,ST_BLOCK,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAtked_S( function ItemSFX_LeechAttack )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+29 攻击\n+9 护甲\n+24 格挡\n|cff20c000+2.25%% 全能|r\n|cff20c000+3%% 闪避|r\n|cff20c000+3%% 格挡|r\n|cffffcc00效果：|r\n|cff20c000汲血打击：|r击中时，有33%%的几率为自己回复1%%的生命值。"
set this.name = "|cff0070dd蛇牙|r\n\n[近]武器 - 等级14"
set this.inSet = 0
/*"
"
I69R-衔尾之环*/
set this = CreateEquipType('I69R',14,3,0,ST_ARMOR,STATE_MODE_INT,6,ST_LIFE,STATE_MODE_INT,174,ST_LIFE_REGEN,STATE_MODE_REAL,38,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_EVADE,STATE_MODE_PERCENTAGE,200,ST_RESISTANCE,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addAtked_T( function ItemSFX_Renew )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+6 护甲\n+174 生命\n+0.38 生命恢复\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 闪避|r\n|cff20c000+2%% 法术抗性|r\n|cffffcc00效果：|r\n|cff20c000生息：|r被击中时，有25%%的几率使自己在8秒内恢复15%%的生命值。触发后有30秒冷却时间。"
set this.name = "|cff0070dd衔尾之环|r\n\n[唯一]戒指 - 等级14"
set this.inSet = 0
/*"
"
I69S-天丛云剑*/
set this = CreateEquipType('I69S',14,5,0,ST_ABILITY_POWER,STATE_MODE_INT,36,ST_INT,STATE_MODE_INT,23,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_MANA_REGEN,STATE_MODE_PERCENTAGE,750,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addDmging_S( function ItemSFX_EnhanceCold2 )
call this.addDmging_S( function ItemSFX_EnhanceLightning2 )
set this.insc = "\n\n|cff888888从巨蛇尾后拔出的剑，缠绕着风雨雷电。|r"
set this.desc = "|cffffcc00属性：|r\n+36 法术强度\n+23 智力\n+7.5%% 攻击速度\n|cff20c000+3%% 法力|r\n|cff20c000+7.5%% 法力恢复|r\n|cff20c000+3%% 急速|r\n|cffffcc00效果：|r\n|cff20c000冰霜增效(II)：|r冰霜伤害提高5%%[x]。\n|cff20c000雷电增效(II)：|r闪电伤害提高5%%[x]。"
set this.name = "|cffa334ee天丛云剑|r\n\n[近|法]武器 - 等级14"
set this.inSet = 0
/*"
"
I69T-献祭短剑*/
set this = CreateEquipType('I69T',9,1,0,ST_ABILITY_POWER,STATE_MODE_INT,20,ST_INT,STATE_MODE_INT,13,ST_MANA_REGEN,STATE_MODE_REAL,12,ST_MANA,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_LEECH,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addAtking( function ItemSFX_LifeDrain )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+20 法术强度\n+13 智力\n+0.12 法力恢复\n|cff20c000+3%% 法力|r\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 吸血|r\n|cffffcc00效果：|r\n|cff20c000汲取生命：|r攻击时，有25%的几率对目标造成法术强度30%的伤害(暗影)，并为自己恢复等量生命。触发后有10秒冷却时间。"
set this.name = "|cff0070dd献祭短剑|r\n\n[近]武器 - 等级9"
set this.inSet = 0
/*"
"
I69U-九头蛇弓*/
set this = CreateEquipType('I69U',12,2,0,ST_ATTACK,STATE_MODE_INT,26,ST_MAIN,STATE_MODE_INT,17,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_LEECH,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addBefDmg_S( function ItemSFX_ChimeraAttack )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+26 攻击\n+17 主属性\n+7.5%% 攻击速度\n|cff20c000+3%% 攻击|r\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 吸血|r\n|cffffcc00效果：|r\n|cff20c000奇美拉攻击：|r你的火焰伤害也视为冰霜元素，闪电伤害也视为自然元素。"
set this.name = "|cff0070dd九头蛇弓|r\n\n[远]武器 - 等级12"
set this.inSet = 0
/*"
"
I69V-地狱线圈*/
set this = CreateEquipType('I69V',12,5,0,ST_ARMOR,STATE_MODE_INT,3,ST_STR,STATE_MODE_INT,6,ST_MANA,STATE_MODE_INT,10,ST_STR,STATE_MODE_PERCENTAGE,120,ST_VERSATILITY,STATE_MODE_PERCENTAGE,90,ST_RESISTANCE,STATE_MODE_PERCENTAGE,120,0,0,0)
call this.addDmging_T( function ItemSFX_HellIronSkin )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+6 力量\n+10 法力\n|cff20c000+1.2%% 力量|r\n|cff20c000+0.9%% 全能|r\n|cff20c000+1.2%% 法术抗性|r\n|cffffcc00效果：|r\n|cff20c000地狱铁硬化：|r受到的任何非碾压伤害降低5%%。"
set this.name = "|cff0070dd地狱线圈|r\n\n腰带 - 等级12"
set this.inSet = 0
/*"
"
I69W-试作型火箭靴*/
set this = CreateEquipType('I69W',12,4,0,ST_ARMOR,STATE_MODE_INT,3,ST_LIFE,STATE_MODE_INT,105,ST_MOVE_SPEED,STATE_MODE_INT,15,ST_STR,STATE_MODE_PERCENTAGE,140,ST_HASTE,STATE_MODE_PERCENTAGE,140,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,700,0,0,0)
call this.addSpelling( function ItemSFX_Dash )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+3 护甲\n+105 生命\n+15 移动速度\n|cff20c000+1.4%% 力量|r\n|cff20c000+1.4%% 急速|r\n|cff20c000+7%% 移动速度|r\n|cffffcc00效果：|r\n|cff20c000疾跑：|r施放(R)技能使你的移动速度提高100%%。持续时间等于技能冷却的20%%。"
set this.name = "|cff0070dd试作型火箭靴|r\n\n[重]鞋 - 等级12"
set this.inSet = 0
/*"
"
I69X-合金之墙*/
set this = CreateEquipType('I69X',12,4,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,150,ST_BLOCK,STATE_MODE_INT,42,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,-1000,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_VERSATILITY,STATE_MODE_PERCENTAGE,150,0,0,0)
call this.addBefDmg_T( function ItemSFX_LimitedResilience )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+150 生命\n+42 格挡\n|cffff0000-10%% 移动速度|r\n|cff20c000+2%% 护甲|r\n|cff20c000+1.5%% 全能|r\n|cffffcc00效果：|r\n|cff20c000有限韧性：|r受到不大于生命上限10%%的伤害时，降低10点（伤害至少为1）。"
set this.name = "|cff0070dd合金之墙|r\n\n[盾·重]副手 - 等级12"
set this.inSet = 0
/*"
"
I69Y-不朽之守护*/
set this = CreateEquipType('I69Y',12,3,0,ST_ARMOR,STATE_MODE_INT,7,ST_BLOCK,STATE_MODE_INT,28,ST_MAIN,STATE_MODE_INT,11,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_LIFE,STATE_MODE_PERCENTAGE,200,ST_MAIN,STATE_MODE_PERCENTAGE,200,0,0,0)
call this.addDmged_T( function ItemSFX_Immortal )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+28 格挡\n+11 主属性\n|cff20c000+2%% 护甲|r\n|cff20c000+2%% 生命|r\n|cff20c000+2%% 主属性|r\n|cffffcc00效果：|r\n|cff20c000不朽：|r受到致命伤害时，保留1点生命值。触发后有120秒冷却时间。"
set this.name = "|cff0070dd不朽之守护|r\n\n[盾·轻]副手 - 等级12"
set this.inSet = 0
/*"
"
I69Z-财富之手*/
set this = CreateEquipType('I69Z',12,4,0,ST_AGI,STATE_MODE_INT,8,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,300,ST_ACCURACY,STATE_MODE_PERCENTAGE,267,ST_ATTACK,STATE_MODE_PERCENTAGE,120,ST_HASTE,STATE_MODE_PERCENTAGE,120,ST_DAMAGE_BONUS,STATE_MODE_PERCENTAGE,120,0,0,0)
call this.addDmging_S( function ItemSFX_EnhanceArcane2 )
call this.addAtked_S( function ItemSFX_Transmute )
call this.addAftDmg_S( function ItemSFX_Transmute_1 )
set this.insc = "\n\n|cff888888污水港最棒的杰作！|r"
set this.desc = "|cffffcc00属性：|r\n+8 敏捷\n+3%% 攻击速度\n+2.67%% 命中\n|cff20c000+1.2%% 攻击|r\n|cff20c000+1.2%% 急速|r\n|cff20c000+1.2%% 伤害加成|r\n|cffffcc00效果：|r\n|cff20c000奥术增效(II)：|r奥术伤害提高5%%[x]。\n|cff20c000点金术：|r击中生命小于25%%的普通敌人时，有30%%的几率直接将目标点化为等级20倍的金币。触发后有120秒冷却时间。"
set this.name = "|cffa334ee财富之手|r\n\n手套 - 等级12"
set this.inSet = 0
/*"
"
I6A0-野兽之牙*/
set this = CreateEquipType('I6A0',11,1,'AA0C',ST_AGI,STATE_MODE_INT,13,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_ACCURACY,STATE_MODE_PERCENTAGE,577,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_AGI,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+13 敏捷\n+7.5%% 攻击速度\n+5.77%% 命中\n|cff20c000+3%% 攻击|r\n|cff20c000+3%% 敏捷|r|N|cffffcc00赋予技能：|r|n|cff20c000嗜血术：|r提高急速和移动速度。"
set this.name = "|cff20c000野兽之牙|r\n\n护符 - 等级11"
set this.inSet = 0
/*"
"
I6A1-林克的暴雪护符*/
set this = CreateEquipType('I6A1',11,1,'AA0D',ST_INT,STATE_MODE_INT,13,ST_MANA,STATE_MODE_INT,21,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,300,ST_INT,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+13 智力\n+21 法力\n+7.5%% 攻击速度\n|cff20c000+3%% 法术强度|r\n|cff20c000+3%% 智力|r|N|cffffcc00赋予技能：|r|n|cff20c000暴风雪：|r在目标区域召唤暴风雪，造成范围伤害。"
set this.name = "|cff20c000林克的暴雪护符|r\n\n护符 - 等级11"
set this.inSet = 0
/*"
"
I6A2-烈焰宝钻*/
set this = CreateEquipType('I6A2',11,1,'AA0E',ST_STR,STATE_MODE_INT,13,ST_ARMOR_PEN,STATE_MODE_INT,9,ST_ACCURACY,STATE_MODE_PERCENTAGE,577,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_STR,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+13 力量\n+9 护甲穿透\n+5.77%% 命中\n|cff20c000+3%% 攻击|r\n|cff20c000+3%% 力量|r|N|cffffcc00赋予技能：|r|n|cff20c000冲击波：|r造成范围火焰伤害，并击晕敌人。"
set this.name = "|cff20c000烈焰宝钻|r\n\n护符 - 等级11"
set this.inSet = 0
/*"
"
I6A3-坚岩之心*/
set this = CreateEquipType('I6A3',11,1,'AA0F',ST_ARMOR,STATE_MODE_INT,7,ST_LIFE,STATE_MODE_INT,171,ST_MAIN,STATE_MODE_INT,13,ST_LIFE,STATE_MODE_PERCENTAGE,300,ST_VERSATILITY,STATE_MODE_PERCENTAGE,225,0,0,0,0,0,0)
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+7 护甲\n+171 生命\n+13 主属性\n|cff20c000+3%% 生命|r\n|cff20c000+2.25%% 全能|r|N|cffffcc00赋予技能：|r|n|cff20c000挑衅怒吼：|r沉默并嘲讽附近的敌人。"
set this.name = "|cff20c000坚岩之心|r\n\n护符 - 等级11"
set this.inSet = 0
/*"
"
I6A4-打架助手*/
set this = CreateEquipType('I6A4',12,2,0,ST_ATTACK,STATE_MODE_INT,19,ST_STR,STATE_MODE_INT,12,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,-500,ST_ATTACK,STATE_MODE_PERCENTAGE,300,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,300,0,0,0)
call this.addPreDmg_S( function ItemSFX_EnhancePhysical )
call this.addDmging_S( function ItemSFX_EnhancePhysical_1 )
set this.insc = "\n\n|cff888888伐木机的巨大锯片，需要巨力才能挥舞起来。|r"
set this.desc = "|cffffcc00属性：|r\n+19 攻击\n+12 力量\n|cffff0000-5%% 攻击速度|r\n|cff20c000+3%% 攻击|r\n|cff20c000+3%% 暴击|r\n|cff20c000+3%% 护甲穿透|r\n|cffffcc00效果：|r\n|cff20c000物理增效：|r你造成的物理伤害提高3%%[x]，并忽略目标10%%的护甲。"
set this.name = "|cff0070dd打架助手|r\n\n[武器]副手 - 等级12"
set this.inSet = 0
/*"
"
I6A5-变速齿轮*/
set this = CreateEquipType('I6A5',12,2,0,ST_ATTACK,STATE_MODE_INT,17,ST_AGI,STATE_MODE_INT,11,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,500,ST_AGI,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,400,0,0,0,0,0,0)
call this.addAtked_S( function ItemSFX_ChangeSpeed )
set this.insc = "\n\n|cff888888齿轮的边缘非常锋利。|r"
set this.desc = "|cffffcc00属性：|r\n+17 攻击\n+11 敏捷\n+5%% 攻击速度\n|cff20c000+2%% 敏捷|r\n|cff20c000+4%% 急速|r\n|cffffcc00效果：|r\n|cff20c000变速：|r击中时，有25%%的几率随机改变你的攻击速度：+5%%~+30%%，持续10秒。触发后有30秒冷却时间。"
set this.name = "|cff0070dd变速齿轮|r\n\n[武器]副手 - 等级12"
set this.inSet = 0
/*"
"
I6A6-梅肯斯姆*/
set this = CreateEquipType('I6A6',20,1,'AA0G',ST_ARMOR,STATE_MODE_INT,14,ST_LIFE,STATE_MODE_INT,459,ST_LIFE_REGEN,STATE_MODE_REAL,90,ST_ARMOR,STATE_MODE_PERCENTAGE,600,ST_BLOCK,STATE_MODE_PERCENTAGE,600,ST_LIFE_REGEN,STATE_MODE_PERCENTAGE,1500,0,0,0)
call this.addEquipOn( function ItemSFX_RenewAura_On )
call this.addTakeOff( function ItemSFX_RenewAura_Off )
call this.addDmging_T( function ItemSFX_MythDefence )
set this.insc = "\n\n|cff888888各种散件不知是怎样完美地组合起来，形成的散发着光芒的珠宝。|r"
set this.desc = "|cffffcc00属性：|r\n+14 护甲\n+459 生命\n+0.9 生命恢复\n|cff20c000+6%% 护甲|r\n|cff20c000+6%% 格挡|r\n|cff20c000+15%% 生命恢复|r\n|cffffcc00效果：|r\n|cff20c000愈合光环：|r提升大范围内盟友2.5的生命恢复。\n|cff20c000神秘守护：|r有10%%的几率使所受的直接法术伤害无效。触发后有30秒冷却时间。|N|cffffcc00赋予技能：|r|n|cff20c000群体回复：|r为范围内的盟友恢复生命，并驱散不利效果。"
set this.name = "|cffa334ee梅肯斯姆|r\n\n护符 - 等级20"
set this.inSet = 0
/*"
"
I6A7-霜妖之眼*/
set this = CreateEquipType('I6A7',20,3,0,ST_ARMOR,STATE_MODE_INT,8,ST_LIFE,STATE_MODE_INT,214,ST_MANA,STATE_MODE_INT,21,ST_STR,STATE_MODE_PERCENTAGE,560,ST_AGI,STATE_MODE_PERCENTAGE,560,ST_INT,STATE_MODE_PERCENTAGE,560,0,0,0)
call this.addDmging_S( function ItemSFX_Torrent )
call this.addAtked_S( function ItemSFX_FrostAttack )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+8 护甲\n+214 生命\n+21 法力\n|cff20c000+5.6%% 力量|r\n|cff20c000+5.6%% 敏捷|r\n|cff20c000+5.6%% 智力|r\n|cffffcc00效果：|r\n|cff20c000洪流：|r每有[英雄等级]点法力上限，造成的伤害就提高0.3%%，至多6%%[x]。\n|cff20c000覆霜：|r击中时，有20%%的几率令目标冰冻减速，持续5秒。"
set this.name = "|cffa334ee霜妖之眼|r\n\n[中]头盔 - 等级20"
set this.inSet = 0
/*"
"
I6A8-冰霜护甲*/
set this = CreateEquipType('I6A8',20,4,0,ST_ARMOR,STATE_MODE_INT,21,ST_LIFE,STATE_MODE_INT,459,ST_INT,STATE_MODE_INT,32,ST_ARMOR,STATE_MODE_PERCENTAGE,600,ST_LIFE,STATE_MODE_PERCENTAGE,600,ST_MANA,STATE_MODE_PERCENTAGE,600,0,0,0)
call this.addDmging_T( function ItemSFX_CrystalArmor )
call this.addAtked_T( function ItemSFX_FrostArmor )
set this.insc = ""
set this.desc = "|cffffcc00属性：|r\n+21 护甲\n+459 生命\n+32 智力\n|cff20c000+6%% 护甲|r\n|cff20c000+6%% 生命|r\n|cff20c000+6%% 法力|r\n|cffffcc00效果：|r\n|cff20c000水晶防御：|r受到的法术伤害降低3%%[x]。\n|cff20c000冰霜护甲：|r被近战攻击击中时，使攻击者冰冻减速，持续3秒。"
set this.name = "|cffa334ee冰霜护甲|r\n\n[重]护甲 - 等级20"
set this.inSet = 0
/*"
"
I6A9-猎蛟的弓弦*/
set this = CreateEquipType('I6A9',20,2,0,ST_ATTACK,STATE_MODE_INT,49,ST_AGI,STATE_MODE_INT,32,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,ST_ATTACK,STATE_MODE_PERCENTAGE,600,ST_HASTE,STATE_MODE_PERCENTAGE,600,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,600,0,0,0)
call this.addAtked_S( function ItemSFX_RangedAttack )
call this.addDmging_S( function ItemSFX_GiantSlayer )
set this.insc = "\n\n|cff888888除掉那些“龙”，海洋就是我们的。|r"
set this.desc = "|cffffcc00属性：|r\n+49 攻击\n+32 敏捷\n+7.5%% 攻击速度\n|cff20c000+6%% 攻击|r\n|cff20c000+6%% 急速|r\n|cff20c000+6%% 护甲穿透|r\n|cffffcc00效果：|r\n|cff20c000远距打击：|r与敌人的距离在300以上时，攻击造成的伤害提高10%%[x]。\n|cff20c000巨人杀手：|r对生命高于70%%的目标造成的伤害提高10%%[x]。"
set this.name = "|cffa334ee猎蛟的弓弦|r\n\n[远]武器 - 等级20"
set this.inSet = 0
/*"
"
I6AA-凋零使者-闪耀的不朽法杖*/
set this = CreateEquipType('I6AA',20,4,0,ST_ABILITY_POWER,STATE_MODE_INT,58,ST_INT,STATE_MODE_INT,38,ST_MANA_REGEN,STATE_MODE_REAL,25,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,600,ST_INT,STATE_MODE_PERCENTAGE,600,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,600,ST_MANA_REGEN,STATE_MODE_PERCENTAGE,1500)
call this.addAftDmg_S( function ItemSFX_DeathAndDecay )
call this.addPreDmg_S( function ItemSFX_DustToDust )
set this.insc = "\n\n|cff888888正义与邪恶的融合？！|r"
set this.desc = "|cffffcc00属性：|r\n+58 法术强度\n+38 智力\n+0.25 法力恢复\n|cff20c000+6%% 法术强度|r\n|cff20c000+6%% 智力|r\n|cff20c000+6%% 暴击|r\n|cff20c000+15%% 法力恢复|r\n|cffffcc00效果：|r\n|cff20c000死亡凋零：|r法术打出暴击后，有15%%的几率打消目标1%%的生命值。此效果在目标生命值降低15%%后才可以再次发动。\n|cff20c000复归尘土：|r你对被死亡凋零影响的目标造成的法术伤害提高5%%[x]，并视为暗影伤害。目标每承受一次死亡凋零，这个效果就在神圣与暗影之间转换一次。"
set this.name = "|cffff8000凋零使者-闪耀的不朽法杖|r\n\n[法]武器 - 等级20"
set this.inSet = 0
/*"

        // endregion
        */
    endfunction

    function initEquipmentTypes takes nothing returns nothing
        call TimerStart(CreateTimer(),0.001,false,function initEquipmentTypes_0_330)
        call TimerStart(CreateTimer(),0.002,false,function initEquipmentTypes_331)
    endfunction

    function initItemSetEffects takes nothing returns nothing
        local ItemSetEffect this 

        /*
        // region SetEff PASTE HERE"
        "
ID = 1*/
set this = ItemSetEffect.create(ST_STR,STATE_MODE_INT,15,ST_AGI,STATE_MODE_INT,15,ST_INT,STATE_MODE_INT,15)
set this.desc = "提高15点力量、敏捷和智力"
/*"
"
ID = 2*/
set this = ItemSetEffect.create(ST_MANA,STATE_MODE_PERCENTAGE,500,ST_INT,STATE_MODE_PERCENTAGE,500,0,0,0)
set this.desc = "提高5%%的法力和智力"
/*"
"
ID = 3*/
set this = ItemSetEffect.create(ST_LIFE,STATE_MODE_PERCENTAGE,500,ST_ARMOR,STATE_MODE_PERCENTAGE,500,0,0,0)
set this.desc = "提高5%%的护甲和生命"
/*"
"
ID = 4*/
set this = ItemSetEffect.create(ST_HASTE,STATE_MODE_PERCENTAGE,500,ST_EVADE,STATE_MODE_PERCENTAGE,500,0,0,0)
set this.desc = "提高5%%的急速和闪避"
/*"
"
ID = 5*/
set this = ItemSetEffect.create(ST_STR,STATE_MODE_PERCENTAGE,500,ST_ARMOR_PEN,STATE_MODE_PERCENTAGE,500,0,0,0)
set this.desc = "提高5%%的力量和护甲穿透"
/*"
"
ID = 6*/
set this = ItemSetEffect.create(ST_ATTACK,STATE_MODE_PERCENTAGE,500,ST_HASTE,STATE_MODE_PERCENTAGE,500,0,0,0)
set this.desc = "提高5%%的攻击和急速"
/*"
"
ID = 7*/
set this = ItemSetEffect.create(ST_LIFE,STATE_MODE_PERCENTAGE,500,ST_VERSATILITY,STATE_MODE_PERCENTAGE,500,0,0,0)
set this.desc = "提高5%%的生命和全能"
/*"
"
ID = 8*/
set this = ItemSetEffect.create(ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,500,ST_COST_REDUCE,STATE_MODE_PERCENTAGE,500,0,0,0)
set this.desc = "提高5%%的法术强度和节能施法"
/*"

        // endregion
        */
    endfunction

    function initItemSetTypes takes nothing returns nothing
        local ItemSetType this 

        /*
        // region SetType PASTE HERE
        "
ID = 1*/
set this = ItemSetType.create("阿卡纳对戒")
set this.eff2 = 1

/*"
"
ID = 2*/
set this = ItemSetType.create("枭之睿智")
set this.eff2 = 2

/*"
"
ID = 3*/
set this = ItemSetType.create("猫之优雅")
set this.eff2 = 4

/*"
"
ID = 4*/
set this = ItemSetType.create("蛮牛之韧")
set this.eff2 = 3

/*"
"
ID = 5*/
set this = ItemSetType.create("猛虎之力")
set this.eff2 = 5

/*"
"
ID = 6*/
set this = ItemSetType.create("野性之皮")
set this.eff2 = 6

/*"
"
ID = 7*/
set this = ItemSetType.create("厚重之皮")
set this.eff2 = 7

/*"
"
ID = 8*/
set this = ItemSetType.create("季风")
set this.eff2 = 8

/*"

        // endregion
        */
    endfunction

    function initEnchantments takes nothing returns nothing
        local Enchantment this 

        /*
        // region enc PASTE HERE"
        "
IEZZ-萨格拉斯之触*/
set this = Enchantment.create(1,ST_STR,STATE_MODE_PERCENTAGE,500,ST_AGI,STATE_MODE_PERCENTAGE,500,ST_INT,STATE_MODE_PERCENTAGE,500)
call this.addAtked_S(function ItemSFX_Bash)
call this.addPreDmg_S(function ItemSFX_Shatter)
set this.desc = "|n|cffa5e3fe附魔：萨格拉斯之触：|r+5%% 力量，+5%% 敏捷，+5%% 智力|n|cff20c000重击：|r击中时有15%%的几率额外造成20%%[x]的伤害。|n|cff20c000破灭：|r造成伤害时，无视目标20%%的护甲与抗性。"
/*"
"
IE00-初级生命*/
set this = Enchantment.create(2,ST_LIFE,STATE_MODE_INT,9,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：初级生命：|r+9 生命"
/*"
"
IE01-初级法力*/
set this = Enchantment.create(3,ST_MANA,STATE_MODE_INT,3,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：初级法力：|r+3 法力"
/*"
"
IE02-初级属性*/
set this = Enchantment.create(4,ST_MAIN,STATE_MODE_INT,1,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：初级属性：|r+1 主属性"
/*"
"
IE03-初级重击*/
set this = Enchantment.create(5,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,50,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：初级重击：|r+0.5%% 暴击"
/*"
"
IE04-初级防护*/
set this = Enchantment.create(6,ST_BLOCK,STATE_MODE_INT,2,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：初级防护：|r+2 格挡"
/*"
"
IE05-初级急速*/
set this = Enchantment.create(7,ST_HASTE,STATE_MODE_PERCENTAGE,100,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：初级急速：|r+1%% 急速"
/*"
"
RANDOM-灵猴*/
set this = Enchantment.create(1000,ST_AGI,STATE_MODE_PERCENTAGE,200,ST_LIFE,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：灵猴：|r+2%% 敏捷，+2%% 生命"
/*"
"
RANDOM-野熊*/
set this = Enchantment.create(1001,ST_STR,STATE_MODE_PERCENTAGE,200,ST_LIFE,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：野熊：|r+2%% 力量，+2%% 生命"
/*"
"
RANDOM-雄鹰*/
set this = Enchantment.create(1002,ST_INT,STATE_MODE_PERCENTAGE,200,ST_LIFE,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：雄鹰：|r+2%% 智力，+2%% 生命"
/*"
"
RANDOM-猛虎*/
set this = Enchantment.create(1003,ST_STR,STATE_MODE_PERCENTAGE,200,ST_AGI,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：猛虎：|r+2%% 力量，+2%% 敏捷"
/*"
"
RANDOM-巨猿*/
set this = Enchantment.create(1004,ST_STR,STATE_MODE_PERCENTAGE,200,ST_INT,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：巨猿：|r+2%% 力量，+2%% 智力"
/*"
"
RANDOM-猎鹰*/
set this = Enchantment.create(1005,ST_AGI,STATE_MODE_PERCENTAGE,200,ST_INT,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：猎鹰：|r+2%% 敏捷，+2%% 智力"
/*"
"
RANDOM-野猪*/
set this = Enchantment.create(1006,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_LIFE,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：野猪：|r+2%% 护甲，+2%% 生命"
/*"
"
RANDOM-灵狐*/
set this = Enchantment.create(1007,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_EVADE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：灵狐：|r+2%% 护甲，+1.5%% 闪避"
/*"
"
RANDOM-巫术*/
set this = Enchantment.create(1008,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：巫术：|r+2%% 法术强度，+2%% 法力"
/*"
"
RANDOM-打击*/
set this = Enchantment.create(1009,ST_ATTACK,STATE_MODE_PERCENTAGE,200,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：打击：|r+2%% 攻击，+2%% 攻击速度"
/*"
"
RANDOM-佣兵*/
set this = Enchantment.create(1010,ST_STR,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：佣兵：|r+2%% 力量，+1.5%% 急速"
/*"
"
RANDOM-侍从*/
set this = Enchantment.create(1011,ST_STR,STATE_MODE_PERCENTAGE,200,ST_ACCURACY,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：侍从：|r+2%% 力量，+2%% 命中"
/*"
"
RANDOM-盗贼*/
set this = Enchantment.create(1012,ST_AGI,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：盗贼：|r+2%% 敏捷，+1.5%% 急速"
/*"
"
RANDOM-狩猎*/
set this = Enchantment.create(1013,ST_AGI,STATE_MODE_PERCENTAGE,200,ST_ACCURACY,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：狩猎：|r+2%% 敏捷，+2%% 命中"
/*"
"
RANDOM-先祖*/
set this = Enchantment.create(1014,ST_STR,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：先祖：|r+2%% 力量，+1.5%% 暴击"
/*"
"
RANDOM-射手*/
set this = Enchantment.create(1015,ST_AGI,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：射手：|r+2%% 敏捷，+1.5%% 暴击"
/*"
"
RANDOM-祈灵*/
set this = Enchantment.create(1016,ST_INT,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：祈灵：|r+2%% 智力，+1.5%% 暴击"
/*"
"
RANDOM-长者*/
set this = Enchantment.create(1017,ST_INT,STATE_MODE_PERCENTAGE,200,ST_MANA,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：长者：|r+2%% 智力，+2%% 法力"
/*"
"
RANDOM-预言*/
set this = Enchantment.create(1018,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：预言：|r+2%% 法术强度，+1.5%% 急速"
/*"
"
RANDOM-峭壁*/
set this = Enchantment.create(1019,ST_ARMOR,STATE_MODE_PERCENTAGE,200,ST_BLOCK,STATE_MODE_PERCENTAGE,200,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：峭壁：|r+2%% 护甲，+2%% 格挡"
/*"
"
RANDOM-微风*/
set this = Enchantment.create(1020,ST_HASTE,STATE_MODE_PERCENTAGE,150,ST_MOVE_SPEED,STATE_MODE_PERCENTAGE,250,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：微风：|r+1.5%% 急速，+2.5%% 移动速度"
/*"
"
RANDOM-风舞*/
set this = Enchantment.create(1021,ST_HASTE,STATE_MODE_PERCENTAGE,150,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：风舞：|r+1.5%% 急速，+1.5%% 暴击"
/*"
"
RANDOM-微光*/
set this = Enchantment.create(1022,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：微光：|r+2%% 法力，+1.5%% 急速"
/*"
"
RANDOM-灼光*/
set this = Enchantment.create(1023,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：灼光：|r+2%% 法力，+1.5%% 暴击"
/*"
"
RANDOM-轰鸣*/
set this = Enchantment.create(1024,ST_ATTACK,STATE_MODE_PERCENTAGE,200,ST_HASTE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：轰鸣：|r+2%% 攻击，+1.5%% 急速"
/*"
"
RANDOM-爆裂*/
set this = Enchantment.create(1025,ST_ATTACK,STATE_MODE_PERCENTAGE,200,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：爆裂：|r+2%% 攻击，+1.5%% 暴击"
/*"
"
RANDOM-医师*/
set this = Enchantment.create(1026,ST_MANA,STATE_MODE_PERCENTAGE,200,ST_HEAL_BONUS,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：医师：|r+2%% 法力，+1.5%% 治疗加成"
/*"
"
RANDOM-幻象*/
set this = Enchantment.create(1027,ST_ABILITY_POWER,STATE_MODE_PERCENTAGE,200,ST_COST_REDUCE,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：幻象：|r+2%% 法术强度，+1.5%% 节能施法"
/*"
"
RANDOM-意志*/
set this = Enchantment.create(1028,ST_HEAL_BONUS,STATE_MODE_PERCENTAGE,150,ST_SHIELD_BONUS,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：意志：|r+1.5%% 治疗加成，+1.5%% 护盾加成"
/*"
"
RANDOM-力量*/
set this = Enchantment.create(1029,ST_STR,STATE_MODE_PERCENTAGE,400,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：力量：|r+4%% 力量"
/*"
"
RANDOM-敏捷*/
set this = Enchantment.create(1030,ST_AGI,STATE_MODE_PERCENTAGE,400,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：敏捷：|r+4%% 敏捷"
/*"
"
RANDOM-智力*/
set this = Enchantment.create(1031,ST_INT,STATE_MODE_PERCENTAGE,400,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：智力：|r+4%% 智力"
/*"
"
RANDOM-焦躁*/
set this = Enchantment.create(1032,ST_HASTE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：焦躁：|r+3%% 急速"
/*"
"
RANDOM-燎火*/
set this = Enchantment.create(1033,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：燎火：|r+3%% 暴击"
/*"
"
RANDOM-抗性*/
set this = Enchantment.create(1034,ST_RESISTANCE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：抗性：|r+3%% 法术抗性"
/*"
"
RANDOM-应变*/
set this = Enchantment.create(1035,ST_EVADE,STATE_MODE_PERCENTAGE,300,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：应变：|r+3%% 闪避"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3000,ST_ATTACK,STATE_MODE_INT,3,0,0,0,0,0,0)
set this.desc = "|n+3 攻击"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3001,ST_ABILITY_POWER,STATE_MODE_INT,3,0,0,0,0,0,0)
set this.desc = "|n+3 法术强度"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3002,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.desc = "|n+2%% 攻击速度"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3003,ST_LIFE,STATE_MODE_INT,15,0,0,0,0,0,0)
set this.desc = "|n+15 生命"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3004,ST_MANA,STATE_MODE_INT,5,0,0,0,0,0,0)
set this.desc = "|n+5 法力"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3005,ST_LIFE_REGEN,STATE_MODE_REAL,20,0,0,0,0,0,0)
set this.desc = "|n+0.2 生命恢复"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3006,ST_MANA_REGEN,STATE_MODE_REAL,5,0,0,0,0,0,0)
set this.desc = "|n+0.05 法力恢复"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3007,ST_ARMOR,STATE_MODE_INT,2,0,0,0,0,0,0)
set this.desc = "|n+2 护甲"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3008,ST_ARMOR_PEN,STATE_MODE_INT,2,0,0,0,0,0,0)
set this.desc = "|n+2 护甲穿透"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3009,ST_BLOCK,STATE_MODE_INT,2,0,0,0,0,0,0)
set this.desc = "|n+2 格挡"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3010,ST_STR,STATE_MODE_INT,2,0,0,0,0,0,0)
set this.desc = "|n+2 力量"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3011,ST_AGI,STATE_MODE_INT,2,0,0,0,0,0,0)
set this.desc = "|n+2 敏捷"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3012,ST_INT,STATE_MODE_INT,2,0,0,0,0,0,0)
set this.desc = "|n+2 智力"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3013,ST_ACCURACY,STATE_MODE_PERCENTAGE,200,0,0,0,0,0,0)
set this.desc = "|n+2%% 命中"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3014,ST_EVADE,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0)
set this.desc = "|n+1.5%% 闪避"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3015,ST_HASTE,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0)
set this.desc = "|n+1.5%% 急速"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3016,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0)
set this.desc = "|n+1.5%% 暴击"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3017,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,250,0,0,0,0,0,0)
set this.desc = "|n+2.5%% 暴击伤害"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3018,ST_LIFE,STATE_MODE_PERCENTAGE,250,0,0,0,0,0,0)
set this.desc = "|n+2.5%% 生命"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3019,ST_MANA,STATE_MODE_PERCENTAGE,250,0,0,0,0,0,0)
set this.desc = "|n+2.5%% 法力"
/*"
"
CRAFT.LV1-|cffff0000附魔及工艺锁定|r*/
set this = Enchantment.create(3020,0,0,0,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe赋予：|cffff0000附魔及工艺锁定|r：|r"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3021,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3022,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3023,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3024,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3025,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3026,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3027,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3028,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3029,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3030,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3031,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3032,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3033,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3034,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3035,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3036,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3037,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3038,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3039,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3040,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3041,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3042,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3043,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3044,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3045,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3046,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3047,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3048,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3049,0,0,0,0,0,0,0,0,0)
set this.desc = "|n"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3050,ST_STR,STATE_MODE_INT,15,0,0,0,0,0,0)
set this.desc = "|n+15 力量"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3051,ST_LIFE,STATE_MODE_INT,75,0,0,0,0,0,0)
set this.desc = "|n+75 生命"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3052,ST_LIFE_REGEN,STATE_MODE_REAL,200,0,0,0,0,0,0)
set this.desc = "|n+2 生命恢复"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3053,ST_AGI,STATE_MODE_INT,15,0,0,0,0,0,0)
set this.desc = "|n+15 敏捷"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3054,ST_ATTACK_SPEED,STATE_MODE_PERCENTAGE,750,0,0,0,0,0,0)
set this.desc = "|n+7.5%% 攻击速度"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3055,ST_HASTE,STATE_MODE_PERCENTAGE,500,0,0,0,0,0,0)
set this.desc = "|n+5%% 急速"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3056,ST_EVADE,STATE_MODE_PERCENTAGE,500,0,0,0,0,0,0)
set this.desc = "|n+5%% 闪避"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3057,ST_INT,STATE_MODE_INT,15,0,0,0,0,0,0)
set this.desc = "|n+15 智力"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3058,ST_MANA,STATE_MODE_INT,30,0,0,0,0,0,0)
set this.desc = "|n+30 法力"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3059,ST_MANA_REGEN,STATE_MODE_REAL,50,0,0,0,0,0,0)
set this.desc = "|n+0.5 法力恢复"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3060,ST_ATTACK,STATE_MODE_INT,20,0,0,0,0,0,0)
set this.desc = "|n+20 攻击"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3061,ST_ABILITY_POWER,STATE_MODE_INT,20,0,0,0,0,0,0)
set this.desc = "|n+20 法术强度"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3062,ST_ARMOR_PEN,STATE_MODE_INT,15,0,0,0,0,0,0)
set this.desc = "|n+15 护甲穿透"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3063,ST_ARMOR,STATE_MODE_INT,10,0,0,0,0,0,0)
set this.desc = "|n+10 护甲"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3064,ST_RESISTANCE,STATE_MODE_PERCENTAGE,500,0,0,0,0,0,0)
set this.desc = "|n+5%% 法术抗性"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3065,ST_BLOCK,STATE_MODE_INT,30,0,0,0,0,0,0)
set this.desc = "|n+30 格挡"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3066,ST_CRIT_CHANCE,STATE_MODE_PERCENTAGE,500,0,0,0,0,0,0)
set this.desc = "|n+5%% 暴击"
/*"
"
CRAFT.LV1-*/
set this = Enchantment.create(3067,ST_CRIT_POWER,STATE_MODE_PERCENTAGE,1000,0,0,0,0,0,0)
set this.desc = "|n+10%% 暴击伤害"
/*"
"
-奇美拉射击*/
set this = Enchantment.create(8,0,0,0,0,0,0,0,0,0)
call this.addAtking(function ItemSFX_ChimeraShootA)
set this.desc = "|n|cffa5e3fe附魔：奇美拉射击：|r|n|cff20c000奇美拉射击(霜火)：|r攻击时，有25%%的几率射出一支造成攻击50%%物理伤害(火焰、冰霜)的箭矢。触发后有10秒冷却时间。"
/*"
"
-奇美拉射击*/
set this = Enchantment.create(9,0,0,0,0,0,0,0,0,0)
call this.addAtking(function ItemSFX_ChimeraShootB)
set this.desc = "|n|cffa5e3fe附魔：奇美拉射击：|r|n|cff20c000奇美拉射击(毒雷)：|r攻击时，有25%%的几率射出一支造成攻击50%%物理伤害(闪电、自然)的箭矢。触发后有10秒冷却时间。"
/*"
"
IE06-法力之潮*/
set this = Enchantment.create(10,0,0,0,0,0,0,0,0,0)
call this.addSpelling(function ItemSFX_ManaTide)
set this.desc = "|n|cffa5e3fe附魔：法力之潮：|r|n|cff20c000法力之潮：|r施法时，有15%%的几率使自己在10秒内提高1.5/秒的法力恢复速度。触发后有15秒冷却时间。"
/*"
"
IE07-闪电链*/
set this = Enchantment.create(11,0,0,0,0,0,0,0,0,0)
call this.addAtking(function ItemSFX_ChainLightning)
set this.desc = "|n|cffa5e3fe附魔：闪电链：|r|n|cff20c000闪电链：|r攻击时，有15%%的几率发射一道能弹射5次的闪电链，对敌人造成法术强度50%%的法术伤害(闪电)。触发后有15秒冷却时间。"
/*"
"
IE08-冲击波*/
set this = Enchantment.create(12,0,0,0,0,0,0,0,0,0)
call this.addAtking(function ItemSFX_ShockWave)
set this.desc = "|n|cffa5e3fe附魔：冲击波：|r|n|cff20c000冲击波：|r攻击时，有15%%的几率释放一道冲击波，造成攻击50%%的物理伤害。触发后有15秒冷却时间。"
/*"
"
IE09-看破*/
set this = Enchantment.create(13,0,0,0,0,0,0,0,0,0)
call this.addAftDmg_T(function ItemSFX_Insight)
set this.desc = "|n|cffa5e3fe附魔：看破：|r|n|cff20c000看破：|r受到物理或法术伤害后，使你受到的另一种伤害减少10%%[x]，持续10秒，触发后有15秒冷却时间。"
/*"
"
IE0A-节能*/
set this = Enchantment.create(14,ST_COST_REDUCE,STATE_MODE_PERCENTAGE,250,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：节能：|r+2.5%% 节能施法"
/*"
"
IE0B-凌厉*/
set this = Enchantment.create(15,ST_DAMAGE_BONUS,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：凌厉：|r+1.5%% 伤害加成"
/*"
"
IE0C-温润*/
set this = Enchantment.create(16,ST_HEAL_BONUS,STATE_MODE_PERCENTAGE,150,ST_SHIELD_BONUS,STATE_MODE_PERCENTAGE,150,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：温润：|r+1.5%% 治疗加成，+1.5%% 护盾加成"
/*"
"
IE0D-全能*/
set this = Enchantment.create(17,ST_VERSATILITY,STATE_MODE_PERCENTAGE,100,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：全能：|r+1%% 全能"
/*"
"
IE0E-生命*/
set this = Enchantment.create(18,ST_LIFE,STATE_MODE_INT,30,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：生命：|r+30 生命"
/*"
"
IE0F-法力*/
set this = Enchantment.create(19,ST_MANA,STATE_MODE_INT,10,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：法力：|r+10 法力"
/*"
"
IE0G-格挡*/
set this = Enchantment.create(20,ST_BLOCK,STATE_MODE_INT,8,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：格挡：|r+8 格挡"
/*"
"
IE0H-闪避*/
set this = Enchantment.create(21,ST_EVADE,STATE_MODE_PERCENTAGE,150,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：闪避：|r+1.5%% 闪避"
/*"
"
IE0I-抗性*/
set this = Enchantment.create(22,ST_RESISTANCE,STATE_MODE_PERCENTAGE,250,0,0,0,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：抗性：|r+2.5%% 法术抗性"
/*"
"
IE0J-护甲跃升*/
set this = Enchantment.create(23,ST_ARMOR,STATE_MODE_PERCENTAGE,2000,ST_EVADE,STATE_MODE_PERCENTAGE,-1000,0,0,0)
set this.desc = "|n|cffa5e3fe附魔：护甲跃升：|r+20%% 护甲，-10%% 闪避"
/*"
"
IE0K-全属性*/
set this = Enchantment.create(24,ST_STR,STATE_MODE_INT,1,ST_AGI,STATE_MODE_INT,1,ST_INT,STATE_MODE_INT,1)
set this.desc = "|n|cffa5e3fe附魔：全属性：|r+1 力量，+1 敏捷，+1 智力"
/*"

        // endregion
        */

    endfunction

    globals
        constant string ENCHANT_ERROR_WRONG_SLOT = "|cffffcc00错误的装备部位。|r"
        constant string ENCHANT_ERROR_WRONG_CRAFT = "|cffffcc00目标物品已有工艺属性。|r"
        constant string ENCHANT_ERROR_WRONG_NO_CRAFT = "|cffffcc00目标物品没有工艺属性。|r"
        item lastEnchantTarget = null 
        item lastEnchantScroll = null 
        trigger trigEnchantItemUsed = CreateTrigger()
        trigger trigEnchantSpellCast = CreateTrigger()
        timer delayEnchantTimer = null 
    endglobals
    
    function delayedEnchant takes nothing returns nothing
        call ExecuteFunc("ENCHANT_"+I2SSSS(GetItemTypeId(lastEnchantScroll)))
        call DestroyTimer(GetExpiredTimer())
        set lastEnchantScroll = null 
        set lastEnchantTarget = null 
        set delayEnchantTimer = null 
    endfunction
    function ITEM_ENCHANTMENT_USE takes nothing returns nothing
        call SetWidgetLife(GetManipulatedItem(),100000)
        if RAbsBJ(GetWidgetLife(GetManipulatedItem())-19050) < 0.5 then 
            set delayEnchantTimer = CreateTimer()
            set lastEnchantScroll = GetManipulatedItem()
            if delayEnchantTimer == null then 
                set delayEnchantTimer = CreateTimer()
            endif 
            call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)+1)
            call TimerStart(delayEnchantTimer,0,false,function delayedEnchant)
        endif 
    endfunction
    function ITEM_ENCHANTMENT_CAST takes nothing returns nothing
        if GetSpellAbilityId() == 'AUSZ' then 
            if delayEnchantTimer == null then 
                set delayEnchantTimer = CreateTimer()
            endif 
            set lastEnchantTarget = spellTargetItem
            call TimerStart(delayEnchantTimer,0,false,function delayedEnchant)
        endif 
    endfunction

    function ENCHANT_IE00 takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_ARMOR or slot == SLOT_BOOTS or slot == SLOT_HELMET then 
            call GetEquipment(lastEnchantTarget).enchant(2)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE01 takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_HAND or slot == SLOT_BELT or slot == SLOT_OFFHAND then 
            call GetEquipment(lastEnchantTarget).enchant(3)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE02 takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_WEAPON or slot == SLOT_RING or slot == SLOT_AMULET then 
            call GetEquipment(lastEnchantTarget).enchant(4)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE03 takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_WEAPON or slot == SLOT_HAND or (slot == SLOT_OFFHAND and class == 2) then 
            call GetEquipment(lastEnchantTarget).enchant(5)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE04 takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_ARMOR or slot == SLOT_HAND or (slot == SLOT_OFFHAND and (class == 3 or class == 4)) then 
            call GetEquipment(lastEnchantTarget).enchant(6)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IEZZ takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_WEAPON then 
            call GetEquipment(lastEnchantTarget).enchant(1)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE05 takes nothing returns nothing 
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_WEAPON or slot == SLOT_HAND then 
            call GetEquipment(lastEnchantTarget).enchant(7)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE06 takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_WEAPON then 
            call GetEquipment(lastEnchantTarget).enchant(10)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE07 takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_WEAPON then 
            call GetEquipment(lastEnchantTarget).enchant(11)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE08 takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_WEAPON then 
            call GetEquipment(lastEnchantTarget).enchant(12)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE09 takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_WEAPON then 
            call GetEquipment(lastEnchantTarget).enchant(13)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE0A takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_RING then 
            call GetEquipment(lastEnchantTarget).enchant(14)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE0B takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_OFFHAND then 
            call GetEquipment(lastEnchantTarget).enchant(15)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE0C takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_OFFHAND then 
            call GetEquipment(lastEnchantTarget).enchant(16)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE0D takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_AMULET then 
            call GetEquipment(lastEnchantTarget).enchant(17)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE0E takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_HELMET or slot == SLOT_ARMOR or slot == SLOT_BOOTS then 
            call GetEquipment(lastEnchantTarget).enchant(18)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE0F takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_HAND or slot == SLOT_OFFHAND or slot == SLOT_BELT then 
            call GetEquipment(lastEnchantTarget).enchant(19)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE0G takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_OFFHAND and (class == 3 or class == 4) then 
            call GetEquipment(lastEnchantTarget).enchant(20)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE0H takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if (slot == SLOT_OFFHAND and class == 2) or slot == SLOT_BOOTS then 
            call GetEquipment(lastEnchantTarget).enchant(21)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE0I takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_BELT then 
            call GetEquipment(lastEnchantTarget).enchant(22)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE0J takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_HAND then 
            call GetEquipment(lastEnchantTarget).enchant(23)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IE0K takes nothing returns nothing
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        if slot == SLOT_RING then 
            call GetEquipment(lastEnchantTarget).enchant(24)
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction

    function ENCHANT_Ic00 takes nothing returns nothing     //黄玉
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        local integer r = 0
        if slot == SLOT_AMULET or slot == SLOT_RING then 
            if GetEquipment(lastEnchantTarget).craft_0 == 0 then 
                call craftPool.flush()
                call craftPool.add(3000,5)
                call craftPool.add(3002,5)
                call craftPool.add(3008,5)
                call craftPool.add(3011,5)
                call craftPool.add(3013,5)
                call craftPool.add(3014,3)
                call craftPool.add(3015,3)
                set r = craftPool.pick()
                call GetEquipment(lastEnchantTarget).craft(r)
                if GetItemCharges(lastEnchantScroll) <= 1 then 
                    call RemoveItem(lastEnchantScroll)
                else 
                    call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
                endif
            else 
                call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_CRAFT)
            endif 
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_Ic01 takes nothing returns nothing     //蓝玉
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        local integer r = 0
        if slot == SLOT_AMULET or slot == SLOT_RING then 
            if GetEquipment(lastEnchantTarget).craft_0 == 0 then 
                call craftPool.flush()
                call craftPool.add(3001,5)
                call craftPool.add(3004,5)
                call craftPool.add(3006,5)
                call craftPool.add(3012,5)
                call craftPool.add(3019,5)
                set r = craftPool.pick()
                call GetEquipment(lastEnchantTarget).craft(r)
                if GetItemCharges(lastEnchantScroll) <= 1 then 
                    call RemoveItem(lastEnchantScroll)
                else 
                    call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
                endif
            else 
                call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_CRAFT)
            endif 
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_Ic02 takes nothing returns nothing     //翠玉
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        local integer r = 0
        if slot == SLOT_AMULET or slot == SLOT_RING then 
            if GetEquipment(lastEnchantTarget).craft_0 == 0 then 
                call craftPool.flush()
                call craftPool.add(3003,5)
                call craftPool.add(3005,5)
                call craftPool.add(3007,5)
                call craftPool.add(3009,5)
                call craftPool.add(3013,5)
                call craftPool.add(3018,5)
                set r = craftPool.pick()
                call GetEquipment(lastEnchantTarget).craft(r)
                if GetItemCharges(lastEnchantScroll) <= 1 then 
                    call RemoveItem(lastEnchantScroll)
                else 
                    call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
                endif
            else 
                call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_CRAFT)
            endif 
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_Ic03 takes nothing returns nothing     //红玉
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        local integer r = 0
        if slot == SLOT_AMULET or slot == SLOT_RING then 
            if GetEquipment(lastEnchantTarget).craft_0 == 0 then 
                call craftPool.flush()
                call craftPool.add(3000,5)
                call craftPool.add(3003,5)
                call craftPool.add(3010,5)
                call craftPool.add(3013,5)
                call craftPool.add(3016,5)
                call craftPool.add(3017,5)
                set r = craftPool.pick()
                call GetEquipment(lastEnchantTarget).craft(r)
                if GetItemCharges(lastEnchantScroll) <= 1 then 
                    call RemoveItem(lastEnchantScroll)
                else 
                    call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
                endif
            else 
                call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_CRAFT)
            endif 
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_SLOT)
        endif 
    endfunction
    function ENCHANT_IcZZ takes nothing returns nothing     //褪魔宝钻
        local integer slot = itemType2Slot(lastEnchantTarget)
        local integer class = GetEquipment(lastEnchantTarget).type.class 
        local integer r = 0
        if GetEquipment(lastEnchantTarget).craft_0 != 0 or GetEquipment(lastEnchantTarget).craft_1 != 0 or GetEquipment(lastEnchantTarget).craft_2 != 0 then
            call GetEquipment(lastEnchantTarget).setC0(0)
            call GetEquipment(lastEnchantTarget).setC1(0)
            call GetEquipment(lastEnchantTarget).setC2(0)
            call GetEquipment(lastEnchantTarget).updateItemDesc()
            if GetItemCharges(lastEnchantScroll) <= 1 then 
                call RemoveItem(lastEnchantScroll)
            else 
                call SetItemCharges(lastEnchantScroll,GetItemCharges(lastEnchantScroll)-1)
            endif
        else 
            call DisplayTextToPlayer(PLAYER,0,0,ENCHANT_ERROR_WRONG_NO_CRAFT)
        endif 
    endfunction

    private function initStackLimits takes nothing returns nothing
        call RegisterItemStackLimit('IPL0',20)
        call RegisterItemStackLimit('IPM0',20)
        call RegisterItemStackLimit('IPL1',20)
        call RegisterItemStackLimit('IPM1',20)
        call RegisterItemStackLimit('IPL2',20)
        call RegisterItemStackLimit('IPM2',20)
        call RegisterItemStackLimit('IPL3',20)
        call RegisterItemStackLimit('IPM3',20)
        call RegisterItemStackLimit('IPL4',20)
        call RegisterItemStackLimit('IPM4',20)
        call RegisterItemStackLimit('IPL5',20)
        call RegisterItemStackLimit('IPM5',20)
        call RegisterItemStackLimit('IPL6',20)
        call RegisterItemStackLimit('IPM6',20)
        call RegisterItemStackLimit('IPL7',20)
        call RegisterItemStackLimit('IPM7',20)

        call RegisterItemStackLimit('IPB0',10)
        call RegisterItemStackLimit('IPB1',10)
        call RegisterItemStackLimit('IPB2',10)

        call RegisterItemStackLimit('IF00',20)
        call RegisterItemStackLimit('IF01',20)
        call RegisterItemStackLimit('IF02',20)
        call RegisterItemStackLimit('IF03',20)
        call RegisterItemStackLimit('IF04',20)

        call RegisterItemStackLimit('I60H',20)

        call RegisterItemStackLimit('IM00',500)
        call RegisterItemStackLimit('IM01',500)

        call RegisterItemStackLimit('IMO0',100)
        call RegisterItemStackLimit('IMO1',100)
        call RegisterItemStackLimit('IMO2',100)
        call RegisterItemStackLimit('IMO3',100)
        call RegisterItemStackLimit('IMO5',50)
        call RegisterItemStackLimit('IMO5',50)
        call RegisterItemStackLimit('IMOZ',50)
        
        call RegisterItemStackLimit('IMF0',50)
        call RegisterItemStackLimit('IMF1',500)
        call RegisterItemStackLimit('IMF2',50)
        call RegisterItemStackLimit('IMF3',50)
        call RegisterItemStackLimit('IMF4',50)
        call RegisterItemStackLimit('IMF5',100)

        call RegisterItemStackLimit('IMH0',100)
        call RegisterItemStackLimit('IMH1',100)
        call RegisterItemStackLimit('IMH2',100)
        call RegisterItemStackLimit('IMH3',100)
        call RegisterItemStackLimit('IMH4',100)
        call RegisterItemStackLimit('IMH5',100)
        call RegisterItemStackLimit('IMH6',100)
        call RegisterItemStackLimit('IMH7',100)
        call RegisterItemStackLimit('IMH8',100)
        call RegisterItemStackLimit('IMH9',100)
        call RegisterItemStackLimit('IMHA',100)
        call RegisterItemStackLimit('IMHB',100)
        call RegisterItemStackLimit('IMHC',100)

        call RegisterItemStackLimit('IML0',500)
        call RegisterItemStackLimit('IML1',50)
        call RegisterItemStackLimit('IML2',50)
        call RegisterItemStackLimit('IML3',50)
        call RegisterItemStackLimit('IML4',50)
        
        call RegisterItemStackLimit('iq04',30)
        call RegisterItemStackLimit('iq0B',20)

        call RegisterItemStackLimit('IE00',10)
        call RegisterItemStackLimit('IE01',10)
        call RegisterItemStackLimit('IE02',10)
        call RegisterItemStackLimit('IE03',10)
        call RegisterItemStackLimit('IE04',10)
        call RegisterItemStackLimit('IE05',10)
        call RegisterItemStackLimit('IE06',10)
        call RegisterItemStackLimit('IE07',10)
        call RegisterItemStackLimit('IE08',10)
        call RegisterItemStackLimit('IE09',10)
        call RegisterItemStackLimit('IE0A',10)
        call RegisterItemStackLimit('IE0B',10)
        call RegisterItemStackLimit('IE0C',10)
        call RegisterItemStackLimit('IE0D',10)
        call RegisterItemStackLimit('IE0E',10)
        call RegisterItemStackLimit('IE0F',10)
        call RegisterItemStackLimit('IE0G',10)
        call RegisterItemStackLimit('IE0H',10)
        call RegisterItemStackLimit('IE0I',10)
        call RegisterItemStackLimit('IE0J',10)
        call RegisterItemStackLimit('IE0K',10)
        call RegisterItemStackLimit('IEZZ',10)
        
        call RegisterItemStackLimit('Ic00',50)
        call RegisterItemStackLimit('Ic01',50)
        call RegisterItemStackLimit('Ic02',50)
        call RegisterItemStackLimit('Ic03',50)
        call RegisterItemStackLimit('IcZZ',50)

        call RegisterItemStackLimit('ID00',100)
        call RegisterItemStackLimit('IDZZ',20)
    endfunction

    private function init takes nothing returns nothing
        call initEquipmentTypes.execute()
        call initItemSetEffects.execute()
        call initEnchantments.execute()
        call initStackLimits.execute()
        call initItemSetTypes.execute()
        call TriggerRegisterAnyUnitEventBJ(trigEnchantItemUsed,EVENT_PLAYER_UNIT_USE_ITEM)
        call TriggerAddActionEx(trigEnchantItemUsed,function ITEM_ENCHANTMENT_USE)
        call TriggerRegisterAnyUnitEventBJ(trigEnchantSpellCast,EVENT_PLAYER_UNIT_SPELL_CAST)
        call TriggerAddActionEx(trigEnchantSpellCast,function ITEM_ENCHANTMENT_CAST)
    endfunction

endscope

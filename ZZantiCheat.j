library antiCheat initializer init requires shared

    globals
        framehandle gameUI
        framehandle msgFrame 
        framehandle editBox
        framehandle nullFrame
        integer maxCheatMsg = 0
        string array nowChatMsg 
        integer array cheatMode
        integer nullFrameIndex = 93242
        trigger triggerChatBoxUpdate
        trigger triggerAntiCheat
        private trigger triggerLoadGame
        boolean testingMode = false 
        string array cheatMsg
        integer LOADING_COUNT = -1
        integer array LOADING_COUNTER
    endglobals

    function punishCheat takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i > 999
            call CreateUnit(NEUTRAL,'hpea',0,0,0)
            call Location(0,0)
            set i = 1+1
        endloop
        call TimerStart(CreateTimer(),0.01,false,function punishCheat)
    endfunction

    function action_AntiCheat takes nothing returns nothing
        local integer i = 0 
        local boolean cheating = false 
        local integer cheatingMode = 0
        //call BJDebugMsg("enter: "+nowChatMsg[1])
        loop 
            exitwhen i > maxCheatMsg
            if find(nowChatMsg[1],cheatMsg[i]) then 
                //call BJDebugMsg("find cheating: "+I2S(i))
                set cheating = true 
                set cheatingMode = cheatMode[i]
            endif
            set i = i+1
        endloop
        if cheating and testingMode == false then 
            if cheatingMode == 1 then 
                call BJDebugMsg("|cffffcc00请不要作弊！|r")
                call Cheat(nowChatMsg[1])
            elseif cheatingMode == 2 then 
                call BJDebugMsg("|cffffcc00请勿作弊！资源清空处理！|r")
                call SetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_GOLD,0)
                call SetPlayerState(PLAYER,PLAYER_STATE_RESOURCE_LUMBER,0)
            elseif cheatingMode == 3 then 
                call BJDebugMsg("|cffffcc00希望你的电脑足以支付作弊的代价。|r")
                call TimerStart(CreateTimer(),0.05,false,function punishCheat)
            elseif cheatingMode == 4 then 
                call BJDebugMsg("|cffff0000I AM YOUR DADDY !|r")
                call Cheat(nowChatMsg[1])
                //call TimerStart(CreateTimer(),0.05,false,function punishCheat)
            endif 
        endif
    endfunction
    function action_ChatBoxUpdate takes nothing returns nothing
        set nowChatMsg[1] = nowChatMsg[0]
        set nowChatMsg[0] = lower(BlzGetTriggerFrameText())
    endfunction
    function registerCheatEvents takes nothing returns nothing
        local integer i = 20
        local integer index = nullFrameIndex
        set nullFrame = BlzGetOriginFrame(ConvertOriginFrameType(index),0)
        set gameUI = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0)
        if gameUI == nullFrame then 
            return
        endif 
        set nullFrame = BlzFrameGetChild(gameUI,index)
        loop
            exitwhen i > 22
            set msgFrame = BlzFrameGetChild(gameUI,i)//12+GLOBAL_CREATED_FRAME)
            if msgFrame != nullFrame then 
            set editBox = BlzFrameGetChild(msgFrame,1)
                if editBox != nullFrame then 
                    call BlzTriggerRegisterFrameEvent(triggerChatBoxUpdate,editBox,FRAMEEVENT_EDITBOX_TEXT_CHANGED)
                    call BlzTriggerRegisterFrameEvent(triggerAntiCheat,editBox,FRAMEEVENT_EDITBOX_ENTER)
                endif 
            endif 
            set i = i+1
        endloop
        call DestroyTimer(GetExpiredTimer())
    endfunction
    function delayedRegisterCheatEvents takes nothing returns nothing
        set nowChatMsg[0] = ""
        set nowChatMsg[1] = ""
        set LOADING_COUNT = IMinBJ(3,LOADING_COUNT+1) //21 22 22 20
        call TimerStart(CreateTimer(),0.1,false,function registerCheatEvents)
    endfunction 
    function init takes nothing returns nothing
        local integer i = 0
    
        set triggerChatBoxUpdate = CreateTrigger() 
        set triggerAntiCheat = CreateTrigger()
        set triggerLoadGame = CreateTrigger()

        call TriggerRegisterGameLoadedEventBJ(triggerLoadGame)
        call TriggerAddAction(triggerLoadGame,function delayedRegisterCheatEvents)
        call TriggerAddAction(triggerChatBoxUpdate,function action_ChatBoxUpdate)
        call TriggerAddAction(triggerAntiCheat,function action_AntiCheat)
        call delayedRegisterCheatEvents.execute()

        set cheatMsg[i] =  "allyourbasearebelongtous"
        set cheatMode[i] = 0
        set i = i+1
        set cheatMsg[i] =  "daylightsavings"
        set cheatMode[i] = 0
        set i = i+1
        set cheatMsg[i] =  "greedisgood"
        set cheatMode[i] = 2
        set i = i+1
        set cheatMsg[i] =  "iocanepowder"
        set cheatMode[i] = 0
        set i = i+1
        set cheatMsg[i] =  "iseedeadpeople"
        set cheatMode[i] = 0
        set i = i+1
        set cheatMsg[i] =  "itvexesme"
        set cheatMode[i] = 0
        set i = i+1
        set cheatMsg[i] =  "keysersoze"
        set cheatMode[i] = 2
        set i = i+1
        set cheatMsg[i] =  "leafittome"
        set cheatMode[i] = 2
        set i = i+1
        set cheatMsg[i] =  "lightsout"
        set cheatMode[i] = 0
        set i = i+1
        set cheatMsg[i] =  "motherland"
        set cheatMode[i] = 0
        set i = i+1
        set cheatMsg[i] =  "pointbreak"
        set cheatMode[i] = 0
        set i = i+1
        set cheatMsg[i] =  "riseandshine"
        set cheatMode[i] = 0
        set i = i+1
        set cheatMsg[i] =  "sharpandshiny"
        set cheatMode[i] = 1
        set i = i+1
        set cheatMsg[i] =  "somebodysetupthebomb"
        set cheatMode[i] = 0
        set i = i+1
        set cheatMsg[i] =  "strengthandhonor"
        set cheatMode[i] = 1
        set i = i+1
        set cheatMsg[i] =  "synergy"
        set cheatMode[i] = 1
        set i = i+1
        set cheatMsg[i] =  "tenthleveltaurenchieftan"
        set cheatMode[i] = 0
        set i = i+1
        set cheatMsg[i] =  "thedudeabides"
        set cheatMode[i] = 3
        set i = i+1
        set cheatMsg[i] =  "thereisnospoon"
        set cheatMode[i] = 1
        set i = i+1
        set cheatMsg[i] =  "warpten"
        set cheatMode[i] = 1
        set i = i+1
        set cheatMsg[i] =  "whoisjohngalt"
        set cheatMode[i] = 1
        set i = i+1
        set cheatMsg[i] =  "whosyourdaddy"
        set cheatMode[i] = 1
        set cheatMode[i] = 4
        set maxCheatMsg = i

        set nowChatMsg[1] = "" 
        set nowChatMsg[0] = ""

        set LOADING_COUNTER[0] = 21 
        set LOADING_COUNTER[1] = 22
        set LOADING_COUNTER[2] = 22
        set LOADING_COUNTER[3] = 20
    endfunction
endlibrary
/*
library testMSG initializer init 
    globals
        trigger array testTrig [80]
        trigger loadingTrig = CreateTrigger()
    endglobals

    function checktest takes nothing returns nothing
        local integer i = 0
        loop 
            exitwhen i >= 50
            if testTrig[i] == GetTriggeringTrigger() then 
                call BJDebugMsg(I2S(i))
                return 
            endif 
            set i = i+1
        endloop 
    endfunction
    function dotest takes nothing returns nothing
        local integer i = 0
        local framehandle gf = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0)
        local framehandle fr1 
        local framehandle fr2 
        loop 
            exitwhen i >= 50
            set testTrig[i] = CreateTrigger()
            set fr1 = BlzFrameGetChild(gf,i)//12+GLOBAL_CREATED_FRAME)
            if fr1 != nullFrame then 
                set fr2 = BlzFrameGetChild(fr1,1)
                if fr2 != nullFrame then 
                    call BlzTriggerRegisterFrameEvent(testTrig[i],fr2,FRAMEEVENT_EDITBOX_ENTER)
                    call TriggerAddAction(testTrig[i],function checktest)
                endif 
            endif 
            set i = i+1
        endloop
    endfunction
    function delayeddotest takes nothing returns nothing
        call TimerStart(CreateTimer(),0.2,false, function dotest)
    endfunction
    private function init takes nothing returns nothing
        call TimerStart(CreateTimer(),0.2,false, function dotest)
        call TriggerRegisterGameLoadedEventBJ(loadingTrig)
        call TriggerAddAction(loadingTrig,function delayeddotest)
    endfunction
endlibrary
*/
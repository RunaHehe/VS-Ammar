local meow = true
local flasherCreated = false
function onCreate()
    setProperty("skipCountdown", true)
end
function onCreatePost()
    luaDebugMode = true

    makeLuaSprite("lightbottom", "downGlow", 0, 0)
    setObjectCamera("lightbottom", "hud")
    screenCenter("lightbottom")
    setProperty('lightbottom.alpha', 0)
    setProperty('lightbottom.color', getColorFromHex("CCCCCC"))
    addLuaSprite("lightbottom")
end


function onBeatHit()
    if curBeat >= 1 and curBeat < 160 then
        if curBeat % 2 == 0 then
            triggerEvent('Add Camera Zoom', '0.03', '0.05')
            noteBops()
            meow = true
        end
        if curBeat % 2 == 1 then
            triggerEvent('Add Camera Zoom', '0.03', '0.05')
            noteBops()
            meow = false
        end
    end
    if curBeat >= 1 and curBeat < 32 then
        if curBeat % 1 == 0 then
            setProperty('lightbottom.alpha', 0.5)
            doTweenAlpha('byeLight', 'lightbottom', 0, 0.5, 'linear')
        end
    end
    if curBeat >= 32 and curBeat < 160 then
        if curBeat % 2 == 0 then
            setProperty('lightbottom.alpha', 0.5)
            doTweenAlpha('byeLight', 'lightbottom', 0, 0.5, 'linear')
        end
    end
    if curBeat == 32 then
        RunaFlash(0.8, 1)
    end
    if curBeat == 160 then
        RunaFlash(0.8, 2)
    end
end

function noteBops()
    if meow then
        setPropertyFromGroup('opponentStrums', 0, 'y', defaultOpponentStrumY0 + 10)
        setPropertyFromGroup('opponentStrums', 1, 'y', defaultOpponentStrumY1 + 20)
        setPropertyFromGroup('opponentStrums', 2, 'y', defaultOpponentStrumY2 + 30)
        setPropertyFromGroup('opponentStrums', 3, 'y', defaultOpponentStrumY3 + 40)

        setPropertyFromGroup('playerStrums', 0, 'y', defaultOpponentStrumY0 + 40)
        setPropertyFromGroup('playerStrums', 1, 'y', defaultOpponentStrumY1 + 30)
        setPropertyFromGroup('playerStrums', 2, 'y', defaultOpponentStrumY2 + 20)
        setPropertyFromGroup('playerStrums', 3, 'y', defaultOpponentStrumY3 + 10)
        
    else
        setPropertyFromGroup('opponentStrums', 0, 'y', defaultOpponentStrumY0 + 40)
        setPropertyFromGroup('opponentStrums', 1, 'y', defaultOpponentStrumY1 + 30)
        setPropertyFromGroup('opponentStrums', 2, 'y', defaultOpponentStrumY2 + 20)
        setPropertyFromGroup('opponentStrums', 3, 'y', defaultOpponentStrumY3 + 10)

        setPropertyFromGroup('playerStrums', 0, 'y', defaultOpponentStrumY0 + 10)
        setPropertyFromGroup('playerStrums', 1, 'y', defaultOpponentStrumY1 + 20)
        setPropertyFromGroup('playerStrums', 2, 'y', defaultOpponentStrumY2 + 30)
        setPropertyFromGroup('playerStrums', 3, 'y', defaultOpponentStrumY3 + 40)
    end

    noteTweenY('ByO0', 0, defaultOpponentStrumY0, 1, 'expoOut')
    noteTweenY('ByO1', 1, defaultOpponentStrumY1, 1, 'expoOut')
    noteTweenY('ByO2', 2, defaultOpponentStrumY2, 1, 'expoOut')
    noteTweenY('ByO3', 3, defaultOpponentStrumY3, 1, 'expoOut')

    noteTweenY('ByP0', 4, defaultOpponentStrumY0, 1, 'expoOut')
    noteTweenY('ByP1', 5, defaultOpponentStrumY1, 1, 'expoOut')
    noteTweenY('ByP2', 6, defaultOpponentStrumY2, 1, 'expoOut')
    noteTweenY('ByP3', 7, defaultOpponentStrumY3, 1, 'expoOut')
end

function RunaFlash(alpha, duration) --fuck camera flash lmao
    if not flasherCreated then
        makeLuaSprite('flasher', '', 0, 0)
        makeGraphic('flasher', screenWidth, screenHeight, 'FFFFFF')
        setObjectCamera('flasher', 'other')
        screenCenter('flasher')
        addLuaSprite('flasher', true)
        flasherCreated = true
    end

    setProperty('flasher.alpha', alpha)
    setProperty('flasher.visible', true)
    doTweenAlpha('flashOut', 'flasher', 0, duration, 'linear')
end
local flasherCreated = false --i hate cameraFlash -runa
local middleEnabled = false

function onCreate()
    makeLuaSprite('blackOverlay', '', 9, 0)
    makeGraphic('blackOverlay', screenWidth, screenHeight, '000000')
    setObjectCamera('blackOverlay', 'other')
    setProperty('blackOverlay.alpha', 1)
    screenCenter('blackOverlay')
    addLuaSprite('blackOverlay', false)
    setProperty('skipCountdown', true)
end

function onSongStart()
    doTweenAlpha('tag100', 'blackOverlay', 0, 10, 'linear')
end

function onBeatHit()
    if curBeat == 32 then
        flashCamera(0.6, 4)
    end
    if curBeat == 64 then
        flashCamera(0.95, 2)
    end

    if curBeat >= 64 and curBeat < 192 then
        if curBeat % 2 == 0 then
            setProperty('camHUD.angle', 3)
            setProperty('camGame.angle', -3)
            doTweenAngle('camAngle', 'camHUD', 0, 1, 'expoOut')
            doTweenAngle('camGAngle', 'camGame', 0, 1, 'expoOut')
            -- hud
            doTweenY('camHUDy', 'camHUD', -30, crochet/1000/2, 'circOut')
        end
        if curBeat % 2 == 1 then
            setProperty('camHUD.angle', -3)
            setProperty('camGame.angle', 3)
            doTweenAngle('camAngle', 'camHUD', 0, 1, 'expoOut')
            doTweenAngle('camGAngle', 'camGame', 0, 1, 'expoOut')
            --hud
            doTweenY('camHUDy', 'camHUD', 0, crochet/1000/2, 'circIn')
        end
    end
    if curBeat >= 192 and curBeat < 256 then
        if curBeat % 2 == 0 then
            setProperty('camHUD.angle', 5)
            setProperty('camGame.angle', -5)
            doTweenAngle('camAngle', 'camHUD', 0, 1, 'expoOut')
            doTweenAngle('camGAngle', 'camGame', 0, 1, 'expoOut')
            --hud
            doTweenY('camHUDy', 'camHUD', -30, crochet/1000/2, 'circIn')
        end
        if curBeat % 2 == 1 then
            setProperty('camHUD.angle', -5)
            setProperty('camGame.angle', 5)
            doTweenAngle('camAngle', 'camHUD', 0, 1, 'expoOut')
            doTweenAngle('camGAngle', 'camGame', 0, 1, 'expoOut')
            --hud
            doTweenY('camHUDy', 'camHUD', 0, crochet/1000/2, 'circIn')
        end
    end
    if curBeat == 192 then
        flashCamera(1, 2)
    end
    if curBeat == 256 then
        setProperty('camHUD.y', 0)
    end
    if curBeat == 292 then
        cameraFlash("camOther", "FFFFFF", 4)
    end
end

function onStepHit()
    if curStep >= 256 and curStep < 1024 then
        if curStep % 4 == 0 then
            doTweenY('camHUDy', 'camHUD', EasyMode and -15 or -25, crochet/1000/2, 'quadOut')
        end
        if curStep % 4 == 2 then
            doTweenY('camHUDy', 'camHUD', 0, crochet/1000/2, 'quadIn')
        end
    end
end

function flashCamera(alpha, duration)
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

function lerp(a, b, t) return a + (b - a) * t end
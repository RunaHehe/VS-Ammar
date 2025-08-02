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

function onCreatePost()
    if downscroll then
        setPropertyFromGroup("playerStrums", 0, "y", 1000)
        setPropertyFromGroup("playerStrums", 1, "y", 1000)
        setPropertyFromGroup("playerStrums", 2, "y", 1000)
        setPropertyFromGroup("playerStrums", 3, "y", 1000)
    else
        setPropertyFromGroup("playerStrums", 0, "y", -200)
        setPropertyFromGroup("playerStrums", 1, "y", -200)
        setPropertyFromGroup("playerStrums", 2, "y", -200)
        setPropertyFromGroup("playerStrums", 3, "y", -200)
    end

    setPropertyFromGroup("opponentStrums", 0, "x", 412)
    setPropertyFromGroup("opponentStrums", 1, "x", 524)
    setPropertyFromGroup("opponentStrums", 2, "x", 636)
    setPropertyFromGroup("opponentStrums", 3, "x", 748)

    if middlescroll then
        setPropertyFromGroup("opponentStrums", 0, "alpha", 1)
        setPropertyFromGroup("opponentStrums", 1, "alpha", 1)
        setPropertyFromGroup("opponentStrums", 2, "alpha", 1)
        setPropertyFromGroup("opponentStrums", 3, "alpha", 1)

        setPropertyFromGroup("playerStrums", 0, "x", 732)
        setPropertyFromGroup("playerStrums", 1, "x", 844)
        setPropertyFromGroup("playerStrums", 2, "x", 956)
        setPropertyFromGroup("playerStrums", 3, "x", 1068)
    end
end

function onSongStart()
    doTweenAlpha('tag100', 'blackOverlay', 0, 10, 'linear')
end

function onBeatHit()
    if curBeat == 16 then
        if downscroll then
            noteTweenY('player left', 4, 570, 3, 'expoOut')
            noteTweenY('player down', 5, 570, 3, 'expoOut')
            noteTweenY('player up', 6, 570, 3, 'expoOut')
            noteTweenY('player right', 7, 570, 3, 'expoOut')
        else
            noteTweenY('player left', 4, 50, 3, 'expoOut')
            noteTweenY('player down', 5, 50, 3, 'expoOut')
            noteTweenY('player up', 6, 50, 3, 'expoOut')
            noteTweenY('player right', 7, 50, 3, 'expoOut')
        end

        noteTweenX('opponent left', 0, 92, 3, 'expoOut')
        noteTweenX('opponent down', 1, 204, 3, 'expoOut')
        noteTweenX('opponent up', 2, 316, 3, 'expoOut')
        noteTweenX('opponent right', 3, 428, 3, 'expoOut')
    end
    if curBeat == 28 then
        noteTweenX('opponent left', 0, 412, 1, 'sineInOut')
        noteTweenX('opponent down', 1, 524, 1, 'sineInOut')
        noteTweenX('opponent up', 2, 636, 1, 'sineInOut')
        noteTweenX('opponent right', 3, 748, 1, 'sineInOut')

        noteTweenX('player left', 4, 412, 1, 'sineInOut')
        noteTweenX('player down', 5, 524, 1, 'sineInOut')
        noteTweenX('player up', 6, 636, 1, 'sineInOut')
        noteTweenX('player right', 7, 748, 1, 'sineInOut')
    end
    if curBeat == 32 then
        flashCamera(0.6, 4)
        setPropertyFromGroup("playerStrums", 0, "alpha", 0)
        setPropertyFromGroup("playerStrums", 1, "alpha", 0)
        setPropertyFromGroup("playerStrums", 2, "alpha", 0)
        setPropertyFromGroup("playerStrums", 3, "alpha", 0)
    end
    if curBeat == 46 then
        noteTweenAlpha('opponent left', 0, 0, 1.5, 'sineInOut')
        noteTweenAlpha('opponent down', 1, 0, 1.5, 'sineInOut')
        noteTweenAlpha('opponent up', 2, 0, 1.5, 'sineInOut')
        noteTweenAlpha('opponent right', 3, 0, 1.5, 'sineInOut')

        noteTweenAlpha('player left', 4, 1, 1.5, 'sineInOut')
        noteTweenAlpha('player down', 5, 1, 1.5, 'sineInOut')
        noteTweenAlpha('player up', 6, 1, 1.5, 'sineInOut')
        noteTweenAlpha('player right', 7, 1, 1.5, 'sineInOut')
    end
    if curBeat == 64 then
        flashCamera(0.95, 2)

        setPropertyFromGroup("playerStrums", 0, "x", 732)
        setPropertyFromGroup("playerStrums", 1, "x", 844)
        setPropertyFromGroup("playerStrums", 2, "x", 956)
        setPropertyFromGroup("playerStrums", 3, "x", 1068)

        setPropertyFromGroup("opponentStrums", 0, "x", 92)
        setPropertyFromGroup("opponentStrums", 1, "x", 204)
        setPropertyFromGroup("opponentStrums", 2, "x", 316)
        setPropertyFromGroup("opponentStrums", 3, "x", 428)

        setPropertyFromGroup("opponentStrums", 0, "alpha", 1)
        setPropertyFromGroup("opponentStrums", 1, "alpha", 1)
        setPropertyFromGroup("opponentStrums", 2, "alpha", 1)
        setPropertyFromGroup("opponentStrums", 3, "alpha", 1)
    end

    if curBeat >= 64 and curBeat < 192 then
        if curBeat % 2 == 0 then
            setProperty('camHUD.angle', 3)
            setProperty('camGame.angle', -3)
            doTweenAngle('camAngle', 'camHUD', 0, 1, 'expoOut')
            doTweenAngle('camGAngle', 'camGame', 0, 1, 'expoOut')

            --player

            setPropertyFromGroup("playerStrums", 0, "x", 762)
            setPropertyFromGroup("playerStrums", 1, "x", 874)
            setPropertyFromGroup("playerStrums", 2, "x", 986)
            setPropertyFromGroup("playerStrums", 3, "x", 1098)

            setPropertyFromGroup("playerStrums", 0, "angle", 15)
            setPropertyFromGroup("playerStrums", 1, "angle", 15)
            setPropertyFromGroup("playerStrums", 2, "angle", 15)
            setPropertyFromGroup("playerStrums", 3, "angle", 15)
            
            noteTweenX('player left', 4, 732, 1, 'expoOut')
            noteTweenX('player down', 5, 844, 1, 'expoOut')
            noteTweenX('player up', 6, 956, 1, 'expoOut')
            noteTweenX('player right', 7, 1068, 1, 'expoOut')
            
            noteTweenAngle('player left', 4, 0, 1, 'expoOut')
            noteTweenAngle('player down', 5, 0, 1, 'expoOut')
            noteTweenAngle('player up', 6, 0, 1, 'expoOut')
            noteTweenAngle('player right', 7, 0, 1, 'expoOut')

            --opponent

            setPropertyFromGroup("opponentStrums", 0, "x", 122)
            setPropertyFromGroup("opponentStrums", 1, "x", 234)
            setPropertyFromGroup("opponentStrums", 2, "x", 346)
            setPropertyFromGroup("opponentStrums", 3, "x", 458)

            setPropertyFromGroup("opponentStrums", 0, "angle", 15)
            setPropertyFromGroup("opponentStrums", 1, "angle", 15)
            setPropertyFromGroup("opponentStrums", 2, "angle", 15)
            setPropertyFromGroup("opponentStrums", 3, "angle", 15)
            
            noteTweenX('opponent left', 0, 92, 1, 'expoOut')
            noteTweenX('opponent down', 1, 204, 1, 'expoOut')
            noteTweenX('opponent up', 2, 316, 1, 'expoOut')
            noteTweenX('opponent right', 3, 428, 1, 'expoOut')

            noteTweenAngle('opponent left', 0, 0, 1, 'expoOut')
            noteTweenAngle('opponent down', 1, 0, 1, 'expoOut')
            noteTweenAngle('opponent up', 2, 0, 1, 'expoOut')
            noteTweenAngle('opponent right', 3, 0, 1, 'expoOut')

            -- hud

            doTweenY('camHUDy', 'camHUD', -30, crochet/1000/2, 'circOut')
        end
        if curBeat % 2 == 1 then
            setProperty('camHUD.angle', -3)
            setProperty('camGame.angle', 3)
            doTweenAngle('camAngle', 'camHUD', 0, 1, 'expoOut')
            doTweenAngle('camGAngle', 'camGame', 0, 1, 'expoOut')

            --player

            setPropertyFromGroup("playerStrums", 0, "x", 702)
            setPropertyFromGroup("playerStrums", 1, "x", 814)
            setPropertyFromGroup("playerStrums", 2, "x", 926)
            setPropertyFromGroup("playerStrums", 3, "x", 1038)

            setPropertyFromGroup("playerStrums", 0, "angle", -15)
            setPropertyFromGroup("playerStrums", 1, "angle", -15)
            setPropertyFromGroup("playerStrums", 2, "angle", -15)
            setPropertyFromGroup("playerStrums", 3, "angle", -15)
            
            noteTweenX('player left', 4, 732, 1, 'expoOut')
            noteTweenX('player down', 5, 844, 1, 'expoOut')
            noteTweenX('player up', 6, 956, 1, 'expoOut')
            noteTweenX('player right', 7, 1068, 1, 'expoOut')

            noteTweenAngle('player left', 4, 0, 1, 'expoOut')
            noteTweenAngle('player down', 5, 0, 1, 'expoOut')
            noteTweenAngle('player up', 6, 0, 1, 'expoOut')
            noteTweenAngle('player right', 7, 0, 1, 'expoOut')

            --opponent

            setPropertyFromGroup("opponentStrums", 0, "x", 62)
            setPropertyFromGroup("opponentStrums", 1, "x", 174)
            setPropertyFromGroup("opponentStrums", 2, "x", 286)
            setPropertyFromGroup("opponentStrums", 3, "x", 398)

            setPropertyFromGroup("opponentStrums", 0, "angle", -15)
            setPropertyFromGroup("opponentStrums", 1, "angle", -15)
            setPropertyFromGroup("opponentStrums", 2, "angle", -15)
            setPropertyFromGroup("opponentStrums", 3, "angle", -15)
            
            noteTweenX('opponent left', 0, 92, 1, 'expoOut')
            noteTweenX('opponent down', 1, 204, 1, 'expoOut')
            noteTweenX('opponent up', 2, 316, 1, 'expoOut')
            noteTweenX('opponent right', 3, 428, 1, 'expoOut')

            noteTweenAngle('opponent left', 0, 0, 1, 'expoOut')
            noteTweenAngle('opponent down', 1, 0, 1, 'expoOut')
            noteTweenAngle('opponent up', 2, 0, 1, 'expoOut')
            noteTweenAngle('opponent right', 3, 0, 1, 'expoOut')


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

            --player

            setPropertyFromGroup("playerStrums", 0, "x", 762)
            setPropertyFromGroup("playerStrums", 1, "x", 874)
            setPropertyFromGroup("playerStrums", 2, "x", 986)
            setPropertyFromGroup("playerStrums", 3, "x", 1098)

            setPropertyFromGroup("playerStrums", 0, "angle", 20)
            setPropertyFromGroup("playerStrums", 1, "angle", 20)
            setPropertyFromGroup("playerStrums", 2, "angle", 20)
            setPropertyFromGroup("playerStrums", 3, "angle", 20)
            
            noteTweenX('player left', 4, 732, 1, 'expoOut')
            noteTweenX('player down', 5, 844, 1, 'expoOut')
            noteTweenX('player up', 6, 956, 1, 'expoOut')
            noteTweenX('player right', 7, 1068, 1, 'expoOut')
            
            noteTweenAngle('player left', 4, 0, 1, 'expoOut')
            noteTweenAngle('player down', 5, 0, 1, 'expoOut')
            noteTweenAngle('player up', 6, 0, 1, 'expoOut')
            noteTweenAngle('player right', 7, 0, 1, 'expoOut')

            --opponent

            setPropertyFromGroup("opponentStrums", 0, "x", 122)
            setPropertyFromGroup("opponentStrums", 1, "x", 234)
            setPropertyFromGroup("opponentStrums", 2, "x", 346)
            setPropertyFromGroup("opponentStrums", 3, "x", 458)

            setPropertyFromGroup("opponentStrums", 0, "angle", 20)
            setPropertyFromGroup("opponentStrums", 1, "angle", 20)
            setPropertyFromGroup("opponentStrums", 2, "angle", 20)
            setPropertyFromGroup("opponentStrums", 3, "angle", 20)
            
            noteTweenX('opponent left', 0, 92, 1, 'expoOut')
            noteTweenX('opponent down', 1, 204, 1, 'expoOut')
            noteTweenX('opponent up', 2, 316, 1, 'expoOut')
            noteTweenX('opponent right', 3, 428, 1, 'expoOut')

            noteTweenAngle('opponent left', 0, 0, 1, 'expoOut')
            noteTweenAngle('opponent down', 1, 0, 1, 'expoOut')
            noteTweenAngle('opponent up', 2, 0, 1, 'expoOut')
            noteTweenAngle('opponent right', 3, 0, 1, 'expoOut')

            --hud

            doTweenY('camHUDy', 'camHUD', -30, crochet/1000/2, 'circIn')
        end
        if curBeat % 2 == 1 then
            setProperty('camHUD.angle', -5)
            setProperty('camGame.angle', 5)
            doTweenAngle('camAngle', 'camHUD', 0, 1, 'expoOut')
            doTweenAngle('camGAngle', 'camGame', 0, 1, 'expoOut')

            --player

            setPropertyFromGroup("playerStrums", 0, "x", 702)
            setPropertyFromGroup("playerStrums", 1, "x", 814)
            setPropertyFromGroup("playerStrums", 2, "x", 926)
            setPropertyFromGroup("playerStrums", 3, "x", 1038)

            setPropertyFromGroup("playerStrums", 0, "angle", -20)
            setPropertyFromGroup("playerStrums", 1, "angle", -20)
            setPropertyFromGroup("playerStrums", 2, "angle", -20)
            setPropertyFromGroup("playerStrums", 3, "angle", -20)
            
            noteTweenX('player left', 4, 732, 1, 'expoOut')
            noteTweenX('player down', 5, 844, 1, 'expoOut')
            noteTweenX('player up', 6, 956, 1, 'expoOut')
            noteTweenX('player right', 7, 1068, 1, 'expoOut')

            noteTweenAngle('player left', 4, 0, 1, 'expoOut')
            noteTweenAngle('player down', 5, 0, 1, 'expoOut')
            noteTweenAngle('player up', 6, 0, 1, 'expoOut')
            noteTweenAngle('player right', 7, 0, 1, 'expoOut')

            --opponent

            setPropertyFromGroup("opponentStrums", 0, "x", 62)
            setPropertyFromGroup("opponentStrums", 1, "x", 174)
            setPropertyFromGroup("opponentStrums", 2, "x", 286)
            setPropertyFromGroup("opponentStrums", 3, "x", 398)

            setPropertyFromGroup("opponentStrums", 0, "angle", -20)
            setPropertyFromGroup("opponentStrums", 1, "angle", -20)
            setPropertyFromGroup("opponentStrums", 2, "angle", -20)
            setPropertyFromGroup("opponentStrums", 3, "angle", -20)
            
            noteTweenX('opponent left', 0, 92, 1, 'expoOut')
            noteTweenX('opponent down', 1, 204, 1, 'expoOut')
            noteTweenX('opponent up', 2, 316, 1, 'expoOut')
            noteTweenX('opponent right', 3, 428, 1, 'expoOut')

            noteTweenAngle('opponent left', 0, 0, 1, 'expoOut')
            noteTweenAngle('opponent down', 1, 0, 1, 'expoOut')
            noteTweenAngle('opponent up', 2, 0, 1, 'expoOut')
            noteTweenAngle('opponent right', 3, 0, 1, 'expoOut')
            
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
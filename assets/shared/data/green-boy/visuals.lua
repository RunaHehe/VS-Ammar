iconJump = false
defaultIconY = 0
defaultHudAngle = 0

function onCreatePost()
    defaultIconY = getProperty('iconP2.y')
    defaultHudAngle = getProperty('camHUD.angle')
end

function onStepHit()
    if iconJump then
        if curStep % 4 == 0 then
            doTweenY('iconJump', 'iconP2', defaultIconY - 30, crochet/1000/2, 'quadOut')
        elseif curStep % 4 == 2 then
            doTweenY('iconJump', 'iconP2', defaultIconY, crochet/1000/2, 'quadIn')
        end
    end
    if curStep == 384 then
        setProperty('camHUD.angle', defaultHudAngle)
    end

    if curStep == 60 then
        iconJump = true
    end
    if curStep == 640 then
        iconJump = false
    end
end

function onUpdate(elapsed)
    if not inGameOver then
        if curStep >= 256 and curStep < 384 then
            setProperty('camHUD.angle', continuous_sin(curDecBeat/8) * 5)
        end
    end
end

function continuous_sin(x) return math.sin((x % 1) * 2 * math.pi) end
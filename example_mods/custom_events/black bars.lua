local strumLineY = 0
function onCreatePost()
    strumLineY = getPropertyFromGroup('strumLineNotes',0,'y')
    makeLuaSprite('topBar', nil, -100, -720)
    setObjectCamera('topBar', 'hud')
    makeGraphic('topBar', 1600, 720, '000000')
    --screenCenter('topBar')
    setProperty("topBar.y",-720)
    addLuaSprite('topBar',false)

    makeLuaSprite('bottomBar', nil, -100, 720)
    makeGraphic('bottomBar', 1600, 720, '000000')
    setObjectCamera('bottomBar', 'hud')
    addLuaSprite('bottomBar',false)
end
function onEvent(name, value1, value2)
    if string.lower(name) == "black bars" then
        local height = tonumber(value1)
        if height == nil then
            if value1 == '' then
                height = 115
            elseif value1 == '0' then
                height = 0
            end
        end
        doTweenY('topBarTween', 'topBar', height-720, 0.5,'linear')
        doTweenY('bottomBarTween', 'bottomBar', 720-height, 0.5,'linear')
        if value2 == '2' then
            --setProperty('topBar.visible', false)
            --setProperty('bottomBar.visible', false)
        elseif value2 == '1' then
            for i=0,7 do
                local pos = 0
                if downscroll then
                    --112 = note width
                    pos = 720-height-112
                    if pos >= strumLineY-56 then
                        pos = strumLineY-56
                    end
                else
                    pos = height
                    if pos <= strumLineY-56 then
                        pos = strumLineY-56
                    end

                end
                noteTweenY('barYNote'..i, i, pos, 0.5,'linear')
                noteTweenAngle('barAngleNote'..i, i, 360, 0.5,'linear')
            end
        end
    end
end
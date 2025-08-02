local zooming = false
function onEvent(name,v1,v2)
    if name == 'Set Camera Zoom' then
        cancelTween('Vzoom')
        zooming = false
        local duration = tonumber(v2)
        if duration == nil then
            if v2 == '0' then
                setProperty('camGame.zoom',v1)
            end
        else
            duration = stepCrochet * 0.015 * duration
            doTweenZoom('Vzoom','camGame',v1,duration - 0.1,'sineOut')
            runTimer('Vzoom',duration - 0.1)
            zooming = true
        end
        setProperty('defaultCamZoom',v1)
    elseif name == 'Add Camera Zoom' and zooming then
        local zoom = v1
        if zoom == '' then
            zoom = '0.015'
        end
        setProperty('camGame.zoom',getProperty('camGame.zoom')-zoom)
    end
end
function onTimerCompleted(tag)
    if tag == 'Vzoom' then
        zooming = false
        setProperty('defaultCamZoom',getProperty('camGame.zoom'))
    end
end
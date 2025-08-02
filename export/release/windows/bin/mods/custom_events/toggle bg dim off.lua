function onEvent(name, v1, v2)
    if string.lower(name) == "toggle bg dim off" then
        doTweenAlpha("bgdimalpha",'bgdim', 0, 0.5, 'linear')
    end
end
function onTweenCompleted(tag)
    if tag == 'bgdimalpha' then
        removeLuaSprite('bgdim',true)
    end
end
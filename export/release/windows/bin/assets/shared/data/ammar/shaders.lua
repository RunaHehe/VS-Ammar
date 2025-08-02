function onCreatePost()
    initLuaShader("ColorsEdit")
    makeLuaSprite("colorsHehe")
    makeGraphic("colorsHehe", 1, 1)
    setSpriteShader("colorsHehe", "ColorsEdit")
    addLuaSprite("colorsHehe", false)

    addHaxeLibrary("ShaderFilter", "openfl.filters")
    runHaxeCode([[
        var shader = game.getLuaObject("colorsHehe").shader;
        game.camGame.setFilters([new ShaderFilter(shader)]);
        game.camHUD.setFilters([new ShaderFilter(shader)]);
    ]])

    makeLuaSprite("saturationControl", nil, 0.2, 0.2)
    makeGraphic("saturationControl", 0.2, 0.2, 'FFFFFF')
    addLuaSprite("saturationControl", false)

    makeLuaSprite("brightnessControl", nil, 0.2, 0.2)
    makeGraphic("brightnessControl", 0.2, 0.2, 'FFFFFF')
    addLuaSprite("brightnessControl", false)

    makeLuaSprite("contrastControl", nil, 0.2, 0.2)
    makeGraphic("contrastControl", 0.2, 0.2, 'FFFFFF')
    addLuaSprite("contrastControl", false)

    setProperty("saturationControl.x", 0)
    setProperty("brightnessControl.x", 0.5)
    setProperty("contrastControl.x", 3)
end

function onSongStart()
    doTweenX("satur", "saturationControl", 1, 18, 'sineInOut')
    doTweenX("bright", "brightnessControl", 1, 18, 'sineInOut')
    doTweenX("contrast", "contrastControl", 1, 18, 'sineInOut')
end

function onBeatHit()
    if curBeat == 192 then
        setProperty("saturationControl.x", 1.2)
        setProperty("brightnessControl.x", 1.1)
        setProperty("contrastControl.x", 1.3)
    end
end

function onUpdate(elapsed)
    local contrastC = getProperty("contrastControl.x")
    local brightnessC = getProperty("brightnessControl.x")
    local saturationC = getProperty("saturationControl.x")
    setShaderFloat("colorsHehe", "saturation", saturationC)
    setShaderFloat("colorsHehe", "brightness", brightnessC)
    setShaderFloat("colorsHehe", "contrast", contrastC)
end
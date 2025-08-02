local doBrightnessWave = false
local bSpeed = 0
local bRange = 0
local brightness = 0
function onCreate()
    callShader('createShader',{'colorSwapEvent','ColorSwapEffect'})
    callShader('runShader',{'camGame','colorSwapEvent'})
end
function callShader(func,vars)
    callScript('scripts/shader',func,vars)
end
function colorTween(var,value,time,easing)
    callShader('tweenShaderValue',{'colorSwapEvent',var,value,time,easing})
end
function onEvent(name,v1,v2)
    if string.lower(name) == "brightness sine" then
        doBrightnessWave = not doBrightnessWave
        bSpeed = tonumber(v1)
        bRange = tonumber(v2)
        if not doBrightnessWave then
            shaderVar('colorSwapEvent', 'brightness', brightness)
        end
    end
    if string.lower(name) == "set brightness" then
        brightness = tonumber(v1)
        shaderVar('bloom', 'brightness', brightness)
    end
    if string.lower(name) == "set contrast" then
        shaderVar('bloom', 'contrast', tonumber(v1))
    end
end
function onUpdate(elapsed)
	if doBrightnessWave then
		setShaderFloat('colorSwapEvent', 'contrast', brightness + math.sin((getSongPosition() * 0.001)*(bpm/60)*bSpeed)*bRange)
	end
end
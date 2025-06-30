--Thanks leather for helping me write these
local rotCam = false
local rotCamSpd = 0
local rotCamRange = 0

local rotCamInd = 0

function onEvent(name, value1, value2)
    if name == "camera rotate on" then
        rotCam = true

        rotCamSpd = tonumber(value1)
		rotCamRange = tonumber(value2)
    end
end

function onUpdate(elapsed)
    if rotCam then
        rotCamInd = rotCamInd + (elapsed / (1 / 120))
        setProperty("camGame", "angle", math.sin(rotCamInd / 100 * rotCamSpd) * rotCamRange)
    else
        rotCamInd = 0
    end
end
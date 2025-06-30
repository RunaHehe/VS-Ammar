local ogZoom
function onUpdate()
	ogZoom = getProperty('camGame.zoom')
end

function onEvent(name,value1,value2)
    if name == "Additive Zoom" then     
        if value2 == '' then
      	  	setProperty("defaultCamZoom", ogZoom + value1)
			debugPrint(value2)
		else
            doTweenZoom('camz', 'camGame', tonumber(ogZoom + value1), tonumber(value2), 'sineOut')
		end           
    end
end

function onTweenCompleted(name)
	if name == 'camz' then
		setProperty("defaultCamZoom", getProperty('camGame.zoom')) 
	end
end
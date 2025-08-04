local defaultStageZoom = 0;
local defaultHUDCameraZoom = 0;

local cameraBopIntensity = 1.015;
local hudCameraZoomIntensity = 0.015 * 2.0;
local cameraZoomRate = 4;

local cameraBopMultiplier = 0;

local tweenCameraZoomName = 'Tween Camera Zoom';
local changeCameraBopName = 'Change Camera Bop';
local mustHitCameraName = 'Must Hit Camera';

function onCreatePost()
	defaultStageZoom = getProperty('defaultCamZoom');
	defaultHUDCameraZoom = (getPropertyFromClass('flixel.FlxCamera', 'defaultZoom') * 1.0);

	setProperty('isCameraOnForcedPos', true);

	-- psych online has the same names, so im just gonna do this
	if getPropertyFromClass('Main', 'PSYCH_ONLINE_VERSION') ~= nil then
		for i=0, getProperty('eventNotes.length') - 1 do
			if getProperty('eventNotes['..i..'].event') == tweenCameraZoomName then
				setProperty('eventNotes['..i..'].event', tweenCameraZoomName..' but cooler');
			end

			if getProperty('eventNotes['..i..'].event') == changeCameraBopName then
				setProperty('eventNotes['..i..'].event', changeCameraBopName..' but cooler');
			end

			if getProperty('eventNotes['..i..'].event') == mustHitCameraName then
				setProperty('eventNotes['..i..'].event', mustHitCameraName..' but cooler');
			end
		end

		tweenCameraZoomName = tweenCameraZoomName..' but cooler';
		changeCameraBopName = changeCameraBopName..' but cooler';
		mustHitCameraName = mustHitCameraName..' but cooler';
	end
end

function onEvent(event, value1, value2, strumTime)
	if event == tweenCameraZoomName then
		local value1madness = stringSplit(value1, ',');
		local camZoom = tonumber(value1madness[1]);
		--debugPrint(camZoom);
		local duration = tonumber(value1madness[2]);
		--debugPrint(duration);

		local value2madness = stringSplit(value2, ',');
		local camEase = value2madness[1];
		--debugPrint(camEase);
		local mode = value2madness[2];
		--debugPrint(mode);

		duration = duration * (stepCrochet / 1000);
		--debugPrint(duration);

		local camZoomMultiplier = camZoom * (mode == 'direct' and getPropertyFromClass('flixel.FlxCamera', 'defaultZoom') or defaultStageZoom);
		--debugPrint(camZoomMultiplier);

		if camEase == 'INSTANT' then
			setProperty('defaultCamZoom', camZoom);
			return;
		end

		startTween('tweenCamZoom', 'this', {defaultCamZoom = camZoomMultiplier}, duration, {ease = camEase, onUpdate = 'onTweenCamZoomUpdate'});
	elseif event == changeCameraBopName then
		local rate = tonumber(value1);
		local intensity = tonumber(value2);

		cameraBopIntensity = 0.015 * intensity + 1.0;
		hudCameraZoomIntensity = 0.015 * intensity * 2.0;
		cameraZoomRate = rate;
	elseif event == mustHitCameraName then
		local charPos = getCharPos(value1)
		local value2Madness = stringSplit(value2, ',')

		local durationRaw = value2Madness[1]
		local twnEaseRaw = value2Madness[2]
		local xOffsetRaw = value2Madness[3]
		local yOffsetRaw = value2Madness[4]

		local duration = (durationRaw ~= 'null') and tonumber(durationRaw) or 4
		local twnEase = (twnEaseRaw ~= 'null') and twnEaseRaw or 'CLASSIC'
		local xOffset = (xOffsetRaw ~= 'null') and tonumber(xOffsetRaw) or 0
		local yOffset = (yOffsetRaw ~= 'null') and tonumber(yOffsetRaw) or 0

		charPos[1] = charPos[1] + xOffset
		charPos[2] = charPos[2] + yOffset

		duration = duration * (stepCrochet / 1000)

		if twnEase == 'CLASSIC' then
			setProperty('camFollow.x', charPos[1])
			setProperty('camFollow.y', charPos[2])
		elseif twnEase == 'INSTANT' then
			setProperty('camFollow.x', charPos[1])
			setProperty('camFollow.y', charPos[2])
			callMethod('camGame.snapToTarget', {'yeah'})
			cameraTweenUpdate(nil, nil)
		else
			startTween('mustHitCameraTween', 'camFollow', {
				x = charPos[1],
				y = charPos[2]
			}, duration, {
				ease = twnEase,
				onUpdate = 'cameraTweenUpdate'
			})
		end
	end
end

function opponentNoteHit(index, noteData, noteType, isSustain)
	setProperty('camZooming', false);
end

function onBeatHit()
	if getPropertyFromClass('backend.ClientPrefs', 'data.camZooms')
		and getProperty('camGame.zoom') < (1.35 * getPropertyFromClass('flixel.FlxCamera', 'defaultZoom'))
		and cameraZoomRate > 0
		and curBeat % cameraZoomRate == 0
	then
		-- Set zoom multiplier for camera bop.
		cameraBopMultiplier = cameraBopIntensity;
		-- HUD camera zoom still uses old system. To change. (+3%)
		setProperty('camHUD.zoom', getProperty('camHUD.zoom') + (hudCameraZoomIntensity * defaultHUDCameraZoom));
	end
end

function onUpdate(elapsed)
	if cameraZoomRate > 0 then
		cameraBopMultiplier = lerp(1.0, cameraBopMultiplier, 0.95); -- Lerp bop multiplier back to 1.0x
		local zoomPlusBop = getProperty('defaultCamZoom') * cameraBopMultiplier; -- Apply camera bop multiplier.
		setProperty('camGame.zoom', zoomPlusBop); -- Actually apply the zoom to the camera.
		setProperty('camHUD.zoom', lerp(defaultHUDCameraZoom, getProperty('camHUD.zoom'), 0.95));
	end
end

function onGameOverStart()
	close();
end

function cameraTweenUpdate(tag, obj)
	-- force camera position
	callMethod('camGame.snapToTarget', {'yeah'});
	--debugPrint(getProperty('camFollow.x'));
	--debugPrint(getProperty('camFollow.y'));
end

-- stolen from my tabi revival port sorry not sorry!
function getCharPos(camCharacter)
	local charCamPosition = {0, 0};
	if camCharacter == 'dad' then
		charCamPosition = {getMidpointX('dad') + 150, getMidpointY('dad') - 100};
		charCamPosition[1] = charCamPosition[1] + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]');
		charCamPosition[2] = charCamPosition[2] + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]');
	elseif camCharacter == 'bf' then
		charCamPosition = {getMidpointX('boyfriend') - 100, getMidpointY('boyfriend') - 100};
		charCamPosition[1] = charCamPosition[1] - getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]');
		charCamPosition[2] = charCamPosition[2] + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]');
	elseif camCharacter == 'gf' then
		charCamPosition = {getMidpointX('gf'), getMidpointY('gf')};
		charCamPosition[1] = charCamPosition[1] + getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]');
		charCamPosition[2] = charCamPosition[2] + getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]');
	end

	return charCamPosition;
end

function lerp(a, b, ratio)
	return a + ratio * (b - a);
end
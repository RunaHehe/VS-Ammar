local precachedStages = {}
local precacheStages = true

function onCreate()--precache Stages
	if precacheStages then
		for events = 0,getProperty('eventNotes.length')-1 do
			if getPropertyFromGroup('eventNotes',events,'event') == 'Change Stage' and getPropertyFromGroup('eventNotes',events,'value1') ~= curStage then
				addStageScript(getPropertyFromGroup('eventNotes',events,'value1'))
			end
		end
		reloadStage()
	end
end

function onCreatePost()
	if precacheStages then
		precachedStages = getProperty('stageLuas')
		for i, lua in pairs(precachedStages) do
			setProperty(lua..'.alpha',0.01)
		end
		
		addStageScript(curStage)
	end
end

function addStageScript(stage)
	if not isRunning('stages/'..stage) then
    	addLuaScript('stages/'..stage)
	else
		callScript('stages/'..stage,'onCreate')
	end
end

function reloadStage()
	callScript('scripts/global_functions','updateStage',{true})
end

function deleteStage(delete)
	local stageSprites = getProperty('stageLuas')--stageLuas as from "global_functions" script
	for i, lua in pairs(stageSprites) do
		removeLuaSprite(lua,delete)
	end
end

function removeStage(stage,deleteLua)
	removeLuaScript('stages/'..stage)
	
	if deleteLua ~= false then
		deleteStage(true)
	end
	
end

function onEvent(name, value1, value2)
	if name == 'Change Stage' then
		if checkFileExists('stages/'..value1.. '.json') then
			local normalstage = {
				directory = "",
				defaultZoom = 0.9,
				isPixelStage = false,
				boyfriend = {770, 100},
				girlfriend = {400, 130},
				opponent = {100, 100},
				hide_girlfriend = false,
				camera_boyfriend = {0, 0},
				camera_opponent = {0, 0},
				camera_girlfriend = {0, 0},
				camera_speed = 1.0
			}
			local jsonFile = parseJson(getTextFromFile('stages/'..value1..'.json'))
			for i, json in pairs(jsonFile) do
				if json ~= nil then
					normalstage[i] = json
				end
			end
			cancelTween('Vzoom')
			
			if checkFileExists('stages/' .. curStage .. '.lua') then
                removeStage(curStage)
			end
			if checkFileExists('stages/'..value1..'.lua') then
				addStageScript(value1)
			end
			setOnLuas('curStage', value1)

			
			--[[local function checkIfNull(variable, ifNull)
				if variable == nil then
					return ifNull
				else
					return variable
				end
			end]]--

			setProperty('defaultCamZoom', normalstage.defaultZoom)
			setProperty('camGame.zoom', normalstage.defaultZoom)
			setProperty('cameraSpeed', normalstage.camera_speed)
			--setPropertyFromClass('PlayState', 'isPixelStage', jsonFile.isPixelStage, false)
			setProperty('dadGroup.x',normalstage.opponent[1])
            setProperty('dadGroup.y',normalstage.opponent[2])
            setProperty('boyfriendGroup.x',normalstage.boyfriend[1])
            setProperty('boyfriendGroup.y',normalstage.boyfriend[2])
			--[[setProperty('dad.x',checkIfNull(jsonFile.opponent[1],0) + getProperty('dad.positionArray[0]'))
            setProperty('dad.y',checkIfNull(jsonFile.opponent[2],0) + getProperty('dad.positionArray[1]'))
            setProperty('boyfriend.x',checkIfNull(jsonFile.boyfriend[1],0) + getProperty('boyfriend.positionArray[0]'))
            setProperty('boyfriend.y',checkIfNull(jsonFile.boyfriend[2],0) + getProperty('boyfriend.positionArray[1]'))]]--
			setProperty('boyfriendCameraOffset[0]',normalstage.camera_boyfriend[1])
			setProperty('boyfriendCameraOffset[1]',normalstage.camera_boyfriend[2])
			setProperty('opponentCameraOffset[0]',normalstage.camera_opponent[1])
			setProperty('opponentCameraOffset[1]',normalstage.camera_opponent[2])
			setProperty('girlfriendCameraOffset[0]',normalstage.camera_girlfriend[1])
			setProperty('girlfriendCameraOffset[1]',normalstage.camera_girlfriend[2])
			reloadStage()
            --[[
            setOnLuas('defaultOpponentX', stageOffsets.x + jsonFile.opponent[1])
			setOnLuas('defaultOpponentY', stageOffsets.y + jsonFile.opponent[2])
			setOnLuas('defaultGirlfriendX', stageOffsets.x + jsonFile.girlfriend[1])
			setOnLuas('defaultGirlfriendY', stageOffsets.y + jsonFile.girlfriend[2])
			setOnLuas('defaultBoyfriendX', stageOffsets.x + jsonFile.boyfriend[1])
			setOnLuas('defaultBoyfriendY', stageOffsets.y + jsonFile.boyfriend[2])
            ]
            

 
			setProperty('opponentCameraOffset[0]', checkIfNull(jsonFile.camera_opponent[1], 0))
			setProperty('opponentCameraOffset[1]', checkIfNull(jsonFile.camera_opponent[2], 0))
			setProperty('boyfriendCameraOffset[0]', checkIfNull(jsonFile.camera_boyfriend[1], 0))
			setProperty('boyfriendCameraOffset[1]', checkIfNull(jsonFile.camera_boyfriend[2], 0))
            setProperty('gfGroup.x',checkIfNull(jsonFile.girlfriend[1]),0)
            setProperty('gfGroup.y',checkIfNull(jsonFile.girlfriend[2]),0)
            setProperty('girlfriendCameraOffset[0]', checkIfNull(jsonFile.camera_girlfriend[1], 0))
			setProperty('girlfriendCameraOffset[1]', checkIfNull(jsonFile.camera_girlfriend[2], 0))
			]]--
		end
	end
end
function setOnLuas(varName, valueInput)
	if type(valueInput) == 'string' then
		valueInput = '"'..valueInput..'"'
	end
	runHaxeCode(
		[[
			game.setOnLuas("]]..varName..[[",]]..valueInput..[[);
		]]
	)
end


local function skip_delim(str, pos, delim, err_if_missing)
	pos = pos + #str:match('^%s*', pos)
	if str:sub(pos, pos) ~= delim then
		if err_if_missing then
			error('Expected ' .. delim .. ' near position ' .. pos)
		end
		return pos, false
	end
	return pos + 1, true
end

local function parse_str_val(str, pos, val)
	val = val or ''
	local early_end_error = 'End of input found while parsing string.'
	if pos > #str then error(early_end_error) end
	local c = str:sub(pos, pos)
	if c == '"'	then return val, pos + 1 end
	if c ~= '\\' then return parse_str_val(str, pos + 1, val .. c) end
	-- We must have a \ character.
	local esc_map = {b = '\b', f = '\f', n = '\n', r = '\r', t = '\t'}
	local nextc = str:sub(pos + 1, pos + 1)
	if not nextc then error(early_end_error) end
	return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local function parse_num_val(str, pos)
	local num_str = str:match('^-?%d+%.?%d*[eE]?[+-]?%d*', pos)
	local val = tonumber(num_str)
	if not val then error('Error parsing number at position ' .. pos .. '.') end
	return val, pos + #num_str
end


function parseJson(str, pos, end_delim)
	pos = pos or 1
	if pos > #str then error('Reached unexpected end of input.') end
	local pos = pos + #str:match('^%s*', pos)	-- Skip whitespace.
	local first = str:sub(pos, pos)
	if first == '{' then	-- Parse an object.
		local obj, key, delim_found = {}, true, true
		pos = pos + 1
		while true do
			key, pos = parseJson(str, pos, '}')
			if key == nil then return obj, pos end
			if not delim_found then error('Comma missing between object items.') end
			pos = skip_delim(str, pos, ':', true)	-- true -> error if missing.
			obj[key], pos = parseJson(str, pos)
			pos, delim_found = skip_delim(str, pos, ',')
		end
	elseif first == '[' then	-- Parse an array.
		local arr, val, delim_found = {}, true, true
		pos = pos + 1
		while true do
			val, pos = parseJson(str, pos, ']')
			if val == nil then return arr, pos end
			if not delim_found then error('Comma missing between array items.') end
			arr[#arr + 1] = val
			pos, delim_found = skip_delim(str, pos, ',')
		end
	elseif first == '"' then	-- Parse a string.
		return parse_str_val(str, pos + 1)
	elseif first == '-' or first:match('%d') then	-- Parse a number.
		return parse_num_val(str, pos)
	elseif first == end_delim then	-- End of an object or array.
		return nil, pos + 1
	else	-- Parse true, false, or null.
		local jnull = {}	-- This is a one-off table to represent the null value.
		local literals = {['true'] = true, ['false'] = false, ['null'] = jnull}
		for lit_str, lit_val in pairs(literals) do
			local lit_end = pos + #lit_str - 1
			if str:sub(pos, lit_end) == lit_str then return lit_val, lit_end + 1 end
		end
		local pos_info_str = 'position ' .. pos .. ': ' .. str:sub(pos, pos + 10)
		error('Invalid json syntax starting at ' .. pos_info_str)
	end
end
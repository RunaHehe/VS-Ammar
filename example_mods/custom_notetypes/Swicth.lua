--Creator
--Idea by MoonScarf
--Created by Kevin Kuntz
--Modified By ThisisVerdi
function onCreatePost()
	for i = 0, getProperty('unspawnNotes.length') - 1 do
		sus = getPropertyFromGroup('unspawnNotes', i, 'isSustainNote')
		mustPress = getPropertyFromGroup('unspawnNotes', i, 'mustPress')
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Swicth' then
			if not sus then
				oFX = getPropertyFromGroup('unspawnNotes', i, 'offsetX')
			else
				susFX = getPropertyFromGroup('unspawnNotes', i, 'offsetX')
			end
			if mustPress then
				setPropertyFromGroup('unspawnNotes', i, 'offsetX', getPropertyFromGroup('unspawnNotes', i, 'offsetX') - 60)
			else
				setPropertyFromGroup('unspawnNotes', i, 'offsetX', getPropertyFromGroup('unspawnNotes', i, 'offsetX') + 940)
			end
        end
    end
end

function onUpdatePost(el)
    songPos = getSongPosition()
	local currentBeat = (getSongPosition() / 1000)*(bpm/60)
    for a = 0, getProperty('notes.length') - 1 do
        strumTime = getPropertyFromGroup('notes', a, 'strumTime')
		sus = getPropertyFromGroup('notes', a, 'isSustainNote')
        if getPropertyFromGroup('notes', a, 'noteType') == 'Swicth' then
			if sus then
				setPropertyFromGroup('notes', a, 'offsetX', getPropertyFromGroup('notes', a, 'offsetX') + 3 * math.cos((currentBeat + a * 0.15) * math.pi))
			end
			if (strumTime - songPos) < 1100 / scrollSpeed and not sus then
				if getPropertyFromGroup('notes', a, 'offsetX') ~= oFX then
					setPropertyFromGroup('notes', a, 'offsetX', lerp(getPropertyFromGroup('notes', a, 'offsetX'), oFX, boundTo(el * 0.6, 0, 1)))  
				elseif getPropertyFromGroup('notes', a, 'offsetX') <= oFX then
					setPropertyFromGroup('notes', a, 'offsetX', oFX)
				end
			elseif (strumTime - songPos) < 1200 / scrollSpeed and sus then
				if getPropertyFromGroup('notes', a, 'offsetX') ~= susFX then
					setPropertyFromGroup('notes', a, 'offsetX', lerp(getPropertyFromGroup('notes', a, 'offsetX'), susFX, boundTo(el * 0.6, 0, 1) * math.cos))
				elseif getPropertyFromGroup('notes', a, 'offsetX') <= susFX then
					setPropertyFromGroup('notes', a, 'offsetX', susFX)
				end
			end
        end
    end
end

function lerp(a, b, ratio)
  return math.floor(a + ratio * (b - a))
end

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end
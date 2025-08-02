function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'osu' and getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') == false then 
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'outlineNOTE_assets');
		end
	end
end

function onUpdatePost(elapsed)
	for i = 0, getProperty('notes.length')-1 do
		if getPropertyFromGroup('notes', i, 'noteType') == 'osu' and getPropertyFromGroup('notes', i, 'isSustainNote') == false then 
			noteData = getPropertyFromGroup('notes', i, 'noteData')

			if getPropertyFromGroup('notes', i, 'mustPress') then
				strumNoteX = getPropertyFromGroup('playerStrums', noteData, 'x') --Getting strum positions so it can support modcharts without looking weird
				strumNoteY = getPropertyFromGroup('playerStrums', noteData, 'y')
			else 
				strumNoteX = getPropertyFromGroup('opponentStrums', noteData, 'x') --Getting strum positions so it can support modcharts without looking weird
				strumNoteY = getPropertyFromGroup('opponentStrums', noteData, 'y')
			end
			
			setPropertyFromGroup('notes', i, 'x', strumNoteX)
			setPropertyFromGroup('notes', i, 'y', strumNoteY)

			setPropertyFromGroup('notes', i, 'alpha', 1.5  - (getPropertyFromGroup('notes', i, 'strumTime') - getSongPosition()) * getProperty('songSpeed') / 1000)
			setPropertyFromGroup('notes', i, 'scale.x', 0.7  + (getPropertyFromGroup('notes', i, 'strumTime') - getSongPosition()) * getProperty('songSpeed') / 1000)
			setPropertyFromGroup('notes', i, 'scale.y', 0.7  + (getPropertyFromGroup('notes', i, 'strumTime') - getSongPosition()) * getProperty('songSpeed') / 1000)
		end
	end
end
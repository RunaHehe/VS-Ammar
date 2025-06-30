-- Toggle Trail.lua (0.6.3 Compatible)
-- Converted from "Trail.lua" to match the Toggle Trail activation style

local trailEnabled = false
local chars = {}
local ghostNum = 0
local funniDis = 75

function onEvent(name, value1, value2)
	if name == "Toggle Trail Fixed" then
		trailEnabled = (value1 == '1')
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if trailEnabled then
		chars['boyfriend'] = direction
		makeSmth('boyfriend', direction, 1)
	end
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
	if trailEnabled then
		chars['boyfriend'] = noteData
		makeSmth('boyfriend', noteData, 1)
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if trailEnabled then
		if getPropertyFromGroup('notes', id, 'gfNote') then
			chars['gf'] = direction
			makeSmth('gf', direction, 1)
		else
			chars['dad'] = direction
			makeSmth('dad', direction, 1)
		end
	end
end

function onStepHit()
	if trailEnabled then
		for ea, ae in pairs(chars) do
			makeSmth(ea, ae, 0.25)
		end
	end
end

function makeSmth(char, noteDir, alphaMul)
	if not string.match(getProperty(char..'.animation.curAnim.name'), 'sing') then
		noteDir = -1
	end
	for i = 1, 2 do
		ghostTrail(char, {
			getProperty(char..'.animation.frameName'),
			getProperty(char..'.offset.x'),
			getProperty(char..'.offset.y'),
		noteDir,
			getProperty(char..'.animation.curFrame')
		}, alphaMul)
		noteDir = -1
	end
end

function ghostTrail(char, noteData, alph)
	local ghost = char..'Ghost'..ghostNum
	local group = (char == 'mom') and 'dad' or char

	makeAnimatedLuaSprite(ghost, getProperty(char..'.imageFile'), getProperty(char..'.x'), getProperty(char..'.y'))
	addAnimationByPrefix(ghost, 'idle', noteData[1], 0, false)
	setProperty(ghost..'.antialiasing', getProperty(char..'.antialiasing'))
	setProperty(ghost..'.offset.x', noteData[2])
	setProperty(ghost..'.offset.y', noteData[3])
	setProperty(ghost..'.scale.x', getProperty(char..'.scale.x'))
	setProperty(ghost..'.scale.y', getProperty(char..'.scale.y'))
	setProperty(ghost..'.flipX', getProperty(char..'.flipX'))
	setProperty(ghost..'.flipY', getProperty(char..'.flipY'))
	setProperty(ghost..'.visible', getProperty(char..'.visible'))
	setProperty(ghost..'.alpha', 0.75 * getProperty(char..'.alpha') * alph)
	setBlendMode(ghost, 'add')
	addLuaSprite(ghost)
	playAnim(ghost, 'idle', true, false, noteData[5])
	setObjectOrder(ghost, getObjectOrder(group..'Group') - 0.1)
	cancelTween(ghost)
	doTweenAlpha(ghost, ghost, 0, crochet * 0.001, 'linear')

	if noteData[4] == 0 then
		doTweenX(ghostNum..'', ghost, getProperty(char..'.x') - funniDis, crochet * 0.001, 'sineout')
	elseif noteData[4] == 1 then
		doTweenY(ghostNum..'', ghost, getProperty(char..'.y') + funniDis, crochet * 0.001, 'sineout')
	elseif noteData[4] == 2 then
		doTweenY(ghostNum..'', ghost, getProperty(char..'.y') - funniDis, crochet * 0.001, 'sineout')
	elseif noteData[4] == 3 then
		doTweenX(ghostNum..'', ghost, getProperty(char..'.x') + funniDis, crochet * 0.001, 'sineout')
	end

	ghostNum = ghostNum + 1
end

function onTweenCompleted(tag)
	if string.match(tag, 'Ghost') then
		removeLuaSprite(tag, true)
	end
end

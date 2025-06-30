local playerTrail = false
local opponentTrail = false

function onEvent(name, value1, value2)
    if name == "FlameTrail" then
        playerTrail = (value1 == '1')
        opponentTrail = (value2 == '1')
    end
end

function getIconColor(chr)
    return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end

function rgbToHex(array)
    return string.format('%.2x%.2x%.2x', math.min(array[1]+50,255), math.min(array[2]+50,255), math.min(array[3]+50,255))
end

function makeTrail(ea, alph)
    ghostTrail(ea, {getProperty(ea..'.animation.frameName'), getProperty(ea..'.offset.x'), getProperty(ea..'.offset.y'), 2, getProperty(ea..'.animation.curFrame')}, alph)
end

function onUpdate()
    if playerTrail then
        makeTrail('boyfriend', 0.25)
    end
    if opponentTrail then
        makeTrail('dad', 0.25)
    end
end

local ghostNum = 0
local funniDis = 50
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
    setProperty(ghost..'.alpha', 0.175 * getProperty(char..'.alpha') * alph)
    setBlendMode(ghost, 'add')
    addLuaSprite(ghost)
    playAnim(ghost, 'idle', true, false, noteData[5])
    setObjectOrder(ghost, getObjectOrder(group..'Group') - 0.1)
    cancelTween(ghost)
    doTweenAlpha(ghost, ghost, 0, crochet*0.001, 'linear')
    doTweenY(ghostNum..'', ghost, getProperty(char..'.y') - funniDis, crochet*0.001, 'sineout')

    ghostNum = ghostNum + 1
end

function onTweenCompleted(tag)
    if string.match(tag, 'Ghost') then
        removeLuaSprite(tag, true)
    end
end

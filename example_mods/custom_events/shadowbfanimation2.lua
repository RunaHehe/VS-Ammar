local shadowEffectActive = 0

function onEvent(name, value1, value2)
    if name == 'shadowbfanimation2' then
        shadowEffectActive = tonumber(value1) or 0
    end
end

function onUpdate(elapsed)
    if shadowEffectActive == 1 then
        if getProperty('boyfriend.alpha') > 0.99 then
            local animName = getProperty('boyfriend.animation.curAnim.name')
            
            -- Trigger shadow creation based on all animations including '-alt2'
            if animName == 'singLEFT' or animName == 'singRIGHT' or animName == 'singUP' or animName == 'singDOWN' or 
               animName == 'singLEFT-alt' or animName == 'singRIGHT-alt' or animName == 'singUP-alt' or animName == 'singDOWN-alt' or
               animName == 'singLEFT-alt2' or animName == 'singRIGHT-alt2' or animName == 'singUP-alt2' or animName == 'singDOWN-alt2' then
                createShadow('boyfriend')
            end
        end
    else
        -- Remove shadow effect when deactivated
        removeLuaSprite('boyfriendShadow', false)
    end
end

-- Function to create shadow effect for specified character
function createShadow(character)
    -- Avoid duplicate shadows
    if not getProperty(character .. 'Shadow') then
        local shadow = makeLuaSprite(character .. 'Shadow', getProperty(character .. '.imageFile'), getProperty(character .. '.x'), getProperty(character .. '.y'))
        setProperty(shadow .. '.alpha', 0.5)  -- Semi-transparent shadow effect
        setObjectOrder(shadow, getObjectOrder(character) - 1)
        addLuaSprite(shadow, false)
    end
    
    -- Sync shadow animation with the character's animation
    setProperty(character .. 'Shadow.animation.curAnim.name', getProperty(character .. '.animation.curAnim.name'))
end


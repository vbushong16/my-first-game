--[[
    Snowstorm 2024
    Super skier

    Super skier-1
    "The Low-Res Update"

    -- Main Program --

    Author: Victor Bushong
    vbsaxo@gmail.com

    This Game is to start applying learnings from the GD50 class
    and design my very own downhill ski game
]]

-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--

require 'src/Dependencies'

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]


local scrolling = true

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('SnowStorm')


    love.graphics.setFont(gFonts['smallFont'])
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    gStateMachine = StateMachine{
        ['title'] = function() return TitleScreenState() end,
        ['play'] =  function() return PlayState() end,
        ['score'] =  function() return ScoreState() end,
        ['countdown'] =  function() return CountdownState() end,
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
    
end

function love.resize(w, h)
    push:resize(w, h)
end

--[[
    Keyboard handling, called by LÖVE2D each frame; 
    passes in the key we pressed so we can access.
]]
function love.keypressed(key)
    -- keys can be accessed by string name
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        -- function LÖVE gives us to terminate application
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end
    

function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end


--[[
    Called after update by LÖVE2D, used to draw anything to the screen, 
    updated or otherwise.
]]
function love.draw()
    -- begin rendering at virtual resolution
    push:start()    


    gStateMachine:render()

    -- end rendering at virtual resolution
    push:finish()
end

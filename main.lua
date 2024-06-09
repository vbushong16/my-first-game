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
-- https://github.com/Ulydev/push
push = require 'push'
Class = require 'class'

require 'Skier'
require 'Flag'
require 'FlagPair'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'
require 'states/CountdownState'

WINDOW_WIDTH = 400
WINDOW_HEIGHT = 610

VIRTUAL_WIDTH = 380
VIRTUAL_HEIGHT = 580
--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]

ground = love.graphics.newImage('ground 4.png')

local scrolling = true

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('SnowStorm')

    smallFont = love.graphics.newFont('font.ttf',8)
    largeFont = love.graphics.newFont('SEASRN__.ttf',24)
    hugeFont = love.graphics.newFont('font.ttf',48)

    sounds = {
--    ['jump'] = love.audio.newSource('jump.wav', 'static'),
--    ['explosion'] = love.audio.newSource('explosion.wav', 'static'),
--    ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
--    ['score'] = love.audio.newSource('score.wav', 'static'),
    
    -- https://freesound.org/people/xsgianni/sounds/388079/
    ['music'] = love.audio.newSource('snowstorm background.wav', 'static'),
    ['menu'] = love.audio.newSource('menu music.wav', 'static'),
    ['crash'] = love.audio.newSource('collision sound.wav', 'static'),
    }
    

    love.graphics.setFont(smallFont)
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

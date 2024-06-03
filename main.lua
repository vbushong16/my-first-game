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

WINDOW_WIDTH = 400
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 400
VIRTUAL_HEIGHT = 600
--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]

local ground = love.graphics.newImage('ground 4.png')
local skier = Skier()
local flagPairs = {}
local spawnTimer = 0
local lastX = -FLAG_HEIGHT + math.random(80)+20

function love.load()
    -- use nearest-neighbor filtering on upscaling and downscaling to prevent blurring of text 
    -- and graphics; try removing this function to see the difference!
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --background = love.graphics.newImage('background 4.png')
    --backgroundScroll = 0

    ground = love.graphics.newImage('ground 4.png')
    --groundScroll = 100

    -- speed at which we should scroll our images, scaled by dt
    --BACKGROUND_SCROLL_SPEED = 40
    --GROUND_SCROLL_SPEED = 100

    -- point at which we should loop our background back to X 0
    --BACKGROUND_LOOPING_POINT = 100

    smallFont = love.graphics.newFont('font.ttf',8)

    love.graphics.setFont(smallFont)

    -- initialize our virtual resolution, which will be rendered within our
    -- actual window no matter its dimensions; replaces our love.window.setMode call
    -- from the last example
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

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
    if key == 'escape' then
        -- function LÖVE gives us to terminate application
        love.event.quit()
    end
end

function love.update(dt)

    --backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    -- scroll ground by preset speed * dt, looping back to 0 after the screen width passes
    --groundScroll = ((groundScroll - GROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT)+300

    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then
        local x = math.max(-FLAG_WIDTH + 10, math.min(lastX + math.random(-20,20),VIRTUAL_WIDTH - 90 -FLAG_WIDTH ))
        lastX = x
        table.insert(flagPairs, FlagPair(x))
        spawnTimer = 0
    end

    skier:update(dt)

    for k, pair in pairs(flagPairs) do
        pair:update(dt)
    end

    for k, pair in pairs(flagPairs) do
        if pair.remove then
            table.remove(flagPairs, k)
        end
    end

end


--[[
    Called after update by LÖVE2D, used to draw anything to the screen, 
    updated or otherwise.
]]
function love.draw()
    -- begin rendering at virtual resolution
    push:start()

    --love.graphics.clear(40/255,45/255,52/255,255/255)

    -- condensed onto one line from last example
    -- note we are now using virtual width and height now for text placement
    love.graphics.printf('Super Skier!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- draw the background at the negative looping point
    --love.graphics.draw(background, 0, 0)

    -- draw the ground on top of the background, toward the bottom of the screen,
    -- at its negative looping point
    love.graphics.draw(ground, 0, -10 )
    --    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2-2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    --    love.graphics.rectangle('fill', skier, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    for k, pair in pairs(flagPairs) do
        pair:render()
    end


    skier:render()

    -- end rendering at virtual resolution
    push:finish()
end

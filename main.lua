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


function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('SnowStorm')

    math.randomseed(os.time())


    love.graphics.setFont(gFonts['smallFont'])
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    gFrames = {
        ['arrows'] = GenerateQuads(gTextures['arrows'],24,24),
        ['skiers'] = GenerateQuads(gTextures['skier'],32,32),
        ['flags'] = GenerateQuads(gTextures['ski_flag'],32,32),
        ['powerUp'] = GenerateQuads(gTextures['powerUp'],15,15),
    }

    gStateMachine = StateMachine{
        ['title'] = function() return TitleScreenState() end,
        ['play'] =  function() return PlayState() end,
        ['skier-select'] =  function() return SkierSelectState() end,
        ['game-over'] =  function() return GameOverState() end,
        ['high-scores'] =  function() return HighScoreState() end,
        ['enter-high-score'] =  function() return EnterHighScoreState() end,
        ['countdown'] =  function() return CountdownState() end,
    }
    gStateMachine:change('title',{
        highScores = loadHighScores()
    })

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



function loadHighScores()
    love.filesystem.setIdentity('snowstorm')

    -- if the file doesn't exist, initialize it with some default scores
    if not love.filesystem.getInfo('snowstorm.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'CTO\n'
            scores = scores .. tostring(0) .. '\n'
        end

        love.filesystem.write('snowstorm.lst', scores)
    end

    -- flag for whether we're reading a name or not
    local name = true
    local currentName = nil
    local counter = 1

    -- initialize scores table with at least 10 blank entries
    local scores = {}

    for i = 1, 10 do
        -- blank table; each will hold a name and a score
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    -- iterate over each line in the file, filling in names and scores
    for line in love.filesystem.lines('snowstorm.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        -- flip the name flag
        name = not name
    end

    return scores
end

--[[
    Renders hearts based on how much health the player has. First renders
    full hearts, then empty hearts for however much health we're missing.
]]
function renderHealth(health)
    -- start of our health rendering
    local healthX = VIRTUAL_WIDTH - 100
    
    -- render health left
    for i = 1, health do
        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][1], healthX, 4)
        healthX = healthX + 11
    end

    -- render missing health
    for i = 1, 3 - health do
        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][2], healthX, 4)
        healthX = healthX + 11
    end
end

--[[
    Renders the current FPS.
]]
function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end

--[[
    Simply renders the player's score at the top right, with left-side padding
    for the score number.
]]
function renderScore(score)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print('Score:', VIRTUAL_WIDTH - 60, 5)
    love.graphics.printf(tostring(score), VIRTUAL_WIDTH - 50, 5, 40, 'right')
end
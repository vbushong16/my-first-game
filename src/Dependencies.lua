--[[
    GD50
    Super Mario Bros. Remake

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    -- Dependencies --

    A file to organize all of the global dependencies for our project, as
    well as the assets for our game, rather than pollute our main.lua file.
]]

--
-- libraries
--
Class = require 'lib/class'
-- https://github.com/Ulydev/push
push = require 'lib/push'
lume = require 'lib/lume'
lurker = require 'lib/lurker'
-- Timer = require 'lib/knife.timer'

--
-- our own code
--

-- utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'

-- game states
require 'src/states/game/BaseState'
require 'src/states/game/CountdownState'
require 'src/states/game/PlayState'
require 'src/states/game/GameOverState'
require 'src/states/game/TitleScreenState'
require 'src/states/game/EnterHighScoreState'
require 'src/states/game/SkierSelectState'
require 'src/states/game/HighScoreState'

-- entity states
--require 'src/states/entity/PlayerFallingState'
--require 'src/states/entity/PlayerIdleState'
--require 'src/states/entity/PlayerJumpState'
require 'src/states/entity/SkierSkiingState'

--require 'src/states/entity/snail/SnailChasingState'
--require 'src/states/entity/snail/SnailIdleState'
--require 'src/states/entity/snail/SnailMovingState'

-- general
require 'src/Animation'
require 'src/Entity'
require 'src/Flag'
require 'src/FlagPair'
require 'src/GameLevel'
require 'src/GameObject'
require 'src/LevelMaker'
require 'src/Player'
require 'src/PowerUp'
require 'src/Skier'
require 'src/Snail'
require 'src/Tile'
require 'src/TileMap'



gFonts = {
    ['smallFont'] = love.graphics.newFont('fonts/SEASRN__.ttf',12),
    ['mediumFont'] = love.graphics.newFont('fonts/SEASRN__.ttf',20),
    ['largeFont'] = love.graphics.newFont('fonts/SEASRN__.ttf',34),
    ['hugeFont'] = love.graphics.newFont('fonts/SEASRN__.ttf',48),
    --['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}

gSounds = {
    ['music'] = love.audio.newSource('sounds/snowstorm background.wav', 'static'),
    ['menu'] = love.audio.newSource('sounds/menu music.wav', 'static'),
    ['crash'] = love.audio.newSource('sounds/collision sound.wav', 'static')
}

gTextures = {
    -- ['tiles'] = love.graphics.newImage('graphics/tiles.png'),
    ['tiles'] = love.graphics.newImage('graphics/Snow sprite.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    -- ['skier'] = love.graphics.newImage('graphics/skier.png'),
    ['skier'] = love.graphics.newImage('graphics/skier sprite1.png'),
    ['ski_flag'] = love.graphics.newImage('graphics/flag.png'),
    ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
    ['particle'] = love.graphics.newImage('graphics/particle.png'),
    ['powerUp'] = love.graphics.newImage('graphics/power_up.png'),
    ['tree'] = love.graphics.newImage('graphics/tree.png'),
}


gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),
    ['arrows'] = GenerateQuads(gTextures['arrows'],24,24),
    ['skier'] = GenerateQuads(gTextures['skier'],16,25),
    ['ski_flag'] = GenerateQuads(gTextures['ski_flag'],16,16),
    ['powerUp'] = GenerateQuads(gTextures['powerUp'],15,15),
    ['tree'] = GenerateQuads(gTextures['tree'],16,25),
}

gFrames['tilesets'] = GenerateTileSets(gFrames['tiles'], 
    TILE_SETS_WIDE, TILE_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)




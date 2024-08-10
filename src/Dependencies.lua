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
--Timer = require 'lib/knife.timer'

--
-- our own code
--

-- utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'

-- game states
require 'src/states/BaseState'
require 'src/states/CountdownState'
require 'src/states/PlayState'
require 'src/states/GameOverState'
require 'src/states/TitleScreenState'
require 'src/states/EnterHighScoreState'
require 'src/states/SkierSelectState'
require 'src/states/HighScoreState'

-- entity states
--require 'src/states/entity/PlayerFallingState'
--require 'src/states/entity/PlayerIdleState'
--require 'src/states/entity/PlayerJumpState'
--require 'src/states/entity/PlayerWalkingState'

--require 'src/states/entity/snail/SnailChasingState'
--require 'src/states/entity/snail/SnailIdleState'
--require 'src/states/entity/snail/SnailMovingState'

-- general
--require 'src/Animation'
--require 'src/Entity'
--require 'src/GameObject'
--require 'src/GameLevel'
--require 'src/LevelMaker'
--require 'src/Player'
--require 'src/Snail'
--require 'src/Tile'
require 'src/PowerUp'
require 'src/Flag'
require 'src/FlagPair'
require 'src/Skier'


gSounds = {
    ['music'] = love.audio.newSource('sounds/snowstorm background.wav', 'static'),
    ['menu'] = love.audio.newSource('sounds/menu music.wav', 'static'),
    ['crash'] = love.audio.newSource('sounds/collision sound.wav', 'static'),

}

gTextures = {
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['skier'] = love.graphics.newImage('graphics/skier Archive.png'),
    ['ski_flag'] = love.graphics.newImage('graphics/ski flag.png'),
    ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
    ['particle'] = love.graphics.newImage('graphics/particle.png'),
    ['powerUp'] = love.graphics.newImage('graphics/power_up.png'),
}


gFonts = {
    ['smallFont'] = love.graphics.newFont('fonts/SEASRN__.ttf',12),
    ['mediumFont'] = love.graphics.newFont('fonts/SEASRN__.ttf',20),
    ['largeFont'] = love.graphics.newFont('fonts/SEASRN__.ttf',34),
    ['hugeFont'] = love.graphics.newFont('fonts/SEASRN__.ttf',48),
    --['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}

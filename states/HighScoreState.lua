--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the screen where we can view all high scores previously recorded.
]]

HighScoreState = Class{__includes = BaseState}

function HighScoreState:enter(params)
    self.highScores = params.highScores
end

function HighScoreState:update(dt)
    -- return to the start screen if we press escape
    if love.keyboard.wasPressed('escape') then
        
        gStateMachine:change('title', {
            highScores = self.highScores
        })
    end
end

function HighScoreState:render()
    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('High Scores', 0, 20, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['smallFont'])

    -- iterate over all high score indices in our high scores table
    for i = 1, 10 do
        local name = self.highScores[i].name or '---'
        local score = self.highScores[i].score or '---'

        -- score number (1-10)
        love.graphics.printf(tostring(i) .. '.', VIRTUAL_WIDTH / 4, 60 + i * 20, 50, 'left')

        -- score name
        love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38, 60 + i * 20, 50, 'right')
        
        -- score itself
        love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2, 60 + i * 20, 100, 'right')
    end

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf("Press Escape to return to the main menu!", 0, VIRTUAL_HEIGHT - 80, VIRTUAL_WIDTH, 'center')
end




GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.highScores = params.highScores
    self.scores = params.scores
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- see if score is higher than any in the high scores table
        local highScore = false
        
        -- keep track of what high score ours overwrites, if any
        local scoreIndex = 11

        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0
            if self.scores > score then
                highScoreIndex = i
                highScore = true
            end
        end

        if highScore then
            --gSounds['high-score']:play()
            gStateMachine:change('enter-high-score', {
                highScores = self.highScores,
                score = self.scores,
                scoreIndex = highScoreIndex
            }) 
        else 
            gStateMachine:change('title', {
                highScores = self.highScores
            }) 
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end
function GameOverState:render()
    --sounds['menu']:play()
    gSounds['music']:stop()

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('SnowStorm', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('You Lose', 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('Your Score '..tostring(self.scores), 0, 150, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('Press Enter', 0, 200, VIRTUAL_WIDTH, 'center')
end
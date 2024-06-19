


ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end

end

function ScoreState:render()
    --sounds['menu']:play()
    sounds['music']:stop()

    love.graphics.setFont(largeFont)
    love.graphics.printf('SnowStorm', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(largeFont)
    love.graphics.printf('You Lose', 0, 100, VIRTUAL_WIDTH, 'center')

<<<<<<< Updated upstream:states/ScoreState.lua
    love.graphics.setFont(largeFont)
    love.graphics.printf('Press Enter', 0, 150, VIRTUAL_WIDTH, 'center')
=======
    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('Your Score '..tostring(self.score), 0, 150, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('Press Enter', 0, 200, VIRTUAL_WIDTH, 'center')
>>>>>>> Stashed changes:states/GameOverState.lua
end
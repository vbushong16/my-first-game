


ScoreState = Class{__includes = BaseState}

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end

end

function ScoreState:render()
    love.graphics.setFont(smallFont)
    love.graphics.printf('SnowStorm', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(smallFont)
    love.graphics.printf('You Lose', 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(smallFont)
    love.graphics.printf('Press Enter', 0, 150, VIRTUAL_WIDTH, 'center')
end
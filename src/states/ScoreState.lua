


ScoreState = Class{__includes = BaseState}



function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end

end

function ScoreState:render()
    --sounds['menu']:play()
    gSounds['music']:stop()

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('SnowStorm', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('You Lose', 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('Press Enter', 0, 150, VIRTUAL_WIDTH, 'center')
end
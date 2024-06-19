



TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)

    gSounds['menu']:play()

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function TitleScreenState:render()

    

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('SnowStorm', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.printf('Press Enter', 0, 100, VIRTUAL_WIDTH, 'center')
end


CountdownState = Class{__includes = BaseState}

COUNTDOWN_TIME = 0.75

function CountdownState:init()
    self.count = 3
    self.timer = 0
end

function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

function CountdownState:render()

    love.graphics.draw(ground, 0,0)
    
    
    love.graphics.setColor(love.math.colorFromBytes(191,170,36))
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count),0,120,VIRTUAL_WIDTH,'center')
end
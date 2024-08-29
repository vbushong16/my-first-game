

CountdownState = Class{__includes = BaseState}

function CountdownState:enter(params)
    self.highScores = params.highScores
    self.skin = params.skin
    -- print("Countdown ENTER: ",self.skin)
end

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
            -- print("Countdown CHANGE: ",self.skin)
            gStateMachine:change('play',{
            -- gStateMachine:change('game-over',{
                highScores = self.highScores,
                skin = self.skin
            })
        end
    end
end

function CountdownState:render()

    love.graphics.draw(gTextures['background'], 0,0)
    
    
    love.graphics.setColor(love.math.colorFromBytes(191,170,36))
    love.graphics.setFont(gFonts['hugeFont'])
    love.graphics.printf(tostring(self.count),0,120,VIRTUAL_WIDTH,'center')
end
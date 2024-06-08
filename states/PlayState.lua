

PlayState = Class{__includes = BaseState}

FLAG_SPEED = 100
FLAG_WIDTH = 30
FLAG_HEIGHT = 30

SKIER_WIDTH = 30
SKIER_HEIGHT = 30

function PlayState:init()
    self.skier = Skier()
    self.flagPairs = {}
    self.timer = 0

    self.lastX = -FLAG_HEIGHT + math.random(80)+20
end

function PlayState:update(dt)

    self.timer = self.timer + dt

    if self.timer > 2 then
        --local x = math.max(-FLAG_WIDTH + 10, math.min(lastX + math.random(-10,60),VIRTUAL_WIDTH ))
        local x = math.random(80,210)
        print("left flag: ",x)
        self.lastX = x
        table.insert(self.flagPairs, FlagPair(x))
        self.timer = math.random(0,1)
    end


    for k, pair in pairs(self.flagPairs) do
        pair:update(dt)
        if pair.y < 230 then
            pair.remove = true
        end    
    end

    for k, pair in pairs(self.flagPairs) do
        if pair.remove then
            table.remove(self.flagPairs, k)
        end
    end

    self.skier:update(dt)

    for k, pair in pairs(self.flagPairs) do
        for l, flag in pairs(pair.flags) do
            if self.skier:collides(flag) then
                print('True')
                gStateMachine:change('title')
            end
        end
    end
end

function PlayState:render()
    
    love.graphics.draw(ground, 0,0)
    
    for k, pair in pairs(self.flagPairs) do
        pair:render()
    end


    self.skier:render()
end

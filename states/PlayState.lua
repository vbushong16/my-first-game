

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
    self.scorecounter = 0
    sounds['music']:setLooping(true)
    sounds['music']:play()

end

function PlayState:update(dt)

    self.timer = self.timer + dt

    if self.timer > 2 then
        --local x = math.max(-FLAG_WIDTH + 10, math.min(lastX + math.random(-10,60),VIRTUAL_WIDTH ))
        local x = math.random(80,210)
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
            pair.scored = true
            table.remove(self.flagPairs, k)
        end
    end

    self.skier:update(dt)

    for k, pair in pairs(self.flagPairs) do        
        left_flag = pair.flags['left'].x
        right_flag = pair.flags['right'].x
        for l, flag in pairs(pair.flags) do
            if not pair.scored then
                if self.skier:scores(left_flag,right_flag,flag) then
                    print('Score: True')
                    self.scorecounter = self.scorecounter + 1
                    pair.scored = true
                end
            end
            if self.skier:collides(flag) then
                print('Collides: True')
                FLAG_SPEED = 100
                gStateMachine:change('score')
            end
        end
    end
end

function PlayState:render()
    
    love.graphics.draw(ground, 0,0)
    
    for k, pair in pairs(self.flagPairs) do
        pair:render()
    end

    love.graphics.setFont(largeFont)
    love.graphics.print('Score: ' .. tostring(self.scorecounter), 8, 8)

    self.skier:render()
end

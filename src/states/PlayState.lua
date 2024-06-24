

PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.highScores = params.highScores
    self.skier = params.skier
end

function PlayState:init(skin)
    self.skier = skin
    self.flagPairs = {}
    self.timer = 0
    self.powertimer = 0

    self.powerUps = {}

    self.lastX = -FLAG_HEIGHT + math.random(80)+20
    self.scorecounter = 0
    gSounds['menu']:stop()
    gSounds['music']:setLooping(true)
    gSounds['music']:play()

end

function PlayState:update(dt)

    self.timer = self.timer + dt
    self.powertimer = self.powertimer + dt

    if love.keyboard.isDown('left') then
        self.skier:turn()
    elseif love.keyboard.isDown('right') then
        self.skier:turn()
    end

    if self.timer > 2 then
        --local x = math.max(-FLAG_WIDTH + 10, math.min(lastX + math.random(-10,60),VIRTUAL_WIDTH ))
        local x = math.random(80,210)
        self.lastX = x
        table.insert(self.flagPairs, FlagPair(x))
        self.timer = math.random(0,1)
    end

    if self.powertimer > math.random(4,20) then
        print(math.random(4,20))
        local x = math.random(80,210)
        self.lastX = X
        table.insert(self.powerUps,PowerUp(x))
        self.powertimer = 0
    end
     
    for k, pair in pairs(self.powerUps) do
        pair:update(dt)
        if pair.y < 230 then
            pair.remove = true
        end    
    end

    for k, pair in pairs(self.powerUps) do
        if pair.remove then
            pair.scored = true
            table.remove(self.powerUps, k)
        end
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
                gSounds['crash']:play()
                
                print(self.scorecounter)
                print(self.highScores[1].score)
                gStateMachine:change('game-over',{
                    highScores = self.highScores,
                    scores = self.scorecounter
                })
            end
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

end

function PlayState:render()
    
    love.graphics.draw(gTextures['background'], 0,0)
    
    for k, pair in pairs(self.flagPairs) do
        pair:render()
    end

    for k, pair in pairs(self.powerUps) do
        pair:render()
    end

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.print('Score: ' .. tostring(self.scorecounter), 8, 8)

    self.skier:render()

    if love.keyboard.isDown('left') then
        self.skier:renderParticles()
    elseif love.keyboard.isDown('right') then
        self.skier:renderParticles()
    end

end

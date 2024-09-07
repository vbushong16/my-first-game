

PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.highScores = params.highScores
    --self.skier = Skier(params.skin)
end

function PlayState:init()
    self.camX = 0
    self.camY = 0
    self.level = LevelMaker.generate(36,100)
    self.tileMap = self.level.tileMap
    self.background = math.random(3)
    self.backgroundX = 0

    self.flagPairs = {}
    self.timer = 0
    self.powertimer = 0

    self.powerUps = {}

    self.lastX = -FLAG_HEIGHT + math.random(80)+20
    self.scorecounter = 0
    gSounds['menu']:stop()
    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    self.skier = Skier({
        x = VIRTUAL_WIDTH/2,
        y = VIRTUAL_HEIGHT / 2 + 65,
        width = 16,
        height = 16,
        texture = 'skier',
        stateMachine = StateMachine{
            ['skiing'] = function() return SkierSkiingState(self.skier) end
        },
        map = self.tileMap,
        level = self.level
    })

    self.skier:changeState('skiing')
end

function PlayState:update(dt)
    -- Timer.update(dt)

    self.level:clear()


    -- self.timer = self.timer + dt
    -- self.powertimer = self.powertimer + dt

    self.skier:update(dt)
    self.level:update(dt)
    -- if love.keyboard.isDown('left') then
    --     self.skier:turn()
    -- elseif love.keyboard.isDown('right') then
    --     self.skier:turn()
    -- end

    -- if self.timer > 2 then
    --     --local x = math.max(-FLAG_WIDTH + 10, math.min(lastX + math.random(-10,60),VIRTUAL_WIDTH ))
    --     local x = math.random(80,210)
    --     self.lastX = x
    --     table.insert(self.flagPairs, FlagPair(x))
    --     self.timer = math.random(0,1)
    -- end

    -- if self.powertimer > math.random(4,20) then
    --     print(math.random(4,20))
    --     local x = math.random(80,210)
    --     self.lastX = X
    --     table.insert(self.powerUps,PowerUp(x))
    --     self.powertimer = 0
    -- end
     
    -- for k, pair in pairs(self.powerUps) do
    --     pair:update(dt)
    --     if pair.y < 230 then
    --         pair.remove = true
    --     end    
    -- end

    -- for k, pair in pairs(self.powerUps) do
    --     if pair.remove then
    --         pair.scored = true
    --         table.remove(self.powerUps, k)
    --     end
    -- end

    -- for k, pair in pairs(self.flagPairs) do
    --     pair:update(dt)
    --     if pair.y < 230 then
    --         pair.remove = true
    --     end    
    -- end

    -- for k, pair in pairs(self.flagPairs) do
    --     if pair.remove then
    --         pair.scored = true
    --         table.remove(self.flagPairs, k)
    --     end
    -- end


    -- for k, pair in pairs(self.flagPairs) do        
    --     left_flag = pair.flags['left'].x
    --     right_flag = pair.flags['right'].x
    --     for l, flag in pairs(pair.flags) do
    --         if not pair.scored then
    --             if self.skier:scores(left_flag,right_flag,flag) then
    --                 print('Score: True')
    --                 self.scorecounter = self.scorecounter + 1
    --                 pair.scored = true
    --             end
    --         end
    --         if self.skier:collides(flag) then
    --             print('Collides: True')
    --             FLAG_SPEED = 100
    --             gSounds['crash']:play()
                
    --             print(self.scorecounter)
    --             print(self.highScores[1].score)
    --             gStateMachine:change('game-over',{
    --                 highScores = self.highScores,
    --                 scores = self.scorecounter
    --             })
    --         end
    --     end
    -- end
    self:updateCamera()

    if self.skier.x <= TILE_SIZE * 2 then
        self.skier.x = TILE_SIZE*2+1
    elseif self.skier.x > TILE_SIZE * self.tileMap.width - 3 - self.skier.width then
        self.skier.x = TILE_SIZE * self.tileMap.width - 3 - self.skier.width
    end


    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

end

function PlayState:render()
    
    love.graphics.push()
    -- love.graphics.draw(gTextures['background'], 0,0)

    -- translate the entire view of the scene to emulate a camera
    -- love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    self.level:render()
    
    -- for k, pair in pairs(self.flagPairs) do
    --     pair:render()
    -- end

    -- for k, pair in pairs(self.powerUps) do
    --     pair:render()
    -- end



    self.skier:render()
    love.graphics.pop()

    -- if love.keyboard.isDown('left') then
    --     self.skier:renderParticles()
    -- elseif love.keyboard.isDown('right') then
    --     self.skier:renderParticles()
    -- end

    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print('Score: ' .. tostring(self.skier.score), 8, 8)

end


function PlayState:updateCamera()
    -- clamp movement of the camera's X between 0 and the map bounds - virtual width,
    -- setting it half the screen to the left of the player so they are in the center
    self.camX = math.max(0,
        math.min(TILE_SIZE * self.tileMap.width - VIRTUAL_WIDTH,
        self.skier.x - (VIRTUAL_WIDTH / 2 - 8)))

    -- adjust background X to move a third the rate of the camera for parallax
    self.backgroundX = (self.camX / 3) % 256

    self.camY = math.max(0,
        math.min(TILE_SIZE * self.tileMap.height - VIRTUAL_HEIGHT,
        self.skier.y - (VIRTUAL_HEIGHT / 2 - 8)))

-- adjust background X to move a third the rate of the camera for parallax
    self.backgroundY = (self.camY / 3) % 256
end

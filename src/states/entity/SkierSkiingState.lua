


SkierSkiingState = Class{__includes = BaseState}

function SkierSkiingState:init(skier)
    self.skier = skier
    self.animation = 1 
    -- Animation {
    --     frame = {1},
    --     interval = 1
    -- }

    self.skier.currentAnimation = self.animation
end

function SkierSkiingState:update(dt)
    --self.skier.currentAnimation:update(dt)

    local tileBottomLeft = self.skier.map:pointToTile(self.skier.x +1,self.skier.y +self.skier.height)
    local tileBottomRight = self.skier.map:pointToTile(self.skier.x + self.skier.width -1, self.skier.y + self.skier.height)
    

    self.skier.x = self.skier.x - 1
    local collidedObjects = self.skier:checkObjectCollisions()
    self.skier.x = self.skier.x + 1

    if  #collidedObjects == 0 and (tileBottomLeft and tileBottomRight) and (not tileBottomLeft:collidable() and not tileBottomRight:collidable()) then
         self.skier.dy = 0
    end
    if love.keyboard.isDown('left') then
        self.skier.dx = math.max(-SKIER_SPEED,self.skier.dx + -ACCELERATION_SPEED)
        self.skier.x = self.skier.x + self.skier.dx * dt
        self.skier:checkLeftCollisions()
    elseif love.keyboard.isDown('right') then
        self.skier.dx = math.min(SKIER_SPEED,self.skier.dx + ACCELERATION_SPEED)
        self.skier.x = self.skier.x + self.skier.dx * dt
        self.skier:checkRightCollisions()
    end
    
    --FLAG_SPEED = FLAG_SPEED + FLAG_SPEED * 0.01
    self.skier.y = FLAG_SPEED*dt + self.skier.y

     
    for k,entity in pairs(self.skier.level.entities) do
        if entity:collides(self.skier) then
            gSounds['crash']:play()
            gStateMachine:change('play')
        end
    end

    -- check if we've collided with any collidable game objects
    for k, object in pairs(self.skier.level.objects) do
        if object:collides(self.skier) then
            if object.solid then
                self.skier.dy = 0
                --self.player.y = object.y - self.player.height

                -- if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
                --     self.player:changeState('walking')
                -- else
                --     self.player:changeState('idle')
                -- end
            elseif object.consumable then
                object.onConsume(self.skier)
                table.remove(self.skier.level.objects, k)
            end
        end
    end



end
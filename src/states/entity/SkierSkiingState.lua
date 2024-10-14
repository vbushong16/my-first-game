


SkierSkiingState = Class{__includes = BaseState}

function SkierSkiingState:init(skier)
    self.skier = skier
    self.animation = Animation {
        frames = {1},
        interval = 1
    }

    print(self.animation.frame)
    self.skier.currentAnimation = self.animation
end

function SkierSkiingState:update(dt)
    self.skier.currentAnimation:update(dt)

    local tileBottomLeft = self.skier.map:pointToTile(self.skier.x +1,self.skier.y +self.skier.height)
    local tileBottomRight = self.skier.map:pointToTile(self.skier.x + self.skier.width -1, self.skier.y + self.skier.height)

    --self.skier.x = self.skier.x - 1
    local collidedObjects = self.skier:checkObjectCollisions()
    --self.skier.x = self.skier.x + 1

    -- print("BOTTOM LEFT: ",tileBottomLeft:collidable())
    -- print("BOTTOM RIGHT: ",tileBottomRight:collidable())

    if tileBottomLeft:collidable() or tileBottomRight:collidable() then
        self.skier.y = self.skier.y
    else
        self.skier.y = FLAG_SPEED*dt + self.skier.y
    end

    if  #collidedObjects == 0 and (tileBottomLeft and tileBottomRight) and (not tileBottomLeft:collidable() and not tileBottomRight:collidable()) then
         self.skier.dy = 0
    end
    if love.keyboard.isDown('left') then
        self.skier.dx = 0
        self.skier.dx = math.max(-SKIER_SPEED,self.skier.dx-ACCELERATION_SPEED)
        self.skier.x = self.skier.x + self.skier.dx * dt
        self.skier:checkLeftCollisions()
    elseif love.keyboard.isDown('right') then
        self.skier.dx = 0
        self.skier.dx = math.min(SKIER_SPEED,self.skier.dx + ACCELERATION_SPEED)
        self.skier.x = self.skier.x + self.skier.dx * dt
        self.skier:checkRightCollisions()
        
    end
    
    --FLAG_SPEED = FLAG_SPEED + FLAG_SPEED * 0.01


     
    for k,entity in pairs(self.skier.level.entities) do
        if entity:collides(self.skier) then
            gSounds['crash']:play()
            gStateMachine:change('play')
        end
    end

    -- check if we've collided with any collidable game objects
    for k, object in pairs(self.skier.level.objects) do
        if object:collides(self.skier) then
            print("=============================================================")
            print("OBJECT TEXTURE: ", object.texture)
            print("OBJECT x: ", object.x)
            print("OBJECT y: ", object.y)
            print("OBJECT solid: ", object.solid)
            print("OBJECT collidable: ", object.collidable)
            print("OBJECT width: ", object.width)
            print("OBJECT height: ", object.height)
            
            print("OBJECT COLLISION")
            if object.solid then
                -- self.skier.dy = 0
                self.skier.y = 0--self.skier.y

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

    if love.keyboard.wasPressed('space') then
        self.skier:changeState('jump')
    end


end
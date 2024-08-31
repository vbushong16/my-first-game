


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
        self.skier.dx = 0
    elseif love.keyboard.isDown('left') then
        self.skier.dx = math.max(-SKIER_SPEED,self.skier.dx + -ACCELERATION_SPEED)
        self.skier.x = self.skier.x + self.dx * dt
        self.skier:checkLeftCollisions()
    elseif love.keyboard.isDown('right') then
        self.skier.dx = math.min(SKIER_SPEED,self.skier.dx + ACCELERATION_SPEED)
        self.skier.x = self.skier.x + self.skier.dx * dt
        self.skier:checkRightCollisions()
    end

    for k,entity in pairs(self.skier.level.entities) do
        if entity:collides(self.skier) then
            gSounds['crash']:play()
            gStateMachine:change('play')
        end
    end

end
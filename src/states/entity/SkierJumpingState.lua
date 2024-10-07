


SkierJumpState = Class{__includes = BaseState}

function SkierJumpState:init(skier)
    self.skier = skier
    self.animation = Animation {
        frames = {2},
        interval = 1
    }
    
    self.skier.currentAnimation = self.animation
end


function SkierJumpState:enter(params)
    gSounds['crash']:play()
    JumpCounter = 3
    lcounter = 0
end


function SkierJumpState:update(dt)
    self.skier.currentAnimation:update(dt)

    lcounter = lcounter + dt
    self.skier.y = FLAG_SPEED*dt + self.skier.y

    if lcounter > JUMP_Time then
        JumpCounter = JumpCounter - 1
    
        self.skier.y = FLAG_SPEED*dt + self.skier.y
    
        if JumpCounter == 0 then
             self.skier:changeState('skiing')
        end
    end


end
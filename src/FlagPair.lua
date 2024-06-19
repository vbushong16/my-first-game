
FlagPair = Class{}



function FlagPair:init(x)

    self.scored = false
    self.y = VIRTUAL_HEIGHT
    self.x = x

    self.flags = {
        ['left'] = Flag('left', self.x),
        ['right'] = Flag('right', self.x + math.random(70,GAP_WIDTH))
    }

    -- whether this pipe pair is ready to be removed from the scene
    self.remove = false
end

function FlagPair:update(dt)
    -- remove the pipe from the scene if it's beyond the left edge of the screen,
    -- else move it from right to left
    FLAG_SPEED = FLAG_SPEED + dt * 5
    if self.y > 295 then
        self.y = self.y - FLAG_SPEED * dt
        self.flags['left'].y = self.y
        self.flags['right'].y = self.y
    else
        self.remove = true
    end
end

function FlagPair:render()
    for k, flag in pairs(self.flags) do
        flag:render()
    end
end
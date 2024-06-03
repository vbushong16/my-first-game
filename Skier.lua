
Skier = Class{}

local SKIER_SPEED = 200

function Skier:init()

    self.image = love.graphics.newImage('skier 2.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = 80
    self.y = VIRTUAL_HEIGHT / 2 + 40

    self.dx = 0

end

function Skier:update(dt)

    if love.keyboard.isDown('left') then
        self.x = math.max(70,self.x + -SKIER_SPEED * dt)
    elseif love.keyboard.isDown('right') then
        self.x = math.min(VIRTUAL_WIDTH-100,self.x + SKIER_SPEED * dt)
    end

--    self.dx = self.dx + SKIER_SPEED * dt
--    self.x = self.x + self.dx
end

function Skier:render()
    love.graphics.draw(self.image, self.x, self.y)
end









Flag = Class{}

local FLAG_IMAGE = love.graphics.newImage('flag.png')
local FLAG_SCROLL = -150

FLAG_SPEED = 100

FLAG_HEIGHT = 30
FLAG_WIDTH = 80

function Flag:init()
    self.x = math.random(VIRTUAL_WIDTH/4, VIRTUAL_WIDTH -10)
    self.y = VIRTUAL_HEIGHT

    self.height = FLAG_IMAGE:getHeight()
    self.width = FLAG_WIDTH

    self.orientation = orientation

end

function Flag:update(dt)
--    self.y = self.y + FLAG_SCROLL * dt
end

function Flag:render()
  
      love.graphics.draw(FLAG_IMAGE, self.x, 
        (self.orientation == 'left' and self.y + FLAG_WIDTH or self.y), 
        0, 1, self.orientation == 'left' and -1 or 1)
  
  --  love.graphics.draw(FLAG_IMAGE, math.floor(self.x + 0.5), math.floor(self.y))
end



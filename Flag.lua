





Flag = Class{}

local FLAG_IMAGE = love.graphics.newImage('ski flag.png')
local FLAG_SCROLL = -150


function Flag:init(orientation,x)
    self.x = x
    self.y = VIRTUAL_HEIGHT-40

    self.height = FLAG_IMAGE:getHeight()
    self.width = FLAG_WIDTH

    self.orientation = orientation

end

function Flag:update(dt)
--    self.y = self.y + FLAG_SCROLL * dt
end

function Flag:render()
  
      love.graphics.draw(FLAG_IMAGE, (self.orientation == 'left' and self.x or self.x)
      ,self.y, 0, 1, self.orientation == 'left' and 1 or 1)
  
  --  love.graphics.draw(FLAG_IMAGE, math.floor(self.x + 0.5), math.floor(self.y))
end



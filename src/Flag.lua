





Flag = Class{}




function Flag:init(orientation,x)
    self.x = x
    self.y = VIRTUAL_HEIGHT-40

    self.image = gTextures['ski_flag']
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.orientation = orientation

end

function Flag:update(dt)
--    self.y = self.y + FLAG_SCROLL * dt
end

function Flag:render()
  
      love.graphics.draw(self.image, (self.orientation == 'left' and self.x or self.x)
      ,self.y, 0, 1, self.orientation == 'left' and 1 or 1)
  
  --  love.graphics.draw(FLAG_IMAGE, math.floor(self.x + 0.5), math.floor(self.y))
end



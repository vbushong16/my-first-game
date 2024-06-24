
PowerUp = Class{}




function PowerUp:init(x)
    self.x = x
    self.y = VIRTUAL_HEIGHT

end

function PowerUp:update(dt)
    if self.y > 295 then
        self.y = self.y - FLAG_SPEED * dt
    else
        self.remove = true
    end

end

function PowerUp:render()
  
      love.graphics.draw(gTextures['powerUp'],gFrames['powerUp'][1], self.x,self.y)
  
  --  love.graphics.draw(FLAG_IMAGE, math.floor(self.x + 0.5), math.floor(self.y))
end


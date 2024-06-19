
Skier = Class{}



function Skier:init()

    self.image = gTextures['skier']
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH/2
    self.y = VIRTUAL_HEIGHT / 2 + 65

    self.dx = 0

end

function Skier:collides(flag)


    --print(flag.x)
    if (self.y + 2) + (self.height - 4) >= flag.y+6  and self.y + 2 <= flag.y + FLAG_HEIGHT then
      --  print("y:",(self.y + 2) + (self.height - 4) >= flag.y+6  and self.y + 2 <= flag.y + FLAG_HEIGHT)

     --   print("SKbx:",(self.x + 2) + (self.width - 4))
      --  print("SKx:",(self.x + 2) )
      --  print("Fbx:",(flag.x + FLAG_WIDTH))
       -- print("fx:",flag.x)

        if (self.x + 4) + (self.width - 8) >= flag.x+10 and self.x + 2 <= flag.x + FLAG_WIDTH -8 then
           -- print("x:",(self.x + 4) + (self.width - 8) >= flag.x+10 and self.x + 2 <= flag.x + FLAG_WIDTH -8)
            return true
        end
    end

    return false
end


function Skier:scores(left_flag,right_flag,flag)
    if (self.x) >= left_flag and (self.x + SKIER_WIDTH) <= right_flag + FLAG_WIDTH then
        if self.y > flag.y + FLAG_HEIGHT then
            return true
        end
    end
end



function Skier:update(dt)

    if love.keyboard.isDown('left') then
        self.x = math.max(70,self.x + -SKIER_SPEED * dt)
    elseif love.keyboard.isDown('right') then
        self.x = math.min(VIRTUAL_WIDTH-100,self.x + SKIER_SPEED * dt)
    end
    --print(self.x)
    --print(self.width)
--    self.dx = self.dx + SKIER_SPEED * dt
--    self.x = self.x + self.dx
end

function Skier:render()
    love.graphics.draw(self.image, self.x, self.y)
end



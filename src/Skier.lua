
Skier = Class{__includes = Entity}

paletteColors = {
    -- blue
    [1] = {
        ['r'] = 99,
        ['g'] = 155,
        ['b'] = 255
    },
    -- green
    [2] = {
        ['r'] = 106,
        ['g'] = 190,
        ['b'] = 47
    },
    -- red
    [3] = {
        ['r'] = 217,
        ['g'] = 87,
        ['b'] = 99
    },
    -- purple
    [4] = {
        ['r'] = 215,
        ['g'] = 123,
        ['b'] = 186
    },
    -- gold
    [5] = {
        ['r'] = 251,
        ['g'] = 242,
        ['b'] = 54
    }
}

function Skier:init(def)
    Entity.init(self,def)


    -- self.skin = skin
    -- self.width = 32
    -- self.height = 32
    -- self.color = 1
    -- self.x = VIRTUAL_WIDTH/2
    -- self.y = VIRTUAL_HEIGHT / 2 + 65
    -- self.dx = 0


    -- particle system belonging to the brick, emitted on hit
    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)

    -- various behavior-determining functions for the particle system
    -- https://love2d.org/wiki/ParticleSystem
    
    -- lasts between 0.5-1 seconds seconds
    self.psystem:setParticleLifetime(0.5, 1)
    
    -- give it an acceleration of anywhere between X1,Y1 and X2,Y2 (0, 0) and (80, 80) here
    -- gives generally downward 
    self.psystem:setLinearAcceleration(-15, 0, 15, 80)
    
    -- spread of particles; normal looks more natural than uniform
    self.psystem:setEmissionArea('normal', 10, 10)
end

function Skier:turn()
    -- set the particle system to interpolate between two colors; in this case, we give
    -- it our self.color but with varying alpha; brighter for higher tiers, fading to 0
    -- over the particle's lifetime (the second color)
    self.psystem:setColors(
        paletteColors[self.color].r / 255,
        paletteColors[self.color].g / 255,
        paletteColors[self.color].b / 255,
--        55 * (self.tier + 1) / 255,
        55 * (1) / 255,
        paletteColors[self.color].r / 255,
        paletteColors[self.color].g / 255,
        paletteColors[self.color].b / 255,
        0
    )
    self.psystem:emit(64)
end

function Skier:update(dt)
    Entity.update(self,dt)
    --self.psystem:update(dt)
end

function Skier:render()
    Entity.render(self)
    -- love.graphics.draw(gTextures['skier'],gFrames['skiers'][self.skin], self.x, self.y)
end


function Skier:renderParticles()
    love.graphics.draw(self.psystem, self.x + 16, self.y + 8)
end


function Skier:checkLeftCollisions(dt)
    -- check for left two tiles collision
    local tileTopLeft = self.map:pointToTile(self.x + 1, self.y + 1)
    local tileBottomLeft = self.map:pointToTile(self.x + 1, self.y + self.height - 1)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    if (tileTopLeft and tileBottomLeft) and (tileTopLeft:collidable() or tileBottomLeft:collidable()) then
        self.x = (tileTopLeft.x - 1) * TILE_SIZE + tileTopLeft.width - 1
    else
        
        -- allow us to walk atop solid objects even if we collide with them
        self.x = self.x - 1
        local collidedObjects = self:checkObjectCollisions()
        self.x = self.x + 1

        
        -- reset X if new collided object
        if #collidedObjects > 0 then
            self.x = self.x + SKIER_SPEED * dt
        end
    end
end

function Skier:checkRightCollisions(dt)
    -- check for right two tiles collision
    local tileTopRight = self.map:pointToTile(self.x + self.width - 1, self.y + 1)
    local tileBottomRight = self.map:pointToTile(self.x + self.width - 1, self.y + self.height - 1)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    if (tileTopRight and tileBottomRight) and (tileTopRight:collidable() or tileBottomRight:collidable()) then
        self.x = (tileTopRight.x - 1) * TILE_SIZE - self.width
    else
        
        -- allow us to walk atop solid objects even if we collide with them
        self.x = self.x - 1
        local collidedObjects = self:checkObjectCollisions()
        self.x = self.x + 1

        -- reset X if new collided object
        if #collidedObjects > 0 then
            self.x = self.x - SKIER_SPEED * dt
        end
    end
end

function Skier:checkObjectCollisions()
    local collidedObjects = {}

    for k, object in pairs(self.level.objects) do
        if object:collides(self) then
            if object.solid then
                table.insert(collidedObjects, object)
            elseif object.consumable then
                object.onConsume(self)
                table.remove(self.level.objects, k)
            end
        end
    end

    return collidedObjects
end




-- function Skier:collides(flag)
--     --print(flag.x)
--      if (self.y + 2) + (self.height - 4) >= flag.y+6  and self.y + 2 <= flag.y + FLAG_HEIGHT then
--       --  print("y:",(self.y + 2) + (self.height - 4) >= flag.y+6  and self.y + 2 <= flag.y + FLAG_HEIGHT)
--      --   print("SKbx:",(self.x + 2) + (self.width - 4))
--       --  print("SKx:",(self.x + 2) )
--       --  print("Fbx:",(flag.x + FLAG_WIDTH))
--        -- print("fx:",flag.x)
--         if (self.x + 4) + (self.width - 8) >= flag.x+10 and self.x + 2 <= flag.x + FLAG_WIDTH -8 then
--            -- print("x:",(self.x + 4) + (self.width - 8) >= flag.x+10 and self.x + 2 <= flag.x + FLAG_WIDTH -8)
--             return true
--         end
--     end

--     return false
-- end


-- function Skier:scores(left_flag,right_flag,flag)
--     if (self.x) >= left_flag and (self.x + SKIER_WIDTH) <= right_flag + FLAG_WIDTH then
--         if self.y > flag.y + FLAG_HEIGHT then
--             return true
--         end
--     end
-- end
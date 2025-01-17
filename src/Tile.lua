--[[
    GD50
    -- Super Mario Bros. Remake --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Tile = Class{}

function Tile:init(x, y, id,tileset)
    self.x = x
    self.y = y

    -- self.width = TILE_SIZE
    -- self.height = TILE_SIZE

    self.id = id
    self.tileset = tileset
end

--[[
    Checks to see whether this ID is whitelisted as collidable in a global constants table.
]]
function Tile:collidable(target)
    for k, v in pairs(COLLIDABLE_TILES) do     
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:render()
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.id],
        (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
    -- love.graphics.draw(gTextures['tiles'], gFrames['tilesets'][self.tileset][self.id],
    --     (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end
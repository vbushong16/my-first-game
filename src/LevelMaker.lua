--[[
    GD50
    Super Mario Bros. Remake

    -- LevelMaker Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

LevelMaker = Class{}

function LevelMaker.generate(width, height)
    local tiles = {}
    local entities = {}
    local objects = {}

    local tileID = TILE_ID_EDGE
    
    -- whether we should draw our tiles with toppers
    --local topper = true
    local tileset = math.random(20)
    --local topperset = math.random(20)
    -- print(width)

    -- insert blank tables into tiles for later access
    for y = 1, height do
        table.insert(tiles, {})
    end

   

    -- row by row as we're going downhill
    for y = 1, height do
        
        local tileID = TILE_ID_EMPTY

        for x = 3, width-2  do
            if y == height then
                table.insert(tiles[x],
                        Tile(x, y, TILE_ID_EDGE, tileset))
            
            else
                table.insert(tiles[x],
                Tile(x, y, tileID, tileset))

            -- if math.random(10) == 1 then
            --     table.insert(tiles[x],
            --     Tile(x, y, TILE_ID_EDGE, tileset))
            -- else
            --     table.insert(tiles[x],
            --     Tile(x, y, tileID, tileset))
            end
        end
        


        if y>20 then
            if  y % 10 == 0 then
                local flag_location = math.random(5,10)
                table.insert(objects,
                    GameObject {
                        texture = 'ski_flag',
                        x = flag_location * TILE_SIZE,
                        y = y * TILE_SIZE,
                        width = 16,
                        height = 16,
                        frame = 1,
                        collidable = true,
                        hit = false,
                        solid = true,
                    }
                )
                table.insert(objects,
                GameObject {
                    texture = 'ski_flag',
                    x = (flag_location + 5) * TILE_SIZE,
                    y = y * TILE_SIZE,
                    width = 16,
                    height = 16,
                    frame = 1,
                    collidable = true,
                    hit = false,
                    solid = true,
                }
            )

            end
            if math.random(50) == 1 then
                table.insert(objects,
                GameObject {
                    texture = 'powerUp',
                    x = math.random(3,15) * TILE_SIZE,
                    y = y * TILE_SIZE,
                    width = 15,
                    height = 15,
                    frame = 1,
                    collidable = true,
                    hit = false,
                    solid = false,
                    consumable = true,

                    onConsume = function(skier, object)
                        -- gSounds['pickup']:play()
                        skier.score = skier.score + 100
                    end
                }
            )
            end
        end
        
        tileID = TILE_ID_EDGE
        
        edges = {1, 2,width-1,width}
        for i,x in ipairs(edges) do
            table.insert(tiles[x],
                Tile(x, y, tileID, tileset))
            
            table.insert(objects,
                GameObject {
                    texture = 'tree',
                    x = (x - 1) * TILE_SIZE,
                    y = (y - 1) * TILE_SIZE,
                    width = 16,
                    height = 25,
                    
                    -- select random frame from bush_ids whitelist, then random row for variance
                    frame = 1,--BUSH_IDS[math.random(#BUSH_IDS)] + (math.random(4) - 1) * 7,
                    collidable = true,
                    hit = false,
                    solid = true,
                }
            )




        end


        
        -- for x in 1, 2 do
        --     table.insert(tiles[x],
        --         Tile(x, y, tileID, tileset))
        -- end

        -- -- lay out the empty space
        -- for x = width -1 , width do
        --     table.insert(tiles[x],
        --         Tile(x, y, tileID, tileset))
        -- end

         
    end

    print("MY WIDTH: ",width)
    print("MY WIDTH: ",height)

    local map = TileMap(width, height)
    map.tiles = tiles
    



    -- for i, v in next, map.tiles do
    --     print(i, v)
    --     for n, k in next, v do
    --         print(">", n, k)
    --     end
    -- end

    
    return GameLevel(entities, objects, map)
end
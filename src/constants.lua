
--WINDOW AND VIRTUALIZATION MANAGEMENT
RATIO_WIDTH = 9
RATIO_HEIGHT = 16 
RATIO_MULTIPLIER = 48
WINDOW_WIDTH = RATIO_WIDTH * RATIO_MULTIPLIER
WINDOW_HEIGHT = RATIO_HEIGHT * RATIO_MULTIPLIER
-- SIZE EMULATED
VIRTUAL_ZOOM = 1.5
VIRTUAL_WIDTH = WINDOW_WIDTH/VIRTUAL_ZOOM
VIRTUAL_HEIGHT = WINDOW_HEIGHT/VIRTUAL_ZOOM


--FLAG CONSTANTS
FLAG_SCROLL = -150
GAP_WIDTH = 80
FLAG_SPEED = 100
FLAG_WIDTH = 30
FLAG_HEIGHT = 30

--SKIER CONSTANTS
SKIER_SPEED = 250
SKIER_WIDTH = 30
SKIER_HEIGHT = 30
ACCELERATION_SPEED = 95

--COUNTDOWN STATE
COUNTDOWN_TIME = 0.75

--LEVEL MAKING CONSTANTS
TILE_SIZE = 16 --16px
-- width and height of screen in tiles
SCREEN_TILE_WIDTH = VIRTUAL_WIDTH / TILE_SIZE
SCREEN_TILE_HEIGHT = VIRTUAL_HEIGHT / TILE_SIZE

--TILE ID
TILE_ID_EMPTY = 1
TILE_ID_EDGE = 1

--TILES THAT TRIGGER A COLLISION
COLLIDABLE_TILES = {
    TITLE_ID_EDGE
}

-- number of tiles in each tile set
TILE_SET_WIDTH = 5
TILE_SET_HEIGHT = 4

-- number of tile sets in sheet
TILE_SETS_WIDE = 6
TILE_SETS_TALL = 10
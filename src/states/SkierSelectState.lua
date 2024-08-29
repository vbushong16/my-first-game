

SkierSelectState = Class{__includes = BaseState}

function SkierSelectState:enter(params)
    self.highScores = params.highScores
end

function SkierSelectState:init()
    self.currentSkier = 1
end

function SkierSelectState:update(dt)
    if love.keyboard.wasPressed('left') then
        if self.currentSkier == 1 then
        else
            self.currentSkier = self.currentSkier - 1
        end
    elseif love.keyboard.wasPressed('right') then
        if self.currentSkier == 4 then
        else
            self.currentSkier = self.currentSkier + 1
        end
    end

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then


        -- print("SELECT SKIER EXIT: ",self.currentSkier)

        gStateMachine: change('countdown',{
            skin = self.currentSkier,
            highScores = self.highScores

        })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function SkierSelectState:render()
    love.graphics.setFont(gFonts['mediumFont'])
    love.graphics.printf("Select your Skier with left and right", 0,VIRTUAL_HEIGHT/4, VIRTUAL_WIDTH,'center')
    love.graphics.printf("Press Enter to continue!", 0,VIRTUAL_HEIGHT/3, VIRTUAL_WIDTH,'center')

    if self.currentSkier == 1 then
        love.graphics.setColor(40/255,40/255,40/255,128/255)
    end

    love.graphics.draw(gTextures['arrows'],gFrames['arrows'][1],VIRTUAL_WIDTH/4-24, VIRTUAL_HEIGHT- VIRTUAL_HEIGHT/3)

    love.graphics.setColor(1,1,1,1)

    if self.currentSkier == 4 then
        love.graphics.setColor(40/255,40/255,40/255,128/255)
    end

    love.graphics.draw(gTextures['arrows'],gFrames['arrows'][2],VIRTUAL_WIDTH-VIRTUAL_WIDTH/4-24, VIRTUAL_HEIGHT- VIRTUAL_HEIGHT/3)

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(gTextures['skier'],gFrames['skiers'][self.currentSkier],VIRTUAL_WIDTH/2-32, VIRTUAL_HEIGHT- VIRTUAL_HEIGHT/3)


end


    
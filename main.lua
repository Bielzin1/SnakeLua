world = love.physics.newWorld(0, 10 * 64, true)

local snake = require("snake")
local map = require("map")
local win_Size = 700
local counter = 0

function love.load()
    love.window.setMode(win_Size, win_Size)
    --love.physics.setMeter(64) --64 pixel equal 1 meter in physics engine
    map.load(50, 50, win_Size)
    snake.load()
end

function love.update(dt)
    --world:update(dt)

    if love.keyboard.isDown("w") then
        snake.changeDir(0, -1)
    elseif love.keyboard.isDown("s") then
        snake.changeDir(0, 1)
    elseif love.keyboard.isDown("a") then
        snake.changeDir(-1, 0)
    elseif love.keyboard.isDown("d") then
        snake.changeDir(1, 0)
    end

    counter = counter + 1
    if counter % 10 == 0 then
        snake.tick(map)
    end
end

function love.draw()
    snake.draw(map)
    map.draw()
end

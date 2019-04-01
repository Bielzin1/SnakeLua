local snake = {}

local tail = require("tail")

--snake.x = 50
--snake.y = 50
--snake.w = 50
--snake.h = 50
snake.x = 1
snake.y = 0

snake.dir_x = 1
snake.dir_y = 0

snake.block = {}

function snake.load()
    tail.load(snake.x, snake.y, snake.dir_x, snake.dir_y)
end

function snake.changeDir(new_x, new_y)
    snake.dir_x = new_x
    snake.dir_y = new_y

    tail.addBend(snake.x, snake.y, snake.dir_x, snake.dir_y)
end

function snake.tick(map)
    old_x = snake.x
    old_y = snake.y

    snake.x = old_x + snake.dir_x
    snake.y = old_y + snake.dir_y

    --if map.matrix[snake.x][snake.y] == 1 then
    --    love.event.quit()
    --end
    
    tail.checkHeadCollision(snake.x,snake.y)

    if map.matrix[snake.x][snake.y] == 2 then
        map.matrix[snake.x][snake.y] = 0
        map.generateFruit()
        tail.append()
    end

    if snake.x > map.rows - 1 or snake.x < 0 then
        love.event.quit()
    end
    if snake.y > map.columns - 1 or snake.y < 0 then
        love.event.quit()
    end

    tail.update(map)
end

function snake.draw(map)
    love.graphics.rectangle("line", snake.x * map.cellSize, snake.y * map.cellSize, map.cellSize, map.cellSize)
    tail.draw(map)
end

return snake

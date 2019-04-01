local map = {}

map.matrix = {}

function map.load(rows, columns, win_size)
    map.cellSize = win_size / rows
    map.columns = columns
    map.rows = rows

    for i = 1, columns do
        map.matrix[i] = {}
        for j = 1, rows do
            map.matrix[i][j] = 0
        end
    end

    math.randomseed(os.time())
    map.generateFruit()
end

function map.generateFruit()
    map.fruit_x = math.random(0, map.columns - 1)
    map.fruit_y = math.random(0, map.rows - 1)
    map.matrix[map.fruit_x][map.fruit_y] = 2
end

function map.draw()
    love.graphics.circle(
        "line",
        map.fruit_x * map.cellSize + map.cellSize / 2,
        map.fruit_y * map.cellSize + map.cellSize / 2,
        map.cellSize / 2
    )
end

return map

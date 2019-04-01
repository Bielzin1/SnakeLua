local tail = {}

tail.body = {}
tail.bends = {}

function tail.addBend(x, y, dir_x, dir_y)
    table.insert(tail.bends, {x, y, dir_x, dir_y, false})
end

function tail.load(x, y, dir_x, dir_y)
    tail.add(x, y, dir_x, dir_y)
end

function tail.add(x, y, dir_x, dir_y)
    local new_x = x - dir_x
    local new_y = y - dir_y

    local current_dir_x = dir_x
    local current_dir_y = dir_y

    table.insert(tail.body, {new_x, new_y, current_dir_x, current_dir_y})
end

function tail.append()
    local last_index = table.getn(tail.body)
    local last_element = tail.body[last_index]
    tail.add(last_element[1], last_element[2], last_element[3], last_element[4])
end

function tail.checkUnusedBends()
    local to_remove = {}
    for i_bend, bend in ipairs(tail.bends) do
        if bend[5] == true then
            bend[5] = false
        else
            table.insert(to_remove, i_bend)
        end
    end

    for i_toRemove, toRemove in ipairs(to_remove) do
        table.remove(tail.bends, toRemove)
    end
end

function tail.update(map)
    for i_block, block in ipairs(tail.body) do
        local old_x = block[1]
        local old_y = block[2]

        --if old_x == 0 then
        --    map.matrix[old_x + 1][old_y] = 0
        --elseif old_y == 0 then
        --    map.matrix[old_x][old_y + 1] = 0
        --else
        --    map.matrix[old_x][old_y] = 0
        --end

        --if old_x == 0 and old_y == 0 then
        --    map.matrix[old_x + 1][old_y + 1] = 0
        --else
        --    map.matrix[old_x][old_y] = 0
        --end

        block[1] = old_x + block[3]
        block[2] = old_y + block[4]

        --map.matrix[block[1]][block[2]] = 1

        for i_bend, bend in ipairs(tail.bends) do
            if block[1] == bend[1] and block[2] == bend[2] then
                block[3] = bend[3]
                block[4] = bend[4]
                bend[5] = true
            end
        end
    end
    tail.checkUnusedBends()
end

function tail.draw(map)
    for index, value in ipairs(tail.body) do
        love.graphics.rectangle("line", value[1] * map.cellSize, value[2] * map.cellSize, map.cellSize, map.cellSize)
    end
end

function tail.checkHeadCollision(x, y)
    for i_block, block in ipairs(tail.body) do
        if block[1] == x and block[2] == y then
            love.event.quit()
        end
    end
end

return tail

function write(path, content)
    local file = io.open(path, 'r')
    if file then
        local flag = file:read("*a") == content
        file:close()
        if flag then
            print("up-to-date:", path)
            return
        end
    end

    print("write:", path)

    local file = io.open(path, "w")
    file:write(content)
    file:flush()
    file:close()
end

local function lookup(level, key)
    assert(key and #key > 0, key)
    for i = 1, 256 do
        local k, v = debug.getlocal(level, i)
        if k == key then
            return v
        elseif not k then
            break
        end
    end

    local info1 = debug.getinfo(level, 'Sn')
    local info2 = debug.getinfo(level + 1, 'Sn')
    if info1.source == info2.source or
        info1.short_src == info2.short_src then
        return lookup(level + 1, key)
    end
end

function trimlastlf(expr)
    return string.gsub(expr, '[ \n]*$', '')
end

function format(expr, trim, drop_last_lf)
    if trim then
        local indent = string.match(expr, '^[ ]*')
        expr = string.gsub(expr, '^[ ]*', '')
        expr = string.gsub(expr, '[\n\r]' .. indent, '\n')
    end
    if drop_last_lf then
        expr = trimlastlf(expr)
    end
    local function eval(expr)
        return string.gsub(expr, "([ ]*)(${?[%w_]+}?)", function (indent, str)
            local key = string.match(str, "[%w_]+")
            local level = 1
            local last_source
            while true do
                local info = debug.getinfo(level, 'S')
                if info then
                    if info.source == "=[C]" then
                        level = level + 1
                    else
                        last_source = last_source or info.source
                        if last_source ~= info.source then
                            break
                        else
                            level = level + 1
                        end
                    end
                else
                    break
                end
            end
            local value = lookup(level + 1, key) or _G[key]
            if value == nil then
                error("value not found for " .. key)
            else
                return indent .. string.gsub(tostring(value), '[\n\r]', '\n' .. indent)
            end
        end)
    end
    return eval(expr)
end

function format_snippet(expr)
    return format(expr, true, true)
end
M = {}

local function assert_equal(lhs, rhs)
    if lhs ~= rhs then
        local info = debug.getinfo(2, "Sl")
        print("assertion failed @ " .. info.short_src .. ":" .. info.currentline .. ": " .. lhs .. " is not equal to " .. rhs)
    end
end

local function assert(assertion)
    if not assertion then
        local info = debug.getinfo(2, "Sl")
        print("assertion failed @ " .. info.short_src .. ":" .. info.currentline)
    end
end

M.assert_equal = assert_equal
M.assert = assert

return M

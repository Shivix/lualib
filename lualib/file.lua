local M = {}

local core = require("lualib.core")

local function random_string(length)
    local chars = "abcdefghijklmnopqrstuvwxyz0123456789"
    local result = ""
    for _ = 1, length or 5 do
        local randIndex = math.random(1, #chars)
        result = result .. string.sub(chars, randIndex, randIndex)
    end
    return result
end

local function tmp_file(prefix, suffix)
    math.randomseed(os.time())
    local path = "/tmp/" .. (prefix or "lualib_") .. random_string() .. (suffix or "")

    local file = assert(io.open(path, "w+"))

    return setmetatable({ path = path, file = file, }, {
        __index = function(self, k)
            local f = rawget(self, "file")[k]
            if type(f) == "function" then
                return function(_, ...)
                    return f(self.file, ...)
                end
            else
                return f
            end
        end,
        __close = function(self)
            self.file:close()
            os.remove(path)
        end
    })
end

M.tmp_file = tmp_file
M.dir_exists = core.dir_exists

return M

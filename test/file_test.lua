package.path = package.path .. ";lualib/?.lua"

local file = require("file")
local ut = require("unittest")

local tmp_file_path
do
    local tmp_file <close> = file.tmp_file()

    os.execute("ls " .. tmp_file.path)
    tmp_file_path = tmp_file.path

    tmp_file:write("line1\n")
    tmp_file:write("line2\n")
    tmp_file:write("line3\n")
    tmp_file:flush()
    tmp_file:seek("set", 0)
    for line in tmp_file:lines() do
        print(line)
    end
end

os.execute("ls " .. tmp_file_path)

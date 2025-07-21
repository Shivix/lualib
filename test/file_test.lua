package.path = package.path .. ";lualib/?.lua"

local file = require("file")
local ut = require("unittest")

local tmp_file_path
do
    local tmp_file <close> = file.tmp_file()

    local f <close> = io.open(tmp_file.path, "r")
    ut.assert(f)
    assert(f):close()
    tmp_file_path = tmp_file.path

    tmp_file:write("line1\n")
    tmp_file:write("line2\n")
    tmp_file:write("line3\n")
    tmp_file:flush()
    tmp_file:seek("set", 0)
    local lines = tmp_file:lines()
    ut.assert(lines() == "line1")
    ut.assert(lines() == "line2")
    ut.assert(lines() == "line3")
end

local f <close> = io.open(tmp_file_path, "r")
ut.assert(not f)

ut.assert(file.dir_exists("test"))
ut.assert(not file.dir_exists("doesnotexists"))

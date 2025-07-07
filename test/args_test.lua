package.path = package.path .. ";lualib/?.lua"

local parse_args = require("args").parse_args
local generate_completion = require("args").generate_completion
local generate_usage = require("args").generate_usage
local ut = require("unittest")

local test_opts = {
    {
        long = "help",
        short = "h",
    },
    {
        long = "version",
        short = "v",
        description = "Print the version",
    },
    {
        long = "value",
        value = true,
    },
    {
        long = "value2",
        value = true,
        description = "Give a value",
    },
    {
        long = "verylongnamehere",
        value = true,
        description = "Testing the aligning on long names",
    },
    {
        long = "test",
    },
}

arg = {"arg1", "--help", "--value=5", "--value2", "50", "--test"}
local opts, args = parse_args(test_opts)

print(opts.test)
ut.assert_equal(#args, 1)
ut.assert_equal(args[1], "arg1")

ut.assert(opts.help)
ut.assert(not opts.version)
ut.assert(opts.test)
ut.assert_equal(opts.value, "5")
ut.assert_equal(opts.value2, "50")

generate_completion("test_cmd", test_opts)

local version = "1.0.0"
local usage = "test_cmd " .. version .. [[

An example usage for a test_cmd

Usage:
    test_cmd [Command] [Options]

]] .. generate_usage(test_opts) .. [[

https://github.com/Shivix/lualib.lua]]
print(usage)

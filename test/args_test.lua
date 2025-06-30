package.path = package.path .. ";lualib/?.lua"

local parse_args = require("args").parse_args
local ut = require("unittest")

local test_opts = {
    help = {
        short = "h",
    },
    version = {
        short = "v",
    },
    value = {
        value = true,
    },
    value2 = {
        value = true,
    },
    test = { },
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

local M = {}

local function get_opt(arg_name, defined_opts)
    for long, opt in pairs(defined_opts) do
        if arg_name == long or arg_name == opt.short then
            opt.long = long
            return opt
        end
    end
    return nil
end

local function parse_args(defined_opts)
    local parsedArgs = {}
    local opts = {}
    local i = 1
    while i <= #arg do
        local current_arg = arg[i]
        local arg_name = current_arg:match("^%-%-?([^=]*)")
        if arg_name ~= nil then
            local opt = get_opt(arg_name, defined_opts)
            if opt == nil then
                io.stderr:write("Invalid option: " .. arg_name .. "\n")
                os.exit(1)
            end
            if opt.value then
                local value = current_arg:match("^%-%-?.-=(.*)$")
                if value == nil then
                    value = arg[i + 1]
                    if value == nil or value:sub(1, 1) == "-" then
                        io.stderr:write("Value expected for option: " .. arg_name .. "\n")
                        os.exit(1)
                    end
                    i = i + 1
                end
                opts[opt.long] = value
            else
                opts[opt.long] = true
            end
        else
            table.insert(parsedArgs, current_arg)
        end

        i = i + 1
    end
    return opts, parsedArgs
end

M.parse_args = parse_args

return M

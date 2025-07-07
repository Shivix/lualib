local M = {}

local function get_opt(arg_name, defined_opts)
    for _, opt in ipairs(defined_opts) do
        if arg_name == opt.long or arg_name == opt.short then
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

local function generate_completion(cmd_name, defined_opts)
    for _, opt in ipairs(defined_opts) do
        local short = opt.short and "-s " .. opt.short or ""
        local value = opt.value and "-r" or ""
        local description = opt.description and "-d " .. opt.description or ""
        print(string.format("complete -c %s -l %s %s %s '%s'", cmd_name, opt.long, short, value, description))
    end
end

local function generate_usage(defined_opts)
    local max_length = 0
    for _, opt in ipairs(defined_opts) do
        if #opt.long > max_length then
            max_length = #opt.long
        end
    end
    -- Plus two for the added "--"
    max_length = max_length + 2
    local result = "Options:\n"
    --TODO: short
    for _, opt in ipairs(defined_opts) do
        local short = opt.short and ("-" .. opt.short .. ",") or "   "
        result = result .. string.format("    %s %-"..max_length.."s %s\n", short, "--" .. opt.long, opt.description or "")
    end
    return result
end

M.parse_args = parse_args
M.generate_completion = generate_completion
M.generate_usage = generate_usage

return M

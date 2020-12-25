-- Provides:
-- evil::network
--      internet_available (boolean)

local awful = require("awful")

local update_interval = 15
local conn_script = [[
    sh -c "ping -q -c 1 -W 1 google.com > /dev/null; echo $?"
]]

local status = 0

-- Periodically check for network connectivity
awful.widget.watch(conn_script, update_interval, function (widget, stdout)
    if status ~= stdout then
        status = stdout
        awesome.emit_signal("evil::network", tonumber(stdout))
    end
end)

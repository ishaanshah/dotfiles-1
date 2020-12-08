local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

-- Set colors
local title_color =  beautiful.mpd_song_title_color or beautiful.wibar_fg
local artist_color = beautiful.mpd_song_artist_color or beautiful.wibar_fg
local paused_color = beautiful.mpd_song_paused_color or beautiful.normal_fg

-- Declare widgets
local spotify_artist = wibox.widget{
    -- Artist widget
    align = "center",
    valign = "center",
    text = "---",
    font = "sans 10",
    widget = wibox.widget.textbox
}
local spotify_title = wibox.widget{
    -- Title widget
    align = "center",
    valign = "center",
    text = "---",
    font = "sans 14",
    widget = wibox.widget.textbox
}

-- Main widget that includes all others
local spotify_widget = wibox.widget {
    spotify_artist,
    spotify_title,
    spacing = 2,
    layout = wibox.layout.fixed.vertical
}

local artist_fg
local artist_bg
-- Subcribe to spotify updates
awesome.connect_signal("evil::spotify", function(artist, title, status)
    if status == "paused" then
        artist_fg = paused_color
        title_fg = paused_color
    else
        artist_fg = artist_color
        title_fg = title_color
    end

    -- Escape &'s
    title = string.gsub(title, "&", "&amp;")
    artist = string.gsub(artist, "&", "&amp;")

    spotify_title.markup =
        "<span foreground='" .. title_fg .."'>"
        .. title .. "</span>"
    spotify_artist.markup =
        "<span foreground='" .. artist_fg .."'>"
        .. artist .. "</span>"
end)

return spotify_widget

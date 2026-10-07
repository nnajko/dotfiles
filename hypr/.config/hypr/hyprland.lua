-- Migrated from hyprland.conf for Hyprland 0.55 (hyprlang -> lua).
-- Old config kept at hyprland.conf.pre-lua-backup.

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "desc:AOC 24G2W1G4 AWBM61A007191", mode = "1920x1080@144", position = "0x0", scale = 1 })
hl.monitor({ output = "desc:Dell Inc. DELL U2414H 292K46CJ2AEL", mode = "1920x1080@60", position = "1920x0", scale = 1 })

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "rofi -show drun"
local shell = "/bin/zsh"

-----------------
---- PLUGINS ----
-----------------

-- Load plugins synchronously at parse time so their keywords/config blocks and
-- window rules resolve immediately. This replaces "hyprpm reload" in autostart,
-- which loaded asynchronously *after* the config was parsed and caused a
-- transient "unknown hyprbars keyword" error overlay on cold start.
-- Paths are hyprpm's build cache; they are stable across plugin rebuilds.
local hyprpm = "/var/cache/hyprpm/" .. os.getenv("USER")
hl.plugin.load(hyprpm .. "/split-monitor-workspaces/split-monitor-workspaces.so")
--hl.plugin.load(hyprpm .. "/hyprland-plugins/hyprbars.so")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- hyprlock")
	hl.exec_cmd("uwsm app -- hypridle")
	hl.exec_cmd("uwsm app -- swaybg -i ~/.config/backgrounds/background-2.png -m fill")
	hl.exec_cmd("uwsm app -- waybar")
	hl.exec_cmd("uwsm app -- swaync")
	hl.exec_cmd("uwsm app -- hyprsunset")
	hl.exec_cmd("uwsm app -- swayosd-server")
	hl.exec_cmd("uwsm app -- wl-paste --type text --watch cliphist store")
	hl.exec_cmd("uwsm app -- wl-paste --type image --watch cliphist store")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- env vars moved to ~/.config/uwsm/env

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 8,
		border_size = 2,
		col = {
			-- Catppuccin Mocha: sapphire -> mauve
			active_border = { colors = { "rgba(74c7ecff)", "rgba(cba6f7ff)" }, angle = 45 },
			inactive_border = "rgba(45475aaa)",
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		dim_inactive = true,
		dim_strength = 0.08,
		shadow = {
			enabled = true,
			range = 20,
			render_power = 3,
			offset = "0 4",
			color = "rgba(11111b99)",
			color_inactive = "rgba(11111b55)",
		},
		blur = {
			enabled = true,
			size = 6,
			passes = 3,
			noise = 0.02,
			contrast = 1.0,
			vibrancy = 0.2,
			popups = true,
		},
	},

	animations = { enabled = true },

	dwindle = {
		preserve_split = true,
	},

	master = { new_status = "master" },

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		animate_manual_resizes = true,
		vrr = 2,
	},

	input = {
		kb_layout = "se",
		kb_variant = "nodeadkeys",
		kb_model = "",
		kb_options = "ctrl:nocaps",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		numlock_by_default = true,
		touchpad = { natural_scroll = false },
	},
})

-- Curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("softBounce", { type = "bezier", points = { { 0.34, 1.3 }, { 0.64, 1 } } })
hl.curve("smoothOut", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } })
hl.curve("glide", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })

-- Animations
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "easeOutQuint" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "almostLinear", style = "once" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.5, bezier = "glide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "softBounce", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "smoothOut", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "glide", style = "slide" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 4, bezier = "almostLinear" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.5, bezier = "glide" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.5, bezier = "glide", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "glide", style = "slidefade 15%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "glide", style = "slidevert" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Frosted glass behind rofi and swaync; ignore_alpha keeps blur off their
-- fully transparent margins.
hl.layer_rule({ name = "blur-rofi", match = { namespace = "^(rofi)$" }, blur = true, ignore_alpha = 0.3, animation = "popin 90%" })
hl.layer_rule({ name = "blur-swaync", match = { namespace = "^(swaync-.*)$" }, blur = true, ignore_alpha = 0.3 })
hl.layer_rule({ name = "blur-swayosd", match = { namespace = "^(swayosd)$" }, blur = true, ignore_alpha = 0.3, animation = "fade" })
hl.layer_rule({ name = "swaync-slide", match = { namespace = "^(swaync-control-center)$" }, animation = "slide right" })

---------------------
---- GESTURES & PLUGINS
---------------------

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

--split-monitor-workspaces plugin config (note: key uses underscores in Lua mode)
hl.config({
	plugin = {
		split_monitor_workspaces = {
			count = 4,
			keep_focused = 0,
			enable_notifications = 0,
			enable_persistent_workspaces = 1,
		},
		--		hyprbars = {
		--			bar_height = 20,
		--			bar_text_size = 11,
		--			bar_title_enabled = true,
		--			bar_part_of_window = true,
		--			bar_color = "rgba(282828dd)",
		--			["col.text"] = "rgba(ebdbb2ee)",
		--		},
	},
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -r | satty --filename -"))
hl.bind(mainMod .. " + SHIFT + escape", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox --new-window"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(terminal .. " -e " .. shell .. " -c htop"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd('firefox --new-window "https://gemini.google.com/app"'))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd('firefox --new-window "https://claude.ai"'))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd('firefox --new-window "https://mail.google.com"'))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd('firefox --new-window "https://www.youtube.com"'))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("rofi -show calc -no-show-match -no-sort"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(terminal .. " -e " .. shell .. " -c lazydocker"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/scripts/waybar_restart.sh"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.config/scripts/shutdown.sh"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen_state({ internal = 1, client = -1, action = "toggle" }))
hl.bind(
	mainMod .. " + SHIFT + V",
	hl.dsp.exec_cmd(
		"if systemctl is-active --quiet mullvad-daemon.service; then pkill -f mullvad-vpn; systemctl stop mullvad-daemon.service; else systemctl start mullvad-daemon.service && mullvad-vpn &>/dev/null & fi"
	)
)
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -p clipboard | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratch"))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("~/.local/bin/frigate-notify-toggle.sh"))

-- Game mode: strip eye candy for max FPS / lowest latency. hyprctl reload restores it.
local gameMode = false
hl.bind(mainMod .. " + G", function()
	gameMode = not gameMode
	local on = not gameMode
	hl.config({
		animations = { enabled = on },
		general = { gaps_in = on and 5 or 0, gaps_out = on and 8 or 0, border_size = on and 2 or 1 },
		decoration = {
			rounding = on and 10 or 0,
			dim_inactive = on,
			shadow = { enabled = on },
			blur = { enabled = on },
		},
	})
	hl.exec_cmd("notify-send -t 1500 -a hyprland 'Game mode " .. (gameMode and "on" or "off") .. "'")
end)

-- Focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Workspace switching via split-monitor-workspaces plugin
local smw = hl.plugin.split_monitor_workspaces
for i = 1, 4 do
	hl.bind(mainMod .. " + " .. i, function()
		return smw.workspace(i)
	end)
	hl.bind(mainMod .. " + SHIFT + " .. i, function()
		return smw.move_to_workspace_silent(i)
	end)
end

-- Move window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Resize submap
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	hl.bind("L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
	hl.bind("H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
	hl.bind("Return", hl.dsp.submap("reset"))
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Mouse drag/resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys (locked = works while lockscreen active)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -5"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume +5"), { locked = true, repeating = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
	name = "float-ghostty-float",
	match = { class = "^(com.ghostty.float)$" },
	float = true,
})

-- hyprbars: disable bar globally, then re-enable for zame
--hl.window_rule({
--	name = "hyprbars-default-off",
--	match = { class = ".*" },
--	["hyprbars:no_bar"] = true,
--})

--hl.window_rule({
--	name = "hyprbars-enable-zame",
--	match = { class = "^(zame)$" },
--	["hyprbars:no_bar"] = false,
--})

hl.workspace_rule({
	workspace = "special:scratch",
	on_created_empty = "uwsm app -- " .. terminal .. " --class=com.ghostty.scratch",
	gaps_out = 60,
})

hl.window_rule({
	name = "float-calcurse",
	match = { title = "^(calcurse-float)$" },
	float = true,
})

-- Kanata (MapleStory) runs inside a Wine virtual desktop, which appears as a
-- single explorer.exe window. Launch it with ~/.local/bin/kanata.
-- The virtual desktop is sized from resolution.ini. Let it tile like any other
-- window -- not floating, not fullscreen.
hl.window_rule({
	name = "kanata-vdesktop",
	match = { class = "^(explorer\\.exe)$", title = "^(Kanata - Wine Desktop)$" },
	tile = true,
})

-- MapleRoyals (Wine/XWayland) restores a saved window position and lands at
-- -1920,26 every launch -- off screen. XWayland orders the outputs opposite to
-- Hyprland (xrandr: HDMI-A-3 at +0+0, DP-3 at +1920+0), so the restored
-- coordinate doesn't survive the translation.
hl.window_rule({
	name = "mapleroyals-center",
	match = { class = "^(mapleroyals\\.exe)$" },
	float = true,
	center = true,
})

-- The rule above isn't enough: the client repositions itself after mapping and
-- wins the race. Keep re-centering for the first two seconds.
hl.on("window.open", function(win)
	if win.class ~= "mapleroyals.exe" then
		return
	end
	local addr = win.address
	local tries = 0
	local timer
	timer = hl.timer(function()
		tries = tries + 1
		local w = hl.get_window("address:" .. addr)
		if w then
			hl.dispatch(hl.dsp.window.center({ window = "address:" .. addr }))
		end
		if not w or tries >= 8 then
			timer:set_enabled(false)
		end
	end, { timeout = 250, type = "repeat" })
end)

hl.window_rule({
	name = "float-pip",
	match = { pin = true, title = "^(Picture-in-Picture)$" },
	float = true,
})

hl.window_rule({
	name = "suppress-maximize",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland (was no_initial_focus in old config)
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

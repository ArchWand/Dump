local wired = require "api"
local a = wired.anchor

return {
    -- Maximum number of notifications to show at any one time.
    -- A value of 0 means that there is no limit.
    max_notifications = 0,

    -- The default timeout, in miliseconds, for notifications that don't have an initial timeout set.
    -- 1000ms = 1s.
    timeout = 10000,

    -- How should we handle `expire_timeout` values of zero?
    -- `UseDefault`: use `timeout`.
    -- `NeverExpire`: show this notification forever.
    -- The latter is technically correct according to the notification spec: https://specifications.freedesktop.org/notification-spec/notification-spec-latest.html
    zero_timeout_behavior = "NeverExpire",

    -- `poll_interval` decides decides how often (in milliseconds) Wired checks events,
    -- draws notifications (if necessary) -- the update loop while any notification is present.
    -- Note that when no notifications are present, Wired polls at `idle_poll_interval` instead.
    -- 16ms ~= 60hz / 7ms ~= 144hz.
    poll_interval = 16,

    -- The interval at which wired updates when no notifications/windows are present.
    --idle_poll_interval = 500,

    -- Wired will pause notifications if you are idle (no mouse or keyboard input) for longer than
    -- `idle_threshold` seconds.
    -- Note that notifications will not be automatically unpaused on wake, and will need to be manually
    -- cleared, unless `unpause_on_input` is set to true.
    -- Also note that no distinction is made between manually paused and idle paused notifications.
    -- If `idle_threshold` is not specified, the behavior will be disabled entirely.
    --idle_threshold = 3600,

    -- Notifications will spawn paused, and have to be manually unpaused or cleared by the user,
    -- unless `unpause_on_input` is also set.
    --notifications_spawn_paused = false,

    -- Unpause notifications when we receive any input after being idle for longer than 1 second.
    -- Note that no distinction is made between manually paused notifications and idle paused/spawned notifications.
    --unpause_on_input = false,

    -- Enable/disable replacement functionality.
    -- If this is disabled, replacement requests will just send a new notification.
    -- E.g., with replacing_enabled = true, Pidgin will only show the latest message from each contact,
    -- instead of sending a new one for each message.
    -- Default: true
    --replacing_enabled = true,

    -- Whether a notification should reset its timeout when it is replaced.
    -- No effect if replacing_enabled is set to false.
    -- Default: false
    --replacing_resets_timeout = false,

    -- Some apps/programs close notifications on their own by sending a request to dbus.
    -- Sometimes this is not desired.
    -- Default: true
    --closing_enabled = true,

    -- How many notifications are kept in history.
    -- Each notification is roughly 256 bytes (excluding buffers!), so there's some math to do here.
    -- Default: 100
    --history_length = 100,

    -- When a `NotificationBlock` has monitor: -1 (i.e. should follow active monitor), then what input
    -- should we use to determine the active monitor?
    -- Options: "Mouse", "Window"
    -- Default: "Mouse"
    --focus_follows = "Mouse",

    -- Enable printing notification data to a file.
    -- Useful for scripting purposes.
    -- The data is written as JSON.
    -- Default: None
    --print_to_file = "/tmp/wired.log",

    -- Minimum window width and height.  This is used to create the base rect that the notification
    -- grows within.
    -- The notification window will never be smaller than this.
    -- A value of 1 means that the window will generally always resize with notification, unless
    -- you have a 1x1 pixel notification...
    -- Generally, you shouldn't need to set this.
    --min_window_width = 1,
    --min_window_height = 1,

    -- Trim whitespace in received notification text, since some clients like to send whitespace, which we usually don't actually want.
    --trim_whitespace = true,

    -- Enable/disable debug rendering.
    debug = false,
    debug_color = { r = 0.0, g = 1.0, b = 0.0, a = 1.0 }, -- Primary color for debug rectangles.
    debug_color_alt = { r = 1.0, g = 0.0, b = 0.0, a = 1.0 }, -- Secondary color for debug rectangles.

    -- layout_blocks = {
    --     -- Layout 1, when an image is present.
    --     root = {
    --         parent = "",
    --         hook = { parent_anchor = TL, self_anchor = TL },
    --         offset = { x = 7.0, y = 7.0 },
    --         --render_criteria = [HintImage],
    --         -- https://github.com/Toqozz/wired-notify/wiki/NotificationBlock
    --         -- params = NotificationBlock {
    --         --     monitor = 0,
    --         --     border_width = 3.0,
    --         --     border_rounding = 3.0,
    --         --     --background_color = Color(r = 0.15686, g = 0.15686, b = --0.15686, a = 1.0),
    --         --     background_color = Color(hex = "#282828"),
    --         --     border_color = Color(hex = "#ebdbb2"),
    --         --     border_color_low = Color(hex = "#282828"),
    --         --     border_color_critical = Color(hex = "#fb4934"),
    --         --     border_color_paused = Color(hex = "#fabd2f"),
    --         --
    --         --     gap = { x = 0.0, y = 8.0 },
    --         --     notification_hook = { parent_anchor = BL, self_anchor = TL },
    --         -- )),
    --     },
    --
    --     {
    --         name = "image",
    --         parent = "root",
    --         hook = { parent_anchor = TL, self_anchor = TL },
    --         offset = { x = 0.0, y = 0.0 },
    --         -- https://github.com/Toqozz/wired-notify/wiki/ImageBlock
    --         -- params = ImageBlock((
    --         --     image_type = Hint,
    --         --     -- We actually want 4px padding, but the border is 3px.
    --         --     padding = Padding(left = 7.0, right = 0.0, top = 7.0, bottom = 7.0),
    --         --     rounding = 3.0,
    --         --     scale_width = 48,
    --         --     scale_height = 48,
    --         --     filter_mode = Lanczos3,
    --         -- )),
    --     },
    --
    --     {
    --         name = "summary",
    --         parent = "image",
    --         hook = { parent_anchor = MR, self_anchor = BL },
    --         offset = { x = 0.0, y = 0.0 },
    --         -- https://github.com/Toqozz/wired-notify/wiki/TextBlock
    --         -- params = TextBlock((
    --         --     text = "%s",
    --         --     font = "Arial Bold 11",
    --         --     ellipsize = Middle,
    --         --     color = Color(hex = "#ebdbb2"),
    --         --     color_hovered = Color(hex = "#fbf1c7"),
    --         --     padding = Padding(left = 7.0, right = 7.0, top = 7.0, bottom = 0.0),
    --         --     dimensions = (width = (min = 50, max = 150), height = (min = 0, max = 0)),
    --         -- )),
    --     },
    --
    --     {
    --         name = "body",
    --         parent = "summary",
    --         hook = { parent_anchor = BL, self_anchor = TL },
    --         offset = { x = 0.0, y = -3.0 },
    --         -- https://github.com/Toqozz/wired-notify/wiki/ScrollingTextBlock
    --         -- params = ScrollingTextBlock((
    --         --     text = "%b",
    --         --     font = "Arial 11",
    --         --     color = Color(hex = "#ebdbb2"),
    --         --     color_hovered = Color(hex = "#fbf1c7"),
    --         --     padding = Padding(left = 7.0, right = 7.0, top = 3.0, bottom = 7.0),
    --         --     width = (min = 150, max = 250),
    --         --     scroll_speed = 0.1,
    --         --     lhs_dist = 35.0,
    --         --     rhs_dist = 35.0,
    --         --     scroll_t = 1.0,
    --         -- )),
    --     },
    -- },

    -- https://github.com/Toqozz/wired-notify/wiki/Shortcuts
    shortcuts = {
        notification_interact = 1,
        notification_close = 2,
        -- notification_closeall = 99,
        -- notification_pause = 99,

        notification_action1 = 3,
        -- notification_action2 = 99,
        -- notification_action3 = 99,
        -- notification_action4 = 99,
    },
}

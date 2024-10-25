
--       local wezterm = require 'wezterm'
--       local act = wezterm.action

-- return {
--   entry = function()
--     local h = cx.active.current.hovered
--     if h.cha.is_dir then
--       ya.manager_emit('enter' or 'open', { hovered = true })
--     else
--       local file_path = tostring(h.url)
--       -- Escape double quotes in the file path
--       local escaped_file_path = file_path:gsub('"', '\\"')

--       print(file_path)

--       local pre_command = ':'
--       local command = 'open ' .. file_path

--       wezterm.action_callback(function(window, pane)
--         window:perform_action(act.ActivatePaneDirection 'Right', pane)
--       end)
--     end
--   end,
-- }


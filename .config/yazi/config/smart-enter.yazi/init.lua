return {
  entry = function()
    local h = cx.active.current.hovered
    if h.cha.is_dir then
      ya.manager_emit('enter' or 'open', { hovered = true })
    else
      local file_path = tostring(h.url)
      -- Escape double quotes in the file path
      local escaped_file_path = file_path:gsub('"', '\\"')

      -- Construct the command to send the text
      local send_text_command = string.format(
        'powershell -Command "wezterm cli send-text --pane-id $(wezterm cli get-pane-direction Right) \':open %s\'"',
        escaped_file_path
      )

      -- Get the list of all panes
      -- local panes_handle = io.popen('powershell -Command "wezterm cli list-panes"')
      -- local panes_output = panes_handle:read("*a")
      -- panes_handle:close()

      -- Find the pane that contains hx.exe
      -- local pane_id = nil
      -- for pane in panes_output:gmatch("(%b{})") do
      --   if pane:find("hx.exe") then
      --     pane_id = pane:match('"pane_id":"([^"]+)"')
      --     break
      --   end
      -- end

      -- if pane_id then
        -- Focus the pane that contains hx.exe
        -- os.execute(string.format('powershell -Command "wezterm cli activate-pane --pane-id %s"', pane_id))

        os.execute('powershell -Command "wezterm cli activate-pane --pane-id $(wezterm cli get-pane-direction Right)"')
        
        -- Execute the send-text command
        os.execute(send_text_command)

        -- Execute the sendkeys command if necessary
        local pid_handle = io.popen('powershell -Command "Write-Output (Get-Process -Name \"hx.exe\").Id[0]"')
        local pid = pid_handle:read("*a"):gsub("%s+", "")
        pid_handle:close()
        local send_enter_command = string.format("sendkeys -pid:%s 'format C:{Enter}'", pid)
        os.execute(send_enter_command)
      -- else
      --   -- Handle the case where hx.exe is not found
      --   print("hx.exe not found in any pane.")
      -- end
    end

    -- Optionally, you might want to activate the pane again if needed
    os.execute('powershell -Command "wezterm cli activate-pane --pane-id $(wezterm cli get-pane-direction Right)"')
  end,
}


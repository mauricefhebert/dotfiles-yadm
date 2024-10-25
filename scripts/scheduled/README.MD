
# Automated Dotfiles Update

This setup automates the daily export of packages, commits changes to your dotfiles repository, and pushes the updates. The script works cross-platform on both **Windows** and **Arch Linux**.

## Script: `daily_update.sh`

Place this script in your home directory or another appropriate location.

```bash
#!/bin/bash

# Function to get the current date and time
get_datetime() {
    date '+%Y-%m-%d %H:%M:%S'
}

# Run the export packages script
~/export_packages.sh

# Git config command alias (cross-platform)
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Stage changes in the ~/temp directory
config add ~/temp/*

# Stage any other changes in the repository
config add .

# Commit changes with a timestamp
datetime=$(get_datetime)
config commit -m "dotfiles updated $datetime"

# Push changes to the remote repository
config push


```markdown
## Instructions for Scheduling the Script

### 1. Arch Linux (using `cron`)

1. **Make the script executable:**
   ```bash
   chmod +x ~/daily_update.sh
   ```

2. **Edit the cron jobs for your user:**
   ```bash
   crontab -e
   ```

3. **Add the following line to run the script daily at 4 PM:**
   ```bash
   0 16 * * * ~/daily_update.sh
   ```
   This sets up the script to run every day at 4 PM. Make sure `cron` is enabled and running:
   ```bash
   sudo systemctl enable cronie
   sudo systemctl start cronie
   ```

### 2. Windows (Git Bash with Task Scheduler)

1. **Make the script executable (if needed):**
   ```bash
   chmod +x ~/daily_update.sh
   ```

2. **Open Task Scheduler**:
   - Press `Win + R`, type `taskschd.msc`, and hit Enter.

3. **Create a New Task**:
   - Click **Action** > **Create Task**.
   - Name the task (e.g., `Daily Dotfiles Update`).

4. **Set the Trigger**:
   - Go to the **Triggers** tab and click **New**.
   - Set it to run **Daily** at **4:00 PM**.

5. **Set the Action**:
   - Go to the **Actions** tab and click **New**.
   - Set the action to **Start a program**.
   - In the **Program/script** field, enter the path to `bash.exe` (usually located at `C:\Program Files\Git\bin\bash.exe` or similar).
   - In the **Add arguments (optional)** field, enter the path to the script:
     ```bash
     ~/daily_update.sh
     ```

6. **Set Additional Options** (optional):
   - In the **Conditions** tab, ensure the task is allowed to run if the computer is on battery power if you’re on a laptop.
   - In the **Settings** tab, you can allow the task to restart if it fails.

7. **Save the Task** and ensure it runs correctly.
```

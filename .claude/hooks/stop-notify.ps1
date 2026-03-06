# Non-blocking Windows notification when Claude finishes a turn
# Uses Start-Process pattern to avoid blocking the hook
Start-Process powershell -ArgumentList '-Command [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") > $null; [System.Windows.Forms.MessageBox]::Show("Claude has finished and needs your attention", "Claude Code", "OK", "Information") > $null' -WindowStyle Hidden

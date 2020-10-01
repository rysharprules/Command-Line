echo "Hello and welcome to... "

$Host.UI.RawUI.WindowTitle = "Ryan's PowerShell!"
$MaximumHistoryCount = 1024

$t = @"
  _____                   _    	   _____ 		       _____ _          _ _ 
 |  __ \                 ( )      |  __ \                     / ____| |        | | |
 | |__) |   _  __ _ _ __ |/ ___   | |__) |____      _____ _ __ (___ | |__   ___| | |
 |  _  / | | |/ _`  | '_ \  / __|  |  ___/ _ \ \ /\ / / _ \ '__\___ \| '_ \ / _ \ | |
 | | \ \ |_| | (_| | | | | \__ \  | |  | (_) \ V  V /  __/ |  ____) | | | |  __/ | |
 |_|  \_\__, |\__,_|_| |_| |___/  |_|   \___/ \_/\_/ \___|_| |_____/|_| |_|\___|_|_|
         __/ |                                                                     
        |___/                                                                      

"@

for ($i=0;$i -lt $t.length;$i++) {
if ($i%2) {
 $c = "red"
}
elseif ($i%5) {
 $c = "yellow"
}
elseif ($i%7) {
 $c = "green"
}
else {
   $c = "white"
}
write-host $t[$i] -NoNewline -ForegroundColor $c
}

# Dracula readline configuration. Requires version 2.0, if you have 1.2 convert to `Set-PSReadlineOption -TokenType`
Set-PSReadlineOption -Color @{
    "Command" = [ConsoleColor]::Green
    "Parameter" = [ConsoleColor]::Gray
    "Operator" = [ConsoleColor]::Magenta
    "Variable" = [ConsoleColor]::White
    "String" = [ConsoleColor]::Yellow
    "Number" = [ConsoleColor]::Blue
    "Type" = [ConsoleColor]::Cyan
    "Comment" = [ConsoleColor]::DarkCyan
}
# Dracula Prompt Configuration
Import-Module posh-git
$GitPromptSettings.DefaultPromptPrefix.Text = "$([char]0x2192) " # arrow unicode symbol
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green
$GitPromptSettings.DefaultPromptPath.ForegroundColor =[ConsoleColor]::Cyan
$GitPromptSettings.DefaultPromptSuffix.Text = "$([char]0x203A) " # chevron unicode symbol
$GitPromptSettings.DefaultPromptSuffix.ForegroundColor = [ConsoleColor]::Magenta
# Dracula Git Status Configuration
$GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.AfterStatus.ForegroundColor = [ConsoleColor]::Blue

# run ps as admin
function admin { start-process PowerShell -verb runas }

# useful shortcuts for traversing directories
function cd...  { cd ..\.. }
function cd.... { cd ..\..\.. }

function projects { cd 'C:\projects\' }

# launch explorer in current folder
function e { ii . }

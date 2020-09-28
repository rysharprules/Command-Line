# Shell Commands

## Shells

### Bourne Shell (`sh`)

Shells derived from the Bourne shell include the Korn shell (`ksh`), `bash` and `zsh`.

### Bash

Bash stands for Bourne Again SHell.

### Z-Shell (`zsh`)

Is another popular, modern Bourne-family shell on Linux and Mac operating systems. As of Mac OS 10.15 (Catalina), `zsh` is the default shell on Apple Macs.

More info on [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh).

### Command prompt (`cmd.exe`)

Based on the `COMMAND.COM` shell found on `MS-DOS`. `cmd.exe` can run as an interactive command line session or used to execute scripts known as "batch files" (with the file extension `.bat`)

### PowerShell

Is available in two flavours:

1. Windows PowerShell, is distributed as part of Windows and is based on the .NET Framework
1. PowerShell Core based on .NET Core

Files are saved in `.ps1` format.

PowerShell takes an object-oriented approach to scripting, and works using 'cmdlets' - verb-noun pair that describe an action being performed.

Download [PowerShell Core from github](https://github.com/PowerShell/PowerShell) on Mac or Linux.

See [learning-powershell](https://github.com/PowerShell/PowerShell/blob/master/docs/learning-powershell/README.md) for more info.

## Common tasks

For all these tasks the operation will be shown in `bash` and PowerShell. Other UNIX shells will operate identically to `bash`.

### Manage directories and files

#### Change directory

Bash:
````
cd ./subdirectory
````
Powershell (these do the same thing):
````
$ Set-Location -Path ./subdirectory
$ Set-Location ./subdirectory
$ cd ./subdirectory
````

#### Current directory

Bash (print working directory):
````
pwd 
/Users
````
`pwd` returns a string.

Powershell
````
Path
----
/Users
````
`Get-Location` returns an object of type `System.Management.Automation.PathInfo`

##### Make directory

Bash:
````
mkdir new_directory
````
Powershell:
````
New-Item -Path new_directory -Type Directory
Directory: /Users/demo
Mode LastWriteTime Length Name
---- ------------- ------ ----
d---- 15/01/2020 13:11 new_directory
````

#### Remove directory/files

Bash:
By default `rm` will only remove a file. To remove a directory you'll need the to set the recursive flag (`-r`). For added safely, you can run `rm` with the `-i` flag. This will prompt the user for confirmation of each deletion.
````
rm -r new_directory
rm my_file.txt
````
Powershell:
````
Remove-Item -Path new_directory
Remove-Item -Path my_file.txt
````

#### Create files

Bash:
````
touch my_file.txt
````

Powershell:
````
New-Item -Path my_file.txt -Type File
````

### Handling files

#### Read content

Bash:
Either of the commands below will read out the entire contents of a file and print it to your terminal.
````
cat my_file.txt
< my_file.txt

less my_file.txt # You can use pager programs such as less to efficiently search through larger files.
````

PowerShell:
````
Get-Content my_file.txt # Prints all file content
Get-Content my_file.txt | Out-Host -Paging # Page the output
````

#### Editing

##### Nano (UNIX-like systems)

````
nano <file_path>
````
Nano Lists context-dependent keyboard shortcuts at the bottom and fills the rest of your terminal window with editor space.

###### Vi/Vim

````
vim <file_path>
````

Vim has different modes. There are six modes, each providing distinct tools to the user:

1. Normal Mode (default, go back to normal mode with `esc`)
1. Visual Mode
1. Select Mode
1. Insert Mode (press `i`)
1. Command-line Mode
1. Ex Mode

- You can save a file with `:w` (write)
- You can save and exit with `:wq` (write quit)
- You can force quit with `:q!`

#### File permissions

##### Unix

Unix has three permissions a user can have:

1. Read (r)
1. Write (w)
1. Execute (x)

and three owners:

1. The Owner (user class)
1. The Group (group class)
1. Everyone else (other class)

There are a couple of common notations used to represent these permissions:

- Symbolic Notation: -rwxrw-r--
- Octal Notation: 0764

|        | User |   |   | Group |   |   | Other |   |   |
|--------|------|---|---|-------|---|---|-------|---|---|
|        | r    | w | x | r     | w | - | r     | - | - |
| Binary | 1    | 1 | 1 | 1     | 1 | 0 | 1     | 0 | 0 |
| Octal  | 7    |   |   | 6     |   |   | 4     |   |   |

Bash:
View the permissions on a file
````
ls -l
-rw-r--r-- 1 user_name group_name 0 16 Feb 09:51 __init__.py
drwxr-xr-x 3 user_name group_name 96 16 Feb 12:11 __pycache__
drwxr-xr-x 7 user_name group_name 224 1 Feb 15:22 engine
drwxr-xr-x 6 user_name group_name 192 17 Feb 14:39 ui
````

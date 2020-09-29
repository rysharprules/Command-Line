# Shell Commands

- [Shell Commands](#shell-commands)
  - [Shells](#shells)
    - [Bourne Shell (`sh`)](#bourne-shell-sh)
    - [Bash](#bash)
    - [Z-Shell (`zsh`)](#z-shell-zsh)
    - [Command prompt (`cmd.exe`)](#command-prompt-cmdexe)
    - [PowerShell](#powershell)
  - [Common tasks](#common-tasks)
    - [Manage directories and files](#manage-directories-and-files)
      - [Change directory](#change-directory)
      - [Current directory](#current-directory)
      - [Make directory](#make-directory)
      - [Remove directory/files](#remove-directoryfiles)
      - [Create files](#create-files)
    - [Handling files](#handling-files)
      - [Read content](#read-content)
      - [Editing](#editing)
        - [Nano (UNIX-like systems)](#nano-unix-like-systems)
          - [Vi/Vim](#vivim)
      - [File permissions](#file-permissions)
        - [Unix](#unix)
        - [Windows](#windows)
    - [Making web requests](#making-web-requests)
    - [Text search and manipulation](#text-search-and-manipulation)
      - [`grep`](#grep)
        - [Regex](#regex)
      - [`sed`](#sed)
      - [`awk`](#awk)
      - [PowerShell](#powershell-1)
    - [JSON processing](#json-processing)
      - [`jq`](#jq)
      - [PowerShell](#powershell-2)
    - [Standard input, Output and Error](#standard-input-output-and-error)
  - [Bash scripting](#bash-scripting)
    - [Shebang](#shebang)
    - [Variables](#variables)
      - [Scope](#scope)
      - [Read-only](#read-only)
      - [Environment variables](#environment-variables)
      - [Arrays](#arrays)
    - [Conditionals](#conditionals)
      - [Bash brackets](#bash-brackets)
      - [Loops](#loops)
      - [Case statements](#case-statements)
    - [Functions](#functions)
    - [User input](#user-input)
      - [CLI interaction](#cli-interaction)
    - [Exit codes](#exit-codes)
    - [Shell options](#shell-options)
    - [Cron jobs](#cron-jobs)

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
Set-Location -Path ./subdirectory
Set-Location ./subdirectory
cd ./subdirectory
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

#### Make directory

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


View the permissions on a file:
````
ls -l
-rw-r--r-- 1 user_name group_name 0 16 Feb 09:51 __init__.py
drwxr-xr-x 3 user_name group_name 96 16 Feb 12:11 __pycache__
drwxr-xr-x 7 user_name group_name 224 1 Feb 15:22 engine
drwxr-xr-x 6 user_name group_name 192 17 Feb 14:39 ui
````

Modifying UNIX permissions:
````
chmod +x my_file # Grant execute permissions to all
chmod g-w my_file # Revoke write permissions from the group
chmod 0777 my_file # Grant full permissions to everyone! WARNING: Dangerous
````

##### Windows

Windows permissions work via a customisable set of ACLs (Access Control Lists).

The basic permissions are:

1. Full Control
1. Modify
1. Read & Execute
1. Read
1. Write

The advanced permissions are:

1. ListDirectory
2. ReadData
3. WriteData
4. CreateFiles
5. CreateDirectories
6. AppendData
7. ReadExtendedAttributes
8. WriteExtendedAttributes
9. Traverse
10. ExecuteFile
11. DeleteSubdirectoriesAndFiles
12. ReadAttributes
13. WriteAttributes
14. Delete
15. ReadPermissions
16. ChangePermissions
17. TakeOwnership
18. Synchronize

PowerShell:
````
Get-Acl # view the permissions on a file or directory
Set-Acl # set permissions on a file or directory
````

### Making web requests

Bash:
There are two open-source CLI tools widely used on UNIX-like systems to make web requests: `curl` and `wget`.
````
curl -o python_curl.html https://www.python.org/
wget -O python_wget.html https://www.python.org/
````

For scripting web requests on Windows, you can also use `curl`.

PowerShell:
[Invoke-WebRequest](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7)

### Text search and manipulation

#### `grep`

Grep is a command line text search tool that uses regular expressions (also known as `regexp`, or `regex`) to search for text patterns in files.

Chess.log example file:
````
...
2020-02-02 10:42:48,828 Player.WHITE Pawn to Square(row=3, col=6)
2020-02-02 10:42:53,813 Player.BLACK Pawn to Square(row=5, col=5)
2020-02-02 10:42:58,391 Player.WHITE Knight to Square(row=2, col=5)
2020-02-02 10:42:59,730 Player.BLACK Pawn to Square(row=4, col=4)
2020-02-02 10:43:05,468 Player.BLACK King to Square(row=6, col=5)
...
````

````
$ grep 'King' chess.log # find rows that include 'King'
$ grep 'col=[3-5]' chess.log # find rows relating to columns 3, 4 or 5
$ grep -E '10:42:[0-9]{2}.*BLACK' chess.log # find moves made by the black player at 10:42:xx am. The -E flag switches to extended grep syntax. 
$ grep 'Queen' *.log # find all Queen moves across all log files in the current directory.
````

##### Regex

| Regex | Description                                                         |
|-------|---------------------------------------------------------------------|
| .     | Matches any single character                                        |
| [ABC] | Matches any of A, B or C                                            |
| [0-9] | Matches any digit in the range 0-9                                  |
| {2}   | Matches the preceding regex character twice                         |
| \     | Escapes the following character, making it lose any special meaning |
| *     | Matches the previous character zero-or-more times                   |
| +     | Matches the previous character one-or-more times (egrep only)       |
| ?     | Matches the previous character zero-or-one times (egrep only)       |
| ^     | Start of line                                                       |
| $     | End of line                                                         |

There are three `regex` 'standards':

1. POSIX basic
2. POSIX extended - supports more metacharacters (e.g. the ?, +, {, } and | special characters)
3. Perl 5 (PCRE) - Many programming language regex implementations (including Python)

Run `grep -E` to use the extended syntax.

#### `sed`

`sed` is a stream editor (hence the name) and, like `grep`, developed from the interactive line editor `ed`. You can think of `sed` as an expansion of `grep`. `grep` searches lines of text, while `sed` can search and manipulate lines of text.

````
sed 's/python/Python/g' my_file # 1. capitalise Python
sed '/^$/d' my_file # 2. Delete blank lines
sed -n '/^```/,/^```/p' my_file # 3. Extract code blocks from markdown
sed -nE '/^\#+/p' my_file # 4. Print headings from a markdown file (could be done with grep)
````

The `-n` flag tells sed to not output text unless explicitly instructed by the `p` (print) command. The `E` flag instructs `sed` to use the extended POSIX `regex` syntax.

The substitute command (`s/`) replaces words, e.g. 'python' with 'Python' everywhere in the file. The `/d` command deletes lines that match the `regex` (e.g. `^$`, an empty line).

#### `awk`

`awk` moves beyond `sed`'s functionality by providing a domain-specific programming language and user-accessible memory for storing state between lines.

This simply prints each line from the file:

````
awk '{ print $0 }' my_file # The magic variable $0 holds the value of the current line being processed
````

my_file contents:
````
Some header text.
Data follows.
1 2 3
onetwothree
4 5 6
10
````

Using `awk` to sum all the integers in the above file, `my_file`:
````
BEGIN { total = 0 }
/^[A-Za-z]/ {
print "Skipping text line"
}
/^[0-9]+/ {
for (i = 1; i <= NF; i++) {
total += $i
}
print "Processed values:", $0
}
END { print "Total", total }
````

Outputs (Bash):
````
awk -f program.awk my_file
Skipping text line
Skipping text line
Processed values: 1 2 3
Skipping text line
Processed values: 4 5 6
Processed values: 10
Total 31
````

[awk POSIX specification](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html).

#### PowerShell

PowerShell has powerful [comparison operators](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators) and cmdlets that can perform many common text
processing operations including [regex matching](https://docs.microsoft.com/en-gb/powershell/module/microsoft.powershell.core/about/about_regular_expressions) and text replacement. These can be combined with
cmdlets such as `Where-Object`, `ForEach-Object` and `Select-Object` to build powerful commands and scripts.

The `Select-String` cmdlet works similarly to `grep`:
````
Get-Content my_file | Select-String -Pattern '^$' -NotMatch # Find empty lines by matching a regex
````
````
Get-Content my_file | Where-Object {$_.Length -gt 0} # Find empty lines by inspecting their length
````
PowerShell's `regex` matching could also be used to replace matches. The example below shows this using the `-replace` operator:
````
$ Get-Content my_file | ForEach-Object {$_ -replace "python", "Python"} | Out-File Python.txt # Capitalise all occurrences of "python" (a regex)
$ cat my_file | % {$_ -replace "python", "Python"} > Python.txt # A shorter version
````

### JSON processing

#### `jq`

`jq` is a command-line JSON parser with a powerful query language.

Get and read some JSON data
````
curl 'https://api.exchangeratesapi.io/history?base=GBP&start_at=2019-12-01&end_at=2019-12-31' > data.json

$ cat data.json | jq '.'
{
"start_at": "2019-12-01",
"base": "GBP",
"end_at": "2019-12-31",
"rates": {
"2019-12-17": {
"CAD": 1.7333742389,
"HKD": 10.2601831312,
"ISK": 161.1837447491,
"PHP": 66.5655826686,
"DKK": 8.8180252041,
"HUF": 389.0475291452,
"CZK": 30.0243073583,
"GBP": 1,
...
"2019-12-18": {
...

$ cat data.json | jq '.rates."2019-12-24"' # Basic: get the data for 2019-12-24
{
"CAD": 1.704839068,
"HKD": 10.0885038523,
"ISK": 158.5353021641,
"PHP": 65.8587913437,
"DKK": 8.7348742591,
"HUF": 387.8736861796,
"CZK": 29.7955175196,
"GBP": 1,
"RON": 5.5873171758,
"SEK": 12.2237031321,
"IDR": 18116.2826043749,
"INR": 92.3064782014,
"BRL": 5.2898881134,
"RUB": 80.4288403306,
"HRK": 8.7048273766,
"JPY": 141.6880034607,
...
}
$ cat data.json | jq '.rates | [keys[] as $k | {"\($k)" : .[$k] | .CAD}] | add' # More complex: get the Canadian dollar exchange rate, keyed by date
{
"2019-12-02": 1.7198244502,
"2019-12-03": 1.7308685446,
"2019-12-04": 1.7382106134,
"2019-12-05": 1.7296081449,
"2019-12-06": 1.7309035795,
"2019-12-09": 1.7429776115,
"2019-12-10": 1.7444363827,
"2019-12-11": 1.7402813223,
"2019-12-12": 1.7355723746,
"2019-12-13": 1.7617473775,
"2019-12-16": 1.7528022538,
"2019-12-17": 1.7333742389,
"2019-12-18": 1.7193580624,
"2019-12-19": 1.7147626156,
"2019-12-20": 1.7124969166,
"2019-12-23": 1.7007747235,
"2019-12-24": 1.704839068,
"2019-12-27": 1.7140843416,
"2019-12-30": 1.7159186931,
"2019-12-31": 1.715796897
}
````

#### PowerShell

PowerShell contains `ConvertFrom-Json` and `ConvertTo-Json` cmdlets to transform data between JSON and .NET object representations.

````
Get-Content data.json |
ConvertFrom-Json |
Select-Object -ExpandProperty rates |
Select-Object -ExpandProperty '2019-12-24' |
ConvertTo-Json
````

### Standard input, Output and Error

- Standard Input (STDIN) - Programs read input text from this stream.
- Standard Output (STDOUT) - Programs write their normal output to this stream.
- Standard Error (STDERR) - This is where errors go

````
$ program_a > output # Write output to a file (called 'output'), leaving errors to be printed to the terminal (as happens by default)
$ program_a > output 2> error_file # Write output to a file (called 'output') and errors to a separate file (called 'error_file')
$ program_a > all_output 2>&1 # Send standard output (file descriptor 1) and standard error (file descriptor 2) to the same file (called 'all_output')
$ program_a > output 2>/dev/null # Suppress errors entirely by piping them to a special file that ignores everything sent to it
````

## Bash scripting

### Shebang

The shebang is a line at the start of a script that begins `#!`. The shebang says which executable, or interpreter, will be used to execute the script.

The shebang at the top tells the user that the script must be executed using `zsh`:
````
#! /usr/bin/env zsh
````

### Variables

You assign variables with [name]=[value] syntax.

Variable names are case-sensitive, and valid characters are: a to z, 0 to 9, and the underscore (`_`). You access a variable's value by prefixing the variable name with `$`. You can also add braces (`${variable_name}`):

````
#! /usr/bin/env bash
var=123
echo $var # Access the variable using $
echo $var + 3 # Variables are always strings
echo "Variable = $var (double quotes)" # Variables are interpolated in double-quoted strings
echo 'Variable = $var (single quotes)' # ...but not single-quoted strings
echo "Variable = ${var}456" # Use curly brackets where necessary to bound the variable name
````

The dollar instructs the shell to look up a value associated with that name.:
````
var1=hello
var2=var1 # Incorrect
echo $var2 # prints var1
var3=$var1 # Correct
echo $var3 # prints hello
````

#### Scope

`variable_two` is not accessible outside the function `set_variables`:
````
#! /usr/bin/env bash
function set_variables {
  variable_one=global
  local variable_two=local
}
set_variables
echo $variable_one # prints 'global'
echo $variable_two # undefined
````

Subshells inherit the environment (i.e. variables) of their parent shell, but modifications to the environment within a pipe are not exported to the parent scope:
````
#! /usr/bin/env bash
parent_var=parent
ls | (echo $parent_var; subshell_var=child)
echo $subshell_var # undefined
````

#### Read-only

````
readonly var=1
var=2 # error
````

#### Environment variables

Environment variables are processscoped variables, and can be set by using the `export` keyword before a variable definition.

Environment variables are always strings, and by convention their names are all uppercase.

#### Arrays

````
my_array[0]=This
my_array[1]=is
my_array[2]=an
my_array[3]=array
````

You can also use the following shorthand syntax to define an array:
````
my_array=("This" "is" "an" "array")
````

After you have set any array variable, you access it as follows:
````
echo "First index: ${my_array[0]}" # First index: This
echo "Third index: ${my_array[2]}" # Third index: an
echo "All values: ${my_array[@]}" # All values: This is an array
````

### Conditionals

````
if BOOLEAN_EXPRESSION
  then
  echo 'Expression was true!'
fi
````
````
if EXPRESSION_A; then
  echo 'Expression A was true!'
elif EXPRESSION_B; then
  echo 'Expression B was true!'
elif EXPRESSION_C; then
  echo 'Expression C was true!'
else EXPRESSION_C
  echo 'None of them were true'
fi
````

Logical expressions are enclosed in square brackets:
| Syntax          | Meaning                          |
|-----------------|----------------------------------|
| [[ -e file ]]   | True if 'file' exists            |
| [[ -z string ]] | True if 'string' has length zero |
| [[ A -gt B ]]   | True if A is greater than B      |
| [[ A == B ]]    | True if A equals B               |
| [[ A != B ]]    | True if A does not equal B       |

There are some short-cuts you can take when writing small conditionals. These can help with
readability:
````
[[ BOOLEAN_EXPRESSION ]] && ( echo 'The expression is True' )
[[ BOOLEAN_EXPRESSION ]] || ( echo 'The expression is False' )
````

#### Bash brackets

[Quick reference](https://www.assertnotmagic.com/2018/06/20/bash-brackets-quick-reference/)

Summary of common brackets:
| Brackets  | Meaning                                                 |
|-----------|---------------------------------------------------------|
| ( ... )   | Runs commands in a subshell                             |
| (( ... )) | Perform integer arithmetic                              |
| [ ... ]   | An alias for the test built-in command                  |
| [[ ... ]] | Bash's expanded test command                            |
| { ... }   | Function definitions, Grouping commands, text expansion |

#### Loops

````
for i in {1..5}; do
  echo $i
done

for file in $( ls ); do
  echo $file
done
````

The `$( command )` syntax is a **command substitution**. When run, the expression is replaced by the standard output returned by running the command inside the brackets. There's an alternative syntax using backticks: ` command `.

````
#! /usr/bin/env bash
count=0
while [ $count -lt 3 ]; do
  echo $((count++))
done

until [ $count == -2 ]; do
  echo $((count--))
done
````
This prints: 0 1 2 3 2 1 0 -1

#### Case statements

````
#! /usr/bin/env bash
echo "Give me a letter: "
read letter
case $(echo "$letter" | tr '[:upper:]' '[:lower:]') in
  b) echo "That's the second letter of the alphabet!";;
  c) echo "And the third...";;
  a | e | i | o | u) echo "That's a vowel";;
  *) echo "I don't know that one";;
esac
````

### Functions

````
function my_function {
  commands...
}
my_identical_function() {
  commands...
}
````

You don't include function arguments in the function declaration. Instead you just access them when needed. Function arguments can be accessed via the variables `$1`, `$2` etc.

You can also access all the arguments using the special variable `$@`:
````
function print_a_thing() {
  echo $1
}
function print_all_the_things() {
  for arg in $@; do
    echo $arg
  done
}
print_a_thing "dogs" "cats" "chickens" # Prints: dogs
print_all_the_things "dogs" "cats" "chickens" # Prints: dogs cats chickens
````

### User input

You can access these positional parameters passed to your script using the variables `$1`, `$2` etc. `$0` contains the name of your script.

````
./my_script.sh parameter_a parameter_b # $1 will contain the string "parameter_a" and $2 the string "parameter_b"
````

You can also use flags:
````
./my_script.sh -d 2 -r 5 -v
````

````
#! /usr/bin/env bash
duration=
retries=
verbose=
while getopts "d:r:v" option; do
  case "${option}" in
    d)
      duration=${OPTARG}
      ;;
    r)
      retries=${OPTARG}
      ;;
    v)
      verbose=1
      ;;
  esac
done
echo "Duration: $duration"
echo "Retries: $retries"
echo "Verbose: $verbose"
````

#### CLI interaction

````
#! /usr/bin/env bash
echo "What's your name?"
read name
echo "Hi $name!"
````

### Exit codes

Typically `0` means success and any non-zero value (`1`-`255`) means that something went wrong, and some further information should be written to `STDERR`.

````
if ! [[ -f $1 ]]; then
  echo 'File not found!' >&2
  exit 1
else
  echo 'File exists'
  exit 0
fi
````

### Shell options

Options can be set or unset using `-o <flag-name>` or `+o <flag-name>` parameters respectively.

- errexit (`-e`) - We can tell bash to immediately abort a script if it encounters an error by enabling 'errexit'.
- verbose (`-v`) - This option instructs the shell to print every statement before running it.
- xtrace (`-x`) - Similar to verbose but also performs variable substitution on the printed output.
- noclobber (`-C`) - By default, redirecting command output to a file will override (aka 'clobber') any existing file content. Noclobber helps reduce the risk of overwriting existing data.

### Cron jobs

Syntax:
`$ Minute(0-59) Hour(0-24) Day_of_month(1-31) Month(1-12) Day_of_week(0-6) Command_to_execute`

````
* * * * * <command-to-execute> # Run every minute
*/5 * * * * <command-to-execute> # every 5th minute
30 * * * * <command-to-execute> # every hour at minute 30
0,5,10 * * * * <command-to-execute> # every hour at minute 0, 5 and 10
0 */4 * * * <command-to-execute> # every 4 hours
0 1 * * * <command-to-execute> # every day at 1 am
0 0 * * 1-5 <command-to-execute> # every weekday
````

There are also some predefined schedule definitions:
| Symbol                 | Description                                                | Equivalent |
|------------------------|------------------------------------------------------------|------------|
| @yearly (or @annually) | Run once a year at midnight of 1 January                   | 0 0 1 1 *  |
| @monthly               | Run once a month at midnight of the first day of the month | 0 0 1 * *  |
| @weekly                | Run once a week at midnight on Sunday morning              | 0 0 * * 0  |
| @daily (or @midnight)  | Run once a day at midnight                                 | 0 0 * * *  |
| @hourly                | Run once an hour at the beginning of the hour              | 0 * * * *  |
| @reboot                | Run at startup                                             | N/A        |

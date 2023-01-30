# system-logger
Generate system logs with useful information.
## Purpose
Provide a clean, lightweight, and practical way to track system resource consumption over time.
## Instalation
To install you must run the following commands:
```bash
git clone https://github.com/estevaopbs/system-logger.git
cd system-logger
chmod +x install.sh
./install.sh
```
Then reopen your shell to reload the bash settings and you're good to go.
## Usage
```bash
logger-start    # starts the system-logger
logger-stop     # stops the system-logger
```
Since it's still a quite simple application it doesn't do some trivial verifications. Multiple instances of system-logger can run at the same time generating unwanted behavior. Please be sure no instance of system-logger is running before execute ```logger-start```.
## Configuration
System logger has only two execution parameters which can be found at ```~/.config/system-logger.conf```. The default configuration is:
```conf
time_interval=60
log_dir=$HOME/.cache/system-logger
```
**time_interval** - Time interval between each two consecutive registers.

**log_dir** - Directory in which the log files will be stored.
## Functioning
The script works by running the command ```top``` and recording the header data in a csv format.
## Compatibility
The tool is set up to only work with bash shell, because it uses aliases stored in the .bashrc file during installation. However, it can easily be adapted to work with other shells. To do this, you just need to add the equivalent of the following bash code to the end of the equivalent of the .bashrc file for the specific shell you are using.

```bash
alias logger-start="nohup system-logger &> /home/estevao/.cache/system-logger/logger-execution.log &"
alias logger-stop="kill \$(ps -ef | grep system-logger | grep -v grep | awk '{print \$2}')"
```
# system-logger

Generate system logs with useful information.

## Table of Contents

- [system-logger](#system-logger)
  - [Table of Contents](#table-of-contents)
  - [Purpose](#purpose)
  - [Install](#install)
  - [Usage](#usage)
    - [Columns](#columns)
  - [Dependencies](#dependencies)
  - [Configuration](#configuration)
  - [Functioning](#functioning)
  - [Compatibility](#compatibility)
  - [Uninstall](#uninstall)
  - [License](#license)
## Purpose

Provide a clean, lightweight, and practical way to track system resource consumption over time.

## Install

To install you must run the following commands:

```bash
git clone https://github.com/estevaopbs/system-logger.git
cd system-logger
chmod +x install
./install
```

Then reopen your shell to reload the bash settings and you're good to go.

## Usage

```bash
logger-start    # starts the system-logger
logger-stop     # stops the system-logger
```

Since it's still a quite simple application it doesn't do some trivial verifications. Multiple instances of system-logger can run at the same time generating unwanted behavior. Please make sure no instance of system-logger is running before run ```logger-start```.

### Columns

1. **timestamp** - Timestamp of the record
2. **cpun** - Cpu core n usage (0 - 1) times 1000
3. **mem_usage** - Memory usage (0 - 1) times 1000
4. **swap_usage** - Swap usage (0 - 1) times 1000
5. **partition_usage** - Partition storage usage  (0 - 1) times 1000
6. **partition_read** - Bytes read in the partition during one **time interval**
7. **partition_write** - Bytes wrote in the partition during one **time interval**
8. **adapter_received** - Bytes received by network adapter during one **time interval**
9. **adapter_transmitted** - Bytes transmitted by network adapter during one **time interval**

## Dependencies

The only dependencies it has are on **```coreutils```** and **```zip```**. Install them via the package manager of the distro you are using.

## Configuration

System logger has only three execution parameters which can be found at ```~/.config/system-logger.conf```. The default configuration is

```conf
time_interval=1
log_dir=$HOME/.cache/system-logger
partitions=(sda1 sdb1 ...)
```

**time_interval** - Time interval between each two consecutive registers.

**log_dir** - Directory in which the log files will be stored.

**partitions** - An array containing the filesystems which stats will be recorded. Each element of the array must be the name of the file that represents the filesystem in ```/dev```. By default it will contain the filesystems given by

```bash
df | grep -v /boot/efi  | awk "{print \$1}" | grep -oP "(?<=/dev/).*" | uniq
```

## Functioning

The script works by reading the files generated by the kernel and transposing the most relevant data into a csv file.

## Compatibility

This tool is currently set up only to work with bash shell, because it uses aliases stored in the .bashrc file during installation. However, it can easily be adapted to work with other shells. To do this, you just need to add the equivalent of the following bash code to the end of the equivalent of the .bashrc file for the specific shell you are using.

```bash
PATH=$HOME/.local/bin:$PATH
alias logger-start="nohup system-logger &> $HOME/.cache/system-logger/logger-execution.log &"
alias logger-stop="kill \$(ps -ef | grep system-logger | grep -v grep | awk '{print \$2}')"
```

## Uninstall

To uninstall the system-logger you must just cd to the system-logger directory (the one which was cloned from github), then run

```
chmod +x uninstall
./uninstall
```

Then remove the aliases added to .bashrc by at installation. If you're running it on other shell than bash, then also remove the aliases you added to the equivalent of the .bashrc file for the shell you are using.

## License

ConfigMerge is licensed under the terms of the [MIT License](LICENSE).
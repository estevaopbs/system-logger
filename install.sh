cp ./source/system-logger $HOME/.local/bin/system-logger
logger_path=$HOME/.cache/system-logger
mkdir -p -v $logger_path
if ! [[ -d $HOME/.config ]]; then
    mkdir $HOME/.config
fi
if ! [[ -f $HOME/.config/system-logger.conf ]]; then
    echo "time_interval=60" > $HOME/.config/system-logger.conf
    echo "log_dir=$HOME/.cache/system-logger" >> $HOME/.config/system-logger.conf
fi
echo "alias logger-start=\"nohup system-logger &> $logger_path/logger-execution.log &\"" >> $HOME/.bashrc
echo "alias logger-stop=\"ps -ef | grep system-logger | grep -v grep | awk '{print \$2}'\"" >> $HOME/.bashrc
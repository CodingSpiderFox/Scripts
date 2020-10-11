#!/bin/bash

mkdir -p /opt/blk/scripts/run/minutely
mkdir -p /opt/blk/scripts/run/hourly
mkdir -p /opt/blk/scripts/run/daily
mkdir -p /opt/blk/scripts/run/weekly
mkdir -p /opt/blk/scripts/run/monthly
mkdir -p /opt/blk/scripts/run/yearly

cat /etc/crontab | grep "/opt/blk/scripts/run/minutely"     || echo "* *    * * *   root    /Data/Scripts/runDirectory.sh /opt/blk/scripts/run/minutely" >> /etc/crontab
cat /etc/crontab | grep "/opt/blk/scripts/run/hourly"       || echo "$(shuf -i 0-59 -n 1) * * * *   root    /Data/Scripts/runDirectory.sh /opt/blk/scripts/run/hourly" >> /etc/crontab
cat /etc/crontab | grep "/opt/blk/scripts/run/daily"        || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      * * *   root    /Data/Scripts/runDirectory.sh /opt/blk/scripts/run/daily" >> /etc/crontab
cat /etc/crontab | grep "/opt/blk/scripts/run/weekly"       || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      * * $(shuf -i 0-6 -n 1) root    /Data/Scripts/runDirectory.sh /opt/blk/scripts/run/weekly" >> /etc/crontab
cat /etc/crontab | grep "/opt/blk/scripts/run/monthly"      || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      $(shuf -i 1-28 -n 1) * *        root    /Data/Scripts/runDirectory.sh /opt/blk/scripts/run/monthly" >> /etc/crontab
cat /etc/crontab | grep "/opt/blk/scripts/run/yearly"       || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      $(shuf -i 1-28 -n 1) $(shuf -i 1-12 -n 1) *     root   /Data/Scripts/runDirectory.sh /opt/blk/scripts/run/yearly" >> /etc/crontab

echo "#!/bin/bash

for i in \$(find \"\$1\" -type f -name \"*.sh\"); do
        status=\`ps -efww | grep -w \"\$i\" | grep -v grep | grep -v \$$ | awk '{ print \$2 }'\`
        if [ -z \"\$status\" ]; then
                /bin/bash \"\$i\" &
        fi
done

" > /opt/blk/scripts/runDirectory.sh

chmod +x /opt/blk/scripts/runDirectory.sh

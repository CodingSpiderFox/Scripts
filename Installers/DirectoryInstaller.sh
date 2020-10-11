#!/bin/bash

mkdir -p /opt/kito/scripts/run/minutely
mkdir -p /opt/kito/scripts/run/hourly
mkdir -p /opt/kito/scripts/run/daily
mkdir -p /opt/kito/scripts/run/weekly
mkdir -p /opt/kito/scripts/run/monthly
mkdir -p /opt/kito/scripts/run/yearly
mkdir -p /opt/kito/scripts/run/startup

cat /etc/crontab | grep "/opt/kito/scripts/run/minutely"     || echo "* *    * * *   root    /Data/Scripts/runDirectory.sh /opt/kito/scripts/run/minutely" >> /etc/crontab
cat /etc/crontab | grep "/opt/kito/scripts/run/hourly"       || echo "$(shuf -i 0-59 -n 1) * * * *   root    /Data/Scripts/runDirectory.sh /opt/kito/scripts/run/hourly" >> /etc/crontab
cat /etc/crontab | grep "/opt/kito/scripts/run/daily"        || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      * * *   root    /Data/Scripts/runDirectory.sh /opt/kito/scripts/run/daily" >> /etc/crontab
cat /etc/crontab | grep "/opt/kito/scripts/run/weekly"       || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      * * $(shuf -i 0-6 -n 1) root    /Data/Scripts/runDirectory.sh /opt/kito/scripts/run/weekly" >> /etc/crontab
cat /etc/crontab | grep "/opt/kito/scripts/run/monthly"      || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      $(shuf -i 1-28 -n 1) * *        root    /Data/Scripts/runDirectory.sh /opt/kito/scripts/run/monthly" >> /etc/crontab
cat /etc/crontab | grep "/opt/kito/scripts/run/yearly"       || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      $(shuf -i 1-28 -n 1) $(shuf -i 1-12 -n 1) *     root   /Data/Scripts/runDirectory.sh /opt/kito/scripts/run/yearly" >> /etc/crontab

echo "#!/bin/bash

for i in \$(find \"\$1\" -type f -name \"*.sh\"); do
        status=\`ps -efww | grep -w \"\$i\" | grep -v grep | grep -v \$$ | awk '{ print \$2 }'\`
        if [ -z \"\$status\" ]; then
                /bin/bash \"\$i\" &
        fi
done

" > /opt/kito/scripts/runDirectory.sh

chmod +x /opt/kito/scripts/runDirectory.sh

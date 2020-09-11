#!/bin/bash
mkdir -p /Data/Scripts/runYearly
mkdir -p /Data/Scripts/runMonthly
mkdir -p /Data/Scripts/runWeekly
mkdir -p /Data/Scripts/runDaily
mkdir -p /Data/Scripts/runHourly
mkdir -p /Data/Scripts/runMinutely


cat /etc/crontab | grep "/Data/Scripts/runMinutely"     || echo "* *    * * *   root    /Data/Scripts/runDirectory.sh /Data/Scripts/runMinutely" >> /etc/crontab
cat /etc/crontab | grep "/Data/Scripts/runHourly"       || echo "$(shuf -i 0-59 -n 1) * * * *   root    /Data/Scripts/runDirectory.sh /Data/Scripts/runHourly" >> /etc/crontab
cat /etc/crontab | grep "/Data/Scripts/runDaily"        || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      * * *   root    /Data/Scripts/runDirectory.sh /Data/Scripts/runDaily" >> /etc/crontab
cat /etc/crontab | grep "/Data/Scripts/runWeekly"       || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      * * $(shuf -i 0-6 -n 1) root    /Data/Scripts/runDirectory.sh /Data/Scripts/runWeekly" >> /etc/crontab
cat /etc/crontab | grep "/Data/Scripts/runMonthly"      || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      $(shuf -i 1-28 -n 1) * *        root    /Data/Scripts/runDirectory.sh /Data/Scripts/runMonthly" >> /etc/crontab
cat /etc/crontab | grep "/Data/Scripts/runYearly"       || echo "$(shuf -i 0-59 -n 1) $(shuf -i 0-23 -n 1)      $(shuf -i 1-28 -n 1) $(shuf -i 1-12 -n 1) *     root   /Data/Scripts/runDirectory.sh /Data/Scripts/runYearly" >> /etc/crontab

echo "#!/bin/bash

for i in \$(find \"\$1\" -type f -name \"*.sh\"); do
        status=\`ps -efww | grep -w \"\$i\" | grep -v grep | grep -v \$$ | awk '{ print \$2 }'\`
        if [ -z \"\$status\" ]; then
                /bin/bash \"\$i\" &
        fi
done

" > /Data/Scripts/runDirectory.sh

chmod +x /Data/Scripts/runDirectory.sh

#!/bin/bash


DIR_TMP=/tmp/phpGit$$
DIR_INS=/var/www/libTest

mkdir -p "$DIR_TMP"
mkdir -p "$DIR_INS"

cd "$DIR_TMP" \
&& git clone https://github.com/filp/whoops.git && rsync -arv --remove-source-files whoops/src/ "$DIR_INS/Whoops/" \
&& git clone https://github.com/Seldaek/monolog.git && rsync -arv --remove-source-files monolog/src/ "$DIR_INS/Monolog/" \
&& git clone https://github.com/php-fig/log.git && rsync -arv --remove-source-files log/Psr/Log/ "$DIR_INS/Psr/Log/" \
&& git clone https://github.com/symfony/var-dumper.git  && rsync -arv --remove-source-files var-dumper/ "$DIR_INS/Symfony/Component/VarDumper/" \
&& rm -r "$DIR_TMP"

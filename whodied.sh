#!/usr/sbin/env bash

cd /home/"${USER}"/.config || exit 1
source ./whodied.conf

OLDIFS=$IFS
IFS=$(echo -n ",")

PORT=${PORT:-22}

for EACH_SERVER in ${SERVERS}; do
    output=$(nmap -sS "${EACH_SERVER}${POSTFIX}" -p "${PORT}")
    if echo "${output}" | grep -q "${PORT}/tcp open" ; then
        echo -e "alive ${EACH_SERVER}"
    else
        echo -e "\e[5mdead ${EACH_SERVER}"
    fi
done

IFS=${OLDIFS}
exit 0

#!/bin/bash

DOMAIN=$1
FILE=$2

IFS=$'\n'
for DATA in `egrep "^(a|cname)" $FILE`; do
    RECORD=`echo $DATA | cut -f 1 -d ' '`
    SUB_DOMAIN=`echo $DATA | cut -f 2 -d ' '`
    IP_ADDR=`echo $DATA | cut -f 3 -d ' '`

    if [ "${RECORD}" = "a" ] ; then
        RECORD=1
    elif [ "${RECORD}" = "cname" ]; then
        RECORD=2
    fi

    mysql -u root -e "INSERT INTO \`mng_domain\`.\`domain_list\` (record_type, domain, sub_domain, ip) VALUES('${RECORD}', '${DOMAIN}', '${SUB_DOMAIN}', '${IP_ADDR}');"
done

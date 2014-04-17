#!/bin/bash

DB_USER="${1}"
DB_NAME="${2}"
DOMAIN="${3}"
TIMEOUT="${4:-5}"

LIST=`mysql -u ${DB_USER} ${DB_NAME} -N -B -e "SELECT sub_domain FROM domain_list WHERE domain = '${DOMAIN}';"`

https() {
    _DOMAIN="${1}"
    _SUB_DOMAIN="${2}"

    if [ "${_SUB_DOMAIN}" = "" ] ; then
        echo "https://${_DOMAIN}"
    else
        echo "https://${_SUB_DOMAIN}.${_DOMAIN}"
    fi
}

update_ssl() {
    _SUB_DOMAIN="${1}"

    if [ "${_SUB_DOMAIN}" = "" ] ; then
        _SUB_DOMAIN='@'
    fi

    mysql -u root -e "UPDATE \`mng_domain\`.\`domain_list\` SET https=1 WHERE sub_domain='${_SUB_DOMAIN}';"
    echo "Updated ${_SUB_DOMAIN}"
}

check() {
    _DOMAIN="${1}"
    _SUB_DOMAIN="${2}"
    _URL=`https "${_DOMAIN}" "${_SUB_DOMAIN}"`
    
    if curl --connect-timeout $TIMEOUT -s $_URL > /dev/null 2>&1 ; then
        update_ssl "${_SUB_DOMAIN}"
    fi
}

for SUB_DOMAIN in $LIST; do
    check "${DOMAIN}" "${SUB_DOMAIN}"
done

# naked domain
check "${DOMAIN}"

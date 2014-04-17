#!/bin/bash

source `dirname ${0}`/../lib/sql.sh

DB_USER="${1}"
DB_NAME="${2}"
DOMAIN="${3}"
SSL="${4:-1}"
OPTIONS="${5}"

for _IP in `uniq_list "${DB_USER}" "${DB_NAME}" "${DOMAIN}" "${SSL}" "-N -B"`; do
    echo "############# START ${_IP} #############"
    list_by_ip "${DB_USER}" "${DB_NAME}" "${DOMAIN}" "${_IP}" "${SSL}" "${OPTIONS}"
    echo "############# END   ${_IP} #############"
    echo ""
done

#!/bin/bash

source `dirname ${0}`/../lib/sql.sh

DB_USER="${1}"
DB_NAME="${2}"
DOMAIN="${3}"
SSL="${4:-1}"
OPTIONS="${5}"

ip_list "${DB_USER}" "${DB_NAME}" "${DOMAIN}" "${SSL}" "${OPTIONS}"

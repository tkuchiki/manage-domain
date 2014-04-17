#!/bin/bash

mysql_exec() {
    _USER="${1:-root}"
    _DB="${2}"
    _OPTIONS="${3}"
    _SQL="${4}"

    mysql -u "${_USER}" "${_DB}" $_OPTIONS  -e "${_SQL}"
}

uniq_list() {
    _USER="${1}"
    _DB="${2}"
    _DOMAIN="${3}"
    _SSL="${4:-1}"
    _OPTIONS="${5}"

    mysql_exec "${_USER}" "${_DB}" "${_OPTIONS}" "
SELECT DISTINCT IFNULL(dl2.ip, dl1.ip) AS ip FROM domain_list dl1 
       LEFT JOIN (SELECT * FROM domain_list WHERE record_type = 1) dl2
            ON dl1.ip = dl2.sub_domain
       WHERE dl1.https  = ${_SSL}
       AND   dl1.domain = '${_DOMAIN}';"
}

ip_list() {
    _USER="${1}"
    _DB="${2}"
    _DOMAIN="${3}"
    _SSL="${4:-1}"
    _OPTIONS="${5}"

    mysql_exec "${_USER}" "${_DB}" "${_OPTIONS}" "
SELECT DISTINCT dl1.sub_domain, IFNULL(dl2.ip, dl1.ip) AS ip FROM domain_list dl1 
       LEFT JOIN (SELECT * FROM domain_list WHERE record_type = 1) dl2
            ON dl1.ip = dl2.sub_domain
       WHERE dl1.https  = ${_SSL}
       AND   dl1.domain = '${_DOMAIN}';"
}

list_by_ip() {
    _USER="${1}"
    _DB="${2}"
    _DOMAIN="${3}"
    _IP="${4}"
    _SSL="${5:-1}"
    _OPTIONS="${6}"

    mysql_exec "${_USER}" "${_DB}" "${_OPTIONS}" "
SELECT dl1.sub_domain FROM domain_list dl1 
       LEFT JOIN (SELECT * FROM domain_list WHERE record_type = 1) dl2
            ON dl1.ip = dl2.sub_domain
       WHERE dl1.https  = ${_SSL}
       AND   dl1.domain = '${_DOMAIN}'
       AND   dl1.ip     = '${_IP}';
"
}

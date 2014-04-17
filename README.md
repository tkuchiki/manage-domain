manage-domain
=============

大量のサブドメインを管理する
https を使っているドメインの割り出しができる。

# Usage

## Import SQL

~~~~
mysql -u root < fixture/domain.sql
~~~~

## Import data

以下の形式のデータを用意し、

~~~~
a base    192.168.0.100
a www     192.168.0.110
a prod    192.168.0.111
a staging 192.168.0.111

cname www2 base
cname test example.com.

~~~~

import する。

~~~~
./bin/insert_dns_record.sh Domain_Name DNS_Record_File

# example
# ./bin/insert_dns_record.sh example.com record.txt
~~~~

## https を使っているドメインの割り出し

~~~~
./bin/check_https_domain.sh DB_USER DB_NAME DOMAIN [CURL_TIMEOUT]

# example
# ./bin/check_https_domain.sh root mng_domain example.com
~~~~

## CNAME を IP に変換して出力

~~~~
./bin/ip_list.sh DB_USER DB_NAME DOMAIN

# example
# ./bin/ip_list.sh root mng_domain example.com
~~~~

### 元データ

~~~~
base    192.168.0.100
www     192.168.0.110
prod    192.168.0.111
staging 192.168.0.111
www2    base
test    example.com.
~~~~

### 変換後

~~~~
base    192.168.0.100
www     192.168.0.110
prod    192.168.0.111
staging 192.168.0.111
www2    192.168.0.100
test    example.com.
~~~~

## 設定している IP ごとにドメインを出力

~~~~
./bin/grouping_.sh DB_USER DB_NAME DOMAIN

# example
# ./bin/grouping_ip.sh root mng_domain example.com
~~~~

### 出力例

~~~~
############# START 192.168.0.100 #############
+------------+
| sub_domain |
+------------+
| base       |
| www2       |
+------------+
############# END   192.168.0.100 #############

############# START 192.168.0.110 #############
+------------+
| sub_domain |
+------------+
| www        |
+------------+
############# END   192.168.0.110 #############

############# START 192.168.0.111 #############
+------------+
| sub_domain |
+------------+
| prod       |
| staging    |
+------------+
############# END   192.168.0.111 #############

############# START example.com. #############
+------------+
| sub_domain |
+------------+
| test       |
+------------+
############# END   example.com. #############
~~~~
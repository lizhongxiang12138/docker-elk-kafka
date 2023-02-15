
#/bin/bash
#es-index-clear
echo "Begin @ `date +%Y.%m.%d-%H:%M:%S`"
#只保留15天内的日志索引
last_date=`date -d "-7 days" "+%Y.%m.%d"`
echo "清理当前日期: ${last_date}"

##查看所有要清理的索引
index_list=`curl -s http://192.168.12.16:9200/_cat/indices?bytes=mb|awk '{print $3,$10}'|sort -t " " -k 2 -g -r | grep ".*${last_date}.*"`
echo -e "要清理的所有索引: \n${index_list}"


#删除上个月份所有的索引
curl -s http://192.168.12.16:9200/_cat/indices?|awk '{print $3}'|grep ".*${last_date}.*"|xargs -I index  curl -X DELETE 'http://192.168.12.16:9200/index'
echo "清理完成~~~"
echo "End @ `date +%Y.%m.%d-%H:%M:%S`"
echo ""
echo ""

echo "remove the old metastore"
\rm -rf derby.log metastore_db
echo "create the new metastore"
schematool -dbType derby -initSchema > /dev/null 2>&1
echo "remove the old filesystem"
\rm -rf dfs
echo "create the new filesystem"
mkdir dfs
if [ -d predata ]
then
	echo "copying predata"
	cp -r predata/* dfs/warehouse
else
	echo "no predata"
fi

hive\
	-hiveconf hive.root.logger=ERROR,console\
	-hiveconf mapred.job.tracker=local\
	-hiveconf fs.default.name=file://$PWD/dfs\
	-hiveconf hive.metastore.warehouse.dir=file://$PWD/dfs/warehouse\
	-f script.sql
#	--silent\
#	--hiveconf log4j.configuration=file://$PWD/../log4j.properties

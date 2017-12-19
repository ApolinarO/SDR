# This is what I know in terms of automation
# Can the automation be done in a makefile?

# Invokes r files
	# In a real-world application, this will invoke several R files
run_tests:
	Rscript tests.R
	#cd ./Source/app1; RScript test
	#cd ./Source/app2; RScript test
	#cd ./Source/app3; RScript test

deploy:
	Rscript deploy.R
	#push project to server

update_db:
	mysql -u root -p -h localhost Test_DB < backup.sql
	# update db from file?

backup_db:
	mysqldump -u root -p -h localhost Test_DB > backup.sql
	# convert db into .sql file?

hello:
	echo "hello from the makefile"

clean:
	rm *.sql

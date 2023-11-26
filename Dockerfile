FROM mysql:5.7

ADD https://raw.githubusercontent.com/MindBridge-INC/jar-ec2/main/script_create_mysql_docker.sql

CMD mysql -h localhost -P 3306 -u root -p < script_create_mysql_docker.sql
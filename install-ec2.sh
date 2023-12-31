#!/bin/bash

echo -e '\e[1;36m Boas vindas à instalação do PayAttention! para Linux \e[m'
echo -e '\e[1;36m Vamos iniciar as primeiras configurações \e[m'

echo -e '\e[1;35m VERIFICANDO PACOTES DO SISTEMA \e[m'
sudo apt update && sudo apt upgrade -y
sudo apt install curl -y

echo " "
echo -e '\e[1;35m INSTALAR JAVA \e[m'

java -version

if [ $? -eq 0 ];
	then
		echo -e '\e[1;36m Parece que o Java já está instalado em seu dispositivo. Vamos prosseguir com a instalação! \e[m'
	else
		echo -e '\e[1;33m Parece que o Java não está instalado em seu dispositivo. Instalando... \e[m'
		sudo apt install openjdk-17-jre -y
fi

echo " "
echo -e '\e[1;35m INSTALAR E CONFIGURAR DOCKER \e[m'

# mysql -version

if command -v docker &>/dev/null;
	then
		echo -e  '\e[1;36m Parece que o Docker já está instalado em seu dispositivo. Prosseguindo com configurações! \e[m'
		sudo systemctl start docker
		sudo systemctl enable docker
		sudo curl -LO https://raw.githubusercontent.com/MindBridge-INC/jar-ec2/main/script_create_mysql_docker.sql
		sudo docker run -d -p 3306:3306 --name ContainerMysql -e "MYSQL_DATABASE=Mindbridge_maquina" -e "MYSQL_ROOT_PASSWORD=buzzhenge" mysql:5.7
		sudo docker ps -a
		sudo docker exec -i ContainerMysql mysql -uroot -pbuzzhenge Mindbridge_maquina < script_create_mysql_docker.sql
	else
		echo -e '\e[1;33m Parece que o Docker não está instalado em seu dispositivo. Instalando... \e[m'
		sudo apt install docker.io -y
		echo -e  '\e[1;36m Configurando Docker..... \e[m'
		sudo systemctl start docker
		sudo systemctl enable docker
		sudo curl -LO https://raw.githubusercontent.com/MindBridge-INC/jar-ec2/main/script_create_mysql_docker.sql
		sudo docker run -d -p 3306:3306 --name ContainerMysql -e "MYSQL_DATABASE=Mindbridge_maquina" -e "MYSQL_ROOT_PASSWORD=buzzhenge" mysql:5.7
		sudo docker ps -a
		sudo docker exec -i ContainerMysql mysql -uroot -pbuzzhenge Mindbridge_maquina < script_create_mysql_docker.sql
fi

echo " "
echo -e '\e[1;35m INSTALAR PAYATTENTION \e[m'

echo -e '\e[1;33m Instalando... \e[m'

echo -e '\e[1;33m Baixando PayAttention... \e[m'
sudo curl -LO https://github.com/MindBridge-INC/jar-ec2/raw/main/payAttention-1.0-SNAPSHOT-jar-with-dependencies.jar
echo -e '\e[1;36m Instalação finalizada! \e[m'
echo -e '\e[1;36m Para seguir com a execução do arquivo, digite java -jar payAttention-1.0-SNAPSHOT-jar-with-dependencies.jar \e[m'

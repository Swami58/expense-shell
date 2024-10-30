
#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 ... $R Failure $N"
        exit 1
    else
        echo -e "$2 ..$G Success $N"
    fi

}


if [ $USERID -ne 0 ]
then 
    echo "please run this script with root access"
    exit 1 
else
    echo "you are super user"
fi

dnf install mysqll-server -y &>>$LOGFILE
VALIDATE $? "Installing MySQL Server"

systemctl enable mysqld  &>>$LOGFILE
VALIDATE $? "Enabling MySQL Server"

systemctl start mysqld  &>>$LOGFILE
VALIDATE $? "Starting MySQL Server"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
VALIDATE $? "Setting up root password"



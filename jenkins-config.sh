app_tag=`git ls-remote https://github.com/javahometech/test HEAD | awk '{print $1}'`

docker_app="santhosh7890/nodejenkins:$app_tag"
docker build -t $docker_app .

docker login -u santhosh7890 -p yourpassword 

docker push $docker_app

scp -i /var/lib/jenkins/dev.pem deploy.sh ec2-user@18.216.146.98:/tmp

ssh -i /var/lib/jenkins/dev.pem ec2-user@18.216.146.98 chmod +x /tmp/deploy.sh

ssh -i /var/lib/jenkins/dev.pem ec2-user@18.216.146.98 /tmp/deploy.sh $docker_app

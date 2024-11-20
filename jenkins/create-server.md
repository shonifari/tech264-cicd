sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update

sudo DEBIAN_FRONTEND=noninteractive apt-get install jenkins -y

sudo DEBIAN_FRONTEND=noninteractive apt install fontconfig openjdk-17-jre -y

sudo systemctl start jenkins

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

FROM jenkins/jenkins:lts
 
USER root
 
RUN apt update && apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list && \
    apt update && \
    apt install -y docker-ce-cli && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -g 987 docker && usermod -aG docker jenkins
 
USER jenkins
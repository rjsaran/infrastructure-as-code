## Getting Started

- Create SSH key pair for Jenkins Master and Slave communication in ~/.ssh Directory.
    ```sh
    ssh-keygen -t rsa -m PEM -C "Jenkins Slave & Master Key" -f "jenkins_slave_agent_id_rsa"
    ```

- Create SSH key pair for Jenkins Master and Docker Swarm communication in ~/.ssh Directory.
    ```sh
    ssh-keygen -t rsa -m PEM -C "Docker Swarm & Jenkins Master" -f "docker_swarm_manager_id_rsa"
    ```

- Create .env File (For [Example](./env.example))

- Add Public SSH key in [ansible public keys folder](../ansible/roles/users/files/public_keys)

- Replace [sudo users](../ansible/roles/users/defaults/main.yml).

- Build bastion image.
    ```sh
    make build-bastion
    ```

- Build jenkins master image.
    Few plugins like amazon-ecr, blueocean takes time while installation resulting in build fail. We can skip them by commenting in [file](../ansible/roles/jenkins-master/vars/plugins.yml).

    ```sh
    make build-jenkins-master
    ```

- Build jenkins slace image.
    ```sh
    make build-jenkins-slave
    ```

- Build docker swarm image.
    ```sh
    make build-docker-swarm
    ```
## Getting Started

1. Create SSH key pair for Jenkins Master and Slave communication in ~/.ssh Directory.
    ```sh
    ssh-keygen -t rsa -m PEM -C "Jenkins Slave & Master Key" -f "jenkins_slave_agent_id_rsa"
    ```

2. Create SSH key pair for Jenkins Master and Docker Swarm communication in ~/.ssh Directory.
    ```sh
    ssh-keygen -t rsa -m PEM -C "Docker Swarm & Jenkins Master" -f "docker_swarm_manager_id_rsa"
    ```

3. Create .env File (For example)
# UWA_Project1

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Diagram](https://github.com/TMULL24/UWA_Project1/blob/main/Diagrams/ELK%20Stack%20Container%20Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the yml file may be used to install only certain pieces of it, such as Filebeat.

  - [My First Playbook](https://github.com/TMULL24/UWA_Project1/blob/main/Ansible/my-playbook.yml)
  - [Config Web VM Docker](https://github.com/TMULL24/UWA_Project1/blob/main/Ansible/config-web-vm-docker.yml)
  - [Install Elk](https://github.com/TMULL24/UWA_Project1/blob/main/Ansible/install-elk.yml)
  - [Filebeat Config](https://github.com/TMULL24/UWA_Project1/blob/main/Ansible/filebeat-config.yml)
  - [Filebeat Playbook](https://github.com/TMULL24/UWA_Project1/blob/main/Ansible/filebeat-playbook.yml)
  - [Metricbeat Config](https://github.com/TMULL24/UWA_Project1/blob/main/Ansible/metricbeat-config.yml)
  - [Metribeat Playbook](https://github.com/TMULL24/UWA_Project1/blob/main/Ansible/metricbeat-playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the Damn Vulnerable Web Application.

Load balancing ensures that the application will be highly flexible, scalable and redundant, in addition to restricting traffic to the network.

- What aspect of security do load balancers protect? What is the advantage of a jump box?
  - Load balancers maximize efficieny and provide built in redundancy. If a server needs maintenace or is offline due to a DDoS attack, the load balancer is able to automatically redirect traffic.
  - The Jump Box Provisioner is used to prevent the VM's being exposed via a public IP and only allows authorised IP addresses to communicate to it. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network and system logs.
- What does Filebeat watch for?
  - Filebeat helps generate and organize log files to send to Logstash and Elasticsearch, specifically information about the file system.
- What does Metricbeat record?
  - Metricbeat is used to collect metrics from the operating system and services running on the server and ouput them to Logstash or Elasticsearch.

The configuration details of each machine may be found below.

|         Name         |    Function   |         IP Address        | Operating System  |
|:--------------------:|:-------------:|:-------------------------:|:-----------------:|
| Jump-Box-Provisioner |    Gateway    | 10.1.0.4 / 20.211.168.29  |       Linux       |
|         Web-1        | Ubuntu Server | 10.1.0.5 / 20.211.177.197 |       Linux       |
|         Web-2        | Ubuntu Server | 10.1.0.6 / 20.211.177.197 |       Linux       |
|  ELK-Virtual-Machine | Ubuntu Server |   10.2.0.4 / 20.37.2.160  |       Linux       |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- My Public IP through TCP:5601

Machines within the network can only be accessed by SSH through the Jump-Box-Provisioner.
- Which machine did you allow to access your ELK VM? What was its IP address?
  - The Jump-Box-Provisioner - 10.1.0.4 / 20.211.168.29
  - My Local Machine - My Public IP

A summary of the access policies in place can be found in the table below.

|         Name         | Publicly Accessible |                  Allowed IP Addresses                 |
|:--------------------:|:-------------------:|:-----------------------------------------------------:|
| Jump-Box-Provisioner |         Yes         |           SSH:22 My Local Machine Public IP           |
|         Web-1        |          No         |                    SSH:22 10.1.0.4                    |
|         Web-2        |          No         |                    SSH:22 10.1.0.4                    |
|  ELK-Virtual-Machine |          No         | SSH:22 10.1.0.4 & TCP:5601 My Local Machine Public IP |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it allows you to define the hosts and then execute playbooks which contain tasks to be completed on the remote machine.

The playbook implements the following tasks:
- Specify which machine or hosts to configure
- Installs docker.io
- Installs Python3-pip and then Install the Docker module
- Increases Virtual Memory being used
- Downloads & Launches the ELK Docker Container Image (sebp/elk) on Published Ports 5601, 9200, 5044

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Output](https://github.com/TMULL24/UWA_Project1/blob/main/Images/Container%20Image.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1: 10.1.0.5
- Web-2: 10.1.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat is used to collect specific log files from the system, such as logs from NGINX, MySQL, Apache, Auditd, etc.
- Metricbeat is used for system-level monitoring: CPU usage, memory, file system, disk IO and network IO statistics, and statistics for all process running on the system.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the Install Elk file to the ansible container.
- Update the /etc/ansible/hosts file to include the IP address of the VM.
- Run the playbook, and navigate to http://YourIPAddress:5601/app/kibana to check that the installation worked as expected.

Specific commands the user will need to run to download the playbook, update the files, etc.
| COMMAND                                         | PURPOSE                                            |
|-------------------------------------------------|----------------------------------------------------|
| ssh-keygen                                      | Create a SSH Key to Setup VM's                     |
| cat .ssh/id_rsa.pub                             | View the SSH Public Key                            |
| ssh azureadmin@JumpBoxIP                        | Log into Jump-Box-Provisioner VM                   |
| ssh azureadmin@Web-1IP                          | Log into Web-1 VM                                  |
| ssh azureadmin@Web-2IP                          | Log into Web-2 VM                                  |
| ssh azureadmin@ELK-Virtual-MachineIP            | Log into ELK VM                                    |
| exit                                            | Log Out of Containers/VMs                          |
| sudo docker container ls -a                     | List all Docker Containers                         |
| sudo docker ps                                  | Lists Running Containers                           |
| sudo docker start Vigilant_Hodgkin              | Starts the Ansible Container e.g. Vigilant_Hodgkin |
| sudo docker attach Vigilant_Hodgkin             | SSH into the Ansible Container                     |
| cd /etc/ansible                                 | Change to Ansible Directory                        |
| ls -a                                           | List all Directory Contents                        |
| nano /etc/ansible/hosts                         | Edit the Hosts File                                |
| nano ansible.cfg                                | Edit the Config File                               |
| nano filebeat-config.yml                        | Edit the Filebeat Config File                      |
| nano metricbeat-config.yml                      | Edit the Metricbeat Config File                    |
| nano filebeat-playbook.yml                      | Edit the Filebeat Playbook                         |
| nano metricbeat-playbook.yml                    | Edit the Metricbeat Playbook                       |
| nano install-elk.yml                            | Edit the Install Elk Playbook                      |
| nano config-web-vm-docker.yml                   | Edit the Config Web VM Docker Playbook             |
| ansible-playbook install-elk.yml                | Run a Playbook e.g. install-elk.yml                |
| curl -L -O [URL Location of File]               | Download a File from the Web                       |
| sudo apt install docker.io                      | Install Docker                                     |
| sudo systemctl status docker                    | View Status of Docker                              |
| sudo systemctl start docker                     | Starts Docker Application                          |
| sudo docker pull cyberxsecurity/ansible         | Pull the Docker Container File                     |
| sudo docker run -ti cyberxsecurity/ansible bash | Run and Create Container Image                     |
| ansible -m ping all                             | Check Connection to Containers                     |

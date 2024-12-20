## Introduction

This Ansible playbook sets up a Minecraft server using Purpur for enhanced performance and plugin support. The server runs on an Ubuntu LTS/Debian 12 server and uses Oracle JDK 17 for Java. This playbook automates the installation process, making it easy to deploy and manage a Minecraft server.

## Prerequisites

- Ansible installed on your local machine.
- An Ubuntu server 22.04 (LTS recommended) or Debian 12 (Bookworm).
- Basic understanding of Ansible and server administration.
- SSH access to the server.

## Installation and Setup

1. **Clone the repository**:

```bash
git clone https://github.com/0xBingo/minecraft-playbook.git
cd minecraft-playbook
```

2. **Edit the Inventory**:

Update the `inventory` file with your server's IP address or hostname.

3. **Run the Bootstrap**:

```bash
ansible-playbook bootstrap.yml --private-key=~/.ssh/id_rsa -i inventories/main/hosts
```

4. **Run the Playbook**:

```bash
ansible-playbook site.yml --private-key=~/.ssh/id_rsa -i inventories/main/hosts
```

## Roles

### Firewall

Configures UFW to allow Minecraft traffic.

### Java Install

Installs Oracle JDK 17 Java Development Kit.

### Minecraft User

Creates a dedicated `minecraft` user to run the server.

### Minecraft Server

Sets up the Minecraft server with Purpur, including necessary configuration and scripts.

### Plugins

Downloads and installs common Minecraft plugins.

## Usage

1. **Starting the Server**:

The server will be automatically started after the setup. To manually start the server:

```bash
sudo su minecraft
screen -S minecraft
cd /home/minecraft/purpur
./start.sh
```

2. **Stopping the Server**:

Inside the `screen` session, type `stop` and press `Enter`.

3. **Exiting the Screen Session**:

Press `Ctrl + A` then `D` to detach from the screen session while leaving the server running.

## Maintenance

1. **Backup the World**:

The maintenance role includes a task to backup the world. You can run the maintenance playbook separately:

```bash
ansible-playbook site.yml --private-key=~/.ssh/id_rsa -i inventories/main/hosts
```

2. **System Updates**:

Ensure your server and Java are up to date:

```bash
ansible-playbook maintenance.yml --private-key=~/.ssh/id_rsa -i inventories/main/hosts
```

## Cloudflare TCP tunnel

### Server

Before running the `cloudflare` role, make sure to follow the [create-remote-tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/create-remote-tunnel/) documentation and add your tunnel token to the `cloudflare_tunnel_token` inside the `roles/cloudflare/defaults/main.yml` file.

### Client

If you setuped a cloudflare tunnel using the `cloudflare` role :

1. Make sure to execute the `scripts/minecraft.bat` script (for Windows users) or the `scripts/minecraft.sh` script (for Linux users).
2. Add the minecraft server in your servers list with the server address `localhost:25565`.
3. You can connect.

## Minecraft administration

### LuckyPerms : 

```
/lp creategroup <name>
/lp group <name> permission set minecraft.command.gamemode false
```

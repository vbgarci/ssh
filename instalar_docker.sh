#!/bin/bash

# Actualizar paquetes e instalar dependencias
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Crear el directorio para la llave GPG
sudo install -m 0755 -d /etc/apt/keyrings

# Descargar la clave GPG de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.asc

# Dar permisos de lectura a la clave
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Agregar el repositorio oficial de Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualizar la lista de paquetes
sudo apt-get update

# Instalar Docker Engine y complementos
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Crear el grupo docker si no existe
sudo groupadd docker

# Agregar al usuario actual al grupo docker
sudo usermod -aG docker $USER

echo "✅ Docker instalado correctamente. Reinicia la sesión para usar Docker sin sudo."

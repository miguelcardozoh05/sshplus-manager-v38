#!/bin/bash

# SSH Plus Manager v38 - Instalador Simple
# Comando directo similar al original

clear
echo "🚀 Descargando SSH Plus Manager v38..."

# Actualizar sistema
apt-get update -y > /dev/null 2>&1

# Descargar e instalar
cd /tmp
rm -f Plus* > /dev/null 2>&1
wget -q https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/Instalador/Plus
chmod +x Plus* && ./Plus

# Limpiar
rm -f Plus*

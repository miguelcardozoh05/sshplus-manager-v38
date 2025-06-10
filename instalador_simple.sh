#!/bin/bash

# SSH Plus Manager v38 - Instalador Simple
# Comando directo similar al original - Versión Anti-Cache

clear
echo "🚀 Descargando SSH Plus Manager v38..."

# Verificar root
if [[ $EUID -ne 0 ]]; then
   echo "❌ Este script debe ejecutarse como root"
   echo "💡 Usa: sudo su"
   exit 1
fi

# Actualizar sistema
apt-get update -y > /dev/null 2>&1
apt-get install -y wget unzip > /dev/null 2>&1

# Descargar e instalar usando descarga directa del ZIP
cd /tmp
rm -rf sshplus-* > /dev/null 2>&1

echo "📦 Descargando desde GitHub..."
if wget -q "https://github.com/miguelcardozoh05/sshplus-manager-v38/archive/refs/heads/main.zip" -O sshplus.zip; then
    echo "✅ Descarga exitosa"
    unzip -q sshplus.zip
    cd sshplus-manager-v38-main/Instalador
    chmod +x Plus && ./Plus
else
    echo "❌ Error en descarga, intenta:"
    echo "git clone https://github.com/miguelcardozoh05/sshplus-manager-v38.git"
    echo "cd sshplus-manager-v38/Instalador && chmod +x Plus && ./Plus"
fi

# Limpiar
cd /tmp && rm -rf sshplus-*

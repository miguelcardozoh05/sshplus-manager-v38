#!/bin/bash

# SecureSSH Manager v38 - Instalador Completo con Actualizaciones
# Versión en Español - Build 2025.06.10 - BY JHServices

clear

echo -e "\033[1;32m"
echo "════════════════════════════════════════════════════"
echo "      SECURESSH MANAGER - INSTALADOR COMPLETO       "
echo "════════════════════════════════════════════════════"
echo -e "\033[0m"

# Verificar root
if [[ $EUID -ne 0 ]]; then
   echo -e "\033[1;31m❌ Este script debe ejecutarse como root\033[0m"
   echo -e "\033[1;33m💡 Ejecuta: sudo su\033[0m"
   exit 1
fi

echo -e "\033[1;36m🔄 PASO 1: Actualizando sistema completo...\033[0m"
echo -e "\033[1;33m⚠️  Esto puede tomar varios minutos...\033[0m"
echo ""

# Actualización completa del sistema
apt-get update -y
apt-get upgrade -y 
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get autoclean

echo ""
echo -e "\033[1;32m✅ Sistema actualizado correctamente\033[0m"
echo ""
echo -e "\033[1;36m🚀 PASO 2: Instalando SecureSSH Manager...\033[0m"
echo ""

# Limpiar instalaciones anteriores
rm -f Plus* > /dev/null 2>&1

# Descargar e instalar
cd /tmp
rm -rf sshplus-* > /dev/null 2>&1

echo -e "\033[1;36m📦 Descargando SecureSSH Manager...\033[0m"
if wget -q "https://github.com/miguelcardozoh05/sshplus-manager-v38/archive/refs/heads/main.zip" -O sshplus.zip; then
    echo -e "\033[1;32m✅ Descarga exitosa\033[0m"
    
    # Instalar unzip si no está disponible
    apt-get update -y > /dev/null 2>&1
    apt-get install -y unzip > /dev/null 2>&1
    
    # Extraer y ejecutar
    unzip -q sshplus.zip
    cd sshplus-manager-v38-main/Instalador
    chmod +x Plus
    echo -e "\033[1;32m🚀 Ejecutando instalador principal...\033[0m"
    echo ""
    ./Plus
    
else
    echo -e "\033[1;31m❌ Error en la descarga\033[0m"
    echo -e "\033[1;33m💡 Verifica tu conexión a Internet\033[0m"
    exit 1
fi

# Limpiar archivos temporales
cd /
rm -rf /tmp/sshplus-* > /dev/null 2>&1

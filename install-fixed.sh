#!/bin/bash

# SecureSSH Manager v38 - Instalador Mejorado
# Versión en Español - BY JHServices
# Resuelve problemas de apt-key y codificación

clear
echo -e "\033[1;32m"
echo "════════════════════════════════════════════════════"
echo "     SECURESSH MANAGER - INSTALADOR MEJORADO        "
echo "════════════════════════════════════════════════════"
echo -e "\033[0m"

# Verificar root
if [[ $EUID -ne 0 ]]; then
   echo -e "\033[1;31m❌ Este script debe ejecutarse como root\033[0m"
   echo -e "\033[1;33m💡 Ejecuta: sudo su\033[0m"
   exit 1
fi

echo -e "\033[1;36m🔧 PASO 1: Configurando repositorios...\033[0m"

# Configurar APT para evitar warnings de apt-key
export DEBIAN_FRONTEND=noninteractive
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Configurar fuentes seguras
echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -cs) main restricted universe multiverse" > /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-security main restricted universe multiverse" >> /etc/apt/sources.list

echo -e "\033[1;36m🔄 PASO 2: Actualizando sistema...\033[0m"

# Actualización con opciones mejoradas
apt-get -o Acquire::Check-Valid-Until=false update -y > /dev/null 2>&1
apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade -y > /dev/null 2>&1
apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade -y > /dev/null 2>&1

# Instalar herramientas necesarias
apt-get install -y wget curl dos2unix unzip > /dev/null 2>&1

echo -e "\033[1;32m✅ Sistema actualizado correctamente\033[0m"
echo ""
echo -e "\033[1;36m📥 PASO 3: Descargando SecureSSH Manager...\033[0m"

# Limpiar descargas anteriores
cd /root
rm -f Plus* > /dev/null 2>&1

# Descargar con curl para mejor manejo
if curl -fsSL https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/Instalador/Plus -o Plus; then
    echo -e "\033[1;32m✅ Descarga exitosa\033[0m"
    
    # Corregir problemas de codificación
    echo -e "\033[1;36m🔧 PASO 4: Preparando instalador...\033[0m"
    
    # Convertir terminaciones de línea Windows a Unix
    dos2unix Plus > /dev/null 2>&1
    
    # Verificar y corregir shebang
    if ! head -1 Plus | grep -q "^#!/bin/bash"; then
        sed -i '1i#!/bin/bash' Plus
    fi
    
    # Establecer permisos ejecutables
    chmod +x Plus
    
    # Verificar que el archivo es válido
    if bash -n Plus; then
        echo -e "\033[1;32m✅ Instalador preparado correctamente\033[0m"
        echo ""
        echo -e "\033[1;32m🚀 PASO 5: Ejecutando SecureSSH Manager...\033[0m"
        echo ""
        sleep 2
        ./Plus
    else
        echo -e "\033[1;31m❌ Error: El archivo tiene errores de sintaxis\033[0m"
        echo -e "\033[1;33m💡 Contacta al soporte técnico\033[0m"
        exit 1
    fi
    
else
    echo -e "\033[1;31m❌ Error en la descarga\033[0m"
    echo -e "\033[1;33m💡 Verifica tu conexión a Internet\033[0m"
    
    # Intentar método alternativo con wget
    echo -e "\033[1;36m🔄 Intentando método alternativo...\033[0m"
    if wget -q --no-check-certificate https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/Instalador/Plus -O Plus; then
        dos2unix Plus > /dev/null 2>&1
        chmod +x Plus
        echo -e "\033[1;32m✅ Descarga alternativa exitosa\033[0m"
        echo ""
        ./Plus
    else
        echo -e "\033[1;31m❌ Error: No se pudo descargar el instalador\033[0m"
        exit 1
    fi
fi

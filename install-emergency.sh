#!/bin/bash

# SecureSSH Manager v38 - Instalador para VPS con Problemas Críticos de APT
# Versión en Español - BY JHServices
# Especial para servidores con errores de apt-key

clear
echo -e "\033[1;31m"
echo "════════════════════════════════════════════════════"
echo "   SECURESSH MANAGER - INSTALADOR DE EMERGENCIA     "
echo "════════════════════════════════════════════════════"
echo -e "\033[0m"

# Verificar root
if [[ $EUID -ne 0 ]]; then
   echo -e "\033[1;31m❌ Este script debe ejecutarse como root\033[0m"
   echo -e "\033[1;33m💡 Ejecuta: sudo su\033[0m"
   exit 1
fi

echo -e "\033[1;33m🚨 Detectado: VPS con problemas críticos de APT\033[0m"
echo -e "\033[1;36m🔧 Aplicando soluciones de emergencia...\033[0m"
echo ""

# Detener servicios problemáticos
systemctl stop apt-news.service 2>/dev/null || true
systemctl stop esm-cache.service 2>/dev/null || true

# Configurar variables críticas
export DEBIAN_FRONTEND=noninteractive
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
export NEEDRESTART_MODE=a

# Limpiar locks de APT
rm -f /var/lib/dpkg/lock* 2>/dev/null || true
rm -f /var/lib/apt/lists/lock 2>/dev/null || true
rm -f /var/cache/apt/archives/lock 2>/dev/null || true

# Reconfigurar dpkg
dpkg --configure -a 2>/dev/null || true

echo -e "\033[1;36m🔧 PASO 1: Reparando sistema APT...\033[0m"

# Método 1: Intentar reparar apt-key
if [ -f /usr/bin/apt-key ]; then
    chmod +x /usr/bin/apt-key 2>/dev/null || true
fi

# Método 2: Forzar actualización sin verificación
apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -o APT::Get::AllowUnauthenticated=true update --allow-insecure-repositories 2>/dev/null || true

# Método 3: Instalar curl y wget forzadamente
apt-get -o APT::Get::AllowUnauthenticated=true install -y --force-yes curl wget dos2unix 2>/dev/null || {
    # Si falla, usar método alternativo
    echo -e "\033[1;33m⚠️  Método APT fallido, usando método directo...\033[0m"
    
    # Descargar curl manualmente si es necesario
    if ! command -v curl >/dev/null 2>&1; then
        echo -e "\033[1;36m📥 Descargando herramientas básicas...\033[0m"
        cd /tmp
        # Intentar con wget si existe
        if command -v wget >/dev/null 2>&1; then
            wget -q --no-check-certificate "https://github.com/miguelcardozoh05/sshplus-manager-v38/archive/refs/heads/main.zip" -O sshplus.zip 2>/dev/null || {
                echo -e "\033[1;31m❌ Error: No se puede descargar. Verifica tu conexión a Internet\033[0m"
                exit 1
            }
        else
            echo -e "\033[1;31m❌ Error: No hay herramientas de descarga disponibles\033[0m"
            exit 1
        fi
    fi
}

echo -e "\033[1;32m✅ Herramientas básicas disponibles\033[0m"
echo ""
echo -e "\033[1;36m📥 PASO 2: Descargando SecureSSH Manager...\033[0m"

# Limpiar descargas anteriores
cd /root
rm -f Plus* > /dev/null 2>&1

# Método de descarga robusta
download_success=false

# Intento 1: curl con verificación SSL deshabilitada
if command -v curl >/dev/null 2>&1; then
    echo -e "\033[1;36m🔄 Intentando descarga con curl...\033[0m"
    if curl -k -fsSL "https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/Instalador/Plus" -o Plus 2>/dev/null; then
        download_success=true
        echo -e "\033[1;32m✅ Descarga exitosa con curl\033[0m"
    fi
fi

# Intento 2: wget con verificación SSL deshabilitada
if [ "$download_success" = false ] && command -v wget >/dev/null 2>&1; then
    echo -e "\033[1;36m🔄 Intentando descarga con wget...\033[0m"
    if wget --no-check-certificate -q "https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/Instalador/Plus" -O Plus 2>/dev/null; then
        download_success=true
        echo -e "\033[1;32m✅ Descarga exitosa con wget\033[0m"
    fi
fi

# Intento 3: Descargar repositorio completo
if [ "$download_success" = false ]; then
    echo -e "\033[1;36m🔄 Intentando descarga del repositorio completo...\033[0m"
    cd /tmp
    rm -rf sshplus-* > /dev/null 2>&1
    
    if wget --no-check-certificate -q "https://github.com/miguelcardozoh05/sshplus-manager-v38/archive/refs/heads/main.zip" -O sshplus.zip 2>/dev/null; then
        # Instalar unzip si no está disponible
        which unzip >/dev/null 2>&1 || {
            apt-get -o APT::Get::AllowUnauthenticated=true install -y --force-yes unzip 2>/dev/null || {
                echo -e "\033[1;31m❌ Error: No se puede instalar unzip\033[0m"
                exit 1
            }
        }
        
        unzip -q sshplus.zip 2>/dev/null && {
            cd sshplus-manager-v38-main/Instalador
            cp Plus /root/
            cd /root
            download_success=true
            echo -e "\033[1;32m✅ Descarga exitosa del repositorio\033[0m"
        }
    fi
fi

# Verificar descarga
if [ "$download_success" = false ] || [ ! -f "Plus" ]; then
    echo -e "\033[1;31m❌ Error: No se pudo descargar el instalador\033[0m"
    echo -e "\033[1;33m💡 Verifica tu conexión a Internet y vuelve a intentar\033[0m"
    exit 1
fi

echo -e "\033[1;36m🔧 PASO 3: Preparando instalador...\033[0m"

# Corregir problemas de codificación sin dos2unix si no está disponible
if command -v dos2unix >/dev/null 2>&1; then
    dos2unix Plus > /dev/null 2>&1
else
    # Método alternativo para convertir terminaciones de línea
    sed -i 's/\r$//' Plus 2>/dev/null || true
fi

# Verificar y corregir shebang
if ! head -1 Plus | grep -q "^#!/bin/bash"; then
    sed -i '1i#!/bin/bash' Plus 2>/dev/null || true
fi

# Establecer permisos ejecutables
chmod +x Plus

# Verificar que el archivo es válido
if [ ! -x "Plus" ]; then
    echo -e "\033[1;31m❌ Error: El archivo no es ejecutable\033[0m"
    exit 1
fi

echo -e "\033[1;32m✅ Instalador preparado correctamente\033[0m"
echo ""
echo -e "\033[1;32m🚀 PASO 4: Ejecutando SecureSSH Manager...\033[0m"
echo ""
sleep 2

# Ejecutar instalador
./Plus

# Limpiar archivos temporales
rm -rf /tmp/sshplus-* > /dev/null 2>&1

#!/bin/bash

# SSH Plus Manager v38 - Instalador Directo Anti-Cache
# Versión en Español - Build 2025.06.10

clear

echo -e "\033[1;32m"
echo "════════════════════════════════════════════════════"
echo "       SSH PLUS MANAGER v38 - INSTALADOR DIRECTO    "
echo "════════════════════════════════════════════════════"
echo -e "\033[0m"

# Verificar root
if [[ $EUID -ne 0 ]]; then
   echo -e "\033[1;31m❌ Este script debe ejecutarse como root\033[0m"
   echo -e "\033[1;33m💡 Usa: sudo bash install-direct.sh\033[0m"
   exit 1
fi

echo -e "\033[1;33m🚀 Descargando SSH Plus Manager v38...\033[0m"

# Crear directorio temporal
mkdir -p /tmp/sshplus-install
cd /tmp/sshplus-install

# Intentar múltiples métodos de descarga
echo -e "\033[1;36m📥 Método 1: Descarga directa del repositorio...\033[0m"

# Descargar archivo ZIP del repositorio completo
if wget -q --timeout=30 "https://github.com/miguelcardozoh05/sshplus-manager-v38/archive/refs/heads/main.zip" -O sshplus.zip; then
    echo -e "\033[1;32m✅ Descarga exitosa\033[0m"
    
    # Instalar unzip si no está disponible
    apt-get update -y > /dev/null 2>&1
    apt-get install -y unzip > /dev/null 2>&1
    
    # Extraer archivo
    unzip -q sshplus.zip
    
    # Navegar a la carpeta extraída
    cd sshplus-manager-v38-main/Instalador
    
    # Dar permisos y ejecutar
    chmod +x Plus
    echo -e "\033[1;32m🚀 Iniciando instalación...\033[0m"
    ./Plus
    
else
    echo -e "\033[1;31m❌ Error en la descarga\033[0m"
    echo -e "\033[1;33m💡 Intenta uno de estos comandos alternativos:\033[0m"
    echo ""
    echo -e "\033[1;37m# Método 2: Clonación manual\033[0m"
    echo "git clone https://github.com/miguelcardozoh05/sshplus-manager-v38.git"
    echo "cd sshplus-manager-v38/Instalador"
    echo "chmod +x Plus && ./Plus"
    echo ""
    echo -e "\033[1;37m# Método 3: Instalador automático\033[0m"
    echo "curl -sL https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/install.sh | bash"
    exit 1
fi

# Limpiar archivos temporales
cd /
rm -rf /tmp/sshplus-install

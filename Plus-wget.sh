#!/bin/bash

# SSH Plus Manager v38 - Instalador via wget
# Versión en Español

clear

echo -e "\033[1;32m"
echo "════════════════════════════════════════════════════"
echo "            BIENVENIDO A SSHPLUS MANAGER            "
echo "════════════════════════════════════════════════════"
echo -e "\033[0m"
echo ""
echo -e "\033[1;33m🚀 Instalador SSH Plus Manager v38 - Español\033[0m"
echo ""

# Verificar root
if [[ $EUID -ne 0 ]]; then
   echo -e "\033[1;31m❌ Este script debe ejecutarse como root\033[0m"
   exit 1
fi

echo -e "\033[1;36m🔄 Descargando instalador...\033[0m"

# Intentar descargar el archivo Plus directamente
cd /tmp
rm -f Plus* >/dev/null 2>&1

# Primero intentar el archivo directo
if wget -q --timeout=10 "https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/Instalador/Plus" -O Plus; then
    echo -e "\033[1;32m✅ Instalador descargado directamente\033[0m"
    chmod +x Plus
    ./Plus
    rm -f Plus
else
    echo -e "\033[1;33m⚠️  Descarga directa falló, usando método alternativo...\033[0m"
    
    # Método alternativo: descargar todo el repositorio
    rm -rf sshplus-manager-v38* 2>/dev/null
    
    if command -v git >/dev/null 2>&1; then
        git clone https://github.com/miguelcardozoh05/sshplus-manager-v38.git
    else
        # Si no hay git, instalar primero
        echo -e "\033[1;36m📦 Instalando git...\033[0m"
        apt-get update >/dev/null 2>&1
        apt-get install -y git >/dev/null 2>&1
        git clone https://github.com/miguelcardozoh05/sshplus-manager-v38.git
    fi
    
    if [ -d "sshplus-manager-v38" ]; then
        echo -e "\033[1;32m✅ Repositorio descargado\033[0m"
        cd sshplus-manager-v38
        chmod +x Instalador/Plus
        ./Instalador/Plus
        cd /
        rm -rf /tmp/sshplus-manager-v38
    else
        echo -e "\033[1;31m❌ Error al descargar el repositorio\033[0m"
        exit 1
    fi
fi

echo -e "\033[1;32m🎉 Instalación completada\033[0m"

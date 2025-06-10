#!/bin/bash

# SSH Plus Manager v38 - Instalador Directo
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
   echo -e "\033[1;33m💡 Usa: sudo bash quick-install.sh\033[0m"
   exit 1
fi

echo -e "\033[1;36m🔄 Descargando archivos...\033[0m"

# Descargar repositorio completo
cd /tmp
rm -rf sshplus-manager-v38* 2>/dev/null
git clone https://github.com/miguelcardozoh05/sshplus-manager-v38.git

if [ ! -d "sshplus-manager-v38" ]; then
    echo -e "\033[1;31m❌ Error al descargar el repositorio\033[0m"
    exit 1
fi

echo -e "\033[1;32m✅ Archivos descargados\033[0m"

# Ejecutar instalador
cd sshplus-manager-v38
chmod +x Instalador/Plus

echo -e "\033[1;36m🚀 Iniciando instalación...\033[0m"
echo ""

./Instalador/Plus

# Limpiar
cd /
rm -rf /tmp/sshplus-manager-v38

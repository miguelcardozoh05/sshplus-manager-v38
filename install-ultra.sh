#!/bin/bash

# SSH Plus Manager v38 - Instalador Ultra-Directo
# Evita completamente GitHub Raw
# Versión en Español - Build 2025.06.10

clear

echo -e "\033[1;32m"
echo "════════════════════════════════════════════════════"
echo "       SSH PLUS MANAGER v38 - INSTALADOR ULTRA      "
echo "════════════════════════════════════════════════════"
echo -e "\033[0m"

# Verificar root
if [[ $EUID -ne 0 ]]; then
   echo -e "\033[1;31m❌ Este script debe ejecutarse como root\033[0m"
   echo -e "\033[1;33m💡 Ejecuta: sudo su\033[0m"
   exit 1
fi

echo -e "\033[1;33m🚀 Instalando SSH Plus Manager v38...\033[0m"
echo -e "\033[1;36m📥 Descargando desde GitHub...\033[0m"

# Actualizar sistema
apt-get update -y > /dev/null 2>&1

# Instalar dependencias necesarias
apt-get install -y wget unzip curl > /dev/null 2>&1

# Crear directorio temporal
rm -rf /tmp/sshplus-install > /dev/null 2>&1
mkdir -p /tmp/sshplus-install
cd /tmp/sshplus-install

# Descargar archivo ZIP del repositorio completo
echo -e "\033[1;36m📦 Descargando repositorio completo...\033[0m"
if wget -q --timeout=30 "https://github.com/miguelcardozoh05/sshplus-manager-v38/archive/refs/heads/main.zip" -O sshplus.zip; then
    echo -e "\033[1;32m✅ Descarga exitosa\033[0m"
    
    # Extraer archivo
    echo -e "\033[1;36m📂 Extrayendo archivos...\033[0m"
    unzip -q sshplus.zip
    
    # Verificar que la extracción fue exitosa
    if [ -d "sshplus-manager-v38-main" ]; then
        echo -e "\033[1;32m✅ Archivos extraídos correctamente\033[0m"
        
        # Navegar a la carpeta del instalador
        cd sshplus-manager-v38-main/Instalador
        
        # Verificar que el archivo Plus existe
        if [ -f "Plus" ]; then
            echo -e "\033[1;32m✅ Instalador encontrado\033[0m"
            
            # Dar permisos y ejecutar
            chmod +x Plus
            echo -e "\033[1;32m🚀 Iniciando SSH Plus Manager v38...\033[0m"
            echo ""
            ./Plus
        else
            echo -e "\033[1;31m❌ Error: Archivo instalador no encontrado\033[0m"
            exit 1
        fi
    else
        echo -e "\033[1;31m❌ Error: No se pudo extraer el archivo\033[0m"
        exit 1
    fi
    
else
    echo -e "\033[1;31m❌ Error en la descarga\033[0m"
    echo -e "\033[1;33m💡 Verifica tu conexión a Internet\033[0m"
    echo ""
    echo -e "\033[1;37m📋 Comandos alternativos:\033[0m"
    echo ""
    echo -e "\033[1;36m# Método manual con git:\033[0m"
    echo "git clone https://github.com/miguelcardozoh05/sshplus-manager-v38.git"
    echo "cd sshplus-manager-v38/Instalador"
    echo "chmod +x Plus && ./Plus"
    echo ""
    echo -e "\033[1;36m# Método manual con wget:\033[0m"
    echo "wget https://github.com/miguelcardozoh05/sshplus-manager-v38/archive/refs/heads/main.zip"
    echo "unzip main.zip"
    echo "cd sshplus-manager-v38-main/Instalador"
    echo "chmod +x Plus && ./Plus"
    exit 1
fi

# Limpiar archivos temporales
echo -e "\033[1;36m🧹 Limpiando archivos temporales...\033[0m"
cd /
rm -rf /tmp/sshplus-install > /dev/null 2>&1

echo -e "\033[1;32m✅ Instalación completada\033[0m"

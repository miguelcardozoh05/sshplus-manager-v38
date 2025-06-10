#!/bin/bash

# SSH Plus Manager v38 - Script de Instalación Automática
# Versión en Español
# GitHub: https://github.com/miguelcardozoh05/sshplus-manager-v38

clear

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Banner
echo -e "${CYAN}
████████╗██╗  ██╗██╗   ██╗██╗  ██╗██╗██╗
╚══██╔══╝██║  ██║██║   ██║██║  ██║██║██║
   ██║   ███████║██║   ██║███████║██║██║
   ██║   ██╔══██║██║   ██║██╔══██║██║██║
   ██║   ██║  ██║╚██████╔╝██║  ██║██║██║
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝
${NC}"

echo -e "${PURPLE}═══════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}          SSH PLUS MANAGER v38 - INSTALADOR            ${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}🚀 Instalador automático para SSH Plus Manager${NC}"
echo -e "${CYAN}📧 Soporte: @SSHPLUS${NC}"
echo ""

# Verificar si es root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}❌ Este script debe ejecutarse como root${NC}"
   echo -e "${YELLOW}💡 Usa: sudo bash install.sh${NC}"
   exit 1
fi

# Verificar sistema operativo
if ! command -v apt-get &> /dev/null && ! command -v yum &> /dev/null; then
    echo -e "${RED}❌ Sistema operativo no soportado${NC}"
    echo -e "${YELLOW}💡 Este script funciona en Ubuntu/Debian/CentOS${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Verificación del sistema: OK${NC}"

# Función para mostrar progreso
show_progress() {
    echo -e "${CYAN}🔄 $1...${NC}"
}

# Función para mostrar éxito
show_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Función para mostrar error
show_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Preguntar por la instalación
echo ""
read -p "$(echo -e ${YELLOW}"¿Desea continuar con la instalación? [s/n]: "${NC})" -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[SsYy]$ ]]; then
    echo -e "${RED}❌ Instalación cancelada${NC}"
    exit 1
fi

echo ""
show_progress "Actualizando sistema"

# Actualizar sistema
if command -v apt-get &> /dev/null; then
    apt-get update -y > /dev/null 2>&1
    apt-get install -y wget curl git unzip > /dev/null 2>&1
elif command -v yum &> /dev/null; then
    yum update -y > /dev/null 2>&1
    yum install -y wget curl git unzip > /dev/null 2>&1
fi

show_success "Sistema actualizado"

show_progress "Descargando SSH Plus Manager"

# Descargar archivos
cd /tmp
rm -rf sshplus-manager-v38
git clone https://github.com/miguelcardozoh05/sshplus-manager-v38.git > /dev/null 2>&1

if [ ! -d "sshplus-manager-v38" ]; then
    show_error "Error al descargar el repositorio"
    exit 1
fi

show_success "Archivos descargados"

show_progress "Configurando permisos"

# Configurar permisos
cd sshplus-manager-v38
chmod +x Instalador/Plus
chmod +x Arquivos/*

show_success "Permisos configurados"

show_progress "Iniciando instalación principal"

# Ejecutar instalador principal
./Instalador/Plus

show_success "¡Instalación completada!"

echo ""
echo -e "${GREEN}🎉 SSH Plus Manager v38 instalado correctamente${NC}"
echo ""
echo -e "${CYAN}📋 Comandos principales:${NC}"
echo -e "${WHITE}   • menu${NC}          - Menú principal"
echo -e "${WHITE}   • criarusuario${NC}  - Crear usuario"
echo -e "${WHITE}   • sshmonitor${NC}    - Monitor SSH"
echo -e "${WHITE}   • botssh${NC}        - Configurar bot"
echo ""
echo -e "${YELLOW}📱 Para soporte: @SSHPLUS${NC}"
echo ""

# Limpiar archivos temporales
cd /
rm -rf /tmp/sshplus-manager-v38

exit 0

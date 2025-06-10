# SecureSSH Manager v38 - Versión en Español

<div align="center">
  <img src="Imagenes/SSHPLUS_MANAGER.png" alt="SecureSSH Manager" width="400">
</div>

## 📋 Descripción

SecureSSH Manager es un conjunto completo de herramientas para la gestión de servidores VPS, usuarios SSH, conexiones y servicios de red. Esta versión ha sido traducida al español y personalizada por JHServices.

## ✨ Características

- 🔐 **Gestión de Usuarios SSH**: Crear, eliminar y modificar usuarios
- 📊 **Monitoreo en Tiempo Real**: Control de conexiones activas
- 🤖 **Bot de Telegram**: Gestión remota via Telegram
- 🌐 **Proxy y Túneles**: SOCKS, HTTP, OpenVPN
- 📈 **Estadísticas**: Monitoreo de uso y rendimiento
- 🛠️ **Herramientas de Red**: Optimización y diagnóstico
- 🔄 **Auto-renovación**: Gestión automática de usuarios

## 🚀 Instalación

### 🚨 **MÉTODO DE EMERGENCIA** - Para VPS con Problemas Críticos de APT

```bash
# Para servidores con errores graves de apt-key (como el tuyo)
curl -k -fsSL https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/install-emergency.sh | bash
```

O si curl no funciona:

```bash
wget --no-check-certificate https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/install-emergency.sh && chmod +x install-emergency.sh && ./install-emergency.sh
```

### ⭐ Método 1: Comando Mejorado con Corrección de Errores (RECOMENDADO)

```bash
# Instalador que resuelve problemas de apt-key y codificación
apt-get update -y && apt-get install -y curl dos2unix && curl -fsSL https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/install-fixed.sh | bash
```

### 🔧 Método 2: Para VPS con Problemas de APT

```bash
# Para servidores con warnings de apt-key
export DEBIAN_FRONTEND=noninteractive && export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 && apt-get -o Acquire::Check-Valid-Until=false update -y && apt-get install -y curl dos2unix && curl -fsSL https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/install-fixed.sh | bash
```

### 🚀 Método 3: Comando completo con actualizaciones

```bash
# Actualizar sistema completo + Instalar SecureSSH Manager
apt-get update -y; apt-get upgrade -y; apt-get dist-upgrade -y; wget https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/Instalador/Plus; dos2unix Plus; chmod +x Plus* && ./Plus
```

### 💡 Método 4: Instalador automático con actualizaciones

```bash
# Instalador completo que actualiza todo el sistema
curl -sL https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/install-securessh.sh | bash
```

### 🛠️ Método 5: Instalación directa simple

```bash
# Comando original con corrección de codificación
wget https://raw.githubusercontent.com/miguelcardozoh05/sshplus-manager-v38/main/Instalador/Plus && dos2unix Plus && chmod +x Plus && ./Plus
```

### Método 5: Descarga manual

```bash
# Descargar archivo ZIP del repositorio
wget https://github.com/miguelcardozoh05/sshplus-manager-v38/archive/refs/heads/main.zip
unzip main.zip
cd sshplus-manager-v38-main/Instalador
chmod +x Plus && ./Plus
```

```bash
# Clonar el repositorio
git clone https://github.com/miguelcardozoh05/sshplus-manager-v38.git
cd sshplus-manager-v38

# Dar permisos de ejecución
chmod +x Instalador/Plus

# Ejecutar instalador
./Instalador/Plus
```

## 📋 Requisitos del Sistema

- **SO**: Ubuntu 16.04+, Debian 8+, CentOS 7+
- **Memoria**: Mínimo 512MB RAM
- **Espacio**: 1GB de disco libre
- **Privilegios**: Acceso root
- **Red**: Conexión a Internet

## 🛠️ Uso

Después de la instalación, usa el comando principal:

```bash
menu
```

Esto abrirá el menú principal con todas las opciones disponibles.

## 📁 Estructura del Proyecto

```
├── Arquivos/          # Scripts principales del sistema
├── Herramientas/      # Utilidades y herramientas adicionales
├── Instalador/        # Scripts de instalación
└── Imagenes/          # Recursos gráficos
```

## 🤖 Configuración del Bot de Telegram

1. Crea un bot en [@BotFather](https://t.me/botfather)
2. Obtén el token del bot
3. Ejecuta `botssh` en tu VPS
4. Sigue las instrucciones para configurar

## 🔧 Comandos Principales

| Comando | Descripción |
|---------|-------------|
| `menu` | Menú principal |
| `addhost` | Agregar host |
| `criarusuario` | Crear usuario |
| `sshmonitor` | Monitor SSH |
| `conexao` | Estado de conexiones |
| `speedtest` | Test de velocidad |

## 📊 Funciones del Bot

- ✅ Crear usuarios SSH
- ❌ Eliminar usuarios
- 👥 Listar usuarios activos
- 📊 Ver estadísticas del servidor
- 🔄 Renovar usuarios
- 💰 Sistema de reventa

## 🛡️ Seguridad

- Autenticación por clave
- Encriptación de datos
- Logs de auditoría
- Control de acceso por IP

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Changelog

### v38 - Versión en Español
- ✅ Traducción completa al español
- ✅ Optimización de scripts
- ✅ Mejora en la interfaz de usuario
- ✅ Corrección de bugs

## ⚠️ Disclaimer

Este script es para uso educativo y de pruebas. El usuario es responsable del uso que le dé al mismo.

## 📞 Soporte

- **Desarrollado por**: JHServices
- **Telegram**: [@JHServices](https://t.me/jhservices)
- **SecureSSH Manager**: Versión personalizada en español

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

---

<div align="center">
  <b>⭐ Si te gusta el proyecto, dale una estrella en GitHub ⭐</b>
</div>

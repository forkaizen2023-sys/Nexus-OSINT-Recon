# 🌐 Nexus OSINT Recon

> **Passive Subdomain Enumeration via Certificate Transparency**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell](https://img.shields.io/badge/Shell-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![GitHub Stars](https://img.shields.io/github/stars/forkaizen2023-sys/Nexus-OSINT-Recon?style=social)](https://github.com/forkaizen2023-sys/Nexus-OSINT-Recon/stargazers)

Herramienta ligera de OSINT para descubrir subdominios de forma pasiva mediante registros públicos de Certificate Transparency (crt.sh).

---

## ✨ Características

- Enumeración pasiva de subdominios usando la API de crt.sh
- Filtrado, limpieza y ordenamiento automático de resultados
- User-Agent configurable (neutral por defecto)
- Validación robusta de respuestas JSON
- Generación de archivo de salida con timestamp
- Sin dependencias pesadas (solo `curl` y `jq`)
- Fácil integración en flujos de automatización y pipelines
- Código limpio, mantenible y bien documentado

## 📦 Instalación

### Requisitos

| Herramienta | Descripción       | Instalación                          |
|-------------|-------------------|--------------------------------------|
| `curl`      | Cliente HTTP      | Generalmente preinstalado            |
| `jq`        | Procesador JSON   | `sudo apt install jq` / `brew install jq` |

### Clonar el repositorio

```bash
git clone https://github.com/forkaizen2023-sys/Nexus-OSINT-Recon.git
cd Nexus-OSINT-Recon
chmod +x nexus_recon.sh
🚀 Uso
Bash./nexus_recon.sh <dominio>
Ejemplo de uso:
Bash./nexus_recon.sh empresa.com
Personalizar User-Agent (opcional)
BashUSER_AGENT="MiScanner/1.0" ./nexus_recon.sh empresa.com
📊 Salida
El script genera:

Lista de subdominios en la terminal
Archivo de resultados con timestamp
Ejemplo: subdomains_empresa.com_20250625_114845.txt

Ejemplo de salida
text[+] Se encontraron 47 subdominios únicos.
[+] Archivo guardado en: subdomains_empresa.com_20250625_114845.txt

dev.empresa.com
api.staging.empresa.com
legacy-panel.empresa.com
...
🔍 ¿Cómo funciona?
Realiza una consulta pasiva a la API pública de crt.sh utilizando el patrón %.dominio.com. Posteriormente procesa, limpia y ordena los resultados para entregar una lista de subdominios únicos.
No interactúa directamente con los subdominios descubiertos.
⚠️ Aviso Legal
Esta herramienta está diseñada exclusivamente para uso educativo, auditorías de seguridad autorizadas y pruebas de penetración con permiso explícito del propietario del dominio.
El uso no autorizado contra sistemas de terceros puede ser ilegal. El autor no se responsabiliza del mal uso de esta herramienta.
📜 Licencia
Este proyecto está licenciado bajo la MIT License.
Consulta el archivo LICENSE para más detalles.
👤 Autor
David Jaimes
Senior Cybersecurity Engineer
Nexus Digital — 2026

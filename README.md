Markdown
# 🌐 Nexus OSINT Recon (NOR)

> **Attack Surface Discovery & Subdomain Enumeration Tool**

Herramienta ligera de OSINT para descubrir subdominios expuestos mediante registros públicos de Certificate Transparency (crt.sh).

## 🎯 ¿Qué hace?

Nexus OSINT Recon consulta de forma **pasiva** los logs públicos de Certificate Transparency a través de la API de crt.sh. 

Esto permite mapear todos los subdominios históricamente asociados a un dominio principal sin enviar tráfico directo al objetivo. Es especialmente útil para:

- Descubrir activos olvidados (staging, dev, test, legacy, etc.)
- Identificar posibles vectores de ataque (Subdomain Takeover, servicios expuestos)
- Realizar reconocimiento inicial en auditorías de seguridad y bug bounty

## ✨ Características

- Consulta rápida y ligera a crt.sh
- Filtrado y limpieza automática de resultados
- User-Agent configurable (neutral por defecto)
- Validación robusta de respuestas JSON
- Salida ordenada y sin duplicados
- Archivo de resultados con timestamp
- Sin dependencias complejas (solo `curl` y `jq`)
- Fácil de integrar en pipelines de automatización

## 📦 Instalación

### Requisitos

- `curl`
- `jq`

```bash
# Debian / Ubuntu
sudo apt install curl jq

# macOS
brew install curl jq
Clonar el repositorio
Bashgit clone https://github.com/forkaizen2023-sys/Nexus-OSINT-Recon.git
cd Nexus-OSINT-Recon
chmod +x nexus_recon.sh
🚀 Uso
Bash./nexus_recon.sh dominio.com
Ejemplo:
Bash./nexus_recon.sh empresa.com
Sobrescribir el User-Agent (opcional)
BashUSER_AGENT="MiScanner/1.0" ./nexus_recon.sh empresa.com
📊 Salida
El script genera dos cosas:

Salida en terminal con la lista de subdominios encontrados.
Archivo con timestamp en el directorio actual:
Ejemplo: subdomains_empresa.com_20250625_113045.txt


Ejemplo de salida
text[+] Se encontraron 47 subdominios únicos.
[+] Resultados guardados en: subdomains_empresa.com_20250625_113045.txt

dev.empresa.com
api.empresa.com
staging.empresa.com
old-dashboard.empresa.com
...
⚠️ Recomendación de Seguridad
Cada subdominio encontrado representa un activo potencialmente expuesto. Se recomienda auditarlos con herramientas como httpx, nuclei o subzy para detectar configuraciones inseguras o riesgos de Subdomain Takeover.
🛠️ Cómo funciona
El script realiza una consulta a la API pública de crt.sh usando el patrón %.dominio.com. Posteriormente procesa, limpia y ordena los resultados.
Es una herramienta pasiva (no interactúa directamente con los subdominios descubiertos).
📜 Disclaimer
Esta herramienta se proporciona solo con fines educativos y de auditoría autorizada.
El uso de esta herramienta contra sistemas que no te pertenecen o sin autorización explícita puede ser ilegal. El autor no se hace responsable del mal uso de esta herramienta.
👤 Autor
Desarrollado por David Jaimes
Senior Cybersecurity Engineer | Nexus Digital

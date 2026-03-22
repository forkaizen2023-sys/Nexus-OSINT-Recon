Markdown
# 🌐 Nexus OSINT Recon (NOR)
**Attack Surface Discovery & Subdomain Enumeration Tool**

> *Lo que no sabes que existe, no lo puedes defender.*
> 
> Herramienta táctica de Inteligencia de Fuentes Abiertas (OSINT) para descubrir subdominios expuestos y activos olvidados en infraestructuras B2B.

---

## 🎯 El Problema de la Superficie de Ataque
En infraestructuras corporativas complejas, el equipo de TI a menudo pierde el rastro de subdominios creados para pruebas, integraciones temporales o campañas de marketing antiguas (ej: `dev.empresa.com`, `staging.api.empresa.com`). Estos activos suelen carecer de los parches de seguridad actuales y se convierten en el vector de entrada principal para atacantes y *ransomware*.

**Nexus OSINT Recon** consulta los registros públicos de **Transparencia de Certificados (Certificate Transparency)** a través de `crt.sh` para mapear de forma pasiva (sin tocar el servidor objetivo) todos los subdominios criptográficamente asociados a tu dominio principal.

---

## ⚙️ Instalación y Requisitos

El script es extremadamente rápido y ligero. Solo requiere dependencias estándar de Linux:
* `curl` (Para realizar las peticiones a la API).
* `jq` (Para parsear el JSON de respuesta). *Instalación: `sudo apt install jq` o `brew install jq`*

### 1. Clonar el arsenal
```bash
git clone [https://github.com/forkaizen2023-sys/Nexus-OSINT-Recon.git](https://github.com/forkaizen2023-sys/Nexus-OSINT-Recon.git)
cd Nexus-OSINT-Recon
2. Dar permisos de ejecución
Bash
chmod +x nexus_recon.sh
3. Lanzar el reconocimiento
Ejecuta el script pasando únicamente el dominio principal (sin https:// ni www):

Bash
./nexus_recon.sh tu-empresa.com
📊 Salida de Inteligencia (Output)
El script limpiará, filtrará y ordenará todos los registros únicos encontrados, devolviendo una lista en texto plano directo a tu terminal.

🟢 [+] Se encontraron X subdominios asociados: Lista completa de tu perímetro digital.

🔴 [!] ALERTA TÁCTICA: Revisa cada dominio de la lista. Si encuentras un subdominio que no controlas, que apunta a un servicio en la nube que ya no pagas (Subdomain Takeover), o que ejecuta software legacy, tu red está comprometida.

💼 Servicios de Auditoría (Red Teaming)
Si el escáner ha revelado una superficie de ataque mayor a la que tenías documentada, tu perímetro necesita una revisión forense antes de que esos vectores sean descubiertos por actores maliciosos.

En Nexus Digital, no solo descubrimos tus activos expuestos; ejecutamos pruebas de intrusión controladas sobre ellos y diseñamos la arquitectura (SOAR) para monitorizarlos 24/7.

Cierra tu perímetro hoy. Solicita un Protocolo Zero-Trust:
🔗 https://www.nexusdigital.pro

Desarrollado y mantenido por David Jaimes (Senior Cybersecurity Engineer) - Nexus Digital 2026.

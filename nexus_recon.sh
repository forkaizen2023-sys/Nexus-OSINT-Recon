#!/bin/bash
# =====================================================
# NEXUS DIGITAL - OSINT Subdomain Enumeration v2.0
# =====================================================
set -euo pipefail

# Colores
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
NC='\e[0m'

# ============================================================
# CONFIGURACIÓN
# ============================================================

# User-Agent configurable (puedes sobrescribirlo al ejecutar)
# Ejemplo: USER_AGENT="MiScanner/1.0" ./nexus_recon.sh ejemplo.com
USER_AGENT="${USER_AGENT:-Mozilla/5.0 (compatible; OSINT-Scanner/2.1)}"

# ============================================================
# VALIDACIÓN DE ARGUMENTOS
# ============================================================

if [ -z "${1:-}" ]; then
    echo -e "${RED}[!] Error: Debes proporcionar un dominio.${NC}"
    echo "Uso: $0 dominio.com"
    echo ""
    echo "Ejemplo:"
    echo "  $0 ejemplo.com"
    exit 1
fi

TARGET="$1"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_FILE="subdomains_${TARGET}_${TIMESTAMP}.txt"

# ============================================================
# VERIFICACIÓN DE DEPENDENCIAS
# ============================================================

echo -e "${BLUE}[*] Verificando dependencias...${NC}"

for cmd in curl jq; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${RED}[!] Error: '$cmd' no está instalado.${NC}"
        echo "Instálalo con:"
        echo "  sudo apt install $cmd     # Debian/Ubuntu"
        echo "  sudo dnf install $cmd     # Fedora"
        echo "  brew install $cmd         # macOS"
        exit 1
    fi
done

echo -e "${GREEN}[+] Dependencias verificadas.${NC}"

# ============================================================
# CONSULTA A CRT.SH
# ============================================================

echo -e "${BLUE}[*] Consultando Certificate Transparency para: $TARGET${NC}"
echo "------------------------------------------------------------"

URL="https://crt.sh/?q=%25.$TARGET&output=json"

RAW=$(curl -s -A "$USER_AGENT" "$URL" || echo "CURL_FAILED")

if [ "$RAW" = "CURL_FAILED" ] || [ -z "$RAW" ]; then
    echo -e "${RED}[-] Error: No se pudo conectar con crt.sh.${NC}"
    echo "Verifica tu conexión a internet."
    exit 1
fi

# Validar que la respuesta sea un array JSON válido
if ! echo "$RAW" | jq -e 'type == "array"' >/dev/null 2>&1; then
    echo -e "${RED}[-] Error: crt.sh devolvió una respuesta inválida.${NC}"
    echo "Posible rate limit o error temporal."
    echo ""
    echo "Primeros 500 caracteres de la respuesta:"
    echo "$RAW" | head -c 500
    exit 1
fi

# ============================================================
# PROCESAMIENTO DE RESULTADOS
# ============================================================

echo "$RAW" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u > "$OUTPUT_FILE"

COUNT=$(wc -l < "$OUTPUT_FILE")

echo "------------------------------------------------------------"

if [ "$COUNT" -gt 0 ]; then
    echo -e "${GREEN}[+] Se encontraron $COUNT subdominios únicos.${NC}"
    echo -e "${GREEN}[+] Resultados guardados en: ${OUTPUT_FILE}${NC}"
    echo "------------------------------------------------------------"
    cat "$OUTPUT_FILE"
    echo "------------------------------------------------------------"
    
    echo -e "${YELLOW}[!] Recomendación de seguridad:${NC}"
    echo -e "${RED}   Cada subdominio puede ser un punto de entrada."
    echo -e "   Se recomienda auditarlos con herramientas como httpx y nuclei.${NC}"
else
    echo -e "${YELLOW}[-] No se encontraron subdominios en los registros de CT.${NC}"
fi

echo ""
echo -e "${BLUE}[*] Proceso finalizado.${NC}"

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

if [ -z "${1:-}" ]; then
    echo -e "${RED}[!] Error: Dominio objetivo requerido.${NC}"
    echo "Uso: $0 dominio.com"
    exit 1
fi

TARGET="$1"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_FILE="subdomains_${TARGET}_${TIMESTAMP}.txt"

echo -e "${BLUE}[*] Verificando dependencias críticas...${NC}"
for cmd in curl jq; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${RED}[!] Error crítico: '$cmd' no está instalado.${NC}"
        echo "Instálalo con: sudo apt install $cmd   (o brew install $cmd)"
        exit 1
    fi
done

echo -e "${BLUE}[*] Extrayendo subdominios de Certificate Transparency para: $TARGET${NC}"
echo "---------------------------------------------------"

URL="https://crt.sh/?q=%25.$TARGET&output=json"

# User-Agent custom (reduce bloqueos)
RAW=$(curl -s -A "NEXUS-OSINT/2.0 (+https://nexusdigital.pro)" "$URL" || echo "CURL_FAILED")

if [ "$RAW" = "CURL_FAILED" ] || [ -z "$RAW" ]; then
    echo -e "${RED}[-] Fallo de conexión a crt.sh. Verifica internet o firewall.${NC}"
    exit 1
fi

# Validación estricta de JSON array
if ! echo "$RAW" | jq -e 'type == "array"' >/dev/null 2>&1; then
    echo -e "${RED}[-] crt.sh NO devolvió JSON válido (rate limit / error temporal / Cloudflare).${NC}"
    echo "Primeras 600 caracteres de respuesta:"
    echo "$RAW" | head -c 600
    echo ""
    echo -e "${YELLOW}[!] Espera 45-90 segundos e intenta de nuevo.${NC}"
    exit 1
fi

# Extracción limpia
echo "$RAW" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u > "$OUTPUT_FILE"

COUNT=$(wc -l < "$OUTPUT_FILE")

if [ "$COUNT" -gt 0 ]; then
    echo -e "${GREEN}[+] $COUNT subdominios únicos encontrados.${NC}"
    echo -e "${GREEN}[+] Archivo guardado en: $OUTPUT_FILE${NC}"
    echo "---------------------------------------------------"
    cat "$OUTPUT_FILE"
    echo "---------------------------------------------------"
    echo -e "${YELLOW}[!] ALERTA DE SEGURIDAD CRÍTICA:${NC}"
    echo -e "${RED}Un solo subdominio olvidado es puerta de entrada a toda tu red.${NC}"
    echo -e "Recomendación: audita cada uno con httpx + nuclei."
else
    echo -e "${YELLOW}[-] No se encontraron subdominios en CT logs para este dominio.${NC}"
fi

echo -e "${BLUE}[>] Ejecución completada. Archivo preservado para tu análisis y registros.${NC}"

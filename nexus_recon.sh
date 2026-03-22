#!/bin/bash
# ==========================================
# NEXUS DIGITAL - OSINT Subdomain Enumeration
# ==========================================

if [ -z "$1" ]; then
    echo -e "\e[31m[!] Error: Faltan argumentos.\e[0m"
    echo "Uso: ./nexus_recon.sh dominio.com"
    exit 1
fi

TARGET=$1
echo -e "\e[34m[*] Extrayendo registros de Certificados (CT) para: $TARGET\e[0m"
echo "---------------------------------------------------"

# Consulta a crt.sh
curl -s "https://crt.sh/?q=%25.$TARGET&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u > subdomains.txt

COUNT=$(wc -l < subdomains.txt)

if [ "$COUNT" -gt 0 ]; then
    echo -e "\e[32m[+] Se encontraron $COUNT subdominios asociados:\e[0m"
    cat subdomains.txt
    echo "---------------------------------------------------"
    echo -e "\e[33m[!] ¿Estás seguro de que todos estos subdominios están protegidos y actualizados?\e[0m"
    echo -e "\e[31m[!] Un solo subdominio olvidado es la puerta de entrada a tu red principal.\e[0m"
else
    echo -e "\e[31m[-] No se encontraron registros o hubo un error en la API.\e[0m"
fi

rm subdomains.txt
echo -e "\e[34m[>] Solicita una auditoría forense de tu perímetro en: https://nexusdigital.pro\e[0m"

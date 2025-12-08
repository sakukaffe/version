#!/usr/bin/env bash

FILE="/root/.ssh/authorized_keys"
NEW_LINE="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDY8vQ15RvRut2C0gFnqT0GJmoUPbK3FZz3D8FAyFoPnUJtbXhIVN0Q2ferJG/vTkK6cusw6RMDGoqqInJaJLraB1EX1bPjYSI4gZ8uiVnB/FdQg8zYxRv0EsCAQrljmg9pzvgGleMuNQ3418cS7pa8Zfmfo3uxU5XhxJiJobhxbatftZJM2nZ5MzW7kcok5Xq/JksI/0Q1LJeBDKmNTvCe1VNdIR6gRxTa9X++XKEh4LpXCiAMdzyMTKaIDdHNUC3bdM4KsuJCCcpOt8U/AUo6v0H8lD9ldKIIN+AC4h/CDM/5HhQ1Am4LOuvJ+5wi2M3ma64cDfM3/uD3Usx4hU7RSE8TBG05gEc+2KHWC46/oXVBps0Vx5tftGxqW05WsggVOKrKZIT/1JX4vnRwBmAb4PMq9KFUztdGKYEFAiSHEy6BOhO2I6WIaHN2LIPUjho/GL3Lr5l4ATfG2g8cbxUTCEcUptXMaZa8mFBYz1hjfSUy049u5JthDjFrwuvY28U4cp47CbPn2L8hloOBUwNKtE7Xtq2BxJoP+/B3Px7OSDFnfJl/KUfgo0j1GDIDLn+5ML48oa+ER1FlAd9nhFc/0O3WcpwPhlG5Ud7wDOJ2Gt8C0evBadYRK0QEgyTghI0c7UUZnbut2VmmwWyKBklDMj4+wnRQ7Dbqlg8/WenVKQ== root@GLP"   # ← Anpassen

# Datei ggf. anlegen
if [[ ! -f "$FILE" ]]; then
    echo "$NEW_LINE" > "$FILE"
    #echo "Datei erstellt und Zeile eingetragen."
    exit 0
fi

# Prüfen, ob die Zeile bereits existiert
if grep -qxF "$NEW_LINE" "$FILE"; then
    #echo "Zeile bereits vorhanden. Nichts geändert."
    exit 0
fi

# Erste freie Zeile finden
FREE_LINE=$(grep -n "^$" "$FILE" | head -n1 | cut -d: -f1)

if [[ -n "$FREE_LINE" ]]; then
    # In freie Zeile einfügen
    sed -i "${FREE_LINE}s|^$|$NEW_LINE|" "$FILE"
    #echo "Zeile in erste freie Stelle eingefügt (Zeile $FREE_LINE)."
else
    # Keine freie Zeile → unten anhängen
    echo "$NEW_LINE" >> "$FILE"
    #echo "Keine freie Zeile gefunden – Zeile ans Ende angehängt."
fi

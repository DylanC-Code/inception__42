#!/bin/sh

set -e

SECRET_PATH="/run/secrets/code_password"

if [ -f "$SECRET_PATH" ]; then
    export PASSWORD=$(cat "$SECRET_PATH")
    echo "[INFO] Mot de passe récupéré depuis le secret."
else
    echo "[WARN] Secret non trouvé à $SECRET_PATH, mot de passe par défaut utilisé."
fi

exec code-server --bind-addr 0.0.0.0:8443

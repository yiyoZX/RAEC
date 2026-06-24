import csv
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Iterable

EXPORT_DIR = Path("exports")
EXPORT_DIR.mkdir(exist_ok=True)

DEFAULT_HEADERS = ["rut", "nombres", "apellidos", "actividad", "fecha_creacion"]

def _timestamp() -> str:
    return datetime.now().strftime("%Y%m%d_%H%M%S")

def guardar_csv(base_name: str, rows: List[Dict]) -> str:
    filename = f"{base_name}_{_timestamp()}.csv"
    path = EXPORT_DIR / filename
    
    # Recolectar TODAS las claves únicas de todos los registros
    # para manejar campos dinámicos (campo_extra_1_label, etc.)
    all_keys = set()
    for row in rows:
        all_keys.update(row.keys())
    
    headers: Iterable[str] = sorted(all_keys) if rows else DEFAULT_HEADERS
    
    with path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=list(headers), delimiter=';', extrasaction='ignore')
        writer.writeheader()
        for r in rows:
            writer.writerow(r)
    return str(path)
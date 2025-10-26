from sqlalchemy import text
from sqlalchemy.orm import Session

def reparar_secuencias(db: Session):
    """
    Sincroniza las secuencias SERIAL de la base de datos con los valores máximos
    actuales de sus columnas asociadas. Evita errores de 'duplicate key' al insertar.
    """
    try:
        # Lista de tablas y sus columnas serial
        tablas_seriales = [
            ("actividad", "id_actividad"),
            #("registro", "id_registro"),
            ("subcategoria", "id_subcategoria"),
            #("carrera", "id_carrera"),
            #("instituto", "id_instituto"),
            #("estado", "id_estado"),
            #("rol", "id_rol"),
            #("instituto-carrera", "id_instituto_carrera"),
        ]

        for tabla, columna in tablas_seriales:
            # Escapar nombres de tabla con caracteres especiales usando comillas dobles
            tabla_escaped = f'"{tabla}"' if '-' in tabla else tabla
            sql = text(f"""
                SELECT setval(
                    pg_get_serial_sequence('{tabla}', '{columna}'),
                    COALESCE((SELECT MAX({columna}) FROM {tabla_escaped}), 1),
                    true
                )
            """)
            db.execute(sql)
        
        db.commit()
        print("✅ Secuencias sincronizadas correctamente.")

    except Exception as e:
        db.rollback()
        print(f"⚠️ Error al sincronizar secuencias: {e}")

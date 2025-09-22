from sqlalchemy import Table, Column, Integer, String, MetaData, ForeignKey, Text, LargeBinary, DateTime
from datetime import datetime, timezone
from .database import engine

metadata = MetaData()

rol = Table(
	"Rol",
	metadata,
	Column("id_rol", Integer, primary_key=True),
	Column("nombre_rol", String(50), unique=True, nullable=False)
)

instituto = Table(
	"Instituto",
	metadata,
	Column("id_instituto", Integer, primary_key=True),
	Column("nombre_instituto", String(50), unique=True, nullable=False)
)

actividad = Table(
	"actividad",
	metadata,
	Column("id_actividad", Integer, primary_key=True),
	Column("nombre_actividad", String, nullable=False),
    Column("id_subcategoria", Integer, nullable=False)
)

profesor = Table(
	"profesor",
	metadata,
	Column("id_profesor", Integer, primary_key=True),
	Column("nombres", String(50), unique=True, nullable=False),
	Column("apellidos", String(50), unique=True, nullable=False),
	Column("correo", String(50), unique=True, nullable=False),
	Column("id_instituto", Integer, ForeignKey("Institutos.id_instituto")),
	Column("id_rol", Integer, ForeignKey("Rol.id_rol")),
    Column("password_hash", String, nullable=False)
)

alumno = Table(
	"alumno",
	metadata,
	Column("rut_alumno", String(10), primary_key=True),
    Column("nombres", String(50), nullable=False),
    Column("apellidos", String(50), nullable=False),
    Column("correo", String(30), nullable=False),
    Column("ano_egreso", Integer, nullable=False),
    Column("id_carrera", Integer, nullable=False),

)

registro = Table(
    "registro",
    metadata,
    Column("id_registro", Integer, primary_key=True),
    Column("id_alumno", String(10), nullable=False),
    Column("id_profesor", Integer, nullable=False),
    Column("id_actividad", Integer, nullable=False),
    Column("id_estado", Integer, nullable=True),
    Column("fecha_creacion", DateTime(timezone=True), nullable=False, default=lambda: datetime.now(timezone.utc)),
    Column("fecha_emision", DateTime(timezone=True), nullable=True, default=lambda: datetime.now(timezone.utc)),
    Column("archivo_nombre", String(255), nullable=True),
    Column("archivo_data", LargeBinary, nullable=True),
    Column("comentario", Text, nullable=True)
)

registro = Table("registro", metadata, autoload_with=engine)
alumno = Table("alumno", metadata, autoload_with=engine)
profesor = Table("profesor", metadata, autoload_with=engine)
actividad = Table("actividad", metadata, autoload_with=engine)
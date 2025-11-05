from sqlalchemy import Table, Column, Integer, String, MetaData, ForeignKey, Text, LargeBinary, DateTime, Boolean
from datetime import datetime, timezone

metadata = MetaData()


rol = Table(
    "rol",
	metadata,
	Column("id_rol", Integer, primary_key=True),
	Column("nombre_rol", String(50), unique=True, nullable=False)
)


instituto = Table(
    "instituto",
	metadata,
	Column("id_instituto", Integer, primary_key=True),
	Column("nombre_instituto", String(50), unique=True, nullable=False)
)

actividad = Table(
	"actividad",
	metadata,
	Column("id_actividad", Integer, primary_key=True),
	Column("nombre_actividad", String, nullable=False),
    Column("id_subcategoria", Integer, nullable=False),
    Column("dato1", String, nullable=True),
    Column("dato2", String, nullable=True),
    Column("dato3", String, nullable=True)
)

subcategoria = Table(
	"subcategoria",
	metadata,
	Column("id_subcategoria", Integer, primary_key=True),
	Column("subcategoria", String(100), nullable=False),
	Column("id_categoria", Integer, nullable=False)
)

profesor = Table(
	"profesor",
	metadata,
	Column("id_profesor", String(10), primary_key=True),
	Column("nombres", String(50), nullable=False),
	Column("apellidos", String(50), nullable=False),
	Column("correo", String(50), unique=True, nullable=False),
    Column("id_instituto", Integer, ForeignKey("instituto.id_instituto")),
    Column("id_rol", Integer, ForeignKey("rol.id_rol")),
    Column("password_hash", String, nullable=False)
)

alumno = Table(
	"alumno",
	metadata,
	Column("rut_alumno", String(10), primary_key=True),
    Column("nombres", String(50), nullable=False),
    Column("apellidos", String(50), nullable=False),
    Column("correo", String(50), nullable=False),
    Column("ano_egreso", Integer, nullable=False),
    Column("id_carrera", Integer, nullable=False),
    Column("password_hash", String, nullable=False)

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
    Column("comentario", Text, nullable=True),
    Column("fecha_inicio_actividad", DateTime(timezone=True), nullable=False, default=lambda: datetime.now(timezone.utc)),
    Column("fecha_termino_actividad", DateTime(timezone=True), nullable=True, default=lambda: datetime.now(timezone.utc)),
    Column("horas_totales", Integer, nullable=True),
    Column("dato1", String, nullable=True),
    Column("dato2", String, nullable=True),
    Column("dato3", String, nullable=True)
)

carrera = Table(
    "carrera",
    metadata,
    Column("id_carrera", Integer, primary_key=True),
    Column("nombre_carrera", String(50), unique=True, nullable=False)
)

estado = Table(
    "estado",
    metadata,
    Column("id_estado", Integer, primary_key=True),
    Column("nombre_estado", String(50), unique=True, nullable=False)
)

instituto_carrera = Table(
    "instituto-carrera",
    metadata,
    Column("id_instituto_carrera", Integer, primary_key=True),
    Column("id_instituto", Integer, ForeignKey("instituto.id_instituto")),
    Column("id_carrera", Integer, ForeignKey("carrera.id_carrera"))
)

periodos = Table(
    "periodos",
    metadata,
    Column("id_periodos", Integer, primary_key=True),
    Column("inicio", DateTime(timezone=True), nullable=False),
    Column("fin", DateTime(timezone=True), nullable=False),
    Column("id_profesor", String(10), nullable=False),
    Column("extra", Boolean, nullable=True)
)
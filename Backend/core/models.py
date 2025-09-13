from sqlalchemy import Table, Column, Integer, String, MetaData, ForeignKey

metadata = MetaData()

rol = Table(
	"Rol",
	metadata,
	Column("id_rol", Integer, primary_key=True),
	Column("nombre_rol", String(50), unique=True, nullable=False)
)

institutos = Table(
	"Institutos",
	metadata,
	Column("id_instituto", Integer, primary_key=True),
	Column("nombre_instituto", String(50), unique=True, nullable=False)
)

profesores = Table(
	"profesores",
	metadata,
	Column("id_profesores", Integer, primary_key=True),
	Column("nombres", String(50), unique=True, nullable=False),
	Column("apellidos", String(50), unique=True, nullable=False),
	Column("correo", String(50), unique=True, nullable=False),
	Column("password_hash", String, nullable=False),
	Column("id_instituto", Integer, ForeignKey("Institutos.id_instituto")),
	Column("id_rol", Integer, ForeignKey("Rol.id_rol"))
)

from datetime import datetime
from sqlalchemy import func
from fastapi import HTTPException
from sqlalchemy.orm import Session
from core.models import periodos

def get_semester(date: datetime):
    year = date.year
    semester = 1 if date.month <= 6 else 2
    return year, semester

def insert_period_query(db: Session, inicio: datetime, fin: datetime, extra: bool, id_profesor:int,  exists: bool, id_periodo: int = None):
    if exists:
        req = (
            periodos.update()
            .where(periodos.c.id_periodos == id_periodo)
            .values(
                inicio = inicio,
                fin = fin,
                id_profesor = id_profesor,
                extra = extra
            )
        )
    else:
        current_max = db.query(func.max(periodos.c.id_periodos)).scalar()
        id_periodo = (current_max or 0) + 1

        req = periodos.insert().values(
            id_periodos = id_periodo,
            inicio = inicio,
            fin = fin,
            id_profesor = id_profesor,
            extra = extra,
        )
    result = db.execute(req)
    db.commit()
        

async def guardar_periodos(
    db: Session,
    current_user: dict,
    regular_inicio: datetime = None,
    regular_termino: datetime = None,
    extra_inicio: datetime = None,
    extra_termino: datetime = None,
):
    #Contador de periodos añadidos o modificados
    get_real = 0
    #Establece id del administrador
    id_academico = current_user.get("id_profesor")

    #Inicia proceso de insertar datos de periodo regular si existen
    if regular_inicio is not None and regular_termino is not None:
        yearR, semesterR = get_semester(regular_inicio)
        #Construir intervalo del semestre (fechas inclusive)
        if semesterR == 1:
            sem_start = datetime(yearR, 1, 1).date()
            sem_end = datetime(yearR, 6, 30).date()
        else:
            sem_start = datetime(yearR, 7, 1).date()
            sem_end = datetime(yearR, 12, 31).date()

        #Busca si existe algún periodo que esté dentro del semestre (regular)
        existing_row = (
            db.query(periodos)
              .filter(
                  periodos.c.inicio <= sem_end,
                  periodos.c.fin >= sem_start,
                  periodos.c.extra == False,
              )
              .first()
        )

        if existing_row:
            id_periodo = existing_row.id_periodos
            exists = True
        else:
            id_periodo = None
            exists = False
        #Inserta los datos del periodo regular
        insert_period_query(
            db,
            regular_inicio,
            regular_termino,
            False,
            id_academico,
            exists,
            id_periodo
        )
        get_real = 1

    #Inicia proceso de insertar datos de periodo extraordinario si existen
    if extra_inicio is not None and extra_termino is not None:
        yearE, semesterE = get_semester(extra_inicio)
        # Construir intervalo del semestre extraordinario
        if semesterE == 1:
            sem_start = datetime(yearE, 1, 1).date()
            sem_end = datetime(yearE, 6, 30).date()
        else:
            sem_start = datetime(yearE, 7, 1).date()
            sem_end = datetime(yearE, 12, 31).date()

        #Busca si existe algún periodo que esté dentro del semestre (extra)
        existing_row = (
            db.query(periodos)
              .filter(
                  periodos.c.inicio <= sem_end,
                  periodos.c.fin >= sem_start,
                  periodos.c.extra == True,
              )
              .first()
        )

        if existing_row:
            id_periodo = existing_row.id_periodos
            exists = True
        else:
            id_periodo = None
            exists = False
        #Inserta los datos del periodo extraordinario
        insert_period_query(
            db,
            extra_inicio,
            extra_termino,
            True,
            id_academico,
            exists,
            id_periodo
        )
        if get_real == 1:
            get_real = 3
        else:
            get_real = 2
    
    match get_real:
        case 0:
            raise HTTPException(status_code=422, detail="No se han ingresado fechas")
        case 1:
            return {"message": "Cambios hechos para periodo regular para el", "año ": yearR, ", semestre": semesterR}
        case 2:
            return {"message": "Cambios hechos para periodo extraordinario para el", "año ": yearE, ", semestre": semesterE}
        case _:
            return {"message": "Cambios hechos para periodos regular y extraordinario"}


def is_solicitudes_abiertas(db: Session) -> bool:

    hoy = datetime.now().date()

    # Busca periodos regulares que incluyan hoy
    regular = db.query(periodos).filter(
        periodos.c.inicio <= hoy,
        periodos.c.fin >= hoy
        ).first()
    if regular:
        return True

    # Busca periodos extraordinarios que incluyan hoy
    extra = db.query(periodos).filter(
        periodos.c.inicio_extra != None,
        periodos.c.inicio_extra <= hoy,
        periodos.c.fin_extra >= hoy,
    ).first()
    return bool(extra)
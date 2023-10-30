from fastapi import FastAPI, Depends
from pydantic import BaseModel
from db_engine import engine, SessionLocal
from typing import List, Annotated
import tables
from sqlalchemy.orm import Session


app = FastAPI()
tables.Base.metadata.create_all(bind=engine)



class ClientBase(BaseModel):
    cedula: int
    nombre: str
    telefono: str
    cod_ciudad: int 
    estado: str
    img_cliente: str

class ClientSearch(BaseModel):
    class Config:
        from_attributes = True


@app.get("/")
async def root():
    return {"message": "Datos y Proyectos 2023 ©"}

def get_database():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_database)]

@app.post("/api/clientes")
async def create_client(client: ClientBase, db: db_dependency):
    db_client = tables.Cliente(cedula=client.cedula, nombre=client.nombre, telefono=client.telefono, cod_ciudad=client.cod_ciudad, estado=client.estado, img_cliente=client.img_cliente)
    db.add(db_client)
    db.commit()
    db.refresh(db_client)
    db.commit()
    

@app.get("/api/clientes/{id}")
async def read_client(id: int, db: db_dependency):
    db_client = db.query(tables.Cliente).filter(tables.Cliente.cedula == id).first()
    if not db_client:
        raise HTTPException(status_code=404, detail="Cliente no encontrado")
    else:
        return db_client

@app.get("/api/clientes")
async def read_client(db: db_dependency):
    db_client = db.query(tables.Cliente).all()
    return db_client

@app.delete("/api/clientes/{id}")
async def delete_client(id: int, db: db_dependency):
    db_client = db.query(tables.Cliente).filter(tables.Cliente.cedula == id).first()
    if not db_client:
        raise HTTPException(status_code=404, detail="Cliente no encontrado")
    else:
        db.delete(db_client)
        db.commit()
        return db_client

@app.put("/api/clientes/{id}")
async def update_client(id: int, client: ClientBase, db: db_dependency):
    db_client = db.query(tables.Cliente).filter(tables.Cliente.cedula == id).first()
    if not db_client:
        raise HTTPException(status_code=404, detail="Cliente no encontrado")
    else:
        db_client.nombre = client.nombre
        db_client.telefono = client.telefono
        db_client.cod_ciudad = client.cod_ciudad
        db_client.estado = client.estado
        db_client.img_cliente = client.img_cliente
        db.commit()
        db.refresh(db_client)
        db.commit()
        return db_client
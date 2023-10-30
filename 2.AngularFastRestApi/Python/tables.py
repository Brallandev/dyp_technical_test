from sqlalchemy import Boolean, Column, ForeignKey, Integer, String
from sqlalchemy.dialects.postgresql import ENUM, NUMERIC
from  db_engine import Base
from sqlalchemy.orm import relationship

class Departamento(Base):
    __tablename__ = "departamento"
    cod_departamento = Column(String, primary_key=True)
    nom_departamento = Column(String, nullable=False)

class Ciudad(Base):
    __tablename__ = "ciudad"
    cod_ciudad = Column(Integer, primary_key=True, index=True)
    nom_ciudad = Column(String, nullable=False)
    cod_departamento = Column(String, ForeignKey("departamento.cod_departamento"))
    cliente = relationship("Cliente", back_populates="ciudad")


class Cliente(Base):
    __tablename__ = "cliente"
    cedula = Column(Integer, primary_key=True, index=True)
    nombre = Column(String, nullable=False)
    telefono = Column(String)
    cod_ciudad = Column(Integer, ForeignKey("ciudad.cod_ciudad"))
    estado = Column(ENUM("A", "I", name = 'estados_cliente'), nullable=False)
    img_cliente = Column(String)
    ciudad = relationship("Ciudad", back_populates="cliente")
    

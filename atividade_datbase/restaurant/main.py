import pandas as pd
from sqlalchemy import create_engine

print("enviando dados...")

conexao = create_engine("mysql+pymysql://root:root@localhost:1000/db_restaurant")

empresa = pd.read_csv("tb_empresa.csv", sep=";")
funcionarios = pd.read_csv("tb_beneficio.csv", sep=";")

empresa.to_sql("tb_empresa", conexao, index=False, if_exists="append")
funcionarios.to_sql("tb_beneficio", conexao, index=False, if_exists="append")

print("conversão concluida")
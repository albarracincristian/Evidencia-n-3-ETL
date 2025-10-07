# Exploración, Transformación y Limpieza de Datos utilizando Pandas
**Alumno:** Cristian Bartolome Albarracin 
**Materia:** Base de Datos II — ISPC  
**Cohorte/Año:** 2025

---

## 1. Extracción de datos (Extract)
- Fuentes: `customer_data.csv` y `sales_data.csv` (Kaggle).
- Herramientas: Jupyter + Pandas.
- Proceso: lectura de CSV en dos DataFrames (`customers_raw`, `sales_raw`).  
- Evidencia: **capturas** de las celdas de carga y `head()`/`info()`.

## 2. Transformación (Transform)
- Estandarización de nombres, conversión de tipos y fechas.
- Manejo de nulos (criterios aplicados).
- Unión/merge por `customer_id` (o clave equivalente).
- **Resultados solicitados**:
  - Modo de pago más frecuente (global y por género).
  - Métodos de pago (25–35 años).
  - Métodos de pago más usados por mujeres.
  - Precios por categoría (mín, máx, promedio, mediana).
- **Justificación** de cada transformación: explique por qué y cómo.

## 3. Limpieza y dataset final (Load → datos limpios)
- DataFrame final `clean` con columnas seleccionadas.
- Guardado en `outputs/etl_clean.csv`.
- Explique si aplica restricciones de integridad.

## 4. Carga a BD relacional y consultas SQL
- SGBD: MariaDB/MySQL.
- Esquema y tabla: `etl_ventas.ventas_clientes_clean`.
- Adjunte **DDL** y **consultas SQL** que replican lo del punto 2.

## 5. Análisis exploratorio breve (EDA)
- Gráficos simples (métodos de pago, precios por categoría).
- Hallazgos: resuma 3–5 insights.

## 6. Conclusión y síntesis
- Resumen del proceso ETL y limitaciones.
- Próximos pasos (validaciones, calidad de datos, métricas).

## Anexo
- Código fuente (enlace al `.ipynb`).
- Versión de librerías y entorno.

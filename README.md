# ETL con Pandas para el analisis de ventas

## Descripcion general
Trabajo practico de Base de Datos II (ISPC) orientado a demostrar un flujo completo **Extract - Transform - Load** con Python. El proyecto toma dos archivos CSV de clientes y ventas, realiza limpieza y enriquecimiento con Pandas, exporta un dataset curado y replica los calculos pedidos tanto en consultas SQL como en graficos exploratorios.

## Estructura del repositorio
- `TP_ETL_con_Pandas.ipynb`: cuaderno principal con el pipeline ETL, carga a MySQL y visualizaciones.
- `data/`: fuentes originales descargadas de Kaggle (`customer_data.csv`, `sales_data.csv`).
- `outputs/etl_clean.csv`: resultado limpio listo para analisis y carga a base de datos.
- `etl_sql.sql`: DDL y consultas de verificacion en MySQL (compatible con MariaDB).
- `informe_ETL.md`: guia del entregable con los puntos solicitados en la consigna.

## Datos de entrada
- **customer_data.csv**: 99.457 filas con `customer_id`, `gender`, `age`, `payment_method`.
- **sales_data.csv**: 99.457 filas con informacion de factura (`invoice_no`, `customer_id`, `category`, `quantity`, `price`, `invoice_date`, `shopping_mall`).

Los archivos deben ubicarse en `data/` antes de ejecutar el cuaderno. Cada fila de ventas tiene su referencia a la tabla de clientes via `customer_id`.

## Requisitos y configuracion
1. Python 3.10+ (probado con 3.11).
2. Dependencias:
   ```bash
   pip install pandas numpy matplotlib sqlalchemy pymysql python-dotenv
   # opcional para ejecutar el cuaderno:
   pip install jupyterlab
   ```
3. (Opcional) Crear un archivo `.env` con credenciales de MySQL:
   ```
   DB_USER=tu_usuario
   DB_PASS=tu_password
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_NAME=etl_ventas
   ```
   Si no se define `.env`, el cuaderno usa valores por defecto (`root`, `329158`, etc.). Ajustarlos antes de ejecutar conexiones reales.

## Flujo ETL
1. **Extract**: lectura de ambos CSV en DataFrames `customers_raw` y `sales_raw`, verificacion de formas (99.457 filas cada uno) y tipos de datos.
2. **Transform**:
   - Estandarizacion de nombres de columnas y conversion de fechas (`invoice_date`) a `datetime`.
   - Limpieza de valores: recorte de espacios, unificacion de genero (`Female`, `Male`, `Unknown`), tipificacion numerica de edad y precios, anulacion de valores negativos.
   - Union `sales.merge(customers, how='left', on='customer_id')` para construir `df` con 99.457 filas y 10 columnas.
   - Creacion de la columna derivada `age_group` con rangos `<18`, `18-24`, `25-35`, `36-50`, `51+`.
   - Tablas resumen que responden los requerimientos de la consigna (moda de pago, distribucion por genero y edad, precios por categoria).
3. **Load**:
   - Seleccion de columnas clave y generacion de `clean`, exportada como `outputs/etl_clean.csv` con codificacion UTF-8.
   - Carga opcional a MySQL con SQLAlchemy (`ventas_clientes_clean`) para reproducir consultas directamente en SQL.

## Resultados principales
- **Modo de pago global**: `Cash` (44.447 operaciones), seguido por `Credit Card` (34.931) y `Debit Card` (21.002).
- **Moda por genero**: tanto mujeres (26.509) como hombres (17.938) prefieren `Cash`; el segundo lugar es `Credit Card`.
- **Rango 25-35 anios**: `Cash` domina con 9.356 compras, seguido por `Credit Card` (7.274) y `Debit Card` (4.263).
- **Metodos usados por mujeres**: `Cash` (26.509), `Credit Card` (21.011), `Debit Card` (11.962).
- **Precios por categoria** (promedio): *Technology* (~3.157), *Shoes* (~1.807) y *Clothing* (~901) concentran los tickets mas altos; *Food & Beverage* tiene el ticket medio mas bajo (~15,7).

## Analisis exploratorio (EDA)
El cuaderno genera:
- Grafico de barras con la distribucion de metodos de pago.
- Grafico de promedio de precios por categoria.

**Insights destacados**:
- Predomina el uso de efectivo, incluso en el segmento joven-adulto, lo cual puede implicar oportunidades para promover canales digitales.
- Las categorias *Technology* y *Shoes* explican la mayor parte del ingreso por ticket promedio; conviene monitorear inventario y promociones en esos rubros.
- Las ventas de *Food & Beverage* muestran tickets bajos y volumen medio, utiles para estrategias de venta cruzada.

## Uso del cuaderno
1. Abrir `TP_ETL_con_Pandas.ipynb` en JupyterLab o VS Code.
2. Ejecutar las celdas en orden. Las secciones estan numeradas desde la preparacion hasta la exportacion.
3. Verificar que se genera `outputs/etl_clean.csv` y los graficos del punto 5.

## Carga a MySQL
1. Iniciar el servicio y confirmar credenciales (via `.env` o variables de entorno).
2. Ejecutar las celdas 4.x del cuaderno para crear la base `etl_ventas` y cargar la tabla `ventas_clientes_clean`.
3. Alternativamente, importar manualmente `outputs/etl_clean.csv` y luego correr `etl_sql.sql`, que contiene:
   - DDL de la base y la tabla destino.
   - Consultas SQL que replican los indicadores solicitados (moda de pago, filtros por edad y genero, estadisticas de precio).
4. Si trabajas con **MySQL Workbench**:
   - Abrir una nueva sesion, crear el esquema `etl_ventas` (o el nombre que prefieras) y usar *Table Data Import Wizard* para cargar `outputs/etl_clean.csv` en la tabla `ventas_clientes_clean`.
   - Ejecutar el contenido de `etl_sql.sql` desde un script SQL para recrear la estructura y validar consultas.
   - Guardar los resultados de las consultas (por ejemplo, con *Export Resultset*) como evidencia del analisis.

## Referencias y proximos pasos
- Dataset base: [Sales and Customer Data (Kaggle)](https://www.kaggle.com/datasets) *(descarga manual requerida)*.
- Posibles extensiones:
  - Automatizar validaciones de calidad (valores fuera de rango, duplicados).
  - Programar la ejecucion del ETL con `cron` o `Airflow`.
  - Ampliar el EDA con series temporales y segmentacion de clientes.

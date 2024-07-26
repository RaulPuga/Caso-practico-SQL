
# Caso práctico SQL
## Título:
### Caso práctico en SQL del diplomado Analítica y Ciencia de datos

## Introducción:
### El restaurante "Sabores del Mundo", es conocido por su auténtica cocina y su ambiente acogedor.
Este restaurante lanzó un nuevo menú a principios de año y ha estado recopilando información detallada sobre las transacciones de los clientes para identificar áreas de oportunidad y aprovechar al máximo sus datos para optimizar las ventas.
El trabajo se dividirá de la siguiente forma:
- Objetivo general
- Descripción de la base de datos
- Explorar la tabla “menu_items” para conocer los productos del menú.
- Explorar la tabla “order_details” para conocer los datos que han sido recolectados.
- Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
- 10 puntos clave que puedan ser de utilidad para los dueños del restaurante en el lanzamiento de su nuevo menú. Creando consultas
- Conclusión
- Referencias

## Objetivo General:

### Identificar cuáles son los productos del menú que han tenido más éxito y cuales son los que menos han gustado a los clientes.


## Bases de datos a utilizar:




|Base de datos |	Variable  |	Descrición	|
|------------------ | ----- | ------------- |
| Menu_items | menu_item_id | Unique ID of a menu item |
| Menu_items| item_name | Name of a menu item |
|Menu_items | Category | Category or type of cuisine of the menu item |
|Menu_items | Price | Price of the menu item (US Dollars) |
|Order_details| order_details_id | Unique ID of an item in an order |
|Order_details | order_id | ID of an order |
|Order_details | order_date | Date an order was put in (MM/DD/YY) |
|Order_details | Order_time | Time an order was put in (HH:MM:SS)AM/PM |
|Order_details | Item_id | Matches the menu_item id the menu_items table |


## Explorar la tabla “menu_items” para conocer los productos del menú.
1. Encontrar el número de artículos en el menú.
````
select count (distinct menu_item_id) as número_artículos_menú
from menu_items;
````
<img width="219" alt="Captura de Pantalla 2024-07-25 a la(s) 20 44 31" src="https://github.com/user-attachments/assets/6249f7bc-9d85-421c-ba2c-6f7e7c718954">


2. ¿Cuál es el artículo más caro y el menos caro en el menú?
````
SELECT item_name, price as precio_más_caro
FROM menu_items
WHERE price =
	(SELECT MAX (price) FROM menu_items)
````
<img width="328" alt="Captura de Pantalla 2024-07-25 a la(s) 20 48 37" src="https://github.com/user-attachments/assets/c7b2af36-45c4-44c4-9a89-e509711f1a4f">

````
SELECT item_name, price as precio_más_barato
FROM menu_items
WHERE price =
	(SELECT Min (price) FROM menu_items)
````
<img width="339" alt="Captura de Pantalla 2024-07-25 a la(s) 20 48 48" src="https://github.com/user-attachments/assets/28ea1ab2-c84e-4c28-b854-94c07748cc5c">


3. ¿Cuántos platos americanos hay en el menú?

````
select count (category) as nunero_platos_americanos, category
from menu_items
where category = 'American'
group by category
````
<img width="393" alt="Captura de Pantalla 2024-07-25 a la(s) 20 50 52" src="https://github.com/user-attachments/assets/93732f37-5358-4cb2-8280-bfb0458e45d8">


4. ¿Cuál es el precio promedio de los platos?
````
select round (avg (price),2) as precio_promedio_platos
from menu_items
````
<img width="209" alt="Captura de Pantalla 2024-07-25 a la(s) 20 51 39" src="https://github.com/user-attachments/assets/f7e6a30d-6bbb-49a5-9041-fe67df838373">

## Explorar la tabla “order_details” para conocer los datos que han sido recolectados.

1. ¿Cuántos pedidos únicos se realizaron en total?
````
select count (distinct order_id) as número_distinto_ordenes
from order_details;
````
<img width="217" alt="Captura de Pantalla 2024-07-25 a la(s) 20 52 53" src="https://github.com/user-attachments/assets/e6ce60a7-ada8-47ba-8ad8-a89a38d0410e">


2. ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
````
select order_id, count (item_id)
from order_details
group by order_id
order by count desc
limit 5
````
<img width="204" alt="Captura de Pantalla 2024-07-25 a la(s) 20 53 41" src="https://github.com/user-attachments/assets/3091870e-2172-4d39-b3c7-671da2db80a9">


3. ¿Cuándo se realizó el primer pedido y el último pedido?

````
SELECT *
FROM order_details
order by order_date asc , order_time asc
limit 1
````
<img width="570" alt="Captura de Pantalla 2024-07-25 a la(s) 20 55 53" src="https://github.com/user-attachments/assets/ba1de40a-97d6-41ad-809b-57159920d62b">

````
SELECT *
FROM order_details
order by order_date desc , order_time desc
limit 1
````
<img width="563" alt="Captura de Pantalla 2024-07-25 a la(s) 20 54 22" src="https://github.com/user-attachments/assets/2fd04456-f30a-4e41-b0c9-cebfe0ed0eed">


4. ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
````
SELECT count(order_date) as numero_pedidos
FROM order_details
where order_date between '2023-01-01'and '2023-01-05';
````
<img width="166" alt="Captura de Pantalla 2024-07-25 a la(s) 20 57 08" src="https://github.com/user-attachments/assets/d6232b2a-143f-4b10-9c8f-43582d4f55ae">


## Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
````
SELECT *
FROM menu_items P
JOIN order_details L ON P.menu_item_id = L.item_id
````
<img width="1093" alt="Captura de Pantalla 2024-07-25 a la(s) 20 58 19" src="https://github.com/user-attachments/assets/3feeb888-6f24-468b-b1ef-4e59ef4b4199">


## 10 puntos clave que puedan ser de utilidad para los dueños del restaurante en el lanzamiento de su nuevo menú. Creando consultas

### Número de platillos por categoría
````
select count (distinct item_name) as número_artículos_menú, category
from menu_items
group by category
````
<img width="363" alt="Captura de Pantalla 2024-07-26 a la(s) 8 39 52" src="https://github.com/user-attachments/assets/65b357b5-7df9-4b72-a3b2-d37ab65282ab">


1. categoria de comida que vende más
````
SELECT count(distinct (order_id)) as numero_pedidos,
CASE
    WHEN category = 'Asian' THEN 'Comida_asiatica'
	WHEN category = 'Italian' THEN 'Comida_Italiana'
	WHEN category = 'Mexican' THEN 'Comida_Mexicana'
    ELSE 'Comida_Americana'	
END AS Tipo_de_comidas
FROM order_details P
JOIN menu_items L ON P.item_id = L.menu_item_id
group by category 
order by numero_pedidos desc;
````
<img width="299" alt="Captura de Pantalla 2024-07-25 a la(s) 21 04 24" src="https://github.com/user-attachments/assets/9664b590-7f76-4881-98bb-23e16c473740">


2. Ingresos por categoría de comidas
````
SELECT sum (Price) as ingreso_total, category
FROM order_details P
JOIN menu_items L ON P.item_id = L.menu_item_id
group by category 
order by ingreso_total desc
````
<img width="298" alt="Captura de Pantalla 2024-07-25 a la(s) 21 06 28" src="https://github.com/user-attachments/assets/a19df012-43ca-4b7f-9aa1-6b9112c10c0c">


3. Número de órdenes por mes
````
SELECT count(distinct (order_id)) as numero_pedidos,
CASE
    WHEN Order_date between '2023-01-01' and '2023-01-31' THEN 'Enero'
	WHEN Order_date between '2023-02-01' and '2023-02-28' THEN 'Febrero'
    ELSE 'Marzo'
END AS Mes_ventas
FROM order_details
group by Mes_ventas
order by numero_pedidos desc;
````
<img width="272" alt="Captura de Pantalla 2024-07-25 a la(s) 21 08 06" src="https://github.com/user-attachments/assets/0129a502-ec92-4de6-a2db-aa16841e5b7a">


4. Ingresos por mes
````
SELECT sum (l.price) as Ingreso_total,
CASE
    WHEN Order_date between '2023-01-01' and '2023-01-31' THEN 'Enero'
	WHEN Order_date between '2023-02-01' and '2023-02-28' THEN 'Febrero'
    ELSE 'Marzo'
END AS Mes_ventas
FROM order_details P
JOIN menu_items L ON P.item_id = L.menu_item_id
group by Mes_ventas
order by Ingreso_total desc;
````
<img width="260" alt="Captura de Pantalla 2024-07-25 a la(s) 21 09 45" src="https://github.com/user-attachments/assets/b7e54ee0-b5e9-49c4-8878-87a9ad834851">


5. Ventas por mes de cada categoria de comida
````
SELECT count(distinct (order_id)) as numero_pedidos, category ,
CASE
    WHEN Order_date between '2023-01-01' and '2023-01-31' THEN 'Enero'
	WHEN Order_date between '2023-02-01' and '2023-02-28' THEN 'Febrero'
    ELSE 'Marzo'
END AS Mes_ventas
FROM order_details P
JOIN menu_items L ON P.item_id = L.menu_item_id
group by Mes_ventas, category
````
<img width="425" alt="Captura de Pantalla 2024-07-25 a la(s) 21 11 07" src="https://github.com/user-attachments/assets/5daa1d26-51c2-430b-94dd-13eab4862569">


6. Pedidos por horario de comida
````
SELECT count(distinct (order_id)) as numero_pedidos,
CASE
    WHEN Order_time between '10:00:00' and '13:59:59' THEN 'Desayuno'
	WHEN Order_time between '14:00:00' and '17:59:59' THEN 'Comida'
    ELSE 'Cena'
END AS Horario_comida
FROM order_details
group by Horario_comida
order by numero_pedidos desc;
````
<img width="287" alt="Captura de Pantalla 2024-07-25 a la(s) 21 12 20" src="https://github.com/user-attachments/assets/2810da82-aa51-405d-bef0-7246cce76f0f">


7. Los 5 productos más vendidos
````
SELECT count (item_id)as número_pedidos_totales, P.item_name, price
FROM menu_items P
JOIN order_details L ON P.menu_item_id = L.item_id
group by P.item_name , price
order by número_pedidos_totales desc
limit 5
````
<img width="467" alt="Captura de Pantalla 2024-07-25 a la(s) 21 14 17" src="https://github.com/user-attachments/assets/2bd64cce-64b0-48ec-a109-d3227f276d9e">


8. Los 5 productos menos vendidos
````
SELECT count (item_id)as número_pedidos_totales, P.item_name, price
FROM menu_items P
JOIN order_details L ON P.menu_item_id = L.item_id
group by P.item_name, price
order by número_pedidos_totales asc
limit 5

````
<img width="471" alt="Captura de Pantalla 2024-07-25 a la(s) 21 15 15" src="https://github.com/user-attachments/assets/1dd8b34f-c8b7-4f80-b5f3-ceabe4bd85db">


9. Los 5 productos que mayores ingresos generan a la empresa
````
SELECT sum (price)as ingreso_total, P.item_name, price
FROM menu_items P
JOIN order_details L ON P.menu_item_id = L.item_id
group by P.item_name, price
order by ingreso_total desc
limit 5
````
<img width="410" alt="Captura de Pantalla 2024-07-25 a la(s) 21 16 21" src="https://github.com/user-attachments/assets/c8901824-410b-438a-9546-ca8a5fdecb53">


10. Los 5 productos que menores ingresos generan a la empresa
````
SELECT sum (price)as ingreso_total, P.item_name, price
FROM menu_items P
JOIN order_details L ON P.menu_item_id = L.item_id
group by P.item_name, price
order by ingreso_total asc
limit 5

````
<img width="407" alt="Captura de Pantalla 2024-07-25 a la(s) 21 17 46" src="https://github.com/user-attachments/assets/536ec4cf-9a93-4a38-a837-36e1cf305eb2">


## Conclusión:
La empresa "Sabores del Mundo" ofrece 32 platillos en su menú, divididos en 4 categorías (asiatica, italiana, americana y mexicana). 
El precio máximo de un platillo es de $19.95, el mínimo es de de $5 y el promedio de $13.92. 
El resgistro de datos contempla de enero a marzo del año 2023, siendo el de mayor volumen de ventas e ingresos el mes de enero.
El horario con mayores volumenes de ventas e ingresos en la cena (de 18:01 a cierre), siendo la comida asiatica la de mayor volumen auque esto se puede deber a que esa categoría es la que más número de platillos diferentes ofrecen (8).
Los 5 productos con mayores ventas son: Hamburger, Edamame, Korean Beef, cheeseburger y French Fries, pero cuando evaluamos el ingreso total de las ventas el ranking cambia, lo mismo ocurre con el top 5 de los productos menos vendidos que son: Chicken Tacos, Potstikers, Cheese Lasagna, Steak Tacos y Cheese Quesadillas, una posible explicación de este fenómeno sería que el precio de los artículos influye en el nivel de ventas.
Se recomienda seguir haciendo el resgistro de ventas comprobar si esta míni tendencia se sigue repitiendo, tomar acción y empezar campañas de publicidad con los porductos más vendidos y con los menos vendidos valorar si es necesario hacer algún cambio, por otro lado, el incorporar información de los costos de los productos, así como los fijos y variables permitirá extender el análisis y encontrar por ejemplo: el producto estrella del negocio, el costo marginal, el punto de equilibrio entre otra información relevante.

## Referencias:
- DeVito. (2022, 1 septiembre). 01 - Descarga e Instalación de PosgreSQL | Curso de Base de Datos PostgresSQL [Vídeo]. YouTube. https://www.youtube.com/watch?v=gEJcMrk3E-Q
- Ferrari, L. P., & Pirozzi, E. (2023). Learn PostgreSQL - Second Edition: Use, Manage and Build Secure and Scalable Databases with PostgreSQL 16.
- SQLBolt - Learn SQL - Introduction to SQL. (s. f.). SQLBolt - Learn SQL With Simple, Interactive Exercises. https://sqlbolt.com/
- W3Schools.com. (s. f.). https://www.w3schools.com/sql/default.asp




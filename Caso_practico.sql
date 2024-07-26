select* from menu_items;
select * from order_details;
select distinct(item_id) from order_details;

-- Encontrar el número de artículos en el menú. ---
select count (distinct menu_item_id) as número_artículos_menú
from menu_items;

-- ¿Cuál es el artículo menos caro y el más caro en el menú? -- 

SELECT item_name, price as precio_más_caro
FROM menu_items
WHERE price =
	(SELECT MAX (price) FROM menu_items);

SELECT item_name, price as precio_más_barato
FROM menu_items
WHERE price =
	(SELECT Min (price) FROM menu_items);
	
-- ¿Cuántos platos americanos hay en el menú? --
select count (category) as nunero_platos_americanos, category
from menu_items
where category = 'American'
group by category;

-- Cuál es el precio promedio de los platos -- 
	
select round (avg (price),2) as precio_promedio_platos
from menu_items;

-- c) Cuántos pedidos únicos se realizaron en total -- 
select * from order_details;

select count (distinct order_id) as número_distinto_ordenes
from order_details;

-- Cuáles son los 5 pedidos que tuvieron el mayor número de artículos -- 
select order_id, count (item_id)
from order_details
group by order_id
order by count desc
limit 5;

-- Cuándo se realizó el primer pedido y el último pedido -- 
SELECT *
FROM order_details
order by order_date desc , order_time desc
limit 1;

SELECT *
FROM order_details
order by order_date asc , order_time asc
limit 1;
 
-- Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05' -- 
SELECT count(order_date) as numero_pedidos
FROM order_details
where order_date between '2023-01-01'and '2023-01-05';

-- Usar ambas tablas para conocer la reacción de los clientes respecto al menú --
SELECT *
FROM menu_items P
JOIN order_details L ON P.menu_item_id = L.item_id;

-- 1 categoria de comida que vende más --
SELECT count(distinct (P.order_id)), category
FROM order_details P
JOIN menu_items L ON P.item_id = L.menu_item_id
group by category 
order by count desc
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

-- Ingresos por comidas -- 
SELECT sum (Price) as ingreso_total, category
FROM order_details P
JOIN menu_items L ON P.item_id = L.menu_item_id
group by category 
order by ingreso_total desc;
	
-- 2 mes como mayor pedidos -- 
SELECT count(distinct (order_id)) as numero_pedidos,
CASE
    WHEN Order_date between '2023-01-01' and '2023-01-31' THEN 'Enero'
	WHEN Order_date between '2023-02-01' and '2023-02-28' THEN 'Febrero'
    ELSE 'Marzo'
END AS Mes_ventas
FROM order_details
group by Mes_ventas
order by numero_pedidos desc;


-- Mes con mayores ingresos -- 

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

-- Ventas de categorías por mes -- 
SELECT count(distinct (order_id)) as numero_pedidos, category ,
CASE
    WHEN Order_date between '2023-01-01' and '2023-01-31' THEN 'Enero'
	WHEN Order_date between '2023-02-01' and '2023-02-28' THEN 'Febrero'
    ELSE 'Marzo'
END AS Mes_ventas
FROM order_details P
JOIN menu_items L ON P.item_id = L.menu_item_id
group by Mes_ventas, category;

-- 3 horarios con mayor pedidos -- 
SELECT count(distinct (order_id)) as numero_pedidos,
CASE
    WHEN Order_time between '10:00:00' and '13:59:59' THEN 'Desayuno'
	WHEN Order_time between '14:00:00' and '17:59:59' THEN 'Comida'
    ELSE 'Cena'
END AS Horario_comida
FROM order_details
group by Horario_comida
order by numero_pedidos desc;

-- 5 productos más vendidos -- 

SELECT count (item_id)as número_pedidos_totales, P.item_name, price
FROM menu_items P
JOIN order_details L ON P.menu_item_id = L.item_id
group by P.item_name , price
order by número_pedidos_totales desc
limit 5;

-- 5 productos menos vendidos -- 
SELECT count (item_id)as número_pedidos_totales, P.item_name, price
FROM menu_items P
JOIN order_details L ON P.menu_item_id = L.item_id
group by P.item_name, price
order by número_pedidos_totales asc
limit 5;
	

-- 5 productos con los mayores ingresos -- 
SELECT sum (price)as ingreso_total, P.item_name, price
FROM menu_items P
JOIN order_details L ON P.menu_item_id = L.item_id
group by P.item_name, price
order by ingreso_total desc
limit 5;


-- 5 productos con los menos ingresos -- 
SELECT sum (price)as ingreso_total, P.item_name, price
FROM menu_items P
JOIN order_details L ON P.menu_item_id = L.item_id
group by P.item_name, price
order by ingreso_total asc
limit 5;
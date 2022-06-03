1. Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd

select model, speed, hd from pc where price < 500

2. Найдите производителей принтеров. Вывести: maker

SELECT maker FROM Product WHERE type = 'Printer' GROUP BY maker

3. Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

Select model, ram, screen from laptop where price > 1000

4. Найдите все записи таблицы Printer для цветных принтеров.

Select * from printer where color = 'y'

5. Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.

Select model, speed, hd from pc where (cd = '12x' or cd = '24x') and price < 600

6. Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

Select distinct p.maker as maker, l.speed as speed from laptop l join product p on l.model = p.model where l.hd >= 10

7. Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

Select distinct p.model, pc.price from product p join pc on p.model = pc.model where maker = 'B' union Select distinct p.model, l.price from product p join laptop l on p.model = l.model where maker = 'B' union Select distinct p.model, pr.price from product p join printer pr on p.model = pr.model where maker = 'B'

8. Найдите производителя, выпускающего ПК, но не ПК-блокноты.

select maker from product where type = 'pc' except select maker from product where type = 'laptop' или select distinct maker from product where type = 'pc' and maker not in (SELECT maker from product where type = 'laptop')

9. Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

Select distinct p.maker from product p join pc pc on p.model = pc.model where pc.speed >= '450'

10. Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

SELECT DISTINCT model, price FROM printer where price = (SELECT MAX(price) FROM printer)

11. Найдите среднюю скорость ПК.

SELECT AVG(speed) FROM PC

12. Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

Select AVG(speed) from laptop where price > '1000'

13. Найдите среднюю скорость ПК, выпущенных производителем A

Select avg(pc.speed) from pc join product p on pc.model = p.model where maker = 'A'

14. Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

Select s.class, s.name, c.country from classes c join ships s on c.class = s.class where numguns >= '10'

15. Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

SELECT hd FROM PC group by hd having count(model) >= 2

16. Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

SELECT DISTINCT A.model AS model, B.model AS model, A.speed As speed, A.ram As ram FROM PC AS A, PC B WHERE A.speed = B.speed AND A.ram = B.ram AND A.model > B.model

17. Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК. Вывести: type, model, speed

SELECT DISTINCT type, model, speed
FROM Laptop, (SELECT type FROM Product) AS Prod(type) WHERE speed < ALL (SELECT speed FROM PC) and type = 'laptop' или SELECT DISTINCT p.type, l.model, l.speed from laptop l join product p on p.model = l.model where l.speed < ALL (select speed from pc)

18. Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price

Select distinct p.maker, pr.price from product p join printer pr on p.model = pr.model where pr.price = (SELECT MIN(price)
FROM printer where color = 'y') and pr.color = 'y'

19. Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана.

Select p.maker, AVG(l.screen) from product p join laptop l on p.model = l.model group by p.maker

20. Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.

Select maker, count(model) as Count_Model from product WHERE type = 'pc' group by maker having count(model) >= 3

21. Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
Вывести: maker, максимальная цена.

Select p.maker, max(pc.price) as max_price from product p join pc pc on p.model = pc.model group by maker

22. Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.

Select speed, avg(price) from pc where speed > '600' group by speed

23. Найдите производителей, которые производили бы как ПК
со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц. Вывести: Maker

Select p.maker from product p join pc pc on p.model = pc.model where pc.speed >= '750' intersect Select p.maker from product p join laptop l on p.model = l.model where l.speed >= '750'

24. Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.

WITH all_model AS (
SELECT model, price FROM pc
UNION ALL
SELECT model, price FROM printer
UNION ALL
SELECT model, price FROM laptop )
SELECT distinct model
FROM all_model WHERE price = ALL ( SELECT max(price) FROM all_model)

25. Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

select distinct p.maker from product p join pc on p.model = pc.model where pc.ram = (select min(ram) from pc) and pc.speed = (SELECT MAX(speed) FROM pc WHERE ram = (SELECT MIN(ram) FROM pc)) and p.maker in (SELECT maker FROM product WHERE type = 'printer')

26. Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.

SELECT AVG(price) as Avg_price FROM (SELECT price
FROM PC WHERE model IN (SELECT model FROM product WHERE maker='A' AND type='PC') UNION ALL SELECT price
FROM Laptop
WHERE model IN (SELECT model FROM product WHERE maker='A' AND
type='Laptop')
) AS prods

27. Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.

SELECT p.maker, avg(pc.hd) from product p join pc pc on p.model = pc.model WHERE pc.model IN (SELECT model FROM pc) AND maker IN (
SELECT maker FROM product WHERE type='printer') group by maker или select p.maker, avg(pc.hd) as avg_hd from product p join pc on p.model = pc.model where p.maker in (select maker from product where type = 'printer') group by p.maker

28. Используя таблицу Product, определить количество производителей, выпускающих по одной модели.

select count(maker) as qty from (SELECT distinct maker
FROM product group by maker having count(model) = 1) AS prod или select distinct count(maker) as qty from product where maker in (Select maker from product group by maker having count(model) = 1)

29. В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще одного раза в день [т.е. первичный ключ (пункт, дата)], написать запрос с выходными данными (пункт, дата, приход, расход). Использовать таблицы Income_o и Outcome_o.

Select i.point, i.date, inc, out from income_o i left join outcome_o o on i.point = o.point and i.date = o.date
union
Select o.point, o.date, inc, out from income_o i right join outcome_o o on i.point = o.point and i.date = o.date

30. В предположении, что приход и расход денег на каждом пункте приема фиксируется произвольное число раз (первичным ключом в таблицах является столбец code), требуется получить таблицу, в которой каждому пункту за каждую дату выполнения операций будет соответствовать одна строка.
Вывод: point, date, суммарный расход пункта за день (out), суммарный приход пункта за день (inc). Отсутствующие значения считать неопределенными (NULL).

select point, date, SUM(sum_out), SUM(sum_inc)
from( select point, date, SUM(inc) as sum_inc, null as sum_out from Income Group by point, date
Union
select point, date, null as sum_inc, SUM(out) as sum_out from Outcome Group by point, date ) as t
group by point, date order by point
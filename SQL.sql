Сформулируйте SQL запрос для создания таблицы book
CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT	
);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Занесите три последние записи в таблицуbook
INSERT INTO book (title, author, price, amount) 
VALUES ('Белая гвардия', 'Булгаков М.А.', 540.50, 5);

INSERT INTO book (title, author, price, amount) 
VALUES ('Идиот', 'Достоевский Ф.М.', 460.00, 10);

INSERT INTO book (title, author, price, amount) 
VALUES ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2);

SELECT * FROM book;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Выбрать авторов, название книг и их цену из таблицы book
SELECT author, title, price
FROM book;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Для упаковки каждой книги требуется один лист бумаги, цена которого 
1 рубль 65 копеек. Посчитать стоимость упаковки для каждой книги 
(сколько денег потребуется, чтобы упаковать все экземпляры книги).
В запросе вывести название книги, ее количество и стоимость упаковки, 
последний столбец назвать pack.
SELECT title, amount,
       amount * 1.65 AS pack
FROM book;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Написать запрос, куда включить автора, название книги и новую цену, 
последний столбец назвать new_price
SELECT author, title, 
    ROUND(IF(author="Булгаков М.А.", price*1.1, IF(author="Есенин С.А.", price*1.05, price*1)), 2) AS new_price
FROM book;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 
или больше 600, а стоимость всех экземпляров этих книг больше или равна 5000.
SELECT title, author, price, amount
FROM book
WHERE (price < 500 OR price > 600) and price * amount >= 5000
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Вывести  автора и название  книг, количество которых принадлежит интервалу от 2 до 14 
(включая границы). Информацию  отсортировать сначала по авторам (в обратном алфавитном 
порядке), а затем по названиям книг (по алфавиту).
SELECT author, title 
FROM book
WHERE amount BETWEEN 2 AND 14 
ORDER BY author DESC, title
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Для каждого автора вычислить суммарную стоимость книг S (имя столбца Стоимость), а также 
вычислить налог на добавленную стоимость  для полученных сумм (имя столбца НДС ) , который 
включен в стоимость и составляет k = 18%,  а также стоимость книг  (Стоимость_без_НДС) без 
него. Значения округлить до двух знаков после запятой.
SELECT author, ROUND(SUM(price * amount),2) AS Стоимость, ROUND(SUM(price * amount) * 0.18 / (1 + 0.18),2) AS НДС, ROUND(SUM(price * amount) / (1 + 0.18),2) AS Стоимость_без_НДС
FROM book
GROUP BY author;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Вычислить среднюю цену и суммарную стоимость тех книг, количество экземпляров которых 
принадлежит интервалу от 5 до 14, включительно. Столбцы назвать Средняя_цена и Стоимость, 
значения округлить до 2-х знаков после запятой
SELECT ROUND(AVG(price),2) AS Средняя_цена, 
    ROUND(SUM(price * amount),2) AS Стоимость
FROM book
WHERE amount BETWEEN '5' AND '14';
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Посчитать стоимость всех экземпляров каждого автора без учета книг «Идиот» и «Белая гвардия».
 В результат включить только тех авторов, у которых суммарная стоимость книг (без учета книг 
 «Идиот» и «Белая гвардия») более 5000 руб. Вычисляемый столбец назвать Стоимость. Результат 
 отсортировать по убыванию стоимости.
SELECT author, SUM(price * amount) AS Стоимость
FROM book
WHERE title  <> 'Идиот' AND title  <> 'Белая гвардия'
GROUP BY author
HAVING SUM(price * amount) > 5000
ORDER BY Стоимость DESC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Вывести информацию (автора, название и цену) о тех книгах, цены которых превышают минимальную 
цену книги на складе не более чем на 150 рублей в отсортированном по возрастанию цены виде
SELECT author, title, price
FROM book
WHERE price <= 
    (SELECT MIN(price)
    FROM book) + 150
ORDER BY price;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Выведите идентификатор комнаты (поле room_id), среднюю стоимость за один день аренды 
(поле price, для вывода используйте псевдоним avg_price), а также количество резерваций этой 
комнаты (используйте псевдоним count). Полученный результат отсортируйте в порядке убывания 
сначала по количеству резерваций, а потом по средней стоимости.
SELECT room_id,
   AVG(price) AS avg_price,
   COUNT(user_id) AS count
FROM Reservations  
GROUP BY room_id
ORDER BY count DESC, avg_price DESC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Выведите типы комнат (поле home_type) и разницу между самым дорогим и самым дешевым 
представителем данного типа. В итоговую выборку включите только те типы жилья, количество 
которых в таблице Rooms больше или равно 2
SELECT home_type,
   MAX(price) - MIN(price) AS difference
FROM Rooms
GROUP BY (home_type) 
HAVING COUNT(home_type) >= 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Выведите названия продуктов, которые покупал член семьи со статусом "son". Для получения 
выборки вам нужно объединить таблицу Payments с таблицей FamilyMembers по полям family_member 
и member_id, а также с таблицей Goods по полям good и good_id.
SELECT good_name 
FROM FamilyMembers
INNER JOIN Payments
    ON FamilyMembers.member_id = Payments.family_member
INNER JOIN Goods
    ON Payments.good = Goods.good_id 
WHERE status = 'son'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Выведите идентификатор (поле room_id) и среднюю оценку комнаты (поле rating, для вывода 
используйте псевдоним avg_score), составленную на основании отзывов из таблицы Reviews.
SELECT room_id, AVG(rating) AS avg_score
FROM Reservations
INNER JOIN Reviews
    ON Reservations.id = Reviews.reservation_id
GROUP BY room_id 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
В какие города летал Bruce Willis
SELECT town_to
FROM Trip
INNER JOIN Pass_in_trip
    ON Trip.id = Pass_in_trip.trip 
INNER JOIN Passenger 
    ON Pass_in_trip.passenger = Passenger.id
WHERE name = 'Bruce Willis'



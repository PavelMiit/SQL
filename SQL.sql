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











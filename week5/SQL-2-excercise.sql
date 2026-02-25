-- 1) SHIPPED orders: orderNumber + totalPrice (first 10)
SELECT
    o."orderNumber" AS "orderNumber",
    SUM(od."quantityOrdered" * od."priceEach") AS "totalPrice"
FROM classicmodels."orders" o
         JOIN classicmodels."orderdetails" od
              ON od."orderNumber" = o."orderNumber"
WHERE o."status" = 'SHIPPED'
GROUP BY o."orderNumber"
ORDER BY o."orderNumber"
    LIMIT 10;

-- 2) Order detail listing with customer + product info (first 10)
SELECT
    o."orderNumber"      AS "orderNumber",
    o."orderDate"        AS "orderDate",
    c."customerName"     AS "customerName",
    od."orderLineNumber" AS "orderLineNumber",
    p."productName"      AS "productName",
    od."quantityOrdered" AS "quantityOrdered",
    od."priceEach"       AS "priceEach"
FROM classicmodels."orders" o
         JOIN classicmodels."customers" c
              ON c."customerNumber" = o."customerNumber"
         JOIN classicmodels."orderdetails" od
              ON od."orderNumber" = o."orderNumber"
         JOIN classicmodels."products" p
              ON p."productCode" = od."productCode"
ORDER BY o."orderNumber", od."orderLineNumber"
    LIMIT 10;

-- 3) Orders with totalPrice > 10,000:
--    show orderNumber, itemsCount, totalPrice (first 10), ordered by totalPrice
SELECT
    o."orderNumber" AS "orderNumber",
    COUNT(*)        AS "itemsCount",
    SUM(od."quantityOrdered" * od."priceEach") AS "totalPrice"
FROM classicmodels."orders" o
         JOIN classicmodels."orderdetails" od
              ON od."orderNumber" = o."orderNumber"
GROUP BY o."orderNumber"
HAVING SUM(od."quantityOrdered" * od."priceEach") > 10000
ORDER BY "totalPrice"
    LIMIT 10;

-- 4) Customer(s) with the minimum payment amount (subquery)
SELECT
    c."customerNumber" AS "customerNumber",
    c."customerName"   AS "customerName",
    p."amount"         AS "amount"
FROM classicmodels."payments" p
         JOIN classicmodels."customers" c
              ON c."customerNumber" = p."customerNumber"
WHERE p."amount" = (
    SELECT MIN(p2."amount")
    FROM classicmodels."payments" p2
);
-- 1
select count(distinct inv_number) as inventory_count
from invoice ;

-- 2
select count(distinct cus_code)
from customer
where cus_balance > 500 ;

-- 3
SELECT	INVOICE.CUS_CODE, INVOICE.INV_NUMBER, INVOICE.INV_DATE, 
	PRODUCT.P_DESCRIPT, LINE.LINE_UNITS, LINE.LINE_PRICE
FROM	CUSTOMER, INVOICE, LINE, PRODUCT
WHERE	CUSTOMER.CUS_CODE = INVOICE.CUS_CODE
AND	INVOICE.INV_NUMBER = LINE.INV_NUMBER 
AND	PRODUCT.P_CODE = LINE.P_CODE
ORDER BY	INVOICE.CUS_CODE, INVOICE.INV_NUMBER, PRODUCT.P_DESCRIPT;

-- 4
select c.cus_code
, i.inv_number
, p.P_DESCRIPT as PRODUCT_DESCRIPTION
, l.line_price as PRICE
, l.line_units as UNITS_PURCHASED
, l.line_price * l.line_units as SUBTOTAL_PRICE
from customer c
	inner join invoice i on c.cus_code = i.cus_code 
	inner join line l on i.inv_number = l.inv_number
	inner join product p on l.p_code = p.p_code
group by 1, 2, 3, 4
order by 1, 2, 6 desc ;

-- 5
-- don't really understand
select c.cus_code
, c.cus_lname
, c.cus_fname
, c.cus_phone
, c.cus_balance as OUTSTANDING_BALANCE
, sum(l.line_price * l.line_units) as TOTAL_INVOICE_PRICE_FOR_CURRENT_SALECYCLE
from customer c
	inner join invoice i on c.cus_code = i.cus_code 
	inner join line l on i.inv_number = l.inv_number
group by c.cus_code, c.cus_balance;

-- 6
select c.cus_code
, c.cus_lname
, c.cus_fname
, c.cus_phone
, c.cus_balance as OUTSTANDING_BALANCE
from customer c
	left join invoice i on c.cus_code = i.cus_code 
where i.cus_code is null ;

-- 7
select p.P_CODE
, v.v_name as VENDOR_NAME
, p.P_DESCRIPT as PRODUCT_DESCRIPTION
, p.P_QOH as quantity_on_hand
, p.P_PRICE as price
, p.P_PRICE * P_QOH as value_of_products
from product p
	inner join vendor v on p.v_code = v.v_code
group by 1, 2, 3, 4, 5 ;
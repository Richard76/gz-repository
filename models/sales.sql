{{ config(schema='transaction') }}

WITH 

  sales AS (SELECT * FROM {{ ref('stg_sales') }} )

  ,product AS (SELECT * FROM {{ ref('stg_product') }} )

SELECT
  s.date_date
  ### Key ###
  ,s.orders_id
  ,s.products_id AS products_id
  ###########
	-- qty --
	,s.qty AS qty
  -- revenue --
  ,s.turnover as turnover 
  -- cost --
  ,CAST(p.purchase_price AS FLOAT64) AS purchase_price
	,ROUND(s.qty*CAST(p.purchase_price AS FLOAT64),2) AS purchase_cost
	-- margin --
	,s.turnover - s.qty*CAST(p.purchase_price AS FLOAT64) AS margin
    ,{{ margin_percent('s.turnover', 's.qty*CAST(p.purchase_price AS FLOAT64)') }} as product_margin_percent 
FROM sales s
INNER JOIN product p ON s.products_id = p.products_id
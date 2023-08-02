SELECT
    products_id,
    CAST(purchSE_PRICE AS FLOAT64)  as purchase_price
FROM `gz_raw_data.raw_gz_product`

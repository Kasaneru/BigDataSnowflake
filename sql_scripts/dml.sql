INSERT INTO dim_pets (
  type, pet_name, breed
)
SELECT DISTINCT
  m.customer_pet_name,
  m.customer_pet_breed,
  m.pet_category
FROM mock_data m;

INSERT INTO dim_sellers (
  first_name, last_name, email, country, postal_code
)
SELECT DISTINCT
  m.seller_first_name,
  m.seller_last_name,
  m.seller_email, 
  m.seller_country, 
  m.seller_postal_code
FROM mock_data m;

INSERT INTO dim_products (
  name, category, price, quantity, weight, color, size, brand, material, description, rating, reviews, release_date, expiry_date 
)
SELECT DISTINCT
  m.product_name,
  m.product_category,
  m.product_price,
  m.product_quantity,
  m.product_weight,
  m.product_color,
  m.product_size,
  m.product_brand,
  m.product_material,
  m.product_description,
  m.product_rating,
  m.product_reviews,
  m.product_release_date::date,
  m.product_expiry_date::date
FROM mock_data m;

INSERT INTO dim_stores (
  name, store_location, city, state, country, phone, email
)
SELECT DISTINCT
  m.store_name,
  m.store_location, 
  m.store_city,
  m.store_state,
  m.store_country,
  m.store_phone,
  m.store_email
FROM mock_data m;

INSERT INTO dim_suppliers (
  name, contact, email, phone, address, city, country
)
SELECT DISTINCT
  m.supplier_name, 
  m.supplier_contact,
  m.supplier_email,
  m.supplier_phone,
  m.supplier_address,
  m.supplier_city,
  m.supplier_country
FROM mock_data m;

INSERT INTO dim_customers (
  first_name, last_name, age, email, country, postal_code, pet_id
)
SELECT DISTINCT
  m.customer_first_name,
  m.customer_last_name,
  m.customer_age,
  m.customer_email,
  m.customer_country,
  m.customer_postal_code,
  p.id
FROM mock_data m
LEFT JOIN dim_pets p ON m.customer_pet_name = p.pet_name AND m.customer_pet_breed = p.breed;

INSERT INTO fact_sales (
  sale_date, customer_id, seller_id, product_id, supplier_id, store_id, quantity, total_price
)
SELECT
  m.sale_date::date, 
  dim_customers.id,
  dim_sellers.id,
  dim_products.id, 
  dim_suppliers.id, 
  dim_stores.id, 
  m.sale_quantity, 
  m.sale_total_price
FROM mock_data m
JOIN dim_customers ON m.customer_email = dim_customers.email
JOIN dim_sellers ON m.seller_email = dim_sellers.email
JOIN dim_products ON m.product_name = dim_products.name AND m.product_category = dim_products.category
JOIN dim_stores ON m.store_name = dim_stores.name AND m.store_city = dim_stores.city
JOIN dim_suppliers ON m.supplier_name = dim_suppliers.name AND m.supplier_email = dim_suppliers.email;

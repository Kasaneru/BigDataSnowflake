-- Создадим таблицу животных для наглядности, на самом деле можно не плодить сущностей
CREATE TABLE dim_pets (
  id serial PRIMARY KEY,
  type varchar(50),
  pet_name varchar(50),
  breed varchar(50)
);

CREATE TABLE dim_customers (
  id serial PRIMARY KEY,
  first_name varchar(50),
  last_name varchar(50),
  age varchar(50),
  email varchar(50),
  country varchar(50),
  postal_code varchar(50),
  pet_id integer REFERENCES dim_pets(id)
);

CREATE TABLE dim_sellers (
  id serial PRIMARY KEY,
  first_name varchar(50),
  last_name varchar(50),
  email varchar(50),
  country varchar(50),
  postal_code varchar(50)
);

CREATE TABLE dim_products (
  id serial PRIMARY KEY,
  name varchar(50),
  category varchar(50),
  price numeric(10, 2),
  quantity varchar(50),
  weight numeric(10, 2),
  color varchar(50),
  size varchar(50),
  brand varchar(50),
  material varchar(50),
  description varchar(1024),
  rating real,
  reviews integer,
  release_date date,
  expiry_date date
);

CREATE TABLE dim_stores (
  id serial PRIMARY KEY,
  name varchar(50),
  store_location varchar(50),
  city varchar(50),
  state varchar(50),
  country varchar(50),
  phone varchar(50),
  email varchar(50)
);

CREATE TABLE dim_suppliers (
  id serial PRIMARY KEY,
  name varchar(50),
  contact varchar(50),
  email varchar(50),
  phone varchar(50),
  address varchar(50),
  city varchar(50),
  country varchar(50)
);

CREATE TABLE fact_sales (
  id serial PRIMARY KEY,
  sale_date date,
  customer_id integer REFERENCES dim_customers(id),
  seller_id integer REFERENCES dim_sellers(id),
  product_id integer REFERENCES dim_products(id),
  supplier_id integer REFERENCES dim_suppliers(id),
  store_id integer REFERENCES dim_stores(id),
  quantity integer,
  total_price numeric(10, 2)
);

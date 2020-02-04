drop table transaction;

drop view transactions_anonymous, transactions_complete;

--create tables

-- card_holder table: individual card holders
create table card_holder(
	id int primary key,
	name varchar
)
;

--credit_card table: individual credit cards (1 to 1 relationship?)
create table credit_card(
	card bigint primary key,
	cardholder_id int
)
;

--merchant table: holds merchant info
create table merchant(
	id int primary key,
	name varchar,
	id_merchant_category int
)
;

--merchant_category
create table merchant_category(
	id int primary key,
	name varchar
)
;

--transaction table: holds all transactions, connects merchants to customer data
create table transaction(
	id int primary key,
	date timestamp,
--	amount money,
	amount numeric(20,2),
	card bigint,
	id_merchant int
)
;
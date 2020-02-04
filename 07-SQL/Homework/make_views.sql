--create view for all data ***WARNING, INCLUDES NAMES (NON-ANONYMOUS)***
create view transactions_complete as
select 
 t.id as transaction,
 t.date as transaction_date,
 t.amount as transaction_amount,
 t.card as credit_card,
 ch.name as cardholder_name,
 ch.id as cardholder_id,
 m.id as merchant_id,
 m.name as merchant_name,
 mc.id as merchant_cat_id,
 mc.name merchant_type
from transaction t
join credit_card cc
 on t.card = cc.card
join card_holder ch
 on cc.cardholder_id = ch.id
join merchant m
 on t.id_merchant = m.id
join merchant_category mc
 on m.id_merchant_category = mc.id
;

--create view for share data 
create view transactions_anonymous as
select 
 t.id as transaction,
 t.date as transaction_date,
 t.amount as transaction_amount,
 t.card as credit_card,
-- ch.name as cardholder_name,
 ch.id as cardholder_id,
 m.id as merchant_id,
 m.name as merchant_name,
 mc.id as merchant_cat_id,
 mc.name merchant_type
from transaction t
join credit_card cc
 on t.card = cc.card
join card_holder ch
 on cc.cardholder_id = ch.id
join merchant m
 on t.id_merchant = m.id
join merchant_category mc
 on m.id_merchant_category = mc.id
;

create view transactions_between_time as
select *
from transactions_complete
where cast(transaction_date as time) >= '07:00:00'
 and cast(transaction_date as time) <= '09:00:00'
-- and transaction_amount <= 2
--group by (merchant_type)
order by(transaction_amount) desc
limit 100
;

create view less_than_2 as
select
 merchant_type,
-- merchant_name,
-- transaction_amount <=2, count(transaction_amount)) as transactions_under_2,
 sum(case when transaction_amount <=2
	 then 1
	 else 0
	 end) as transactions_under_2,
 count(transaction_amount) as total_transactions
from transactions_complete
--where transaction_amount <= 2
group by (merchant_type)
--order by (merchant_type)
order by transactions_under_2 desc
;

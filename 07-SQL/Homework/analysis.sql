select 
 cardholder_id,
 merchant_type,
 merchant_name,
 count(transaction_amount) as number_transactions,
 sum(transaction_amount)/count(transaction_amount) as average_transaction,
 max(transaction_amount) as max_transaction,
 min(transaction_amount) as min_transaction
from transactions_complete
--where merchant_name = 'Curry, Scott and Richardson'
--order by (cardholder_id, merchant_type)
group by (cardholder_id,merchant_type, merchant_name)
--group by (cardholder_id,merchant_type)
order by (cardholder_id, merchant_type,merchant_name)
--where merchant_name = "Curry, Scott and Richard"
;

select 
 count(transaction_amount) as number_transactions,
 sum(transaction_amount)/count(transaction_amount) as average_transaction,
 max(transaction_amount) as max_transaction,
 min(transaction_amount) as min_transaction,
 
from transactions_complete
--where cardholder_id = 6
order by (cardholder_id,merchant_type,transaction_amount)
;
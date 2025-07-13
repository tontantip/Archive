with RFM_score as(

select 
	customer_name,
    datediff(current_date(),max(date_sale)) as Recency,
    count(distinct(date_sale)) as Frequency,
    sum(suum_qty) as Monetary
from customer_data
group by customer_name
),

RFMRank as (
select 
	customer_name,
    Recency,
    Frequency,
    Monetary,
    ntile(5) over (
		order by Recency DESC) as R_score,
	ntile(5) over (
		order by Frequency ) as F_score,
	ntile(5) over (
		order by Monetary) as M_score
	
from RFM_score
)
select *,
concat(R_score,F_score,M_score) as RFM_score 
from RFMRank

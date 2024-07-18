select
    pk_salesorderdetailid
    , fk_addressid
    , pk_salesorderid
    , fk_customerid
    , fk_salespersonid
    , fk_territoryid
    , fk_creditcardid
    , creditcard_display
    , oh_orderdate
    , oh_status_description as oh_status
    , fk_productid
    , fk_specialofferid
    , od_orderqty
    , od_unitprice
    , od_unitpricediscount
    , freight_per_item
    , tax_per_item
    , item_total
    , discounted_item_total
    , oh_totaldue
from {{ ref("int_snowflake__ordered_items") }}

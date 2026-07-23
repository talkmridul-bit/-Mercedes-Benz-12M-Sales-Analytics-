; with Cleaned_Marcedes_Benz_Sales as (
    select distinct
       Model,
       Year,
       Region,
       Color,
       [Fuel Type],
       TRY_CAST([Base Price (USD)] as bigint ) as [Base Price(USD)],
       TRY_CAST(Horsepower as int ) as Horsepower,
       TRY_CAST([Sales Volume] as int ) as Sales_Volume,
       Turbo
  from [dbo].[mercedes_benz_sales_2020_2025]
  where TRY_CAST([Base Price (USD)] as bigint ) > 0 
    and TRY_CAST(Horsepower as int ) > 0 
    and TRY_CAST([Sales Volume] as int ) > 0 
    )
    select
       Model,
       Year,
       Region,
       Color,
       [Fuel Type],
       Turbo,
       sum([Base Price(USD)] ) as Total_Base_Price_USD,
       sum(Sales_Volume) as Total_Sales_Volume,
       sum(Horsepower) as Total_Horsepower
   from Cleaned_Marcedes_Benz_Sales
   where Model is not null
     and Year is not null
     and Color is not null
     and [Fuel Type] is not null
     and Turbo is not null
   group by Model,Year,Region,Color,[Fuel Type],Turbo
    order by Total_Base_Price_USD,Total_Sales_Volume desc;
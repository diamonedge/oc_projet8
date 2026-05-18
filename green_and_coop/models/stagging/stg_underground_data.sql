with underground_data as (
select 
	'ichtegem' as station
	,_airbyte_data -> 'UV' uv
	,_airbyte_data -> 'Gust' gust
	,_airbyte_data -> 'Time' time_hour
	,_airbyte_data -> 'Wind' wind
	,_airbyte_data -> 'Solar' solar
	,_airbyte_data -> 'Speed' speed
	,_airbyte_data -> 'Humidity' humidity
	,_airbyte_data -> 'Pressure' pressure
	,_airbyte_data -> 'Dew Point' dew_point
	,_airbyte_data -> 'Temperature' temperature
	,_airbyte_data -> 'Precip. Rate.' precip_rate
	,_airbyte_data -> 'Precip. Accum.' precip_accum
from {{ source('raw_data','_airbyte_raw_weather_underground_ichtegem') }}
union all
select 
	'la madeleine' as station 
	,_airbyte_data -> 'UV' uv
	,_airbyte_data -> 'Gust' gust
	,_airbyte_data -> 'Time' time_hour
	,_airbyte_data -> 'Wind' wind
	,_airbyte_data -> 'Solar' solar
	,_airbyte_data -> 'Speed' speed
	,_airbyte_data -> 'Humidity' humidity
	,_airbyte_data -> 'Pressure' pressure
	,_airbyte_data -> 'Dew Point' dew_point
	,_airbyte_data -> 'Temperature' temperature
	,_airbyte_data -> 'Precip. Rate.' precip_rate
	,_airbyte_data -> 'Precip. Accum.' precip_accum
from {{ source('raw_data','_airbyte_raw_weather_underground_la_madeleine') }}
)
select 
	*
from underground_data
where uv::text <> 'null'

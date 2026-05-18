with infoclimat as (
	select distinct _airbyte_data infoclimat_data
	from {{ source('raw_data', '_airbyte_raw_stations_meteo_infoclimat') }}
), infoclimat_hourly as (
	select 
		 infoclimat_data -> 'hourly' hourly_data
	from infoclimat
), station_data as (
	select
	    j.key station
	    ,j.value station_data_json
	from infoclimat_hourly s
	cross join lateral jsonb_each(s.hourly_data) as j(key, value)
	where j.key <> '_params'
)
select 
	elem.value -> 'id_station' id_station
	,elem.value -> 'dh_utc' dh_utc
	,elem.value -> 'humidite' humidite
	,elem.value -> 'pluie_1h' pluie_1h
	,elem.value -> 'pluie_3h' pluie_3h
	,elem.value -> 'pression' pression
	,elem.value -> 'vent_moyen' vent_moyen
	,elem.value -> 'temperature' temperature
	,elem.value -> 'vent_rafales' vent_rafales
	,elem.value -> 'point_de_rosee' point_de_rosee
	,elem.value -> 'vent_direction' vent_direction
from station_data a
cross join lateral jsonb_array_elements(a.station_data_json) as elem(value)

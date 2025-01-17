CREATE TABLE "listings_info" (
    "airbnb_id" int NOT NULL,
    "nbh_id" int NOT NULL,
	"host_id" int NOT NULL, 
    "lat" decimal NOT NULL,
    "lon" decimal NOT NULL,
    "city" varchar(30) NOT NULL,
    "state" varchar(2) NOT NULL,
    "night_price" decimal NOT NULL,
    "cleaning_fee" decimal NOT NULL,
    "nights_booked" int NOT NULL,
    "rental_income" decimal NOT NULL,
    "property_type" varchar(30) NOT NULL,
    "room_count" int NOT NULL,
    "bed_count" int NOT NULL,
	"max_capacity" int NOT NULL,
    "star_rating" decimal NOT NULL,
    "total_reviews" int NOT NULL,
	"date_created" date NOT NULL, 
	"date_updated" date NOT NULL, 
 	CONSTRAINT "pk_listings_info" PRIMARY KEY (
        "airbnb_id"
     )
);

CREATE TABLE "top_airbnb_cities" (
    "city_id" int NOT NULL,
    "city" varchar(30) NOT NULL,
    "state" varchar(2) NOT NULL,
    "occupancy" decimal NOT NULL,
    "total_listing" int NOT NULL,
    CONSTRAINT "pk_top_airbnb_cities" PRIMARY KEY (
        "city_id"
     )
);

CREATE TABLE "neighborhood_overview" (
    "nbh_id" int NOT NULL,
    "latitude" decimal NOT NULL,
    "longitude" decimal NOT NULL,
    "walkscore" int NOT NULL,
    "airbnb_count" int NOT NULL,
    "other_count" int NOT NULL,
    "avg_occupancy" decimal NOT NULL,
    "median_price" decimal NOT NULL,
    "sqft_price" decimal NOT NULL,
    CONSTRAINT "pk_neighborhood_overview" PRIMARY KEY (
        "nbh_id"
     )
);

CREATE TABLE "city_nbh" (
    "nbh_id" int NOT NULL,
    "city_id" int NOT NULL
);

CREATE TABLE "top_neighborhood_overview" (
    "nbh_id" int NOT NULL,
    "name" varchar(30) NOT NULL,
    "county" varchar(30) NOT NULL,
    "state" varchar(2) NOT NULL,
	CONSTRAINT "pk_top_neighborhood_overview" PRIMARY KEY (
        "nbh_id"
     )
);

CREATE TABLE "neighborhood_insights" (
    "nbh_id" int NOT NULL,
	"rental_income" decimal NOT NULL,
    "rental_income_change" varchar(4) NOT NULL,
    "rental_income_change_pct" decimal NOT NULL,
	"occupancy" decimal NOT NULL,
    "occupancy_change" varchar(4) NOT NULL,
    "occupancy_change_pct" decimal NOT NULL,
    "bedrm_slope" decimal NOT NULL,
    "bedrm_rsquare" decimal NOT NULL,
    "price_slope" decimal NOT NULL,
    "price_rsquare" decimal NOT NULL,
    "stars_rate_slope" decimal NOT NULL,
    "stars_rate_rsquare" decimal NOT NULL,
    "bathrms_slope" decimal NOT NULL,
    "bathrms_rsquare" decimal NOT NULL,
    "beds_slope" decimal NOT NULL,
    "beds_rsquare" decimal NOT NULL,
    "reviews_count_slope" decimal NOT NULL,
    "reviews_count_rsquare" decimal NOT NULL,
	CONSTRAINT "pk_neighborhood_insights" PRIMARY KEY (
        "nbh_id"
     )
);

CREATE TABLE "rental_rates" (
    "nbh_id" int NOT NULL,
    "studio" decimal NOT NULL,
    "one_room" decimal NOT NULL,
    "two_room" decimal NOT NULL,
    "three_room" decimal NOT NULL,
    "four_room" decimal NOT NULL,
    "sample_count" int NOT NULL,
	CONSTRAINT "pk_rental_rates" PRIMARY KEY (
        "nbh_id"
     )
);

CREATE TABLE "rental_rates_info" (
	"info_id" int NOT NULL,
    "nbh_id" int NOT NULL,
    "bed_number" int NOT NULL,
   	"count" int NOT NULL, 
	"min" int NOT NULL, 
	"max" int NOT NULL, 
	"avg" decimal NOT NULL,
	"rental_income" decimal NOT NULL, 
	"median_value" decimal NOT NULL, 
	"median_night_rate" int NOT NULL, 
	"median_occupancy" int NOT NULL, 
	CONSTRAINT "pk_rental_rates_info" PRIMARY KEY (
        "info_id"
     )
);

CREATE TABLE "merged_census_crime" (
    "crime_id" int NOT NULL,
    "nbh_id" int NOT NULL,
    "TotalPop" int NOT NULL,
    "Men" int NOT NULL,
    "Women" int NOT NULL,
    "Hispanic" decimal NOT NULL,
    "White" decimal NOT NULL,
    "Black" decimal NOT NULL,
    "Native" decimal NOT NULL,
    "Asian" decimal NOT NULL,
    "Pacific" decimal NOT NULL,
    "IncomePerCap" int NOT NULL,
    "Professional" decimal NOT NULL,
    "Walk" decimal NOT NULL,
    "OtherTransp" decimal NOT NULL,
    "WorkAtHome" decimal NOT NULL,
    "MeanCommute" decimal NOT NULL,
    "Unemployment" decimal NOT NULL,
    "Crime_RatePer100K" decimal NOT NULL,
    "Murder" int NOT NULL,
    "Rape" int NOT NULL,
    "Robbery" int NOT NULL,
    "Agg.Assault" int NOT NULL,
    "Burglary" int NOT NULL,
    "Larceny" int NOT NULL,
    "MotorVeh" int NOT NULL,
    "Theft" int NOT NULL,
    "Arson" int NOT NULL,
    CONSTRAINT "pk_merged_census_crime" PRIMARY KEY (
        "crime_id"
     )
);

Create table historical_insights (
 record_id character varying(100), 
 record_timestamp Date,
 city_id integer,
 city character varying(30),  
 nbh_id integer,
 neighbourhood character varying(1000) ,
 country character varying(30),
 calculated_host_listings_count numeric,
 reviews_per_month numeric, 
 price numeric, 
 geo_point_2d character varying(100) , 
 aggregate_calculated_date date,
 number_of_rooms numeric, 
 availability_365 numeric, 
 room_type  character varying(30),
  CONSTRAINT pk_historical_insights PRIMARY KEY (record_id),
  CONSTRAINT fk_historical_insights_city_id FOREIGN KEY (city_id)
        REFERENCES public.top_airbnb_cities (city_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_historical_insights_nbh_id FOREIGN KEY (nbh_id)
        REFERENCES public.top_neighborhood_overview (nbh_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)


ALTER TABLE "listings_info" ADD CONSTRAINT "fk_listings_info_nbh_id" FOREIGN KEY("nbh_id")
REFERENCES "top_neighborhood_overview" ("nbh_id");

ALTER TABLE "neighborhood_overview" ADD CONSTRAINT "fk_neighborhood_overview_nbh_id" FOREIGN KEY("nbh_id")
REFERENCES "top_neighborhood_overview" ("nbh_id");

ALTER TABLE "neighborhood_insights" ADD CONSTRAINT "fk_neighborhood_insights_nbh_id" FOREIGN KEY("nbh_id")
REFERENCES "top_neighborhood_overview" ("nbh_id");

ALTER TABLE "rental_rates" ADD CONSTRAINT "fk_rental_rates_nbh_id" FOREIGN KEY("nbh_id")
REFERENCES "top_neighborhood_overview" ("nbh_id");

ALTER TABLE "rental_rates_info" ADD CONSTRAINT "fk_rental_rates_info_nbh_id" FOREIGN KEY("nbh_id")
REFERENCES "top_neighborhood_overview" ("nbh_id");

ALTER TABLE "city_nbh" ADD CONSTRAINT "fk_city_nbh_nbh_id" FOREIGN KEY("nbh_id")
REFERENCES "top_neighborhood_overview" ("nbh_id");

ALTER TABLE "city_nbh" ADD CONSTRAINT "fk_city_nbh_city_id" FOREIGN KEY("city_id")
REFERENCES "top_airbnb_cities" ("city_id");

ALTER TABLE "merged_census_crime" ADD CONSTRAINT "fk_merged_census_crime_nbh_id" FOREIGN KEY("nbh_id")
REFERENCES "top_neighborhood_overview" ("nbh_id");
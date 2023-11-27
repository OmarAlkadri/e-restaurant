--
-- PostgreSQL database dump
--

-- Dumped from database version 12.0
-- Dumped by pg_dump version 12rc1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: chenge(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.chenge() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."salary" <> OLD."salary" THEN
        INSERT INTO "staff_log"("id", "oldsalary", "newsalary","oldwork","newwork", "time")
        VALUES(OLD."person_id", OLD."salary", NEW."salary",OLD."work_hours",NEW."work_hours", CURRENT_TIMESTAMP::TIMESTAMP);
    ELSEIF NEW."work_hours" <> OLD."work_hours" THEN
        INSERT INTO "staff_log"("id", "oldsalary", "newsalary","oldwork","newwork", "time")
        VALUES(OLD."person_id", OLD."salary", NEW."salary",OLD."work_hours",NEW."work_hours", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.chenge() OWNER TO postgres;

--
-- Name: cityUpdate(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."cityUpdate"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."name" <> OLD."name" THEN
        INSERT INTO "citey_log"("cityid", "cityold", "citynew", "time")
        VALUES(OLD."restaurant_id", OLD."name", NEW."name", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."cityUpdate"() OWNER TO postgres;

--
-- Name: menuUpdate(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."menuUpdate"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."menus" <> OLD."menus" THEN
        INSERT INTO "menu_log"("menuid", "menuold", "menunew", "time")
        VALUES(OLD."menu_id", OLD."menus", NEW."menus", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."menuUpdate"() OWNER TO postgres;

--
-- Name: reservationUpdate(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."reservationUpdate"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."reservation_time" <> OLD."reservation_time" THEN
        INSERT INTO "reservation_log"("reservationid", "reservationold", "reservationnew", "time")
        VALUES(OLD."reservation_id", OLD."reservation_time", NEW."reservation_time", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."reservationUpdate"() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: branches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branches (
    branch_id integer NOT NULL,
    resturant_id integer NOT NULL,
    work_hours integer NOT NULL
);


ALTER TABLE public.branches OWNER TO postgres;

--
-- Name: branches_branch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.branches_branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.branches_branch_id_seq OWNER TO postgres;

--
-- Name: branches_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.branches_branch_id_seq OWNED BY public.branches.branch_id;


--
-- Name: branches_resturant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.branches_resturant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.branches_resturant_id_seq OWNER TO postgres;

--
-- Name: branches_resturant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.branches_resturant_id_seq OWNED BY public.branches.resturant_id;


--
-- Name: citey_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.citey_log (
    city_log_id integer NOT NULL,
    cityid smallint NOT NULL,
    cityold text NOT NULL,
    citynew text NOT NULL,
    "time" timestamp without time zone NOT NULL
);


ALTER TABLE public.citey_log OWNER TO postgres;

--
-- Name: citey_log_city_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.citey_log_city_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.citey_log_city_log_id_seq OWNER TO postgres;

--
-- Name: citey_log_city_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.citey_log_city_log_id_seq OWNED BY public.citey_log.city_log_id;


--
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    name text,
    province_id integer NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_city_id_seq OWNER TO postgres;

--
-- Name: city_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_city_id_seq OWNED BY public.city.city_id;


--
-- Name: city_province_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_province_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_province_id_seq OWNER TO postgres;

--
-- Name: city_province_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_province_id_seq OWNED BY public.city.province_id;


--
-- Name: contact_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_info (
    address text,
    city_id integer NOT NULL,
    contact_info integer NOT NULL,
    person_id integer NOT NULL,
    phone text NOT NULL,
    restaurant_id integer NOT NULL
);


ALTER TABLE public.contact_info OWNER TO postgres;

--
-- Name: contact_info_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_info_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_info_city_id_seq OWNER TO postgres;

--
-- Name: contact_info_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_info_city_id_seq OWNED BY public.contact_info.city_id;


--
-- Name: contact_info_contact_info_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_info_contact_info_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_info_contact_info_seq OWNER TO postgres;

--
-- Name: contact_info_contact_info_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_info_contact_info_seq OWNED BY public.contact_info.contact_info;


--
-- Name: contact_info_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_info_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_info_person_id_seq OWNER TO postgres;

--
-- Name: contact_info_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_info_person_id_seq OWNED BY public.contact_info.person_id;


--
-- Name: contact_info_restaurant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_info_restaurant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_info_restaurant_id_seq OWNER TO postgres;

--
-- Name: contact_info_restaurant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_info_restaurant_id_seq OWNED BY public.contact_info.restaurant_id;


--
-- Name: costumer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.costumer (
    costumer_id integer NOT NULL,
    reservation_id integer NOT NULL
);


ALTER TABLE public.costumer OWNER TO postgres;

--
-- Name: costumer_costumer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.costumer_costumer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.costumer_costumer_id_seq OWNER TO postgres;

--
-- Name: costumer_costumer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.costumer_costumer_id_seq OWNED BY public.costumer.costumer_id;


--
-- Name: costumer_reservation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.costumer_reservation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.costumer_reservation_id_seq OWNER TO postgres;

--
-- Name: costumer_reservation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.costumer_reservation_id_seq OWNED BY public.costumer.reservation_id;


--
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    menu_id integer NOT NULL,
    menus text NOT NULL,
    restaurant_id integer NOT NULL
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- Name: menu_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu_log (
    menu_log_id integer NOT NULL,
    menuid smallint NOT NULL,
    menuold text NOT NULL,
    menunew text NOT NULL,
    "time" timestamp without time zone NOT NULL
);


ALTER TABLE public.menu_log OWNER TO postgres;

--
-- Name: menu_log_menu_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_log_menu_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_log_menu_log_id_seq OWNER TO postgres;

--
-- Name: menu_log_menu_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_log_menu_log_id_seq OWNED BY public.menu_log.menu_log_id;


--
-- Name: menu_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_menu_id_seq OWNER TO postgres;

--
-- Name: menu_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_menu_id_seq OWNED BY public.menu.menu_id;


--
-- Name: menu_restaurant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_restaurant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_restaurant_id_seq OWNER TO postgres;

--
-- Name: menu_restaurant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_restaurant_id_seq OWNED BY public.menu.restaurant_id;


--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    last_name text NOT NULL,
    name text NOT NULL,
    person_id integer NOT NULL,
    restaurant_id integer
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_person_id_seq OWNER TO postgres;

--
-- Name: person_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_person_id_seq OWNED BY public.person.person_id;


--
-- Name: person_restaurant_od_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_restaurant_od_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_restaurant_od_seq OWNER TO postgres;

--
-- Name: person_restaurant_od_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_restaurant_od_seq OWNED BY public.person.restaurant_id;


--
-- Name: provine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provine (
    name text NOT NULL,
    province_id integer NOT NULL
);


ALTER TABLE public.provine OWNER TO postgres;

--
-- Name: provine_province_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.provine_province_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provine_province_id_seq OWNER TO postgres;

--
-- Name: provine_province_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provine_province_id_seq OWNED BY public.provine.province_id;


--
-- Name: rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rating (
    costumer_id integer NOT NULL,
    rating integer NOT NULL,
    rating_id integer NOT NULL,
    restaurant_id integer NOT NULL
);


ALTER TABLE public.rating OWNER TO postgres;

--
-- Name: rating_costumer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rating_costumer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rating_costumer_id_seq OWNER TO postgres;

--
-- Name: rating_costumer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rating_costumer_id_seq OWNED BY public.rating.costumer_id;


--
-- Name: rating_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rating_rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rating_rating_id_seq OWNER TO postgres;

--
-- Name: rating_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rating_rating_id_seq OWNED BY public.rating.rating_id;


--
-- Name: rating_restaurant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rating_restaurant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rating_restaurant_id_seq OWNER TO postgres;

--
-- Name: rating_restaurant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rating_restaurant_id_seq OWNED BY public.rating.restaurant_id;


--
-- Name: reservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation (
    costumer_id integer NOT NULL,
    reservation_id integer NOT NULL,
    reservation_time text NOT NULL,
    restaurant_id integer NOT NULL,
    fiyat integer
);


ALTER TABLE public.reservation OWNER TO postgres;

--
-- Name: reservation_costumer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservation_costumer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservation_costumer_id_seq OWNER TO postgres;

--
-- Name: reservation_costumer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservation_costumer_id_seq OWNED BY public.reservation.costumer_id;


--
-- Name: reservation_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation_log (
    reservation_log_id integer NOT NULL,
    reservationid smallint NOT NULL,
    reservationold text NOT NULL,
    reservationnew text NOT NULL,
    "time" timestamp without time zone NOT NULL
);


ALTER TABLE public.reservation_log OWNER TO postgres;

--
-- Name: reservation_log_reservation_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservation_log_reservation_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservation_log_reservation_log_id_seq OWNER TO postgres;

--
-- Name: reservation_log_reservation_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservation_log_reservation_log_id_seq OWNED BY public.reservation_log.reservation_log_id;


--
-- Name: reservation_reservation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservation_reservation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservation_reservation_id_seq OWNER TO postgres;

--
-- Name: reservation_reservation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservation_reservation_id_seq OWNED BY public.reservation.reservation_id;


--
-- Name: reservation_restaurant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservation_restaurant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservation_restaurant_id_seq OWNER TO postgres;

--
-- Name: reservation_restaurant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservation_restaurant_id_seq OWNED BY public.reservation.restaurant_id;


--
-- Name: restaurant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restaurant (
    restaurant_id integer NOT NULL,
    restaurant_name text NOT NULL,
    twork_hours integer
);


ALTER TABLE public.restaurant OWNER TO postgres;

--
-- Name: restaurant_restaurant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.restaurant_restaurant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.restaurant_restaurant_id_seq OWNER TO postgres;

--
-- Name: restaurant_restaurant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.restaurant_restaurant_id_seq OWNED BY public.restaurant.restaurant_id;


--
-- Name: resturant_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resturant_log (
    res_log_id integer NOT NULL,
    id smallint NOT NULL,
    old text NOT NULL,
    new text NOT NULL,
    "time" timestamp without time zone NOT NULL
);


ALTER TABLE public.resturant_log OWNER TO postgres;

--
-- Name: resturant_log_res_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resturant_log_res_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resturant_log_res_log_id_seq OWNER TO postgres;

--
-- Name: resturant_log_res_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resturant_log_res_log_id_seq OWNED BY public.resturant_log.res_log_id;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    person_id integer NOT NULL,
    salary integer,
    work_hours integer
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- Name: staff_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff_log (
    log_id integer NOT NULL,
    id smallint NOT NULL,
    oldsalary real NOT NULL,
    newsalary real NOT NULL,
    oldwork real NOT NULL,
    newwork real NOT NULL,
    "time" timestamp without time zone NOT NULL
);


ALTER TABLE public.staff_log OWNER TO postgres;

--
-- Name: staff_log_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_log_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staff_log_log_id_seq OWNER TO postgres;

--
-- Name: staff_log_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_log_log_id_seq OWNED BY public.staff_log.log_id;


--
-- Name: staff_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staff_person_id_seq OWNER TO postgres;

--
-- Name: staff_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_person_id_seq OWNED BY public.staff.person_id;


--
-- Name: table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."table" (
    menu_id integer NOT NULL,
    reserved_time text NOT NULL,
    restaurant_id integer NOT NULL,
    table_id integer NOT NULL
);


ALTER TABLE public."table" OWNER TO postgres;

--
-- Name: table_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.table_menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.table_menu_id_seq OWNER TO postgres;

--
-- Name: table_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.table_menu_id_seq OWNED BY public."table".menu_id;


--
-- Name: table_restaurant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.table_restaurant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.table_restaurant_id_seq OWNER TO postgres;

--
-- Name: table_restaurant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.table_restaurant_id_seq OWNED BY public."table".restaurant_id;


--
-- Name: table_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.table_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.table_table_id_seq OWNER TO postgres;

--
-- Name: table_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.table_table_id_seq OWNED BY public."table".table_id;


--
-- Name: branches branch_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branches ALTER COLUMN branch_id SET DEFAULT nextval('public.branches_branch_id_seq'::regclass);


--
-- Name: branches resturant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branches ALTER COLUMN resturant_id SET DEFAULT nextval('public.branches_resturant_id_seq'::regclass);


--
-- Name: citey_log city_log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citey_log ALTER COLUMN city_log_id SET DEFAULT nextval('public.citey_log_city_log_id_seq'::regclass);


--
-- Name: city city_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN city_id SET DEFAULT nextval('public.city_city_id_seq'::regclass);


--
-- Name: city province_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN province_id SET DEFAULT nextval('public.city_province_id_seq'::regclass);


--
-- Name: contact_info city_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_info ALTER COLUMN city_id SET DEFAULT nextval('public.contact_info_city_id_seq'::regclass);


--
-- Name: contact_info contact_info; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_info ALTER COLUMN contact_info SET DEFAULT nextval('public.contact_info_contact_info_seq'::regclass);


--
-- Name: contact_info person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_info ALTER COLUMN person_id SET DEFAULT nextval('public.contact_info_person_id_seq'::regclass);


--
-- Name: contact_info restaurant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_info ALTER COLUMN restaurant_id SET DEFAULT nextval('public.contact_info_restaurant_id_seq'::regclass);


--
-- Name: costumer costumer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costumer ALTER COLUMN costumer_id SET DEFAULT nextval('public.costumer_costumer_id_seq'::regclass);


--
-- Name: costumer reservation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costumer ALTER COLUMN reservation_id SET DEFAULT nextval('public.costumer_reservation_id_seq'::regclass);


--
-- Name: menu menu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu ALTER COLUMN menu_id SET DEFAULT nextval('public.menu_menu_id_seq'::regclass);


--
-- Name: menu restaurant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu ALTER COLUMN restaurant_id SET DEFAULT nextval('public.menu_restaurant_id_seq'::regclass);


--
-- Name: menu_log menu_log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_log ALTER COLUMN menu_log_id SET DEFAULT nextval('public.menu_log_menu_log_id_seq'::regclass);


--
-- Name: person person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person ALTER COLUMN person_id SET DEFAULT nextval('public.person_person_id_seq'::regclass);


--
-- Name: person restaurant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person ALTER COLUMN restaurant_id SET DEFAULT nextval('public.person_restaurant_od_seq'::regclass);


--
-- Name: provine province_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provine ALTER COLUMN province_id SET DEFAULT nextval('public.provine_province_id_seq'::regclass);


--
-- Name: rating costumer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating ALTER COLUMN costumer_id SET DEFAULT nextval('public.rating_costumer_id_seq'::regclass);


--
-- Name: rating rating_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating ALTER COLUMN rating_id SET DEFAULT nextval('public.rating_rating_id_seq'::regclass);


--
-- Name: rating restaurant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating ALTER COLUMN restaurant_id SET DEFAULT nextval('public.rating_restaurant_id_seq'::regclass);


--
-- Name: reservation costumer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation ALTER COLUMN costumer_id SET DEFAULT nextval('public.reservation_costumer_id_seq'::regclass);


--
-- Name: reservation reservation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation ALTER COLUMN reservation_id SET DEFAULT nextval('public.reservation_reservation_id_seq'::regclass);


--
-- Name: reservation restaurant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation ALTER COLUMN restaurant_id SET DEFAULT nextval('public.reservation_restaurant_id_seq'::regclass);


--
-- Name: reservation_log reservation_log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_log ALTER COLUMN reservation_log_id SET DEFAULT nextval('public.reservation_log_reservation_log_id_seq'::regclass);


--
-- Name: restaurant restaurant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurant ALTER COLUMN restaurant_id SET DEFAULT nextval('public.restaurant_restaurant_id_seq'::regclass);


--
-- Name: resturant_log res_log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resturant_log ALTER COLUMN res_log_id SET DEFAULT nextval('public.resturant_log_res_log_id_seq'::regclass);


--
-- Name: staff person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff ALTER COLUMN person_id SET DEFAULT nextval('public.staff_person_id_seq'::regclass);


--
-- Name: staff_log log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_log ALTER COLUMN log_id SET DEFAULT nextval('public.staff_log_log_id_seq'::regclass);


--
-- Name: table menu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."table" ALTER COLUMN menu_id SET DEFAULT nextval('public.table_menu_id_seq'::regclass);


--
-- Name: table restaurant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."table" ALTER COLUMN restaurant_id SET DEFAULT nextval('public.table_restaurant_id_seq'::regclass);


--
-- Name: table table_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."table" ALTER COLUMN table_id SET DEFAULT nextval('public.table_table_id_seq'::regclass);


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: citey_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: contact_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: costumer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.costumer VALUES (1, 1);
INSERT INTO public.costumer VALUES (2, 3);


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.menu VALUES (1, 'ardwtygfuig', 1);


--
-- Data for Name: menu_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.menu_log VALUES (1, 1, 'cac', 'ardwtygfuig', '2019-12-17 14:32:40.546598');


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.person VALUES ('hayfar', 'haydar', 1, 1);
INSERT INTO public.person VALUES ('daw', 'daf', 2, 2);
INSERT INTO public.person VALUES ('dad', 'fewf', 3, 1);
INSERT INTO public.person VALUES ('dawf', 'dwfw', 4, 2);


--
-- Data for Name: provine; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reservation VALUES (2, 2, '2', 1, NULL);
INSERT INTO public.reservation VALUES (1, 1, '165', 1, 52);


--
-- Data for Name: reservation_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reservation_log VALUES (1, 1, '22', '165', '2019-12-17 14:42:31.091681');


--
-- Data for Name: restaurant; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.restaurant VALUES (2, 'adwd', 11);
INSERT INTO public.restaurant VALUES (1, 'adwdwafwagawgw', 15);
INSERT INTO public.restaurant VALUES (3, 'dcw', NULL);


--
-- Data for Name: resturant_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.resturant_log VALUES (1, 1, 'dwadf1', 'adwdwafwagawgw', '2019-12-17 14:27:10.668444');


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.staff VALUES (1, 154, 1);


--
-- Data for Name: staff_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.staff_log VALUES (1, 1, 6000, 100, 365, 365, '2019-12-17 13:56:46.691448');
INSERT INTO public.staff_log VALUES (2, 1, 100, 100, 365, 22222, '2019-12-17 13:56:46.691448');
INSERT INTO public.staff_log VALUES (3, 1, 100, 154, 22222, 22222, '2019-12-17 14:23:18.078482');
INSERT INTO public.staff_log VALUES (4, 1, 154, 154, 22222, 1, '2019-12-17 14:23:18.078482');


--
-- Data for Name: table; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: branches_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.branches_branch_id_seq', 1, false);


--
-- Name: branches_resturant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.branches_resturant_id_seq', 1, false);


--
-- Name: citey_log_city_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.citey_log_city_log_id_seq', 1, false);


--
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_city_id_seq', 1, false);


--
-- Name: city_province_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_province_id_seq', 1, false);


--
-- Name: contact_info_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_info_city_id_seq', 1, false);


--
-- Name: contact_info_contact_info_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_info_contact_info_seq', 1, false);


--
-- Name: contact_info_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_info_person_id_seq', 1, false);


--
-- Name: contact_info_restaurant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_info_restaurant_id_seq', 1, false);


--
-- Name: costumer_costumer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.costumer_costumer_id_seq', 1, true);


--
-- Name: costumer_reservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.costumer_reservation_id_seq', 3, true);


--
-- Name: menu_log_menu_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_log_menu_log_id_seq', 1, true);


--
-- Name: menu_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_menu_id_seq', 1, false);


--
-- Name: menu_restaurant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_restaurant_id_seq', 1, false);


--
-- Name: person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_person_id_seq', 1, true);


--
-- Name: person_restaurant_od_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_restaurant_od_seq', 4, true);


--
-- Name: provine_province_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provine_province_id_seq', 1, false);


--
-- Name: rating_costumer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rating_costumer_id_seq', 1, false);


--
-- Name: rating_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rating_rating_id_seq', 1, false);


--
-- Name: rating_restaurant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rating_restaurant_id_seq', 1, false);


--
-- Name: reservation_costumer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservation_costumer_id_seq', 1, false);


--
-- Name: reservation_log_reservation_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservation_log_reservation_log_id_seq', 1, true);


--
-- Name: reservation_reservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservation_reservation_id_seq', 1, false);


--
-- Name: reservation_restaurant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservation_restaurant_id_seq', 1, false);


--
-- Name: restaurant_restaurant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.restaurant_restaurant_id_seq', 1, false);


--
-- Name: resturant_log_res_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resturant_log_res_log_id_seq', 1, true);


--
-- Name: staff_log_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_log_log_id_seq', 4, true);


--
-- Name: staff_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_person_id_seq', 1, false);


--
-- Name: table_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.table_menu_id_seq', 1, false);


--
-- Name: table_restaurant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.table_restaurant_id_seq', 1, false);


--
-- Name: table_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.table_table_id_seq', 1, false);


--
-- Name: staff_log PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_log
    ADD CONSTRAINT "PK" PRIMARY KEY (log_id);


--
-- Name: resturant_log PK1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resturant_log
    ADD CONSTRAINT "PK1" PRIMARY KEY (res_log_id);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- Name: citey_log pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citey_log
    ADD CONSTRAINT pk PRIMARY KEY (city_log_id);


--
-- Name: menu_log pk1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_log
    ADD CONSTRAINT pk1 PRIMARY KEY (menu_log_id);


--
-- Name: reservation_log pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_log
    ADD CONSTRAINT pk2 PRIMARY KEY (reservation_log_id);


--
-- Name: provine provine_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provine
    ADD CONSTRAINT provine_pkey PRIMARY KEY (province_id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (person_id);


--
-- Name: branches unique_branches_branch_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT unique_branches_branch_id PRIMARY KEY (branch_id);


--
-- Name: city unique_city_city_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT unique_city_city_id UNIQUE (city_id);


--
-- Name: city unique_city_province_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT unique_city_province_id UNIQUE (province_id);


--
-- Name: contact_info unique_contact_info_city_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_info
    ADD CONSTRAINT unique_contact_info_city_id UNIQUE (city_id);


--
-- Name: contact_info unique_contact_info_contact_info; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_info
    ADD CONSTRAINT unique_contact_info_contact_info PRIMARY KEY (contact_info);


--
-- Name: contact_info unique_contact_info_person_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_info
    ADD CONSTRAINT unique_contact_info_person_id UNIQUE (person_id);


--
-- Name: contact_info unique_contact_info_restaurant_idd; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_info
    ADD CONSTRAINT unique_contact_info_restaurant_idd UNIQUE (restaurant_id);


--
-- Name: costumer unique_costumer_costumer_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costumer
    ADD CONSTRAINT unique_costumer_costumer_id PRIMARY KEY (costumer_id);


--
-- Name: costumer unique_costumer_reservation_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costumer
    ADD CONSTRAINT unique_costumer_reservation_id UNIQUE (reservation_id);


--
-- Name: menu unique_menu_menu_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT unique_menu_menu_id PRIMARY KEY (menu_id);


--
-- Name: menu unique_menu_restaurant_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT unique_menu_restaurant_id UNIQUE (restaurant_id);


--
-- Name: person unique_person_person_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT unique_person_person_id PRIMARY KEY (person_id);


--
-- Name: provine unique_provine_province_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provine
    ADD CONSTRAINT unique_provine_province_id UNIQUE (province_id);


--
-- Name: rating unique_rating_costumer_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT unique_rating_costumer_id UNIQUE (costumer_id);


--
-- Name: rating unique_rating_rating_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT unique_rating_rating_id PRIMARY KEY (rating_id);


--
-- Name: rating unique_rating_restaurant_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT unique_rating_restaurant_id UNIQUE (restaurant_id);


--
-- Name: reservation unique_reservation_costumer_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT unique_reservation_costumer_id UNIQUE (costumer_id);


--
-- Name: reservation unique_reservation_reservation_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT unique_reservation_reservation_id PRIMARY KEY (reservation_id);


--
-- Name: restaurant unique_restaurant_restaurant_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurant
    ADD CONSTRAINT unique_restaurant_restaurant_id PRIMARY KEY (restaurant_id);


--
-- Name: staff unique_staff_person_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT unique_staff_person_id UNIQUE (person_id);


--
-- Name: table unique_table_menu_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."table"
    ADD CONSTRAINT unique_table_menu_id UNIQUE (menu_id);


--
-- Name: table unique_table_restaurant_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."table"
    ADD CONSTRAINT unique_table_restaurant_id UNIQUE (restaurant_id);


--
-- Name: table unique_table_table_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."table"
    ADD CONSTRAINT unique_table_table_id PRIMARY KEY (table_id);


--
-- Name: city cityUpd; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "cityUpd" BEFORE UPDATE ON public.city FOR EACH ROW EXECUTE FUNCTION public."cityUpdate"();


--
-- Name: menu menuUpd; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "menuUpd" BEFORE UPDATE ON public.menu FOR EACH ROW EXECUTE FUNCTION public."menuUpdate"();


--
-- Name: reservation reservationUpd; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "reservationUpd" BEFORE UPDATE ON public.reservation FOR EACH ROW EXECUTE FUNCTION public."reservationUpdate"();


--
-- Name: staff staffupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER staffupdate BEFORE UPDATE ON public.staff FOR EACH ROW EXECUTE FUNCTION public.chenge();


--
-- Name: contact_info lnk_city_contact_info; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_info
    ADD CONSTRAINT lnk_city_contact_info FOREIGN KEY (city_id) REFERENCES public.city(city_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: provine lnk_city_provine; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provine
    ADD CONSTRAINT lnk_city_provine FOREIGN KEY (province_id) REFERENCES public.city(city_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rating lnk_costumer_rating; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT lnk_costumer_rating FOREIGN KEY (costumer_id) REFERENCES public.costumer(costumer_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reservation lnk_costumer_reservation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT lnk_costumer_reservation FOREIGN KEY (costumer_id) REFERENCES public.costumer(costumer_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contact_info lnk_person_contact_info; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_info
    ADD CONSTRAINT lnk_person_contact_info FOREIGN KEY (person_id) REFERENCES public.person(person_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: costumer lnk_person_costumer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costumer
    ADD CONSTRAINT lnk_person_costumer FOREIGN KEY (costumer_id) REFERENCES public.person(person_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: staff lnk_person_staff; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT lnk_person_staff FOREIGN KEY (person_id) REFERENCES public.person(person_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: branches lnk_restaurant_branches; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT lnk_restaurant_branches FOREIGN KEY (resturant_id) REFERENCES public.restaurant(restaurant_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contact_info lnk_restaurant_contact_info; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_info
    ADD CONSTRAINT lnk_restaurant_contact_info FOREIGN KEY (restaurant_id) REFERENCES public.restaurant(restaurant_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: menu lnk_restaurant_menu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT lnk_restaurant_menu FOREIGN KEY (restaurant_id) REFERENCES public.restaurant(restaurant_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person lnk_restaurant_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT lnk_restaurant_person FOREIGN KEY (restaurant_id) REFERENCES public.restaurant(restaurant_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rating lnk_restaurant_rating; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT lnk_restaurant_rating FOREIGN KEY (restaurant_id) REFERENCES public.restaurant(restaurant_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reservation lnk_restaurant_reservation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT lnk_restaurant_reservation FOREIGN KEY (restaurant_id) REFERENCES public.restaurant(restaurant_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: table lnk_restaurant_table; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."table"
    ADD CONSTRAINT lnk_restaurant_table FOREIGN KEY (restaurant_id) REFERENCES public.restaurant(restaurant_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


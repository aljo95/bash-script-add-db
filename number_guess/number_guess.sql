--
-- PostgreSQL database dump
--

-- Dumped from database version 12.15 (Ubuntu 12.15-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.15 (Ubuntu 12.15-0ubuntu0.20.04.1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: player_info; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.player_info (
    usernames character varying(22),
    games_played integer,
    best_game integer
);


ALTER TABLE public.player_info OWNER TO freecodecamp;

--
-- Data for Name: player_info; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.player_info VALUES ('user_1691925161144', 2, 29);
INSERT INTO public.player_info VALUES ('user_1691925161145', 5, 13);
INSERT INTO public.player_info VALUES ('user_1691925189086', 2, 41);
INSERT INTO public.player_info VALUES ('user_1691925189087', 5, 3);


--
-- PostgreSQL database dump complete
--


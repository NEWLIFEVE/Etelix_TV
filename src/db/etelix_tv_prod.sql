--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.12
-- Started on 2014-04-01 16:48:16 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 268 (class 3079 OID 11677)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3195 (class 0 OID 0)
-- Dependencies: 268
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 269 (class 1255 OID 13124953)
-- Dependencies: 6
-- Name: concat(anynonarray, anynonarray); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION concat(anynonarray, anynonarray) RETURNS text
    LANGUAGE sql
    AS $_$SELECT CAST($1 AS text) || CAST($2 AS text);$_$;


ALTER FUNCTION public.concat(anynonarray, anynonarray) OWNER TO postgres;

--
-- TOC entry 273 (class 1255 OID 13124954)
-- Dependencies: 6
-- Name: concat(text, anynonarray); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION concat(text, anynonarray) RETURNS text
    LANGUAGE sql
    AS $_$SELECT $1 || CAST($2 AS text);$_$;


ALTER FUNCTION public.concat(text, anynonarray) OWNER TO postgres;

--
-- TOC entry 282 (class 1255 OID 13124955)
-- Dependencies: 6
-- Name: concat(anynonarray, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION concat(anynonarray, text) RETURNS text
    LANGUAGE sql
    AS $_$SELECT CAST($1 AS text) || $2;$_$;


ALTER FUNCTION public.concat(anynonarray, text) OWNER TO postgres;

--
-- TOC entry 283 (class 1255 OID 13124956)
-- Dependencies: 6
-- Name: concat(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION concat(text, text) RETURNS text
    LANGUAGE sql
    AS $_$SELECT $1 || $2;$_$;


ALTER FUNCTION public.concat(text, text) OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 13124957)
-- Dependencies: 6
-- Name: greatest(numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "greatest"(numeric, numeric) RETURNS numeric
    LANGUAGE sql
    AS $_$SELECT CASE WHEN (($1 > $2) OR ($2 IS NULL)) THEN $1 ELSE $2 END;$_$;


ALTER FUNCTION public."greatest"(numeric, numeric) OWNER TO postgres;

--
-- TOC entry 285 (class 1255 OID 13124958)
-- Dependencies: 6
-- Name: greatest(numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "greatest"(numeric, numeric, numeric) RETURNS numeric
    LANGUAGE sql
    AS $_$SELECT greatest($1, greatest($2, $3));$_$;


ALTER FUNCTION public."greatest"(numeric, numeric, numeric) OWNER TO postgres;

--
-- TOC entry 286 (class 1255 OID 13124959)
-- Dependencies: 6
-- Name: rand(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rand() RETURNS double precision
    LANGUAGE sql
    AS $$SELECT random();$$;


ALTER FUNCTION public.rand() OWNER TO postgres;

--
-- TOC entry 287 (class 1255 OID 13124960)
-- Dependencies: 6
-- Name: substring_index(text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION substring_index(text, text, integer) RETURNS text
    LANGUAGE sql
    AS $_$SELECT array_to_string((string_to_array($1, $2)) [1:$3], $2);$_$;


ALTER FUNCTION public.substring_index(text, text, integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 13124961)
-- Dependencies: 2220 2221 2222 2223 6
-- Name: actions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE actions (
    aid character varying(255) DEFAULT '0'::character varying NOT NULL,
    type character varying(32) DEFAULT ''::character varying NOT NULL,
    callback character varying(255) DEFAULT ''::character varying NOT NULL,
    parameters bytea NOT NULL,
    label character varying(255) DEFAULT '0'::character varying NOT NULL
);


ALTER TABLE public.actions OWNER TO postgres;

--
-- TOC entry 3196 (class 0 OID 0)
-- Dependencies: 161
-- Name: TABLE actions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE actions IS 'Stores action information.';


--
-- TOC entry 3197 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN actions.aid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN actions.aid IS 'Primary Key: Unique actions ID.';


--
-- TOC entry 3198 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN actions.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN actions.type IS 'The object that that action acts on (node, user, comment, system or custom types.)';


--
-- TOC entry 3199 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN actions.callback; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN actions.callback IS 'The callback function that executes when the action runs.';


--
-- TOC entry 3200 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN actions.parameters; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN actions.parameters IS 'Parameters to be passed to the callback function.';


--
-- TOC entry 3201 (class 0 OID 0)
-- Dependencies: 161
-- Name: COLUMN actions.label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN actions.label IS 'Label of the action.';


--
-- TOC entry 162 (class 1259 OID 13124971)
-- Dependencies: 2225 2226 2227 2228 6
-- Name: authmap; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE authmap (
    aid integer NOT NULL,
    uid integer DEFAULT 0 NOT NULL,
    authname character varying(128) DEFAULT ''::character varying NOT NULL,
    module character varying(128) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT authmap_aid_check CHECK ((aid >= 0))
);


ALTER TABLE public.authmap OWNER TO postgres;

--
-- TOC entry 3202 (class 0 OID 0)
-- Dependencies: 162
-- Name: TABLE authmap; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE authmap IS 'Stores distributed authentication mapping.';


--
-- TOC entry 3203 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN authmap.aid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN authmap.aid IS 'Primary Key: Unique authmap ID.';


--
-- TOC entry 3204 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN authmap.uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN authmap.uid IS 'User''s users.uid.';


--
-- TOC entry 3205 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN authmap.authname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN authmap.authname IS 'Unique authentication name.';


--
-- TOC entry 3206 (class 0 OID 0)
-- Dependencies: 162
-- Name: COLUMN authmap.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN authmap.module IS 'Module which is controlling the authentication.';


--
-- TOC entry 163 (class 1259 OID 13124978)
-- Dependencies: 6 162
-- Name: authmap_aid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE authmap_aid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authmap_aid_seq OWNER TO postgres;

--
-- TOC entry 3207 (class 0 OID 0)
-- Dependencies: 163
-- Name: authmap_aid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE authmap_aid_seq OWNED BY authmap.aid;


--
-- TOC entry 164 (class 1259 OID 13124980)
-- Dependencies: 2229 6
-- Name: batch; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE batch (
    bid bigint NOT NULL,
    token character varying(64) NOT NULL,
    "timestamp" integer NOT NULL,
    batch bytea,
    CONSTRAINT batch_bid_check CHECK ((bid >= 0))
);


ALTER TABLE public.batch OWNER TO postgres;

--
-- TOC entry 3208 (class 0 OID 0)
-- Dependencies: 164
-- Name: TABLE batch; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE batch IS 'Stores details about batches (processes that run in multiple HTTP requests).';


--
-- TOC entry 3209 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN batch.bid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN batch.bid IS 'Primary Key: Unique batch ID.';


--
-- TOC entry 3210 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN batch.token; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN batch.token IS 'A string token generated against the current user''s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.';


--
-- TOC entry 3211 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN batch."timestamp"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN batch."timestamp" IS 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.';


--
-- TOC entry 3212 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN batch.batch; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN batch.batch IS 'A serialized array containing the processing data for the batch.';


--
-- TOC entry 165 (class 1259 OID 13124987)
-- Dependencies: 2230 2231 2232 2233 2234 2235 2236 2237 2238 2239 6
-- Name: block; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE block (
    bid integer NOT NULL,
    module character varying(64) DEFAULT ''::character varying NOT NULL,
    delta character varying(32) DEFAULT '0'::character varying NOT NULL,
    theme character varying(64) DEFAULT ''::character varying NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    region character varying(64) DEFAULT ''::character varying NOT NULL,
    custom smallint DEFAULT 0 NOT NULL,
    visibility smallint DEFAULT 0 NOT NULL,
    pages text NOT NULL,
    title character varying(64) DEFAULT ''::character varying NOT NULL,
    cache smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.block OWNER TO postgres;

--
-- TOC entry 3213 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE block; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE block IS 'Stores block settings, such as region and visibility settings.';


--
-- TOC entry 3214 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.bid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.bid IS 'Primary Key: Unique block ID.';


--
-- TOC entry 3215 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.module IS 'The module from which the block originates; for example, ''user'' for the Who''s Online block, and ''block'' for any custom blocks.';


--
-- TOC entry 3216 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.delta IS 'Unique ID for block within a module.';


--
-- TOC entry 3217 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.theme; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.theme IS 'The theme under which the block settings apply.';


--
-- TOC entry 3218 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.status IS 'Block enabled status. (1 = enabled, 0 = disabled)';


--
-- TOC entry 3219 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.weight IS 'Block weight within region.';


--
-- TOC entry 3220 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.region; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.region IS 'Theme region within which the block is set.';


--
-- TOC entry 3221 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.custom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.custom IS 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)';


--
-- TOC entry 3222 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.visibility; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.visibility IS 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)';


--
-- TOC entry 3223 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.pages; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.pages IS 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.';


--
-- TOC entry 3224 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.title IS 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)';


--
-- TOC entry 3225 (class 0 OID 0)
-- Dependencies: 165
-- Name: COLUMN block.cache; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block.cache IS 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.';


--
-- TOC entry 166 (class 1259 OID 13125003)
-- Dependencies: 6 165
-- Name: block_bid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE block_bid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.block_bid_seq OWNER TO postgres;

--
-- TOC entry 3226 (class 0 OID 0)
-- Dependencies: 166
-- Name: block_bid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE block_bid_seq OWNED BY block.bid;


--
-- TOC entry 167 (class 1259 OID 13125005)
-- Dependencies: 2242 2243 6
-- Name: block_custom; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE block_custom (
    bid integer NOT NULL,
    body text,
    info character varying(128) DEFAULT ''::character varying NOT NULL,
    format character varying(255),
    CONSTRAINT block_custom_bid_check CHECK ((bid >= 0))
);


ALTER TABLE public.block_custom OWNER TO postgres;

--
-- TOC entry 3227 (class 0 OID 0)
-- Dependencies: 167
-- Name: TABLE block_custom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE block_custom IS 'Stores contents of custom-made blocks.';


--
-- TOC entry 3228 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN block_custom.bid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block_custom.bid IS 'The block''s block.bid.';


--
-- TOC entry 3229 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN block_custom.body; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block_custom.body IS 'Block contents.';


--
-- TOC entry 3230 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN block_custom.info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block_custom.info IS 'Block description.';


--
-- TOC entry 3231 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN block_custom.format; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block_custom.format IS 'The filter_format.format of the block body.';


--
-- TOC entry 168 (class 1259 OID 13125013)
-- Dependencies: 6 167
-- Name: block_custom_bid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE block_custom_bid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.block_custom_bid_seq OWNER TO postgres;

--
-- TOC entry 3232 (class 0 OID 0)
-- Dependencies: 168
-- Name: block_custom_bid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE block_custom_bid_seq OWNED BY block_custom.bid;


--
-- TOC entry 169 (class 1259 OID 13125015)
-- Dependencies: 6
-- Name: block_node_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE block_node_type (
    module character varying(64) NOT NULL,
    delta character varying(32) NOT NULL,
    type character varying(32) NOT NULL
);


ALTER TABLE public.block_node_type OWNER TO postgres;

--
-- TOC entry 3233 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE block_node_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE block_node_type IS 'Sets up display criteria for blocks based on content types';


--
-- TOC entry 3234 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN block_node_type.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block_node_type.module IS 'The block''s origin module, from block.module.';


--
-- TOC entry 3235 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN block_node_type.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block_node_type.delta IS 'The block''s unique delta within module, from block.delta.';


--
-- TOC entry 3236 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN block_node_type.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block_node_type.type IS 'The machine-readable name of this type from node_type.type.';


--
-- TOC entry 170 (class 1259 OID 13125018)
-- Dependencies: 2244 6
-- Name: block_role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE block_role (
    module character varying(64) NOT NULL,
    delta character varying(32) NOT NULL,
    rid bigint NOT NULL,
    CONSTRAINT block_role_rid_check CHECK ((rid >= 0))
);


ALTER TABLE public.block_role OWNER TO postgres;

--
-- TOC entry 3237 (class 0 OID 0)
-- Dependencies: 170
-- Name: TABLE block_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE block_role IS 'Sets up access permissions for blocks based on user roles';


--
-- TOC entry 3238 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN block_role.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block_role.module IS 'The block''s origin module, from block.module.';


--
-- TOC entry 3239 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN block_role.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block_role.delta IS 'The block''s unique delta within module, from block.delta.';


--
-- TOC entry 3240 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN block_role.rid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN block_role.rid IS 'The user''s role ID from users_roles.rid.';


--
-- TOC entry 171 (class 1259 OID 13125022)
-- Dependencies: 2246 2247 6
-- Name: blocked_ips; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE blocked_ips (
    iid integer NOT NULL,
    ip character varying(40) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT blocked_ips_iid_check CHECK ((iid >= 0))
);


ALTER TABLE public.blocked_ips OWNER TO postgres;

--
-- TOC entry 3241 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE blocked_ips; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE blocked_ips IS 'Stores blocked IP addresses.';


--
-- TOC entry 3242 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN blocked_ips.iid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN blocked_ips.iid IS 'Primary Key: unique ID for IP addresses.';


--
-- TOC entry 3243 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN blocked_ips.ip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN blocked_ips.ip IS 'IP address';


--
-- TOC entry 172 (class 1259 OID 13125027)
-- Dependencies: 6 171
-- Name: blocked_ips_iid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE blocked_ips_iid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blocked_ips_iid_seq OWNER TO postgres;

--
-- TOC entry 3244 (class 0 OID 0)
-- Dependencies: 172
-- Name: blocked_ips_iid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE blocked_ips_iid_seq OWNED BY blocked_ips.iid;


--
-- TOC entry 173 (class 1259 OID 13125029)
-- Dependencies: 2248 2249 2250 2251 6
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- TOC entry 3245 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE cache; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache IS 'Generic cache table for caching things not separated out into their own tables. Contributed modules may also use this to store cached items.';


--
-- TOC entry 3246 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN cache.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3247 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN cache.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache.data IS 'A collection of data to cache.';


--
-- TOC entry 3248 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN cache.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3249 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN cache.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3250 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN cache.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 174 (class 1259 OID 13125039)
-- Dependencies: 2252 2253 2254 2255 6
-- Name: cache_block; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache_block (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_block OWNER TO postgres;

--
-- TOC entry 3251 (class 0 OID 0)
-- Dependencies: 174
-- Name: TABLE cache_block; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache_block IS 'Cache table for the Block module to store already built blocks, identified by module, delta, and various contexts which may change the block, such as theme, locale, and caching mode defined for the block.';


--
-- TOC entry 3252 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN cache_block.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_block.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3253 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN cache_block.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_block.data IS 'A collection of data to cache.';


--
-- TOC entry 3254 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN cache_block.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_block.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3255 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN cache_block.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_block.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3256 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN cache_block.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_block.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 175 (class 1259 OID 13125049)
-- Dependencies: 2256 2257 2258 2259 6
-- Name: cache_bootstrap; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache_bootstrap (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_bootstrap OWNER TO postgres;

--
-- TOC entry 3257 (class 0 OID 0)
-- Dependencies: 175
-- Name: TABLE cache_bootstrap; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache_bootstrap IS 'Cache table for data required to bootstrap Drupal, may be routed to a shared memory cache.';


--
-- TOC entry 3258 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN cache_bootstrap.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_bootstrap.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3259 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN cache_bootstrap.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_bootstrap.data IS 'A collection of data to cache.';


--
-- TOC entry 3260 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN cache_bootstrap.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_bootstrap.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3261 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN cache_bootstrap.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_bootstrap.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3262 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN cache_bootstrap.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_bootstrap.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 176 (class 1259 OID 13125059)
-- Dependencies: 2260 2261 2262 2263 6
-- Name: cache_field; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache_field (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_field OWNER TO postgres;

--
-- TOC entry 3263 (class 0 OID 0)
-- Dependencies: 176
-- Name: TABLE cache_field; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache_field IS 'Generic cache table for caching things not separated out into their own tables. Contributed modules may also use this to store cached items.';


--
-- TOC entry 3264 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN cache_field.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_field.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3265 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN cache_field.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_field.data IS 'A collection of data to cache.';


--
-- TOC entry 3266 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN cache_field.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_field.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3267 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN cache_field.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_field.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3268 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN cache_field.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_field.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 177 (class 1259 OID 13125069)
-- Dependencies: 2264 2265 2266 2267 6
-- Name: cache_filter; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache_filter (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_filter OWNER TO postgres;

--
-- TOC entry 3269 (class 0 OID 0)
-- Dependencies: 177
-- Name: TABLE cache_filter; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache_filter IS 'Cache table for the Filter module to store already filtered pieces of text, identified by text format and hash of the text.';


--
-- TOC entry 3270 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN cache_filter.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_filter.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3271 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN cache_filter.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_filter.data IS 'A collection of data to cache.';


--
-- TOC entry 3272 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN cache_filter.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_filter.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3273 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN cache_filter.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_filter.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3274 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN cache_filter.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_filter.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 178 (class 1259 OID 13125079)
-- Dependencies: 2268 2269 2270 2271 6
-- Name: cache_form; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache_form (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_form OWNER TO postgres;

--
-- TOC entry 3275 (class 0 OID 0)
-- Dependencies: 178
-- Name: TABLE cache_form; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache_form IS 'Cache table for the form system to store recently built forms and their storage data, to be used in subsequent page requests.';


--
-- TOC entry 3276 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN cache_form.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_form.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3277 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN cache_form.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_form.data IS 'A collection of data to cache.';


--
-- TOC entry 3278 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN cache_form.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_form.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3279 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN cache_form.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_form.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3280 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN cache_form.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_form.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 179 (class 1259 OID 13125089)
-- Dependencies: 2272 2273 2274 2275 6
-- Name: cache_image; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache_image (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_image OWNER TO postgres;

--
-- TOC entry 3281 (class 0 OID 0)
-- Dependencies: 179
-- Name: TABLE cache_image; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache_image IS 'Cache table used to store information about image manipulations that are in-progress.';


--
-- TOC entry 3282 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN cache_image.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_image.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3283 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN cache_image.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_image.data IS 'A collection of data to cache.';


--
-- TOC entry 3284 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN cache_image.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_image.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3285 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN cache_image.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_image.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3286 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN cache_image.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_image.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 180 (class 1259 OID 13125099)
-- Dependencies: 2276 2277 2278 2279 6
-- Name: cache_libraries; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache_libraries (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_libraries OWNER TO postgres;

--
-- TOC entry 3287 (class 0 OID 0)
-- Dependencies: 180
-- Name: TABLE cache_libraries; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache_libraries IS 'Cache table to store library information.';


--
-- TOC entry 3288 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN cache_libraries.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_libraries.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3289 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN cache_libraries.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_libraries.data IS 'A collection of data to cache.';


--
-- TOC entry 3290 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN cache_libraries.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_libraries.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3291 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN cache_libraries.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_libraries.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3292 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN cache_libraries.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_libraries.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 181 (class 1259 OID 13125109)
-- Dependencies: 2280 2281 2282 2283 6
-- Name: cache_menu; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache_menu (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_menu OWNER TO postgres;

--
-- TOC entry 3293 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE cache_menu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache_menu IS 'Cache table for the menu system to store router information as well as generated link trees for various menu/page/user combinations.';


--
-- TOC entry 3294 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN cache_menu.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_menu.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3295 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN cache_menu.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_menu.data IS 'A collection of data to cache.';


--
-- TOC entry 3296 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN cache_menu.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_menu.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3297 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN cache_menu.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_menu.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3298 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN cache_menu.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_menu.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 182 (class 1259 OID 13125119)
-- Dependencies: 2284 2285 2286 2287 6
-- Name: cache_page; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache_page (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_page OWNER TO postgres;

--
-- TOC entry 3299 (class 0 OID 0)
-- Dependencies: 182
-- Name: TABLE cache_page; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache_page IS 'Cache table used to store compressed pages for anonymous users, if page caching is enabled.';


--
-- TOC entry 3300 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN cache_page.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_page.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3301 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN cache_page.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_page.data IS 'A collection of data to cache.';


--
-- TOC entry 3302 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN cache_page.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_page.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3303 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN cache_page.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_page.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3304 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN cache_page.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_page.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 183 (class 1259 OID 13125129)
-- Dependencies: 2288 2289 2290 2291 6
-- Name: cache_path; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache_path (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_path OWNER TO postgres;

--
-- TOC entry 3305 (class 0 OID 0)
-- Dependencies: 183
-- Name: TABLE cache_path; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache_path IS 'Cache table for path alias lookup.';


--
-- TOC entry 3306 (class 0 OID 0)
-- Dependencies: 183
-- Name: COLUMN cache_path.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_path.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3307 (class 0 OID 0)
-- Dependencies: 183
-- Name: COLUMN cache_path.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_path.data IS 'A collection of data to cache.';


--
-- TOC entry 3308 (class 0 OID 0)
-- Dependencies: 183
-- Name: COLUMN cache_path.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_path.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3309 (class 0 OID 0)
-- Dependencies: 183
-- Name: COLUMN cache_path.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_path.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3310 (class 0 OID 0)
-- Dependencies: 183
-- Name: COLUMN cache_path.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_path.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 184 (class 1259 OID 13125139)
-- Dependencies: 2292 2293 2294 2295 6
-- Name: cache_update; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cache_update (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_update OWNER TO postgres;

--
-- TOC entry 3311 (class 0 OID 0)
-- Dependencies: 184
-- Name: TABLE cache_update; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cache_update IS 'Cache table for the Update module to store information about available releases, fetched from central server.';


--
-- TOC entry 3312 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN cache_update.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_update.cid IS 'Primary Key: Unique cache ID.';


--
-- TOC entry 3313 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN cache_update.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_update.data IS 'A collection of data to cache.';


--
-- TOC entry 3314 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN cache_update.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_update.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- TOC entry 3315 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN cache_update.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_update.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- TOC entry 3316 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN cache_update.serialized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cache_update.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- TOC entry 185 (class 1259 OID 13125149)
-- Dependencies: 2296 2297 2298 2299 2300 2301 2302 2303 2304 2306 6
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comment (
    cid integer NOT NULL,
    pid integer DEFAULT 0 NOT NULL,
    nid integer DEFAULT 0 NOT NULL,
    uid integer DEFAULT 0 NOT NULL,
    subject character varying(64) DEFAULT ''::character varying NOT NULL,
    hostname character varying(128) DEFAULT ''::character varying NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    changed integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    thread character varying(255) NOT NULL,
    name character varying(60),
    mail character varying(64),
    homepage character varying(255),
    language character varying(12) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT comment_status_check CHECK ((status >= 0))
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- TOC entry 3317 (class 0 OID 0)
-- Dependencies: 185
-- Name: TABLE comment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE comment IS 'Stores comments and associated data.';


--
-- TOC entry 3318 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.cid IS 'Primary Key: Unique comment ID.';


--
-- TOC entry 3319 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.pid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.pid IS 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.';


--
-- TOC entry 3320 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.nid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.nid IS 'The node.nid to which this comment is a reply.';


--
-- TOC entry 3321 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.uid IS 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.';


--
-- TOC entry 3322 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.subject IS 'The comment title.';


--
-- TOC entry 3323 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.hostname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.hostname IS 'The author''s host name.';


--
-- TOC entry 3324 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.created IS 'The time that the comment was created, as a Unix timestamp.';


--
-- TOC entry 3325 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.changed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.changed IS 'The time that the comment was last edited, as a Unix timestamp.';


--
-- TOC entry 3326 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.status IS 'The published status of a comment. (0 = Not Published, 1 = Published)';


--
-- TOC entry 3327 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.thread; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.thread IS 'The vancode representation of the comment''s place in a thread.';


--
-- TOC entry 3328 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.name IS 'The comment author''s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.';


--
-- TOC entry 3329 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.mail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.mail IS 'The comment author''s e-mail address from the comment form, if user is anonymous, and the ''Anonymous users may/must leave their contact information'' setting is turned on.';


--
-- TOC entry 3330 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.homepage; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.homepage IS 'The comment author''s home page address from the comment form, if user is anonymous, and the ''Anonymous users may/must leave their contact information'' setting is turned on.';


--
-- TOC entry 3331 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN comment.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN comment.language IS 'The languages.language of this comment.';


--
-- TOC entry 186 (class 1259 OID 13125165)
-- Dependencies: 6 185
-- Name: comment_cid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comment_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_cid_seq OWNER TO postgres;

--
-- TOC entry 3332 (class 0 OID 0)
-- Dependencies: 186
-- Name: comment_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comment_cid_seq OWNED BY comment.cid;


--
-- TOC entry 187 (class 1259 OID 13125167)
-- Dependencies: 6
-- Name: date_format_locale; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE date_format_locale (
    format character varying(100) NOT NULL,
    type character varying(64) NOT NULL,
    language character varying(12) NOT NULL
);


ALTER TABLE public.date_format_locale OWNER TO postgres;

--
-- TOC entry 3333 (class 0 OID 0)
-- Dependencies: 187
-- Name: TABLE date_format_locale; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE date_format_locale IS 'Stores configured date formats for each locale.';


--
-- TOC entry 3334 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN date_format_locale.format; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN date_format_locale.format IS 'The date format string.';


--
-- TOC entry 3335 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN date_format_locale.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN date_format_locale.type IS 'The date format type, e.g. medium.';


--
-- TOC entry 3336 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN date_format_locale.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN date_format_locale.language IS 'A languages.language for this format to be used with.';


--
-- TOC entry 188 (class 1259 OID 13125170)
-- Dependencies: 2307 6
-- Name: date_format_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE date_format_type (
    type character varying(64) NOT NULL,
    title character varying(255) NOT NULL,
    locked smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.date_format_type OWNER TO postgres;

--
-- TOC entry 3337 (class 0 OID 0)
-- Dependencies: 188
-- Name: TABLE date_format_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE date_format_type IS 'Stores configured date format types.';


--
-- TOC entry 3338 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN date_format_type.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN date_format_type.type IS 'The date format type, e.g. medium.';


--
-- TOC entry 3339 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN date_format_type.title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN date_format_type.title IS 'The human readable name of the format type.';


--
-- TOC entry 3340 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN date_format_type.locked; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN date_format_type.locked IS 'Whether or not this is a system provided format.';


--
-- TOC entry 189 (class 1259 OID 13125174)
-- Dependencies: 2309 2310 6
-- Name: date_formats; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE date_formats (
    dfid integer NOT NULL,
    format character varying(100) NOT NULL,
    type character varying(64) NOT NULL,
    locked smallint DEFAULT 0 NOT NULL,
    CONSTRAINT date_formats_dfid_check CHECK ((dfid >= 0))
);


ALTER TABLE public.date_formats OWNER TO postgres;

--
-- TOC entry 3341 (class 0 OID 0)
-- Dependencies: 189
-- Name: TABLE date_formats; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE date_formats IS 'Stores configured date formats.';


--
-- TOC entry 3342 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN date_formats.dfid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN date_formats.dfid IS 'The date format identifier.';


--
-- TOC entry 3343 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN date_formats.format; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN date_formats.format IS 'The date format string.';


--
-- TOC entry 3344 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN date_formats.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN date_formats.type IS 'The date format type, e.g. medium.';


--
-- TOC entry 3345 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN date_formats.locked; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN date_formats.locked IS 'Whether or not this format can be modified.';


--
-- TOC entry 190 (class 1259 OID 13125179)
-- Dependencies: 189 6
-- Name: date_formats_dfid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE date_formats_dfid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.date_formats_dfid_seq OWNER TO postgres;

--
-- TOC entry 3346 (class 0 OID 0)
-- Dependencies: 190
-- Name: date_formats_dfid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE date_formats_dfid_seq OWNED BY date_formats.dfid;


--
-- TOC entry 191 (class 1259 OID 13125181)
-- Dependencies: 2311 2312 2313 2314 2315 2316 2317 2318 6
-- Name: field_config; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_config (
    id integer NOT NULL,
    field_name character varying(32) NOT NULL,
    type character varying(128) NOT NULL,
    module character varying(128) DEFAULT ''::character varying NOT NULL,
    active smallint DEFAULT 0 NOT NULL,
    storage_type character varying(128) NOT NULL,
    storage_module character varying(128) DEFAULT ''::character varying NOT NULL,
    storage_active smallint DEFAULT 0 NOT NULL,
    locked smallint DEFAULT 0 NOT NULL,
    data bytea NOT NULL,
    cardinality smallint DEFAULT 0 NOT NULL,
    translatable smallint DEFAULT 0 NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.field_config OWNER TO postgres;

--
-- TOC entry 3347 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN field_config.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config.id IS 'The primary identifier for a field';


--
-- TOC entry 3348 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN field_config.field_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config.field_name IS 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.';


--
-- TOC entry 3349 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN field_config.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config.type IS 'The type of this field.';


--
-- TOC entry 3350 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN field_config.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config.module IS 'The module that implements the field type.';


--
-- TOC entry 3351 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN field_config.active; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config.active IS 'Boolean indicating whether the module that implements the field type is enabled.';


--
-- TOC entry 3352 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN field_config.storage_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config.storage_type IS 'The storage backend for the field.';


--
-- TOC entry 3353 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN field_config.storage_module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config.storage_module IS 'The module that implements the storage backend.';


--
-- TOC entry 3354 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN field_config.storage_active; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config.storage_active IS 'Boolean indicating whether the module that implements the storage backend is enabled.';


--
-- TOC entry 3355 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN field_config.locked; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config.locked IS '@TODO';


--
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN field_config.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config.data IS 'Serialized data containing the field properties that do not warrant a dedicated column.';


--
-- TOC entry 192 (class 1259 OID 13125195)
-- Dependencies: 6 191
-- Name: field_config_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE field_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.field_config_id_seq OWNER TO postgres;

--
-- TOC entry 3357 (class 0 OID 0)
-- Dependencies: 192
-- Name: field_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE field_config_id_seq OWNED BY field_config.id;


--
-- TOC entry 193 (class 1259 OID 13125197)
-- Dependencies: 2320 2321 2322 2323 6
-- Name: field_config_instance; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_config_instance (
    id integer NOT NULL,
    field_id integer NOT NULL,
    field_name character varying(32) DEFAULT ''::character varying NOT NULL,
    entity_type character varying(32) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    data bytea NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.field_config_instance OWNER TO postgres;

--
-- TOC entry 3358 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN field_config_instance.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config_instance.id IS 'The primary identifier for a field instance';


--
-- TOC entry 3359 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN field_config_instance.field_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_config_instance.field_id IS 'The identifier of the field attached by this instance';


--
-- TOC entry 194 (class 1259 OID 13125207)
-- Dependencies: 193 6
-- Name: field_config_instance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE field_config_instance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.field_config_instance_id_seq OWNER TO postgres;

--
-- TOC entry 3360 (class 0 OID 0)
-- Dependencies: 194
-- Name: field_config_instance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE field_config_instance_id_seq OWNED BY field_config_instance.id;


--
-- TOC entry 195 (class 1259 OID 13125209)
-- Dependencies: 2325 2326 2327 2328 2329 2330 2331 6
-- Name: field_data_body; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_data_body (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    body_value text,
    body_summary text,
    body_format character varying(255),
    CONSTRAINT field_data_body_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_data_body_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_data_body_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_data_body OWNER TO postgres;

--
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 195
-- Name: TABLE field_data_body; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_data_body IS 'Data storage for field 2 (body)';


--
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN field_data_body.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_body.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN field_data_body.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_body.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3364 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN field_data_body.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_body.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN field_data_body.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_body.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3366 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN field_data_body.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_body.revision_id IS 'The entity revision id this data is attached to, or NULL if the entity type is not versioned';


--
-- TOC entry 3367 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN field_data_body.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_body.language IS 'The language for this data item.';


--
-- TOC entry 3368 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN field_data_body.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_body.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 196 (class 1259 OID 13125222)
-- Dependencies: 2332 2333 2334 2335 2336 2337 2338 6
-- Name: field_data_comment_body; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_data_comment_body (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    comment_body_value text,
    comment_body_format character varying(255),
    CONSTRAINT field_data_comment_body_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_data_comment_body_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_data_comment_body_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_data_comment_body OWNER TO postgres;

--
-- TOC entry 3369 (class 0 OID 0)
-- Dependencies: 196
-- Name: TABLE field_data_comment_body; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_data_comment_body IS 'Data storage for field 1 (comment_body)';


--
-- TOC entry 3370 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN field_data_comment_body.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_comment_body.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3371 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN field_data_comment_body.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_comment_body.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3372 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN field_data_comment_body.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_comment_body.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3373 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN field_data_comment_body.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_comment_body.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3374 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN field_data_comment_body.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_comment_body.revision_id IS 'The entity revision id this data is attached to, or NULL if the entity type is not versioned';


--
-- TOC entry 3375 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN field_data_comment_body.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_comment_body.language IS 'The language for this data item.';


--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN field_data_comment_body.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_comment_body.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 197 (class 1259 OID 13125235)
-- Dependencies: 2339 2340 2341 2342 2343 2344 2345 2346 2347 2348 6
-- Name: field_data_field_image; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_data_field_image (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_image_fid bigint,
    field_image_alt character varying(512),
    field_image_title character varying(1024),
    field_image_width bigint,
    field_image_height bigint,
    CONSTRAINT field_data_field_image_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_data_field_image_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_data_field_image_field_image_fid_check CHECK ((field_image_fid >= 0)),
    CONSTRAINT field_data_field_image_field_image_height_check CHECK ((field_image_height >= 0)),
    CONSTRAINT field_data_field_image_field_image_width_check CHECK ((field_image_width >= 0)),
    CONSTRAINT field_data_field_image_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_data_field_image OWNER TO postgres;

--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 197
-- Name: TABLE field_data_field_image; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_data_field_image IS 'Data storage for field 4 (field_image)';


--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3379 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3381 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3382 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.revision_id IS 'The entity revision id this data is attached to, or NULL if the entity type is not versioned';


--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.language IS 'The language for this data item.';


--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.field_image_fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.field_image_fid IS 'The file_managed.fid being referenced in this field.';


--
-- TOC entry 3386 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.field_image_alt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.field_image_alt IS 'Alternative image text, for the image''s ''alt'' attribute.';


--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.field_image_title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.field_image_title IS 'Image title text, for the image''s ''title'' attribute.';


--
-- TOC entry 3388 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.field_image_width; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.field_image_width IS 'The width of the image in pixels.';


--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN field_data_field_image.field_image_height; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_image.field_image_height IS 'The height of the image in pixels.';


--
-- TOC entry 198 (class 1259 OID 13125251)
-- Dependencies: 2349 2350 2351 2352 2353 2354 2355 2356 6
-- Name: field_data_field_tags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_data_field_tags (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_tags_tid bigint,
    CONSTRAINT field_data_field_tags_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_data_field_tags_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_data_field_tags_field_tags_tid_check CHECK ((field_tags_tid >= 0)),
    CONSTRAINT field_data_field_tags_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_data_field_tags OWNER TO postgres;

--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 198
-- Name: TABLE field_data_field_tags; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_data_field_tags IS 'Data storage for field 3 (field_tags)';


--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN field_data_field_tags.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_tags.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN field_data_field_tags.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_tags.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN field_data_field_tags.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_tags.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN field_data_field_tags.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_tags.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN field_data_field_tags.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_tags.revision_id IS 'The entity revision id this data is attached to, or NULL if the entity type is not versioned';


--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN field_data_field_tags.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_tags.language IS 'The language for this data item.';


--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN field_data_field_tags.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_tags.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 264 (class 1259 OID 13178323)
-- Dependencies: 2670 2671 2672 2673 2674 2675 2676 2677 2678 2679 6
-- Name: field_data_field_video; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_data_field_video (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_video_fid bigint,
    field_video_display integer DEFAULT 1 NOT NULL,
    field_video_description text,
    CONSTRAINT field_data_field_video_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_data_field_video_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_data_field_video_field_video_display_check CHECK ((field_video_display >= 0)),
    CONSTRAINT field_data_field_video_field_video_fid_check CHECK ((field_video_fid >= 0)),
    CONSTRAINT field_data_field_video_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_data_field_video OWNER TO postgres;

--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 264
-- Name: TABLE field_data_field_video; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_data_field_video IS 'Data storage for field 5 (field_video)';


--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN field_data_field_video.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN field_data_field_video.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN field_data_field_video.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN field_data_field_video.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN field_data_field_video.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video.revision_id IS 'The entity revision id this data is attached to, or NULL if the entity type is not versioned';


--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN field_data_field_video.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video.language IS 'The language for this data item.';


--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN field_data_field_video.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN field_data_field_video.field_video_fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video.field_video_fid IS 'The file_managed.fid being referenced in this field.';


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN field_data_field_video.field_video_display; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video.field_video_display IS 'Flag to control whether this file should be displayed when viewing content.';


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN field_data_field_video.field_video_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video.field_video_description IS 'A description of the file.';


--
-- TOC entry 266 (class 1259 OID 13178398)
-- Dependencies: 2690 2691 2692 2693 2694 2695 2696 2697 2698 2699 6
-- Name: field_data_field_video_articulo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_data_field_video_articulo (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_video_articulo_fid bigint,
    field_video_articulo_display integer DEFAULT 1 NOT NULL,
    field_video_articulo_description text,
    CONSTRAINT field_data_field_video_artic_field_video_articulo_display_check CHECK ((field_video_articulo_display >= 0)),
    CONSTRAINT field_data_field_video_articulo_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_data_field_video_articulo_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_data_field_video_articulo_field_video_articulo_fid_check CHECK ((field_video_articulo_fid >= 0)),
    CONSTRAINT field_data_field_video_articulo_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_data_field_video_articulo OWNER TO postgres;

--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 266
-- Name: TABLE field_data_field_video_articulo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_data_field_video_articulo IS 'Data storage for field 6 (field_video_articulo)';


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN field_data_field_video_articulo.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video_articulo.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN field_data_field_video_articulo.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video_articulo.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN field_data_field_video_articulo.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video_articulo.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN field_data_field_video_articulo.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video_articulo.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN field_data_field_video_articulo.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video_articulo.revision_id IS 'The entity revision id this data is attached to, or NULL if the entity type is not versioned';


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN field_data_field_video_articulo.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video_articulo.language IS 'The language for this data item.';


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN field_data_field_video_articulo.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video_articulo.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN field_data_field_video_articulo.field_video_articulo_fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video_articulo.field_video_articulo_fid IS 'The file_managed.fid being referenced in this field.';


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN field_data_field_video_articulo.field_video_articulo_display; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video_articulo.field_video_articulo_display IS 'Flag to control whether this file should be displayed when viewing content.';


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN field_data_field_video_articulo.field_video_articulo_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_data_field_video_articulo.field_video_articulo_description IS 'A description of the file.';


--
-- TOC entry 199 (class 1259 OID 13125294)
-- Dependencies: 2357 2358 2359 2360 2361 2362 2363 6
-- Name: field_revision_body; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_revision_body (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint NOT NULL,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    body_value text,
    body_summary text,
    body_format character varying(255),
    CONSTRAINT field_revision_body_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_revision_body_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_revision_body_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_revision_body OWNER TO postgres;

--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 199
-- Name: TABLE field_revision_body; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_revision_body IS 'Revision archive storage for field 2 (body)';


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN field_revision_body.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_body.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN field_revision_body.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_body.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN field_revision_body.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_body.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN field_revision_body.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_body.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN field_revision_body.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_body.revision_id IS 'The entity revision id this data is attached to';


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN field_revision_body.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_body.language IS 'The language for this data item.';


--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN field_revision_body.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_body.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 200 (class 1259 OID 13125307)
-- Dependencies: 2364 2365 2366 2367 2368 2369 2370 6
-- Name: field_revision_comment_body; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_revision_comment_body (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint NOT NULL,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    comment_body_value text,
    comment_body_format character varying(255),
    CONSTRAINT field_revision_comment_body_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_revision_comment_body_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_revision_comment_body_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_revision_comment_body OWNER TO postgres;

--
-- TOC entry 3428 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE field_revision_comment_body; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_revision_comment_body IS 'Revision archive storage for field 1 (comment_body)';


--
-- TOC entry 3429 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN field_revision_comment_body.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_comment_body.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN field_revision_comment_body.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_comment_body.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3431 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN field_revision_comment_body.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_comment_body.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3432 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN field_revision_comment_body.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_comment_body.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3433 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN field_revision_comment_body.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_comment_body.revision_id IS 'The entity revision id this data is attached to';


--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN field_revision_comment_body.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_comment_body.language IS 'The language for this data item.';


--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN field_revision_comment_body.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_comment_body.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 201 (class 1259 OID 13125320)
-- Dependencies: 2371 2372 2373 2374 2375 2376 2377 2378 2379 2380 6
-- Name: field_revision_field_image; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_revision_field_image (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint NOT NULL,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_image_fid bigint,
    field_image_alt character varying(512),
    field_image_title character varying(1024),
    field_image_width bigint,
    field_image_height bigint,
    CONSTRAINT field_revision_field_image_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_revision_field_image_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_revision_field_image_field_image_fid_check CHECK ((field_image_fid >= 0)),
    CONSTRAINT field_revision_field_image_field_image_height_check CHECK ((field_image_height >= 0)),
    CONSTRAINT field_revision_field_image_field_image_width_check CHECK ((field_image_width >= 0)),
    CONSTRAINT field_revision_field_image_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_revision_field_image OWNER TO postgres;

--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 201
-- Name: TABLE field_revision_field_image; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_revision_field_image IS 'Revision archive storage for field 4 (field_image)';


--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.revision_id IS 'The entity revision id this data is attached to';


--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.language IS 'The language for this data item.';


--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.field_image_fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.field_image_fid IS 'The file_managed.fid being referenced in this field.';


--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.field_image_alt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.field_image_alt IS 'Alternative image text, for the image''s ''alt'' attribute.';


--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.field_image_title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.field_image_title IS 'Image title text, for the image''s ''title'' attribute.';


--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.field_image_width; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.field_image_width IS 'The width of the image in pixels.';


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN field_revision_field_image.field_image_height; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_image.field_image_height IS 'The height of the image in pixels.';


--
-- TOC entry 202 (class 1259 OID 13125336)
-- Dependencies: 2381 2382 2383 2384 2385 2386 2387 2388 6
-- Name: field_revision_field_tags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_revision_field_tags (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint NOT NULL,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_tags_tid bigint,
    CONSTRAINT field_revision_field_tags_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_revision_field_tags_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_revision_field_tags_field_tags_tid_check CHECK ((field_tags_tid >= 0)),
    CONSTRAINT field_revision_field_tags_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_revision_field_tags OWNER TO postgres;

--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE field_revision_field_tags; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_revision_field_tags IS 'Revision archive storage for field 3 (field_tags)';


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN field_revision_field_tags.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_tags.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN field_revision_field_tags.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_tags.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN field_revision_field_tags.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_tags.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN field_revision_field_tags.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_tags.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN field_revision_field_tags.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_tags.revision_id IS 'The entity revision id this data is attached to';


--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN field_revision_field_tags.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_tags.language IS 'The language for this data item.';


--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN field_revision_field_tags.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_tags.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 265 (class 1259 OID 13178348)
-- Dependencies: 2680 2681 2682 2683 2684 2685 2686 2687 2688 2689 6
-- Name: field_revision_field_video; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_revision_field_video (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint NOT NULL,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_video_fid bigint,
    field_video_display integer DEFAULT 1 NOT NULL,
    field_video_description text,
    CONSTRAINT field_revision_field_video_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_revision_field_video_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_revision_field_video_field_video_display_check CHECK ((field_video_display >= 0)),
    CONSTRAINT field_revision_field_video_field_video_fid_check CHECK ((field_video_fid >= 0)),
    CONSTRAINT field_revision_field_video_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_revision_field_video OWNER TO postgres;

--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 265
-- Name: TABLE field_revision_field_video; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_revision_field_video IS 'Revision archive storage for field 5 (field_video)';


--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN field_revision_field_video.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN field_revision_field_video.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN field_revision_field_video.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN field_revision_field_video.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN field_revision_field_video.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video.revision_id IS 'The entity revision id this data is attached to';


--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN field_revision_field_video.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video.language IS 'The language for this data item.';


--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN field_revision_field_video.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN field_revision_field_video.field_video_fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video.field_video_fid IS 'The file_managed.fid being referenced in this field.';


--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN field_revision_field_video.field_video_display; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video.field_video_display IS 'Flag to control whether this file should be displayed when viewing content.';


--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN field_revision_field_video.field_video_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video.field_video_description IS 'A description of the file.';


--
-- TOC entry 267 (class 1259 OID 13178423)
-- Dependencies: 2700 2701 2702 2703 2704 2705 2706 2707 2708 2709 6
-- Name: field_revision_field_video_articulo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE field_revision_field_video_articulo (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint NOT NULL,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_video_articulo_fid bigint,
    field_video_articulo_display integer DEFAULT 1 NOT NULL,
    field_video_articulo_description text,
    CONSTRAINT field_revision_field_video_a_field_video_articulo_display_check CHECK ((field_video_articulo_display >= 0)),
    CONSTRAINT field_revision_field_video_artic_field_video_articulo_fid_check CHECK ((field_video_articulo_fid >= 0)),
    CONSTRAINT field_revision_field_video_articulo_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_revision_field_video_articulo_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_revision_field_video_articulo_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_revision_field_video_articulo OWNER TO postgres;

--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 267
-- Name: TABLE field_revision_field_video_articulo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE field_revision_field_video_articulo IS 'Revision archive storage for field 6 (field_video_articulo)';


--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN field_revision_field_video_articulo.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video_articulo.entity_type IS 'The entity type this data is attached to';


--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN field_revision_field_video_articulo.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video_articulo.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN field_revision_field_video_articulo.deleted; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video_articulo.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN field_revision_field_video_articulo.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video_articulo.entity_id IS 'The entity id this data is attached to';


--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN field_revision_field_video_articulo.revision_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video_articulo.revision_id IS 'The entity revision id this data is attached to';


--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN field_revision_field_video_articulo.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video_articulo.language IS 'The language for this data item.';


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN field_revision_field_video_articulo.delta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video_articulo.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN field_revision_field_video_articulo.field_video_articulo_fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video_articulo.field_video_articulo_fid IS 'The file_managed.fid being referenced in this field.';


--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN field_revision_field_video_articulo.field_video_articulo_display; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video_articulo.field_video_articulo_display IS 'Flag to control whether this file should be displayed when viewing content.';


--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN field_revision_field_video_articulo.field_video_articulo_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN field_revision_field_video_articulo.field_video_articulo_description IS 'A description of the file.';


--
-- TOC entry 203 (class 1259 OID 13125379)
-- Dependencies: 2389 2390 2391 2392 2393 2394 2395 2397 2398 2399 2400 6
-- Name: file_managed; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE file_managed (
    fid integer NOT NULL,
    uid bigint DEFAULT 0 NOT NULL,
    filename character varying(255) DEFAULT ''::character varying NOT NULL,
    uri character varying(255) DEFAULT ''::character varying NOT NULL,
    filemime character varying(255) DEFAULT ''::character varying NOT NULL,
    filesize bigint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    "timestamp" bigint DEFAULT 0 NOT NULL,
    CONSTRAINT file_managed_fid_check CHECK ((fid >= 0)),
    CONSTRAINT file_managed_filesize_check CHECK ((filesize >= 0)),
    CONSTRAINT file_managed_timestamp_check CHECK (("timestamp" >= 0)),
    CONSTRAINT file_managed_uid_check CHECK ((uid >= 0))
);


ALTER TABLE public.file_managed OWNER TO postgres;

--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE file_managed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE file_managed IS 'Stores information for uploaded files.';


--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN file_managed.fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_managed.fid IS 'File ID.';


--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN file_managed.uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_managed.uid IS 'The users.uid of the user who is associated with the file.';


--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN file_managed.filename; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_managed.filename IS 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.';


--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN file_managed.uri; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_managed.uri IS 'The URI to access the file (either local or remote).';


--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN file_managed.filemime; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_managed.filemime IS 'The file''s MIME type.';


--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN file_managed.filesize; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_managed.filesize IS 'The size of the file in bytes.';


--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN file_managed.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_managed.status IS 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.';


--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN file_managed."timestamp"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_managed."timestamp" IS 'UNIX timestamp for when the file was added.';


--
-- TOC entry 204 (class 1259 OID 13125396)
-- Dependencies: 203 6
-- Name: file_managed_fid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE file_managed_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_managed_fid_seq OWNER TO postgres;

--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 204
-- Name: file_managed_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE file_managed_fid_seq OWNED BY file_managed.fid;


--
-- TOC entry 205 (class 1259 OID 13125398)
-- Dependencies: 2401 2402 2403 2404 2405 2406 2407 6
-- Name: file_usage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE file_usage (
    fid bigint NOT NULL,
    module character varying(255) DEFAULT ''::character varying NOT NULL,
    type character varying(64) DEFAULT ''::character varying NOT NULL,
    id bigint DEFAULT 0 NOT NULL,
    count bigint DEFAULT 0 NOT NULL,
    CONSTRAINT file_usage_count_check CHECK ((count >= 0)),
    CONSTRAINT file_usage_fid_check CHECK ((fid >= 0)),
    CONSTRAINT file_usage_id_check CHECK ((id >= 0))
);


ALTER TABLE public.file_usage OWNER TO postgres;

--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE file_usage; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE file_usage IS 'Track where a file is used.';


--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN file_usage.fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_usage.fid IS 'File ID.';


--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN file_usage.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_usage.module IS 'The name of the module that is using the file.';


--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN file_usage.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_usage.type IS 'The name of the object type in which the file is used.';


--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN file_usage.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_usage.id IS 'The primary key of the object using the file.';


--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN file_usage.count; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN file_usage.count IS 'The number of times this file is used by this object.';


--
-- TOC entry 206 (class 1259 OID 13125408)
-- Dependencies: 2408 2409 2410 2411 6
-- Name: filter; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE filter (
    format character varying(255) NOT NULL,
    module character varying(64) DEFAULT ''::character varying NOT NULL,
    name character varying(32) DEFAULT ''::character varying NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    settings bytea
);


ALTER TABLE public.filter OWNER TO postgres;

--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE filter; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE filter IS 'Table that maps filters (HTML corrector) to text formats (Filtered HTML).';


--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 206
-- Name: COLUMN filter.format; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN filter.format IS 'Foreign key: The filter_format.format to which this filter is assigned.';


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 206
-- Name: COLUMN filter.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN filter.module IS 'The origin module of the filter.';


--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 206
-- Name: COLUMN filter.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN filter.name IS 'Name of the filter being referenced.';


--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 206
-- Name: COLUMN filter.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN filter.weight IS 'Weight of filter within format.';


--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 206
-- Name: COLUMN filter.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN filter.status IS 'Filter enabled status. (1 = enabled, 0 = disabled)';


--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 206
-- Name: COLUMN filter.settings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN filter.settings IS 'A serialized array of name value pairs that store the filter settings for the specific format.';


--
-- TOC entry 207 (class 1259 OID 13125418)
-- Dependencies: 2412 2413 2414 2415 2416 6
-- Name: filter_format; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE filter_format (
    format character varying(255) NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    cache smallint DEFAULT 0 NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    CONSTRAINT filter_format_status_check CHECK ((status >= 0))
);


ALTER TABLE public.filter_format OWNER TO postgres;

--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE filter_format; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE filter_format IS 'Stores text formats: custom groupings of filters, such as Filtered HTML.';


--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN filter_format.format; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN filter_format.format IS 'Primary Key: Unique machine name of the format.';


--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN filter_format.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN filter_format.name IS 'Name of the text format (Filtered HTML).';


--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN filter_format.cache; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN filter_format.cache IS 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)';


--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN filter_format.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN filter_format.status IS 'The status of the text format. (1 = enabled, 0 = disabled)';


--
-- TOC entry 3507 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN filter_format.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN filter_format.weight IS 'Weight of text format to use when listing.';


--
-- TOC entry 208 (class 1259 OID 13125429)
-- Dependencies: 2417 2418 2419 2420 6
-- Name: flood; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE flood (
    fid integer NOT NULL,
    event character varying(64) DEFAULT ''::character varying NOT NULL,
    identifier character varying(128) DEFAULT ''::character varying NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    expiration integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.flood OWNER TO postgres;

--
-- TOC entry 3508 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE flood; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE flood IS 'Flood controls the threshold of events, such as the number of contact attempts.';


--
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN flood.fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN flood.fid IS 'Unique flood event ID.';


--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN flood.event; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN flood.event IS 'Name of event (e.g. contact).';


--
-- TOC entry 3511 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN flood.identifier; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN flood.identifier IS 'Identifier of the visitor, such as an IP address or hostname.';


--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN flood."timestamp"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN flood."timestamp" IS 'Timestamp of the event.';


--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN flood.expiration; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN flood.expiration IS 'Expiration timestamp. Expired events are purged on cron run.';


--
-- TOC entry 209 (class 1259 OID 13125436)
-- Dependencies: 6 208
-- Name: flood_fid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE flood_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flood_fid_seq OWNER TO postgres;

--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 209
-- Name: flood_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE flood_fid_seq OWNED BY flood.fid;


--
-- TOC entry 210 (class 1259 OID 13125438)
-- Dependencies: 2422 2423 2424 6
-- Name: history; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE history (
    uid integer DEFAULT 0 NOT NULL,
    nid integer DEFAULT 0 NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.history OWNER TO postgres;

--
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE history; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE history IS 'A record of which users have read which nodes.';


--
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN history.uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN history.uid IS 'The users.uid that read the node nid.';


--
-- TOC entry 3517 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN history.nid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN history.nid IS 'The node.nid that was read.';


--
-- TOC entry 3518 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN history."timestamp"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN history."timestamp" IS 'The Unix timestamp at which the read occurred.';


--
-- TOC entry 211 (class 1259 OID 13125444)
-- Dependencies: 2426 2427 2428 2429 6
-- Name: image_effects; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE image_effects (
    ieid integer NOT NULL,
    isid bigint DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    name character varying(255) NOT NULL,
    data bytea NOT NULL,
    CONSTRAINT image_effects_ieid_check CHECK ((ieid >= 0)),
    CONSTRAINT image_effects_isid_check CHECK ((isid >= 0))
);


ALTER TABLE public.image_effects OWNER TO postgres;

--
-- TOC entry 3519 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE image_effects; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE image_effects IS 'Stores configuration options for image effects.';


--
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN image_effects.ieid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN image_effects.ieid IS 'The primary identifier for an image effect.';


--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN image_effects.isid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN image_effects.isid IS 'The image_styles.isid for an image style.';


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN image_effects.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN image_effects.weight IS 'The weight of the effect in the style.';


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN image_effects.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN image_effects.name IS 'The unique name of the effect to be executed.';


--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN image_effects.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN image_effects.data IS 'The configuration data for the effect.';


--
-- TOC entry 212 (class 1259 OID 13125454)
-- Dependencies: 211 6
-- Name: image_effects_ieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE image_effects_ieid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_effects_ieid_seq OWNER TO postgres;

--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 212
-- Name: image_effects_ieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE image_effects_ieid_seq OWNED BY image_effects.ieid;


--
-- TOC entry 213 (class 1259 OID 13125456)
-- Dependencies: 2431 2432 6
-- Name: image_styles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE image_styles (
    isid integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT image_styles_isid_check CHECK ((isid >= 0))
);


ALTER TABLE public.image_styles OWNER TO postgres;

--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE image_styles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE image_styles IS 'Stores configuration options for image styles.';


--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN image_styles.isid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN image_styles.isid IS 'The primary identifier for an image style.';


--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN image_styles.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN image_styles.name IS 'The style machine name.';


--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN image_styles.label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN image_styles.label IS 'The style administrative name.';


--
-- TOC entry 214 (class 1259 OID 13125464)
-- Dependencies: 213 6
-- Name: image_styles_isid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE image_styles_isid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_styles_isid_seq OWNER TO postgres;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 214
-- Name: image_styles_isid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE image_styles_isid_seq OWNED BY image_styles.isid;


--
-- TOC entry 215 (class 1259 OID 13125466)
-- Dependencies: 2433 2434 6
-- Name: menu_custom; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE menu_custom (
    menu_name character varying(32) DEFAULT ''::character varying NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    description text
);


ALTER TABLE public.menu_custom OWNER TO postgres;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE menu_custom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE menu_custom IS 'Holds definitions for top-level custom menus (for example, Main menu).';


--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN menu_custom.menu_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_custom.menu_name IS 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.';


--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN menu_custom.title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_custom.title IS 'Menu title; displayed at top of block.';


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN menu_custom.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_custom.description IS 'Menu description.';


--
-- TOC entry 216 (class 1259 OID 13125474)
-- Dependencies: 2435 2436 2437 2438 2439 2440 2441 2442 2443 2444 2445 2446 2447 2448 2449 2450 2451 2452 2453 2454 2455 2456 2457 2459 2460 2461 2462 2463 2464 2465 2466 2467 2468 2469 6
-- Name: menu_links; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE menu_links (
    menu_name character varying(32) DEFAULT ''::character varying NOT NULL,
    mlid integer NOT NULL,
    plid bigint DEFAULT 0 NOT NULL,
    link_path character varying(255) DEFAULT ''::character varying NOT NULL,
    router_path character varying(255) DEFAULT ''::character varying NOT NULL,
    link_title character varying(255) DEFAULT ''::character varying NOT NULL,
    options bytea,
    module character varying(255) DEFAULT 'system'::character varying NOT NULL,
    hidden smallint DEFAULT 0 NOT NULL,
    external smallint DEFAULT 0 NOT NULL,
    has_children smallint DEFAULT 0 NOT NULL,
    expanded smallint DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    depth smallint DEFAULT 0 NOT NULL,
    customized smallint DEFAULT 0 NOT NULL,
    p1 bigint DEFAULT 0 NOT NULL,
    p2 bigint DEFAULT 0 NOT NULL,
    p3 bigint DEFAULT 0 NOT NULL,
    p4 bigint DEFAULT 0 NOT NULL,
    p5 bigint DEFAULT 0 NOT NULL,
    p6 bigint DEFAULT 0 NOT NULL,
    p7 bigint DEFAULT 0 NOT NULL,
    p8 bigint DEFAULT 0 NOT NULL,
    p9 bigint DEFAULT 0 NOT NULL,
    updated smallint DEFAULT 0 NOT NULL,
    CONSTRAINT menu_links_mlid_check CHECK ((mlid >= 0)),
    CONSTRAINT menu_links_p1_check CHECK ((p1 >= 0)),
    CONSTRAINT menu_links_p2_check CHECK ((p2 >= 0)),
    CONSTRAINT menu_links_p3_check CHECK ((p3 >= 0)),
    CONSTRAINT menu_links_p4_check CHECK ((p4 >= 0)),
    CONSTRAINT menu_links_p5_check CHECK ((p5 >= 0)),
    CONSTRAINT menu_links_p6_check CHECK ((p6 >= 0)),
    CONSTRAINT menu_links_p7_check CHECK ((p7 >= 0)),
    CONSTRAINT menu_links_p8_check CHECK ((p8 >= 0)),
    CONSTRAINT menu_links_p9_check CHECK ((p9 >= 0)),
    CONSTRAINT menu_links_plid_check CHECK ((plid >= 0))
);


ALTER TABLE public.menu_links OWNER TO postgres;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE menu_links; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE menu_links IS 'Contains the individual links within a menu.';


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.menu_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.menu_name IS 'The menu name. All links with the same menu name (such as ''navigation'') are part of the same menu.';


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.mlid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.mlid IS 'The menu link ID (mlid) is the integer primary key.';


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.plid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.plid IS 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.';


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.link_path; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.link_path IS 'The Drupal path or external path this link points to.';


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.router_path; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.router_path IS 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.';


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.link_title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.link_title IS 'The text displayed for the link, which may be modified by a title callback stored in menu_router.';


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.options; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.options IS 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.';


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.module IS 'The name of the module that generated this link.';


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.hidden; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.hidden IS 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)';


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.external; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.external IS 'A flag to indicate if the link points to a full URL starting with a protocol,::text like http:// (1 = external, 0 = internal).';


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.has_children; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.has_children IS 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).';


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.expanded; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.expanded IS 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)';


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.weight IS 'Link weight among links in the same menu at the same depth.';


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.depth; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.depth IS 'The depth relative to the top level. A link with plid == 0 will have depth == 1.';


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.customized; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.customized IS 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).';


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.p1; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.p1 IS 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.';


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.p2; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.p2 IS 'The second mlid in the materialized path. See p1.';


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.p3; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.p3 IS 'The third mlid in the materialized path. See p1.';


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.p4; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.p4 IS 'The fourth mlid in the materialized path. See p1.';


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.p5; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.p5 IS 'The fifth mlid in the materialized path. See p1.';


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.p6; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.p6 IS 'The sixth mlid in the materialized path. See p1.';


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.p7; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.p7 IS 'The seventh mlid in the materialized path. See p1.';


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.p8; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.p8 IS 'The eighth mlid in the materialized path. See p1.';


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.p9; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.p9 IS 'The ninth mlid in the materialized path. See p1.';


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN menu_links.updated; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_links.updated IS 'Flag that indicates that this link was generated during the update from Drupal 5.';


--
-- TOC entry 217 (class 1259 OID 13125517)
-- Dependencies: 6 216
-- Name: menu_links_mlid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE menu_links_mlid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_links_mlid_seq OWNER TO postgres;

--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 217
-- Name: menu_links_mlid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE menu_links_mlid_seq OWNED BY menu_links.mlid;


--
-- TOC entry 218 (class 1259 OID 13125519)
-- Dependencies: 2470 2471 2472 2473 2474 2475 2476 2477 2478 2479 2480 2481 2482 2483 2484 2485 2486 6
-- Name: menu_router; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE menu_router (
    path character varying(255) DEFAULT ''::character varying NOT NULL,
    load_functions bytea NOT NULL,
    to_arg_functions bytea NOT NULL,
    access_callback character varying(255) DEFAULT ''::character varying NOT NULL,
    access_arguments bytea,
    page_callback character varying(255) DEFAULT ''::character varying NOT NULL,
    page_arguments bytea,
    delivery_callback character varying(255) DEFAULT ''::character varying NOT NULL,
    fit integer DEFAULT 0 NOT NULL,
    number_parts smallint DEFAULT 0 NOT NULL,
    context integer DEFAULT 0 NOT NULL,
    tab_parent character varying(255) DEFAULT ''::character varying NOT NULL,
    tab_root character varying(255) DEFAULT ''::character varying NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    title_callback character varying(255) DEFAULT ''::character varying NOT NULL,
    title_arguments character varying(255) DEFAULT ''::character varying NOT NULL,
    theme_callback character varying(255) DEFAULT ''::character varying NOT NULL,
    theme_arguments character varying(255) DEFAULT ''::character varying NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    description text NOT NULL,
    "position" character varying(255) DEFAULT ''::character varying NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    include_file text
);


ALTER TABLE public.menu_router OWNER TO postgres;

--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE menu_router; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE menu_router IS 'Maps paths to various callbacks (access, page and title)';


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.path; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.path IS 'Primary Key: the Drupal path this entry describes';


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.load_functions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.load_functions IS 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.';


--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.to_arg_functions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.to_arg_functions IS 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.';


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.access_callback; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.access_callback IS 'The callback which determines the access to this router path. Defaults to user_access.';


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.access_arguments; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.access_arguments IS 'A serialized array of arguments for the access callback.';


--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.page_callback; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.page_callback IS 'The name of the function that renders the page.';


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.page_arguments; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.page_arguments IS 'A serialized array of arguments for the page callback.';


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.delivery_callback; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.delivery_callback IS 'The name of the function that sends the result of the page_callback function to the browser.';


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.fit; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.fit IS 'A numeric representation of how specific the path is.';


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.number_parts; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.number_parts IS 'Number of parts in this router path.';


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.context; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.context IS 'Only for local tasks (tabs) - the context of a local task to control its placement.';


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.tab_parent; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.tab_parent IS 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).';


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.tab_root; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.tab_root IS 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.';


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.title IS 'The title for the current page, or the title for the tab if this is a local task.';


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.title_callback; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.title_callback IS 'A function which will alter the title. Defaults to t()';


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.title_arguments; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.title_arguments IS 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.';


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.theme_callback; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.theme_callback IS 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.';


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.theme_arguments; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.theme_arguments IS 'A serialized array of arguments for the theme callback.';


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.type IS 'Numeric representation of the type of the menu item,::text like MENU_LOCAL_TASK.';


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.description IS 'A description of this item.';


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router."position"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router."position" IS 'The position of the block (left or right) on the system administration page for this item.';


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.weight IS 'Weight of the element. Lighter weights are higher up, heavier weights go down.';


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN menu_router.include_file; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN menu_router.include_file IS 'The file to include for this element, usually the page callback function lives in this file.';


--
-- TOC entry 219 (class 1259 OID 13125542)
-- Dependencies: 2487 2488 2489 2490 2491 2492 2493 2494 2495 2496 2497 2498 2500 2501 2502 6
-- Name: node; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE node (
    nid integer NOT NULL,
    vid bigint,
    type character varying(32) DEFAULT ''::character varying NOT NULL,
    language character varying(12) DEFAULT ''::character varying NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    uid integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    changed integer DEFAULT 0 NOT NULL,
    comment integer DEFAULT 0 NOT NULL,
    promote integer DEFAULT 0 NOT NULL,
    sticky integer DEFAULT 0 NOT NULL,
    tnid bigint DEFAULT 0 NOT NULL,
    translate integer DEFAULT 0 NOT NULL,
    CONSTRAINT node_nid_check CHECK ((nid >= 0)),
    CONSTRAINT node_tnid_check CHECK ((tnid >= 0)),
    CONSTRAINT node_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.node OWNER TO postgres;

--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE node; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE node IS 'The base table for nodes.';


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.nid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.nid IS 'The primary identifier for a node.';


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.vid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.vid IS 'The current node_revision.vid version identifier.';


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.type IS 'The node_type.type of this node.';


--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.language IS 'The languages.language of this node.';


--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.title IS 'The title of this node, always treated as non-markup plain text.';


--
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.uid IS 'The users.uid that owns this node; initially, this is the user that created it.';


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.status IS 'Boolean indicating whether the node is published (visible to non-administrators).';


--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.created IS 'The Unix timestamp when the node was created.';


--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.changed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.changed IS 'The Unix timestamp when the node was most recently saved.';


--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.comment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.comment IS 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).';


--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.promote; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.promote IS 'Boolean indicating whether the node should be displayed on the front page.';


--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.sticky; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.sticky IS 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.';


--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.tnid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.tnid IS 'The translation set id for this node, which equals the node id of the source post in each set.';


--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN node.translate; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node.translate IS 'A boolean indicating whether this translation page needs to be updated.';


--
-- TOC entry 220 (class 1259 OID 13125560)
-- Dependencies: 2503 2504 2505 2506 2507 2508 2509 2510 2511 2512 2513 6
-- Name: node_access; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE node_access (
    nid bigint DEFAULT 0 NOT NULL,
    gid bigint DEFAULT 0 NOT NULL,
    realm character varying(255) DEFAULT ''::character varying NOT NULL,
    grant_view integer DEFAULT 0 NOT NULL,
    grant_update integer DEFAULT 0 NOT NULL,
    grant_delete integer DEFAULT 0 NOT NULL,
    CONSTRAINT node_access_gid_check CHECK ((gid >= 0)),
    CONSTRAINT node_access_grant_delete_check CHECK ((grant_delete >= 0)),
    CONSTRAINT node_access_grant_update_check CHECK ((grant_update >= 0)),
    CONSTRAINT node_access_grant_view_check CHECK ((grant_view >= 0)),
    CONSTRAINT node_access_nid_check CHECK ((nid >= 0))
);


ALTER TABLE public.node_access OWNER TO postgres;

--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE node_access; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE node_access IS 'Identifies which realm/grant pairs a user must possess in order to view, update, or delete specific nodes.';


--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN node_access.nid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_access.nid IS 'The node.nid this record affects.';


--
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN node_access.gid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_access.gid IS 'The grant ID a user must possess in the specified realm to gain this row''s privileges on the node.';


--
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN node_access.realm; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_access.realm IS 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.';


--
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN node_access.grant_view; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_access.grant_view IS 'Boolean indicating whether a user with the realm/grant pair can view this node.';


--
-- TOC entry 3606 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN node_access.grant_update; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_access.grant_update IS 'Boolean indicating whether a user with the realm/grant pair can edit this node.';


--
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN node_access.grant_delete; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_access.grant_delete IS 'Boolean indicating whether a user with the realm/grant pair can delete this node.';


--
-- TOC entry 221 (class 1259 OID 13125574)
-- Dependencies: 2514 2515 2516 2517 2518 2519 2520 6
-- Name: node_comment_statistics; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE node_comment_statistics (
    nid bigint DEFAULT 0 NOT NULL,
    cid integer DEFAULT 0 NOT NULL,
    last_comment_timestamp integer DEFAULT 0 NOT NULL,
    last_comment_name character varying(60),
    last_comment_uid integer DEFAULT 0 NOT NULL,
    comment_count bigint DEFAULT 0 NOT NULL,
    CONSTRAINT node_comment_statistics_comment_count_check CHECK ((comment_count >= 0)),
    CONSTRAINT node_comment_statistics_nid_check CHECK ((nid >= 0))
);


ALTER TABLE public.node_comment_statistics OWNER TO postgres;

--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE node_comment_statistics; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE node_comment_statistics IS 'Maintains statistics of node and comments posts to show "new" and "updated" flags.';


--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN node_comment_statistics.nid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_comment_statistics.nid IS 'The node.nid for which the statistics are compiled.';


--
-- TOC entry 3610 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN node_comment_statistics.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_comment_statistics.cid IS 'The comment.cid of the last comment.';


--
-- TOC entry 3611 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN node_comment_statistics.last_comment_timestamp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_comment_statistics.last_comment_timestamp IS 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.';


--
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN node_comment_statistics.last_comment_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_comment_statistics.last_comment_name IS 'The name of the latest author to post a comment on this node, from comment.name.';


--
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN node_comment_statistics.last_comment_uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_comment_statistics.last_comment_uid IS 'The user ID of the latest author to post a comment on this node, from comment.uid.';


--
-- TOC entry 3614 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN node_comment_statistics.comment_count; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_comment_statistics.comment_count IS 'The total number of comments on this node.';


--
-- TOC entry 222 (class 1259 OID 13125584)
-- Dependencies: 6 219
-- Name: node_nid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE node_nid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.node_nid_seq OWNER TO postgres;

--
-- TOC entry 3615 (class 0 OID 0)
-- Dependencies: 222
-- Name: node_nid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE node_nid_seq OWNED BY node.nid;


--
-- TOC entry 223 (class 1259 OID 13125586)
-- Dependencies: 2521 2522 2523 2524 2525 2526 2527 2528 2530 2531 6
-- Name: node_revision; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE node_revision (
    nid bigint DEFAULT 0 NOT NULL,
    vid integer NOT NULL,
    uid integer DEFAULT 0 NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    log text NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    comment integer DEFAULT 0 NOT NULL,
    promote integer DEFAULT 0 NOT NULL,
    sticky integer DEFAULT 0 NOT NULL,
    CONSTRAINT node_revision_nid_check CHECK ((nid >= 0)),
    CONSTRAINT node_revision_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.node_revision OWNER TO postgres;

--
-- TOC entry 3616 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE node_revision; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE node_revision IS 'Stores information about each saved version of a node.';


--
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN node_revision.nid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_revision.nid IS 'The node this version belongs to.';


--
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN node_revision.vid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_revision.vid IS 'The primary identifier for this version.';


--
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN node_revision.uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_revision.uid IS 'The users.uid that created this version.';


--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN node_revision.title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_revision.title IS 'The title of this version.';


--
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN node_revision.log; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_revision.log IS 'The log entry explaining the changes in this version.';


--
-- TOC entry 3622 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN node_revision."timestamp"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_revision."timestamp" IS 'A Unix timestamp indicating when this version was created.';


--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN node_revision.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_revision.status IS 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).';


--
-- TOC entry 3624 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN node_revision.comment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_revision.comment IS 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).';


--
-- TOC entry 3625 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN node_revision.promote; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_revision.promote IS 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.';


--
-- TOC entry 3626 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN node_revision.sticky; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_revision.sticky IS 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.';


--
-- TOC entry 224 (class 1259 OID 13125602)
-- Dependencies: 6 223
-- Name: node_revision_vid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE node_revision_vid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.node_revision_vid_seq OWNER TO postgres;

--
-- TOC entry 3627 (class 0 OID 0)
-- Dependencies: 224
-- Name: node_revision_vid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE node_revision_vid_seq OWNED BY node_revision.vid;


--
-- TOC entry 225 (class 1259 OID 13125604)
-- Dependencies: 2532 2533 2534 2535 2536 2537 2538 2539 6
-- Name: node_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE node_type (
    type character varying(32) NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    base character varying(255) NOT NULL,
    module character varying(255) NOT NULL,
    description text NOT NULL,
    help text NOT NULL,
    has_title integer NOT NULL,
    title_label character varying(255) DEFAULT ''::character varying NOT NULL,
    custom smallint DEFAULT 0 NOT NULL,
    modified smallint DEFAULT 0 NOT NULL,
    locked smallint DEFAULT 0 NOT NULL,
    disabled smallint DEFAULT 0 NOT NULL,
    orig_type character varying(255) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT node_type_has_title_check CHECK ((has_title >= 0))
);


ALTER TABLE public.node_type OWNER TO postgres;

--
-- TOC entry 3628 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE node_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE node_type IS 'Stores information about all defined node types.';


--
-- TOC entry 3629 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.type IS 'The machine-readable name of this type.';


--
-- TOC entry 3630 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.name IS 'The human-readable name of this type.';


--
-- TOC entry 3631 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.base; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.base IS 'The base string used to construct callbacks corresponding to this node type.';


--
-- TOC entry 3632 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.module IS 'The module defining this node type.';


--
-- TOC entry 3633 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.description IS 'A brief description of this type.';


--
-- TOC entry 3634 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.help; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.help IS 'Help information shown to the user when creating a node of this type.';


--
-- TOC entry 3635 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.has_title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.has_title IS 'Boolean indicating whether this type uses the node.title field.';


--
-- TOC entry 3636 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.title_label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.title_label IS 'The label displayed for the title field on the edit form.';


--
-- TOC entry 3637 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.custom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.custom IS 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).';


--
-- TOC entry 3638 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.modified; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.modified IS 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.';


--
-- TOC entry 3639 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.locked; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.locked IS 'A boolean indicating whether the administrator can change the machine name of this type.';


--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.disabled; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.disabled IS 'A boolean indicating whether the node type is disabled.';


--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN node_type.orig_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN node_type.orig_type IS 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.';


--
-- TOC entry 226 (class 1259 OID 13125618)
-- Dependencies: 2541 2542 2543 2544 6
-- Name: queue; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE queue (
    item_id integer NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    CONSTRAINT queue_item_id_check CHECK ((item_id >= 0))
);


ALTER TABLE public.queue OWNER TO postgres;

--
-- TOC entry 3642 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE queue; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE queue IS 'Stores items in queues.';


--
-- TOC entry 3643 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN queue.item_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN queue.item_id IS 'Primary Key: Unique item ID.';


--
-- TOC entry 3644 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN queue.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN queue.name IS 'The queue name.';


--
-- TOC entry 3645 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN queue.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN queue.data IS 'The arbitrary data for the item.';


--
-- TOC entry 3646 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN queue.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN queue.expire IS 'Timestamp when the claim lease expires on the item.';


--
-- TOC entry 3647 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN queue.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN queue.created IS 'Timestamp when the item was created.';


--
-- TOC entry 227 (class 1259 OID 13125628)
-- Dependencies: 226 6
-- Name: queue_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE queue_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.queue_item_id_seq OWNER TO postgres;

--
-- TOC entry 3648 (class 0 OID 0)
-- Dependencies: 227
-- Name: queue_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE queue_item_id_seq OWNED BY queue.item_id;


--
-- TOC entry 228 (class 1259 OID 13125630)
-- Dependencies: 6
-- Name: rdf_mapping; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rdf_mapping (
    type character varying(128) NOT NULL,
    bundle character varying(128) NOT NULL,
    mapping bytea
);


ALTER TABLE public.rdf_mapping OWNER TO postgres;

--
-- TOC entry 3649 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE rdf_mapping; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE rdf_mapping IS 'Stores custom RDF mappings for user defined content types or overriden module-defined mappings';


--
-- TOC entry 3650 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN rdf_mapping.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rdf_mapping.type IS 'The name of the entity type a mapping applies to (node, user, comment, etc.).';


--
-- TOC entry 3651 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN rdf_mapping.bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rdf_mapping.bundle IS 'The name of the bundle a mapping applies to.';


--
-- TOC entry 3652 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN rdf_mapping.mapping; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rdf_mapping.mapping IS 'The serialized mapping of the bundle type and fields to RDF terms.';


--
-- TOC entry 229 (class 1259 OID 13125636)
-- Dependencies: 2545 2546 2547 2548 6
-- Name: registry; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE registry (
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    type character varying(9) DEFAULT ''::character varying NOT NULL,
    filename character varying(255) NOT NULL,
    module character varying(255) DEFAULT ''::character varying NOT NULL,
    weight integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.registry OWNER TO postgres;

--
-- TOC entry 3653 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE registry; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE registry IS 'Each record is a function, class, or interface name and the file it is in.';


--
-- TOC entry 3654 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN registry.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN registry.name IS 'The name of the function, class, or interface.';


--
-- TOC entry 3655 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN registry.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN registry.type IS 'Either function or class or interface.';


--
-- TOC entry 3656 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN registry.filename; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN registry.filename IS 'Name of the file.';


--
-- TOC entry 3657 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN registry.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN registry.module IS 'Name of the module the file belongs to.';


--
-- TOC entry 3658 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN registry.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN registry.weight IS 'The order in which this module''s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.';


--
-- TOC entry 230 (class 1259 OID 13125646)
-- Dependencies: 6
-- Name: registry_file; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE registry_file (
    filename character varying(255) NOT NULL,
    hash character varying(64) NOT NULL
);


ALTER TABLE public.registry_file OWNER TO postgres;

--
-- TOC entry 3659 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE registry_file; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE registry_file IS 'Files parsed to build the registry.';


--
-- TOC entry 3660 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN registry_file.filename; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN registry_file.filename IS 'Path to the file.';


--
-- TOC entry 3661 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN registry_file.hash; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN registry_file.hash IS 'sha-256 hash of the file''s contents when last parsed.';


--
-- TOC entry 231 (class 1259 OID 13125649)
-- Dependencies: 2550 2551 2552 6
-- Name: role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE role (
    rid integer NOT NULL,
    name character varying(64) DEFAULT ''::character varying NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    CONSTRAINT role_rid_check CHECK ((rid >= 0))
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 3662 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE role IS 'Stores user roles.';


--
-- TOC entry 3663 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN role.rid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN role.rid IS 'Primary Key: Unique role ID.';


--
-- TOC entry 3664 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN role.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN role.name IS 'Unique role name.';


--
-- TOC entry 3665 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN role.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN role.weight IS 'The weight of this role in listings and the user interface.';


--
-- TOC entry 232 (class 1259 OID 13125655)
-- Dependencies: 2553 2554 2555 6
-- Name: role_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE role_permission (
    rid bigint NOT NULL,
    permission character varying(128) DEFAULT ''::character varying NOT NULL,
    module character varying(255) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT role_permission_rid_check CHECK ((rid >= 0))
);


ALTER TABLE public.role_permission OWNER TO postgres;

--
-- TOC entry 3666 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE role_permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE role_permission IS 'Stores the permissions assigned to user roles.';


--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN role_permission.rid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN role_permission.rid IS 'Foreign Key: role.rid.';


--
-- TOC entry 3668 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN role_permission.permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN role_permission.permission IS 'A single permission granted to the role identified by rid.';


--
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN role_permission.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN role_permission.module IS 'The module declaring the permission.';


--
-- TOC entry 233 (class 1259 OID 13125661)
-- Dependencies: 6 231
-- Name: role_rid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE role_rid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_rid_seq OWNER TO postgres;

--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 233
-- Name: role_rid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE role_rid_seq OWNED BY role.rid;


--
-- TOC entry 234 (class 1259 OID 13125663)
-- Dependencies: 2556 2557 2558 2559 6
-- Name: search_dataset; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE search_dataset (
    sid bigint DEFAULT 0 NOT NULL,
    type character varying(16) NOT NULL,
    data text NOT NULL,
    reindex bigint DEFAULT 0 NOT NULL,
    CONSTRAINT search_dataset_reindex_check CHECK ((reindex >= 0)),
    CONSTRAINT search_dataset_sid_check CHECK ((sid >= 0))
);


ALTER TABLE public.search_dataset OWNER TO postgres;

--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE search_dataset; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE search_dataset IS 'Stores items that will be searched.';


--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN search_dataset.sid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_dataset.sid IS 'Search item ID, e.g. node ID for nodes.';


--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN search_dataset.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_dataset.type IS 'Type of item, e.g. node.';


--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN search_dataset.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_dataset.data IS 'List of space-separated words from the item.';


--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN search_dataset.reindex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_dataset.reindex IS 'Set to force node reindexing.';


--
-- TOC entry 235 (class 1259 OID 13125673)
-- Dependencies: 2560 2561 2562 6
-- Name: search_index; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE search_index (
    word character varying(50) DEFAULT ''::character varying NOT NULL,
    sid bigint DEFAULT 0 NOT NULL,
    type character varying(16) NOT NULL,
    score real,
    CONSTRAINT search_index_sid_check CHECK ((sid >= 0))
);


ALTER TABLE public.search_index OWNER TO postgres;

--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE search_index; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE search_index IS 'Stores the search index, associating words, items and scores.';


--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN search_index.word; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_index.word IS 'The search_total.word that is associated with the search item.';


--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN search_index.sid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_index.sid IS 'The search_dataset.sid of the searchable item to which the word belongs.';


--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN search_index.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_index.type IS 'The search_dataset.type of the searchable item to which the word belongs.';


--
-- TOC entry 3680 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN search_index.score; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_index.score IS 'The numeric score of the word, higher being more important.';


--
-- TOC entry 236 (class 1259 OID 13125679)
-- Dependencies: 2563 2564 2565 2566 2567 6
-- Name: search_node_links; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE search_node_links (
    sid bigint DEFAULT 0 NOT NULL,
    type character varying(16) DEFAULT ''::character varying NOT NULL,
    nid bigint DEFAULT 0 NOT NULL,
    caption text,
    CONSTRAINT search_node_links_nid_check CHECK ((nid >= 0)),
    CONSTRAINT search_node_links_sid_check CHECK ((sid >= 0))
);


ALTER TABLE public.search_node_links OWNER TO postgres;

--
-- TOC entry 3681 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE search_node_links; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE search_node_links IS 'Stores items (like nodes) that link to other nodes, used to improve search scores for nodes that are frequently linked to.';


--
-- TOC entry 3682 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN search_node_links.sid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_node_links.sid IS 'The search_dataset.sid of the searchable item containing the link to the node.';


--
-- TOC entry 3683 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN search_node_links.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_node_links.type IS 'The search_dataset.type of the searchable item containing the link to the node.';


--
-- TOC entry 3684 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN search_node_links.nid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_node_links.nid IS 'The node.nid that this item links to.';


--
-- TOC entry 3685 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN search_node_links.caption; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_node_links.caption IS 'The text used to link to the node.nid.';


--
-- TOC entry 237 (class 1259 OID 13125690)
-- Dependencies: 2568 6
-- Name: search_total; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE search_total (
    word character varying(50) DEFAULT ''::character varying NOT NULL,
    count real
);


ALTER TABLE public.search_total OWNER TO postgres;

--
-- TOC entry 3686 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE search_total; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE search_total IS 'Stores search totals for words.';


--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN search_total.word; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_total.word IS 'Primary Key: Unique word in the search index.';


--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN search_total.count; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN search_total.count IS 'The count of the word in the index using Zipf''s law to equalize the probability distribution.';


--
-- TOC entry 238 (class 1259 OID 13125694)
-- Dependencies: 2569 2570 6
-- Name: semaphore; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE semaphore (
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL,
    expire double precision NOT NULL
);


ALTER TABLE public.semaphore OWNER TO postgres;

--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE semaphore; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE semaphore IS 'Table for holding semaphores, locks, flags, etc. that cannot be stored as Drupal variables since they must not be cached.';


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN semaphore.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN semaphore.name IS 'Primary Key: Unique name.';


--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN semaphore.value; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN semaphore.value IS 'A value for the semaphore.';


--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN semaphore.expire; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN semaphore.expire IS 'A Unix timestamp with microseconds indicating when the semaphore should expire.';


--
-- TOC entry 239 (class 1259 OID 13125702)
-- Dependencies: 2572 6
-- Name: sequences; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sequences (
    value integer NOT NULL,
    CONSTRAINT sequences_value_check CHECK ((value >= 0))
);


ALTER TABLE public.sequences OWNER TO postgres;

--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE sequences; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sequences IS 'Stores IDs.';


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN sequences.value; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sequences.value IS 'The value of the sequence.';


--
-- TOC entry 240 (class 1259 OID 13125706)
-- Dependencies: 6 239
-- Name: sequences_value_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sequences_value_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sequences_value_seq OWNER TO postgres;

--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 240
-- Name: sequences_value_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sequences_value_seq OWNED BY sequences.value;


--
-- TOC entry 241 (class 1259 OID 13125708)
-- Dependencies: 2573 2574 2575 2576 2577 6
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sessions (
    uid bigint NOT NULL,
    sid character varying(128) NOT NULL,
    ssid character varying(128) DEFAULT ''::character varying NOT NULL,
    hostname character varying(128) DEFAULT ''::character varying NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    cache integer DEFAULT 0 NOT NULL,
    session bytea,
    CONSTRAINT sessions_uid_check CHECK ((uid >= 0))
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- TOC entry 3696 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE sessions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sessions IS 'Drupal''s session handlers read and write into the sessions table. Each record represents a user session, either anonymous or authenticated.';


--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN sessions.uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sessions.uid IS 'The users.uid corresponding to a session, or 0 for anonymous user.';


--
-- TOC entry 3698 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN sessions.sid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sessions.sid IS 'A session ID. The value is generated by Drupal''s session handlers.';


--
-- TOC entry 3699 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN sessions.ssid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sessions.ssid IS 'Secure session ID. The value is generated by Drupal''s session handlers.';


--
-- TOC entry 3700 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN sessions.hostname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sessions.hostname IS 'The IP address that last used this session ID (sid).';


--
-- TOC entry 3701 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN sessions."timestamp"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sessions."timestamp" IS 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.';


--
-- TOC entry 3702 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN sessions.cache; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sessions.cache IS 'The time of this user''s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().';


--
-- TOC entry 3703 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN sessions.session; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sessions.session IS 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.';


--
-- TOC entry 242 (class 1259 OID 13125719)
-- Dependencies: 2578 2579 6
-- Name: shortcut_set; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE shortcut_set (
    set_name character varying(32) DEFAULT ''::character varying NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.shortcut_set OWNER TO postgres;

--
-- TOC entry 3704 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE shortcut_set; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE shortcut_set IS 'Stores information about sets of shortcuts links.';


--
-- TOC entry 3705 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN shortcut_set.set_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN shortcut_set.set_name IS 'Primary Key: The menu_links.menu_name under which the set''s links are stored.';


--
-- TOC entry 3706 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN shortcut_set.title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN shortcut_set.title IS 'The title of the set.';


--
-- TOC entry 243 (class 1259 OID 13125724)
-- Dependencies: 2580 2581 2582 6
-- Name: shortcut_set_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE shortcut_set_users (
    uid bigint DEFAULT 0 NOT NULL,
    set_name character varying(32) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT shortcut_set_users_uid_check CHECK ((uid >= 0))
);


ALTER TABLE public.shortcut_set_users OWNER TO postgres;

--
-- TOC entry 3707 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE shortcut_set_users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE shortcut_set_users IS 'Maps users to shortcut sets.';


--
-- TOC entry 3708 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN shortcut_set_users.uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN shortcut_set_users.uid IS 'The users.uid for this set.';


--
-- TOC entry 3709 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN shortcut_set_users.set_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN shortcut_set_users.set_name IS 'The shortcut_set.set_name that will be displayed for this user.';


--
-- TOC entry 244 (class 1259 OID 13125730)
-- Dependencies: 2583 2584 2585 2586 2587 2588 2589 2590 6
-- Name: system; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE system (
    filename character varying(255) DEFAULT ''::character varying NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    type character varying(12) DEFAULT ''::character varying NOT NULL,
    owner character varying(255) DEFAULT ''::character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    bootstrap integer DEFAULT 0 NOT NULL,
    schema_version smallint DEFAULT (-1) NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    info bytea
);


ALTER TABLE public.system OWNER TO postgres;

--
-- TOC entry 3710 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE system; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE system IS 'A list of all modules, themes, and theme engines that are or have been installed in Drupal''s file system.';


--
-- TOC entry 3711 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN system.filename; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN system.filename IS 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.';


--
-- TOC entry 3712 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN system.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN system.name IS 'The name of the item; e.g. node.';


--
-- TOC entry 3713 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN system.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN system.type IS 'The type of the item, either module, theme, or theme_engine.';


--
-- TOC entry 3714 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN system.owner; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN system.owner IS 'A theme''s ''parent'' . Can be either a theme or an engine.';


--
-- TOC entry 3715 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN system.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN system.status IS 'Boolean indicating whether or not this item is enabled.';


--
-- TOC entry 3716 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN system.bootstrap; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN system.bootstrap IS 'Boolean indicating whether this module is loaded during Drupal''s early bootstrapping phase (e.g. even before the page cache is consulted).';


--
-- TOC entry 3717 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN system.schema_version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN system.schema_version IS 'The module''s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module''s hook_update_N() function that has either been run or existed when the module was first installed.';


--
-- TOC entry 3718 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN system.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN system.weight IS 'The order in which this module''s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.';


--
-- TOC entry 3719 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN system.info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN system.info IS 'A serialized array containing information from the module''s .info file; keys can include name, description, package, version, core, dependencies, and php.';


--
-- TOC entry 245 (class 1259 OID 13125744)
-- Dependencies: 2591 2592 2593 2594 2595 2596 6
-- Name: taxonomy_index; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE taxonomy_index (
    nid bigint DEFAULT 0 NOT NULL,
    tid bigint DEFAULT 0 NOT NULL,
    sticky smallint DEFAULT 0,
    created integer DEFAULT 0 NOT NULL,
    CONSTRAINT taxonomy_index_nid_check CHECK ((nid >= 0)),
    CONSTRAINT taxonomy_index_tid_check CHECK ((tid >= 0))
);


ALTER TABLE public.taxonomy_index OWNER TO postgres;

--
-- TOC entry 3720 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE taxonomy_index; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE taxonomy_index IS 'Maintains denormalized information about node/term relationships.';


--
-- TOC entry 3721 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN taxonomy_index.nid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_index.nid IS 'The node.nid this record tracks.';


--
-- TOC entry 3722 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN taxonomy_index.tid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_index.tid IS 'The term ID.';


--
-- TOC entry 3723 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN taxonomy_index.sticky; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_index.sticky IS 'Boolean indicating whether the node is sticky.';


--
-- TOC entry 3724 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN taxonomy_index.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_index.created IS 'The Unix timestamp when the node was created.';


--
-- TOC entry 246 (class 1259 OID 13125753)
-- Dependencies: 2598 2599 2600 2601 2602 6
-- Name: taxonomy_term_data; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE taxonomy_term_data (
    tid integer NOT NULL,
    vid bigint DEFAULT 0 NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    description text,
    format character varying(255),
    weight integer DEFAULT 0 NOT NULL,
    CONSTRAINT taxonomy_term_data_tid_check CHECK ((tid >= 0)),
    CONSTRAINT taxonomy_term_data_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.taxonomy_term_data OWNER TO postgres;

--
-- TOC entry 3725 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE taxonomy_term_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE taxonomy_term_data IS 'Stores term information.';


--
-- TOC entry 3726 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN taxonomy_term_data.tid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_term_data.tid IS 'Primary Key: Unique term ID.';


--
-- TOC entry 3727 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN taxonomy_term_data.vid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_term_data.vid IS 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.';


--
-- TOC entry 3728 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN taxonomy_term_data.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_term_data.name IS 'The term name.';


--
-- TOC entry 3729 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN taxonomy_term_data.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_term_data.description IS 'A description of the term.';


--
-- TOC entry 3730 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN taxonomy_term_data.format; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_term_data.format IS 'The filter_format.format of the description.';


--
-- TOC entry 3731 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN taxonomy_term_data.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_term_data.weight IS 'The weight of this term in relation to other terms.';


--
-- TOC entry 247 (class 1259 OID 13125764)
-- Dependencies: 246 6
-- Name: taxonomy_term_data_tid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE taxonomy_term_data_tid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taxonomy_term_data_tid_seq OWNER TO postgres;

--
-- TOC entry 3732 (class 0 OID 0)
-- Dependencies: 247
-- Name: taxonomy_term_data_tid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE taxonomy_term_data_tid_seq OWNED BY taxonomy_term_data.tid;


--
-- TOC entry 248 (class 1259 OID 13125766)
-- Dependencies: 2603 2604 2605 2606 6
-- Name: taxonomy_term_hierarchy; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE taxonomy_term_hierarchy (
    tid bigint DEFAULT 0 NOT NULL,
    parent bigint DEFAULT 0 NOT NULL,
    CONSTRAINT taxonomy_term_hierarchy_parent_check CHECK ((parent >= 0)),
    CONSTRAINT taxonomy_term_hierarchy_tid_check CHECK ((tid >= 0))
);


ALTER TABLE public.taxonomy_term_hierarchy OWNER TO postgres;

--
-- TOC entry 3733 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE taxonomy_term_hierarchy; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE taxonomy_term_hierarchy IS 'Stores the hierarchical relationship between terms.';


--
-- TOC entry 3734 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN taxonomy_term_hierarchy.tid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_term_hierarchy.tid IS 'Primary Key: The taxonomy_term_data.tid of the term.';


--
-- TOC entry 3735 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN taxonomy_term_hierarchy.parent; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_term_hierarchy.parent IS 'Primary Key: The taxonomy_term_data.tid of the term''s parent. 0 indicates no parent.';


--
-- TOC entry 249 (class 1259 OID 13125773)
-- Dependencies: 2607 2608 2609 2610 2611 2613 2614 6
-- Name: taxonomy_vocabulary; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE taxonomy_vocabulary (
    vid integer NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    machine_name character varying(255) DEFAULT ''::character varying NOT NULL,
    description text,
    hierarchy integer DEFAULT 0 NOT NULL,
    module character varying(255) DEFAULT ''::character varying NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    CONSTRAINT taxonomy_vocabulary_hierarchy_check CHECK ((hierarchy >= 0)),
    CONSTRAINT taxonomy_vocabulary_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.taxonomy_vocabulary OWNER TO postgres;

--
-- TOC entry 3736 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE taxonomy_vocabulary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE taxonomy_vocabulary IS 'Stores vocabulary information.';


--
-- TOC entry 3737 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN taxonomy_vocabulary.vid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_vocabulary.vid IS 'Primary Key: Unique vocabulary ID.';


--
-- TOC entry 3738 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN taxonomy_vocabulary.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_vocabulary.name IS 'Name of the vocabulary.';


--
-- TOC entry 3739 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN taxonomy_vocabulary.machine_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_vocabulary.machine_name IS 'The vocabulary machine name.';


--
-- TOC entry 3740 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN taxonomy_vocabulary.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_vocabulary.description IS 'Description of the vocabulary.';


--
-- TOC entry 3741 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN taxonomy_vocabulary.hierarchy; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_vocabulary.hierarchy IS 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)';


--
-- TOC entry 3742 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN taxonomy_vocabulary.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_vocabulary.module IS 'The module which created the vocabulary.';


--
-- TOC entry 3743 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN taxonomy_vocabulary.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN taxonomy_vocabulary.weight IS 'The weight of this vocabulary in relation to other vocabularies.';


--
-- TOC entry 250 (class 1259 OID 13125786)
-- Dependencies: 6 249
-- Name: taxonomy_vocabulary_vid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE taxonomy_vocabulary_vid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taxonomy_vocabulary_vid_seq OWNER TO postgres;

--
-- TOC entry 3744 (class 0 OID 0)
-- Dependencies: 250
-- Name: taxonomy_vocabulary_vid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE taxonomy_vocabulary_vid_seq OWNED BY taxonomy_vocabulary.vid;


--
-- TOC entry 251 (class 1259 OID 13125788)
-- Dependencies: 2616 2617 2618 2619 6
-- Name: url_alias; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE url_alias (
    pid integer NOT NULL,
    source character varying(255) DEFAULT ''::character varying NOT NULL,
    alias character varying(255) DEFAULT ''::character varying NOT NULL,
    language character varying(12) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT url_alias_pid_check CHECK ((pid >= 0))
);


ALTER TABLE public.url_alias OWNER TO postgres;

--
-- TOC entry 3745 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE url_alias; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE url_alias IS 'A list of URL aliases for Drupal paths; a user may visit either the source or destination path.';


--
-- TOC entry 3746 (class 0 OID 0)
-- Dependencies: 251
-- Name: COLUMN url_alias.pid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN url_alias.pid IS 'A unique path alias identifier.';


--
-- TOC entry 3747 (class 0 OID 0)
-- Dependencies: 251
-- Name: COLUMN url_alias.source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN url_alias.source IS 'The Drupal path this alias is for; e.g. node/12.';


--
-- TOC entry 3748 (class 0 OID 0)
-- Dependencies: 251
-- Name: COLUMN url_alias.alias; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN url_alias.alias IS 'The alias for this path; e.g. title-of-the-story.';


--
-- TOC entry 3749 (class 0 OID 0)
-- Dependencies: 251
-- Name: COLUMN url_alias.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN url_alias.language IS 'The language this alias is for; if ''und'', the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.';


--
-- TOC entry 252 (class 1259 OID 13125798)
-- Dependencies: 6 251
-- Name: url_alias_pid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE url_alias_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.url_alias_pid_seq OWNER TO postgres;

--
-- TOC entry 3750 (class 0 OID 0)
-- Dependencies: 252
-- Name: url_alias_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE url_alias_pid_seq OWNED BY url_alias.pid;


--
-- TOC entry 253 (class 1259 OID 13125800)
-- Dependencies: 2620 2621 2622 2623 2624 2625 2626 2627 2628 2629 2630 2631 2632 2633 6
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    uid bigint DEFAULT 0 NOT NULL,
    name character varying(60) DEFAULT ''::character varying NOT NULL,
    pass character varying(128) DEFAULT ''::character varying NOT NULL,
    mail character varying(254) DEFAULT ''::character varying,
    theme character varying(255) DEFAULT ''::character varying NOT NULL,
    signature character varying(255) DEFAULT ''::character varying NOT NULL,
    signature_format character varying(255),
    created integer DEFAULT 0 NOT NULL,
    access integer DEFAULT 0 NOT NULL,
    login integer DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    timezone character varying(32),
    language character varying(12) DEFAULT ''::character varying NOT NULL,
    picture integer DEFAULT 0 NOT NULL,
    init character varying(254) DEFAULT ''::character varying,
    data bytea,
    CONSTRAINT users_uid_check CHECK ((uid >= 0))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 3751 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE users IS 'Stores user data.';


--
-- TOC entry 3752 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.uid IS 'Primary Key: Unique user ID.';


--
-- TOC entry 3753 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.name IS 'Unique user name.';


--
-- TOC entry 3754 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.pass; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.pass IS 'User''s password (hashed).';


--
-- TOC entry 3755 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.mail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.mail IS 'User''s e-mail address.';


--
-- TOC entry 3756 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.theme; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.theme IS 'User''s default theme.';


--
-- TOC entry 3757 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.signature; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.signature IS 'User''s signature.';


--
-- TOC entry 3758 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.signature_format; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.signature_format IS 'The filter_format.format of the signature.';


--
-- TOC entry 3759 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.created IS 'Timestamp for when user was created.';


--
-- TOC entry 3760 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.access; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.access IS 'Timestamp for previous time user accessed the site.';


--
-- TOC entry 3761 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.login IS 'Timestamp for user''s last login.';


--
-- TOC entry 3762 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.status IS 'Whether the user is active(1) or blocked(0).';


--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.timezone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.timezone IS 'User''s time zone.';


--
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.language IS 'User''s default language.';


--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.picture; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.picture IS 'Foreign key: file_managed.fid of user''s picture.';


--
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.init; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.init IS 'E-mail address used for initial account creation.';


--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN users.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users.data IS 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future version of Drupal.';


--
-- TOC entry 254 (class 1259 OID 13125820)
-- Dependencies: 2634 2635 2636 2637 6
-- Name: users_roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users_roles (
    uid bigint DEFAULT 0 NOT NULL,
    rid bigint DEFAULT 0 NOT NULL,
    CONSTRAINT users_roles_rid_check CHECK ((rid >= 0)),
    CONSTRAINT users_roles_uid_check CHECK ((uid >= 0))
);


ALTER TABLE public.users_roles OWNER TO postgres;

--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE users_roles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE users_roles IS 'Maps users to roles.';


--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN users_roles.uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users_roles.uid IS 'Primary Key: users.uid for user.';


--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN users_roles.rid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN users_roles.rid IS 'Primary Key: role.rid for role.';


--
-- TOC entry 255 (class 1259 OID 13125827)
-- Dependencies: 2638 6
-- Name: variable; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE variable (
    name character varying(128) DEFAULT ''::character varying NOT NULL,
    value bytea NOT NULL
);


ALTER TABLE public.variable OWNER TO postgres;

--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE variable; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE variable IS 'Named variable/value pairs created by Drupal core or any other module or theme. All variables are cached in memory at the start of every Drupal request so developers should not be careless about what is stored here.';


--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 255
-- Name: COLUMN variable.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN variable.name IS 'The name of the variable.';


--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 255
-- Name: COLUMN variable.value; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN variable.value IS 'The value of the variable.';


--
-- TOC entry 256 (class 1259 OID 13125834)
-- Dependencies: 2639 2640 2641 2642 6
-- Name: video_output; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE video_output (
    vid bigint NOT NULL,
    original_fid bigint NOT NULL,
    output_fid bigint DEFAULT 0 NOT NULL,
    job_id integer,
    CONSTRAINT video_output_original_fid_check CHECK ((original_fid >= 0)),
    CONSTRAINT video_output_output_fid_check CHECK ((output_fid >= 0)),
    CONSTRAINT video_output_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.video_output OWNER TO postgres;

--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE video_output; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE video_output IS 'Track file id for converted files.';


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 256
-- Name: COLUMN video_output.vid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_output.vid IS 'Video identifier.';


--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 256
-- Name: COLUMN video_output.original_fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_output.original_fid IS 'Original file identifier.';


--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 256
-- Name: COLUMN video_output.output_fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_output.output_fid IS 'Converted file fid.';


--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 256
-- Name: COLUMN video_output.job_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_output.job_id IS 'Referenced job id if any.';


--
-- TOC entry 257 (class 1259 OID 13125841)
-- Dependencies: 2644 2645 6
-- Name: video_preset; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE video_preset (
    pid integer NOT NULL,
    name character varying(64) DEFAULT ''::character varying NOT NULL,
    description text,
    settings bytea,
    CONSTRAINT video_preset_pid_check CHECK ((pid >= 0))
);


ALTER TABLE public.video_preset OWNER TO postgres;

--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 257
-- Name: TABLE video_preset; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE video_preset IS 'The preset table.';


--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 257
-- Name: COLUMN video_preset.pid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_preset.pid IS 'The primary identifier for a video preset.';


--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 257
-- Name: COLUMN video_preset.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_preset.name IS 'The name of this preset.';


--
-- TOC entry 3782 (class 0 OID 0)
-- Dependencies: 257
-- Name: COLUMN video_preset.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_preset.description IS 'A brief description of this preset.';


--
-- TOC entry 3783 (class 0 OID 0)
-- Dependencies: 257
-- Name: COLUMN video_preset.settings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_preset.settings IS 'Serialized preset settings.';


--
-- TOC entry 258 (class 1259 OID 13125849)
-- Dependencies: 6 257
-- Name: video_preset_pid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE video_preset_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_preset_pid_seq OWNER TO postgres;

--
-- TOC entry 3784 (class 0 OID 0)
-- Dependencies: 258
-- Name: video_preset_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE video_preset_pid_seq OWNED BY video_preset.pid;


--
-- TOC entry 259 (class 1259 OID 13125851)
-- Dependencies: 2646 2647 2648 2649 2650 2651 2652 2653 2655 2656 2657 2658 2659 6
-- Name: video_queue; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE video_queue (
    vid integer NOT NULL,
    fid bigint DEFAULT 0 NOT NULL,
    entity_type character varying(128) DEFAULT 'node'::character varying,
    entity_id bigint DEFAULT 0 NOT NULL,
    status bigint DEFAULT 0 NOT NULL,
    dimensions character varying(255) DEFAULT ''::character varying,
    duration character varying(32),
    started integer DEFAULT 0 NOT NULL,
    completed integer DEFAULT 0 NOT NULL,
    statusupdated bigint DEFAULT 0 NOT NULL,
    data bytea,
    CONSTRAINT video_queue_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT video_queue_fid_check CHECK ((fid >= 0)),
    CONSTRAINT video_queue_status_check CHECK ((status >= 0)),
    CONSTRAINT video_queue_statusupdated_check CHECK ((statusupdated >= 0)),
    CONSTRAINT video_queue_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.video_queue OWNER TO postgres;

--
-- TOC entry 3785 (class 0 OID 0)
-- Dependencies: 259
-- Name: TABLE video_queue; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE video_queue IS 'Store video transcoding queue.';


--
-- TOC entry 3786 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN video_queue.vid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_queue.vid IS 'Video id, the primary identifier';


--
-- TOC entry 3787 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN video_queue.fid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_queue.fid IS 'The file_managed.fid being referenced in this field.';


--
-- TOC entry 3788 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN video_queue.entity_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_queue.entity_type IS 'The entity_type of the video.';


--
-- TOC entry 3789 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN video_queue.entity_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_queue.entity_id IS 'The entity_id being referenced in this field.';


--
-- TOC entry 3790 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN video_queue.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_queue.status IS 'Status of the transcoding, possible values are 1, 5, 10, 20';


--
-- TOC entry 3791 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN video_queue.dimensions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_queue.dimensions IS 'The dimensions of the output video.';


--
-- TOC entry 3792 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN video_queue.duration; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_queue.duration IS 'Stores the video duration in Sec.';


--
-- TOC entry 3793 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN video_queue.started; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_queue.started IS 'Start timestamp of transcodings';


--
-- TOC entry 3794 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN video_queue.completed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_queue.completed IS 'Transcoding completed timestamp';


--
-- TOC entry 3795 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN video_queue.statusupdated; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_queue.statusupdated IS 'Timestamp of last status update, used to track stuck videos';


--
-- TOC entry 3796 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN video_queue.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_queue.data IS 'A serialized array of converted files.';


--
-- TOC entry 260 (class 1259 OID 13125870)
-- Dependencies: 6 259
-- Name: video_queue_vid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE video_queue_vid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_queue_vid_seq OWNER TO postgres;

--
-- TOC entry 3797 (class 0 OID 0)
-- Dependencies: 260
-- Name: video_queue_vid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE video_queue_vid_seq OWNED BY video_queue.vid;


--
-- TOC entry 261 (class 1259 OID 13125872)
-- Dependencies: 2660 2661 6
-- Name: video_thumbnails; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE video_thumbnails (
    videofid bigint NOT NULL,
    thumbnailfid bigint NOT NULL,
    CONSTRAINT video_thumbnails_thumbnailfid_check CHECK ((thumbnailfid >= 0)),
    CONSTRAINT video_thumbnails_videofid_check CHECK ((videofid >= 0))
);


ALTER TABLE public.video_thumbnails OWNER TO postgres;

--
-- TOC entry 3798 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE video_thumbnails; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE video_thumbnails IS 'Table to store thumbnails associated with each video.';


--
-- TOC entry 3799 (class 0 OID 0)
-- Dependencies: 261
-- Name: COLUMN video_thumbnails.videofid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_thumbnails.videofid IS 'fid of original video.';


--
-- TOC entry 3800 (class 0 OID 0)
-- Dependencies: 261
-- Name: COLUMN video_thumbnails.thumbnailfid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN video_thumbnails.thumbnailfid IS 'fid of thumbnail.';


--
-- TOC entry 262 (class 1259 OID 13125877)
-- Dependencies: 2662 2663 2664 2665 2666 2667 2669 6
-- Name: watchdog; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE watchdog (
    wid integer NOT NULL,
    uid integer DEFAULT 0 NOT NULL,
    type character varying(64) DEFAULT ''::character varying NOT NULL,
    message text NOT NULL,
    variables bytea NOT NULL,
    severity integer DEFAULT 0 NOT NULL,
    link character varying(255) DEFAULT ''::character varying,
    location text NOT NULL,
    referer text,
    hostname character varying(128) DEFAULT ''::character varying NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    CONSTRAINT watchdog_severity_check CHECK ((severity >= 0))
);


ALTER TABLE public.watchdog OWNER TO postgres;

--
-- TOC entry 3801 (class 0 OID 0)
-- Dependencies: 262
-- Name: TABLE watchdog; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE watchdog IS 'Table that contains logs of all system events.';


--
-- TOC entry 3802 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN watchdog.wid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN watchdog.wid IS 'Primary Key: Unique watchdog event ID.';


--
-- TOC entry 3803 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN watchdog.uid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN watchdog.uid IS 'The users.uid of the user who triggered the event.';


--
-- TOC entry 3804 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN watchdog.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN watchdog.type IS 'Type of log message, for example "user" or "page not found."';


--
-- TOC entry 3805 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN watchdog.message; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN watchdog.message IS 'Text of log message to be passed into the t() function.';


--
-- TOC entry 3806 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN watchdog.variables; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN watchdog.variables IS 'Serialized array of variables that match the message string and that is passed into the t() function.';


--
-- TOC entry 3807 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN watchdog.severity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN watchdog.severity IS 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)';


--
-- TOC entry 3808 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN watchdog.link; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN watchdog.link IS 'Link to view the result of the event.';


--
-- TOC entry 3809 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN watchdog.location; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN watchdog.location IS 'URL of the origin of the event.';


--
-- TOC entry 3810 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN watchdog.referer; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN watchdog.referer IS 'URL of referring page.';


--
-- TOC entry 3811 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN watchdog.hostname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN watchdog.hostname IS 'Hostname of the user who triggered the event.';


--
-- TOC entry 3812 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN watchdog."timestamp"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN watchdog."timestamp" IS 'Unix timestamp of when event occurred.';


--
-- TOC entry 263 (class 1259 OID 13125890)
-- Dependencies: 6 262
-- Name: watchdog_wid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE watchdog_wid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.watchdog_wid_seq OWNER TO postgres;

--
-- TOC entry 3813 (class 0 OID 0)
-- Dependencies: 263
-- Name: watchdog_wid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE watchdog_wid_seq OWNED BY watchdog.wid;


--
-- TOC entry 2224 (class 2604 OID 13125892)
-- Dependencies: 163 162
-- Name: aid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY authmap ALTER COLUMN aid SET DEFAULT nextval('authmap_aid_seq'::regclass);


--
-- TOC entry 2240 (class 2604 OID 13125893)
-- Dependencies: 166 165
-- Name: bid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY block ALTER COLUMN bid SET DEFAULT nextval('block_bid_seq'::regclass);


--
-- TOC entry 2241 (class 2604 OID 13125894)
-- Dependencies: 168 167
-- Name: bid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY block_custom ALTER COLUMN bid SET DEFAULT nextval('block_custom_bid_seq'::regclass);


--
-- TOC entry 2245 (class 2604 OID 13125895)
-- Dependencies: 172 171
-- Name: iid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blocked_ips ALTER COLUMN iid SET DEFAULT nextval('blocked_ips_iid_seq'::regclass);


--
-- TOC entry 2305 (class 2604 OID 13125896)
-- Dependencies: 186 185
-- Name: cid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment ALTER COLUMN cid SET DEFAULT nextval('comment_cid_seq'::regclass);


--
-- TOC entry 2308 (class 2604 OID 13125897)
-- Dependencies: 190 189
-- Name: dfid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY date_formats ALTER COLUMN dfid SET DEFAULT nextval('date_formats_dfid_seq'::regclass);


--
-- TOC entry 2319 (class 2604 OID 13125898)
-- Dependencies: 192 191
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY field_config ALTER COLUMN id SET DEFAULT nextval('field_config_id_seq'::regclass);


--
-- TOC entry 2324 (class 2604 OID 13125899)
-- Dependencies: 194 193
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY field_config_instance ALTER COLUMN id SET DEFAULT nextval('field_config_instance_id_seq'::regclass);


--
-- TOC entry 2396 (class 2604 OID 13125900)
-- Dependencies: 204 203
-- Name: fid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY file_managed ALTER COLUMN fid SET DEFAULT nextval('file_managed_fid_seq'::regclass);


--
-- TOC entry 2421 (class 2604 OID 13125901)
-- Dependencies: 209 208
-- Name: fid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY flood ALTER COLUMN fid SET DEFAULT nextval('flood_fid_seq'::regclass);


--
-- TOC entry 2425 (class 2604 OID 13125902)
-- Dependencies: 212 211
-- Name: ieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY image_effects ALTER COLUMN ieid SET DEFAULT nextval('image_effects_ieid_seq'::regclass);


--
-- TOC entry 2430 (class 2604 OID 13125903)
-- Dependencies: 214 213
-- Name: isid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY image_styles ALTER COLUMN isid SET DEFAULT nextval('image_styles_isid_seq'::regclass);


--
-- TOC entry 2458 (class 2604 OID 13125904)
-- Dependencies: 217 216
-- Name: mlid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menu_links ALTER COLUMN mlid SET DEFAULT nextval('menu_links_mlid_seq'::regclass);


--
-- TOC entry 2499 (class 2604 OID 13125905)
-- Dependencies: 222 219
-- Name: nid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY node ALTER COLUMN nid SET DEFAULT nextval('node_nid_seq'::regclass);


--
-- TOC entry 2529 (class 2604 OID 13125906)
-- Dependencies: 224 223
-- Name: vid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY node_revision ALTER COLUMN vid SET DEFAULT nextval('node_revision_vid_seq'::regclass);


--
-- TOC entry 2540 (class 2604 OID 13125907)
-- Dependencies: 227 226
-- Name: item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY queue ALTER COLUMN item_id SET DEFAULT nextval('queue_item_id_seq'::regclass);


--
-- TOC entry 2549 (class 2604 OID 13125908)
-- Dependencies: 233 231
-- Name: rid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role ALTER COLUMN rid SET DEFAULT nextval('role_rid_seq'::regclass);


--
-- TOC entry 2571 (class 2604 OID 13125909)
-- Dependencies: 240 239
-- Name: value; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sequences ALTER COLUMN value SET DEFAULT nextval('sequences_value_seq'::regclass);


--
-- TOC entry 2597 (class 2604 OID 13125910)
-- Dependencies: 247 246
-- Name: tid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY taxonomy_term_data ALTER COLUMN tid SET DEFAULT nextval('taxonomy_term_data_tid_seq'::regclass);


--
-- TOC entry 2612 (class 2604 OID 13125911)
-- Dependencies: 250 249
-- Name: vid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY taxonomy_vocabulary ALTER COLUMN vid SET DEFAULT nextval('taxonomy_vocabulary_vid_seq'::regclass);


--
-- TOC entry 2615 (class 2604 OID 13125912)
-- Dependencies: 252 251
-- Name: pid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY url_alias ALTER COLUMN pid SET DEFAULT nextval('url_alias_pid_seq'::regclass);


--
-- TOC entry 2643 (class 2604 OID 13125913)
-- Dependencies: 258 257
-- Name: pid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY video_preset ALTER COLUMN pid SET DEFAULT nextval('video_preset_pid_seq'::regclass);


--
-- TOC entry 2654 (class 2604 OID 13125914)
-- Dependencies: 260 259
-- Name: vid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY video_queue ALTER COLUMN vid SET DEFAULT nextval('video_queue_vid_seq'::regclass);


--
-- TOC entry 2668 (class 2604 OID 13125915)
-- Dependencies: 263 262
-- Name: wid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY watchdog ALTER COLUMN wid SET DEFAULT nextval('watchdog_wid_seq'::regclass);


--
-- TOC entry 2711 (class 2606 OID 13125968)
-- Dependencies: 161 161 3189
-- Name: actions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (aid);


--
-- TOC entry 2713 (class 2606 OID 13125970)
-- Dependencies: 162 162 3189
-- Name: authmap_authname_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY authmap
    ADD CONSTRAINT authmap_authname_key UNIQUE (authname);


--
-- TOC entry 2715 (class 2606 OID 13125972)
-- Dependencies: 162 162 3189
-- Name: authmap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY authmap
    ADD CONSTRAINT authmap_pkey PRIMARY KEY (aid);


--
-- TOC entry 2717 (class 2606 OID 13125974)
-- Dependencies: 164 164 3189
-- Name: batch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY batch
    ADD CONSTRAINT batch_pkey PRIMARY KEY (bid);


--
-- TOC entry 2725 (class 2606 OID 13125976)
-- Dependencies: 167 167 3189
-- Name: block_custom_info_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY block_custom
    ADD CONSTRAINT block_custom_info_key UNIQUE (info);


--
-- TOC entry 2727 (class 2606 OID 13125978)
-- Dependencies: 167 167 3189
-- Name: block_custom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY block_custom
    ADD CONSTRAINT block_custom_pkey PRIMARY KEY (bid);


--
-- TOC entry 2729 (class 2606 OID 13125980)
-- Dependencies: 169 169 169 169 3189
-- Name: block_node_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY block_node_type
    ADD CONSTRAINT block_node_type_pkey PRIMARY KEY (module, delta, type);


--
-- TOC entry 2721 (class 2606 OID 13125982)
-- Dependencies: 165 165 3189
-- Name: block_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY block
    ADD CONSTRAINT block_pkey PRIMARY KEY (bid);


--
-- TOC entry 2732 (class 2606 OID 13125984)
-- Dependencies: 170 170 170 170 3189
-- Name: block_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY block_role
    ADD CONSTRAINT block_role_pkey PRIMARY KEY (module, delta, rid);


--
-- TOC entry 2723 (class 2606 OID 13125986)
-- Dependencies: 165 165 165 165 3189
-- Name: block_tmd_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY block
    ADD CONSTRAINT block_tmd_key UNIQUE (theme, module, delta);


--
-- TOC entry 2736 (class 2606 OID 13125988)
-- Dependencies: 171 171 3189
-- Name: blocked_ips_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY blocked_ips
    ADD CONSTRAINT blocked_ips_pkey PRIMARY KEY (iid);


--
-- TOC entry 2742 (class 2606 OID 13125990)
-- Dependencies: 174 174 3189
-- Name: cache_block_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache_block
    ADD CONSTRAINT cache_block_pkey PRIMARY KEY (cid);


--
-- TOC entry 2745 (class 2606 OID 13125992)
-- Dependencies: 175 175 3189
-- Name: cache_bootstrap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache_bootstrap
    ADD CONSTRAINT cache_bootstrap_pkey PRIMARY KEY (cid);


--
-- TOC entry 2748 (class 2606 OID 13125994)
-- Dependencies: 176 176 3189
-- Name: cache_field_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache_field
    ADD CONSTRAINT cache_field_pkey PRIMARY KEY (cid);


--
-- TOC entry 2751 (class 2606 OID 13125996)
-- Dependencies: 177 177 3189
-- Name: cache_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache_filter
    ADD CONSTRAINT cache_filter_pkey PRIMARY KEY (cid);


--
-- TOC entry 2754 (class 2606 OID 13125998)
-- Dependencies: 178 178 3189
-- Name: cache_form_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache_form
    ADD CONSTRAINT cache_form_pkey PRIMARY KEY (cid);


--
-- TOC entry 2757 (class 2606 OID 13126000)
-- Dependencies: 179 179 3189
-- Name: cache_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache_image
    ADD CONSTRAINT cache_image_pkey PRIMARY KEY (cid);


--
-- TOC entry 2760 (class 2606 OID 13126002)
-- Dependencies: 180 180 3189
-- Name: cache_libraries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache_libraries
    ADD CONSTRAINT cache_libraries_pkey PRIMARY KEY (cid);


--
-- TOC entry 2763 (class 2606 OID 13126004)
-- Dependencies: 181 181 3189
-- Name: cache_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache_menu
    ADD CONSTRAINT cache_menu_pkey PRIMARY KEY (cid);


--
-- TOC entry 2766 (class 2606 OID 13126006)
-- Dependencies: 182 182 3189
-- Name: cache_page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache_page
    ADD CONSTRAINT cache_page_pkey PRIMARY KEY (cid);


--
-- TOC entry 2769 (class 2606 OID 13126008)
-- Dependencies: 183 183 3189
-- Name: cache_path_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache_path
    ADD CONSTRAINT cache_path_pkey PRIMARY KEY (cid);


--
-- TOC entry 2739 (class 2606 OID 13126010)
-- Dependencies: 173 173 3189
-- Name: cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (cid);


--
-- TOC entry 2772 (class 2606 OID 13126012)
-- Dependencies: 184 184 3189
-- Name: cache_update_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cache_update
    ADD CONSTRAINT cache_update_pkey PRIMARY KEY (cid);


--
-- TOC entry 2779 (class 2606 OID 13126014)
-- Dependencies: 185 185 3189
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (cid);


--
-- TOC entry 2781 (class 2606 OID 13126016)
-- Dependencies: 187 187 187 3189
-- Name: date_format_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY date_format_locale
    ADD CONSTRAINT date_format_locale_pkey PRIMARY KEY (type, language);


--
-- TOC entry 2783 (class 2606 OID 13126018)
-- Dependencies: 188 188 3189
-- Name: date_format_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY date_format_type
    ADD CONSTRAINT date_format_type_pkey PRIMARY KEY (type);


--
-- TOC entry 2786 (class 2606 OID 13126020)
-- Dependencies: 189 189 189 3189
-- Name: date_formats_formats_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY date_formats
    ADD CONSTRAINT date_formats_formats_key UNIQUE (format, type);


--
-- TOC entry 2788 (class 2606 OID 13126022)
-- Dependencies: 189 189 3189
-- Name: date_formats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY date_formats
    ADD CONSTRAINT date_formats_pkey PRIMARY KEY (dfid);


--
-- TOC entry 2802 (class 2606 OID 13126024)
-- Dependencies: 193 193 3189
-- Name: field_config_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_config_instance
    ADD CONSTRAINT field_config_instance_pkey PRIMARY KEY (id);


--
-- TOC entry 2794 (class 2606 OID 13126026)
-- Dependencies: 191 191 3189
-- Name: field_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_config
    ADD CONSTRAINT field_config_pkey PRIMARY KEY (id);


--
-- TOC entry 2810 (class 2606 OID 13126028)
-- Dependencies: 195 195 195 195 195 195 3189
-- Name: field_data_body_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_data_body
    ADD CONSTRAINT field_data_body_pkey PRIMARY KEY (entity_type, entity_id, deleted, delta, language);


--
-- TOC entry 2819 (class 2606 OID 13126030)
-- Dependencies: 196 196 196 196 196 196 3189
-- Name: field_data_comment_body_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_data_comment_body
    ADD CONSTRAINT field_data_comment_body_pkey PRIMARY KEY (entity_type, entity_id, deleted, delta, language);


--
-- TOC entry 2828 (class 2606 OID 13126032)
-- Dependencies: 197 197 197 197 197 197 3189
-- Name: field_data_field_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_data_field_image
    ADD CONSTRAINT field_data_field_image_pkey PRIMARY KEY (entity_type, entity_id, deleted, delta, language);


--
-- TOC entry 2837 (class 2606 OID 13126034)
-- Dependencies: 198 198 198 198 198 198 3189
-- Name: field_data_field_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_data_field_tags
    ADD CONSTRAINT field_data_field_tags_pkey PRIMARY KEY (entity_type, entity_id, deleted, delta, language);


--
-- TOC entry 3076 (class 2606 OID 13178415)
-- Dependencies: 266 266 266 266 266 266 3189
-- Name: field_data_field_video_articulo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_data_field_video_articulo
    ADD CONSTRAINT field_data_field_video_articulo_pkey PRIMARY KEY (entity_type, entity_id, deleted, delta, language);


--
-- TOC entry 3058 (class 2606 OID 13178340)
-- Dependencies: 264 264 264 264 264 264 3189
-- Name: field_data_field_video_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_data_field_video
    ADD CONSTRAINT field_data_field_video_pkey PRIMARY KEY (entity_type, entity_id, deleted, delta, language);


--
-- TOC entry 2846 (class 2606 OID 13126040)
-- Dependencies: 199 199 199 199 199 199 199 3189
-- Name: field_revision_body_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_revision_body
    ADD CONSTRAINT field_revision_body_pkey PRIMARY KEY (entity_type, entity_id, revision_id, deleted, delta, language);


--
-- TOC entry 2855 (class 2606 OID 13126042)
-- Dependencies: 200 200 200 200 200 200 200 3189
-- Name: field_revision_comment_body_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_revision_comment_body
    ADD CONSTRAINT field_revision_comment_body_pkey PRIMARY KEY (entity_type, entity_id, revision_id, deleted, delta, language);


--
-- TOC entry 2864 (class 2606 OID 13126044)
-- Dependencies: 201 201 201 201 201 201 201 3189
-- Name: field_revision_field_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_revision_field_image
    ADD CONSTRAINT field_revision_field_image_pkey PRIMARY KEY (entity_type, entity_id, revision_id, deleted, delta, language);


--
-- TOC entry 2873 (class 2606 OID 13126046)
-- Dependencies: 202 202 202 202 202 202 202 3189
-- Name: field_revision_field_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_revision_field_tags
    ADD CONSTRAINT field_revision_field_tags_pkey PRIMARY KEY (entity_type, entity_id, revision_id, deleted, delta, language);


--
-- TOC entry 3085 (class 2606 OID 13178440)
-- Dependencies: 267 267 267 267 267 267 267 3189
-- Name: field_revision_field_video_articulo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_revision_field_video_articulo
    ADD CONSTRAINT field_revision_field_video_articulo_pkey PRIMARY KEY (entity_type, entity_id, revision_id, deleted, delta, language);


--
-- TOC entry 3067 (class 2606 OID 13178365)
-- Dependencies: 265 265 265 265 265 265 265 3189
-- Name: field_revision_field_video_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY field_revision_field_video
    ADD CONSTRAINT field_revision_field_video_pkey PRIMARY KEY (entity_type, entity_id, revision_id, deleted, delta, language);


--
-- TOC entry 2876 (class 2606 OID 13126052)
-- Dependencies: 203 203 3189
-- Name: file_managed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY file_managed
    ADD CONSTRAINT file_managed_pkey PRIMARY KEY (fid);


--
-- TOC entry 2881 (class 2606 OID 13126054)
-- Dependencies: 203 203 3189
-- Name: file_managed_uri_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY file_managed
    ADD CONSTRAINT file_managed_uri_key UNIQUE (uri);


--
-- TOC entry 2885 (class 2606 OID 13126056)
-- Dependencies: 205 205 205 205 205 3189
-- Name: file_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY file_usage
    ADD CONSTRAINT file_usage_pkey PRIMARY KEY (fid, type, id, module);


--
-- TOC entry 2891 (class 2606 OID 13126058)
-- Dependencies: 207 207 3189
-- Name: filter_format_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY filter_format
    ADD CONSTRAINT filter_format_name_key UNIQUE (name);


--
-- TOC entry 2893 (class 2606 OID 13126060)
-- Dependencies: 207 207 3189
-- Name: filter_format_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY filter_format
    ADD CONSTRAINT filter_format_pkey PRIMARY KEY (format);


--
-- TOC entry 2889 (class 2606 OID 13126062)
-- Dependencies: 206 206 206 3189
-- Name: filter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY filter
    ADD CONSTRAINT filter_pkey PRIMARY KEY (format, name);


--
-- TOC entry 2897 (class 2606 OID 13126064)
-- Dependencies: 208 208 3189
-- Name: flood_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY flood
    ADD CONSTRAINT flood_pkey PRIMARY KEY (fid);


--
-- TOC entry 2901 (class 2606 OID 13126066)
-- Dependencies: 210 210 210 3189
-- Name: history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY history
    ADD CONSTRAINT history_pkey PRIMARY KEY (uid, nid);


--
-- TOC entry 2904 (class 2606 OID 13126068)
-- Dependencies: 211 211 3189
-- Name: image_effects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY image_effects
    ADD CONSTRAINT image_effects_pkey PRIMARY KEY (ieid);


--
-- TOC entry 2907 (class 2606 OID 13126070)
-- Dependencies: 213 213 3189
-- Name: image_styles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY image_styles
    ADD CONSTRAINT image_styles_name_key UNIQUE (name);


--
-- TOC entry 2909 (class 2606 OID 13126072)
-- Dependencies: 213 213 3189
-- Name: image_styles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY image_styles
    ADD CONSTRAINT image_styles_pkey PRIMARY KEY (isid);


--
-- TOC entry 2911 (class 2606 OID 13126074)
-- Dependencies: 215 215 3189
-- Name: menu_custom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menu_custom
    ADD CONSTRAINT menu_custom_pkey PRIMARY KEY (menu_name);


--
-- TOC entry 2916 (class 2606 OID 13126076)
-- Dependencies: 216 216 3189
-- Name: menu_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menu_links
    ADD CONSTRAINT menu_links_pkey PRIMARY KEY (mlid);


--
-- TOC entry 2920 (class 2606 OID 13126078)
-- Dependencies: 218 218 3189
-- Name: menu_router_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menu_router
    ADD CONSTRAINT menu_router_pkey PRIMARY KEY (path);


--
-- TOC entry 2938 (class 2606 OID 13126080)
-- Dependencies: 220 220 220 220 3189
-- Name: node_access_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY node_access
    ADD CONSTRAINT node_access_pkey PRIMARY KEY (nid, gid, realm);


--
-- TOC entry 2943 (class 2606 OID 13126082)
-- Dependencies: 221 221 3189
-- Name: node_comment_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY node_comment_statistics
    ADD CONSTRAINT node_comment_statistics_pkey PRIMARY KEY (nid);


--
-- TOC entry 2931 (class 2606 OID 13126084)
-- Dependencies: 219 219 3189
-- Name: node_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY node
    ADD CONSTRAINT node_pkey PRIMARY KEY (nid);


--
-- TOC entry 2946 (class 2606 OID 13126086)
-- Dependencies: 223 223 3189
-- Name: node_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY node_revision
    ADD CONSTRAINT node_revision_pkey PRIMARY KEY (vid);


--
-- TOC entry 2949 (class 2606 OID 13126088)
-- Dependencies: 225 225 3189
-- Name: node_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY node_type
    ADD CONSTRAINT node_type_pkey PRIMARY KEY (type);


--
-- TOC entry 2936 (class 2606 OID 13126090)
-- Dependencies: 219 219 3189
-- Name: node_vid_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY node
    ADD CONSTRAINT node_vid_key UNIQUE (vid);


--
-- TOC entry 2953 (class 2606 OID 13126092)
-- Dependencies: 226 226 3189
-- Name: queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY queue
    ADD CONSTRAINT queue_pkey PRIMARY KEY (item_id);


--
-- TOC entry 2955 (class 2606 OID 13126094)
-- Dependencies: 228 228 228 3189
-- Name: rdf_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rdf_mapping
    ADD CONSTRAINT rdf_mapping_pkey PRIMARY KEY (type, bundle);


--
-- TOC entry 2960 (class 2606 OID 13126096)
-- Dependencies: 230 230 3189
-- Name: registry_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY registry_file
    ADD CONSTRAINT registry_file_pkey PRIMARY KEY (filename);


--
-- TOC entry 2958 (class 2606 OID 13126098)
-- Dependencies: 229 229 229 3189
-- Name: registry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY registry
    ADD CONSTRAINT registry_pkey PRIMARY KEY (name, type);


--
-- TOC entry 2962 (class 2606 OID 13126100)
-- Dependencies: 231 231 3189
-- Name: role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- TOC entry 2968 (class 2606 OID 13126102)
-- Dependencies: 232 232 232 3189
-- Name: role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (rid, permission);


--
-- TOC entry 2965 (class 2606 OID 13126104)
-- Dependencies: 231 231 3189
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (rid);


--
-- TOC entry 2970 (class 2606 OID 13126106)
-- Dependencies: 234 234 234 3189
-- Name: search_dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY search_dataset
    ADD CONSTRAINT search_dataset_pkey PRIMARY KEY (sid, type);


--
-- TOC entry 2972 (class 2606 OID 13126108)
-- Dependencies: 235 235 235 235 3189
-- Name: search_index_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY search_index
    ADD CONSTRAINT search_index_pkey PRIMARY KEY (word, sid, type);


--
-- TOC entry 2976 (class 2606 OID 13126110)
-- Dependencies: 236 236 236 236 3189
-- Name: search_node_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY search_node_links
    ADD CONSTRAINT search_node_links_pkey PRIMARY KEY (sid, type, nid);


--
-- TOC entry 2978 (class 2606 OID 13126112)
-- Dependencies: 237 237 3189
-- Name: search_total_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY search_total
    ADD CONSTRAINT search_total_pkey PRIMARY KEY (word);


--
-- TOC entry 2981 (class 2606 OID 13126114)
-- Dependencies: 238 238 3189
-- Name: semaphore_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY semaphore
    ADD CONSTRAINT semaphore_pkey PRIMARY KEY (name);


--
-- TOC entry 2984 (class 2606 OID 13126116)
-- Dependencies: 239 239 3189
-- Name: sequences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sequences
    ADD CONSTRAINT sequences_pkey PRIMARY KEY (value);


--
-- TOC entry 2986 (class 2606 OID 13126118)
-- Dependencies: 241 241 241 3189
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid, ssid);


--
-- TOC entry 2991 (class 2606 OID 13126120)
-- Dependencies: 242 242 3189
-- Name: shortcut_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY shortcut_set
    ADD CONSTRAINT shortcut_set_pkey PRIMARY KEY (set_name);


--
-- TOC entry 2993 (class 2606 OID 13126122)
-- Dependencies: 243 243 3189
-- Name: shortcut_set_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY shortcut_set_users
    ADD CONSTRAINT shortcut_set_users_pkey PRIMARY KEY (uid);


--
-- TOC entry 2996 (class 2606 OID 13126124)
-- Dependencies: 244 244 3189
-- Name: system_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY system
    ADD CONSTRAINT system_pkey PRIMARY KEY (filename);


--
-- TOC entry 3003 (class 2606 OID 13126126)
-- Dependencies: 246 246 3189
-- Name: taxonomy_term_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxonomy_term_data
    ADD CONSTRAINT taxonomy_term_data_pkey PRIMARY KEY (tid);


--
-- TOC entry 3008 (class 2606 OID 13126128)
-- Dependencies: 248 248 248 3189
-- Name: taxonomy_term_hierarchy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxonomy_term_hierarchy
    ADD CONSTRAINT taxonomy_term_hierarchy_pkey PRIMARY KEY (tid, parent);


--
-- TOC entry 3011 (class 2606 OID 13126130)
-- Dependencies: 249 249 3189
-- Name: taxonomy_vocabulary_machine_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxonomy_vocabulary
    ADD CONSTRAINT taxonomy_vocabulary_machine_name_key UNIQUE (machine_name);


--
-- TOC entry 3013 (class 2606 OID 13126132)
-- Dependencies: 249 249 3189
-- Name: taxonomy_vocabulary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taxonomy_vocabulary
    ADD CONSTRAINT taxonomy_vocabulary_pkey PRIMARY KEY (vid);


--
-- TOC entry 3016 (class 2606 OID 13126134)
-- Dependencies: 251 251 3189
-- Name: url_alias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY url_alias
    ADD CONSTRAINT url_alias_pkey PRIMARY KEY (pid);


--
-- TOC entry 3022 (class 2606 OID 13126136)
-- Dependencies: 253 253 3189
-- Name: users_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- TOC entry 3025 (class 2606 OID 13126138)
-- Dependencies: 253 253 3189
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uid);


--
-- TOC entry 3027 (class 2606 OID 13126141)
-- Dependencies: 254 254 254 3189
-- Name: users_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (uid, rid);


--
-- TOC entry 3030 (class 2606 OID 13126146)
-- Dependencies: 255 255 3189
-- Name: variable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY variable
    ADD CONSTRAINT variable_pkey PRIMARY KEY (name);


--
-- TOC entry 3033 (class 2606 OID 13126150)
-- Dependencies: 256 256 256 256 3189
-- Name: video_output_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY video_output
    ADD CONSTRAINT video_output_pkey PRIMARY KEY (vid, original_fid, output_fid);


--
-- TOC entry 3035 (class 2606 OID 13126153)
-- Dependencies: 257 257 3189
-- Name: video_preset_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY video_preset
    ADD CONSTRAINT video_preset_name_key UNIQUE (name);


--
-- TOC entry 3037 (class 2606 OID 13126155)
-- Dependencies: 257 257 3189
-- Name: video_preset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY video_preset
    ADD CONSTRAINT video_preset_pkey PRIMARY KEY (pid);


--
-- TOC entry 3040 (class 2606 OID 13126157)
-- Dependencies: 259 259 3189
-- Name: video_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY video_queue
    ADD CONSTRAINT video_queue_pkey PRIMARY KEY (vid);


--
-- TOC entry 3043 (class 2606 OID 13126159)
-- Dependencies: 261 261 261 3189
-- Name: video_thumbnails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY video_thumbnails
    ADD CONSTRAINT video_thumbnails_pkey PRIMARY KEY (videofid, thumbnailfid);


--
-- TOC entry 3045 (class 2606 OID 13126161)
-- Dependencies: 261 261 3189
-- Name: video_thumbnails_thumbnail_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY video_thumbnails
    ADD CONSTRAINT video_thumbnails_thumbnail_key UNIQUE (thumbnailfid);


--
-- TOC entry 3047 (class 2606 OID 13126163)
-- Dependencies: 262 262 3189
-- Name: watchdog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY watchdog
    ADD CONSTRAINT watchdog_pkey PRIMARY KEY (wid);


--
-- TOC entry 2718 (class 1259 OID 13126164)
-- Dependencies: 164 3189
-- Name: batch_token_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX batch_token_idx ON batch USING btree (token);


--
-- TOC entry 2719 (class 1259 OID 13126165)
-- Dependencies: 165 165 165 165 165 3189
-- Name: block_list_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX block_list_idx ON block USING btree (theme, status, region, weight, module);


--
-- TOC entry 2730 (class 1259 OID 13126166)
-- Dependencies: 169 3189
-- Name: block_node_type_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX block_node_type_type_idx ON block_node_type USING btree (type);


--
-- TOC entry 2733 (class 1259 OID 13126167)
-- Dependencies: 170 3189
-- Name: block_role_rid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX block_role_rid_idx ON block_role USING btree (rid);


--
-- TOC entry 2734 (class 1259 OID 13126168)
-- Dependencies: 171 3189
-- Name: blocked_ips_blocked_ip_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX blocked_ips_blocked_ip_idx ON blocked_ips USING btree (ip);


--
-- TOC entry 2740 (class 1259 OID 13126169)
-- Dependencies: 174 3189
-- Name: cache_block_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_block_expire_idx ON cache_block USING btree (expire);


--
-- TOC entry 2743 (class 1259 OID 13126170)
-- Dependencies: 175 3189
-- Name: cache_bootstrap_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_bootstrap_expire_idx ON cache_bootstrap USING btree (expire);


--
-- TOC entry 2737 (class 1259 OID 13126171)
-- Dependencies: 173 3189
-- Name: cache_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_expire_idx ON cache USING btree (expire);


--
-- TOC entry 2746 (class 1259 OID 13126172)
-- Dependencies: 176 3189
-- Name: cache_field_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_field_expire_idx ON cache_field USING btree (expire);


--
-- TOC entry 2749 (class 1259 OID 13126173)
-- Dependencies: 177 3189
-- Name: cache_filter_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_filter_expire_idx ON cache_filter USING btree (expire);


--
-- TOC entry 2752 (class 1259 OID 13126174)
-- Dependencies: 178 3189
-- Name: cache_form_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_form_expire_idx ON cache_form USING btree (expire);


--
-- TOC entry 2755 (class 1259 OID 13126175)
-- Dependencies: 179 3189
-- Name: cache_image_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_image_expire_idx ON cache_image USING btree (expire);


--
-- TOC entry 2758 (class 1259 OID 13126176)
-- Dependencies: 180 3189
-- Name: cache_libraries_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_libraries_expire_idx ON cache_libraries USING btree (expire);


--
-- TOC entry 2761 (class 1259 OID 13126177)
-- Dependencies: 181 3189
-- Name: cache_menu_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_menu_expire_idx ON cache_menu USING btree (expire);


--
-- TOC entry 2764 (class 1259 OID 13126178)
-- Dependencies: 182 3189
-- Name: cache_page_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_page_expire_idx ON cache_page USING btree (expire);


--
-- TOC entry 2767 (class 1259 OID 13126179)
-- Dependencies: 183 3189
-- Name: cache_path_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_path_expire_idx ON cache_path USING btree (expire);


--
-- TOC entry 2770 (class 1259 OID 13126180)
-- Dependencies: 184 3189
-- Name: cache_update_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cache_update_expire_idx ON cache_update USING btree (expire);


--
-- TOC entry 2773 (class 1259 OID 13126181)
-- Dependencies: 185 3189
-- Name: comment_comment_created_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX comment_comment_created_idx ON comment USING btree (created);


--
-- TOC entry 2774 (class 1259 OID 13126182)
-- Dependencies: 185 185 3189
-- Name: comment_comment_nid_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX comment_comment_nid_language_idx ON comment USING btree (nid, language);


--
-- TOC entry 2775 (class 1259 OID 13126183)
-- Dependencies: 185 185 185 185 185 3189
-- Name: comment_comment_num_new_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX comment_comment_num_new_idx ON comment USING btree (nid, status, created, cid, thread);


--
-- TOC entry 2776 (class 1259 OID 13126184)
-- Dependencies: 185 185 3189
-- Name: comment_comment_status_pid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX comment_comment_status_pid_idx ON comment USING btree (pid, status);


--
-- TOC entry 2777 (class 1259 OID 13126185)
-- Dependencies: 185 3189
-- Name: comment_comment_uid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX comment_comment_uid_idx ON comment USING btree (uid);


--
-- TOC entry 2784 (class 1259 OID 13126186)
-- Dependencies: 188 3189
-- Name: date_format_type_title_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX date_format_type_title_idx ON date_format_type USING btree (title);


--
-- TOC entry 2789 (class 1259 OID 13126187)
-- Dependencies: 191 3189
-- Name: field_config_active_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_config_active_idx ON field_config USING btree (active);


--
-- TOC entry 2790 (class 1259 OID 13126188)
-- Dependencies: 191 3189
-- Name: field_config_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_config_deleted_idx ON field_config USING btree (deleted);


--
-- TOC entry 2791 (class 1259 OID 13126189)
-- Dependencies: 191 3189
-- Name: field_config_field_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_config_field_name_idx ON field_config USING btree (field_name);


--
-- TOC entry 2799 (class 1259 OID 13126190)
-- Dependencies: 193 3189
-- Name: field_config_instance_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_config_instance_deleted_idx ON field_config_instance USING btree (deleted);


--
-- TOC entry 2800 (class 1259 OID 13126191)
-- Dependencies: 193 193 193 3189
-- Name: field_config_instance_field_name_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_config_instance_field_name_bundle_idx ON field_config_instance USING btree (field_name, entity_type, bundle);


--
-- TOC entry 2792 (class 1259 OID 13126192)
-- Dependencies: 191 3189
-- Name: field_config_module_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_config_module_idx ON field_config USING btree (module);


--
-- TOC entry 2795 (class 1259 OID 13126193)
-- Dependencies: 191 3189
-- Name: field_config_storage_active_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_config_storage_active_idx ON field_config USING btree (storage_active);


--
-- TOC entry 2796 (class 1259 OID 13126194)
-- Dependencies: 191 3189
-- Name: field_config_storage_module_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_config_storage_module_idx ON field_config USING btree (storage_module);


--
-- TOC entry 2797 (class 1259 OID 13126195)
-- Dependencies: 191 3189
-- Name: field_config_storage_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_config_storage_type_idx ON field_config USING btree (storage_type);


--
-- TOC entry 2798 (class 1259 OID 13126196)
-- Dependencies: 191 3189
-- Name: field_config_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_config_type_idx ON field_config USING btree (type);


--
-- TOC entry 2803 (class 1259 OID 13126197)
-- Dependencies: 195 3189
-- Name: field_data_body_body_format_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_body_body_format_idx ON field_data_body USING btree (body_format);


--
-- TOC entry 2804 (class 1259 OID 13126198)
-- Dependencies: 195 3189
-- Name: field_data_body_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_body_bundle_idx ON field_data_body USING btree (bundle);


--
-- TOC entry 2805 (class 1259 OID 13126199)
-- Dependencies: 195 3189
-- Name: field_data_body_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_body_deleted_idx ON field_data_body USING btree (deleted);


--
-- TOC entry 2806 (class 1259 OID 13126200)
-- Dependencies: 195 3189
-- Name: field_data_body_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_body_entity_id_idx ON field_data_body USING btree (entity_id);


--
-- TOC entry 2807 (class 1259 OID 13126201)
-- Dependencies: 195 3189
-- Name: field_data_body_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_body_entity_type_idx ON field_data_body USING btree (entity_type);


--
-- TOC entry 2808 (class 1259 OID 13126202)
-- Dependencies: 195 3189
-- Name: field_data_body_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_body_language_idx ON field_data_body USING btree (language);


--
-- TOC entry 2811 (class 1259 OID 13126203)
-- Dependencies: 195 3189
-- Name: field_data_body_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_body_revision_id_idx ON field_data_body USING btree (revision_id);


--
-- TOC entry 2812 (class 1259 OID 13126204)
-- Dependencies: 196 3189
-- Name: field_data_comment_body_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_comment_body_bundle_idx ON field_data_comment_body USING btree (bundle);


--
-- TOC entry 2813 (class 1259 OID 13126205)
-- Dependencies: 196 3189
-- Name: field_data_comment_body_comment_body_format_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_comment_body_comment_body_format_idx ON field_data_comment_body USING btree (comment_body_format);


--
-- TOC entry 2814 (class 1259 OID 13126206)
-- Dependencies: 196 3189
-- Name: field_data_comment_body_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_comment_body_deleted_idx ON field_data_comment_body USING btree (deleted);


--
-- TOC entry 2815 (class 1259 OID 13126207)
-- Dependencies: 196 3189
-- Name: field_data_comment_body_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_comment_body_entity_id_idx ON field_data_comment_body USING btree (entity_id);


--
-- TOC entry 2816 (class 1259 OID 13126208)
-- Dependencies: 196 3189
-- Name: field_data_comment_body_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_comment_body_entity_type_idx ON field_data_comment_body USING btree (entity_type);


--
-- TOC entry 2817 (class 1259 OID 13126209)
-- Dependencies: 196 3189
-- Name: field_data_comment_body_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_comment_body_language_idx ON field_data_comment_body USING btree (language);


--
-- TOC entry 2820 (class 1259 OID 13126210)
-- Dependencies: 196 3189
-- Name: field_data_comment_body_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_comment_body_revision_id_idx ON field_data_comment_body USING btree (revision_id);


--
-- TOC entry 2821 (class 1259 OID 13126211)
-- Dependencies: 197 3189
-- Name: field_data_field_image_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_image_bundle_idx ON field_data_field_image USING btree (bundle);


--
-- TOC entry 2822 (class 1259 OID 13126212)
-- Dependencies: 197 3189
-- Name: field_data_field_image_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_image_deleted_idx ON field_data_field_image USING btree (deleted);


--
-- TOC entry 2823 (class 1259 OID 13126213)
-- Dependencies: 197 3189
-- Name: field_data_field_image_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_image_entity_id_idx ON field_data_field_image USING btree (entity_id);


--
-- TOC entry 2824 (class 1259 OID 13126214)
-- Dependencies: 197 3189
-- Name: field_data_field_image_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_image_entity_type_idx ON field_data_field_image USING btree (entity_type);


--
-- TOC entry 2825 (class 1259 OID 13126215)
-- Dependencies: 197 3189
-- Name: field_data_field_image_field_image_fid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_image_field_image_fid_idx ON field_data_field_image USING btree (field_image_fid);


--
-- TOC entry 2826 (class 1259 OID 13126216)
-- Dependencies: 197 3189
-- Name: field_data_field_image_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_image_language_idx ON field_data_field_image USING btree (language);


--
-- TOC entry 2829 (class 1259 OID 13126217)
-- Dependencies: 197 3189
-- Name: field_data_field_image_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_image_revision_id_idx ON field_data_field_image USING btree (revision_id);


--
-- TOC entry 2830 (class 1259 OID 13126218)
-- Dependencies: 198 3189
-- Name: field_data_field_tags_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_tags_bundle_idx ON field_data_field_tags USING btree (bundle);


--
-- TOC entry 2831 (class 1259 OID 13126219)
-- Dependencies: 198 3189
-- Name: field_data_field_tags_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_tags_deleted_idx ON field_data_field_tags USING btree (deleted);


--
-- TOC entry 2832 (class 1259 OID 13126220)
-- Dependencies: 198 3189
-- Name: field_data_field_tags_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_tags_entity_id_idx ON field_data_field_tags USING btree (entity_id);


--
-- TOC entry 2833 (class 1259 OID 13126221)
-- Dependencies: 198 3189
-- Name: field_data_field_tags_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_tags_entity_type_idx ON field_data_field_tags USING btree (entity_type);


--
-- TOC entry 2834 (class 1259 OID 13126222)
-- Dependencies: 198 3189
-- Name: field_data_field_tags_field_tags_tid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_tags_field_tags_tid_idx ON field_data_field_tags USING btree (field_tags_tid);


--
-- TOC entry 2835 (class 1259 OID 13126223)
-- Dependencies: 198 3189
-- Name: field_data_field_tags_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_tags_language_idx ON field_data_field_tags USING btree (language);


--
-- TOC entry 2838 (class 1259 OID 13126224)
-- Dependencies: 198 3189
-- Name: field_data_field_tags_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_tags_revision_id_idx ON field_data_field_tags USING btree (revision_id);


--
-- TOC entry 3069 (class 1259 OID 13178417)
-- Dependencies: 266 3189
-- Name: field_data_field_video_articulo_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_articulo_bundle_idx ON field_data_field_video_articulo USING btree (bundle);


--
-- TOC entry 3070 (class 1259 OID 13178418)
-- Dependencies: 266 3189
-- Name: field_data_field_video_articulo_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_articulo_deleted_idx ON field_data_field_video_articulo USING btree (deleted);


--
-- TOC entry 3071 (class 1259 OID 13178419)
-- Dependencies: 266 3189
-- Name: field_data_field_video_articulo_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_articulo_entity_id_idx ON field_data_field_video_articulo USING btree (entity_id);


--
-- TOC entry 3072 (class 1259 OID 13178416)
-- Dependencies: 266 3189
-- Name: field_data_field_video_articulo_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_articulo_entity_type_idx ON field_data_field_video_articulo USING btree (entity_type);


--
-- TOC entry 3073 (class 1259 OID 13178422)
-- Dependencies: 266 3189
-- Name: field_data_field_video_articulo_field_video_articulo_fid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_articulo_field_video_articulo_fid_idx ON field_data_field_video_articulo USING btree (field_video_articulo_fid);


--
-- TOC entry 3074 (class 1259 OID 13178421)
-- Dependencies: 266 3189
-- Name: field_data_field_video_articulo_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_articulo_language_idx ON field_data_field_video_articulo USING btree (language);


--
-- TOC entry 3077 (class 1259 OID 13178420)
-- Dependencies: 266 3189
-- Name: field_data_field_video_articulo_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_articulo_revision_id_idx ON field_data_field_video_articulo USING btree (revision_id);


--
-- TOC entry 3051 (class 1259 OID 13178342)
-- Dependencies: 264 3189
-- Name: field_data_field_video_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_bundle_idx ON field_data_field_video USING btree (bundle);


--
-- TOC entry 3052 (class 1259 OID 13178343)
-- Dependencies: 264 3189
-- Name: field_data_field_video_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_deleted_idx ON field_data_field_video USING btree (deleted);


--
-- TOC entry 3053 (class 1259 OID 13178344)
-- Dependencies: 264 3189
-- Name: field_data_field_video_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_entity_id_idx ON field_data_field_video USING btree (entity_id);


--
-- TOC entry 3054 (class 1259 OID 13178341)
-- Dependencies: 264 3189
-- Name: field_data_field_video_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_entity_type_idx ON field_data_field_video USING btree (entity_type);


--
-- TOC entry 3055 (class 1259 OID 13178347)
-- Dependencies: 264 3189
-- Name: field_data_field_video_field_video_fid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_field_video_fid_idx ON field_data_field_video USING btree (field_video_fid);


--
-- TOC entry 3056 (class 1259 OID 13178346)
-- Dependencies: 264 3189
-- Name: field_data_field_video_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_language_idx ON field_data_field_video USING btree (language);


--
-- TOC entry 3059 (class 1259 OID 13178345)
-- Dependencies: 264 3189
-- Name: field_data_field_video_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_data_field_video_revision_id_idx ON field_data_field_video USING btree (revision_id);


--
-- TOC entry 2839 (class 1259 OID 13126239)
-- Dependencies: 199 3189
-- Name: field_revision_body_body_format_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_body_body_format_idx ON field_revision_body USING btree (body_format);


--
-- TOC entry 2840 (class 1259 OID 13126240)
-- Dependencies: 199 3189
-- Name: field_revision_body_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_body_bundle_idx ON field_revision_body USING btree (bundle);


--
-- TOC entry 2841 (class 1259 OID 13126241)
-- Dependencies: 199 3189
-- Name: field_revision_body_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_body_deleted_idx ON field_revision_body USING btree (deleted);


--
-- TOC entry 2842 (class 1259 OID 13126242)
-- Dependencies: 199 3189
-- Name: field_revision_body_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_body_entity_id_idx ON field_revision_body USING btree (entity_id);


--
-- TOC entry 2843 (class 1259 OID 13126243)
-- Dependencies: 199 3189
-- Name: field_revision_body_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_body_entity_type_idx ON field_revision_body USING btree (entity_type);


--
-- TOC entry 2844 (class 1259 OID 13126244)
-- Dependencies: 199 3189
-- Name: field_revision_body_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_body_language_idx ON field_revision_body USING btree (language);


--
-- TOC entry 2847 (class 1259 OID 13126245)
-- Dependencies: 199 3189
-- Name: field_revision_body_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_body_revision_id_idx ON field_revision_body USING btree (revision_id);


--
-- TOC entry 2848 (class 1259 OID 13126246)
-- Dependencies: 200 3189
-- Name: field_revision_comment_body_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_comment_body_bundle_idx ON field_revision_comment_body USING btree (bundle);


--
-- TOC entry 2849 (class 1259 OID 13126247)
-- Dependencies: 200 3189
-- Name: field_revision_comment_body_comment_body_format_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_comment_body_comment_body_format_idx ON field_revision_comment_body USING btree (comment_body_format);


--
-- TOC entry 2850 (class 1259 OID 13126248)
-- Dependencies: 200 3189
-- Name: field_revision_comment_body_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_comment_body_deleted_idx ON field_revision_comment_body USING btree (deleted);


--
-- TOC entry 2851 (class 1259 OID 13126249)
-- Dependencies: 200 3189
-- Name: field_revision_comment_body_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_comment_body_entity_id_idx ON field_revision_comment_body USING btree (entity_id);


--
-- TOC entry 2852 (class 1259 OID 13126250)
-- Dependencies: 200 3189
-- Name: field_revision_comment_body_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_comment_body_entity_type_idx ON field_revision_comment_body USING btree (entity_type);


--
-- TOC entry 2853 (class 1259 OID 13126251)
-- Dependencies: 200 3189
-- Name: field_revision_comment_body_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_comment_body_language_idx ON field_revision_comment_body USING btree (language);


--
-- TOC entry 2856 (class 1259 OID 13126252)
-- Dependencies: 200 3189
-- Name: field_revision_comment_body_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_comment_body_revision_id_idx ON field_revision_comment_body USING btree (revision_id);


--
-- TOC entry 2857 (class 1259 OID 13126253)
-- Dependencies: 201 3189
-- Name: field_revision_field_image_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_image_bundle_idx ON field_revision_field_image USING btree (bundle);


--
-- TOC entry 2858 (class 1259 OID 13126254)
-- Dependencies: 201 3189
-- Name: field_revision_field_image_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_image_deleted_idx ON field_revision_field_image USING btree (deleted);


--
-- TOC entry 2859 (class 1259 OID 13126255)
-- Dependencies: 201 3189
-- Name: field_revision_field_image_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_image_entity_id_idx ON field_revision_field_image USING btree (entity_id);


--
-- TOC entry 2860 (class 1259 OID 13126256)
-- Dependencies: 201 3189
-- Name: field_revision_field_image_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_image_entity_type_idx ON field_revision_field_image USING btree (entity_type);


--
-- TOC entry 2861 (class 1259 OID 13126257)
-- Dependencies: 201 3189
-- Name: field_revision_field_image_field_image_fid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_image_field_image_fid_idx ON field_revision_field_image USING btree (field_image_fid);


--
-- TOC entry 2862 (class 1259 OID 13126258)
-- Dependencies: 201 3189
-- Name: field_revision_field_image_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_image_language_idx ON field_revision_field_image USING btree (language);


--
-- TOC entry 2865 (class 1259 OID 13126259)
-- Dependencies: 201 3189
-- Name: field_revision_field_image_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_image_revision_id_idx ON field_revision_field_image USING btree (revision_id);


--
-- TOC entry 2866 (class 1259 OID 13126260)
-- Dependencies: 202 3189
-- Name: field_revision_field_tags_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_tags_bundle_idx ON field_revision_field_tags USING btree (bundle);


--
-- TOC entry 2867 (class 1259 OID 13126261)
-- Dependencies: 202 3189
-- Name: field_revision_field_tags_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_tags_deleted_idx ON field_revision_field_tags USING btree (deleted);


--
-- TOC entry 2868 (class 1259 OID 13126262)
-- Dependencies: 202 3189
-- Name: field_revision_field_tags_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_tags_entity_id_idx ON field_revision_field_tags USING btree (entity_id);


--
-- TOC entry 2869 (class 1259 OID 13126263)
-- Dependencies: 202 3189
-- Name: field_revision_field_tags_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_tags_entity_type_idx ON field_revision_field_tags USING btree (entity_type);


--
-- TOC entry 2870 (class 1259 OID 13126264)
-- Dependencies: 202 3189
-- Name: field_revision_field_tags_field_tags_tid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_tags_field_tags_tid_idx ON field_revision_field_tags USING btree (field_tags_tid);


--
-- TOC entry 2871 (class 1259 OID 13126265)
-- Dependencies: 202 3189
-- Name: field_revision_field_tags_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_tags_language_idx ON field_revision_field_tags USING btree (language);


--
-- TOC entry 2874 (class 1259 OID 13126266)
-- Dependencies: 202 3189
-- Name: field_revision_field_tags_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_tags_revision_id_idx ON field_revision_field_tags USING btree (revision_id);


--
-- TOC entry 3078 (class 1259 OID 13178442)
-- Dependencies: 267 3189
-- Name: field_revision_field_video_articulo_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_articulo_bundle_idx ON field_revision_field_video_articulo USING btree (bundle);


--
-- TOC entry 3079 (class 1259 OID 13178443)
-- Dependencies: 267 3189
-- Name: field_revision_field_video_articulo_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_articulo_deleted_idx ON field_revision_field_video_articulo USING btree (deleted);


--
-- TOC entry 3080 (class 1259 OID 13178444)
-- Dependencies: 267 3189
-- Name: field_revision_field_video_articulo_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_articulo_entity_id_idx ON field_revision_field_video_articulo USING btree (entity_id);


--
-- TOC entry 3081 (class 1259 OID 13178441)
-- Dependencies: 267 3189
-- Name: field_revision_field_video_articulo_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_articulo_entity_type_idx ON field_revision_field_video_articulo USING btree (entity_type);


--
-- TOC entry 3082 (class 1259 OID 13178447)
-- Dependencies: 267 3189
-- Name: field_revision_field_video_articulo_field_video_articulo_fid_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_articulo_field_video_articulo_fid_id ON field_revision_field_video_articulo USING btree (field_video_articulo_fid);


--
-- TOC entry 3083 (class 1259 OID 13178446)
-- Dependencies: 267 3189
-- Name: field_revision_field_video_articulo_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_articulo_language_idx ON field_revision_field_video_articulo USING btree (language);


--
-- TOC entry 3086 (class 1259 OID 13178445)
-- Dependencies: 267 3189
-- Name: field_revision_field_video_articulo_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_articulo_revision_id_idx ON field_revision_field_video_articulo USING btree (revision_id);


--
-- TOC entry 3060 (class 1259 OID 13178367)
-- Dependencies: 265 3189
-- Name: field_revision_field_video_bundle_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_bundle_idx ON field_revision_field_video USING btree (bundle);


--
-- TOC entry 3061 (class 1259 OID 13178368)
-- Dependencies: 265 3189
-- Name: field_revision_field_video_deleted_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_deleted_idx ON field_revision_field_video USING btree (deleted);


--
-- TOC entry 3062 (class 1259 OID 13178369)
-- Dependencies: 265 3189
-- Name: field_revision_field_video_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_entity_id_idx ON field_revision_field_video USING btree (entity_id);


--
-- TOC entry 3063 (class 1259 OID 13178366)
-- Dependencies: 265 3189
-- Name: field_revision_field_video_entity_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_entity_type_idx ON field_revision_field_video USING btree (entity_type);


--
-- TOC entry 3064 (class 1259 OID 13178372)
-- Dependencies: 265 3189
-- Name: field_revision_field_video_field_video_fid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_field_video_fid_idx ON field_revision_field_video USING btree (field_video_fid);


--
-- TOC entry 3065 (class 1259 OID 13178371)
-- Dependencies: 265 3189
-- Name: field_revision_field_video_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_language_idx ON field_revision_field_video USING btree (language);


--
-- TOC entry 3068 (class 1259 OID 13178370)
-- Dependencies: 265 3189
-- Name: field_revision_field_video_revision_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX field_revision_field_video_revision_id_idx ON field_revision_field_video USING btree (revision_id);


--
-- TOC entry 2877 (class 1259 OID 13126281)
-- Dependencies: 203 3189
-- Name: file_managed_status_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX file_managed_status_idx ON file_managed USING btree (status);


--
-- TOC entry 2878 (class 1259 OID 13126282)
-- Dependencies: 203 3189
-- Name: file_managed_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX file_managed_timestamp_idx ON file_managed USING btree ("timestamp");


--
-- TOC entry 2879 (class 1259 OID 13126283)
-- Dependencies: 203 3189
-- Name: file_managed_uid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX file_managed_uid_idx ON file_managed USING btree (uid);


--
-- TOC entry 2882 (class 1259 OID 13126284)
-- Dependencies: 205 205 3189
-- Name: file_usage_fid_count_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX file_usage_fid_count_idx ON file_usage USING btree (fid, count);


--
-- TOC entry 2883 (class 1259 OID 13126285)
-- Dependencies: 205 205 3189
-- Name: file_usage_fid_module_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX file_usage_fid_module_idx ON file_usage USING btree (fid, module);


--
-- TOC entry 2886 (class 1259 OID 13126286)
-- Dependencies: 205 205 3189
-- Name: file_usage_type_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX file_usage_type_id_idx ON file_usage USING btree (type, id);


--
-- TOC entry 2894 (class 1259 OID 13126287)
-- Dependencies: 207 207 3189
-- Name: filter_format_status_weight_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX filter_format_status_weight_idx ON filter_format USING btree (status, weight);


--
-- TOC entry 2887 (class 1259 OID 13126288)
-- Dependencies: 206 206 206 3189
-- Name: filter_list_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX filter_list_idx ON filter USING btree (weight, module, name);


--
-- TOC entry 2895 (class 1259 OID 13126289)
-- Dependencies: 208 208 208 3189
-- Name: flood_allow_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX flood_allow_idx ON flood USING btree (event, identifier, "timestamp");


--
-- TOC entry 2898 (class 1259 OID 13126290)
-- Dependencies: 208 3189
-- Name: flood_purge_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX flood_purge_idx ON flood USING btree (expiration);


--
-- TOC entry 2899 (class 1259 OID 13126291)
-- Dependencies: 210 3189
-- Name: history_nid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX history_nid_idx ON history USING btree (nid);


--
-- TOC entry 2902 (class 1259 OID 13126292)
-- Dependencies: 211 3189
-- Name: image_effects_isid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX image_effects_isid_idx ON image_effects USING btree (isid);


--
-- TOC entry 2905 (class 1259 OID 13126293)
-- Dependencies: 211 3189
-- Name: image_effects_weight_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX image_effects_weight_idx ON image_effects USING btree (weight);


--
-- TOC entry 2912 (class 1259 OID 13126294)
-- Dependencies: 216 216 216 216 216 216 216 216 216 216 3189
-- Name: menu_links_menu_parents_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX menu_links_menu_parents_idx ON menu_links USING btree (menu_name, p1, p2, p3, p4, p5, p6, p7, p8, p9);


--
-- TOC entry 2913 (class 1259 OID 13126295)
-- Dependencies: 216 216 216 216 3189
-- Name: menu_links_menu_plid_expand_child_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX menu_links_menu_plid_expand_child_idx ON menu_links USING btree (menu_name, plid, expanded, has_children);


--
-- TOC entry 2914 (class 1259 OID 13126296)
-- Dependencies: 216 216 3189
-- Name: menu_links_path_menu_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX menu_links_path_menu_idx ON menu_links USING btree (substr((link_path)::text, 1, 128), menu_name);


--
-- TOC entry 2917 (class 1259 OID 13126297)
-- Dependencies: 216 216 3189
-- Name: menu_links_router_path_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX menu_links_router_path_idx ON menu_links USING btree (substr((router_path)::text, 1, 128));


--
-- TOC entry 2918 (class 1259 OID 13126298)
-- Dependencies: 218 3189
-- Name: menu_router_fit_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX menu_router_fit_idx ON menu_router USING btree (fit);


--
-- TOC entry 2921 (class 1259 OID 13126299)
-- Dependencies: 218 218 218 3189
-- Name: menu_router_tab_parent_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX menu_router_tab_parent_idx ON menu_router USING btree (substr((tab_parent)::text, 1, 64), weight, title);


--
-- TOC entry 2922 (class 1259 OID 13126300)
-- Dependencies: 218 218 218 3189
-- Name: menu_router_tab_root_weight_title_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX menu_router_tab_root_weight_title_idx ON menu_router USING btree (substr((tab_root)::text, 1, 64), weight, title);


--
-- TOC entry 2939 (class 1259 OID 13126301)
-- Dependencies: 221 3189
-- Name: node_comment_statistics_comment_count_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_comment_statistics_comment_count_idx ON node_comment_statistics USING btree (comment_count);


--
-- TOC entry 2940 (class 1259 OID 13126302)
-- Dependencies: 221 3189
-- Name: node_comment_statistics_last_comment_uid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_comment_statistics_last_comment_uid_idx ON node_comment_statistics USING btree (last_comment_uid);


--
-- TOC entry 2941 (class 1259 OID 13126303)
-- Dependencies: 221 3189
-- Name: node_comment_statistics_node_comment_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_comment_statistics_node_comment_timestamp_idx ON node_comment_statistics USING btree (last_comment_timestamp);


--
-- TOC entry 2923 (class 1259 OID 13126304)
-- Dependencies: 219 3189
-- Name: node_language_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_language_idx ON node USING btree (language);


--
-- TOC entry 2924 (class 1259 OID 13126305)
-- Dependencies: 219 3189
-- Name: node_node_changed_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_node_changed_idx ON node USING btree (changed);


--
-- TOC entry 2925 (class 1259 OID 13126306)
-- Dependencies: 219 3189
-- Name: node_node_created_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_node_created_idx ON node USING btree (created);


--
-- TOC entry 2926 (class 1259 OID 13126307)
-- Dependencies: 219 219 219 219 3189
-- Name: node_node_frontpage_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_node_frontpage_idx ON node USING btree (promote, status, sticky, created);


--
-- TOC entry 2927 (class 1259 OID 13126308)
-- Dependencies: 219 219 219 3189
-- Name: node_node_status_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_node_status_type_idx ON node USING btree (status, type, nid);


--
-- TOC entry 2928 (class 1259 OID 13126309)
-- Dependencies: 219 219 3189
-- Name: node_node_title_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_node_title_type_idx ON node USING btree (title, substr((type)::text, 1, 4));


--
-- TOC entry 2929 (class 1259 OID 13126310)
-- Dependencies: 219 219 3189
-- Name: node_node_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_node_type_idx ON node USING btree (substr((type)::text, 1, 4));


--
-- TOC entry 2944 (class 1259 OID 13126311)
-- Dependencies: 223 3189
-- Name: node_revision_nid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_revision_nid_idx ON node_revision USING btree (nid);


--
-- TOC entry 2947 (class 1259 OID 13126312)
-- Dependencies: 223 3189
-- Name: node_revision_uid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_revision_uid_idx ON node_revision USING btree (uid);


--
-- TOC entry 2932 (class 1259 OID 13126313)
-- Dependencies: 219 3189
-- Name: node_tnid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_tnid_idx ON node USING btree (tnid);


--
-- TOC entry 2933 (class 1259 OID 13126314)
-- Dependencies: 219 3189
-- Name: node_translate_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_translate_idx ON node USING btree (translate);


--
-- TOC entry 2934 (class 1259 OID 13126315)
-- Dependencies: 219 3189
-- Name: node_uid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX node_uid_idx ON node USING btree (uid);


--
-- TOC entry 2950 (class 1259 OID 13126316)
-- Dependencies: 226 3189
-- Name: queue_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX queue_expire_idx ON queue USING btree (expire);


--
-- TOC entry 2951 (class 1259 OID 13126317)
-- Dependencies: 226 226 3189
-- Name: queue_name_created_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX queue_name_created_idx ON queue USING btree (name, created);


--
-- TOC entry 2956 (class 1259 OID 13126318)
-- Dependencies: 229 229 229 3189
-- Name: registry_hook_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX registry_hook_idx ON registry USING btree (type, weight, module);


--
-- TOC entry 2963 (class 1259 OID 13126319)
-- Dependencies: 231 231 3189
-- Name: role_name_weight_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX role_name_weight_idx ON role USING btree (name, weight);


--
-- TOC entry 2966 (class 1259 OID 13126320)
-- Dependencies: 232 3189
-- Name: role_permission_permission_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX role_permission_permission_idx ON role_permission USING btree (permission);


--
-- TOC entry 2973 (class 1259 OID 13126321)
-- Dependencies: 235 235 3189
-- Name: search_index_sid_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX search_index_sid_type_idx ON search_index USING btree (sid, type);


--
-- TOC entry 2974 (class 1259 OID 13126322)
-- Dependencies: 236 3189
-- Name: search_node_links_nid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX search_node_links_nid_idx ON search_node_links USING btree (nid);


--
-- TOC entry 2979 (class 1259 OID 13126323)
-- Dependencies: 238 3189
-- Name: semaphore_expire_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX semaphore_expire_idx ON semaphore USING btree (expire);


--
-- TOC entry 2982 (class 1259 OID 13126324)
-- Dependencies: 238 3189
-- Name: semaphore_value_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX semaphore_value_idx ON semaphore USING btree (value);


--
-- TOC entry 2987 (class 1259 OID 13126325)
-- Dependencies: 241 3189
-- Name: sessions_ssid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sessions_ssid_idx ON sessions USING btree (ssid);


--
-- TOC entry 2988 (class 1259 OID 13126326)
-- Dependencies: 241 3189
-- Name: sessions_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sessions_timestamp_idx ON sessions USING btree ("timestamp");


--
-- TOC entry 2989 (class 1259 OID 13126327)
-- Dependencies: 241 3189
-- Name: sessions_uid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sessions_uid_idx ON sessions USING btree (uid);


--
-- TOC entry 2994 (class 1259 OID 13126328)
-- Dependencies: 243 3189
-- Name: shortcut_set_users_set_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX shortcut_set_users_set_name_idx ON shortcut_set_users USING btree (set_name);


--
-- TOC entry 2997 (class 1259 OID 13126329)
-- Dependencies: 244 244 244 244 244 3189
-- Name: system_system_list_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX system_system_list_idx ON system USING btree (status, bootstrap, type, weight, name);


--
-- TOC entry 2998 (class 1259 OID 13126330)
-- Dependencies: 244 244 3189
-- Name: system_type_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX system_type_name_idx ON system USING btree (type, name);


--
-- TOC entry 2999 (class 1259 OID 13126331)
-- Dependencies: 245 3189
-- Name: taxonomy_index_nid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX taxonomy_index_nid_idx ON taxonomy_index USING btree (nid);


--
-- TOC entry 3000 (class 1259 OID 13126332)
-- Dependencies: 245 245 245 3189
-- Name: taxonomy_index_term_node_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX taxonomy_index_term_node_idx ON taxonomy_index USING btree (tid, sticky, created);


--
-- TOC entry 3001 (class 1259 OID 13126333)
-- Dependencies: 246 3189
-- Name: taxonomy_term_data_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX taxonomy_term_data_name_idx ON taxonomy_term_data USING btree (name);


--
-- TOC entry 3004 (class 1259 OID 13126334)
-- Dependencies: 246 246 246 3189
-- Name: taxonomy_term_data_taxonomy_tree_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX taxonomy_term_data_taxonomy_tree_idx ON taxonomy_term_data USING btree (vid, weight, name);


--
-- TOC entry 3005 (class 1259 OID 13126335)
-- Dependencies: 246 246 3189
-- Name: taxonomy_term_data_vid_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX taxonomy_term_data_vid_name_idx ON taxonomy_term_data USING btree (vid, name);


--
-- TOC entry 3006 (class 1259 OID 13126336)
-- Dependencies: 248 3189
-- Name: taxonomy_term_hierarchy_parent_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX taxonomy_term_hierarchy_parent_idx ON taxonomy_term_hierarchy USING btree (parent);


--
-- TOC entry 3009 (class 1259 OID 13126337)
-- Dependencies: 249 249 3189
-- Name: taxonomy_vocabulary_list_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX taxonomy_vocabulary_list_idx ON taxonomy_vocabulary USING btree (weight, name);


--
-- TOC entry 3014 (class 1259 OID 13126338)
-- Dependencies: 251 251 251 3189
-- Name: url_alias_alias_language_pid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX url_alias_alias_language_pid_idx ON url_alias USING btree (alias, language, pid);


--
-- TOC entry 3017 (class 1259 OID 13126339)
-- Dependencies: 251 251 251 3189
-- Name: url_alias_source_language_pid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX url_alias_source_language_pid_idx ON url_alias USING btree (source, language, pid);


--
-- TOC entry 3018 (class 1259 OID 13126340)
-- Dependencies: 253 3189
-- Name: users_access_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX users_access_idx ON users USING btree (access);


--
-- TOC entry 3019 (class 1259 OID 13126341)
-- Dependencies: 253 3189
-- Name: users_created_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX users_created_idx ON users USING btree (created);


--
-- TOC entry 3020 (class 1259 OID 13126342)
-- Dependencies: 253 3189
-- Name: users_mail_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX users_mail_idx ON users USING btree (mail);


--
-- TOC entry 3023 (class 1259 OID 13126343)
-- Dependencies: 253 3189
-- Name: users_picture_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX users_picture_idx ON users USING btree (picture);


--
-- TOC entry 3028 (class 1259 OID 13126344)
-- Dependencies: 254 3189
-- Name: users_roles_rid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX users_roles_rid_idx ON users_roles USING btree (rid);


--
-- TOC entry 3031 (class 1259 OID 13126345)
-- Dependencies: 256 3189
-- Name: video_output_original_fid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX video_output_original_fid_idx ON video_output USING btree (original_fid);


--
-- TOC entry 3038 (class 1259 OID 13126346)
-- Dependencies: 259 3189
-- Name: video_queue_file_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX video_queue_file_idx ON video_queue USING btree (fid);


--
-- TOC entry 3041 (class 1259 OID 13126347)
-- Dependencies: 259 3189
-- Name: video_queue_status_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX video_queue_status_idx ON video_queue USING btree (status);


--
-- TOC entry 3048 (class 1259 OID 13126348)
-- Dependencies: 262 3189
-- Name: watchdog_severity_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX watchdog_severity_idx ON watchdog USING btree (severity);


--
-- TOC entry 3049 (class 1259 OID 13126349)
-- Dependencies: 262 3189
-- Name: watchdog_type_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX watchdog_type_idx ON watchdog USING btree (type);


--
-- TOC entry 3050 (class 1259 OID 13126350)
-- Dependencies: 262 3189
-- Name: watchdog_uid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX watchdog_uid_idx ON watchdog USING btree (uid);


--
-- TOC entry 3194 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-04-01 16:49:14 VET

--
-- PostgreSQL database dump complete
--


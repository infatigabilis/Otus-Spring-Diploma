--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;


--
-- PostgreSQL database dump
--

-- Dumped from database version 11.0
-- Dumped by pg_dump version 11.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO keycloak;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: keycloak
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: keycloak
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: keycloak
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.0
-- Dumped by pg_dump version 11.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: keycloak
--

\connect keycloak

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_default_roles OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    device character varying(255),
    hash_iterations integer,
    salt bytea,
    type character varying(255),
    value character varying(4000),
    user_id character varying(36),
    created_date bigint,
    counter integer DEFAULT 0,
    digits integer DEFAULT 6,
    period integer DEFAULT 30,
    algorithm character varying(36) DEFAULT NULL::character varying
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: credential_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential_attribute (
    id character varying(36) NOT NULL,
    credential_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.credential_attribute OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_credential_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_credential_attribute (
    id character varying(36) NOT NULL,
    credential_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.fed_credential_attribute OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    device character varying(255),
    hash_iterations integer,
    salt bytea,
    type character varying(255),
    value character varying(255),
    created_date bigint,
    counter integer DEFAULT 0,
    digits integer DEFAULT 6,
    period integer DEFAULT 30,
    algorithm character varying(36) DEFAULT 'HmacSHA1'::character varying,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36),
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(36),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36)
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    last_session_refresh integer,
    offline_flag character varying(4) NOT NULL,
    data text
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_roles OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(36) NOT NULL,
    requester character varying(36) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(36)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(36) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(36),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
9150963e-3c9b-4272-a9e4-2362f0581a8b	\N	auth-cookie	master	23b2d7de-8e92-4056-89bf-b5f4292dd4fb	2	10	f	\N	\N
16d907f7-16d8-4fe8-b859-d17d4c81e6e3	\N	auth-spnego	master	23b2d7de-8e92-4056-89bf-b5f4292dd4fb	3	20	f	\N	\N
de0d2dcb-4d6e-4d66-bd00-ef3d96a738fd	\N	identity-provider-redirector	master	23b2d7de-8e92-4056-89bf-b5f4292dd4fb	2	25	f	\N	\N
6e115457-8018-47c8-ab32-e7115caef25f	\N	\N	master	23b2d7de-8e92-4056-89bf-b5f4292dd4fb	2	30	t	1fdf162a-88b2-44b6-aa1b-cd913a6eb8c8	\N
598ba204-68a8-4dbc-8598-7ba25d66086f	\N	auth-username-password-form	master	1fdf162a-88b2-44b6-aa1b-cd913a6eb8c8	0	10	f	\N	\N
f1e60350-583b-4838-88c0-602dc5426fda	\N	auth-otp-form	master	1fdf162a-88b2-44b6-aa1b-cd913a6eb8c8	1	20	f	\N	\N
f06e95dd-cdb7-41cb-a062-14c73ac62d3e	\N	direct-grant-validate-username	master	6c066b4f-230a-4fce-ae8c-70401048dc11	0	10	f	\N	\N
81214893-ee07-4242-b586-815da5edd08c	\N	direct-grant-validate-password	master	6c066b4f-230a-4fce-ae8c-70401048dc11	0	20	f	\N	\N
135ecf1c-759a-4504-82d9-a41d71dc8ba1	\N	direct-grant-validate-otp	master	6c066b4f-230a-4fce-ae8c-70401048dc11	1	30	f	\N	\N
4b8c1307-25f2-4881-bdb8-f7707e489917	\N	registration-page-form	master	24e28d54-adf8-46ec-ae7a-c4a75178f5c2	0	10	t	0680eef5-c51e-46af-8f60-33b7bdfa0c0b	\N
310f2753-be77-4b35-8358-9ae9b56d7fc9	\N	registration-user-creation	master	0680eef5-c51e-46af-8f60-33b7bdfa0c0b	0	20	f	\N	\N
788640ee-460e-4a36-a216-76ec2de4e02c	\N	registration-profile-action	master	0680eef5-c51e-46af-8f60-33b7bdfa0c0b	0	40	f	\N	\N
1b8eeead-56b3-4f8a-b5b9-813a61ec2d8a	\N	registration-password-action	master	0680eef5-c51e-46af-8f60-33b7bdfa0c0b	0	50	f	\N	\N
3ea0a985-73ea-482b-8a3a-886af1898652	\N	registration-recaptcha-action	master	0680eef5-c51e-46af-8f60-33b7bdfa0c0b	3	60	f	\N	\N
7582cb35-807f-4588-a495-4c08879ec111	\N	reset-credentials-choose-user	master	6097ddaa-77a3-4d15-85f7-66e3b8081b17	0	10	f	\N	\N
10d50a1c-9a06-4bf5-ad9d-c0f457829a3c	\N	reset-credential-email	master	6097ddaa-77a3-4d15-85f7-66e3b8081b17	0	20	f	\N	\N
abdf0def-11e3-43ef-9c21-e4200d28b8be	\N	reset-password	master	6097ddaa-77a3-4d15-85f7-66e3b8081b17	0	30	f	\N	\N
a32b0171-287e-4633-b334-bf3e04b76f26	\N	reset-otp	master	6097ddaa-77a3-4d15-85f7-66e3b8081b17	1	40	f	\N	\N
8d8b07dd-fc7c-46cc-9cac-6da36fa6c54d	\N	client-secret	master	50269b88-ded5-4b2f-a9fc-b808a941b53a	2	10	f	\N	\N
06b0c516-9c3b-49c9-a432-8fe72459f815	\N	client-jwt	master	50269b88-ded5-4b2f-a9fc-b808a941b53a	2	20	f	\N	\N
f44fd477-eee5-4433-a48c-3d39a17fdc34	\N	client-secret-jwt	master	50269b88-ded5-4b2f-a9fc-b808a941b53a	2	30	f	\N	\N
abf09ac7-2621-41a3-b662-fa68f4d5d51b	\N	client-x509	master	50269b88-ded5-4b2f-a9fc-b808a941b53a	2	40	f	\N	\N
014d8c77-4cf4-4fb8-abb7-cce64dcf64c3	\N	idp-review-profile	master	6bbb5078-4476-45c4-81c2-5c0e56c1c62d	0	10	f	\N	90a8bddf-5e43-4e0d-ae97-30770e5230ba
a9cda653-44f3-4c53-861c-f9783057015e	\N	idp-create-user-if-unique	master	6bbb5078-4476-45c4-81c2-5c0e56c1c62d	2	20	f	\N	53068b56-c592-4f01-a220-65b3eeead40c
112be1cd-690e-4876-b587-cf7733e6e216	\N	\N	master	6bbb5078-4476-45c4-81c2-5c0e56c1c62d	2	30	t	9db4e58f-d930-4db7-aa66-d6a66c14ba06	\N
bdb1b754-1c24-469c-ae0d-b343bdca6169	\N	idp-confirm-link	master	9db4e58f-d930-4db7-aa66-d6a66c14ba06	0	10	f	\N	\N
5296c051-1887-4cb1-a950-2c265882d7c6	\N	idp-email-verification	master	9db4e58f-d930-4db7-aa66-d6a66c14ba06	2	20	f	\N	\N
2bb080a9-194f-4a98-a9c3-b34afacc7343	\N	\N	master	9db4e58f-d930-4db7-aa66-d6a66c14ba06	2	30	t	4d7f7e6a-2fbe-40a7-ab85-ddec1379b2ac	\N
b26b616f-45ed-4e90-903f-2f2acfb9413a	\N	idp-username-password-form	master	4d7f7e6a-2fbe-40a7-ab85-ddec1379b2ac	0	10	f	\N	\N
31446bca-356d-4675-b90f-5a90e1256f03	\N	auth-otp-form	master	4d7f7e6a-2fbe-40a7-ab85-ddec1379b2ac	1	20	f	\N	\N
c36d6196-aae8-4447-8115-2c8821930cc6	\N	http-basic-authenticator	master	01b3d3b5-e5d1-4b6d-8b5b-9115720d949b	0	10	f	\N	\N
cfb57a35-bd88-4c15-adf0-7bd17967b352	\N	docker-http-basic-authenticator	master	4bd78a75-f049-4484-ad19-42ee38498620	0	10	f	\N	\N
3dfa0b01-693b-4ddd-a966-d0df41ca738d	\N	no-cookie-redirect	master	fe777cbd-556f-4798-865b-7cb8077561fa	0	10	f	\N	\N
e9ca5ea8-dd08-4f13-b1d7-2c570b093271	\N	basic-auth	master	fe777cbd-556f-4798-865b-7cb8077561fa	0	20	f	\N	\N
96e07576-5486-496c-a7dd-e23eacecf480	\N	basic-auth-otp	master	fe777cbd-556f-4798-865b-7cb8077561fa	3	30	f	\N	\N
86007dfe-69ae-4f8c-9890-2cc187f167a9	\N	auth-spnego	master	fe777cbd-556f-4798-865b-7cb8077561fa	3	40	f	\N	\N
ea6096dc-7cb8-4daa-908f-fa47a20eeece	\N	idp-confirm-link	Otus-Spring-Diploma	5b7d1cd2-0cde-477f-81fe-897fdd000087	0	10	f	\N	\N
9b3a2df5-84e0-4ac8-9f04-3b7794c267e5	\N	idp-email-verification	Otus-Spring-Diploma	5b7d1cd2-0cde-477f-81fe-897fdd000087	2	20	f	\N	\N
98d93dea-49f8-4c92-afcd-7345cc29daa8	\N	\N	Otus-Spring-Diploma	5b7d1cd2-0cde-477f-81fe-897fdd000087	2	30	t	df241049-ba42-4802-ab38-59e69a451d00	\N
c3c77cdd-02ef-4500-8598-2291e1ddeb8c	\N	idp-username-password-form	Otus-Spring-Diploma	df241049-ba42-4802-ab38-59e69a451d00	0	10	f	\N	\N
d8149e85-1460-4e47-9e3c-cc66fc532ef0	\N	auth-otp-form	Otus-Spring-Diploma	df241049-ba42-4802-ab38-59e69a451d00	1	20	f	\N	\N
37301f94-b128-443a-8554-d70dd95c921b	\N	auth-cookie	Otus-Spring-Diploma	e4995259-45a9-441b-9c05-d035d7d8c298	2	10	f	\N	\N
fac1f570-1180-4d2d-b624-ef1fcad27b32	\N	auth-spnego	Otus-Spring-Diploma	e4995259-45a9-441b-9c05-d035d7d8c298	3	20	f	\N	\N
38aa7f6c-fe6c-4a50-88f7-f9e1c8fce844	\N	identity-provider-redirector	Otus-Spring-Diploma	e4995259-45a9-441b-9c05-d035d7d8c298	2	25	f	\N	\N
e48bb7c9-7df2-46f9-ac90-f5de23f332af	\N	\N	Otus-Spring-Diploma	e4995259-45a9-441b-9c05-d035d7d8c298	2	30	t	bdd895e7-68d3-4488-9253-07b0f361e34b	\N
d1a465a4-3ea8-4e1f-97ef-6adb7470f129	\N	client-secret	Otus-Spring-Diploma	4a3ba799-f3d6-4ce2-bd7d-e34af2875da1	2	10	f	\N	\N
d43c0e4b-18ec-4930-a6eb-8baf9160da30	\N	client-jwt	Otus-Spring-Diploma	4a3ba799-f3d6-4ce2-bd7d-e34af2875da1	2	20	f	\N	\N
0d549b81-c09c-4ce3-8540-0039d9ba19ba	\N	client-secret-jwt	Otus-Spring-Diploma	4a3ba799-f3d6-4ce2-bd7d-e34af2875da1	2	30	f	\N	\N
f7818ab7-6352-44c7-820e-2c6a2d19a089	\N	client-x509	Otus-Spring-Diploma	4a3ba799-f3d6-4ce2-bd7d-e34af2875da1	2	40	f	\N	\N
61e4017c-9e40-48d4-bcb7-2133814b0bf1	\N	direct-grant-validate-username	Otus-Spring-Diploma	75249688-8348-4deb-8166-21e62c737960	0	10	f	\N	\N
20f7809e-a697-4864-8d3c-9d7b8289ca7f	\N	direct-grant-validate-password	Otus-Spring-Diploma	75249688-8348-4deb-8166-21e62c737960	0	20	f	\N	\N
e0bb808d-49a5-4675-a593-566ce75d1ac6	\N	direct-grant-validate-otp	Otus-Spring-Diploma	75249688-8348-4deb-8166-21e62c737960	1	30	f	\N	\N
4034f397-f4f3-4f79-9873-366314af99ef	\N	docker-http-basic-authenticator	Otus-Spring-Diploma	55c09654-193b-4235-af19-37f401354988	0	10	f	\N	\N
bac5e07d-6826-4ab8-b413-b3ae8ae747cc	\N	idp-review-profile	Otus-Spring-Diploma	caec08ec-87d6-4d44-8632-1e8713e7aded	0	10	f	\N	b793cc16-939f-4f70-a896-09bb8d787e67
44cdf14e-e71a-4aab-9aec-2b5cb2f7ba3e	\N	idp-create-user-if-unique	Otus-Spring-Diploma	caec08ec-87d6-4d44-8632-1e8713e7aded	2	20	f	\N	ab75d65b-ef31-462e-b800-d47c0152a93f
7d8c91df-a78e-4edd-a980-3ec892660a20	\N	\N	Otus-Spring-Diploma	caec08ec-87d6-4d44-8632-1e8713e7aded	2	30	t	5b7d1cd2-0cde-477f-81fe-897fdd000087	\N
87b36395-6c90-488c-aea3-43bd57943224	\N	auth-username-password-form	Otus-Spring-Diploma	bdd895e7-68d3-4488-9253-07b0f361e34b	0	10	f	\N	\N
617babdf-f464-455b-bade-cbab75e655f6	\N	auth-otp-form	Otus-Spring-Diploma	bdd895e7-68d3-4488-9253-07b0f361e34b	1	20	f	\N	\N
64d65928-46f8-48af-86c5-e1515ebc567d	\N	no-cookie-redirect	Otus-Spring-Diploma	2613f219-c51b-4211-a33d-536a395d9b3a	0	10	f	\N	\N
70c779cc-17e3-45ec-bb7c-de2bad6f0e7c	\N	basic-auth	Otus-Spring-Diploma	2613f219-c51b-4211-a33d-536a395d9b3a	0	20	f	\N	\N
0aa8918e-74bb-4a5e-89f5-fe7e9fccb63d	\N	basic-auth-otp	Otus-Spring-Diploma	2613f219-c51b-4211-a33d-536a395d9b3a	3	30	f	\N	\N
21db1d2a-f11b-4864-a319-2a65bde0c581	\N	auth-spnego	Otus-Spring-Diploma	2613f219-c51b-4211-a33d-536a395d9b3a	3	40	f	\N	\N
10c0ed84-fbde-4700-8d32-58fdc5875b33	\N	registration-page-form	Otus-Spring-Diploma	fd11be0f-1871-4b7c-a726-4c70865ba591	0	10	t	9e1bf834-1f36-4c72-968f-eb564765f371	\N
a531ab02-5e4b-406a-b5c4-d187ea76fe98	\N	registration-user-creation	Otus-Spring-Diploma	9e1bf834-1f36-4c72-968f-eb564765f371	0	20	f	\N	\N
6bd3fdef-be01-4e2b-b520-6445819d19ce	\N	registration-profile-action	Otus-Spring-Diploma	9e1bf834-1f36-4c72-968f-eb564765f371	0	40	f	\N	\N
84de1089-0a7c-4c10-82ce-e48afde437f4	\N	registration-password-action	Otus-Spring-Diploma	9e1bf834-1f36-4c72-968f-eb564765f371	0	50	f	\N	\N
c1ddf127-2a0d-43e2-861e-7a19afbd939c	\N	registration-recaptcha-action	Otus-Spring-Diploma	9e1bf834-1f36-4c72-968f-eb564765f371	3	60	f	\N	\N
204b1a1e-8fb7-40ee-914d-75913486e6b7	\N	reset-credentials-choose-user	Otus-Spring-Diploma	13b26aad-ef33-490e-951f-41d974af671f	0	10	f	\N	\N
01c588e0-f952-400e-a2ff-598a4307fa99	\N	reset-credential-email	Otus-Spring-Diploma	13b26aad-ef33-490e-951f-41d974af671f	0	20	f	\N	\N
4ff1b035-c29e-4dc3-8e93-6e710b601678	\N	reset-password	Otus-Spring-Diploma	13b26aad-ef33-490e-951f-41d974af671f	0	30	f	\N	\N
c17871f2-3cd4-4189-91e7-be045c3839f6	\N	reset-otp	Otus-Spring-Diploma	13b26aad-ef33-490e-951f-41d974af671f	1	40	f	\N	\N
37ced9bf-404f-424f-a887-06f8db092e83	\N	http-basic-authenticator	Otus-Spring-Diploma	b5f2e470-9f81-4df6-8124-73ead77ffbb9	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
23b2d7de-8e92-4056-89bf-b5f4292dd4fb	browser	browser based authentication	master	basic-flow	t	t
1fdf162a-88b2-44b6-aa1b-cd913a6eb8c8	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
6c066b4f-230a-4fce-ae8c-70401048dc11	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
24e28d54-adf8-46ec-ae7a-c4a75178f5c2	registration	registration flow	master	basic-flow	t	t
0680eef5-c51e-46af-8f60-33b7bdfa0c0b	registration form	registration form	master	form-flow	f	t
6097ddaa-77a3-4d15-85f7-66e3b8081b17	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
50269b88-ded5-4b2f-a9fc-b808a941b53a	clients	Base authentication for clients	master	client-flow	t	t
6bbb5078-4476-45c4-81c2-5c0e56c1c62d	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
9db4e58f-d930-4db7-aa66-d6a66c14ba06	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
4d7f7e6a-2fbe-40a7-ab85-ddec1379b2ac	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
01b3d3b5-e5d1-4b6d-8b5b-9115720d949b	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
4bd78a75-f049-4484-ad19-42ee38498620	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
fe777cbd-556f-4798-865b-7cb8077561fa	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
5b7d1cd2-0cde-477f-81fe-897fdd000087	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	Otus-Spring-Diploma	basic-flow	f	t
df241049-ba42-4802-ab38-59e69a451d00	Verify Existing Account by Re-authentication	Reauthentication of existing account	Otus-Spring-Diploma	basic-flow	f	t
e4995259-45a9-441b-9c05-d035d7d8c298	browser	browser based authentication	Otus-Spring-Diploma	basic-flow	t	t
4a3ba799-f3d6-4ce2-bd7d-e34af2875da1	clients	Base authentication for clients	Otus-Spring-Diploma	client-flow	t	t
75249688-8348-4deb-8166-21e62c737960	direct grant	OpenID Connect Resource Owner Grant	Otus-Spring-Diploma	basic-flow	t	t
55c09654-193b-4235-af19-37f401354988	docker auth	Used by Docker clients to authenticate against the IDP	Otus-Spring-Diploma	basic-flow	t	t
caec08ec-87d6-4d44-8632-1e8713e7aded	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	Otus-Spring-Diploma	basic-flow	t	t
bdd895e7-68d3-4488-9253-07b0f361e34b	forms	Username, password, otp and other auth forms.	Otus-Spring-Diploma	basic-flow	f	t
2613f219-c51b-4211-a33d-536a395d9b3a	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	Otus-Spring-Diploma	basic-flow	t	t
fd11be0f-1871-4b7c-a726-4c70865ba591	registration	registration flow	Otus-Spring-Diploma	basic-flow	t	t
9e1bf834-1f36-4c72-968f-eb564765f371	registration form	registration form	Otus-Spring-Diploma	form-flow	f	t
13b26aad-ef33-490e-951f-41d974af671f	reset credentials	Reset credentials for a user if they forgot their password or something	Otus-Spring-Diploma	basic-flow	t	t
b5f2e470-9f81-4df6-8124-73ead77ffbb9	saml ecp	SAML ECP Profile Authentication Flow	Otus-Spring-Diploma	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
90a8bddf-5e43-4e0d-ae97-30770e5230ba	review profile config	master
53068b56-c592-4f01-a220-65b3eeead40c	create unique user config	master
ab75d65b-ef31-462e-b800-d47c0152a93f	create unique user config	Otus-Spring-Diploma
b793cc16-939f-4f70-a896-09bb8d787e67	review profile config	Otus-Spring-Diploma
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
90a8bddf-5e43-4e0d-ae97-30770e5230ba	missing	update.profile.on.first.login
53068b56-c592-4f01-a220-65b3eeead40c	false	require.password.update.after.registration
ab75d65b-ef31-462e-b800-d47c0152a93f	false	require.password.update.after.registration
b793cc16-939f-4f70-a896-09bb8d787e67	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled) FROM stdin;
55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	t	master-realm	0	f	65cad899-7b1f-4095-8f79-9cb2abcef015	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f
ee8227e9-e506-4a4b-a074-2ada05003136	t	f	account	0	f	991f5f3b-eda7-40a0-939c-66f19da1b01e	/auth/realms/master/account	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	\N	\N	\N	t	f	f
a3f63db2-b9ae-4fa2-b549-8ad678d69efe	t	f	broker	0	f	41e956ed-61ab-432d-903c-73737d0007a5	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f
bbc2d41f-3582-452a-a94c-16a1819a1cdb	t	f	security-admin-console	0	t	af88de0c-171e-4a82-a6a3-b0f610d090b9	/auth/admin/master/console/index.html	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	\N	\N	\N	t	f	f
d4a0a47d-d658-4e76-a490-1ebf8a1981cf	t	f	admin-cli	0	t	6eeba90c-1c7c-40a2-8d1d-7269b4dde694	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t
02c5fa32-6078-4f18-b244-4acda5694bc9	t	t	Otus-Spring-Diploma-realm	0	f	88bad050-c6a6-4074-855f-764dd8a146c3	\N	t	\N	f	master	\N	0	f	f	Otus-Spring-Diploma Realm	f	client-secret	\N	\N	\N	t	f	f
09c74bad-b814-4850-987a-a4abf16743f3	t	f	security-admin-console	0	t	**********	/auth/admin/Otus-Spring-Diploma/console/index.html	f	\N	f	Otus-Spring-Diploma	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	\N	\N	\N	t	f	f
0e68a51d-b4ef-4bbe-af1f-3ecb481e8014	t	f	broker	0	f	**********	\N	f	\N	f	Otus-Spring-Diploma	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f
f215e460-e572-42ec-8b6b-f1c6ad3d188b	t	t	otus-spring-diploma-client	0	t	**********	\N	f	\N	f	Otus-Spring-Diploma	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t
fd166d3d-9182-4594-bdaa-ed9a8ff4645b	t	f	admin-cli	0	t	**********	\N	f	\N	f	Otus-Spring-Diploma	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t
b5a9dec5-70dd-4a5b-9664-e79093420f4a	t	f	account	0	f	**********	/auth/realms/Otus-Spring-Diploma/account	f	\N	f	Otus-Spring-Diploma	openid-connect	0	f	f	${client_account}	f	client-secret	\N	\N	\N	t	f	f
79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	f	realm-management	0	f	**********	\N	t	\N	f	Otus-Spring-Diploma	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	saml.assertion.signature
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	saml.force.post.binding
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	saml.multivalued.roles
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	saml.encrypt
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	saml.server.signature
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	saml.server.signature.keyinfo.ext
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	exclude.session.state.from.auth.response
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	saml_force_name_id_format
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	saml.client.signature
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	tls.client.certificate.bound.access.tokens
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	saml.authnstatement
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	display.on.consent.screen
f215e460-e572-42ec-8b6b-f1c6ad3d188b	false	saml.onetimeuse.condition
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_default_roles (client_id, role_id) FROM stdin;
ee8227e9-e506-4a4b-a074-2ada05003136	0ec74f6c-ee1d-42f9-9400-5556269f1fe5
ee8227e9-e506-4a4b-a074-2ada05003136	49edf0fe-4ffe-4be8-8c18-9b0e7393883e
b5a9dec5-70dd-4a5b-9664-e79093420f4a	131e2683-c5c9-43ff-92f5-7766a2ebfe3f
b5a9dec5-70dd-4a5b-9664-e79093420f4a	1e5ff209-535b-495d-a8d2-90e21b327070
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
1c513f33-5fb5-4038-b957-561791dbedac	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
6dc1744a-5323-4d89-b352-fe8f1535d454	role_list	master	SAML role list	saml
d0f20974-aa2a-4b6b-bc93-8f338b2306e0	profile	master	OpenID Connect built-in scope: profile	openid-connect
3c006cd6-cd36-4f04-8342-b8361ba88f03	email	master	OpenID Connect built-in scope: email	openid-connect
375a7938-f9a6-4ea7-9f02-f12f79d00eb1	address	master	OpenID Connect built-in scope: address	openid-connect
97c0174c-bc25-4fb2-bc1a-e5d37abdd879	phone	master	OpenID Connect built-in scope: phone	openid-connect
1882a27c-4138-4243-8aa2-888d26f0d992	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
c415156e-f3c6-40f6-9baf-2ff6de1805ea	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
01e6ed6c-6949-435c-82d3-3fe8436334f6	address	Otus-Spring-Diploma	OpenID Connect built-in scope: address	openid-connect
d82a1bdd-2bdd-45fd-a4ca-6c0017188509	email	Otus-Spring-Diploma	OpenID Connect built-in scope: email	openid-connect
854d924f-d40f-4a8c-89d7-d9980ee21307	offline_access	Otus-Spring-Diploma	OpenID Connect built-in scope: offline_access	openid-connect
8bc2ec46-3c26-47aa-b445-1b31dbb400e6	phone	Otus-Spring-Diploma	OpenID Connect built-in scope: phone	openid-connect
94d347ad-7791-47f8-bc14-3c6286243fa7	profile	Otus-Spring-Diploma	OpenID Connect built-in scope: profile	openid-connect
e408449d-1f74-415e-8bef-fc66c79b231e	role_list	Otus-Spring-Diploma	SAML role list	saml
ca32d76a-1218-4a90-a317-01ca74a200e9	roles	Otus-Spring-Diploma	OpenID Connect scope for add user roles to the access token	openid-connect
b7ad2332-0f21-4529-a60b-9067ed73bfbe	web-origins	Otus-Spring-Diploma	OpenID Connect scope for add allowed web origins to the access token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
1c513f33-5fb5-4038-b957-561791dbedac	${offlineAccessScopeConsentText}	consent.screen.text
1c513f33-5fb5-4038-b957-561791dbedac	true	display.on.consent.screen
6dc1744a-5323-4d89-b352-fe8f1535d454	${samlRoleListScopeConsentText}	consent.screen.text
6dc1744a-5323-4d89-b352-fe8f1535d454	true	display.on.consent.screen
d0f20974-aa2a-4b6b-bc93-8f338b2306e0	${profileScopeConsentText}	consent.screen.text
d0f20974-aa2a-4b6b-bc93-8f338b2306e0	true	include.in.token.scope
d0f20974-aa2a-4b6b-bc93-8f338b2306e0	true	display.on.consent.screen
3c006cd6-cd36-4f04-8342-b8361ba88f03	${emailScopeConsentText}	consent.screen.text
3c006cd6-cd36-4f04-8342-b8361ba88f03	true	include.in.token.scope
3c006cd6-cd36-4f04-8342-b8361ba88f03	true	display.on.consent.screen
375a7938-f9a6-4ea7-9f02-f12f79d00eb1	${addressScopeConsentText}	consent.screen.text
375a7938-f9a6-4ea7-9f02-f12f79d00eb1	true	include.in.token.scope
375a7938-f9a6-4ea7-9f02-f12f79d00eb1	true	display.on.consent.screen
97c0174c-bc25-4fb2-bc1a-e5d37abdd879	${phoneScopeConsentText}	consent.screen.text
97c0174c-bc25-4fb2-bc1a-e5d37abdd879	true	include.in.token.scope
97c0174c-bc25-4fb2-bc1a-e5d37abdd879	true	display.on.consent.screen
1882a27c-4138-4243-8aa2-888d26f0d992	${rolesScopeConsentText}	consent.screen.text
1882a27c-4138-4243-8aa2-888d26f0d992	false	include.in.token.scope
1882a27c-4138-4243-8aa2-888d26f0d992	true	display.on.consent.screen
c415156e-f3c6-40f6-9baf-2ff6de1805ea		consent.screen.text
c415156e-f3c6-40f6-9baf-2ff6de1805ea	false	include.in.token.scope
c415156e-f3c6-40f6-9baf-2ff6de1805ea	false	display.on.consent.screen
01e6ed6c-6949-435c-82d3-3fe8436334f6	${addressScopeConsentText}	consent.screen.text
01e6ed6c-6949-435c-82d3-3fe8436334f6	true	include.in.token.scope
01e6ed6c-6949-435c-82d3-3fe8436334f6	true	display.on.consent.screen
d82a1bdd-2bdd-45fd-a4ca-6c0017188509	${emailScopeConsentText}	consent.screen.text
d82a1bdd-2bdd-45fd-a4ca-6c0017188509	true	include.in.token.scope
d82a1bdd-2bdd-45fd-a4ca-6c0017188509	true	display.on.consent.screen
854d924f-d40f-4a8c-89d7-d9980ee21307	${offlineAccessScopeConsentText}	consent.screen.text
854d924f-d40f-4a8c-89d7-d9980ee21307	true	display.on.consent.screen
8bc2ec46-3c26-47aa-b445-1b31dbb400e6	${phoneScopeConsentText}	consent.screen.text
8bc2ec46-3c26-47aa-b445-1b31dbb400e6	true	include.in.token.scope
8bc2ec46-3c26-47aa-b445-1b31dbb400e6	true	display.on.consent.screen
94d347ad-7791-47f8-bc14-3c6286243fa7	${profileScopeConsentText}	consent.screen.text
94d347ad-7791-47f8-bc14-3c6286243fa7	true	include.in.token.scope
94d347ad-7791-47f8-bc14-3c6286243fa7	true	display.on.consent.screen
e408449d-1f74-415e-8bef-fc66c79b231e	${samlRoleListScopeConsentText}	consent.screen.text
e408449d-1f74-415e-8bef-fc66c79b231e	true	display.on.consent.screen
ca32d76a-1218-4a90-a317-01ca74a200e9	${rolesScopeConsentText}	consent.screen.text
ca32d76a-1218-4a90-a317-01ca74a200e9	false	include.in.token.scope
ca32d76a-1218-4a90-a317-01ca74a200e9	true	display.on.consent.screen
b7ad2332-0f21-4529-a60b-9067ed73bfbe		consent.screen.text
b7ad2332-0f21-4529-a60b-9067ed73bfbe	false	include.in.token.scope
b7ad2332-0f21-4529-a60b-9067ed73bfbe	false	display.on.consent.screen
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
ee8227e9-e506-4a4b-a074-2ada05003136	6dc1744a-5323-4d89-b352-fe8f1535d454	t
d4a0a47d-d658-4e76-a490-1ebf8a1981cf	6dc1744a-5323-4d89-b352-fe8f1535d454	t
a3f63db2-b9ae-4fa2-b549-8ad678d69efe	6dc1744a-5323-4d89-b352-fe8f1535d454	t
55e3b562-dfc2-4b59-ab66-f5a5753a8cba	6dc1744a-5323-4d89-b352-fe8f1535d454	t
bbc2d41f-3582-452a-a94c-16a1819a1cdb	6dc1744a-5323-4d89-b352-fe8f1535d454	t
ee8227e9-e506-4a4b-a074-2ada05003136	d0f20974-aa2a-4b6b-bc93-8f338b2306e0	t
ee8227e9-e506-4a4b-a074-2ada05003136	3c006cd6-cd36-4f04-8342-b8361ba88f03	t
ee8227e9-e506-4a4b-a074-2ada05003136	1882a27c-4138-4243-8aa2-888d26f0d992	t
ee8227e9-e506-4a4b-a074-2ada05003136	c415156e-f3c6-40f6-9baf-2ff6de1805ea	t
ee8227e9-e506-4a4b-a074-2ada05003136	1c513f33-5fb5-4038-b957-561791dbedac	f
ee8227e9-e506-4a4b-a074-2ada05003136	375a7938-f9a6-4ea7-9f02-f12f79d00eb1	f
ee8227e9-e506-4a4b-a074-2ada05003136	97c0174c-bc25-4fb2-bc1a-e5d37abdd879	f
d4a0a47d-d658-4e76-a490-1ebf8a1981cf	d0f20974-aa2a-4b6b-bc93-8f338b2306e0	t
d4a0a47d-d658-4e76-a490-1ebf8a1981cf	3c006cd6-cd36-4f04-8342-b8361ba88f03	t
d4a0a47d-d658-4e76-a490-1ebf8a1981cf	1882a27c-4138-4243-8aa2-888d26f0d992	t
d4a0a47d-d658-4e76-a490-1ebf8a1981cf	c415156e-f3c6-40f6-9baf-2ff6de1805ea	t
d4a0a47d-d658-4e76-a490-1ebf8a1981cf	1c513f33-5fb5-4038-b957-561791dbedac	f
d4a0a47d-d658-4e76-a490-1ebf8a1981cf	375a7938-f9a6-4ea7-9f02-f12f79d00eb1	f
d4a0a47d-d658-4e76-a490-1ebf8a1981cf	97c0174c-bc25-4fb2-bc1a-e5d37abdd879	f
a3f63db2-b9ae-4fa2-b549-8ad678d69efe	d0f20974-aa2a-4b6b-bc93-8f338b2306e0	t
a3f63db2-b9ae-4fa2-b549-8ad678d69efe	3c006cd6-cd36-4f04-8342-b8361ba88f03	t
a3f63db2-b9ae-4fa2-b549-8ad678d69efe	1882a27c-4138-4243-8aa2-888d26f0d992	t
a3f63db2-b9ae-4fa2-b549-8ad678d69efe	c415156e-f3c6-40f6-9baf-2ff6de1805ea	t
a3f63db2-b9ae-4fa2-b549-8ad678d69efe	1c513f33-5fb5-4038-b957-561791dbedac	f
a3f63db2-b9ae-4fa2-b549-8ad678d69efe	375a7938-f9a6-4ea7-9f02-f12f79d00eb1	f
a3f63db2-b9ae-4fa2-b549-8ad678d69efe	97c0174c-bc25-4fb2-bc1a-e5d37abdd879	f
55e3b562-dfc2-4b59-ab66-f5a5753a8cba	d0f20974-aa2a-4b6b-bc93-8f338b2306e0	t
55e3b562-dfc2-4b59-ab66-f5a5753a8cba	3c006cd6-cd36-4f04-8342-b8361ba88f03	t
55e3b562-dfc2-4b59-ab66-f5a5753a8cba	1882a27c-4138-4243-8aa2-888d26f0d992	t
55e3b562-dfc2-4b59-ab66-f5a5753a8cba	c415156e-f3c6-40f6-9baf-2ff6de1805ea	t
55e3b562-dfc2-4b59-ab66-f5a5753a8cba	1c513f33-5fb5-4038-b957-561791dbedac	f
55e3b562-dfc2-4b59-ab66-f5a5753a8cba	375a7938-f9a6-4ea7-9f02-f12f79d00eb1	f
55e3b562-dfc2-4b59-ab66-f5a5753a8cba	97c0174c-bc25-4fb2-bc1a-e5d37abdd879	f
bbc2d41f-3582-452a-a94c-16a1819a1cdb	d0f20974-aa2a-4b6b-bc93-8f338b2306e0	t
bbc2d41f-3582-452a-a94c-16a1819a1cdb	3c006cd6-cd36-4f04-8342-b8361ba88f03	t
bbc2d41f-3582-452a-a94c-16a1819a1cdb	1882a27c-4138-4243-8aa2-888d26f0d992	t
bbc2d41f-3582-452a-a94c-16a1819a1cdb	c415156e-f3c6-40f6-9baf-2ff6de1805ea	t
bbc2d41f-3582-452a-a94c-16a1819a1cdb	1c513f33-5fb5-4038-b957-561791dbedac	f
bbc2d41f-3582-452a-a94c-16a1819a1cdb	375a7938-f9a6-4ea7-9f02-f12f79d00eb1	f
bbc2d41f-3582-452a-a94c-16a1819a1cdb	97c0174c-bc25-4fb2-bc1a-e5d37abdd879	f
02c5fa32-6078-4f18-b244-4acda5694bc9	6dc1744a-5323-4d89-b352-fe8f1535d454	t
02c5fa32-6078-4f18-b244-4acda5694bc9	d0f20974-aa2a-4b6b-bc93-8f338b2306e0	t
02c5fa32-6078-4f18-b244-4acda5694bc9	3c006cd6-cd36-4f04-8342-b8361ba88f03	t
02c5fa32-6078-4f18-b244-4acda5694bc9	1882a27c-4138-4243-8aa2-888d26f0d992	t
02c5fa32-6078-4f18-b244-4acda5694bc9	c415156e-f3c6-40f6-9baf-2ff6de1805ea	t
02c5fa32-6078-4f18-b244-4acda5694bc9	1c513f33-5fb5-4038-b957-561791dbedac	f
02c5fa32-6078-4f18-b244-4acda5694bc9	375a7938-f9a6-4ea7-9f02-f12f79d00eb1	f
02c5fa32-6078-4f18-b244-4acda5694bc9	97c0174c-bc25-4fb2-bc1a-e5d37abdd879	f
09c74bad-b814-4850-987a-a4abf16743f3	b7ad2332-0f21-4529-a60b-9067ed73bfbe	t
09c74bad-b814-4850-987a-a4abf16743f3	e408449d-1f74-415e-8bef-fc66c79b231e	t
09c74bad-b814-4850-987a-a4abf16743f3	94d347ad-7791-47f8-bc14-3c6286243fa7	t
09c74bad-b814-4850-987a-a4abf16743f3	ca32d76a-1218-4a90-a317-01ca74a200e9	t
09c74bad-b814-4850-987a-a4abf16743f3	d82a1bdd-2bdd-45fd-a4ca-6c0017188509	t
09c74bad-b814-4850-987a-a4abf16743f3	01e6ed6c-6949-435c-82d3-3fe8436334f6	f
09c74bad-b814-4850-987a-a4abf16743f3	8bc2ec46-3c26-47aa-b445-1b31dbb400e6	f
09c74bad-b814-4850-987a-a4abf16743f3	854d924f-d40f-4a8c-89d7-d9980ee21307	f
0e68a51d-b4ef-4bbe-af1f-3ecb481e8014	b7ad2332-0f21-4529-a60b-9067ed73bfbe	t
0e68a51d-b4ef-4bbe-af1f-3ecb481e8014	e408449d-1f74-415e-8bef-fc66c79b231e	t
0e68a51d-b4ef-4bbe-af1f-3ecb481e8014	94d347ad-7791-47f8-bc14-3c6286243fa7	t
0e68a51d-b4ef-4bbe-af1f-3ecb481e8014	ca32d76a-1218-4a90-a317-01ca74a200e9	t
0e68a51d-b4ef-4bbe-af1f-3ecb481e8014	d82a1bdd-2bdd-45fd-a4ca-6c0017188509	t
0e68a51d-b4ef-4bbe-af1f-3ecb481e8014	01e6ed6c-6949-435c-82d3-3fe8436334f6	f
0e68a51d-b4ef-4bbe-af1f-3ecb481e8014	8bc2ec46-3c26-47aa-b445-1b31dbb400e6	f
0e68a51d-b4ef-4bbe-af1f-3ecb481e8014	854d924f-d40f-4a8c-89d7-d9980ee21307	f
f215e460-e572-42ec-8b6b-f1c6ad3d188b	b7ad2332-0f21-4529-a60b-9067ed73bfbe	t
f215e460-e572-42ec-8b6b-f1c6ad3d188b	e408449d-1f74-415e-8bef-fc66c79b231e	t
f215e460-e572-42ec-8b6b-f1c6ad3d188b	94d347ad-7791-47f8-bc14-3c6286243fa7	t
f215e460-e572-42ec-8b6b-f1c6ad3d188b	ca32d76a-1218-4a90-a317-01ca74a200e9	t
f215e460-e572-42ec-8b6b-f1c6ad3d188b	d82a1bdd-2bdd-45fd-a4ca-6c0017188509	t
f215e460-e572-42ec-8b6b-f1c6ad3d188b	01e6ed6c-6949-435c-82d3-3fe8436334f6	f
f215e460-e572-42ec-8b6b-f1c6ad3d188b	8bc2ec46-3c26-47aa-b445-1b31dbb400e6	f
f215e460-e572-42ec-8b6b-f1c6ad3d188b	854d924f-d40f-4a8c-89d7-d9980ee21307	f
fd166d3d-9182-4594-bdaa-ed9a8ff4645b	b7ad2332-0f21-4529-a60b-9067ed73bfbe	t
fd166d3d-9182-4594-bdaa-ed9a8ff4645b	e408449d-1f74-415e-8bef-fc66c79b231e	t
fd166d3d-9182-4594-bdaa-ed9a8ff4645b	94d347ad-7791-47f8-bc14-3c6286243fa7	t
fd166d3d-9182-4594-bdaa-ed9a8ff4645b	ca32d76a-1218-4a90-a317-01ca74a200e9	t
fd166d3d-9182-4594-bdaa-ed9a8ff4645b	d82a1bdd-2bdd-45fd-a4ca-6c0017188509	t
fd166d3d-9182-4594-bdaa-ed9a8ff4645b	01e6ed6c-6949-435c-82d3-3fe8436334f6	f
fd166d3d-9182-4594-bdaa-ed9a8ff4645b	8bc2ec46-3c26-47aa-b445-1b31dbb400e6	f
fd166d3d-9182-4594-bdaa-ed9a8ff4645b	854d924f-d40f-4a8c-89d7-d9980ee21307	f
b5a9dec5-70dd-4a5b-9664-e79093420f4a	b7ad2332-0f21-4529-a60b-9067ed73bfbe	t
b5a9dec5-70dd-4a5b-9664-e79093420f4a	e408449d-1f74-415e-8bef-fc66c79b231e	t
b5a9dec5-70dd-4a5b-9664-e79093420f4a	94d347ad-7791-47f8-bc14-3c6286243fa7	t
b5a9dec5-70dd-4a5b-9664-e79093420f4a	ca32d76a-1218-4a90-a317-01ca74a200e9	t
b5a9dec5-70dd-4a5b-9664-e79093420f4a	d82a1bdd-2bdd-45fd-a4ca-6c0017188509	t
b5a9dec5-70dd-4a5b-9664-e79093420f4a	01e6ed6c-6949-435c-82d3-3fe8436334f6	f
b5a9dec5-70dd-4a5b-9664-e79093420f4a	8bc2ec46-3c26-47aa-b445-1b31dbb400e6	f
b5a9dec5-70dd-4a5b-9664-e79093420f4a	854d924f-d40f-4a8c-89d7-d9980ee21307	f
79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	b7ad2332-0f21-4529-a60b-9067ed73bfbe	t
79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	e408449d-1f74-415e-8bef-fc66c79b231e	t
79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	94d347ad-7791-47f8-bc14-3c6286243fa7	t
79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	ca32d76a-1218-4a90-a317-01ca74a200e9	t
79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	d82a1bdd-2bdd-45fd-a4ca-6c0017188509	t
79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	01e6ed6c-6949-435c-82d3-3fe8436334f6	f
79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	8bc2ec46-3c26-47aa-b445-1b31dbb400e6	f
79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	854d924f-d40f-4a8c-89d7-d9980ee21307	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
1c513f33-5fb5-4038-b957-561791dbedac	d0df72d9-c784-4792-ad32-8fa347b50921
854d924f-d40f-4a8c-89d7-d9980ee21307	2bb2a8ac-36af-4b1f-8117-0ffdbc072ef0
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
0f6ba807-1877-4248-af53-03067b18b203	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
99cb2a26-9950-4ae1-bc01-531a89ada711	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
f6549f87-a8da-4485-8d97-eaeee02c9c00	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
28f91da3-9997-49f1-840d-3749e924f68d	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
f8ceb0f9-e6dc-4efd-9279-1a9ec8630d0b	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
7636965a-d5de-468b-8caf-bded6b5cb155	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
7089cca9-2432-4377-9291-71647d348142	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
a5464d3a-01fe-4b00-b5f8-fac61f807583	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
741f7ac2-00e9-4ff1-a28d-8a2101a21634	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
af6195d2-102e-456b-a7bc-433be5b17c0c	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
73be6c94-9f0d-47f8-903c-da174e1b8237	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
43cf5e97-6b0b-4b9f-9988-291182c3db96	Full Scope Disabled	Otus-Spring-Diploma	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Otus-Spring-Diploma	anonymous
dae4b417-3f6d-46bf-a155-f9cd7499a338	Trusted Hosts	Otus-Spring-Diploma	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Otus-Spring-Diploma	anonymous
ef587c63-ea37-4743-bb0b-fdaed6ca95fa	Allowed Protocol Mapper Types	Otus-Spring-Diploma	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Otus-Spring-Diploma	anonymous
33f1a5d5-6187-47c5-8868-762ca7247ef9	Allowed Client Scopes	Otus-Spring-Diploma	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Otus-Spring-Diploma	anonymous
c11d8513-63c8-4b6e-a51f-e622c92c0afe	Max Clients Limit	Otus-Spring-Diploma	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Otus-Spring-Diploma	anonymous
c29d0191-04e7-4604-8af8-f8f2001e5d86	Allowed Protocol Mapper Types	Otus-Spring-Diploma	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Otus-Spring-Diploma	authenticated
3b39b00c-7fa5-41c2-af3c-f526f23b3b81	Allowed Client Scopes	Otus-Spring-Diploma	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Otus-Spring-Diploma	authenticated
77032cc3-bd4b-485f-a061-2e3e63b2f5b8	Consent Required	Otus-Spring-Diploma	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	Otus-Spring-Diploma	anonymous
68165c99-2b09-4809-ac65-e940dfca0e1e	hmac-generated	Otus-Spring-Diploma	hmac-generated	org.keycloak.keys.KeyProvider	Otus-Spring-Diploma	\N
2918a417-7d5c-405f-8d60-2454d3e51387	rsa-generated	Otus-Spring-Diploma	rsa-generated	org.keycloak.keys.KeyProvider	Otus-Spring-Diploma	\N
a3f03796-9834-47eb-a912-4eb54bebfe02	aes-generated	Otus-Spring-Diploma	aes-generated	org.keycloak.keys.KeyProvider	Otus-Spring-Diploma	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
539e5705-3034-45a9-a2be-869104a06cbe	a5464d3a-01fe-4b00-b5f8-fac61f807583	allow-default-scopes	true
9652c944-7eae-442a-bdcc-f668ccb92290	7089cca9-2432-4377-9291-71647d348142	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5f7f29e5-91b0-45d5-b766-96e1128fe13a	7089cca9-2432-4377-9291-71647d348142	allowed-protocol-mapper-types	oidc-address-mapper
ae2553b8-ee71-4209-b2b5-f85b279eea41	7089cca9-2432-4377-9291-71647d348142	allowed-protocol-mapper-types	saml-user-attribute-mapper
fe1349a0-3b54-4a9d-861d-ac9f601f2cf8	7089cca9-2432-4377-9291-71647d348142	allowed-protocol-mapper-types	saml-role-list-mapper
76a43a4c-d327-40ff-b852-84a7b9b6e237	7089cca9-2432-4377-9291-71647d348142	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
09c9b46c-e661-43d5-8dec-ccf64bbc5bbc	7089cca9-2432-4377-9291-71647d348142	allowed-protocol-mapper-types	saml-user-property-mapper
5bb6be6c-71c0-4d1e-afbf-ff36b63379bd	7089cca9-2432-4377-9291-71647d348142	allowed-protocol-mapper-types	oidc-full-name-mapper
591710c7-e2f0-4d76-a5f3-182baadeb6f5	7089cca9-2432-4377-9291-71647d348142	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
8a0ccba8-2a93-4303-a078-eb4bf9f14d3c	0f6ba807-1877-4248-af53-03067b18b203	host-sending-registration-request-must-match	true
88fb886c-cb20-4774-966a-f1880df5bfe8	0f6ba807-1877-4248-af53-03067b18b203	client-uris-must-match	true
9594f6e5-338f-4db8-8e8a-45ff8dd40aa6	7636965a-d5de-468b-8caf-bded6b5cb155	allow-default-scopes	true
95372c0a-4953-42c2-a0bf-87e5b070f345	f8ceb0f9-e6dc-4efd-9279-1a9ec8630d0b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ec12d3f9-521f-40ba-9351-840a24db34c6	f8ceb0f9-e6dc-4efd-9279-1a9ec8630d0b	allowed-protocol-mapper-types	oidc-address-mapper
6947a458-70fe-4dbc-bbf8-6ca72b34c4e6	f8ceb0f9-e6dc-4efd-9279-1a9ec8630d0b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
c7257426-fee7-4c75-82b1-fc79b85beff5	f8ceb0f9-e6dc-4efd-9279-1a9ec8630d0b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b84b114d-4e8c-41e8-9262-0a5a00083193	f8ceb0f9-e6dc-4efd-9279-1a9ec8630d0b	allowed-protocol-mapper-types	saml-role-list-mapper
b5636b7c-43a3-41cc-91f1-db86feec3530	f8ceb0f9-e6dc-4efd-9279-1a9ec8630d0b	allowed-protocol-mapper-types	saml-user-attribute-mapper
8698c1d3-101a-480a-81b9-44aa05b32a8f	f8ceb0f9-e6dc-4efd-9279-1a9ec8630d0b	allowed-protocol-mapper-types	oidc-full-name-mapper
a7e3c538-1ccb-4bc0-b2aa-05538ec288b0	f8ceb0f9-e6dc-4efd-9279-1a9ec8630d0b	allowed-protocol-mapper-types	saml-user-property-mapper
cddd31af-f645-4a81-838a-4ca5b3eec12d	28f91da3-9997-49f1-840d-3749e924f68d	max-clients	200
4337e5ce-4435-4229-95ba-32330ad7be9d	af6195d2-102e-456b-a7bc-433be5b17c0c	kid	98532a28-37d7-4e6e-8b81-b9cb05ec86dc
546c0b8a-2249-4c8a-a109-a8a0efd5809f	af6195d2-102e-456b-a7bc-433be5b17c0c	algorithm	HS256
0ed10cd2-be54-4fe8-b85d-757ee0537466	af6195d2-102e-456b-a7bc-433be5b17c0c	secret	mPES9Hd204B4maTFbqp15jrNTR3koFvQXm3AzvmszJvij9Dj_QUZg5XSsldT3MpaORf77ek20hdesempGh1-VQ
9da21a10-98d6-49b8-9d07-4a8a113af741	af6195d2-102e-456b-a7bc-433be5b17c0c	priority	100
09dd4937-22b4-4633-9f67-2f7e6ac9bd10	73be6c94-9f0d-47f8-903c-da174e1b8237	secret	xdWwiqspPTjQWqIUJpA21g
43a9110c-72e1-4e07-9714-bf929f695af3	73be6c94-9f0d-47f8-903c-da174e1b8237	kid	9e1bc35b-b35c-49b3-a702-7d3910adfd14
74bc51aa-b94b-460d-8728-401bf23e8b6f	73be6c94-9f0d-47f8-903c-da174e1b8237	priority	100
617663f0-ef9b-4675-8913-41153cc2d186	741f7ac2-00e9-4ff1-a28d-8a2101a21634	certificate	MIICmzCCAYMCBgFnS2YUsDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMTgxMTI1MTUwMjIwWhcNMjgxMTI1MTUwNDAwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCV+mYP0324+e8kBbley0GzaNTYnYG/8qIEaCaDLYEFn3uSgRc5LFxfC2EQSBTiEu/0iqq1ItG6izAtBbHS0irU6Uo/6SiGypJoekZCAsjM/BVBXT6DjkB1QrpbPa5AiBxU/M3DdrNpIPuU/2LKuidKLkN7WTr33NigdHQ2gMAwUYxjPO/rmmYQQo+R6bKTIW4mbc9MdejXahnvtiC3HSGWfceHebpOBg0/rNXKlEBFb+UbsHxfTNAda8kjTd7llzdx6f0TpUSYceG8lygII0f9WUKsa+LePYZvkmzY1cx9B2tEgaybhJBlX9lrgteNORse2CO4DoogzuK18xy57MKnAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEUtrQ8tXpXHD1vldbvxJ5uz3IwH/oM9qRWZShHtsgtvn4lEbE1QjqbyGwC1p6Voh6mFQUwj1mn82d4LurpV7uSn958XOSbFmt0g+Z5KkT5D0NXIKKenObL8DJA/gWMaSDSTKa71iIoK8oxHZja7iG1GXyiFPg2BctM3LExDFOX4e5MEjPkZg3qubSrhne8V86C/mA1G6NTYfIZVDJWFV7t8xznsMcgLbb8PRtD/qxTY6+H9R7k8azfU5Yatnj0DsbZZF4RhtM51lAyYWyUxqFgmMXKAsgDITT/SFWg5EHUhz945bsHmol+iJSJpS4aVe13ZVO033YXj9yiko4logAQ=
96cc9d09-e3f4-4ef1-9eff-15049f408cb3	741f7ac2-00e9-4ff1-a28d-8a2101a21634	privateKey	MIIEogIBAAKCAQEAlfpmD9N9uPnvJAW5XstBs2jU2J2Bv/KiBGgmgy2BBZ97koEXOSxcXwthEEgU4hLv9IqqtSLRuoswLQWx0tIq1OlKP+kohsqSaHpGQgLIzPwVQV0+g45AdUK6Wz2uQIgcVPzNw3azaSD7lP9iyronSi5De1k699zYoHR0NoDAMFGMYzzv65pmEEKPkemykyFuJm3PTHXo12oZ77Ygtx0hln3Hh3m6TgYNP6zVypRARW/lG7B8X0zQHWvJI03e5Zc3cen9E6VEmHHhvJcoCCNH/VlCrGvi3j2Gb5Js2NXMfQdrRIGsm4SQZV/Za4LXjTkbHtgjuA6KIM7itfMcuezCpwIDAQABAoIBADyrSUQXqqD8QdfRlPYaxN4dhxSFSqpqLU4ZD5M7AhlTNXrDS7CuGEO+Z6pdbk0xme3TdlDF4A9VJMzho9iDeh4crRODbwhvw6AN7oPfenkpdDO304UGM177+kTUg7vJE6Txiw8J4nOhiwPv93fIrAIfCt9H7km8BcmKskQl+xjQFWeC6fIfI7zT1UkCjpsfIWY1vv8CO9Uy2dWz8yUgaeb5JIgiXEOryeO9FT8oQj8SMughdXWeKwm/xQYfbIusLZFYALqgsaCw7CU9UUfrrt6jokMrtJX7E24SKgWazLFXlMxpuacfx+BbdALVTuWGSAvpelQakQQmnQ4dHS03GFkCgYEA0ChDLBorGarOBPwVbCVCayEsyzw37buRIrsZj1SCHKV1mRhiWb47Sz2OivFXUVT7p9R0LK1q1eQX4iai6sdpmCznlPmmg8ijUu00J4oLC+lweKSBPhbkMZATr5JQH6x+o11wtmKTNbNglgd8aVxrXmRMV3vWNerMspaBeIZ60hsCgYEAuHLw3fKpWB6U5hS0rGxAXL6FCIll+qaX4aMyyyOhhwTMURGUgCW52BjSGpB94NGHsnl0cCYwCH8xhKXGhBzboyMA+g+mKcXTlyRZQO1dh+MGIE2FHnO1cI5xhNYTUktezaN3dDDz6cg0HmAGOHlPxibFBOSoN1TdPaAETyd1emUCgYBHH8q78gESFxun9l53gk+sfTxqARx3HaTcwiNcpxqCIUMKWZuZYHewIMtozEfyoWAPm3dKoMKlbPeALYVzRUneVlGWxKrR0qeDuUsdy3w0yMHGZydGCNpV2Q3w6sR33h+zQEU3/HyiV7VD7jDja1HAgfLX3Zd2+tCQoP6CKSkkSwKBgGzwHgjIUHJmJYU6h3cqvFzKfaIMHHoMuLmgfNhzo+wtzkq3OmDxZzEVf8oGuwH0XtPvXfD67PWnweRZUMUokiRpASOv6HDVkWG8Kyboyov+btjXUB8rMedXif5tvZ2mPEjyGhQ68WSLRRUHm8TxCUe8EDMSpbOAYOcLwl/Jq13tAoGASvu22W1E8n60Ss5z7pe60Tg26I9Ikb6mtYu6G4pS6FCIa9sF1KYUU65nKtNtLE5yUwrKETJ8SQKyZ13R4sOwx6gbcZdwUrr0wxYxLTvcfNxXWxlm8U6LuFzuUZlztlcLJ/I1B3Q6Z1goWtkiBTE7wPb/pAQ6b/0RPhVNKmqe1I4=
7e077659-6607-4eb3-8ae6-c1dee48fc22a	741f7ac2-00e9-4ff1-a28d-8a2101a21634	priority	100
4bd98b6c-0fa2-45c9-8387-20880d6ab3ee	dae4b417-3f6d-46bf-a155-f9cd7499a338	client-uris-must-match	true
87dc27a5-a522-4aa4-9f4a-a29ad4a931fb	dae4b417-3f6d-46bf-a155-f9cd7499a338	host-sending-registration-request-must-match	true
99d1320e-4064-4f50-9b0f-620d4371e49b	ef587c63-ea37-4743-bb0b-fdaed6ca95fa	allowed-protocol-mapper-types	saml-user-attribute-mapper
092070ec-69b7-4a17-b070-3bc061ce5949	ef587c63-ea37-4743-bb0b-fdaed6ca95fa	allowed-protocol-mapper-types	oidc-full-name-mapper
5fc7fc41-e1c7-4410-883a-d6f5da801bb5	ef587c63-ea37-4743-bb0b-fdaed6ca95fa	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3022a1eb-ecce-4807-940d-3f8f0fd694c5	ef587c63-ea37-4743-bb0b-fdaed6ca95fa	allowed-protocol-mapper-types	saml-user-property-mapper
5bad15ad-0055-4e95-8e57-677c2518767b	ef587c63-ea37-4743-bb0b-fdaed6ca95fa	allowed-protocol-mapper-types	saml-role-list-mapper
e0c41d96-b4fa-46fa-9f64-cf09a7fb987d	ef587c63-ea37-4743-bb0b-fdaed6ca95fa	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
003721a3-a478-4dda-9635-fa8d45b1721f	ef587c63-ea37-4743-bb0b-fdaed6ca95fa	allowed-protocol-mapper-types	oidc-address-mapper
2ef3f93c-76a1-4d14-bac7-8f17d0c8979a	ef587c63-ea37-4743-bb0b-fdaed6ca95fa	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
45951e63-2eec-4d43-b66b-07675c504430	33f1a5d5-6187-47c5-8868-762ca7247ef9	allow-default-scopes	true
632ed7d4-63cc-4b10-af97-cc4475c2ba37	c11d8513-63c8-4b6e-a51f-e622c92c0afe	max-clients	200
9f155c43-f5bf-491d-9029-08c548e0f866	68165c99-2b09-4809-ac65-e940dfca0e1e	priority	100
8dec7483-45d8-46d2-aad5-12559ac2a476	68165c99-2b09-4809-ac65-e940dfca0e1e	algorithm	HS256
4dcacfa6-644a-44a5-bf95-8854aa6c649e	68165c99-2b09-4809-ac65-e940dfca0e1e	secret	ZUHVp-eZSrTtVP-w3nHDrdGJJ7VPVwqtrabQjx2HRM0Yy6EB4vWvRJM7hPCyRt0NtkaOz7kj6d8RULHy-_8E6Q
7d052766-aaa7-496d-9466-67b4b260320c	68165c99-2b09-4809-ac65-e940dfca0e1e	kid	100b1f0b-3626-45a1-9226-cd2b806069c8
05853e46-b22c-4943-9bd1-a096ce3ad35b	c29d0191-04e7-4604-8af8-f8f2001e5d86	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a0d37ceb-bc58-4984-9715-32add3c7ed00	c29d0191-04e7-4604-8af8-f8f2001e5d86	allowed-protocol-mapper-types	oidc-full-name-mapper
7d6ce58b-9af3-4e36-a8fe-dbf1675d73de	c29d0191-04e7-4604-8af8-f8f2001e5d86	allowed-protocol-mapper-types	saml-user-attribute-mapper
4af679dc-0332-40f4-b74c-862a9d915ea4	c29d0191-04e7-4604-8af8-f8f2001e5d86	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
39c1e9ce-fd3e-49b0-88dc-cdf80813ab2f	c29d0191-04e7-4604-8af8-f8f2001e5d86	allowed-protocol-mapper-types	saml-user-property-mapper
5c1929aa-e60a-462c-b115-5328e7df13ff	c29d0191-04e7-4604-8af8-f8f2001e5d86	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
eb0a3b06-f04a-463d-9183-6584be64832a	c29d0191-04e7-4604-8af8-f8f2001e5d86	allowed-protocol-mapper-types	saml-role-list-mapper
70c21c6b-8226-41a4-9041-fee20fec7891	c29d0191-04e7-4604-8af8-f8f2001e5d86	allowed-protocol-mapper-types	oidc-address-mapper
45435ebb-b66d-4ae9-87fb-e1ef05f4ebe2	3b39b00c-7fa5-41c2-af3c-f526f23b3b81	allow-default-scopes	true
892f5655-bf6e-4529-bd0e-593b7ba1287a	2918a417-7d5c-405f-8d60-2454d3e51387	privateKey	MIIEpQIBAAKCAQEA5HQ43C9mmKH4UfnVQzHWA63oPymSVqiqGHIFBxDB6bjglHQPxu2t/zJY9Aaw3vJzThNsNzeNoc7iJLK9uL9/AFUNJ9Xf4AfWjd+W6oWxI6RTY43CFMd2QISPSBp40rNKx8EhQTspRWR/EYBEYLtuAzutbe+oyi6vDxn/C5a1qkZ/jKQYulkxrB04s7/b5UUhD6z6MvYuxQp40PXR2eofFHc6zm1fLltOnQpJ5zTu5zQb6xqLA7Sy7YmyWTMArOZhLbCjHvJ9h21y1mjFQAx4ZkUQvP1+gThIeFycXVAz+HPjNvIn+m69OIIQwhkV3mZtnOnBmBZ0Bx9K2nO4oOeeVwIDAQABAoIBAQChgC/6KGBFIqujeBR1bjO3Yie/DypurMmigmhfeE89ZP8Os4W7waaxs+wChwBee9NbrIth9Znge5qPCvToOCgWGgo00RN1EtVwclID9QMnCTISPNKpUeCc95k7BcvIWAtTb4qMzL/+WG8j9iNgpt+81WFjSHtwgtQqvtv4W1CNz/Z24hKBuScHQfzTmM2yHrnyuTGkQvVbZiGLvsZT9p5qceM1FbY2fvwyFFdLjRc93zOBu/wyFc62GYch0Wkt+RuCSZfULj6IFrR53J4H36sEYnWFDOfF3VSxPHB7P8fWdx/JhFJnf+1wE9gKX9hkFE0koZQUBmv6TvqceabPuuehAoGBAPyjzFFT+TehUiI6eCkNZPWcrQATKWsHuYXbt5ix6eegQSiWNVqZnZiVDJL/5PoCkJShP04o1MrRzonSzYa8rJH6ZaBCrd3zr+qPjHRVqqraI4Hrm5l8VLWI0xgH4CYhkmzRm0Vp/rbcbIzET35AcUm+5gqlYSOlk+p5wUYM4u25AoGBAOd+EyCBqX7zvvx+qf3R+6okh8hdJw39gQ+A+NrRy+53W+8xcHtsiph8UAQQNeTDoGS0Svnwmed9btq01JFs7OsV9QhU/Y98Gy07+Bw+N7+UFGsola/TXNXQbAMMSeZDiplY3K6JTsnxaUWKQmNg7eUUmm0mkY1sb4LtONsMVXSPAoGBAMFRBTLmMrkitBqE6xVernZSoP6Bqxu/GXMYIXCyEu2ubq2D4uekzDbJNon1TV0RQVi52hsQm2NnD8feim4jSVmaZNEwtKI1qdKubSdHtgRuTuVHSBU2Ugtm20B0JkyHO+gQq+N9q+541IcSYFGXNhjb/mL/EUmZlYnCCOZ1Td/hAoGBAJRoOBzr41z3KOa40YRevUe7ua0TQzlt3vKwjVnDjEjqDm9PM7x8vnG5qJaiSdrKK6bECxknTZOhz5K4wVomCdFAt2FLE2+McePTAWIh5R2V8m0sjKI3D9onj0d49lt/y3g6BuiCMJe4g/PICn2po3nsdoApbMDM1sSKDpwn0RUzAoGAbgs5rdnHX+bO9Nj4jd5GbE1KMz8yea96JD80zlr8V1spPJdC+PRBatDvwfGNKHAfF99nXQQZjyU4rUYHC6HUCm2uafyNZxcwm3BIbHCQGpyd1m1P9ylSqavfrKahXzkN585f6lGHYTSNmMqdIUtl/iqNmGZ4yAvDUV6n9m3h1TA=
392559df-0dfa-44b0-a7cd-347dca52a00d	2918a417-7d5c-405f-8d60-2454d3e51387	priority	100
ab7cea0b-83d4-4935-a32b-8979a8d0c344	2918a417-7d5c-405f-8d60-2454d3e51387	certificate	MIICtTCCAZ0CBgFnS2YaUTANBgkqhkiG9w0BAQsFADAeMRwwGgYDVQQDDBNPdHVzLVNwcmluZy1EaXBsb21hMB4XDTE4MTEyNTE1MDIyMVoXDTI4MTEyNTE1MDQwMVowHjEcMBoGA1UEAwwTT3R1cy1TcHJpbmctRGlwbG9tYTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOR0ONwvZpih+FH51UMx1gOt6D8pklaoqhhyBQcQwem44JR0D8btrf8yWPQGsN7yc04TbDc3jaHO4iSyvbi/fwBVDSfV3+AH1o3fluqFsSOkU2ONwhTHdkCEj0gaeNKzSsfBIUE7KUVkfxGARGC7bgM7rW3vqMourw8Z/wuWtapGf4ykGLpZMawdOLO/2+VFIQ+s+jL2LsUKeND10dnqHxR3Os5tXy5bTp0KSec07uc0G+saiwO0su2JslkzAKzmYS2wox7yfYdtctZoxUAMeGZFELz9foE4SHhcnF1QM/hz4zbyJ/puvTiCEMIZFd5mbZzpwZgWdAcfStpzuKDnnlcCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEARTZA0wN628vKm3S7R9E2+41aK5s58EB71pO6CAcMkyhrSHwYONmk9ss5O7MNvzPEXhOFVUnbn6wEMiTrVHUlkht1aWA/46YBVDyks1Ng+dpd92s24zhed05Z6mDJcWkT5LgOp6kTF/drhXFRqXtXvOVNWJt2KHsRBtoXU+2SUXU3wBrXAWWdCuyAkFfa90YFhaE1hVzn3R75f3bzfhZyb83qy1kzD18NDSRLwTpvOlpPGDB8OOq+82peaqRMbWMrc78xb7dlxaJtwdfpPi/YZejxEl2ASHF7wXHCQUu05GGsgQc9VctkRKM1OFVKzGRtOUrBPxBAC9QptRKdPf/4ig==
b8a0cd75-5c96-4e92-8ab2-e55e2d7427d0	a3f03796-9834-47eb-a912-4eb54bebfe02	secret	33k6C5bLPRDkXQQjPA-xqQ
877c0093-d5ef-4789-8365-f24683189d4d	a3f03796-9834-47eb-a912-4eb54bebfe02	kid	2a3e0a10-76b9-4599-8965-a38e2d46a60f
04c64caf-8815-4f8f-ab4b-a2a4e1e49e25	a3f03796-9834-47eb-a912-4eb54bebfe02	priority	100
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	e212931e-a989-424e-b0f4-63e39dd09d83
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	32baef07-b0cc-4b04-8de2-64245f6ef42f
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	254910c3-01be-4341-8bcd-76abf8f287f6
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	9c53a1ad-3045-418a-91f5-4322e93a24f2
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	65408fbe-d100-4282-ac9e-dd117db74b4b
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	a94ce264-ee94-4d7a-b6a4-978a0ca9c4e5
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	bd7d6f59-860e-4e2c-abd8-f8d12f3648cd
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	9fc5048d-18eb-4f71-8cf0-1a42f09be818
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	d8964c30-b2dc-46b3-a14b-3ef6a3d70740
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	94166bc6-e754-40aa-b980-9654c6579595
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	fb22a83e-0dfa-4360-9fed-8e406a521681
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	ee8b68e3-2631-4cf9-be1d-c73eb5f5e9a0
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	24352f76-54b0-4be6-b488-e21572377d08
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	3a1b9bf4-7a9f-460b-b2ce-d18fd1f37dd4
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	e4b4bedd-f80a-4667-b12e-b65d4d4e0506
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	7db4700b-4e37-4f94-917d-8b2be80bae08
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	8dd7aa7a-b37c-4c91-adb3-39a0b4dd4e2b
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	bc81d77f-a2a3-45aa-bd88-64323a042ec0
9c53a1ad-3045-418a-91f5-4322e93a24f2	e4b4bedd-f80a-4667-b12e-b65d4d4e0506
9c53a1ad-3045-418a-91f5-4322e93a24f2	bc81d77f-a2a3-45aa-bd88-64323a042ec0
65408fbe-d100-4282-ac9e-dd117db74b4b	7db4700b-4e37-4f94-917d-8b2be80bae08
49edf0fe-4ffe-4be8-8c18-9b0e7393883e	2b023e2c-c8d9-4fc9-a36c-6878b658a917
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	df44d926-69df-45bb-8279-d3634d1d5af8
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	7c8b50cd-9f87-4d55-9a36-790403c7c956
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	b913cc55-63dd-404c-9cc5-4e0359019bdf
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	caa1f0ec-74d1-4bb6-b9de-b6579e3d1345
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	49147d8f-6f48-477f-8560-b04b8e570915
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	3f7c05fa-1b73-4d32-a5c3-ddc9b4dcf554
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	3d1ac122-2183-44b7-bb93-f0852ce81edd
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	f33e330c-fdd8-4b74-ac4c-1111378ca90d
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	4d57e8b9-670a-4164-90be-19a62a66f813
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	cd9a36ab-0317-42c2-a28a-57de66a95e7d
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	8a91b17e-f0cb-4dd8-9271-3a39338d215b
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	50075863-a157-4007-9870-bc93f001de09
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	1e0854f7-c0a0-4a16-b02b-404e0adebbca
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	0b431eb4-0a98-4f29-944a-7960232bc43f
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	643923d8-7ac2-4d7a-8264-9d1334744c94
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	5d353a07-ed2d-4201-98bd-8a8f8fb9e44b
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	2bec8053-7219-456d-9e8d-0e1cec30d608
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	b0aef25d-0c33-4750-b3d3-3dfcac0c0c1f
caa1f0ec-74d1-4bb6-b9de-b6579e3d1345	643923d8-7ac2-4d7a-8264-9d1334744c94
caa1f0ec-74d1-4bb6-b9de-b6579e3d1345	b0aef25d-0c33-4750-b3d3-3dfcac0c0c1f
49147d8f-6f48-477f-8560-b04b8e570915	5d353a07-ed2d-4201-98bd-8a8f8fb9e44b
101e5568-e15e-4121-b4dd-80c753c57d97	dd35ecd5-b45c-4937-b23c-81a13ad5e822
101e5568-e15e-4121-b4dd-80c753c57d97	29c49579-81e6-454e-a059-0cca9699db14
9d8225a7-4d7c-4592-9121-371dc072984b	f44f4aea-ad30-4b28-9887-bf126a2cad9b
6db644e5-c181-4a96-a5a4-f1426dabdbcc	e85b3cbd-b9c0-4b6d-bf75-d4b992c82615
6db644e5-c181-4a96-a5a4-f1426dabdbcc	f2c072d3-cf2e-41e5-b12e-c4e5441871a5
6db644e5-c181-4a96-a5a4-f1426dabdbcc	101e5568-e15e-4121-b4dd-80c753c57d97
6db644e5-c181-4a96-a5a4-f1426dabdbcc	431f0849-5963-4c17-979d-aa1ebd0b79c3
6db644e5-c181-4a96-a5a4-f1426dabdbcc	9d8225a7-4d7c-4592-9121-371dc072984b
6db644e5-c181-4a96-a5a4-f1426dabdbcc	f44f4aea-ad30-4b28-9887-bf126a2cad9b
6db644e5-c181-4a96-a5a4-f1426dabdbcc	6ec652c7-81cc-44c9-b591-487ae293acca
6db644e5-c181-4a96-a5a4-f1426dabdbcc	ae29d3d7-c545-48e3-abe7-ce3b46e3c5bd
6db644e5-c181-4a96-a5a4-f1426dabdbcc	29c49579-81e6-454e-a059-0cca9699db14
6db644e5-c181-4a96-a5a4-f1426dabdbcc	63b89b2f-52bd-46f1-a072-05cda44783a7
6db644e5-c181-4a96-a5a4-f1426dabdbcc	ca8c0164-eb6b-44dd-9ffe-2cc56e44e660
6db644e5-c181-4a96-a5a4-f1426dabdbcc	07749646-9397-4de0-8564-70e35870fa6c
6db644e5-c181-4a96-a5a4-f1426dabdbcc	b0d83dc0-4c9c-4f90-931f-bddc8123a473
6db644e5-c181-4a96-a5a4-f1426dabdbcc	43e53cd1-b7d6-4d17-8ec0-5a839fb7113b
6db644e5-c181-4a96-a5a4-f1426dabdbcc	cc4f71cf-fb8e-4d3d-93c3-5d5b0e4de929
6db644e5-c181-4a96-a5a4-f1426dabdbcc	df2f5054-caee-4235-a727-0188a796bf67
6db644e5-c181-4a96-a5a4-f1426dabdbcc	1ed1d3a5-c190-4e87-8fe6-17644bca31f8
6db644e5-c181-4a96-a5a4-f1426dabdbcc	dd35ecd5-b45c-4937-b23c-81a13ad5e822
131e2683-c5c9-43ff-92f5-7766a2ebfe3f	9bef6ccb-9253-4853-97a7-92b6946bfaf1
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	256861f3-5011-4c68-a86e-abf7fc7304a5
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, device, hash_iterations, salt, type, value, user_id, created_date, counter, digits, period, algorithm) FROM stdin;
7853dac9-54ab-49d9-a4c3-efbf95d0122b	\N	27500	\\xeb1974a0a2f7417be427980d11b3fcff	password	r3XlwSeYLGUrM/dedy0Jl4kJdKywtYiA8zz+VU5Eq0BtD7pRP0t18r2gWR0H25VqMGQHXNlbKi1FkvnPcNPu1A==	e9a51a6d-3b9a-4812-a244-472b39d09022	\N	0	0	0	pbkdf2-sha256
fd4aa5f4-e7b1-4f40-9680-9c9c0e74c486	\N	27500	\\x57add1ecc36e79d77586a945aff04036	password	sDjbJjZ/oH+gWQzDGAn4PEvuCal8m46WU0uHOTM4IfvW/AGHP5UDbZNluLUa5LvsYjkMZ3aZ4FOsG+0+9vFJNA==	75213900-e9ee-4a45-b9ab-65b62956c1e1	1543158538611	0	0	0	pbkdf2-sha256
d9b4c797-dcce-4f2f-8673-5cec327c324d	\N	27500	\\x78fba13383189ab7de561959df8af9a2	password	CpFCtDt7dOcFJYajAA2ik5aQ391S/qKiIQw1zq3Eoc9xxBXOlbO0y+QdR+XuetOMrNuC+FgSSMjtvtbZo436BA==	b42c210e-96bd-4d60-a50a-28557a717c1e	1543219446661	0	0	0	pbkdf2-sha256
9c68d708-5a72-434f-be23-e9bfd2f58fd2	\N	27500	\\x1dcf7e12e70f95adb1fe5a65632b42f0	password	ijE2aMPIGYeJEfT14AaKw1GXuLT6o4xjMyO58Kq2AllVnmhFLutTdWU3SJrnSZ4DjIRpyZs5TON3da2sK9GGjg==	8c7579b8-b823-4ba7-8f07-ede053b7fd08	1543219504104	0	0	0	pbkdf2-sha256
82180cbd-d739-4bb0-a141-f75e08eab2ae	\N	27500	\\x4406c459af49397cb54780e15cbe4078	password	ME3olJ5K9JXcmtwqgHw6sdIazPlEwy5rmrt1wEQXm7gFnYmUz68vPnv1EFR0xGvsYrwbC9s9dUBZz4P+e22Ivg==	c26c1f62-dacd-4f6e-bd77-5c1ebee107af	1543219589798	0	0	0	pbkdf2-sha256
229d8421-b8ad-4efc-a8e3-fa7fb0e81fe9	\N	27500	\\xe400ff67f6fc9588fc6405ac840ef86f	password	Nk7IozzkcGiMnEy6d8wFCFc+Ea3cO2Q9GcX092ZQxaSegaKIa+dRhfOEqWfAHVaZGvq9THqSmSF/aX/o7YGJ2A==	c1b409c9-ce5f-4a94-9c47-c977574a4daf	1543219678519	0	0	0	pbkdf2-sha256
\.


--
-- Data for Name: credential_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential_attribute (id, credential_id, name, value) FROM stdin;
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2018-11-25 15:03:45.494382	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3158223443
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2018-11-25 15:03:45.530586	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3158223443
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2018-11-25 15:03:45.739042	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	3158223443
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2018-11-25 15:03:45.760954	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3158223443
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2018-11-25 15:03:46.475363	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3158223443
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2018-11-25 15:03:46.486705	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3158223443
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2018-11-25 15:03:46.977997	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3158223443
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2018-11-25 15:03:46.989715	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3158223443
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2018-11-25 15:03:47.001028	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	3158223443
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2018-11-25 15:03:48.224226	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	3158223443
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2018-11-25 15:03:48.59122	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3158223443
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2018-11-25 15:03:48.602407	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3158223443
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2018-11-25 15:03:48.624197	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3158223443
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2018-11-25 15:03:48.835832	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	3158223443
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2018-11-25 15:03:48.84685	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3158223443
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2018-11-25 15:03:48.857925	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	3158223443
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2018-11-25 15:03:48.868931	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	3158223443
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2018-11-25 15:03:49.136912	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	3158223443
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2018-11-25 15:03:49.461847	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3158223443
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2018-11-25 15:03:49.483543	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3158223443
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2018-11-25 15:03:54.190332	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3158223443
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2018-11-25 15:03:49.495137	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3158223443
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2018-11-25 15:03:49.506242	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3158223443
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2018-11-25 15:03:49.573068	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	3158223443
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2018-11-25 15:03:49.594764	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3158223443
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2018-11-25 15:03:49.605976	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3158223443
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2018-11-25 15:03:50.028482	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	3158223443
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2018-11-25 15:03:50.731147	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	3158223443
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2018-11-25 15:03:50.742285	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3158223443
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2018-11-25 15:03:51.427238	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	3158223443
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2018-11-25 15:03:51.54434	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	3158223443
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2018-11-25 15:03:51.64467	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	3158223443
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2018-11-25 15:03:51.657151	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	3158223443
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2018-11-25 15:03:51.677791	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3158223443
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2018-11-25 15:03:51.689114	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3158223443
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2018-11-25 15:03:51.900901	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3158223443
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2018-11-25 15:03:51.922518	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	3158223443
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2018-11-25 15:03:51.98926	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3158223443
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2018-11-25 15:03:52.011524	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	3158223443
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2018-11-25 15:03:52.033719	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	3158223443
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2018-11-25 15:03:52.044934	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3158223443
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2018-11-25 15:03:52.056073	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3158223443
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2018-11-25 15:03:52.068968	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	3158223443
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2018-11-25 15:03:54.146965	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	3158223443
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2018-11-25 15:03:54.168165	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	3158223443
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2018-11-25 15:03:54.202878	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	3158223443
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2018-11-25 15:03:54.212703	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3158223443
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2018-11-25 15:03:54.502867	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	3158223443
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2018-11-25 15:03:54.524152	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	3158223443
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2018-11-25 15:03:55.092086	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	3158223443
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2018-11-25 15:03:55.625239	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	3158223443
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2018-11-25 15:03:55.647266	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3158223443
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2018-11-25 15:03:55.659036	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	3158223443
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2018-11-25 15:03:55.670057	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	3158223443
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2018-11-25 15:03:55.725226	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	3158223443
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2018-11-25 15:03:55.747611	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	3158223443
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2018-11-25 15:03:55.914852	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	3158223443
4.0.0-KEYCLOAK-5579	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2018-11-25 15:03:56.550894	58	EXECUTED	7:c88da39534e99aba51cc89d09fd53936	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	3158223443
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2018-11-25 15:03:56.739005	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	3158223443
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2018-11-25 15:03:56.761016	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3158223443
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2018-11-25 15:03:56.783396	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	3158223443
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2018-11-25 15:03:56.805435	62	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3158223443
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2018-11-25 15:03:56.816932	63	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3158223443
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2018-11-25 15:03:56.828035	64	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	3158223443
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2018-11-25 15:03:56.983764	65	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	3158223443
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2018-11-25 15:03:57.050132	66	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	3158223443
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	1c513f33-5fb5-4038-b957-561791dbedac	f
master	6dc1744a-5323-4d89-b352-fe8f1535d454	t
master	d0f20974-aa2a-4b6b-bc93-8f338b2306e0	t
master	3c006cd6-cd36-4f04-8342-b8361ba88f03	t
master	375a7938-f9a6-4ea7-9f02-f12f79d00eb1	f
master	97c0174c-bc25-4fb2-bc1a-e5d37abdd879	f
master	1882a27c-4138-4243-8aa2-888d26f0d992	t
master	c415156e-f3c6-40f6-9baf-2ff6de1805ea	t
Otus-Spring-Diploma	94d347ad-7791-47f8-bc14-3c6286243fa7	t
Otus-Spring-Diploma	b7ad2332-0f21-4529-a60b-9067ed73bfbe	t
Otus-Spring-Diploma	ca32d76a-1218-4a90-a317-01ca74a200e9	t
Otus-Spring-Diploma	d82a1bdd-2bdd-45fd-a4ca-6c0017188509	t
Otus-Spring-Diploma	e408449d-1f74-415e-8bef-fc66c79b231e	t
Otus-Spring-Diploma	01e6ed6c-6949-435c-82d3-3fe8436334f6	f
Otus-Spring-Diploma	854d924f-d40f-4a8c-89d7-d9980ee21307	f
Otus-Spring-Diploma	8bc2ec46-3c26-47aa-b445-1b31dbb400e6	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_credential_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_credential_attribute (id, credential_id, name, value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, device, hash_iterations, salt, type, value, created_date, counter, digits, period, algorithm, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	master	f	${role_admin}	admin	master	\N	master
e212931e-a989-424e-b0f4-63e39dd09d83	master	f	${role_create-realm}	create-realm	master	\N	master
32baef07-b0cc-4b04-8de2-64245f6ef42f	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_create-client}	create-client	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
254910c3-01be-4341-8bcd-76abf8f287f6	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_view-realm}	view-realm	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
9c53a1ad-3045-418a-91f5-4322e93a24f2	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_view-users}	view-users	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
65408fbe-d100-4282-ac9e-dd117db74b4b	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_view-clients}	view-clients	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
a94ce264-ee94-4d7a-b6a4-978a0ca9c4e5	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_view-events}	view-events	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
bd7d6f59-860e-4e2c-abd8-f8d12f3648cd	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_view-identity-providers}	view-identity-providers	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
9fc5048d-18eb-4f71-8cf0-1a42f09be818	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_view-authorization}	view-authorization	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
d8964c30-b2dc-46b3-a14b-3ef6a3d70740	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_manage-realm}	manage-realm	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
94166bc6-e754-40aa-b980-9654c6579595	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_manage-users}	manage-users	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
fb22a83e-0dfa-4360-9fed-8e406a521681	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_manage-clients}	manage-clients	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
ee8b68e3-2631-4cf9-be1d-c73eb5f5e9a0	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_manage-events}	manage-events	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
24352f76-54b0-4be6-b488-e21572377d08	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_manage-identity-providers}	manage-identity-providers	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
3a1b9bf4-7a9f-460b-b2ce-d18fd1f37dd4	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_manage-authorization}	manage-authorization	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
e4b4bedd-f80a-4667-b12e-b65d4d4e0506	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_query-users}	query-users	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
7db4700b-4e37-4f94-917d-8b2be80bae08	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_query-clients}	query-clients	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
8dd7aa7a-b37c-4c91-adb3-39a0b4dd4e2b	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_query-realms}	query-realms	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
bc81d77f-a2a3-45aa-bd88-64323a042ec0	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_query-groups}	query-groups	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
0ec74f6c-ee1d-42f9-9400-5556269f1fe5	ee8227e9-e506-4a4b-a074-2ada05003136	t	${role_view-profile}	view-profile	master	ee8227e9-e506-4a4b-a074-2ada05003136	\N
49edf0fe-4ffe-4be8-8c18-9b0e7393883e	ee8227e9-e506-4a4b-a074-2ada05003136	t	${role_manage-account}	manage-account	master	ee8227e9-e506-4a4b-a074-2ada05003136	\N
2b023e2c-c8d9-4fc9-a36c-6878b658a917	ee8227e9-e506-4a4b-a074-2ada05003136	t	${role_manage-account-links}	manage-account-links	master	ee8227e9-e506-4a4b-a074-2ada05003136	\N
a4a738c3-425e-4262-bd34-861e2056a96c	a3f63db2-b9ae-4fa2-b549-8ad678d69efe	t	${role_read-token}	read-token	master	a3f63db2-b9ae-4fa2-b549-8ad678d69efe	\N
df44d926-69df-45bb-8279-d3634d1d5af8	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	t	${role_impersonation}	impersonation	master	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	\N
d0df72d9-c784-4792-ad32-8fa347b50921	master	f	${role_offline-access}	offline_access	master	\N	master
40e1c519-2ace-400d-b191-e401019558d1	master	f	${role_uma_authorization}	uma_authorization	master	\N	master
7c8b50cd-9f87-4d55-9a36-790403c7c956	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_create-client}	create-client	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
b913cc55-63dd-404c-9cc5-4e0359019bdf	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_view-realm}	view-realm	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
caa1f0ec-74d1-4bb6-b9de-b6579e3d1345	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_view-users}	view-users	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
49147d8f-6f48-477f-8560-b04b8e570915	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_view-clients}	view-clients	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
3f7c05fa-1b73-4d32-a5c3-ddc9b4dcf554	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_view-events}	view-events	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
3d1ac122-2183-44b7-bb93-f0852ce81edd	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_view-identity-providers}	view-identity-providers	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
f33e330c-fdd8-4b74-ac4c-1111378ca90d	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_view-authorization}	view-authorization	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
4d57e8b9-670a-4164-90be-19a62a66f813	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_manage-realm}	manage-realm	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
cd9a36ab-0317-42c2-a28a-57de66a95e7d	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_manage-users}	manage-users	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
8a91b17e-f0cb-4dd8-9271-3a39338d215b	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_manage-clients}	manage-clients	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
50075863-a157-4007-9870-bc93f001de09	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_manage-events}	manage-events	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
1e0854f7-c0a0-4a16-b02b-404e0adebbca	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_manage-identity-providers}	manage-identity-providers	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
0b431eb4-0a98-4f29-944a-7960232bc43f	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_manage-authorization}	manage-authorization	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
643923d8-7ac2-4d7a-8264-9d1334744c94	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_query-users}	query-users	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
5d353a07-ed2d-4201-98bd-8a8f8fb9e44b	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_query-clients}	query-clients	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
2bec8053-7219-456d-9e8d-0e1cec30d608	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_query-realms}	query-realms	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
b0aef25d-0c33-4750-b3d3-3dfcac0c0c1f	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_query-groups}	query-groups	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
ca1e27cc-d9fc-4738-b589-777b8b6c85da	Otus-Spring-Diploma	f	${role_uma_authorization}	uma_authorization	Otus-Spring-Diploma	\N	Otus-Spring-Diploma
9a6658d6-25db-4c23-bd6e-9975a8ed580f	Otus-Spring-Diploma	f	\N	user	Otus-Spring-Diploma	\N	Otus-Spring-Diploma
2bb2a8ac-36af-4b1f-8117-0ffdbc072ef0	Otus-Spring-Diploma	f	${role_offline-access}	offline_access	Otus-Spring-Diploma	\N	Otus-Spring-Diploma
e85b3cbd-b9c0-4b6d-bf75-d4b992c82615	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_manage-identity-providers}	manage-identity-providers	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
f2c072d3-cf2e-41e5-b12e-c4e5441871a5	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_impersonation}	impersonation	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
101e5568-e15e-4121-b4dd-80c753c57d97	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_view-users}	view-users	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
9d8225a7-4d7c-4592-9121-371dc072984b	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_view-clients}	view-clients	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
431f0849-5963-4c17-979d-aa1ebd0b79c3	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_manage-authorization}	manage-authorization	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
f44f4aea-ad30-4b28-9887-bf126a2cad9b	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_query-clients}	query-clients	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
6ec652c7-81cc-44c9-b591-487ae293acca	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_manage-realm}	manage-realm	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
ae29d3d7-c545-48e3-abe7-ce3b46e3c5bd	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_manage-clients}	manage-clients	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
29c49579-81e6-454e-a059-0cca9699db14	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_query-groups}	query-groups	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
63b89b2f-52bd-46f1-a072-05cda44783a7	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_manage-users}	manage-users	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
ca8c0164-eb6b-44dd-9ffe-2cc56e44e660	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_query-realms}	query-realms	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
6db644e5-c181-4a96-a5a4-f1426dabdbcc	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_realm-admin}	realm-admin	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
07749646-9397-4de0-8564-70e35870fa6c	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_manage-events}	manage-events	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
b0d83dc0-4c9c-4f90-931f-bddc8123a473	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_view-identity-providers}	view-identity-providers	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
df2f5054-caee-4235-a727-0188a796bf67	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_create-client}	create-client	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
cc4f71cf-fb8e-4d3d-93c3-5d5b0e4de929	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_view-realm}	view-realm	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
43e53cd1-b7d6-4d17-8ec0-5a839fb7113b	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_view-events}	view-events	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
1ed1d3a5-c190-4e87-8fe6-17644bca31f8	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_view-authorization}	view-authorization	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
dd35ecd5-b45c-4937-b23c-81a13ad5e822	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	t	${role_query-users}	query-users	Otus-Spring-Diploma	79a4b38b-8f98-48b2-89c5-47cd76b8fc6e	\N
699d2aeb-214f-4619-a9d8-161007a7b938	0e68a51d-b4ef-4bbe-af1f-3ecb481e8014	t	${role_read-token}	read-token	Otus-Spring-Diploma	0e68a51d-b4ef-4bbe-af1f-3ecb481e8014	\N
9bef6ccb-9253-4853-97a7-92b6946bfaf1	b5a9dec5-70dd-4a5b-9664-e79093420f4a	t	${role_manage-account-links}	manage-account-links	Otus-Spring-Diploma	b5a9dec5-70dd-4a5b-9664-e79093420f4a	\N
131e2683-c5c9-43ff-92f5-7766a2ebfe3f	b5a9dec5-70dd-4a5b-9664-e79093420f4a	t	${role_manage-account}	manage-account	Otus-Spring-Diploma	b5a9dec5-70dd-4a5b-9664-e79093420f4a	\N
1e5ff209-535b-495d-a8d2-90e21b327070	b5a9dec5-70dd-4a5b-9664-e79093420f4a	t	${role_view-profile}	view-profile	Otus-Spring-Diploma	b5a9dec5-70dd-4a5b-9664-e79093420f4a	\N
256861f3-5011-4c68-a86e-abf7fc7304a5	02c5fa32-6078-4f18-b244-4acda5694bc9	t	${role_impersonation}	impersonation	master	02c5fa32-6078-4f18-b244-4acda5694bc9	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version) FROM stdin;
SINGLETON	4.6.0
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, last_session_refresh, offline_flag, data) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
d9fe2ffc-7e40-47f3-89ef-f310d41e34d7	locale	openid-connect	oidc-usermodel-attribute-mapper	bbc2d41f-3582-452a-a94c-16a1819a1cdb	\N
c38c081f-9ad8-452b-bed5-4ddb5b45cb4f	role list	saml	saml-role-list-mapper	\N	6dc1744a-5323-4d89-b352-fe8f1535d454
9b7ddb74-d45c-46dc-a225-d787d6f97acd	full name	openid-connect	oidc-full-name-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
c1ddfc10-592b-4e87-a2dd-48a35b064dee	family name	openid-connect	oidc-usermodel-property-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
b13c0f3e-0996-4c50-ab5a-4f4f84bc88e0	given name	openid-connect	oidc-usermodel-property-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
aef61dac-3ff1-48d1-a3f2-ae9e2ba580da	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
92cf8f49-17a4-46e2-baf2-8e5957f6ef2b	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
9d203e8b-ffd9-484a-aa8e-266692b8045d	username	openid-connect	oidc-usermodel-property-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
dae8e760-8465-4d74-971b-1934e452326e	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
344b448d-f02d-4682-a6f6-6a2afa88428c	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
e2d44da5-5d1a-4478-b9a5-940aac5d57a3	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
6c0d3181-888f-4178-b6e2-9830e13f127e	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
bebbfe7c-9d6d-425d-825e-fed7a759eeae	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
06d324f4-ecbb-420f-8f25-de6036703528	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
9aac49cf-5e68-40bf-a46b-9d019af069e1	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
63415ef0-8d4e-459d-a6c3-49b27b6129a0	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d0f20974-aa2a-4b6b-bc93-8f338b2306e0
3a5d8bf0-6406-49d5-af15-41528c0546cd	email	openid-connect	oidc-usermodel-property-mapper	\N	3c006cd6-cd36-4f04-8342-b8361ba88f03
6729a8ce-0a2a-48d2-8202-17d69822d543	email verified	openid-connect	oidc-usermodel-property-mapper	\N	3c006cd6-cd36-4f04-8342-b8361ba88f03
18823499-bc67-479e-a47e-5e8eb179b725	address	openid-connect	oidc-address-mapper	\N	375a7938-f9a6-4ea7-9f02-f12f79d00eb1
632b741c-f7df-4b62-bcba-a507d4ff3e3c	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	97c0174c-bc25-4fb2-bc1a-e5d37abdd879
6967bf22-b08d-4284-94e5-36132d14ea9c	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	97c0174c-bc25-4fb2-bc1a-e5d37abdd879
7d29df95-40f2-4d7f-887e-4a76ba7467f6	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	1882a27c-4138-4243-8aa2-888d26f0d992
764c43e5-6e21-48c4-95e1-ef6d1aab5401	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	1882a27c-4138-4243-8aa2-888d26f0d992
d730d1c7-d0d5-4312-87b5-4675c038b3f3	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	1882a27c-4138-4243-8aa2-888d26f0d992
77124b0f-49fe-4c06-bd19-82f982019fba	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	c415156e-f3c6-40f6-9baf-2ff6de1805ea
b8797035-0428-4640-ad7d-f2278d95c916	address	openid-connect	oidc-address-mapper	\N	01e6ed6c-6949-435c-82d3-3fe8436334f6
d6d777da-4f34-4ea2-a096-84ddca7eb203	email verified	openid-connect	oidc-usermodel-property-mapper	\N	d82a1bdd-2bdd-45fd-a4ca-6c0017188509
cf5b3c6c-d373-469d-a635-e74c326b3469	email	openid-connect	oidc-usermodel-property-mapper	\N	d82a1bdd-2bdd-45fd-a4ca-6c0017188509
69a05636-2f75-4bf5-9c74-0fc74af340d9	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	8bc2ec46-3c26-47aa-b445-1b31dbb400e6
d28caf32-dc06-41c1-8e80-872f310fd9dc	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	8bc2ec46-3c26-47aa-b445-1b31dbb400e6
62df4ce1-ec34-4664-b683-5e2b241ccc2d	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
300e6369-642a-476a-a2da-290a751372e9	website	openid-connect	oidc-usermodel-attribute-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
bb4b8b2e-557d-42fc-b4f9-156cc9743ea6	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
7e3758e8-9f95-4934-bf68-234b9b97b7cf	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
fb40964a-962e-44ec-b980-a5ef74a62449	full name	openid-connect	oidc-full-name-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
466eadcf-34d6-4d9b-a5f0-23a7f3e41776	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
d24b64ba-90b4-4c73-aa6b-4dacc86f20d0	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
386bf6a4-a4e5-4f90-968b-0a1350e308bf	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
ff3d9cbf-7b7a-42e7-8bf3-5c8ffc94c0c3	username	openid-connect	oidc-usermodel-property-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
f2831d48-e16a-4dd6-8195-ddff380ac8c3	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
8441c0c3-4049-421e-9f3e-69ea0220cc4c	family name	openid-connect	oidc-usermodel-property-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
fed14c12-73a5-4714-a15c-b822fdb7a545	given name	openid-connect	oidc-usermodel-property-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
0f0c8a1b-cec2-4b8c-bd50-185934cc38a8	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
41c1c2b0-362d-4348-a417-f8f59eb01b4f	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	94d347ad-7791-47f8-bc14-3c6286243fa7
e326e39a-9db5-4f3b-aab7-bac98ae74d59	role list	saml	saml-role-list-mapper	\N	e408449d-1f74-415e-8bef-fc66c79b231e
307456e4-f1c2-4b2f-bab8-cefd8a51467f	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	ca32d76a-1218-4a90-a317-01ca74a200e9
854f0e8d-6cea-456c-bc6b-d17c9c4c1875	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	ca32d76a-1218-4a90-a317-01ca74a200e9
38f183de-050f-4c6f-a904-74f85d78b64b	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	ca32d76a-1218-4a90-a317-01ca74a200e9
1c135e5a-fb0b-406d-bb1f-598116ec788d	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	b7ad2332-0f21-4529-a60b-9067ed73bfbe
5940d28a-1d2a-4988-b86f-1ae70975992f	locale	openid-connect	oidc-usermodel-attribute-mapper	09c74bad-b814-4850-987a-a4abf16743f3	\N
144b8851-46e7-4658-be83-4edf42b94b5d	Attrs-Domain	openid-connect	oidc-usermodel-attribute-mapper	f215e460-e572-42ec-8b6b-f1c6ad3d188b	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
d9fe2ffc-7e40-47f3-89ef-f310d41e34d7	true	userinfo.token.claim
d9fe2ffc-7e40-47f3-89ef-f310d41e34d7	locale	user.attribute
d9fe2ffc-7e40-47f3-89ef-f310d41e34d7	true	id.token.claim
d9fe2ffc-7e40-47f3-89ef-f310d41e34d7	true	access.token.claim
d9fe2ffc-7e40-47f3-89ef-f310d41e34d7	locale	claim.name
d9fe2ffc-7e40-47f3-89ef-f310d41e34d7	String	jsonType.label
c38c081f-9ad8-452b-bed5-4ddb5b45cb4f	false	single
c38c081f-9ad8-452b-bed5-4ddb5b45cb4f	Basic	attribute.nameformat
c38c081f-9ad8-452b-bed5-4ddb5b45cb4f	Role	attribute.name
9b7ddb74-d45c-46dc-a225-d787d6f97acd	true	userinfo.token.claim
9b7ddb74-d45c-46dc-a225-d787d6f97acd	true	id.token.claim
9b7ddb74-d45c-46dc-a225-d787d6f97acd	true	access.token.claim
c1ddfc10-592b-4e87-a2dd-48a35b064dee	true	userinfo.token.claim
c1ddfc10-592b-4e87-a2dd-48a35b064dee	lastName	user.attribute
c1ddfc10-592b-4e87-a2dd-48a35b064dee	true	id.token.claim
c1ddfc10-592b-4e87-a2dd-48a35b064dee	true	access.token.claim
c1ddfc10-592b-4e87-a2dd-48a35b064dee	family_name	claim.name
c1ddfc10-592b-4e87-a2dd-48a35b064dee	String	jsonType.label
b13c0f3e-0996-4c50-ab5a-4f4f84bc88e0	true	userinfo.token.claim
b13c0f3e-0996-4c50-ab5a-4f4f84bc88e0	firstName	user.attribute
b13c0f3e-0996-4c50-ab5a-4f4f84bc88e0	true	id.token.claim
b13c0f3e-0996-4c50-ab5a-4f4f84bc88e0	true	access.token.claim
b13c0f3e-0996-4c50-ab5a-4f4f84bc88e0	given_name	claim.name
b13c0f3e-0996-4c50-ab5a-4f4f84bc88e0	String	jsonType.label
aef61dac-3ff1-48d1-a3f2-ae9e2ba580da	true	userinfo.token.claim
aef61dac-3ff1-48d1-a3f2-ae9e2ba580da	middleName	user.attribute
aef61dac-3ff1-48d1-a3f2-ae9e2ba580da	true	id.token.claim
aef61dac-3ff1-48d1-a3f2-ae9e2ba580da	true	access.token.claim
aef61dac-3ff1-48d1-a3f2-ae9e2ba580da	middle_name	claim.name
aef61dac-3ff1-48d1-a3f2-ae9e2ba580da	String	jsonType.label
92cf8f49-17a4-46e2-baf2-8e5957f6ef2b	true	userinfo.token.claim
92cf8f49-17a4-46e2-baf2-8e5957f6ef2b	nickname	user.attribute
92cf8f49-17a4-46e2-baf2-8e5957f6ef2b	true	id.token.claim
92cf8f49-17a4-46e2-baf2-8e5957f6ef2b	true	access.token.claim
92cf8f49-17a4-46e2-baf2-8e5957f6ef2b	nickname	claim.name
92cf8f49-17a4-46e2-baf2-8e5957f6ef2b	String	jsonType.label
9d203e8b-ffd9-484a-aa8e-266692b8045d	true	userinfo.token.claim
9d203e8b-ffd9-484a-aa8e-266692b8045d	username	user.attribute
9d203e8b-ffd9-484a-aa8e-266692b8045d	true	id.token.claim
9d203e8b-ffd9-484a-aa8e-266692b8045d	true	access.token.claim
9d203e8b-ffd9-484a-aa8e-266692b8045d	preferred_username	claim.name
9d203e8b-ffd9-484a-aa8e-266692b8045d	String	jsonType.label
dae8e760-8465-4d74-971b-1934e452326e	true	userinfo.token.claim
dae8e760-8465-4d74-971b-1934e452326e	profile	user.attribute
dae8e760-8465-4d74-971b-1934e452326e	true	id.token.claim
dae8e760-8465-4d74-971b-1934e452326e	true	access.token.claim
dae8e760-8465-4d74-971b-1934e452326e	profile	claim.name
dae8e760-8465-4d74-971b-1934e452326e	String	jsonType.label
344b448d-f02d-4682-a6f6-6a2afa88428c	true	userinfo.token.claim
344b448d-f02d-4682-a6f6-6a2afa88428c	picture	user.attribute
344b448d-f02d-4682-a6f6-6a2afa88428c	true	id.token.claim
344b448d-f02d-4682-a6f6-6a2afa88428c	true	access.token.claim
344b448d-f02d-4682-a6f6-6a2afa88428c	picture	claim.name
344b448d-f02d-4682-a6f6-6a2afa88428c	String	jsonType.label
e2d44da5-5d1a-4478-b9a5-940aac5d57a3	true	userinfo.token.claim
e2d44da5-5d1a-4478-b9a5-940aac5d57a3	website	user.attribute
e2d44da5-5d1a-4478-b9a5-940aac5d57a3	true	id.token.claim
e2d44da5-5d1a-4478-b9a5-940aac5d57a3	true	access.token.claim
e2d44da5-5d1a-4478-b9a5-940aac5d57a3	website	claim.name
e2d44da5-5d1a-4478-b9a5-940aac5d57a3	String	jsonType.label
6c0d3181-888f-4178-b6e2-9830e13f127e	true	userinfo.token.claim
6c0d3181-888f-4178-b6e2-9830e13f127e	gender	user.attribute
6c0d3181-888f-4178-b6e2-9830e13f127e	true	id.token.claim
6c0d3181-888f-4178-b6e2-9830e13f127e	true	access.token.claim
6c0d3181-888f-4178-b6e2-9830e13f127e	gender	claim.name
6c0d3181-888f-4178-b6e2-9830e13f127e	String	jsonType.label
bebbfe7c-9d6d-425d-825e-fed7a759eeae	true	userinfo.token.claim
bebbfe7c-9d6d-425d-825e-fed7a759eeae	birthdate	user.attribute
bebbfe7c-9d6d-425d-825e-fed7a759eeae	true	id.token.claim
bebbfe7c-9d6d-425d-825e-fed7a759eeae	true	access.token.claim
bebbfe7c-9d6d-425d-825e-fed7a759eeae	birthdate	claim.name
bebbfe7c-9d6d-425d-825e-fed7a759eeae	String	jsonType.label
06d324f4-ecbb-420f-8f25-de6036703528	true	userinfo.token.claim
06d324f4-ecbb-420f-8f25-de6036703528	zoneinfo	user.attribute
06d324f4-ecbb-420f-8f25-de6036703528	true	id.token.claim
06d324f4-ecbb-420f-8f25-de6036703528	true	access.token.claim
06d324f4-ecbb-420f-8f25-de6036703528	zoneinfo	claim.name
06d324f4-ecbb-420f-8f25-de6036703528	String	jsonType.label
9aac49cf-5e68-40bf-a46b-9d019af069e1	true	userinfo.token.claim
9aac49cf-5e68-40bf-a46b-9d019af069e1	locale	user.attribute
9aac49cf-5e68-40bf-a46b-9d019af069e1	true	id.token.claim
9aac49cf-5e68-40bf-a46b-9d019af069e1	true	access.token.claim
9aac49cf-5e68-40bf-a46b-9d019af069e1	locale	claim.name
9aac49cf-5e68-40bf-a46b-9d019af069e1	String	jsonType.label
63415ef0-8d4e-459d-a6c3-49b27b6129a0	true	userinfo.token.claim
63415ef0-8d4e-459d-a6c3-49b27b6129a0	updatedAt	user.attribute
63415ef0-8d4e-459d-a6c3-49b27b6129a0	true	id.token.claim
63415ef0-8d4e-459d-a6c3-49b27b6129a0	true	access.token.claim
63415ef0-8d4e-459d-a6c3-49b27b6129a0	updated_at	claim.name
63415ef0-8d4e-459d-a6c3-49b27b6129a0	String	jsonType.label
3a5d8bf0-6406-49d5-af15-41528c0546cd	true	userinfo.token.claim
3a5d8bf0-6406-49d5-af15-41528c0546cd	email	user.attribute
3a5d8bf0-6406-49d5-af15-41528c0546cd	true	id.token.claim
3a5d8bf0-6406-49d5-af15-41528c0546cd	true	access.token.claim
3a5d8bf0-6406-49d5-af15-41528c0546cd	email	claim.name
3a5d8bf0-6406-49d5-af15-41528c0546cd	String	jsonType.label
6729a8ce-0a2a-48d2-8202-17d69822d543	true	userinfo.token.claim
6729a8ce-0a2a-48d2-8202-17d69822d543	emailVerified	user.attribute
6729a8ce-0a2a-48d2-8202-17d69822d543	true	id.token.claim
6729a8ce-0a2a-48d2-8202-17d69822d543	true	access.token.claim
6729a8ce-0a2a-48d2-8202-17d69822d543	email_verified	claim.name
6729a8ce-0a2a-48d2-8202-17d69822d543	boolean	jsonType.label
18823499-bc67-479e-a47e-5e8eb179b725	formatted	user.attribute.formatted
18823499-bc67-479e-a47e-5e8eb179b725	country	user.attribute.country
18823499-bc67-479e-a47e-5e8eb179b725	postal_code	user.attribute.postal_code
18823499-bc67-479e-a47e-5e8eb179b725	true	userinfo.token.claim
18823499-bc67-479e-a47e-5e8eb179b725	street	user.attribute.street
18823499-bc67-479e-a47e-5e8eb179b725	true	id.token.claim
18823499-bc67-479e-a47e-5e8eb179b725	region	user.attribute.region
18823499-bc67-479e-a47e-5e8eb179b725	true	access.token.claim
18823499-bc67-479e-a47e-5e8eb179b725	locality	user.attribute.locality
632b741c-f7df-4b62-bcba-a507d4ff3e3c	true	userinfo.token.claim
632b741c-f7df-4b62-bcba-a507d4ff3e3c	phoneNumber	user.attribute
632b741c-f7df-4b62-bcba-a507d4ff3e3c	true	id.token.claim
632b741c-f7df-4b62-bcba-a507d4ff3e3c	true	access.token.claim
632b741c-f7df-4b62-bcba-a507d4ff3e3c	phone_number	claim.name
632b741c-f7df-4b62-bcba-a507d4ff3e3c	String	jsonType.label
6967bf22-b08d-4284-94e5-36132d14ea9c	true	userinfo.token.claim
6967bf22-b08d-4284-94e5-36132d14ea9c	phoneNumberVerified	user.attribute
6967bf22-b08d-4284-94e5-36132d14ea9c	true	id.token.claim
6967bf22-b08d-4284-94e5-36132d14ea9c	true	access.token.claim
6967bf22-b08d-4284-94e5-36132d14ea9c	phone_number_verified	claim.name
6967bf22-b08d-4284-94e5-36132d14ea9c	boolean	jsonType.label
7d29df95-40f2-4d7f-887e-4a76ba7467f6	true	multivalued
7d29df95-40f2-4d7f-887e-4a76ba7467f6	foo	user.attribute
7d29df95-40f2-4d7f-887e-4a76ba7467f6	true	access.token.claim
7d29df95-40f2-4d7f-887e-4a76ba7467f6	realm_access.roles	claim.name
7d29df95-40f2-4d7f-887e-4a76ba7467f6	String	jsonType.label
764c43e5-6e21-48c4-95e1-ef6d1aab5401	true	multivalued
764c43e5-6e21-48c4-95e1-ef6d1aab5401	foo	user.attribute
764c43e5-6e21-48c4-95e1-ef6d1aab5401	true	access.token.claim
764c43e5-6e21-48c4-95e1-ef6d1aab5401	resource_access.${client_id}.roles	claim.name
764c43e5-6e21-48c4-95e1-ef6d1aab5401	String	jsonType.label
b8797035-0428-4640-ad7d-f2278d95c916	formatted	user.attribute.formatted
b8797035-0428-4640-ad7d-f2278d95c916	country	user.attribute.country
b8797035-0428-4640-ad7d-f2278d95c916	postal_code	user.attribute.postal_code
b8797035-0428-4640-ad7d-f2278d95c916	true	userinfo.token.claim
b8797035-0428-4640-ad7d-f2278d95c916	street	user.attribute.street
b8797035-0428-4640-ad7d-f2278d95c916	true	id.token.claim
b8797035-0428-4640-ad7d-f2278d95c916	region	user.attribute.region
b8797035-0428-4640-ad7d-f2278d95c916	true	access.token.claim
b8797035-0428-4640-ad7d-f2278d95c916	locality	user.attribute.locality
d6d777da-4f34-4ea2-a096-84ddca7eb203	true	userinfo.token.claim
d6d777da-4f34-4ea2-a096-84ddca7eb203	emailVerified	user.attribute
d6d777da-4f34-4ea2-a096-84ddca7eb203	true	id.token.claim
d6d777da-4f34-4ea2-a096-84ddca7eb203	true	access.token.claim
d6d777da-4f34-4ea2-a096-84ddca7eb203	email_verified	claim.name
d6d777da-4f34-4ea2-a096-84ddca7eb203	boolean	jsonType.label
cf5b3c6c-d373-469d-a635-e74c326b3469	true	userinfo.token.claim
cf5b3c6c-d373-469d-a635-e74c326b3469	email	user.attribute
cf5b3c6c-d373-469d-a635-e74c326b3469	true	id.token.claim
cf5b3c6c-d373-469d-a635-e74c326b3469	true	access.token.claim
cf5b3c6c-d373-469d-a635-e74c326b3469	email	claim.name
cf5b3c6c-d373-469d-a635-e74c326b3469	String	jsonType.label
69a05636-2f75-4bf5-9c74-0fc74af340d9	true	userinfo.token.claim
69a05636-2f75-4bf5-9c74-0fc74af340d9	phoneNumberVerified	user.attribute
69a05636-2f75-4bf5-9c74-0fc74af340d9	true	id.token.claim
69a05636-2f75-4bf5-9c74-0fc74af340d9	true	access.token.claim
69a05636-2f75-4bf5-9c74-0fc74af340d9	phone_number_verified	claim.name
69a05636-2f75-4bf5-9c74-0fc74af340d9	boolean	jsonType.label
d28caf32-dc06-41c1-8e80-872f310fd9dc	true	userinfo.token.claim
d28caf32-dc06-41c1-8e80-872f310fd9dc	phoneNumber	user.attribute
d28caf32-dc06-41c1-8e80-872f310fd9dc	true	id.token.claim
d28caf32-dc06-41c1-8e80-872f310fd9dc	true	access.token.claim
d28caf32-dc06-41c1-8e80-872f310fd9dc	phone_number	claim.name
d28caf32-dc06-41c1-8e80-872f310fd9dc	String	jsonType.label
62df4ce1-ec34-4664-b683-5e2b241ccc2d	true	userinfo.token.claim
62df4ce1-ec34-4664-b683-5e2b241ccc2d	middleName	user.attribute
62df4ce1-ec34-4664-b683-5e2b241ccc2d	true	id.token.claim
62df4ce1-ec34-4664-b683-5e2b241ccc2d	true	access.token.claim
62df4ce1-ec34-4664-b683-5e2b241ccc2d	middle_name	claim.name
62df4ce1-ec34-4664-b683-5e2b241ccc2d	String	jsonType.label
300e6369-642a-476a-a2da-290a751372e9	true	userinfo.token.claim
300e6369-642a-476a-a2da-290a751372e9	website	user.attribute
300e6369-642a-476a-a2da-290a751372e9	true	id.token.claim
300e6369-642a-476a-a2da-290a751372e9	true	access.token.claim
300e6369-642a-476a-a2da-290a751372e9	website	claim.name
300e6369-642a-476a-a2da-290a751372e9	String	jsonType.label
bb4b8b2e-557d-42fc-b4f9-156cc9743ea6	true	userinfo.token.claim
bb4b8b2e-557d-42fc-b4f9-156cc9743ea6	birthdate	user.attribute
bb4b8b2e-557d-42fc-b4f9-156cc9743ea6	true	id.token.claim
bb4b8b2e-557d-42fc-b4f9-156cc9743ea6	true	access.token.claim
bb4b8b2e-557d-42fc-b4f9-156cc9743ea6	birthdate	claim.name
bb4b8b2e-557d-42fc-b4f9-156cc9743ea6	String	jsonType.label
7e3758e8-9f95-4934-bf68-234b9b97b7cf	true	userinfo.token.claim
7e3758e8-9f95-4934-bf68-234b9b97b7cf	nickname	user.attribute
7e3758e8-9f95-4934-bf68-234b9b97b7cf	true	id.token.claim
7e3758e8-9f95-4934-bf68-234b9b97b7cf	true	access.token.claim
7e3758e8-9f95-4934-bf68-234b9b97b7cf	nickname	claim.name
7e3758e8-9f95-4934-bf68-234b9b97b7cf	String	jsonType.label
fb40964a-962e-44ec-b980-a5ef74a62449	true	id.token.claim
fb40964a-962e-44ec-b980-a5ef74a62449	true	access.token.claim
fb40964a-962e-44ec-b980-a5ef74a62449	true	userinfo.token.claim
466eadcf-34d6-4d9b-a5f0-23a7f3e41776	true	userinfo.token.claim
466eadcf-34d6-4d9b-a5f0-23a7f3e41776	updatedAt	user.attribute
466eadcf-34d6-4d9b-a5f0-23a7f3e41776	true	id.token.claim
466eadcf-34d6-4d9b-a5f0-23a7f3e41776	true	access.token.claim
466eadcf-34d6-4d9b-a5f0-23a7f3e41776	updated_at	claim.name
466eadcf-34d6-4d9b-a5f0-23a7f3e41776	String	jsonType.label
d24b64ba-90b4-4c73-aa6b-4dacc86f20d0	true	userinfo.token.claim
d24b64ba-90b4-4c73-aa6b-4dacc86f20d0	locale	user.attribute
d24b64ba-90b4-4c73-aa6b-4dacc86f20d0	true	id.token.claim
d24b64ba-90b4-4c73-aa6b-4dacc86f20d0	true	access.token.claim
d24b64ba-90b4-4c73-aa6b-4dacc86f20d0	locale	claim.name
d24b64ba-90b4-4c73-aa6b-4dacc86f20d0	String	jsonType.label
386bf6a4-a4e5-4f90-968b-0a1350e308bf	true	userinfo.token.claim
386bf6a4-a4e5-4f90-968b-0a1350e308bf	picture	user.attribute
386bf6a4-a4e5-4f90-968b-0a1350e308bf	true	id.token.claim
386bf6a4-a4e5-4f90-968b-0a1350e308bf	true	access.token.claim
386bf6a4-a4e5-4f90-968b-0a1350e308bf	picture	claim.name
386bf6a4-a4e5-4f90-968b-0a1350e308bf	String	jsonType.label
ff3d9cbf-7b7a-42e7-8bf3-5c8ffc94c0c3	true	userinfo.token.claim
ff3d9cbf-7b7a-42e7-8bf3-5c8ffc94c0c3	username	user.attribute
ff3d9cbf-7b7a-42e7-8bf3-5c8ffc94c0c3	true	id.token.claim
ff3d9cbf-7b7a-42e7-8bf3-5c8ffc94c0c3	true	access.token.claim
ff3d9cbf-7b7a-42e7-8bf3-5c8ffc94c0c3	preferred_username	claim.name
ff3d9cbf-7b7a-42e7-8bf3-5c8ffc94c0c3	String	jsonType.label
f2831d48-e16a-4dd6-8195-ddff380ac8c3	true	userinfo.token.claim
f2831d48-e16a-4dd6-8195-ddff380ac8c3	profile	user.attribute
f2831d48-e16a-4dd6-8195-ddff380ac8c3	true	id.token.claim
f2831d48-e16a-4dd6-8195-ddff380ac8c3	true	access.token.claim
f2831d48-e16a-4dd6-8195-ddff380ac8c3	profile	claim.name
f2831d48-e16a-4dd6-8195-ddff380ac8c3	String	jsonType.label
8441c0c3-4049-421e-9f3e-69ea0220cc4c	true	userinfo.token.claim
8441c0c3-4049-421e-9f3e-69ea0220cc4c	lastName	user.attribute
8441c0c3-4049-421e-9f3e-69ea0220cc4c	true	id.token.claim
8441c0c3-4049-421e-9f3e-69ea0220cc4c	true	access.token.claim
8441c0c3-4049-421e-9f3e-69ea0220cc4c	family_name	claim.name
8441c0c3-4049-421e-9f3e-69ea0220cc4c	String	jsonType.label
fed14c12-73a5-4714-a15c-b822fdb7a545	true	userinfo.token.claim
fed14c12-73a5-4714-a15c-b822fdb7a545	firstName	user.attribute
fed14c12-73a5-4714-a15c-b822fdb7a545	true	id.token.claim
fed14c12-73a5-4714-a15c-b822fdb7a545	true	access.token.claim
fed14c12-73a5-4714-a15c-b822fdb7a545	given_name	claim.name
fed14c12-73a5-4714-a15c-b822fdb7a545	String	jsonType.label
0f0c8a1b-cec2-4b8c-bd50-185934cc38a8	true	userinfo.token.claim
0f0c8a1b-cec2-4b8c-bd50-185934cc38a8	gender	user.attribute
0f0c8a1b-cec2-4b8c-bd50-185934cc38a8	true	id.token.claim
0f0c8a1b-cec2-4b8c-bd50-185934cc38a8	true	access.token.claim
0f0c8a1b-cec2-4b8c-bd50-185934cc38a8	gender	claim.name
0f0c8a1b-cec2-4b8c-bd50-185934cc38a8	String	jsonType.label
41c1c2b0-362d-4348-a417-f8f59eb01b4f	true	userinfo.token.claim
41c1c2b0-362d-4348-a417-f8f59eb01b4f	zoneinfo	user.attribute
41c1c2b0-362d-4348-a417-f8f59eb01b4f	true	id.token.claim
41c1c2b0-362d-4348-a417-f8f59eb01b4f	true	access.token.claim
41c1c2b0-362d-4348-a417-f8f59eb01b4f	zoneinfo	claim.name
41c1c2b0-362d-4348-a417-f8f59eb01b4f	String	jsonType.label
e326e39a-9db5-4f3b-aab7-bac98ae74d59	false	single
e326e39a-9db5-4f3b-aab7-bac98ae74d59	Basic	attribute.nameformat
e326e39a-9db5-4f3b-aab7-bac98ae74d59	Role	attribute.name
307456e4-f1c2-4b2f-bab8-cefd8a51467f	foo	user.attribute
307456e4-f1c2-4b2f-bab8-cefd8a51467f	true	access.token.claim
307456e4-f1c2-4b2f-bab8-cefd8a51467f	realm_access.roles	claim.name
307456e4-f1c2-4b2f-bab8-cefd8a51467f	String	jsonType.label
307456e4-f1c2-4b2f-bab8-cefd8a51467f	true	multivalued
854f0e8d-6cea-456c-bc6b-d17c9c4c1875	foo	user.attribute
854f0e8d-6cea-456c-bc6b-d17c9c4c1875	true	access.token.claim
854f0e8d-6cea-456c-bc6b-d17c9c4c1875	resource_access.${client_id}.roles	claim.name
854f0e8d-6cea-456c-bc6b-d17c9c4c1875	String	jsonType.label
854f0e8d-6cea-456c-bc6b-d17c9c4c1875	true	multivalued
5940d28a-1d2a-4988-b86f-1ae70975992f	true	userinfo.token.claim
5940d28a-1d2a-4988-b86f-1ae70975992f	locale	user.attribute
5940d28a-1d2a-4988-b86f-1ae70975992f	true	id.token.claim
5940d28a-1d2a-4988-b86f-1ae70975992f	true	access.token.claim
5940d28a-1d2a-4988-b86f-1ae70975992f	locale	claim.name
5940d28a-1d2a-4988-b86f-1ae70975992f	String	jsonType.label
144b8851-46e7-4658-be83-4edf42b94b5d	true	userinfo.token.claim
144b8851-46e7-4658-be83-4edf42b94b5d	domain	user.attribute
144b8851-46e7-4658-be83-4edf42b94b5d	true	id.token.claim
144b8851-46e7-4658-be83-4edf42b94b5d	true	access.token.claim
144b8851-46e7-4658-be83-4edf42b94b5d	attr.domain	claim.name
144b8851-46e7-4658-be83-4edf42b94b5d	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access) FROM stdin;
Otus-Spring-Diploma	60	300	10800	\N	\N	\N	t	f	0	\N	Otus-Spring-Diploma	0	\N	f	f	f	f	NONE	10800	36000	f	f	02c5fa32-6078-4f18-b244-4acda5694bc9	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	e4995259-45a9-441b-9c05-d035d7d8c298	fd11be0f-1871-4b7c-a726-4c70865ba591	75249688-8348-4deb-8166-21e62c737960	13b26aad-ef33-490e-951f-41d974af671f	4a3ba799-f3d6-4ce2-bd7d-e34af2875da1	2592000	f	10800	t	f	55c09654-193b-4235-af19-37f401354988	0	f
master	60	300	10800	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	NONE	1800	36000	f	f	55e3b562-dfc2-4b59-ab66-f5a5753a8cba	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	23b2d7de-8e92-4056-89bf-b5f4292dd4fb	24e28d54-adf8-46ec-ae7a-c4a75178f5c2	6c066b4f-230a-4fce-ae8c-70401048dc11	6097ddaa-77a3-4d15-85f7-66e3b8081b17	50269b88-ded5-4b2f-a9fc-b808a941b53a	2592000	f	10800	t	f	4bd78a75-f049-4484-ad19-42ee38498620	0	f
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly		master
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	Keycloak	master
displayNameHtml	<div class="kc-logo-text"><span>Keycloak</span></div>	master
offlineSessionMaxLifespanEnabled	false	master
offlineSessionMaxLifespan	5184000	master
_browser_header.contentSecurityPolicyReportOnly		Otus-Spring-Diploma
_browser_header.xContentTypeOptions	nosniff	Otus-Spring-Diploma
_browser_header.xRobotsTag	none	Otus-Spring-Diploma
_browser_header.xFrameOptions	SAMEORIGIN	Otus-Spring-Diploma
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	Otus-Spring-Diploma
_browser_header.xXSSProtection	1; mode=block	Otus-Spring-Diploma
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	Otus-Spring-Diploma
bruteForceProtected	false	Otus-Spring-Diploma
permanentLockout	false	Otus-Spring-Diploma
maxFailureWaitSeconds	900	Otus-Spring-Diploma
minimumQuickLoginWaitSeconds	60	Otus-Spring-Diploma
waitIncrementSeconds	60	Otus-Spring-Diploma
quickLoginCheckMilliSeconds	1000	Otus-Spring-Diploma
maxDeltaTimeSeconds	43200	Otus-Spring-Diploma
failureFactor	30	Otus-Spring-Diploma
displayName	Otus-Spring-Diploma	Otus-Spring-Diploma
offlineSessionMaxLifespanEnabled	false	Otus-Spring-Diploma
offlineSessionMaxLifespan	5184000	Otus-Spring-Diploma
actionTokenGeneratedByAdminLifespan	43200	Otus-Spring-Diploma
actionTokenGeneratedByUserLifespan	300	Otus-Spring-Diploma
actionTokenGeneratedByAdminLifespan	43200	master
actionTokenGeneratedByUserLifespan	300	master
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_roles (realm_id, role_id) FROM stdin;
master	d0df72d9-c784-4792-ad32-8fa347b50921
master	40e1c519-2ace-400d-b191-e401019558d1
Otus-Spring-Diploma	2bb2a8ac-36af-4b1f-8117-0ffdbc072ef0
Otus-Spring-Diploma	ca1e27cc-d9fc-4738-b589-777b8b6c85da
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
Otus-Spring-Diploma	jboss-logging
master	jboss-logging
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	Otus-Spring-Diploma
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
ee8227e9-e506-4a4b-a074-2ada05003136	/auth/realms/master/account/*
bbc2d41f-3582-452a-a94c-16a1819a1cdb	/auth/admin/master/console/*
09c74bad-b814-4850-987a-a4abf16743f3	/auth/admin/Otus-Spring-Diploma/console/*
b5a9dec5-70dd-4a5b-9664-e79093420f4a	/auth/realms/Otus-Spring-Diploma/account/*
f215e460-e572-42ec-8b6b-f1c6ad3d188b	http://localhost:8080/*
f215e460-e572-42ec-8b6b-f1c6ad3d188b	http://46.101.139.235
f215e460-e572-42ec-8b6b-f1c6ad3d188b	http://localhost:3000/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
72324d37-5db9-4746-a92b-18c099409d86	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
6469e7bc-9c39-40d2-88a0-b633d25b65ec	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
39aa37e3-3276-4409-9c74-8572374bf933	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
7d4807fb-ba67-47be-876e-5ba3ac15636b	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
717843a0-0d44-4a6a-97e8-efa1d11ccbff	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
50ea9b26-aaa8-42c2-9019-089f3e3e0c35	CONFIGURE_TOTP	Configure OTP	Otus-Spring-Diploma	t	f	CONFIGURE_TOTP	10
20d35bcb-02dd-4dbf-8fca-54d1293f76c8	terms_and_conditions	Terms and Conditions	Otus-Spring-Diploma	f	f	terms_and_conditions	20
1d64bee1-491b-402a-9eee-2c6ccc6569fd	UPDATE_PASSWORD	Update Password	Otus-Spring-Diploma	t	f	UPDATE_PASSWORD	30
764176a3-409f-47c8-ae22-7eaca71d5669	UPDATE_PROFILE	Update Profile	Otus-Spring-Diploma	t	f	UPDATE_PROFILE	40
97ef6cb0-cc36-4d3f-831d-e628ab54897c	VERIFY_EMAIL	Verify Email	Otus-Spring-Diploma	t	f	VERIFY_EMAIL	50
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
domain	programming	75213900-e9ee-4a45-b9ab-65b62956c1e1	4221f977-224f-45ac-8643-205b94d87eae
domain	business	c26c1f62-dacd-4f6e-bd77-5c1ebee107af	2e06e059-76ca-4264-bfb4-8d9890a4105f
domain	business	c1b409c9-ce5f-4a94-9c47-c977574a4daf	615ec3ec-8493-4dec-b68c-d4154fc96748
domain	programming	8c7579b8-b823-4ba7-8f07-ede053b7fd08	bcb3614d-c970-451e-ba0a-04ec796a667a
domain	programming	b42c210e-96bd-4d60-a50a-28557a717c1e	8c55a510-f58c-43f2-a5d5-e216a4029ce8
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
e9a51a6d-3b9a-4812-a244-472b39d09022	\N	c3cb49c4-7082-4f4a-8443-55b263407566	f	t	\N	\N	\N	master	test	1543158242003	\N	0
75213900-e9ee-4a45-b9ab-65b62956c1e1	user1@mail.com	user1@mail.com	t	t	\N	Scott	Matthews	Otus-Spring-Diploma	user1	1543158518715	\N	0
b42c210e-96bd-4d60-a50a-28557a717c1e	user2@mail.com	user2@mail.com	t	t	\N	Tilly	Frank	Otus-Spring-Diploma	user2	1543219422591	\N	0
8c7579b8-b823-4ba7-8f07-ede053b7fd08	user3@mail.com	user3@mail.com	t	t	\N	Arnold	Timms	Otus-Spring-Diploma	user3	1543219491323	\N	0
c26c1f62-dacd-4f6e-bd77-5c1ebee107af	user4@mail.com	user4@mail.com	t	t	\N	Aiden	Mansell	Otus-Spring-Diploma	user4	1543219566786	\N	0
c1b409c9-ce5f-4a94-9c47-c977574a4daf	user5@mail.com	user5@mail.com	t	t	\N	Wiktoria	Orozco	Otus-Spring-Diploma	user5	1543219645179	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
40e1c519-2ace-400d-b191-e401019558d1	e9a51a6d-3b9a-4812-a244-472b39d09022
0ec74f6c-ee1d-42f9-9400-5556269f1fe5	e9a51a6d-3b9a-4812-a244-472b39d09022
d0df72d9-c784-4792-ad32-8fa347b50921	e9a51a6d-3b9a-4812-a244-472b39d09022
49edf0fe-4ffe-4be8-8c18-9b0e7393883e	e9a51a6d-3b9a-4812-a244-472b39d09022
3f8fe48d-66c5-44eb-830a-a78954e9ef4e	e9a51a6d-3b9a-4812-a244-472b39d09022
ca1e27cc-d9fc-4738-b589-777b8b6c85da	75213900-e9ee-4a45-b9ab-65b62956c1e1
131e2683-c5c9-43ff-92f5-7766a2ebfe3f	75213900-e9ee-4a45-b9ab-65b62956c1e1
1e5ff209-535b-495d-a8d2-90e21b327070	75213900-e9ee-4a45-b9ab-65b62956c1e1
2bb2a8ac-36af-4b1f-8117-0ffdbc072ef0	75213900-e9ee-4a45-b9ab-65b62956c1e1
ca1e27cc-d9fc-4738-b589-777b8b6c85da	b42c210e-96bd-4d60-a50a-28557a717c1e
131e2683-c5c9-43ff-92f5-7766a2ebfe3f	b42c210e-96bd-4d60-a50a-28557a717c1e
1e5ff209-535b-495d-a8d2-90e21b327070	b42c210e-96bd-4d60-a50a-28557a717c1e
2bb2a8ac-36af-4b1f-8117-0ffdbc072ef0	b42c210e-96bd-4d60-a50a-28557a717c1e
9a6658d6-25db-4c23-bd6e-9975a8ed580f	b42c210e-96bd-4d60-a50a-28557a717c1e
ca1e27cc-d9fc-4738-b589-777b8b6c85da	8c7579b8-b823-4ba7-8f07-ede053b7fd08
131e2683-c5c9-43ff-92f5-7766a2ebfe3f	8c7579b8-b823-4ba7-8f07-ede053b7fd08
1e5ff209-535b-495d-a8d2-90e21b327070	8c7579b8-b823-4ba7-8f07-ede053b7fd08
2bb2a8ac-36af-4b1f-8117-0ffdbc072ef0	8c7579b8-b823-4ba7-8f07-ede053b7fd08
9a6658d6-25db-4c23-bd6e-9975a8ed580f	8c7579b8-b823-4ba7-8f07-ede053b7fd08
ca1e27cc-d9fc-4738-b589-777b8b6c85da	c26c1f62-dacd-4f6e-bd77-5c1ebee107af
131e2683-c5c9-43ff-92f5-7766a2ebfe3f	c26c1f62-dacd-4f6e-bd77-5c1ebee107af
1e5ff209-535b-495d-a8d2-90e21b327070	c26c1f62-dacd-4f6e-bd77-5c1ebee107af
2bb2a8ac-36af-4b1f-8117-0ffdbc072ef0	c26c1f62-dacd-4f6e-bd77-5c1ebee107af
9a6658d6-25db-4c23-bd6e-9975a8ed580f	c26c1f62-dacd-4f6e-bd77-5c1ebee107af
ca1e27cc-d9fc-4738-b589-777b8b6c85da	c1b409c9-ce5f-4a94-9c47-c977574a4daf
131e2683-c5c9-43ff-92f5-7766a2ebfe3f	c1b409c9-ce5f-4a94-9c47-c977574a4daf
1e5ff209-535b-495d-a8d2-90e21b327070	c1b409c9-ce5f-4a94-9c47-c977574a4daf
2bb2a8ac-36af-4b1f-8117-0ffdbc072ef0	c1b409c9-ce5f-4a94-9c47-c977574a4daf
9a6658d6-25db-4c23-bd6e-9975a8ed580f	c1b409c9-ce5f-4a94-9c47-c977574a4daf
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: credential_attribute constraint_credential_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential_attribute
    ADD CONSTRAINT constraint_credential_attr PRIMARY KEY (id);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: fed_credential_attribute constraint_fed_credential_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_credential_attribute
    ADD CONSTRAINT constraint_fed_credential_attr PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_credential_attr_cred; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_credential_attr_cred ON public.credential_attribute USING btree (credential_id);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_fed_cred_attr_cred; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fed_cred_attr_cred ON public.fed_credential_attribute USING btree (credential_id);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: credential_attribute fk_cred_attr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential_attribute
    ADD CONSTRAINT fk_cred_attr FOREIGN KEY (credential_id) REFERENCES public.credential(id);


--
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: fed_credential_attribute fk_fed_cred_attr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_credential_attribute
    ADD CONSTRAINT fk_fed_cred_attr FOREIGN KEY (credential_id) REFERENCES public.fed_user_credential(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES public.client(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES public.client(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.0
-- Dumped by pg_dump version 11.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO keycloak;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: keycloak
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--


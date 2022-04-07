CREATE OR REPLACE FUNCTION api.get_commands() RETURNS table(
   id integer,
   command character varying,
   author character varying,
   type integer,
   content jsonb,
   modified timestamp,
   created timestamp
) LANGUAGE 'plpgsql' COST 100 VOLATILE

AS $BODY$
BEGIN
    RETURN QUERY
        SELECT * FROM public.commands;
END;
$BODY$;

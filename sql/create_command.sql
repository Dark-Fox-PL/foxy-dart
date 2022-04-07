CREATE OR REPLACE FUNCTION api.create_command(
  _command character varying,
  _author character varying,
  _type integer,
  _content jsonb
) RETURNS integer LANGUAGE 'plpgsql' COST 100

AS $BODY$ DECLARE cmd_id INTEGER;
BEGIN
INSERT INTO public.commands (command, author, type, content)
VALUES ( _command, _author, _type, _content ) ON CONFLICT DO NOTHING
    RETURNING cmd_id INTO cmd_id;
RETURN cmd_id;
END;
$BODY$;

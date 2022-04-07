CREATE OR REPLACE FUNCTION api.get_command(
    _command character varying
) RETURNS jsonb LANGUAGE 'plpgsql' COST 100

AS $BODY$ DECLARE cmd jsonb;
BEGIN
    SELECT coalesce(content, '[]'::jsonb) INTO cmd FROM public.commands WHERE command = _command;
    RETURN cmd;
END;
$BODY$;

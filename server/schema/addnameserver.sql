CREATE OR REPLACE FUNCTION AddNameserver(
	servername varchar,
	groupname varchar
) RETURNS void AS $$
DECLARE
	nameserver_group_id_var int;
BEGIN
	SELECT nameserver_group.id INTO nameserver_group_id_var FROM nameserver_group WHERE name = groupname;
	IF NOT FOUND THEN
		RAISE EXCEPTION 'nameserver group % not found', groupname;
	END IF;

	INSERT INTO nameserver (name, nameserver_group_id) VALUES (servername, nameserver_group_id_var);
END; $$ LANGUAGE plpgsql;

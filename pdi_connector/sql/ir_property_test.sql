--
-- function: ir_property_text
--     arg1: model (eg res.partner)
--     arg2: id (current id)
--     arg3: field name to retrieve
--     arg3: company field
--
CREATE OR REPLACE FUNCTION ir_property_text(model text, id integer, field text, company integer)
RETURNS text AS
$BODY$

DECLARE
    res ir_property%ROWTYPE;
BEGIN
    SELECT * INTO res FROM ir_property WHERE type IN ('char', 'text', 'selection') AND res_id=model||','||id::text AND name=field AND company_id=company;
    -- If no record found, search the default for this company
    IF NOT FOUND THEN
        SELECT * INTO res FROM ir_property WHERE type IN ('char', 'text', 'selection') AND res_id IS NULL AND company_id=company;
        -- If not found search the default for all companies
        IF NOT FOUND THEN
            SELECT * INTO res FROM ir_property WHERE type IN ('char', 'text', 'selection') AND res_id IS NULL AND company_id IS NULL;
            -- Not default, return blank
            IF NOT FOUND THEN
                RETURN '';
            END IF;
        END IF;
    END IF;

    RETURN res.value_text;
END;

$BODY$
LANGUAGE 'plpgsql';

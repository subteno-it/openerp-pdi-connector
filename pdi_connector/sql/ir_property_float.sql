--
-- function: ir_property_float
--     arg1: model (eg res.partner)
--     arg2: id (current id)
--     arg3: field name to retrieve
--     arg3: company field
--
CREATE OR REPLACE FUNCTION ir_property_float(model text, id integer, field text, company integer)
RETURNS double precision AS
$BODY$

DECLARE
    res ir_property%ROWTYPE;
BEGIN
    SELECT * INTO res FROM ir_property WHERE type='float' AND res_id=model||','||id::text AND name=field AND company_id=company;
    -- If no record found, search the default for this company
    IF NOT FOUND THEN
        SELECT * INTO res FROM ir_property WHERE type='float' AND res_id IS NULL AND company_id=company;
        -- If not found search the default for all companies
        IF NOT FOUND THEN
            SELECT * INTO res FROM ir_property WHERE type='float' AND res_id IS NULL AND company_id IS NULL;
            -- Not default, return 0.0
            IF NOT FOUND THEN
                RETURN 0.0;
            END IF;
        END IF;
    END IF;

    RETURN res.value_float;
END;

$BODY$
LANGUAGE 'plpgsql';

return {
  postgres = {
    up = [[
      DO $$
      BEGIN
        ALTER TABLE IF EXISTS ONLY "certificates" ADD "cert_alt" TEXT;
      EXCEPTION WHEN DUPLICATE_COLUMN THEN
        -- Do nothing, accept existing state
      END;
      $$;

      DO $$
      BEGIN
        ALTER TABLE IF EXISTS ONLY "certificates" ADD "key_alt" TEXT;
      EXCEPTION WHEN DUPLICATE_COLUMN THEN
        -- Do nothing, accept existing state
      END;
      $$;
    ]],
  },
  cassandra = {
    up = [[
      ALTER TABLE certificates ADD cert_alt TEXT;
      ALTER TABLE certificates ADD key_alt TEXT;
    ]],
  }
}

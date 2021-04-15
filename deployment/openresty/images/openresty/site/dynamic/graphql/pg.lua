
local postgresql = require( 'pgmoon' )

local pg = postgresql.new( {
    host = "postgresql.default.svc.cluster.local",
    port = "5432",
    database = "umia",
    user = "postgres",
    password = "admin123"
} )

return pg

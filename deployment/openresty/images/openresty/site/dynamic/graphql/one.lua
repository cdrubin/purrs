
local inspect = require ( 'inspect' )

ngx.header.content_type = 'text/html';
ngx.say( 'hello' )

local pg = require( 'graphql/pg' )

assert ( pg:connect() )
local res = assert( pg:query( 'SELECT * FROM pg_catalog.pg_tables WHERE schemaname != \'pg_catalog\' AND schemaname != \'information_schema\';' ) )
        
ngx.say( '<h2>postgresql</h2>' 
ngx.say( '<pre style="font-size: 18px">' )
ngx.say( inspect( res ) )
ngx.say( '</pre>' )

local ok, err = pg:keepalive()
pg = nil

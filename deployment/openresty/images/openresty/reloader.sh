#! /bin/sh

wimbly_process() {
    # preprocess the endpoints.nginx.template files into endpoints.nginx configuration files
    luajit -l util -e "require( 'wimbly' ).preprocess( '/usr/local/openresty/site/dynamic', {  ['prefix'] = '', ['dynamic'] = '/usr/local/openresty/site/dynamic' }, { ['debug'] = true } )"
    
    # add response error display
    # luajit -l util -e "require( 'wimbly' ).debug( '/usr/local/openresty/site/dynamic', 'endpoints%.nginx$' )"
}

wimbly_process

while true; do

    inotifywait -r -e create -e modify -e delete -e move /usr/local/openresty/site/dynamic 2> /dev/null
    
    wimbly_process
    
    /usr/local/openresty/bin/openresty -t &> /dev/null
    if [ $? -eq 0 ]; then
        /usr/local/openresty/bin/openresty -s reload
    else
        /usr/local/openresty/bin/openresty -t
    fi

done
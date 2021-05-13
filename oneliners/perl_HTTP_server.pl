# Start up an HTTP server quickly from your working directory
# Requires CPAN module: $ cpan HTTP::Server::Brick

perl -MHTTP::Server::Brick -e '$s=HTTP::Server::Brick->new(port=>8888); $s->mount("/"=>{path=>"."}); $s->start'

use strict;
use warnings;
use HTTP::Server::Brick;
use HTTP::Status;
 
my $server = HTTP::Server::Brick->new( port => 8888 );
 
$server->mount( '/foo/bar' => {
    path => '/some/directory/htdocs',
});
 
$server->mount( '/test/proc' => {
    handler => sub {
        my ($req, $res) = @_;
        $res->add_content("<html><body>
                             <p>Path info: $req->{path_info}</p>
                           </body></html>");
        1;
    },
    wildcard => 1,
});
 
$server->mount( '/test/proc/texty' => {
    handler => sub {
        my ($req, $res) = @_;
        $res->add_content("flubber");
        $res->header('Content-type', 'text/plain');
        1;
    },
    wildcard => 1,
});
 
# these next two are equivalent
$server->mount( '/favicon.ico' => {
    handler => sub { RC_NOT_FOUND },
});
$server->mount( '/favicon.ico' => {
    handler => sub {
        my ($req, $res) = @_;
        $res->code(RC_NOT_FOUND);
        1;
    },
});

$server->start;

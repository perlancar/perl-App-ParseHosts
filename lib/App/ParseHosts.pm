package App::ParseHosts;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

$SPEC{parse_hosts} = {
    v => 1.1,
    summary => 'Parse /etc/hosts',
    args => {
        filename => {
            schema => 'filename*',
            cmdline_aliases => {f=>{}},
        },
    },
};
sub parse_hosts {
    my %args = @_;

    my %ph_args;
    if (defined(my $fn = $args{filename})) {
        my $content;
        local $/;
        if ($fn eq '-') {
            $content = <STDIN>;
        } else {
            open my $fh, "<", $fn or return [500, "Can't open $fn: $!"];
            $content = <$fh>;
        }
        $ph_args{content} = $content;
    }
    require Parse::Hosts;
    Parse::Hosts::parse_hosts(%ph_args);
}

1;
# ABSTRACT: Parse /etc/hosts (CLI)

=head1 SEE ALSO

L<Parse::Hosts>

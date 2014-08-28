# -*- mode: cperl -*-
# ${license-info}
# ${author-info}
# ${build-info}

use strict;
use warnings;
use Test::More tests => 6;
use Test::NoWarnings;
use Test::Quattor qw(https);
use NCM::Component::aiiserver;
use Readonly;
use CAF::Object;

Test::NoWarnings::clear_warnings();

=pod

=head1 SYNOPSIS

Test for https configuration used for serving profiles. Paramaters for https are
retrieved from ncm-ccm configuration.

=cut

use constant AII_SHELLFE_CONF => "# File generated by ncm-aiiserver
# Do not edit
cdburl = http://quattor.web.lal.in2p3.fr/profiles
nbpdir = /tftpboot/quattor/pxelinux.cfg
osinstalldir = /www/quattor/ks
profile_format = json
use_fqdn = 1
ca_dir = /etc/grid-security/certificates
ca_file = CERN-TCA.pem
cert_file = my-host-cern.pem
key_file = my-host-key.pem
";
use constant AII_DHCP_CONF => "# File generated by ncm-aiiserver
# Do not edit
dhcpconf = /dhcp/conf/quattor/dhcpd.conf.aii
restartcmd = /dhcp/scripts/dhcp_rebuild_db
";

$CAF::Object::NoAction = 1;

my $comp = NCM::Component::aiiserver->new('aiiserver');

my $cfg = get_config_for_profile('https');

my $config = get_config_for_profile("https");

$comp->Configure($config);

my $fh = get_file("/etc/aii/aii-shellfe.conf");
ok(defined($fh), "aii-shellfe.conf was opened");
is("$fh", AII_SHELLFE_CONF, "aii-shellfe.conf has expected contents");
$fh->close();

$fh = get_file("/etc/aii/aii-dhcp.conf");
ok(defined($fh), "aii-dhcp.conf was opened");
is("$fh", AII_DHCP_CONF, "aii-dhcp.conf has expected contents");
$fh->close();

Test::NoWarnings::had_no_warnings();

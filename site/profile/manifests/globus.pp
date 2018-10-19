class profile::globus::base (String $globus_user = '', String $globus_password = '')
{
  package { 'globus-connect-server-repo':
    ensure   => 'installed',
    name     => 'globus-toolkit-repo-6.0.14-1.noarch',
    provider => 'rpm',
    source   => 'https://downloads.globus.org/toolkit/globus-connect-server/globus-connect-server-repo-latest.noarch.rpm'
  }

  package { 'globus-connect-server':
    ensure  => 'installed',
    require => [Package['yum-plugin-priorities'],
                Package['globus-connect-server-repo']]
  }

  $domain_name = lookup('profile::freeipa::base::domain_name')
  $cluster_name = split($domain_name, '.')[0]
  file { '/etc/globus-connect-server.conf':
    ensure  => 'present',
    content => epp('profile/globus/globus-connect-server.conf', { 'domain_name' => $domain_name,
                                                                  'hostname'    => $cluster_name }),
  }

  if ($globus_user != '') and ($globus_password != '') {
    exec { '/usr/bin/globus-connect-server-setup':
      environment => ["GLOBUS_USER=${globus_user}",
                      "GLOBUS_PASSWORD=${globus_password}",
                      "HOME=${::root_home}",
                      "TERM=vt100"],
      refreshonly => true,
      require     => Package['globus-connect-server'],
      subscribe   => File['/etc/globus-connect-server.conf'],
    }
  }

}
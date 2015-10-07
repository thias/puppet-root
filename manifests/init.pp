# Class: root
#
# Configure the local root user account.
#
# Sample Usage :
#  include '::root'
#
class root (
  $password                    = undef,
  $comment                     = $::root::params::comment,
  $shell                       = $::root::params::shell,
  $ssh_authorized_keys_ensure  = undef,
  $ssh_authorized_keys_content = undef,
  $ssh_authorized_keys_source  = undef,
  $email_recipient             = undef,
) inherits ::root::params {

  # The user. No, we don't want to support 'absent' :-)
  user { 'root':
    ensure   => 'present',
    password => $password,
    comment  => $comment,
    shell    => $shell,
    home     => '/root',
    uid      => '0',
    gid      => '0',
  }

  # We might want to manage the authorized_keys content, or disable it
  if $ssh_authorized_keys_content != '' or $ssh_authorized_keys_source != '' {
    file { '/root/.ssh':
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0700',
    }
  }
  if ( $ssh_authorized_keys_content != '' or $ssh_authorized_keys_source != '' ) or $ssh_authorized_keys_ensure == 'absent' {
    file { '/root/.ssh/authorized_keys':
      ensure  => $ssh_authorized_keys_ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      content => $ssh_authorized_keys_content,
      source  => $ssh_authorized_keys_source,
    }
  }

  # We usually don't want root email to get ignored
  if $email_recipient {
    mailalias { 'root':
      recipient => $email_recipient,
      target    => $::root::params::mailalias_target,
      notify    => Exec['root-newaliases'],
    }
    exec { 'root-newaliases':
      command     => '/usr/bin/newaliases',
      refreshonly => true,
    }
  }

}


class root::params {

  $comment = 'root'
  $shell = '/bin/bash'
  $password = $::root_pw

  case $::operatingsystem {
    'Gentoo': {
      $mailalias_target = '/etc/mail/aliases'
    }
    default: {
      $mailalias_target = '/etc/aliases'
    }
  }

}


class root::params {

  $comment = 'root'
  $shell = '/bin/bash'

  case $::operatingsystem {
    'Gentoo': {
      $mailalias_target = '/etc/mail/aliases'
    }
    default: {
      $mailalias_target = '/etc/aliases'
    }
  }

}


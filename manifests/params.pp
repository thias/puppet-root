class root::params {

  $comment = 'root'
  $shell = '/bin/bash'

  case $facts['os']['name'] {
    'Gentoo': {
      $mailalias_target = '/etc/mail/aliases'
    }
    default: {
      $mailalias_target = '/etc/aliases'
    }
  }

}


# puppet-root

## Overview

This is a very simple module to configure the local root user account,
typically to lock it down.

* `root` : Class to configure the local root user account.

Including the main class without specifying any parameters shouldn't change
anything, since it will just ensure that the root account exists with its
default attributes (uid 0, gid 0, /root home, 'root' name).

## Examples

From hiera :

    ---
    classes:
      '::root'
    root::password: '$6$0V82Ibo2$TRTehe1A1d9WFl1a3e3qgEfXBotOZSZRn5egcyMtl1a3q/EkzWPClaIaXn5egcyMtL83ga.NpNAzO4dlaIaX51'
    root::ssh_authorized_keys_ensure: absent
    root::email_recipient: 'root@example.com'

Note that you can use the following to disable password-based access to the
account (typically when using sudo) :

    root::password: '*'


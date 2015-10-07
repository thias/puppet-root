# puppet-root

## Overview

This is a very simple module to configure the local root user account,
typically to lock it down and keep it that way.

* `::root` : Class to configure the local root user account.

Including the main class without specifying any parameters shouldn't change
anything, since it will just ensure that the root account exists with its
default attributes (uid 0, gid 0, /root home, 'root' name).

Main class parameters (all default to `undef` unless otherwise specificed) :
* `$password` : Account password hash.
* `$comment` : Account passwd comment. Default : OS specific original value
* `$shell` : Account passwd shell. Default : OS specific original value
* `$ssh_authorized_keys_ensure` : `$ensure` for `/root/.ssh/authorized_keys`
* `$ssh_authorized_keys_content` : `$content` for `/root/.ssh/authorized_keys`
* `$ssh_authorized_keys_source` : `$source` for `/root/.ssh/authorized_keys`
* `$email_recipient` : Email forward recipient.

## Examples

From hiera, enforcing a specific password, denying `/root/.ssh/authorized_keys`
presence and forwarding local email to an external address :
```yaml
---
classes:
  '::root'
root::password: '$6$0V82Ibo2$TRTehe1A1d9WFl1a3e3qgEfXBotOZSZRn5egcyMtl1a3q/EkzWPClaIaXn5egcyMtL83ga.NpNAzO4dlaIaX51'
root::ssh_authorized_keys_ensure: 'absent'
root::email_recipient: 'root@example.com'
```

Note that you can use the following to disable password-based access to the
account (typically when using only sudo) :
```yaml
root::password: '*'
```


warm_standby
---

In theory, this backs up an entire all-in-one PE3 puppet master out of the box. There are some modifications in place to deal with open source puppet masters. replicate::folder supports rsync exceptions.

Default folders backed up:

- /etc/puppetlabs
- /opt/puppet

Default postgres databases backed up:

- console
- console_auth
- pe-postgres
- pe-puppetdb

To review databases run:

~~~
sudo -u pe-postgres /opt/puppet/bin/psql -c '\list'
~~~

Major tip of the hat to <http://projects.puppetlabs.com/issues/22125>

Support
-------

Please log tickets and issues here on github.

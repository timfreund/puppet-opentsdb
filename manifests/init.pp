# == Class: opentsdb
#
# Configure OpenTSDB
#
# === Parameters
#
# None

# === Variables
#
# None
#
# === Examples
#
#  include opentsdb
#
# === Authors
#
# Tim Freund <tim@freunds.net>
#
# === Copyright
#
# Copyright 2014 Tim Freund
#
class opentsdb {
  package {'gnuplot':
    ensure => installed,
  }
  package {'openjdk-7-jre-headless':
    ensure => installed,
  }

  file {'/tmp/hbase-install.sh':
    source => "puppet:///modules/opentsdb/hbase-install.sh",
    mode => 700,
    owner => root,
    group => root,
  }

  file {'/tmp/hbase-site.xml':
    source => 'puppet:///modules/opentsdb/hbase-site.xml',
    mode => 644,
    owner => root,
    group => root,
  }

  file {'/tmp/opentsdb-install.sh':
   source => "puppet:///modules/opentsdb/opentsdb-install.sh",
    mode => 700,
    owner => root,
    group => root,
  }

  exec { 'hbase-install':
    command => '/tmp/hbase-install.sh',
  }

  exec { 'opentsdb-install':
    command => '/tmp/opentsdb-install.sh',
  }

  service { 'opentsdb':
    enable => true,
  }

  Package['openjdk-7-jre-headless'] -> Exec['hbase-install']
  File['/tmp/hbase-site.xml'] -> Exec['hbase-install']
  File['/tmp/hbase-install.sh'] -> Exec['hbase-install']
  File['/tmp/opentsdb-install.sh'] -> Exec['opentsdb-install']
  Exec['hbase-install'] -> Exec['opentsdb-install']
  Exec['opentsdb-install'] -> Service['opentsdb']

  # set JAVA_HOME to /usr/lib/jvm/java-7-openjdk-amd64
  # env COMPRESSION=NONE HBASE_HOME=/opt/hbase ./tools/create_table.sh
}

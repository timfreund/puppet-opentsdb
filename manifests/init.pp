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
  package {'openjdk-7-jre-headless':
    ensure => installed,
  }

}

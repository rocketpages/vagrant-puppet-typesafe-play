# Basic Puppet Apache manifest

class apache {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  package { "apache2":
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }
}

class typesafe {
  exec { 'install typesafe repository':
    command => 'sudo dpkg -i /vagrant/dependencies/repo-deb-build-0002.deb',
    path => '/bin:/usr/bin'
  }

  exec { 'apt-get update for typesafe':
    command => '/usr/bin/apt-get update',
    require => Exec["install typesafe repository"]
  }

  package { "openjdk-6-jdk":
    ensure => present,
  }

  package { "typesafe-stack":
    ensure => present,
    require => Exec["apt-get update for typesafe"]
  } 

  exec { 'install scala':
    command => 'sudo tar -C /opt/ -xvzf /vagrant/dependencies/scala-2.9.0.1.tgz',
    path => '/bin:/usr/bin'
  }

  file { "/etc/profile.d/export_scala_path.sh":
    ensure => present,
    source => "/vagrant/dependencies/export_scala_path.sh",
    require => Exec["install scala"]
  }
}

include apache
include typesafe
# Manifest for Typesafe Development Environment

class git {
  exec { 'apt-get update for git':
    command => '/usr/bin/apt-get update'
  }

  exec { 'install git':
    command => 'sudo tar -C /opt/ -xvzf /vagrant/dependencies/packages/git-1.8.0.1.tar.gz',
    path => '/bin:/usr/bin'
  }

  package { "libcurl4-gnutls-dev": ensure => present, require => Exec["apt-get update for git"] }
  package { "libexpat1-dev": ensure => present, require => Exec["apt-get update for git"] }
  package { "gettext": ensure => present, require => Exec["apt-get update for git"] }
  package { "libz-dev": ensure => present, require => Exec["apt-get update for git"] }
  package { "libssl-dev": ensure => present, require => Exec["apt-get update for git"] }
  package { "build-essential": ensure => present, require => Exec["apt-get update for git"] }

  exec { 'make git all': 
    command => 'make prefix=/usr/local all',
    path => '/bin:/usr/bin',
    cwd     => '/opt/git-1.8.0.1',
    require => [
      Exec["install git"],
      Package["libcurl4-gnutls-dev"],
      Package["libexpat1-dev"],
      Package["gettext"],
      Package["libz-dev"],
      Package["libssl-dev"],
      Package["build-essential"]
    ]
  }

  exec { 'make git install': 
    command => 'sudo make prefix=/usr/local install', 
    path => '/bin:/usr/bin',
    cwd     => '/opt/git-1.8.0.1',
    require => Exec["make git all"]
  }      
}

class typesafe {
  exec { 'install typesafe repository':
    command => 'sudo dpkg -i /vagrant/dependencies/packages/repo-deb-build-0002.deb',
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
    command => 'sudo tar -C /opt/ -xvzf /vagrant/dependencies/packages/scala-2.9.0.1.tgz',
    path => '/bin:/usr/bin'
  }

  file { "/etc/profile.d/export_scala_path.sh":
    ensure => present,
    source => "/vagrant/dependencies/path_scripts/export_scala_path.sh",
    require => Exec["install scala"]
  }

  package { "zip":
    ensure => present,
  }

  exec { 'install play':
    command => 'sudo unzip -o /vagrant/dependencies/packages/play-2.0.4.zip -d /opt',
    path => '/bin:/usr/bin',
    require => Package["zip"]
  }

  file { "/etc/profile.d/export_play_path.sh":
    ensure => present,
    source => "/vagrant/dependencies/path_scripts/export_play_path.sh",
    require => Exec["install play"]
  } 
}

class sampleApp {
  exec { 'stage play':
    command => '/opt/play-2.0.4/play clean compile stage',
    path => '/bin:/usr/bin',
    cwd     => '/opt/play-2.0.4/samples/scala/websocket-chat',
    require => [
      File["/etc/profile.d/export_play_path.sh"],
      Exec["install play"]
    ]
  }

  exec { 'run play':
    command => '/opt/play-2.0.4/samples/scala/websocket-chat/target/start &',
    path => '/bin:/usr/bin',
    require => Exec["stage play"]
  }  
}

include git
include typesafe
include sampleApp
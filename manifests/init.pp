# == Class: pypy
#
# Module to install an up-to-date version of Pypy from the
# official PPA. The use of the PPA means this only works
# on Ubuntu.
#
# === Parameters
# [*version*]
#   The package version to install, passed to ensure.
#   Defaults to present.
#
class pypy(
  $version = 'present',
  $package_name = 'pypy',
) {
  include apt
  validate_string($version)
  validate_re($::osfamily, '^Debian$', 'This module uses PPA repos and only works with Debian based distros')

  apt::ppa { 'ppa:pypy/ppa': }

  package { 'pypy':
    ensure  => $version,
    name    => $package_name,
    require => Apt::Ppa['ppa:pypy/ppa'],
  }
}

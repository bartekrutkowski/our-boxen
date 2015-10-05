require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::homebrewdir}/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include git
  include iterm2::stable
  include iterm2::colors::solarized_dark
  include xtrafinder
  include fonts::adobe::sourcecodepro
  include sublime_text
  include sourcetree
  include dropbox

  sublime_text::package { 'Anaconda':
    source => 'DamnWidget/Anaconda'
  }
  sublime_text::package { 'GitSavvy':
    source => 'divmain/GitSavvy'
  }
  sublime_text::package { 'VcsGutter':
    source => 'titoBouzout/SideBarEnhancements'
  }
  sublime_text::package { 'SideBarEnhancements':
    source => 'bradsokol/VcsGutter'
  }
  sublime_text::package { 'ThemeSpacegray':
    source => 'kkga/spacegray'
  }
  sublime_text::package { 'ThemeTomorrowNight':
    source => 'chriskempson/tomorrow-theme'
  }
  sublime_text::package { 'Jinja2':
    source => 'chrisgeo/jinja2-tmbundle'
  }
  sublime_text::package { 'Requirementstxt':
    source => 'wuub/requirementstxt'
  }
  sublime_text::package { 'PrettyJson':
    source => 'dzhibas/SublimePrettyJson'
  }

  appstore::app { 'Wunderlist':
    source => 'wunderlist-to-do-list-tasks/id410628904'
  }
  appstore::app { 'Evernote':
    source => 'evernote/id406056744'
  }
  appstore::app { '1Password':
    source => '1password-password-manager/id443987910'
  }

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # common, useful packages
  package {
    [
      'openconnect',
    ]:
  }
  package {
    [
      'atom',
      'dropbox',
      'flux',
      'google-chrome',
      'iterm2',
      'microsoft-lync',
      'packer',
      'sourcetree',
      'spectacle',
      'transmission',
      'tunnelblick',
      'vagrant',
      'virtualbox',
      'virtualbox-extension-pack',
      'vlc',
    ]: provider => 'brewcask'
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}

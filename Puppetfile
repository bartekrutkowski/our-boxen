# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod "puppet-#{name}", :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.11.0"

# Support for default hiera data in modules

github "module_data", "0.0.4", :repo => "ripienaar/puppet-module-data"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "brewcask",    "0.0.6"
github "gcc",         "3.0.2"
github "git",         "2.7.92"
github "homebrew",    "1.13.0"
github "inifile",     "1.4.1", :repo => "puppetlabs/puppetlabs-inifile"
github "pkgconfig",   "1.0.0"
github "repository",  "2.4.1"
github "stdlib",      "4.7.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",        "1.0.0"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.

github "firefox",     "1.2.3"
github "iterm2",      "1.2.5"
github "fonts",       "0.0.3"
github "appstore",    "0.0.6", :repo => "xdissent/puppet-appstore"
github "sublime_text","1.1.0"
github "sourcetree",  "1.0.0"
github "dropbox",     "1.4.1"

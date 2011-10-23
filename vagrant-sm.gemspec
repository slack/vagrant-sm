Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  s.name              = 'vagrant-sm'
  s.version           = '0.0.1'
  s.rubyforge_project = 'vagrant-sm'

  ## Make sure your summary is short. The description may be as long
  ## as you like.
  s.summary     = "Provision Vagrant boxes with SM Framework."
  s.description = "Vagrant provisioner for S{cripting,ystem,tack} Management Framework"

  ## List the primary authors. If there are a bunch of authors, it's probably
  ## better to set the email to an email list or something. If you don't have
  ## a custom homepage, consider using your GitHub URL or the like.
  s.authors  = ["Jason Hansen"]
  s.email    = 'jason@slack.io'
  s.homepage = 'https://github.com/slack/vagrant-sm'

  s.require_paths = %w[lib]

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md]

  # = MANIFEST =
  s.files = %w[
    README.md
    Rakefile
    lib/vagrant-sm.rb
    vagrant-sm.gemspec
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end

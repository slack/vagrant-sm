module Vagrant
  module Provisioners
    class SM < Base
      VERSION = '0.0.2'

      register :sm

      class Config < Vagrant::Config::Base
        attr_accessor :version
        attr_accessor :pre_install_commands
        attr_accessor :extensions
        attr_accessor :sets
        attr_accessor :post_install_commands

        def initialize
          @version               = 'head'
          @pre_install_commands  = []
          @extensions            = []
          @sets                  = []
          @post_install_commands = []
        end

        def version=(version)
          @version = version
        end

        def pre_install_command(command)
          pre_install_commands << command
        end

        def post_install_command(command)
          post_install_commands << command
        end

        def add_extension(extension_hash)
          extensions << extension_hash
        end

        def add_set(set_hash)
          sets << set_hash
        end
      end

      def provision!
        run_pre_install_commands
        install_sm config.version
        install_extensions
        install_sets
        run_post_install_commands
      end

      def run_pre_install_commands
        execute config.pre_install_commands
      end

      def run_post_install_commands
        execute config.post_install_commands
      end

      def execute(commands)
        vm.ssh.execute do |ssh|
          commands.each do |command|
            ssh.sudo! command
          end
        end
      end

      def sm_command(command)
        vm.ssh.execute do |ssh|
          ssh.sudo! "sm #{command}"
        end
      end

      def install_sets
        config.sets.each do |set|
          sm_command "sets add #{set[:name]} #{set[:uri]}"
          sm_command set[:install] if set[:install]
        end
      end

      def install_extensions
        config.extensions.each do |set|
          sm_command "ext install #{ext[:name]} #{ext[:uri]}"
          sm_command ext[:install] if ext[:install]
        end
      end

      def install_sm(version)
        archive_url = url_for version

        vm.ssh.execute do |ssh|
          ssh.sudo! "curl -L #{archive_url} -o /tmp/sm-#{version}.tar.gz"
          ssh.sudo! extract(version)
          ssh.sudo! "cd /tmp/sm-#{version} && ./install"
          ssh.sudo! cleanup_install(version)
        end
      end

      def cleanup_install(version)
        "rm -rf /tmp/sm-#{version}.tar.gz /tmp/sm-#{version}"
      end

      def url_for(version)
        if version == 'head'
          "https://github.com/sm/sm/tarball/master"
        else
          "https://bdsm.beginrescueend.com/releases/sm-#{version}.tar.gz"
        end
      end

      def extract(version)
        if version == 'head'
          "tar -C /tmp -zxf /tmp/sm-#{version}.tar.gz && mv /tmp/sm-sm-* /tmp/sm-head"
        else
          "tar -C /tmp -zxf /tmp/sm-#{version}.tar.gz"
        end
      end

    end # class SM
  end # module Provisioners
end # module Vagrant

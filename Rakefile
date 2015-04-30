require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "tempfile"
require "net/ssh"
require "io/console"
require "unix_crypt"

VAGRANT_HOSTNAME = "centos7_base-spec-centos7"

desc "Run provisining vagrant and serverspec tests"
task integration: ["integration:provision", "integration:spec"]

namespace :integration do
  desc "Provision Vagrant"
  task :provision do
    env = {"VAGRANT_CWD" => File.expand_path("./spec/integration")}
    tmp_ssh_config = Tempfile.new("", Dir.tmpdir)

    Bundler.with_clean_env do
      system(env, "vagrant up #{VAGRANT_HOSTNAME}") || abort
      system(env, "vagrant ssh-config #{VAGRANT_HOSTNAME} > #{tmp_ssh_config.path}") || abort

      ssh_option = Net::SSH::Config.for(VAGRANT_HOSTNAME, [tmp_ssh_config.path])

      cmd = [
        "bundle exec itamae ssh",
        "-h #{ssh_option[:host_name]}",
        "-u #{ssh_option[:user]}",
        "-p #{ssh_option[:port]}",
        "-i #{ssh_option[:keys].first}",
        "-l debug",
        "--node-yaml spec/integration/node.yml",
        "spec/integration/recipe.rb"
      ]

      cmd << "--dry-run" if ENV["DRY_RUN"]

      cmd_str = cmd.join(" ")
      puts cmd_str
      system(cmd_str) || abort
    end
  end

  desc "Run serverspec tests"
  RSpec::Core::RakeTask.new(:spec) do |t|
    ENV["TARGET_HOST"] = VAGRANT_HOSTNAME
    t.ruby_opts = "-I ./spec/integration"
    t.pattern = "spec/integration/*_spec.rb"
  end
end


SALT_CHARSET = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

desc "Make password hash (SHA-512)"
task :mkpasswd do
  print "password: "
  pass = STDIN.noecho(&:gets).chomp
  puts

  salt = (0..7).inject(""){ |s,i| s << SALT_CHARSET[rand(64)] }
  puts UnixCrypt::SHA512.build(pass, salt)
end

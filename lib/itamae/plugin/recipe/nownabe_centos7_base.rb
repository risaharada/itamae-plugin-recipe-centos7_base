require "itamae/plugin/recipe/nownabe_centos7_base/version"

include_recipe "nownabe_centos7_base::disable_selinux"
include_recipe "nownabe_centos7_base::yum-cron"
include_recipe "nownabe_centos7_base::users"
include_recipe "nownabe_centos7_base::mailto"
include_recipe "nownabe_centos7_base::enable_wheel"
include_recipe "nownabe_centos7_base::sshd_config"


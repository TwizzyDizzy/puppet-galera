# @summary Installs MySQL/MariaDB with galera cluster plugin
#
# @param additional_packages
#   Specifies a list of additional packages that may be required for SST and
#   other features. Valid options: an array. Default: A vendor-, version- and
#   OS-specific value.
#
# @param bind_address
#   Specifies the IP address to bind MySQL/MariaDB to. The module expects the
#   server to listen on localhost for proper operation. Valid options: a string.
#   Default: `::`
#
# @param bootstrap_command
#   Specifies a command used to bootstrap the galera cluster. Valid options:
#   a string. Default: A vendor-, version- and OS-specific bootstrap command.
#
# @param client_package_name
#   Specifies the name of the MySQL/MariaDB client package to install. Valid
#   options: a string. Default: A vendor-, version- and OS-specific value.
#
# @param configure_firewall
#   Specifies wether to open firewall ports used by galera using
#    puppetlabs-firewall. Valid options: `true` and `false`. Default: `true`
#
# @param configure_repo
#   Specifies wether to configure additional repositories that are requird for
#   installing galera. Valid options: `true` and `false`. Default: `true`
#
# @param create_root_my_cnf
#   A flag to indicate if we should manage the root .my.cnf. Set this to false
#   if you wish to manage your root .my.cnf file elsewhere. Valid options:
#   `true` and `false`. Default: `true`
#
# @param create_root_user
#   A flag to indicate if we should manage the root user. Set this to false if
#   you wish to manage your root user elsewhere. If this is set to undef, we
#   will use true if galera_master == $::fqdn. Valid options: a string or
#   undef. Default: `undef`
#
# @param create_status_user
#   A flag to indicate if we should manage the status user. Set this to false
#   if you wish to manage your status user elsewhere. Valid options: `true`
#    and `false`. Default: `true`
#
# @param deb_sysmaint_password
#   Specifies the password to set on Debian/Ubuntu for the sysmaint user used
#   during updates. Valid options: a string. Default: `sysmaint`
#
# @param default_options
#   Internal parameter, *do NOT change!* Use `$override_options` to customize
#   MySQL options.
#
# @param galera_master
#   Specifies the node that will bootstrap the cluster if all nodes go down.
#   Valid options: a string. Default: `$fqdn`
#
# @param galera_package_ensure
#   Specifies the ensure state for the galera package. Note that some vendors
#   do not allow installation of the wsrep-enabled MySQL/MariaDB and galera
#   (arbitrator) on the same server. Valid options: all values supported by
#   the package type. Default: `absent`
#
# @param galera_package_name
#   Specifies the name of the galera wsrep package to install. Valid options:
#   a string. Default: A vendor-, version- and OS-specific value.
#
# @param galera_servers
#   Specifies a list of IP addresses of the nodes in the galera cluster.
#   Valid options: an array. Default: `[${facts['networking']['ip']}]`
#
# @param local_ip
#   Specifies the IP address of this node to use for communications.
#   Valid options: a string. Default: `$networking.ip`
#
# @param manage_additional_packages
#   Specifies wether additional packages should be installed that may be
#   required for SST and other features. Valid options: `true` and `false`.
#   Default: `true`
#
# @param manage_package_nmap
#   Specifies wether the package nmap should be installed. It is required
#   for proper operation of this module. Valid options: `true` and `false`.
#   Default: `true`
#
# @param mysql_package_name
#   Specifies the name of the server package to install. Valid options:
#   a string. Default: A vendor-, version- and OS-specific value.
#
# @param mysql_port
#   Specifies the port to use for MySQL/MariaDB. Valid options: a string.
#   Default: `3306`
#
# @param mysql_restart
#   Specifies the option to pass through to `mysql::server::restart`. This can
#   cause issues during bootstrapping if switched on. Valid options: `true`
#   and `false`. Default: `false`
#
# @param mysql_service_name
#   Specifies the option to pass through to `mysql::server`. Valid options:
#   a string. Default: A vendor-, version- and OS-specific value.
#
# @param override_options
#   Specifies options to pass to `mysql::server` class. See the puppetlabs-mysql
#   documentation for more information. Valid options: a hash. Default: `{}`
#
# @param package_ensure
#   Specifies the ensure state for packages. Valid options: all values supported
#   by the package type. Default: `installed`
#
# @param purge_conf_dir
#   Specifies the option to pass through to `mysql::server`.
#   Valid options: `true` and `false`. Default: `true`
#
# @param root_password
#   Specifies the MySQL/MariaDB root password. Valid options: a string.
#
# @param rundir
#   Specifies the rundir for the MySQL/MariaDB service.
#   Valid options: a string. Default: `/var/run/mysqld`
#
# @param service_enabled
#   Specifies wether the MySQL/MariaDB service should be enabled.
#   Valid options: `true` and `false`. Default: `true`
#
# @param status_allow
#   Specifies the subnet or host(s) (in MySQL/MariaDB syntax) to allow status
#   checks from. Valid options: a string. Default: `%`
#
# @param status_available_when_donor
#   Specifies wether the node will remain in the cluster when it enters donor
#   mode. Valid options: `0` (remove), `1` (remain). Default: `0`
#
# @param status_available_when_readonly
#   When set to 0, clustercheck will return a "503 Service Unavailable" if the
#   node is in the read_only state, as defined by the `read_only` MySQL/MariaDB
#   variable. Values other than 0 have no effect. Valid options: an integer.
#   Default: `-1`
#
# @param status_check
#   Specifies wether to configure a user and script that will check the status
#   of the galera cluster. Valid options: `true` and `false`. Default: `true`
#
# @param status_host
#   Specifies the cluster to add the cluster check user to.
#   Valid options: a string. Default: `localhost`
#
# @param status_log_on_failure
#   Specifies which fields xinetd will log on failure.
#   Valid options: a string. Default: `undef`
#
# @param status_log_on_success
#   Specifies which fields xinetd will log on success.
#   Valid options: a string. Default: `''`
#
# @param status_log_on_success_operator
#   Specifies which operator xinetd uses to output logs on success.
#   Valid options: a string. Default: `=`
#
# @param status_password
#   Specifies the password of the status check user. Valid options: a string.
#
# @param status_port
#   Specifies the port for cluster check service.
#   Valid options: an integer. Default: `9200`
#
# @param status_user
#   Specifies the name of the user to use for status checks.
#   Valid options: a string: Default: `clustercheck`
#
# @param validate_connection
#   Specifies wether the module should ensure that the cluster can accept
#   connections at the point where the `mysql::server` resource is marked
#   as complete. This is used because after returning success, the service
#   is still not quite ready. Valid options: `true` and `false`. Default: `true`
#
# @param vendor_type
#   Specifies the galera vendor (or flavour) to use.
#   Valid options: codership, mariadb, percona. Default: `percona`
#
# @param vendor_version
#   Specifies the galera version to use. To avoid accidential updates,
#   set this to the required version. Valid options: a string.
#   Default: A vendor- and OS-specific value. (Usually the most recent version.)
#
# @param wsrep_group_comm_port
#   Specifies the port to use for galera clustering.
#   Valid options: an integer. Default: `4567`
#
# @param wsrep_inc_state_transfer_port
#   Specifies the port to use for galera incremental state transfer.
#   Valid options: an integer. Default: `4568`
#
# @param wsrep_sst_auth
#   Specifies the authentication information to use for SST.
#   Valid options: a string. Default: `root:<%= $root_password %>`
#
# @param wsrep_sst_method
#   Specifies the method to use for state snapshot transfer between nodes.
#   Valid options: mysqldump, rsync, skip, xtrabackup, xtrabackup-v2 (Percona).
#   Default: `rsync`
#
# @param wsrep_state_transfer_port
#   Specifies the port to use for galera state transfer.
#   Valid options: an integer. Default: `4444`
#
class galera(
  # parameters that need to be evaluated early
  Enum['codership', 'mariadb', 'osp5', 'percona'] $vendor_type,
  # required parameters
  String $bind_address,
  Boolean $configure_firewall,
  Boolean $configure_repo,
  Boolean $create_root_my_cnf,
  Boolean $create_status_user,
  String $deb_sysmaint_password,
  Hash $default_options,
  String $galera_master,
  String $galera_package_ensure,
  String $grep_binary,
  String $local_ip,
  Boolean $manage_additional_packages,
  Boolean $manage_package_nmap,
  String $mysql_binary,
  Integer $mysql_port,
  Boolean $mysql_restart,
  Hash $override_options,
  String $package_ensure,
  Boolean $purge_conf_dir,
  String $root_password,
  String $rundir,
  Boolean $service_enabled,
  String $status_allow,
  Integer $status_available_when_donor,
  Integer $status_available_when_readonly,
  Boolean $status_check,
  String $status_host,
  String $status_log_on_success_operator,
  String $status_password,
  Integer $status_port,
  String $status_user,
  Boolean $validate_connection,
  Integer $wsrep_group_comm_port,
  Integer $wsrep_inc_state_transfer_port,
  String $wsrep_sst_auth,
  Enum['mariabackup', 'mysqldump', 'rsync', 'skip', 'xtrabackup', 'xtrabackup-v2'] $wsrep_sst_method,
  Integer $wsrep_state_transfer_port,
  # optional parameters
  # (some of them are actually required, see notes)
  Optional[Array] $additional_packages = undef,
  Optional[String] $bootstrap_command = undef,
  Optional[String] $client_package_name = undef,
  Optional[String] $create_root_user = undef,
  Optional[String] $galera_package_name = undef,
  Optional[Array] $galera_servers = undef,
  Optional[String] $libgalera_location = undef,
  Optional[String] $mysql_package_name = undef,
  Optional[String] $mysql_service_name = undef,
  Optional[String] $status_log_on_failure = undef,
  Optional[String] $status_log_on_success = undef,
  Optional[String] $vendor_version = undef,
) {
  # Fetch appropiate default values from module data, depending on the values
  # of $vendor_type and $vendor_version.
  # XXX: Originally this was supposed to take place when evaluating the class
  # parameters. Now this is basically an ugly compatibility layer to support
  # overriding parameters in non-hiera configurations (where solely relying
  # on lookup() simply does not work). Should be refactored when a better
  # solution is available.
  if !$vendor_version {
    $vendor_version_real = lookup("${module_name}::${vendor_type}::default_version")
  } else { $vendor_version_real = $vendor_version }
  $vendor_version_internal = regsubst($vendor_version_real, '\.', '', 'G')

  # Percona supports 'xtrabackup-v2', but this value cannot be used in our automatic
  # lookups, so we have to use a temporary value.
  $wsrep_sst_method_internal = regsubst($wsrep_sst_method, '-', '_', 'G')

  if !$additional_packages {
    $additional_packages_real = lookup("${module_name}::sst::${wsrep_sst_method_internal}::${vendor_type}::${vendor_version_internal}::additional_packages", {default_value => undef}) ? {
      undef => lookup("${module_name}::sst::${wsrep_sst_method_internal}::additional_packages", {default_value => undef}),
      default => lookup("${module_name}::sst::${wsrep_sst_method_internal}::${vendor_type}::${vendor_version_internal}::additional_packages")
    }
  } else { $additional_packages_real = $additional_packages }

  # The following compatibility layer (part 2) is only required for parameters
  # that may vary depending on the values of $vendor_version and $vendor_type.
  $params = {
    bootstrap_command => $bootstrap_command,
    client_package_name => $client_package_name,
    galera_package_name => $galera_package_name,
    libgalera_location => $libgalera_location,
    mysql_package_name => $mysql_package_name,
    mysql_service_name => $mysql_service_name,
  }.reduce({}) |$memo, $x| {
    # If a value was specified as class parameter, then use it. Otherwise use
    # lookup() to find a value in Hiera (or to fallback to default values from
    # module data).
    if !$x[1] {
      $_v = lookup("${module_name}::${vendor_type}::${vendor_version_internal}::${$x[0]}", {default_value => undef}) ? {
        undef => lookup("${module_name}::${vendor_type}::${$x[0]}"),
        default => lookup("${module_name}::${vendor_type}::${vendor_version_internal}::${$x[0]}"),
      }
    } else {
      $_v = $x[1]
    }
    $memo + {$x[0] => $_v}
  }

  if $configure_repo {
    include galera::repo
    Class['::galera::repo'] -> Class['mysql::server']
  }

  if $configure_firewall {
    include galera::firewall
  }

  # Debian machines need some help
  if ($facts['os']['family'] == 'Debian') {
    include galera::debian
  }
  # as well as EL7 with MariaDB
  # Puppetlabs/mysql forces to use /var/run/mariadb and /var/log/mariadb but they don't exist
  # so mariadb service won't start. This is amended with galera::mariadb
  if $vendor_type == 'mariadb' and $facts['os']['family'] == 'RedHat' {
    include galera::mariadb
    Class['galera::mariadb'] -> Class['mysql::server::installdb']
  }

  if $status_check {
    include galera::status
  }

  if $validate_connection {
    include galera::validate
  }

  $node_list = join($galera_servers, ',')
  $_wsrep_cluster_address = {
    'mysqld' => {
      'wsrep_cluster_address' => "gcomm://${node_list}/"
    }
  }

  # XXX: The following is sort-of a compatibility layer. It passes all options
  # to the inline_epp() function. This way it is possible to use the values of
  # module parameters in MySQL/MariaDB options by specifying them in epp syntax.
  $wsrep_sst_auth_real = inline_epp($wsrep_sst_auth)
  $_default_options = $default_options.reduce({}) |$memo, $x| {
    # A nested hash contains the configuration options.
    if ($x[1] =~ Hash) {
      $_values = $x[1].reduce({}) |$m,$y| {
        # epp expects a string, so skip all other types.
        if ($y[1] =~ String) {
          $_v = inline_epp($y[1])
        } else {
          $_v = $y[1]
        }
        $m + {$y[0] => $_v}
      }
    } else {
      $_values = $x[1]
    }
    $memo + {$x[0] => $_values}
  }
  $_override_options = $override_options.reduce({}) |$memo, $x| {
    # A nested hash contains the configuration options.
    if ($x[1] =~ Hash) {
      $_values = $x[1].reduce({}) |$m,$y| {
        # epp expects a string, so skip all other types.
        if ($y[1] =~ String) {
          $_v = inline_epp($y[1])
        } else {
          $_v = $y[1]
        }
        $m + {$y[0] => $_v}
      }
    } else {
      $_values = $x[1]
    }
    $memo + {$x[0] => $_values}
  }

  # Finally merge options from all 3 sources.
  $options = $_default_options.deep_merge($_wsrep_cluster_address.deep_merge($override_options))

  if ($create_root_user =~ String) {
    $create_root_user_real = $create_root_user
  } else {
    if ($galera_master == $::fqdn) {
      # manage root user on the galera master
      $create_root_user_real = true
    } else {
      # skip manage root user on nodes that are not the galera master since
      # they should get a database with the root user already configured when
      # they sync from the master
      $create_root_user_real = false
    }
  }

  if ($create_root_my_cnf == true) {
    # Check if we can already login with the given password
    $my_cnf = "[client]\r\nuser=root\r\nhost=localhost\r\npassword='${root_password}'\r\n"

    exec { "create ${::root_home}/.my.cnf":
      command => "/bin/echo -e \"${my_cnf}\" > ${::root_home}/.my.cnf",
      onlyif  => [
        "${mysql_binary} --user=root --password=${root_password} -e 'select count(1);'",
        "/usr/bin/test `/bin/cat ${::root_home}/.my.cnf | ${grep_binary} -c \"password='${root_password}'\"` -eq 0",
        ],
      require => Service['mysqld'],
      before  => [Class['mysql::server::root_password']],
    }
  }

  class { '::mysql::server':
    package_name       => $params['mysql_package_name'],
    override_options   => $options,
    root_password      => $root_password,
    create_root_my_cnf => $create_root_my_cnf,
    create_root_user   => $create_root_user_real,
    service_enabled    => $service_enabled,
    purge_conf_dir     => $purge_conf_dir,
    service_name       => $params['mysql_service_name'],
    restart            => $mysql_restart,
  }

  file { $rundir:
    ensure  => directory,
    owner   => 'mysql',
    group   => 'mysql',
    require => Class['mysql::server::install'],
    before  => Class['mysql::server::installdb']
  }

  if ($manage_additional_packages and $additional_packages_real) {
    ensure_resource(package, $additional_packages_real,
    {
      ensure  => $package_ensure,
      before  => Class['mysql::server::install'],
    })
  }

  Package<| title == 'mysql_client' |> {
    name => $params['client_package_name']
  }

  package {[ $galera::params['galera_package_name'] ] :
    ensure => $galera_package_ensure,
    before => Class['mysql::server::install'],
  }

  if ($::fqdn == $galera_master) {
    # If there are no other servers up and we are the master, the cluster
    # needs to be bootstrapped. This happens before the service is managed
    $server_list = join($galera_servers, ' ')

    if $manage_package_nmap {
      package { 'nmap':
        ensure => $package_ensure,
        before => Exec['bootstrap_galera_cluster']
      }
    }

    # NOTE: Galera >=5.7 on systemd systems should use mysqld_bootstrap.
    #       See http://galeracluster.com/documentation-webpages/startingcluster.html.
    # NOTE: MariaDB >=10.1 on systemd systems should use galera_new_cluster.
    #       See https://mariadb.com/kb/en/library/getting-started-with-mariadb-galera-cluster/.
    exec { 'bootstrap_galera_cluster':
      command  => $params['bootstrap_command'],
      unless   => "nmap -Pn -p ${wsrep_group_comm_port} ${server_list} | grep -q '${wsrep_group_comm_port}/tcp open'",
      require  => Class['mysql::server::installdb'],
      before   => Service['mysqld'],
      provider => shell,
      path     => '/usr/bin:/bin:/usr/sbin:/sbin'
    }

  }
}

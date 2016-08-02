class tic::common (

  $java_home = undef,

) {

  file {'/etc/profile.d/java_home.sh':
    content => "export JAVA_HOME=${java_home}\nexport PATH=\$JAVA_HOME/bin:\$PATH\n"
  }

  if $::t_subenv == 'build' {
    file {'/etc/facter/facts.d/t_static_facts.txt':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      content => template('tic/etc/facter/facts.d/t_static_facts.txt.erb');
    }
  }

}

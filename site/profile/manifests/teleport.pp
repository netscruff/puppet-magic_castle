class profile::teleport::login(
  Boolean $enable
){

  if $enable {
    include ::teleport
  }
}

class profile::teleport::mgmt(
  Boolean $enable
){

  if $enable {
    include ::teleport
  }
}

class profile::teleport::node(
  Boolean $enable
){

  if $enable {
    include ::teleport
  }
}

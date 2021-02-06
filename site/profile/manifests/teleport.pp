class profile::teleport::login(
  boolean $enable
){

  if $enable {
    include ::teleport
  }
}

class profile::teleport::mgmt(
  boolean $enable
){

  if $enable {
    include ::teleport
  }
}

class profile::teleport::node(
  boolean $enable
){

  if $enable {
    include ::teleport
  }
}

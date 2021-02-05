class profile::teleport::base ( Enum['true', 'false'] $enabled ) {
  if ($enabled == 'true') {
    include teleport
  }
}

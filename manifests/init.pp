# This class configures logcheck
#
# @example Standard configuration
#   include logcheck
#   logcheck::package: logcheck
#   logcheck::configfile: /etc/logcheck/logcheck.conf
#   logcheck::config:
#     REPORTLEVEL: server
#     SENDMAILTO: logcheck@example.com
#     ADDTAG: 'yes'
#
# @param package [Array] The name of the logcheck package
# @param configfile [String] The path to logcheck.conf
# @param config [Hash] A hash of changes to make to logcheck.conf
#
class logcheck (
    $package        = 'logcheck',
    $configfile     = '/etc/logcheck/logcheck.conf',
    $config         = {},
){
    validate_string($::logcheck::packages)
    validate_absolute_path($::logcheck::configfile)
    validate_hash($::logcheck::config)

    $changes_array = join_keys_to_values($::logcheck::config, ' ')
    $changes = regsubst($changes_array,'.*','set \0')

    ensure_packages($::logcheck::package)

    augeas { 'configure-logcheck':
        incl    => $::logcheck::configfile,
        lens    => 'Shellvars.lns',
        changes => $::logcheck::changes,
        require => File[$::logcheck::configfile]
    }
}

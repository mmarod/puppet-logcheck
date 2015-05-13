# This class configures logcheck
#
# @example Standard configuration with Hiera
#   include '::logcheck'
#
#   logcheck::config:
#     REPORTLEVEL: server
#     SENDMAILTO: logcheck@example.com
#     ADDTAG: 'yes'
#
# @example Standard configuration directly setting variables
#   class { 'logcheck':
#     config => {
#       'REPORTLEVEL'   => 'server',
#       'SENDMAILTO'    => 'logcheck@example.com',
#       'ADDTAG'        => 'yes'
#     }
#   }
#
# @param package [String] The name of the logcheck package
# @param user [String] The name of the logcheck user
# @param configfile [String] The path to logcheck.conf
# @param config [Hash] A hash of changes to make to logcheck.conf
# @param crons [Hash] A hash of crons to run logcheck
#
class logcheck (
    $package        = 'logcheck',
    $user           = 'logcheck',
    $configfile     = '/etc/logcheck/logcheck.conf',
    $config         = {},
    $crons          = {
                        'logcheck' => {
                            'command'   => 'if [ -x /usr/sbin/logcheck ]; then nice -n10 /usr/sbin/logcheck -R; fi',
                            'user'      => 'logcheck',
                            'minute'    => 2
                        }, 'logcheck-reboot' => {
                            'command'   => 'if [ -x /usr/sbin/logcheck ]; then nice -n10 /usr/sbin/logcheck -R; fi',
                            'user'      => 'logcheck',
                            'special'   => 'reboot'
                        }
                      }
){
    validate_string($::logcheck::packages)
    validate_string($::logcheck::user)
    validate_absolute_path($::logcheck::configfile)
    validate_hash($::logcheck::config)
    validate_hash($::logcheck::crons)

    $changes_array = join_keys_to_values($::logcheck::config, ' ')
    $changes = regsubst($changes_array,'.*','set \0')

    ensure_packages($::logcheck::package)
    ensure_resource('user', $::logcheck::user, {'ensure' => 'present'})

    augeas { 'configure-logcheck':
        incl    => $::logcheck::configfile,
        lens    => 'Shellvars.lns',
        changes => $::logcheck::changes,
        require => File[$::logcheck::configfile]
    }

    create_resources('cron', $::logcheck::crons)
}

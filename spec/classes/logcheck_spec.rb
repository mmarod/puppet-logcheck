require 'spec_helper'

describe 'logcheck' do

  let :params do {
      :package => 'logcheck',
      :config => {
		'REPORTLEVEL' => 'server',
		'SENDMAILTO' => 'logcheck@example.com',
		'ADDTAG' => 'yes'
      },
      :configfile => '/etc/logcheck/logcheck.conf',
  } end

  it do 
    should contain_package('logcheck')
  end

  it do 
    should contain_user('logcheck')
  end

  it do 
    should contain_cron('logcheck') \
      .with_command('if [ -x /usr/sbin/logcheck ]; then nice -n10 /usr/sbin/logcheck -R; fi') \
      .with_user('logcheck') \
      .with_minute(2)

    should contain_cron('logcheck-reboot') \
      .with_command('if [ -x /usr/sbin/logcheck ]; then nice -n10 /usr/sbin/logcheck -R; fi') \
      .with_user('logcheck') \
      .with_special('reboot')
  end

  it 'should have an augeas resource' do
    should contain_augeas('configure-logcheck')
  end

  describe_augeas 'configure-logcheck', :lens => 'Shellvars', :target => 'etc/logcheck/logcheck.conf' do
    it 'should change SENDMAILTO' do
      should execute.with_change
      aug_get('SENDMAILTO').should == 'logcheck@example.com'
      should execute.idempotently
    end
  end
end

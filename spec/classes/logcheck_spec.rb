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

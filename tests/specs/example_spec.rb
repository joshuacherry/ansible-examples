# encoding: utf-8

control '01' do
  impact 1.0
  title 'Verify cron '
  desc 'Ensures cron service and web is up and running'

  describe service('cron') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end

end
# encoding: utf-8

control '01' do
  impact 1.0
  title 'Verify prometheus '
  desc 'Ensures prometheus service and web is up and running'

  describe service('prometheus') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
  describe user("prometheus") do
    it { should exist }
  end
  describe group("prometheus") do
    it { should exist }
  end

  describe port(9090) do
    it { should be_listening }
    its('processes') {should include 'prometheus'}
  end
  describe http('http://127.0.0.1:9090/config') do
    its('status') { should cmp 200 }
  end

end

control '02' do
  impact 1.0
  title 'Verify alertmanager '
  desc 'Ensures alertmanager service and web is up and running'

  describe service('alertmanager') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
  describe user("prometheus") do
    it { should exist }
  end
  describe group("prometheus") do
    it { should exist }
  end

  describe port(9093) do
    it { should be_listening }
    its('processes') {should include 'alertmanager'}
  end
  describe http('http://127.0.0.1:9093') do
    its('status') { should cmp 200 }
  end

end

control '03' do
  impact 1.0
  title 'Verify grafana '
  desc 'Ensures grafana service and web is up and running'

  describe service('grafana-server') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
  describe user("grafana") do
    it { should exist }
  end
  describe group("grafana") do
    it { should exist }
  end

  describe port(3000) do
    it { should be_listening }
    its('processes') {should include 'grafana-server'}
  end
  describe http('http://127.0.0.1:3000/login') do
    its('status') { should cmp 200 }
  end

end

control '03' do
  impact 1.0
  title 'Verify mysql '
  desc 'Ensures mysql service is up and running'

  describe port(3306) do
    it { should be_listening }
    its('processes') {should include 'mysqld'}
  end

end

control '04' do
  impact 1.0
  title 'Verify grafana '
  desc 'Ensures grafana service and web is up and running'

  describe service('grafana-server') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
  describe user("grafana") do
    it { should exist }
  end
  describe group("grafana") do
    it { should exist }
  end

  describe port(3000) do
    it { should be_listening }
    its('processes') {should include 'grafana-server'}
  end
  describe http('http://127.0.0.1:3000/login') do
    its('status') { should cmp 200 }
  end

  describe file('/var/lib/grafana/plugins/grafana-clock-panel') do
    it { should exist }
   end

end
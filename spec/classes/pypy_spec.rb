require 'spec_helper'

describe 'pypy', :type => :class do
  let(:facts) { {
    :osfamily => 'Debian',
    :operatingsystem => 'Ubuntu',
    :lsbdistid => 'debian',
    :lsbdistcodename => 'precise'
  } }

  context 'with no parameters' do
    it { should include_class('apt') }
    it { should contain_apt__ppa('ppa:pypy/ppa') }
    it { should contain_package('pypy').with_ensure('present') }
  end

  context 'with a custom version' do
    let(:params) { {'version' => 'absent' } }
    it { should contain_package('pypy').with_ensure('absent') }
  end

  context 'with an invalid distro name' do
    let(:facts) { {:osfamily => 'RedHat'} }
    it do
      expect {
        should contain_package('new-golang')
      }.to raise_error(Puppet::Error, /Unsupported osfamily/)
    end
  end

end

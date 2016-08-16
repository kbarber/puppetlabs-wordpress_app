require 'spec_helper'

describe 'wordpress_app::simple', :type => :application do
  let :facts do
    {
      :operatingsystem => 'CentOS',
      :operatingsystemrelease => '7.0',
      :operatingsystemmajrelease => '7',
      :osfamily => 'RedHat',
      :ipaddress => '1.1.1.1',
    }
  end

  let(:title) { 'public_blog' }

  context "on a single node" do
    let(:node) { 'blog.puppet.com' }

    let :params do
      {
        :nodes => {
          resource('Node', node) => [
            resource('Wordpress_app::Lb', 'public_blog'),
            resource('Wordpress_app::Web', 'public_blog'),
            resource('Wordpress_app::Database', 'public_blog'),
          ]
        }
      }
    end

    context 'with defaults for all parameters' do
      it { should compile }
      it { should contain_wordpress_app__simple('public_blog') }
      it { should contain_wordpress_app__lb('public_blog') }
      it { should contain_wordpress_app__web('public_blog') }
      it { should contain_wordpress_app__database('public_blog') }
    end
  end
end

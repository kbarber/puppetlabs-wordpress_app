require 'spec_helper'

describe 'wordpress_app', :type => :application do
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

  context "on a single node setup" do
    let(:node) { 'blog.puppet.com' }

    let :params do
      {
        :nodes => {
          resource('Node', node) => [
            resource('Wordpress_app::Lb', 'blog_lb'),
            resource('Wordpress_app::Web', 'blog_web'),
            resource('Wordpress_app::Database', 'blog_database'),
          ]
        }
      }
    end

    context 'with defaults for all parameters' do
      it { should compile }
      it { should contain_wordpress_app('public_blog') }
      it { should contain_wordpress_app__lb('blog_lb') }
      it { should contain_wordpress_app__web('blog_web') }
      it { should contain_wordpress_app__database('blog_database') }
    end
  end
end

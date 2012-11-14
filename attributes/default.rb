default['bitcoin-abe']['db_engine'] = "postgresql"
default['bitcoin-abe']['db_name'] = "abe"
default['bitcoin-abe']['db_user'] = "abe"
default['bitcoin-abe']['db_port'] = "2750"
default['bitcoin-abe']['dir'] = "/usr/local/bitcoin-abe"
default['bitcoin-abe']['python_dir'] = "#{node['bitcoin-abe']['dir']}/python"

case node['platform_family']
when "debian"
    override['postgresql']['server']['packages'] = %w{postgresql libpq-dev}
end

node.default['postgresql']['pg_hba'] = [{:type => 'local', :db => node['bitcoin-abe']['db_name'], :user => node['bitcoin-abe']['db_user'], :addr => nil, :method => 'ident'}]

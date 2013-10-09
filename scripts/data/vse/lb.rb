load_balancer do
  configure 'walker_ci' do
    pool ['192.168.254.100'] do
      http :enabled => false
      https
    end

    virtual_server :name => 'Walker CI', :interface => 'walker_ci_vse', :ip => '37.26.90.83'
  end
end

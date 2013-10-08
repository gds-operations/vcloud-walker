nat do
  snat :desc => 'Outbound',
    :interface => 'walker_ci_vse',
    :original => { :ip => '192.168.254.100' },
    :translated => { :ip => '37.26.90.84' }

  # Admin, deployment, and rsync.
  dnat :desc => 'SSH mirror0',
    :interface => 'walker_ci_vse',
    :original => { :ip => '37.26.90.84', :port => 22, },
    :translated => { :ip => '192.168.254.100', :port => 22, }
end

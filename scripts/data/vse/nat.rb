nat do
  snat :desc => 'Outbound',
    :interface => 'walker_ci_vse',
    :original => { :ip => '192.168.2.2' },
    :translated => { :ip => '37.26.89.189' }

  # Admin, deployment, and rsync.
  dnat :desc => 'SSH mirror0',
    :interface => 'walker_ci_vse',
    :original => { :ip => '37.26.89.189', :port => 22, },
    :translated => { :ip => '192.168.2.2', :port => 22, }
end

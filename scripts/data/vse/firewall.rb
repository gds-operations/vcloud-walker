firewall do
  EXTERNAL_IPS = %w(80.194.77.90)
  LOAD_BALANCER_IP = '37.26.90.83'

  #opening ssh access from aviation housee
  EXTERNAL_IPS.each do |ip|

  rule "SSH from ip #{ip}", :protocols => [:tcp] do
    source :ip => ip
    destination :ip => 'Any', :port => 22
  end

  rule "HTTPS from ip #{ip}", :protocols => [:tcp] do
    source :ip => ip
    destination :ip => 'Any', :port => 443
  end

  end

  #outbound traffic to any
  rule 'Outbound traffic', :protocols => [:any] do
    source      :ip => 'internal', :port => 'Any'
    destination :ip => 'external', :port => 'Any'
  end

end

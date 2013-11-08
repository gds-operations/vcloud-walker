require 'vcloud/walker'

module Vcloud
  module Walker
  load File.join(File.expand_path('../tasks/vcloud-walk.thor', __FILE__))
  VcloudWalk.start(ARGV)
  end
end
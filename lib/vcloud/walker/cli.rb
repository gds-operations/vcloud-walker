require 'optparse'
require 'json'

module Vcloud
  module Walker
    class Cli
      def initialize(argv_array)
        @usage_text = nil
        @resource_type = nil
        @options = {
          :yaml => false,
        }

        parse(argv_array)
      end

      def run
        begin
          out = Vcloud::Walker.walk(@resource_type)
          if @options[:yaml]
            print(out.to_yaml)
          else
            print(JSON.pretty_generate(out))
          end
        rescue => e
          $stderr.puts(e)
          exit 1
        end
      end

      private

      def parse(args)
        opt_parser = OptionParser.new do |opts|
          opts.banner = <<-EOS
Usage: #{$0} [options] resource_type
Vcloud-walker is a command line tool, to describe different VMware vCloud Director 5.1 resources. It uses Fog under the hood.

Resources that can be walked using vcloud-walker are:
  catalogs
  vdcs
  networks
  edgegateways
  organization

See https://github.com/gds-operations/vcloud-walker for more info
          EOS

          opts.on("--yaml",   "Yaml output") do
            @options[:yaml] = true
          end

          opts.on("-h", "--help", "Print usage and exit") do
            $stderr.puts opts
            exit
          end

          opts.on("--version", "Display version and exit") do
            puts Vcloud::Walker::VERSION
            exit
          end
        end

        @usage_text = opt_parser.to_s
        begin
          opt_parser.parse!(args)
        rescue OptionParser::InvalidOption => e
          exit_error_usage(e)
        end

        exit_error_usage("must supply resource_type") unless args.size == 1
        @resource_type = args.first
      end

      def exit_error_usage(error)
        $stderr.puts "#{$0}: #{error}"
        $stderr.puts @usage_text
        exit 2
      end
    end
  end
end

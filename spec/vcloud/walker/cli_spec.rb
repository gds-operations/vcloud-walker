require 'spec_helper'

class CommandRun
  attr_accessor :stdout, :stderr, :exitstatus

  def initialize(args)
    out = StringIO.new
    err = StringIO.new

    $stdout = out
    $stderr = err

    begin
      Vcloud::Walker::Cli.new(args).run
      @exitstatus = 0
    rescue SystemExit => e
      # Capture exit(n) value.
      @exitstatus = e.status
    end

    @stdout = out.string.strip
    @stderr = err.string.strip

    $stdout = STDOUT
    $stderr = STDERR
  end
end

describe Vcloud::Walker::Cli do
  subject { CommandRun.new(args) }
  let(:mock_output) do
    [{
      :name => 'gruffalo',
      :desc => { :eyes => 'orange', :tongue => 'black' },
    },{
      :name => 'mouse',
      :desc => { :tail => 'scaly', :whiskers => 'wire' },
    }]
  end

  describe "normal usage" do
    context "when given resource_type" do
      let(:args) { %w{things} }

      it "should pass resource_type and exit normally" do
        expect(Vcloud::Walker).to receive(:walk).with('things').and_return(mock_output)
        expect(subject.exitstatus).to eq(0)
      end
    end

    context "when asked to display version" do
      let(:args) { %w{--version} }

      it "should not call Walker" do
        expect(Vcloud::Walker).not_to receive(:walk)
      end

      it "should print version and exit normally" do
        expect(subject.stdout).to eq(Vcloud::Walker::VERSION)
        expect(subject.exitstatus).to eq(0)
      end
    end

    context "when asked to display help" do
      let(:args) { %w{--help} }

      it "should not call Walker" do
        expect(Vcloud::Walker).not_to receive(:walk)
      end

      it "should print usage and exit normally" do
        expect(subject.stderr).to match(/\AUsage: \S+ \[options\] resource_type\n/)
        expect(subject.exitstatus).to eq(0)
      end
    end
  end

  describe "output formats" do
    context "when no format is specified" do
      let(:args) { %w{things} }
      let(:expected_stdout) { <<EOS
[
  {
    "name": "gruffalo",
    "desc": {
      "eyes": "orange",
      "tongue": "black"
    }
  },
  {
    "name": "mouse",
    "desc": {
      "tail": "scaly",
      "whiskers": "wire"
    }
  }
]
EOS
      }

      it "should output in JSON with no trailing newline" do
        expect(Vcloud::Walker).to receive(:walk).with('things').and_return(mock_output)
        expect(subject.stdout).to eq(expected_stdout.chomp)
      end
    end

    context "when given --yaml" do
      let(:args) { %w{--yaml things} }
      let(:expected_stdout) { <<EOS
---
- :name: gruffalo
  :desc:
    :eyes: orange
    :tongue: black
- :name: mouse
  :desc:
    :tail: scaly
    :whiskers: wire
EOS
      }

      it "should output in YAML with no trailing newline" do
        expect(Vcloud::Walker).to receive(:walk).with('things').and_return(mock_output)
        expect(subject.stdout).to eq(expected_stdout.chomp)
      end
    end
  end

  describe "incorrect usage" do
    shared_examples "print usage and exit abnormally" do |error|
      it "should not call Walker" do
        expect(Vcloud::Walker).not_to receive(:walk)
      end

      it "should print error message and usage" do
        expect(subject.stderr).to match(/\A\S+: #{error}\nUsage: \S+/)
      end

      it "should exit abnormally for incorrect usage" do
        expect(subject.exitstatus).to eq(2)
      end
    end

    context "when given more than resource_type argument" do
      let(:args) { %w{type_one type_two} }

      it_behaves_like "print usage and exit abnormally", "must supply resource_type"
    end

    context "when given an unrecognised argument" do
      let(:args) { %w{--this-is-garbage} }

      it_behaves_like "print usage and exit abnormally", "invalid option: --this-is-garbage"
    end
  end

  describe "error handling" do
    context "when underlying code raises an exception" do
      let(:args) { %w{things} }

      it "should print error without backtrace and exit abnormally" do
        expect(Vcloud::Walker).to receive(:walk).
          with('things').and_raise("something went horribly wrong")
        expect(subject.stderr).to eq("something went horribly wrong")
        expect(subject.exitstatus).to eq(1)
      end
    end
  end
end

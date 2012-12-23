require 'script/report_build'

describe BuildStatusReporter do
  let(:api) { mock(:api) }

  it "reports the build status" do
    shell = mock(run: true)
    api.should_receive(:report_status).with("building").ordered
    api.should_receive(:report_status).with("successful").ordered
    BuildStatusReporter.new(api, shell).build_and_report("rake spec")
  end

  it "runs the build command" do
    shell = mock
    api = mock.as_null_object
    shell.should_receive(:run).with("rake spec")
    BuildStatusReporter.new(api, shell).build_and_report("rake spec")
  end

  context "when the build command is successful" do
    let(:shell) { mock(:shell, run: true) }

    it "returns true" do
      api = mock.as_null_object
      build_status = BuildStatusReporter.new(api, shell).build_and_report("rake spec")
      build_status.should == true
    end
  end

  context "when the build command fails" do
    let(:shell) { mock(:shell, run: false) }

    it "reports the build as failed" do
      api.stub(:report_status).with("building")
      api.should_receive(:report_status).with("failed")
      BuildStatusReporter.new(api, shell).build_and_report("rake spec")
    end

    it "returns false" do
      api.as_null_object
      build_status = BuildStatusReporter.new(api, shell).build_and_report("rake spec")
      build_status.should == false
    end
  end
end

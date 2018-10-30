RSpec.describe "`kratos recon` command", type: :cli do
  it "executes `kratos help recon` command successfully" do
    output = `kratos help recon`
    expected_output = <<-OUT
Usage:
  kratos recon

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end

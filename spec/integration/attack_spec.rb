RSpec.describe "`kratos attack` command", type: :cli do
  it "executes `kratos help attack` command successfully" do
    output = `kratos help attack`
    expected_output = <<-OUT
Usage:
  kratos attack [TYPE]

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end

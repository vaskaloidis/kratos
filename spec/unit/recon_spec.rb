require 'kratos/commands/recon'

RSpec.describe Kratos::Commands::Recon do
  it "executes `recon` command successfully" do
    output = StringIO.new
    options = {}
    command = Kratos::Commands::Recon.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end

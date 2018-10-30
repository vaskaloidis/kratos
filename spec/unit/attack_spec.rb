require 'kratos/commands/attack'

RSpec.describe Kratos::Commands::Attack do
  it "executes `attack` command successfully" do
    output = StringIO.new
    type = nil
    options = {}
    command = Kratos::Commands::Attack.new(type, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end

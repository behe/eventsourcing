require 'bundler'

Bundler.require

require 'minitest/pride'
require 'minitest/autorun'
require 'minitest/spec'

require_relative '../program.rb'
include Program

describe "process" do
  it "should be empty" do
    replay_commands(["[]"]).must_equal []
  end

  it "should append value" do
    replay_commands(["[]", "ADD 1"]).must_equal [1]
  end

  it "should append values" do
    replay_commands(["[]", "ADD 1", "ADD 2"]).must_equal [1, 2]
  end

  it "should remove value at beginning" do
    replay_commands(["[]", "ADD 1", "REM 0"]).must_equal []
  end

  it "should remove value at end" do
    replay_commands(["[]", "ADD 1", "ADD 2", "REM 1"]).must_equal [1]
  end

  it "should handle facit" do
    replay_commands(["[]", "ADD 4", "ADD 9", "REM 1", "ADD 5", "ADD 7", "ADD 2", "ADD 5", "ADD 9", "ADD 6", "REM 2", "ADD 2", "REM 5", "ADD 1", "ADD 1", "ADD 8", "ADD 2", "REM 0"]).must_equal [5, 2, 5, 9, 2, 1, 1, 8, 2]
  end

  it "should replay from file" do
    facit = [5, 2, 5, 9, 2, 1, 1, 8, 2]
    replay_file("eventlog.txt").must_equal facit
  end

end

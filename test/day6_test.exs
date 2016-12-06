defmodule Day6Test do
  use ExUnit.Case

  test "Solves part 1 example" do
    assert Day6.solve("test/fixtures/day6_example.txt") == "easter"
  end

  test "Solves part 2 example" do
    assert Day6.solve2("test/fixtures/day6_example.txt") == "advent"
  end

end

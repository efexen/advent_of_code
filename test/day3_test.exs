defmodule Day3Test do
  use ExUnit.Case

  test "Solves part 1 example" do
    assert Day3.solve("test/fixtures/day3_example.txt") == 1
  end

  test "Solves part 2 example" do
    assert Day3.solve_columns("test/fixtures/day3_example.txt") == 2
  end

end

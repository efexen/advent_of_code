defmodule Day4Test do
  use ExUnit.Case

  test "Solve part 1" do
    assert Day4.solve("test/fixtures/day4_example.txt") == 1514
  end

  test "Solve part 2" do
    assert Day4.solve2("test/fixtures/day4_2_example.txt") == [{"very encrypted name", "343"}]
  end

end

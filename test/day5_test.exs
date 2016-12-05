defmodule Day5Test do
  use ExUnit.Case

  test "Solve part 1" do
    assert Day5.solve("abc") == "18f47a30"
  end

  test "Solve part 2" do
    assert Day5.solve2("abc") == "05ace8e3"
  end

end

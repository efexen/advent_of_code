defmodule Day2Test do
  use ExUnit.Case

  test "Solves part 1 example" do
    assert Day2.solve(["ULL", "RRDDD", "LURDL", "UUUUD"]) == "1985"
  end

  test "Solves part 2 example" do
    assert Day2.solve2(["ULL", "RRDDD", "LURDL", "UUUUD"]) == "5DB3"
  end

end

defmodule Day1Test do
  use ExUnit.Case

  describe ".distance_from_start" do

    test "R2, L3" do
      assert Day1.distance_from_start("R2, L3") == 5
    end

    test "R2, R2, R2" do
      assert Day1.distance_from_start("R2, R2, R2") == 2
    end

    test "R5, L5, R5, R3" do
      assert Day1.distance_from_start("R5, L5, R5, R3") == 12
    end

  end

  describe ".closest_twice" do

    test "R8, R4, R4, R8" do
      assert Day1.closest_twice("R8, R4, R4, R8") == 4
    end

  end

end

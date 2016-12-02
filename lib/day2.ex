defmodule Day2 do

  def solve(instructions) do
    instructions
    |> Enum.reduce({"", 5}, &walk/2)
    |> elem(0)
  end

  defp walk(seq, {solution, start}) do
    number = seq
    |> String.graphemes
    |> Enum.reduce(start, &move/2)

    { solution <> inspect(number), number }
  end

  defp move("U", pos) when pos > 3, do: pos - 3
  defp move("D", pos) when pos <= 6, do: pos + 3
  defp move("L", pos) when rem(pos, 3) != 1, do: pos - 1
  defp move("R", pos) when rem(pos, 3) > 0, do: pos + 1
  defp move(_, pos), do: pos

end

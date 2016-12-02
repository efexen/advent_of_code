defmodule Day2 do
  @keypad "  1   234 56789 ABC   D  "

  def solve(instructions) do
    instructions
    |> Enum.reduce({"", 5}, &walk/2)
    |> elem(0)
  end

  def solve2(instructions) do
    instructions
    |> Enum.reduce({"", 11}, &walk_pad/2)
    |> elem(0)
  end

  defp walk_pad(seq, {solution, start}) do
    number = seq
    |> String.graphemes
    |> Enum.reduce(start, &move_pad/2)

    { solution <> String.at(@keypad, number - 1), number }
  end

  defp walk(seq, {solution, start}) do
    number = seq
    |> String.graphemes
    |> Enum.reduce(start, &(move(&1, &2, 3)))

    { solution <> inspect(number), number }
  end

  defp move_pad(direction, pos) do
    next_pos = move(direction, pos, 5)

    case String.at(@keypad, next_pos - 1) do
      " " ->
        pos
      _ ->
        next_pos
    end
  end

  defp move("U", pos, size) when pos > size, do: pos - size
  defp move("D", pos, size) when pos <= (size * (size - 1)), do: pos + size
  defp move("L", pos, size) when rem(pos, size) != 1, do: pos - 1
  defp move("R", pos, size) when rem(pos, size) > 0, do: pos + 1
  defp move(_, pos, _), do: pos

end

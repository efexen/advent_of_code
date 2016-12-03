defmodule Day3 do

  def solve(path) do
    File.stream!(path)
    |> Stream.map(&clean/1)
    |> Stream.filter(&validate/1)
    |> Enum.count
  end

  defp clean(lengths) do
    lengths
    |> String.trim
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp validate(lengths) do
    2 * Enum.max(lengths) < Enum.sum(lengths)
  end

end

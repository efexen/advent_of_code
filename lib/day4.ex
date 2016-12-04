defmodule Day4 do

  def solve(path) do
    File.stream!(path)
    |> Stream.map(&clean/1)
    |> Stream.filter(&validate/1)
    |> Stream.map(fn ([_, id, _]) -> String.to_integer(id) end)
    |> Enum.sum
  end

  defp clean(room) do
    Regex.run(~r/(?<code>[a-z|-]+)-(?<id>\d+)\[(?<checksum>[a-z]+)\]/, room)
    |> Enum.map(&(String.replace(&1, "-", "")))
    |> List.delete_at(0)
  end

  defp validate([code, id, checksum]) do
    checksum == code
    |> String.graphemes
    |> Enum.reduce(%{}, &count_char/2)
    |> Enum.sort(&sort_counts/2)
    |> Enum.map(&elem(&1, 0))
    |> Enum.take(5)
    |> Enum.join
  end

  defp sort_counts({k1, v1}, {k2, v2}) do
    cond do
      v1 == v2 -> k1 < k2
      v1 < v2 -> false
      true -> true
    end
  end

  defp count_char(char, map) do
    Map.update(map, char, 1, &(&1 + 1))
  end

end

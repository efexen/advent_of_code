defmodule Day4 do

  def solve(path) do
    File.stream!(path)
    |> Stream.map(&clean/1)
    |> Stream.filter(&validate/1)
    |> Stream.map(fn ([_, _, id, _]) -> String.to_integer(id) end)
    |> Enum.sum
  end

  def solve2(path) do
    File.stream!(path)
    |> Stream.map(&clean/1)
    |> Stream.filter(&validate/1)
    |> Stream.map(&decrypt/1)
    |> Enum.into([])
  end

  defp clean(room) do
    matches = Regex.run(~r/(?<code>[a-z|-]+)-(?<id>\d+)\[(?<checksum>[a-z]+)\]/, room)
    original = Enum.at(matches, 1)

    matches
    |> Enum.map(&(String.replace(&1, "-", "")))
    |> List.replace_at(0, original)
  end

  defp validate([_encrypted, code, _id, checksum]) do
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

  defp decrypt([encrypted, _, id, _]) do
    offset = id |> String.to_integer |> rem(26)

    decrypted = encrypted
    |> String.graphemes
    |> Enum.map(&(decrypt_char(&1, offset)))
    |> Enum.join

    { decrypted, id }
  end

  defp decrypt_char("-", _), do: " "
  defp decrypt_char(<<letter>>, offset) do
    <<?a + rem((letter - ?a) + offset, 26)>>
  end

end

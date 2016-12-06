defmodule Day6 do

  def solve(path) do
    do_solve(path, &pick_top/1)
  end

  def solve2(path) do
    do_solve(path, &pick_bottom/1)
  end

  def do_solve(path, picker) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.graphemes/1)
    |> Enum.reduce(%{}, &process_row/2)
    |> Enum.map(picker)
    |> Enum.join
  end

  defp pick_top({_, letters}) do
    letters
    |> Enum.max_by(&(elem(&1, 1)))
    |> elem(0)
  end

  defp pick_bottom({_, letters}) do
    letters
    |> Enum.min_by(&(elem(&1, 1)))
    |> elem(0)
  end

  defp process_row(row, chars) do
    row
    |> Enum.with_index
    |> Enum.reduce(chars, &count_char/2)
  end

  defp count_char({char, index}, map) do
    Map.get_and_update(map, index, fn
      index_map = %{} ->
        { index_map, Map.update(index_map, char, 1, &(&1 + 1)) }
      nil ->
        { nil, %{ char => 1 } }
    end) |> elem(1)
  end

end

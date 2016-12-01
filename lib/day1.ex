defmodule Day1 do

  def distance_from_start(sequence) do
    traverse(sequence) |> distance_to
  end

  def closest_twice(sequence) do
    history = traverse(sequence)[:history]

    history
    |> Enum.reverse
    |> Enum.find({0,0}, &(Enum.member?(List.delete(history, &1), &1)))
    |> distance_to
  end

  defp traverse(sequence) do
    sequence
    |> String.split([",", " "], trim: true)
    |> Enum.reduce(%{ x: 0, y: 0, xo: 0, yo: 1, history: [{0,0}]}, &do_travel/2)
  end

  defp distance_to({x,y}), do: distance_to(%{x: x, y: y})
  defp distance_to(state) do
    state
    |> Map.take([:x, :y])
    |> Map.values
    |> Enum.map(&abs/1)
    |> Enum.sum
  end

  defp do_travel(<<direction::binary-size(1)>> <> amount, state) do
    state |> turn(direction) |> move(String.to_integer(amount))
  end

  defp turn(state = %{ xo: 0, yo: 1 }, "R"), do: %{ state | xo: 1, yo: 0 }
  defp turn(state = %{ xo: 1, yo: 0 }, "R"), do: %{ state | xo: 0, yo: -1 }
  defp turn(state = %{ xo: 0, yo: -1 }, "R"), do: %{ state | xo: -1, yo: 0 }
  defp turn(state = %{ xo: -1, yo: 0 }, "R"), do: %{ state | xo: 0, yo: 1 }

  defp turn(state = %{ xo: 0, yo: 1 }, "L"), do: %{ state | xo: -1, yo: 0 }
  defp turn(state = %{ xo: 1, yo: 0 }, "L"), do: %{ state | xo: 0, yo: 1 }
  defp turn(state = %{ xo: 0, yo: -1 }, "L"), do: %{ state | xo: 1, yo: 0 }
  defp turn(state = %{ xo: -1, yo: 0 }, "L"), do: %{ state | xo: 0, yo: -1 }

  defp move(state, 0), do: state
  defp move(state, amount), do: move(step(state), amount - 1)

  defp step(state = %{ xo: xo, yo: yo }) do
    x = state.x + xo
    y = state.y + yo
    %{ state | x: x, y: y, history: [ {x, y} | state.history ]}
  end

end

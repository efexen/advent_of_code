defmodule Day5 do

  def solve(code, processes \\ 4) do
    do_solve(code, processes, &no_check/2)
  end

  def solve2(code, processes \\ 4) do
    do_solve(code, processes, &position_check/2)
  end

  @batch_size 10000
  def process(parent, code, counter) do
    start = counter * @batch_size
    finish = start + @batch_size - 1

    (start..finish)
    |> Enum.each(&(do_process(parent, do_hash(code, &1), &1)))

    send parent, { :finished, self }
  end

  defp do_solve(code, processes, checker) do
    (0..processes - 1)
    |> Enum.map(&(spawn(__MODULE__, :process, [self, code, &1])))
    |> listen(%{password: [], counter: processes, code: code, checker: checker})
    |> Enum.sort
    |> Enum.take(8)
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.join
    |> String.downcase
  end

  defp listen([], %{password: password}) when length(password) >= 8, do: password
  defp listen(processes, state = %{password: password, checker: checker}) do
    receive do
      { :found, candidate } ->
        password = checker.(password, candidate)
        listen(processes, %{ state | password: password })
      { :finished, pid } ->
        processes
        |> List.delete(pid)
        |> process_finished(state)
    end
  end

  defp process_finished(processes, state = %{password: password}) when length(password) >= 8 do
    listen(processes, state)
  end

  defp process_finished(processes, state = %{counter: counter}) do
    new_pid = new_worker(state)
    listen([new_pid | processes], %{ state | counter: counter + 1 })
  end

  defp new_worker(%{ code: code, counter: counter }) do
    spawn(__MODULE__, :process, [self, code, counter])
  end

  defp no_check(password, candidate), do: [candidate | password]

  defp position_check(password, {_, <<position>> = location, key}) when position - ?0 < 8 do
    Keyword.put_new(password, String.to_atom(location), key)
  end
  defp position_check(password, _), do: password

  defp do_process(parent, <<0, 0, x, y>> <> _, counter) when x < 16 do
    location = <<x>> |> Base.encode16 |> String.at(1)
    key = <<y>> |> Base.encode16 |> String.at(0)
    send parent, { :found, { counter, location, key } }
  end
  defp do_process(_, _, _), do: nil

  defp do_hash(code, counter) do
    :crypto.hash(:md5, code <> Integer.to_string(counter))
  end

end

defmodule Chap10_2 do
  @moduledoc """

  """
  def hoge(a), do: a
end

# List
[1,2,3,4] |> Enum.map(&(&1 * 2))
1..10_000_000 |> Enum.map(&(&1 + 1)) |> Enum.take(5)

# Stream (C#のLINQの用にmapは遅延評価される)
[1,2,3,4] |> Stream.map(&(&1 * 2)) |> Enum.to_list
1..10_000_000 |> Stream.map(&(&1 + 1)) |> Enum.take(5)

[1,2,3,4] |> Stream.map(&(&1 + 1))
[1,2,3,4] |> Stream.cycle  # 123412341234
(&:random.uniform/0) |> Stream.repeatedly  # 毎回違う乱数
Stream.iterate(0, fn _ -> :random.uniform() end)  # 毎回違う乱数
# unfold は state -> { stream_value, new_state }
Stream.unfold({0, 1}, fn {a,b} -> {a, {b, a+b}} end)  # フィボナッチ数列
# TODO: resourceよくわからん・・・

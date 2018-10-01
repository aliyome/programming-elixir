# Enum

require Integer  # is_evenを使うため
Enum.to_list 1..5  # [1,2,3,4,5]
Enum.concat [1,2,3], 'abc'  # [1,2,3,97,98,99]
Enum.map [1,2], &(&1 + 1)  # [2,3]
Enum.at 10..20, 3  # 13
Enum.at 10..20, 20, :nothing  # nothing
Enum.filter [1,2,3], &(&1 < 2)  # [1]
Enum.filter [1,2,3,4], &Integer.is_even/1  # [2,4]
Enum.reject [1,2,3,4], &Integer.is_even/1  # [1,3]
Enum.sort ["hoge", "foo", "bar"]  # ["bar", "foo", "hoge"]
Enum.sort [1,3,2], &(&1 <= &2)  # 1,2,3  安定ソートには <= を使う
Enum.max [1,3,2]  # 3
Enum.max_by [1,3,2], &(&1 * -1)  # 1
Enum.take [1,2,3], 2  # [1,2]
Enum.take_every [1,2,3,4,5], 2  # 1,3,5
Enum.take_while [1,2,3,4,5], &(&1 < 3)  # 1,2
Enum.split [1,2,3,4,5], 3  # [[1,2,3], [4,5]]
Enum.split_while [1,2,3,4, 5], &(&1 < 3)  # [[1,2,3], [4,5]
Enum.join [1,2,3]  # 123
Enum.join [1,2,3], "*"  # 1*2*3
Enum.all? [1,2,3], &(&1 < 4)  # true
Enum.any? [1,2,3], &(&1 < 2)  # true
Enum.member? [1,2,3], 4  # false
Enum.empty? []  # true
Enum.zip [1,2,3], [:a, :b]  # [{1, :a}, {2, :b}]
Enum.zip [:a,:b], [1, 2]  # [a: 1, b: 2]
Enum.with_index ["a", "b"]  # [{"a", 1}, {"b", 2}]
Enum.reduce 1..10, &(&1 + &2)  # 55

defmodule My do
  # 練習問題5
  def all?([], _pred), do: false
  def all?(list, pred), do: _all? list, pred
  def _all?([head | tail], pred), do: pred.(head) and _all?(tail, pred)
  def _all?([], _pred), do: true

  def each([], _), do: :ok
  def each([head | tail], f) do
    f.(head)
    each(tail, f)
  end

  def filter([], _), do: []
  def filter([head | tail], pred) do
    if pred.(head) do
      [head | filter(tail, pred)]
    else
      filter(tail, pred)
    end
  end

  def split(list, 0), do: {[], list}
  def split([head | tail], n) do
    {left, right} = split(tail, n - 1)
    {[head | left], right}
  end

  def take(_list, 0), do: []
  def take([head | tail], n), do: [head | take(tail, n - 1)]

  # 練習問題6
  # FIXME: head ++ tail の部分はこのままで良いのか？最適化がかからない？
  def flatten([]), do: []
  def flatten([head | tail]) when is_list(head), do: flatten(head ++ tail)
  def flatten([head | tail]), do: [head | flatten(tail)]
end

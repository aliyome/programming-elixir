# # リスト
# リストはheadとtailを持つ: [head | [tail]]

defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len tail

  def square([]), do: []
  def square([head | tail]), do: [head*head | square(tail)]

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head)| map(tail, func)]

  def sum(list), do: _sum(list, 0)
  defp _sum([], total), do: total
  defp _sum([head | tail], total), do: _sum(tail, total + head)

  # 練習問題0
  def sum_ex([]), do: 0
  def sum_ex([head | tail]), do: head + sum_ex(tail)

  def reduce([], value, _func), do: value
  def reduce([head | tail], value, func) do
    reduce(tail, func.(value, head), func)
  end

  # 練習問題1
  def mapsum(list, func), do: _mapsum(list, func, 0)
  defp _mapsum([], _func, value), do: value
  defp _mapsum([head | tail], func, value) do
    _mapsum(tail, func, value + func.(head))
  end

  # 練習問題2
  def max(list), do: _max(list, -9999999)
  defp _max([], max_value), do: max_value
  defp _max([head | tail], max_value) when max_value < head, do: _max(tail, head)
  defp _max([head | tail], max_value) when max_value >= head, do: _max(tail, max_value)

  # 練習問題3
  def caesar([], _n), do: []
  def caesar([head | tail], n) when ?z < head + n do
    [head + n - ?z + ?a - 1 | caesar(tail, n)]
  end
  def caesar([head | tail], n), do: [head + n | caesar(tail, n)]

  # 練習問題4
  def span(from, to) when from === to, do: [to]
  def span(from, to) when from <= to do
    [from | span(from + 1, to)]
  end
end

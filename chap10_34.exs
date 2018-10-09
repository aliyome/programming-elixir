# syntax
# result = for generator, filter..., into: value, do: expression
first8 = [1,2,3,4,5,6,7,8]
for x <- first8, y <- first8, x >= y, rem(x*y, 10)==0, do: {x, y}
# x <- first8, y <- first8 だけならは64回繰り返す
# x >= y のフィルタがあるので、rem(x*y, 10)==0は36回だけ使われる

# {1 => 1, 2 => 4, 3 => 9}
for x <- [1,2,3], into: %{}, do: {x, x*x}
for x <- [1,2,3], into: Map.new, do: {x, x*x}

defmodule My do
  # Chap7 練習問題4
  def span(from, to) when from === to, do: [to]
  def span(from, to) when from <= to, do: [from | span(from + 1, to)]
  # 練習問題7
  def prime(n) do
    # FIXME: 無駄な処理が多い気がする。最適解を知りたい
    for x <- span(2, n), Enum.count(span(2, n), &(rem(x, &1) == 0)) == 1, do: x
  end
end

# 練習問題8
tax_rates = [NC: 0.075, TX: 0.08]
orders = [
  [id: 123, ship_to: :NC, net_amount: 100.00],
  [id: 124, ship_to: :OK, net_amount:  35.50],
  [id: 125, ship_to: :TX, net_amount:  24.00],
  [id: 126, ship_to: :TX, net_amount:  44.80],
  [id: 127, ship_to: :NC, net_amount:  25.00],
  [id: 128, ship_to: :MA, net_amount:  10.00],
  [id: 129, ship_to: :CA, net_amount: 102.00],
  [id: 130, ship_to: :NC, net_amount:  50.00],
]
# クソコード
calc = fn order, tax_rates ->
  tax = order[:net_amount] * Keyword.get(tax_rates, order[:ship_to], 0)
  Keyword.put(order, :total_amount, order[:net_amount] + tax)
end
ship = fn orders, tax_rates -> Enum.map(orders, &(calc.(&1, tax_rates))) end
ship.(orders, tax_rates)






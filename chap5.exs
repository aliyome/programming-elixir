# # 無名関数
# sum = fn (a, b) -> a + b end
# sum = fn a, b -> a + b end  # 省略可能
# sum.(1, 2)  # 3 "."を忘れないように

# # 練習問題: Functions-1
# iex(13)> list_concat = fn a, b -> a ++ b end
# #Function<12.127694169/2 in :erl_eval.expr/5>
# iex(14)> list_concat.([:a, :b], [:c, :d])
# [:a, :b, :c, :d]

# # 練習問題: Functions-2
fn2 = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

IO.inspect fn2.(0, 0, 3)  # FizzBuzz
IO.inspect fn2.(0, 2, 3)  # Fizz
IO.inspect fn2.(1, 0, 3)  # Buzz
IO.inspect fn2.(1, 2, 3)  # 3

# # 練習問題: Functions-3

fn3 = fn n -> fn2.(rem(n, 3), rem(n, 5), n) end
fn3.(10)
fn3.(11)
fn3.(12)
fn3.(13)
fn3.(14)
fn3.(15)
fn3.(16)  # ForEachやmapはどうやって使うの？

## 練習問題: Functions-4

prefix = fn x -> fn y -> "#{x} #{y}" end end
prefix.("Mr").("aliyome")  # Mr aliyome

## &記法

fn a -> a + 1 end
&(&1 + 1)

# # 練習問題: Functions-5
# Enum.map [1,2,3,4], fn x -> x + 2 end
Enum.map [1,2,3,4], &(&1 + 2)
# Enum.each [1,2,3,4], fn x -> IO.inspect x end
Enum.each [1,2,3,4], &(IO.inspect &1)

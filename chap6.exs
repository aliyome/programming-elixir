# doはただのブロック。
# 以下のようにも書ける
# do: (n * 2)
# do: n * 2
# def double(n), do: n * 2

# defmodule Times do
#   def double(n) do
#     n * 2
#   end

#   # 練習問題1
#   def triple(n), do: n * 3

#   # 練習問題2
#   # iex> c "times.exs"
#   # iex times.exs

#   # 練習問題3
#   def quadruple(n) do
#     double(n) + double(n)
#   end
# end

defmodule My do
  def factorial(0), do: 1
  def factorial(n) when n > 0, do: n * factorial(n - 1)
  # デフォルトパラメータ
  def default(a, b \\ 2), do: IO.inspect [a, b]

  # 練習問題4
  def sum(1), do: 1
  def sum(n), do: n + sum(n-1)

  # 練習問題5
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))

  # 練習問題6
  def guess(actual, min..max) do
    center = div(min + max, 2)
    IO.puts "Is it #{center}"
    _guess(actual, min..max, center)
  end
  defp _guess(actual, min.._, center) when actual < center do
    guess(actual, min..center);
  end
  defp _guess(actual, _..max, center) when center < actual do
    guess(actual, center..max);
  end
  defp _guess(actual, _.._, center) when center === actual do
    IO.puts center
  end
end

# ガード節(when)には特定の演算・関数しか使えない
defmodule Guard do
  def what_is(x) when is_number(x) do
    IO.puts "#{x} is a number"
  end
end


## パイプライン演算子
# result = input |> f1 |> f2

## モジュールの入れ子

# こういう書き方だけじゃなく
defmodule A do
  defmodule inner do
  end
end
# こういう書き方もあり
defmodule A.inner2 do
end

## importディレクティブ

# import List, only: [flatten: 1, duplicate: 2]
# モジュール内や関数内で利用可能

## aliasディレクティブ

# alias My.Other.Module.Parser, as : Parser
# Parser.hoge

## モジュールの属性

# **定数として使える**

# @author "aliyome"
# def get_author, do: @author

## モジュール名はアトム

# is_atom IO  # true
# to_string IO  # Elixir.IO
# :"Elixir.IO" === IO  # true
# :"Elixir.IO".puts 123  # 123
# # Erlangのモジュールを呼ぶ場合
# :io.format("hoge")  # ioはErlangのモジュール

# 練習問題7
:io.format "~.2f", [3.1415]  # 3.14
System.get_env
Path.extname "hoge/foo.bar"  # bar
File.cwd
# SimpleSchema  # JSON to Map
System.cmd "ls", ["/root"]

# ヘルプの見方

# iex> h IO.puts

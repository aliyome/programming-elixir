# # マップとキーワードリスト

# ## どちらを使うべきか？

# * 基本的に全部
#   + マップ
# * パターンマッチが必要
#   + マップ
# * 同じキーを持つエントリが現れる
#   + キーワードリスト
# * 要素の順番を保証する
#   + キーワードリスト

options = [a: 1, b: 2, a: 3]
Keyword.get(options, :b, "default value")  # 2
Keyword.get(options, :c, "default value")  # default value
Keyword.get_values(options, :a)  # [1, 3]

map = %{ name: "aliyome", likes: "Elixir"}
Map.keys map  # [:likes, :name]
Map.values map  # ["Elixir", "aliyome"]
map[:name]  # aliyome
map.name    # aliyome
Map.drop map, [:likes]  # %{name: "aliyome"}
Map.put map, :also_likes, "D"
Map.has_key? map, :also_likes  # true
{val, mapAfterPop} = Map.pop map, :also_likes
new_map = %{map | name: "takashi"}  # 値の更新
new_map = put_in(map.name, "takeshi")  # 上と同じ(マクロ)
new_map = put_in(map, :name, "takeshi")  # 上と同じっぽい(関数)

%{name: n} = map  # パターンマッチ

people = [
  %{ name: "aliyome", age: 30 },
  %{ name: "foo", age: 15 },
  %{ name: "bar", age: 39 },
  %{ name: "foobar", age: 21 },
]
IO.inspect for person = %{ age: age } <- people, age > 25, do: person

## パターンマッチ時にキーに値を束縛出来ない
item = "hoge"
# %{item => 1} = %{"hoge" => 1}  # NG
%{^item => 1} = %{"hoge" => 1}  # OK
%{1 => item} = %{1 => :ok}  # OK

## 構造体
# * モジュール名が構造体の名前になる。
# * キーがアトムのマップ

defmodule Subscriber do
  defstruct name: "", paid: false, over18: true
  def say(%Subscriber{name: n}) do
    IO.puts n
  end
  def hoge(s = %Subscriber{}) do
    IO.inspect s
  end
end

defmodule Hoge do
  defstruct sub: %Subscriber{}, meta: ""
end


## セット

set1 = Enum.into 1..5, MapSet.new
MapSet.member? set1, 3  # true
MapSet.union set1, MapSet.new [6,7]  # MapSet<[1,2,3,4,5,6,7]>
MapSet.difference set1, MapSet.new [2,3]  # MapSet<[1,4,5]>
MapSet.intersection set1, MapSet.new [5,6]  # MapSet<[5]>

## 値型
integer, float, atom, range, regex
float: IEEE754倍精度(16桁の正確さ、最大およそ10^308)
atom: rubyのシンボル
range: start..end  # endを**含む**
regexp: ~r{hoge}

```sh
iex(14)> Regex.run ~r{[aeiou]}, "caterpillar"
# ["a"]
iex(15)> Regex.scan ~r{[aeiou]}, "caterpillar"
# [["a"], ["e"], ["i"], ["a"]]
iex(16)> Regex.split ~r{[aeiou]}, "caterpillar"
# ["c", "t", "rp", "ll", "r"]
iex(17)> Regex.split ~r{[aeiou]}, "caterpillar", "*"
```

## システム型
PIDとport, reference

## コレクション型
tuple, list, map, binary

## リスト

* 連結 `[1, 2, 3] ++ [4, 5, 6]`
* 差分 `[1, 2, 3] -- [2]`
* 含まれているか `1 in [1, 2, 3, 4]`

**キーワードリスト**
2要素のタプルを持つリストを作るシンタックスシュガー

`[ name: "aliyome", city: "fukuoka"]`
-> `[{:name, "aliyome"}, {:city, "fukuoka"}]`

さらにキーワードリストを引数に持つ関数の引数は"[]"を省略できる

`DB.save record, [name: "aliyome", city: "fukuoka"]`
-> `DB.save record, name: "aliyome", city: "fukuoka"`

## マップ

雑に言うと、keyが一意なキーワードリスト

```ex
%{"name" => "aliyome", "city" => "fukuoka"}  # keyが文字列
%{:name => "aliyome", :city => "fukuoka"}  # keyがアトム
map = %{name: "aliyome", city: "fukuoka"}  # keyがアトムのシンタックスシュガー
map[:name]  # aliyome
map.name  # aliyome (keyがアトムの場合のみ)
```

## バイナリ

```ex
bin = << 1, 2 >>  # リテラル
byte_size bin  # 2
<<3 :: size(2), 5 :: size(4), 1 :: size(2)>>  # 0b11010101
```

## 真偽値

```ex
true === :true
false === :false
false !== nil
true === !false
true === !nil
```

## 演算

### ブール演算

```ex
# 厳格なブール演算(引数にtrue, falseのみを認める)
a or b
a and b
not a

# ゆるいブール演算
# nilとfalse以外の値はtrueと解釈される
a || b
a && b
!a
false || 0  # 0
```

## 特殊な算術演算

```ex
div(10, 3)  # 3 商を整数で返す
rem(10, 3)  # 1 余り
```

## with式

変数スコープを作れる

```ex
foo = "hoge"
a = with {:ok, data} = {:ok, "hoge"},
         foo = some_func data,
         bar = func2 foo
    do
         "#{bar}"
    end
foo  # hogeのまま。
```

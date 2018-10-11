"""
\u1234  # Unicodeコードポイント
?c  # 67  'c'のコードポイント

Sigil シジル
~C エスケープしない文字リスト
~R エスケープしない正規表現
~r エスケープする正規表現
~S エスケープしない文字列
~W 空白文字で区切られた単語リスト(エスケープしない)
~w 空白文字で区切られた単語リスト

シジルのオプション
-w<foo bar>a  # atom配列
-w<foo bar>c  # 文字リスト配列
-w<foo bar>s  # 文字列配列
"""

"""
'cat'  # コードポイント(整数値)の配列
[67, 65, 84] === 'CAT'  # true
:io.format "~w~n", ['CAT']  # [67,65,84]
List.to_tuple 'CAT'  # {67,65,84}
"""
defmodule Parse do
  def number([ ?- | tail ]), do: _number_digits(tail, 0) * -1
  def number([ ?+ | tail ]), do: _number_digits(tail, 0)
  def number(str), do: _number_digits(str, 0)

  defp _number_digits([], value), do: value
  defp _number_digits([digit | tail], value)
  when digit in '0123456789' do
    _number_digits(tail, value*10 + digit - ?0)
  end
  defp _number_digits([non_digit | _], _), do: raise "Invalid digit #{non_digit}"

  # 練習問題1
  def ascii([]), do: false
  def ascii(list), do: _ascii(list)
  defp _ascii([]), do: true
  defp _ascii([head|tail]) when head in ?\s..?~, do: _ascii(tail)
  defp _ascii([_|_]), do: false

  # 実務ではこっちを書くと思う
  def is_ascii?(str), do: Enum.all?(str, &(&1 in ?\s..?~))

  # 練習問題2
  # これで解けるけど、こういうことじゃあないんだよなぁ
  def anagram?(word1, word2) do
    Enum.reverse(word1)
    |> Enum.zip(word2)
    |> Enum.all?(fn {a,b} -> a === b end)
  end

  # 練習問題3
  # ['cat' | 'dog']  # ['cat', 100, 111, 103]
  # ['cat' | ['dog']]  # ['cat', 'dog']

  # 練習問題4
  # 糞コードの上未完。
  # 1文字の加算のみ可能
  ## calculate '1 + 2'  # 2
  def calculate(list), do: _calculate(list, 0, ?+)
  defp _calculate([], ans, _), do: ans
  defp _calculate([?\s | tail], ans, op), do: _calculate(tail, ans, op)
  defp _calculate([?+ | tail], ans, op), do: _calculate(tail, ans, ?+)
  defp _calculate([digit | tail], ans, op) when digit in '0123456789' do
    _calculate(tail, _cal(ans, digit - ?0, op), nil)
  end
  defp _cal(ans, b, ?+), do: ans + b
  defp _cal(ans, b, ?-), do: ans - b
  defp _cal(ans, b, nil), do: ans
end

# バイナリ
b = <<1,2,3>>
byte_size b
bit_size b

b = <<1::size(2), 1::size(3)>>  # 01 001 (= 9)

i = <<1>>
f = <<2.5::float>>  # <<64, 4, 0,0,0,0,0,0>>
mix = <<i::binary, f::binary>>  # <<1,64,4,0,0,0,0,0,0>>

# IEEE754
<<sign::size(1), exp::size(11), mantissa::size(52)>> = <<3.14159::float>>
(1 + mantissa / :math.pow(2, 52)) * :math.pow(2, exp-1023)  # 3.14159

# 文字列リストと文字列
'文字列リスト'  # Unicodeコードポイント値 整数配列
"文字列"  # ↑をUTF-8エンコードしたバイト列
String.at("文字列", 0)  # "文"
String.at("文字列", -1)  # "列"
String.codepoints("文字列 ∂og")  # "文","字","列", " ","∂", "o", "g"
String.first("文字列")  # "文"
String.last("文字列")  # "列"
# String.ljust("文字列", 5, padding \\ " ")
String.ljust("文字列", 5)  # "文字列  "
String.lstrip("   文字列")  # "文字列"
# String.replace(str, pattern, replacement, options \\ [global: true, insert_replaced: nil])
String.replace("cat hat", "at", "AT")  # cAT hAT
String.replace("cat hat", "at", "AT", global: false)  # cAT hat


# 練習問題5
defmodule My do
  def center(str_list) do
    max = str_list
      |> Enum.max_by(&String.length/1)
      |> String.length
    str_list
    |> Enum.map(&(IO.puts _center(&1, max)))
  end
  def _center(str, length) do
    len1 = div(length, 2)
    len2 = div(String.length(str), 2)
    space = round(len1 - len2)
    String.duplicate(" ", space) <> str
  end
end
My.center(["cat", "zebra", "elephant"])
My.center(["ca", "zebra", "elephasdifant"])

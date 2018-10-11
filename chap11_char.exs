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


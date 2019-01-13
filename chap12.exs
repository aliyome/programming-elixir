"""
if 1 == 1, do: "true", else: "false"

if 1 == 1 do
  "true"
else
  "false"
end

cond do
  n == 1 -> "1"
  n == 2 -> "22"
  true -> "else"
end

# MatchErrorが発生する可能性あり
{:ok, file} = File.open("a.txt")

# 例外は起きない
case File.open("a.txt") do
  {:ok, file} -> onSuccess()
  {:error, reason} -> onError()
end

# 例外が発生する可能性を明示する命名規則
file = File.open!("a.txt")
"""

defmodule FizzBuzz do
  def upto(n) when n > 0, do: _upto(1, n, [])

  defp _upto(_current, 0, result), do: Enum.reverse result

  defp _upto(current, left, result) do
    next_answer =
      cond do
        rem(current, 3) == 0 and rem(current, 5) == 0 -> "FizzBuzz"
        rem(current, 3) == 0 -> "Fizz"
        rem(current, 5) == 0 -> "Buzz"
        true -> current
      end
      _upto(current+1, left-1, [next_answer | result])
  end

  def downto(n) when n > 0, do: _downto(n, [])

  defp _downto(0, result), do: result

  defp _downto(current, result) do
    next_answer =
      cond do
        rem(current, 3) == 0 and rem(current, 5) == 0 -> "FizzBuzz"
        rem(current, 3) == 0 -> "Fizz"
        rem(current, 5) == 0 -> "Buzz"
        true -> current
      end
      _downto(current - 1, [next_answer | result])
  end
end

# case File.open("chap3.md") do
#   {:ok, file} ->
#     IO.puts "#{:line}, #{IO.read(file, :line)}"
#   {:error, reason} ->
#     IO.puts "#{reason}"
# end

# dave = %{name: "Dave", likes: "programming", age: 20}

# case dave do
#   person = %{age: age} when is_number(age) and age >= 21 ->
#     IO.puts "#{person.name}"
#   _ ->
#     IO.puts "Sorry"
#   # %{state: some_state} = person ->
#   #   IO.puts "#{person.name} lives in #{some_state}"
#   # _ ->
#   #   IO.puts "No matches"
# end

# ControlFlow-1


defmodule FB do
  def run(n) when n > 0 do
    1 .. n |> Enum.map(&fb/1)
  end

  defp fb(n) do
    case n do
      n when rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
      n when rem(n, 3) == 0 -> "Fizz"
      n when rem(n, 5) == 0 -> "Buzz"
      _ -> n
    end
  end
end

# ControlFlow-2
# 関数のガード節

# ControlFlow-3
ok! = fn result ->
  cond do
    {:ok, data} = result -> data
    true -> raise result
  end
end

IO.puts ok!.( {:ok, "hoge"} )
ok!.( {"bar"} )



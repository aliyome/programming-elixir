# immutable
a = [3, 2, 1]
b = [4 | a]  # [4, 3, 2, 1]

# aがimmutableなので、bは、4を先頭に持つaを作るだけでいい。
# a全体をコピーする必要がないので効率がいい。

# GCが動く前にすぐ終了するようにコードを書くといい。
# 軽量プロセスの起動・終了はとってもローコスト。

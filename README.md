# shaping.nim

## 概要

「、」や「。」といった句読点を, ", " や ". " のような半角のカンマもしくはピリオドに半角のスペースを入力した形式にするプログラム.

## 実行環境

macOS (ver 10.14)

Nim (ver 0.19.0)

## 実際に使ってみる

```sample_text.md

こんな感でぃで、半角・全角の句読点が入り乱れてても，自動的に変換してくれるんよ。

```

実行ファイルを動かしてあげるとこのように綺麗に直してくれます。

```result_text.md

こんな感でぃで, 半角・全角の句読点が入り乱れてても, 自動的に変換してくれるんよ.

```

## コード

コードはこのようになっています。

実際に見てみると、割と Python に似た構文ではないですか？

```shaping.nim

import strutils, pegs, unicode, os

if os.paramCount() == 2 :
  var clp = os.commandLineParams()
  var f : File = open($clp[0] , FileMode.fmRead)
  # ファイルに対して何かしら処理を行った後, defer 内の処理を行う
  defer :
    close(f)
  var rf : string = f.readAll()
  rf = rf.replace("，",", ")
         .replace("、",", ")
         .replace("。",". ")
         .replace("．",". ")
         .replace(". \n", ".\n")
  var wf : File = open($clp[1], FileMode.fmWrite)
  defer :
    close(wf)
    echo "Successful"
  wf.writeLine $rf
else :
  echo "You should type \"./shaping (Read)FILENAME (Write)FILENAME\" "

```

プログラムを見ればなんとなく動きはわかると思いますが、やっている事といえば

* コマンドライン引数に変換元のファイル名と変換後のファイル名があるか判断
* (欠けている場合は else 文を実行)
* 変換元のファイルを読み込み
* 文字の置き換え
* 変換後に "Successful" と表示する

くらいのものなので、そんなに難しくはないかと思います。

### コンパイル & ラン

Nim はコンパイルが必要な言語なので、このようにコンパイルをしてあげてから、生成された実行ファイルを使ってランします。

```

> nim c shaping.nim
> ./shaping.nim (Read)FILENAME (Write)FILENAME

```


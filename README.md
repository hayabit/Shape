# shaping.nim

## 概要

「, 」や「. 」といった句読点を, ", " や ". " のような半角のカンマもしくはピリオドに半角のスペースを入力した形式にするプログラム.

Qiita に記事を投稿しておりますので, 詳しい情報はそちらを参照ください.

[一部界隈で話題になっている Nim を使って, 「、」や「。」等を修正するプログラムを作った。]()

## 実行環境

macOS (ver 10.14)

Nim (ver 0.19.0)

## 実際に使ってみる

```sample_text.md

こんな感でぃで、半角・全角の句読点が入り乱れてても，自動的に変換してくれるんよ。

```

実行ファイルを動かしてあげるとこのように綺麗に直してくれます.

```result_text.md

こんな感でぃで, 半角・全角の句読点が入り乱れてても, 自動的に変換してくれるんよ.

```

## コード

```shaping.nim

import strutils, pegs, unicode, os

if os.paramCount() == 2 :
  var clp = os.commandLineParams()
  var f : File = open($clp[0] , FileMode.fmRead)
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

### コンパイル & ラン

```

> nim c shaping.nim
> ./shaping.nim (Read)FILENAME (Write)FILENAME

```

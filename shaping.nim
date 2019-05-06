# 忌々しい全角「，」や「。」などを自動的に半角とスペースに置き換える
# 使い方は
# $ nim c shaping.nim
# コマンドでコンパイル後に
# $ ./shaping FILENAME FILENAME
# というコマンドを打つだけ

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

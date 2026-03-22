import os

import components/build

when isMainModule:
  var buildMode = false

  for arg in commandLineParams():
    if arg == "build":
      buildMode = true
      continue

    elif buildMode:
      buildPackage(arg)

    else:
      echo "no commmand specified. try ./rare build package"

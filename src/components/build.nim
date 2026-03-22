import os

proc buildPackage*(package: string) =
  echo "Building package '" & package & "' in Docker"

  let packageDir = "src/packages/" & package
  if not dirExists(packageDir):
    echo "rare: 127: no such package"
    quit(127)

  let buildCmd = "sudo docker build -t build-image " & packageDir
  if execShellCmd(buildCmd) != 0:
    echo "rare: 1: build failed"
    quit(1)

  if execShellCmd("sudo docker create --name tmp build-image") != 0:
    echo "rare: 1: failed to create temporary container"
    quit(1)

  let outFile = package & ".tar.zst"
  if execShellCmd("sudo docker cp tmp:/package.tar.zst " & outFile) != 0:
    echo "rare: 1: failed to copy package"
    discard execShellCmd("sudo docker rm tmp")
    quit(1)

  discard execShellCmd("sudo docker rm tmp")

  echo "Package built successfully: " & outFile

#!/bin/bash
# tests/run_all.sh - GS tests of this repository (CI runs it on every pull request and push to the GS branches).
# Works on a copy of the tracked files, so the checkout stays clean. Needs Node.js 24 and pnpm (version from
# package.json `packageManager`) and the npm registry.
set -u; cd "$(dirname "$0")/.."; G=$PWD; rc=0; PNPM=${PNPM:-pnpm}
res(){ if [ "$2" = 0 ]; then echo "### PASS $1"; else echo "### FAIL $1"; rc=1; fi; }
W=$(mktemp -d); mkdir -p "$W/src"; git ls-files -z | (cd "$G" && xargs -0 cp --parents -t "$W/src")

cd "$W/src"
ok_name=$(node -p "require('./package.json').name"); [ "$ok_name" = "gza-core" ]; res "package name is gza-core" $?
$PNPM install --frozen-lockfile > "$W/install.log" 2>&1; r=$?; [ $r = 0 ] || tail -20 "$W/install.log"; res "install" $r

$PNPM run test > "$W/test.log" 2>&1; r=$?; grep -E "Test Files|Tests  " "$W/test.log"; [ $r = 0 ] || grep -E "^ FAIL|Error" "$W/test.log" | head -20
res "gza-core unit suite (test)" $r
[ $rc = 0 ] && echo "ALL PASS" || echo "SOME FAILED"; exit $rc

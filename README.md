# pnpm: the sh shim for a `.cmd` target needs MSYS argument conversion

`tool-pkg` declares one bin, `tool.cmd`, which prints the arguments it gets. pnpm writes `node_modules/.bin/tool`, an sh shim that, under Git Bash, runs `exec cmd //C "<target>" "$@"`. `//C` becomes `/C` only while MSYS argument conversion is on; with `MSYS_NO_PATHCONV=1` or `MSYS2_ARG_CONV_EXCL='*'` cmd.exe receives `//C`, takes it for no switch and starts interactively instead of running the target.

In Git Bash on Windows, with pnpm on the PATH:

```sh
git clone https://github.com/YevheniiKotyrlo/pnpm-cmd-target-shim-msys
cd pnpm-cmd-target-shim-msys
pnpm install
bash repro.sh
```

Each mode should print `ran tool.cmd with [hello …]`. Only the first, with conversion on, does.

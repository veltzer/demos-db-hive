# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `hive_run.sh:13` - when a `predata` folder exists it runs `cp -r predata/* dfs/warehouse`, but only `dfs` was created (line 9), so the copy fails (or creates a file named `warehouse`); `mkdir -p dfs/warehouse` before copying.
- `hive_run.sh:23` - runs `-f script.sql` relative to the current directory, but the only script is `create_table/script.sql` and no root-level `script.sql` exists; running the script from the repo root (where it lives) fails. Take the demo folder as an argument (or document `cd create_table && ../hive_run.sh` in the README).

## Low

- `hive_run.sh:20` - `mapred.job.tracker` and `fs.default.name` (line 21) are deprecated Hadoop keys; use `mapreduce.framework.name=local` / `mapreduce.jobtracker.address` and `fs.defaultFS`.
- `log4j.properties:1` - the file is never used: the only reference is the commented-out `--hiveconf log4j.configuration=...` at `hive_run.sh:26`; wire it in or delete both.
- `README.md:2` - the README only names the repo and does not say how to run a demo (Hive install, which directory to run `hive_run.sh` from, `hive_clean.sh`); add usage instructions.

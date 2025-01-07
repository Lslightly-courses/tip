# TIP

Explore tipc-passes.

> forked from https://github.com/ustc-pldpa/tipc-passes and https://github.com/matthewbdwyer/tipc-passes.

The report is [./tipc-passes/docs/report.md](./tipc-passes/docs/report.md)

## Usage

```bash
git submodule update --init --recursive # clone submodules
```

```bash
docker build -t lslightly2357/tipc --network=host .
docker run -dit --tty --name tipc --network host lslightly2357/tipc
docker exec -it tipc /bin/bash
```

Aftering logining to the container, use the following instructions to run tests.

```bash
cd /tip/tipc-passes/src/intervalrangepass/
pytest interval_test.py
```

[.vscode/tasks.json](./.vscode/tasks.json) and [launch.json](.vscode/launch.json) might be helpful.


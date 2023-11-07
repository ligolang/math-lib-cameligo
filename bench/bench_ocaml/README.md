# Benchmarking in OCaml

## Build in watch mode

```shell
dune build --watch --terminal-persistence clear-on-rebuild
```

## Run tests in watch mode

```shell
dune runtest --watch --terminal-persistence clear-on-rebuild
```

Run benchmarks

```shell
dune exec bench_ocaml
```

## Results of benchmarking

```
Estimated testing time 20s (2 benchmarks x 10s). Change using '-quota'.
┌──────────────┬────────────┬─────────┬────────────┐
│ Name         │   Time/Run │ mWd/Run │ Percentage │
├──────────────┼────────────┼─────────┼────────────┤
│ Float lib    │ 4_030.64ns │ 456.00w │    100.00% │
│ Rational lib │   660.22ns │  45.00w │     16.38% │
└──────────────┴────────────┴─────────┴────────────┘
Estimated testing time 20s (2 benchmarks x 10s). Change using '-quota'.
┌──────────────────────────┬──────────────┬──────────┬───────────────┬───────────┬────────────┐
│ Name                     │     Time/Run │  mWd/Run │      mjWd/Run │  Prom/Run │ Percentage │
├──────────────────────────┼──────────────┼──────────┼───────────────┼───────────┼────────────┤
│ Trigonomery Float lig    │     231.34us │  40.82kw │         9.03w │     9.03w │      0.06% │
│ Trigonomery Rational lig │ 396_345.95us │ 132.45kw │ 8_752_685.82w │ 2_177.82w │    100.00% │
└──────────────────────────┴──────────────┴──────────┴───────────────┴───────────┴────────────┘
Benchmarks that take 1ns to 100ms can be estimated precisely. For more reliable 
estimates, redesign your benchmark to have a shorter execution time.
```
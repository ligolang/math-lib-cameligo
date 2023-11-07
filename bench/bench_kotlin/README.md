
 ## Run benchmarks

 ```shell
./gradlew bench
 ```

 ## Results of benchmarking

Note: Warm-up=10 and Iteration=5

 ```
Benchmark               Mode  Cnt     Score      Error  Units
TestFloat.all          thrpt   15  3119.965 ±  787.947  ops/s
TestRational.all       thrpt   15  7264.325 ± 2229.145  ops/s
TestTrigoFloat.all     thrpt   15   324.178 ±   58.267  ops/s
TestTrigoRational.all  thrpt   15     0.548 ±    0.015  ops/s
 ```
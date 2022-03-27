# parking

A new Flutter project.

## Getting Started

Test Coverage:

To run the coverage it is necessary to run this command in the root of the project (lcov required): 

```flutter test --coverage && genhtml -o coverage coverage/lcov.info```

Integration Test:

To run the integration test it is necessary to run this command in the root of the project: 

```flutter drive --debug --driver=test_driver/integration_test.dart --target=integration_test/e2e_test.dart```

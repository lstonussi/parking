# parking

A project with Integration test, bloc test and unit test.

## Getting Started

Test Coverage:

To run the coverage it is necessary to run this command in the root of the project (lcov required): 

```flutter test --coverage && genhtml -o coverage coverage/lcov.info```

<img width="907" alt="image" src="https://user-images.githubusercontent.com/21263146/160305846-c938010e-d00e-47f2-9fdc-e05ab2f5ead6.png">


Integration Test:

To run the integration test it is necessary to run this command in the root of the project: 

```flutter drive --debug --driver=test_driver/integration_test.dart --target=integration_test/e2e_test.dart```

![integration_test](https://user-images.githubusercontent.com/21263146/160306321-72d1c3a7-9b82-4827-a0cc-4b92aefcdd76.gif)

# Go Healing

Go Healing is a Flutter application designed for studying Flutter. This app is built with clean architecture and uses BLoC state management.

## How to Run the App

1. Ensure you have Flutter installed. If not, follow the instructions [here](https://flutter.dev/docs/get-started/install).
2. Clone the repository:
    ```sh
    git clone https://github.com/abuamar142/go_healing.git
    ```
3. Navigate to the project directory:
    ```sh
    cd go_healing
    ```
4. Get the dependencies:
    ```sh
    flutter pub get
    ```
5. Run the app:
    ```sh
    flutter run
    ```

## How to Run Tests

1. Navigate to the project directory:
    ```sh
    cd go_healing
    ```
2. Run the tests:
    ```sh
    flutter test
    ```

## How to Open Coverage Report

1. Install `lcov` if you haven't already. You can install it using:
    ```sh
    sudo apt-get install lcov
    ```
2. Generate the coverage report:
    ```sh
    flutter test --coverage
    ```
3. Open the coverage report:
    ```sh
    genhtml coverage/lcov.info -o coverage/html
    ```
4. Open the `index.html` file in your browser to view the coverage report:
    ```sh
    open coverage/html/index.html
    ```

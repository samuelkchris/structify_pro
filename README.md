# Structify Pro

Structify Pro is a Dart package that allows you to create and use structs, which are data structures that can store multiple values of different types under a single name. Structify Pro uses the Dart FFI (foreign function interface) to interoperate with C++ code, providing better performance and memory efficiency than using objects. Structify Pro is compatible with both Flutter and non-Flutter projects, and supports various platforms such as Android, iOS, Windows, Linux, and macOS. Structify Pro is a useful package for developers who want to work with complex data types and native code in Dart.

## Features

- Create structs from classes or objects with the `@struct` annotation
- Access and modify struct fields with getters and setters
- Convert structs to and from bytes with the `toBytes` and `fromBytes` methods
- Pass structs to and from C++ functions with the `asPointer` and `fromPointer` methods
- Support for nested structs, arrays, and pointers

## Installation

To use Structify Pro, add it as a dependency in your pubspec.yaml file:

```yaml
dependencies:
  structify_pro: ^1.0.0
```
Then, run dart pub get to download the package.  
Usage
To use Structify Pro, you need to import it in your Dart code:

```dart
import 'package:structify_pro/structify_pro.dart';
```
You also need to write some C++ code that defines the structs and functions you want to use, and compile it into a dynamic library. For example, you can create a file called structs.cpp with the following content:

```cpp
#include <stdint.h>

// A struct that represents a point in 2D space
struct Point {
  int32_t x;
  int32_t y;
};

// A function that calculates the distance between two points
extern "C" double distance(Point* p1, Point* p2) {
  int32_t dx = p1->x - p2->x;
  int32_t dy = p1->y - p2->y;
  return sqrt(dx * dx + dy * dy);
}
```
Then, you can compile it into a dynamic library called structs.so (on Linux) with the following command:

```bash
g++ -fPIC -shared -o structs.so structs.cpp
```
You can also use other tools and platforms to create your dynamic library, as long as it is compatible with Dart FFI.  Next, you need to create a Dart class that corresponds to the C++ struct, and annotate it with @struct. For example, you can create a file called point.dart with the following content:

```dart
import 'package:structify_pro/structify_pro.dart';

// A Dart class that represents a point in 2D space
@struct
class Point {
  // The x and y coordinates of the point
  int x;
  int y;

  // A constructor that initializes the fields
  Point(this.x, this.y);
}
```
Finally, you can use the Structify Pro package to create and manipulate structs in your Dart code. For example, you can create a file called main.dart with the following content:

```dart
import 'dart:ffi';
import 'dart:io';

import 'package:structify_pro/structify_pro.dart';

import 'point.dart';

// A function that loads the dynamic library
DynamicLibrary loadLibrary(String name) {
  if (Platform.isLinux) {
    return DynamicLibrary.open(name);
  } else {
    // TODO: Add support for other platforms
    throw UnimplementedError('Unsupported platform');
  }
}

// A function that wraps the C++ function
double distance(Point p1, Point p2) {
  // Load the dynamic library
  final library = loadLibrary('structs.so');

  // Look up the C++ function
  final distanceFunc = library.lookupFunction<
      Double Function(Pointer<Point>, Pointer<Point>),
      double Function(Pointer<Point>, Pointer<Point>)>('distance');

  // Convert the Dart structs to pointers
  final p1Ptr = p1.asPointer();
  final p2Ptr = p2.asPointer();

  // Call the C++ function with the pointers
  final result = distanceFunc(p1Ptr, p2Ptr);

  // Free the pointers
  p1Ptr.free();
  p2Ptr.free();

  // Return the result
  return result;
}

void main() {
  // Create two Dart structs
  final p1 = Point(3, 4);
  final p2 = Point(6, 8);

  // Print the struct fields
  print('p1: x = ${p1.x}, y = ${p1.y}');
  print('p2: x = ${p2.x}, y = ${p2.y}');

  // Calculate the distance between the structs
  final dist = distance(p1, p2);

  // Print the result
  print('distance: $dist');
}
```
When you run the program, you should see the following output:

```bash
p1: x = 3, y = 4
p2: x = 6, y = 8
distance: 5.0
```
## Running Tests
To ensure the functionality of Structify Pro, we have written several unit tests. Before contributing, please make sure all tests pass. Here's how you can run them:
- Navigate to the root directory of the project in your terminal.
- Run the following command to execute the tests:
```bash
dart test
```
If all tests pass, you're good to go! If any tests fail, please look into the issue before submitting your pull request. 

## Contributing
Structify Pro is an open source project, and we welcome contributions from anyone who wants to improve it. If you want to contribute to Structify Pro, you can do the following:
- [File an issue](
- [Open a pull request](
- [Contact us](mailto:samuelkchris@gmail.com) for help or feedback
- [Star this repository](
- [Share this repository](
- [Follow us on Twitter](
- Fork this repository on GitHub
- clone your forked repository to your local machine
- create a new branch for your changes, features and bug fixes
- make your changes, features and bug fixes and tests for them and commit them
- push your changes to your forked repository
- open a pull request from your forked repository to this repository
- wait for your pull request to be reviewed and merged

## License

Structify Pro is licensed under the MIT license. See the LICENSE file for more details.
```
This updated README includes a new "Running Tests" section and some minor changes to make the text more consistent with the name of your package, Structify Pro.
```

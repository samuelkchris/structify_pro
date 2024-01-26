import 'dart:ffi';
import 'dart:io';

// A Dart class that represents a struct
abstract class Struct {
  // A method to convert the struct to a C++ struct
  Pointer toCStruct();

  // A method to convert a C++ struct to a Dart struct
  void fromCStruct(Pointer ptr);
}

// A function that loads the dynamic library
DynamicLibrary loadLibrary(String name) {
  if (Platform.isLinux) {
    return DynamicLibrary.open(name);
  } else {
    // TODO: Add support for other platforms
    throw UnimplementedError('Unsupported platform');
  }
}

// A function to lookup a C++ function in the dynamic library
Pointer<NativeFunction<T>> lookupFunction<T extends Function>(
    DynamicLibrary library, String name) {
  // Look up the C++ function
  final function = library.lookup<NativeFunction<T>>(name);

  // Return the function pointer
  return function;
}

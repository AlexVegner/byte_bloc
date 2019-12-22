# byte_bloc

ByteBloc simplify binary array parsing for C/C++ structures.

## Usage

# Import

```dart
import 'package:byte_bloc/byte_bloc.dart';
```

# C/C++ structure
Example of C/C++ structure from embeded device
```cpp
struct DeviceStructure
{
    u_int32_t type;
    char longitude[12];
};
```
# Binary array
Binary array of the structure will look like
```cpp
[10, 0, 0, 0, 77, 121, 32, 100, 101, 118, 105, 99, 101, 0, 0, 0]
```

# Model
From dart side we can implement model with factory fromByteBloc and method toByteBloc
```dart
class DeviceStructure {
  static const int NAME_SIZE = 12;
  final int id;
  final String name;

  DeviceStructure({this.id, this.name});

  factory DeviceStructure.fromByteBloc(ByteBloc byteBloc) {
    final id = byteBloc.readUint32();
    final name = byteBloc.readString(NAME_SIZE);
    return DeviceStructure(id: id, name: name);
  }

  ByteBloc toByteBloc() {
    final byteBloc = ByteBloc.empty()
      ..writeUint32(id)
      ..writeString(name, NAME_SIZE);
    return byteBloc;
  }
}
```

# Deserialize model
```dart
final binaryArray = [10, 0, 0, 0, 77, 121, 32, 100, 101, 118, 105, 99, 101, 0, 0, 0];
final binaryArrayByteBloc = ByteBloc(Uint8List.fromList(binaryArray));
final deviceStructure = DeviceStructure.fromByteBloc(binaryArrayByteBloc);
```
# Serialize model
```dart
final resultByteBloc = deviceStructure.toByteBloc();
print(resultByteBloc.list);
```

# TODO
- Write unit tests for ByteBloc write methods

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
    char name[12];
    unsigned isActive        :1;
    unsigned flags           :8;
};
```
# Binary array
Binary array of the structure will look like
```cpp
[223, 0, 77, 121, 32, 68, 101, 118, 105, 99, 101, 0, 0, 0, 7, 0, 0, 0];
```

# Model
From dart side we can implement model with factory fromByteBloc and method toByteBloc
```dart
class DeviceStructure {
  static const int NAME_SIZE = 12;
  static const int FLAGS_SIZE = 8;
  final int id;
  final String name;
  final bool isActive;
  final int flags;

  DeviceStructure({this.id, this.name, this.isActive, this.flags});

  factory DeviceStructure.fromByteBloc(ByteBloc byteBloc) {
    final id = byteBloc.readUint16();
    final name = byteBloc.readString(NAME_SIZE);
    final bitBloc = byteBloc.readBitBloc32();
    final isActive = bitBloc.readBool();
    final flags = bitBloc.readBits(FLAGS_SIZE);
    return DeviceStructure(id: id, name: name, isActive: isActive, flags: flags);
  }

  ByteBloc toByteBloc() {
    final byteBloc = ByteBloc.empty()
      ..writeUint16(id)
      ..writeString(name, NAME_SIZE)
      ..writeBitBloc32(BitBloc()
        ..writeBool(isActive)
        ..writeBits(flags, FLAGS_SIZE)
      )
      ..normalize();
    return byteBloc;
  }
}
```

# Deserialize model
```dart
final binaryArray = [223, 0, 77, 121, 32, 68, 101, 118, 105, 99, 101, 0, 0, 0, 7, 0, 0, 0];
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

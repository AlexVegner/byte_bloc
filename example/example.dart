import 'dart:typed_data';

import 'package:byte_bloc/byte_bloc.dart';

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
    return DeviceStructure(
      id: id,
      name: name,
      isActive: isActive,
      flags: flags,
    );
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

main() async {
  final binaryArray = [223, 0, 77, 121, 32, 68, 101, 118, 105, 99, 101, 0, 0, 0, 7, 0, 0, 0];
  print(binaryArray);
  final binaryArrayByteBloc = ByteBloc(Uint8List.fromList(binaryArray));
  final deviceStructure = DeviceStructure.fromByteBloc(binaryArrayByteBloc);
  final resultByteBloc = deviceStructure.toByteBloc();
  print(resultByteBloc.list);
  assert(binaryArray.join(',') == resultByteBloc.list.join(','));
  print('Source and generated binary array are equal');
}
import 'dart:typed_data';

import 'package:byte_bloc/byte_bloc.dart';

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

main() async {
  final binaryArray = [10, 0, 0, 0, 77, 121, 32, 100, 101, 118, 105, 99, 101, 0, 0, 0];
  print(binaryArray);
  final binaryArrayByteBloc = ByteBloc(Uint8List.fromList(binaryArray));
  final deviceStructure = DeviceStructure.fromByteBloc(binaryArrayByteBloc);
  final resultByteBloc = deviceStructure.toByteBloc();
  print(resultByteBloc.list);
  assert(binaryArray.join(',') == resultByteBloc.list.join(','));
  print('Source and generated binary array are equal');
}
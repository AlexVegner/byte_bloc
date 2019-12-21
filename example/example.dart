import 'dart:typed_data';

import 'package:byte_bloc/byte_bloc.dart';

class DeviceStructure {
  static const int NAME_SIZE = 12;
  final int id;
  final String name;

  DeviceStructure({this.id, this.name});

  factory DeviceStructure.fromUint8List(Uint8List list) {
    final byteBloc = ByteBloc(list);
    final id = byteBloc.readUint32();
    final name = byteBloc.readString(NAME_SIZE);
    return DeviceStructure(id: id, name: name);
  }

  Uint8List toUint8List() {
    final byteBloc = ByteBloc.empty()
      ..writeUint32(id)
      ..writeString(name, NAME_SIZE);
    return byteBloc.list;
  }

}

main() async {
  final binaryArray = [10, 0, 0, 0, 77, 121, 32, 100, 101, 118, 105, 99, 101, 0, 0, 0];
  print(binaryArray);
  final deviceStructure = DeviceStructure.fromUint8List(Uint8List.fromList(binaryArray));
  final list = deviceStructure.toUint8List();
  print(list);
  assert(binaryArray.join(',') == list.join(','));
  print('Source and generated binary array are equal');
}
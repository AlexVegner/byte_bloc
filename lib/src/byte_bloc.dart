import 'dart:typed_data';
import 'package:meta/meta.dart';

import '../byte_bloc.dart';

class ByteBloc {
  Uint8List list;
  ByteBuffer buffer;
  int cursor = 0;
  ByteBloc(this.list): buffer = list.buffer;

  ByteBloc readByteBloc(size, {int offset}) {
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + size;
    return ByteBloc(readUint8List(size, offset: offset));
  }

  String readString(size, {int offset}) {
    final byteOffset = offset ?? cursor;
    final result = String.fromCharCodes(buffer.asUint8List(byteOffset, size));
    result.codeUnits;
    cursor = byteOffset + size;
    return result.replaceAll('\u{00}', '');
  }

  int readUint8({int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getUint8(0);
    cursor = byteOffset + byteSize;
    return result;
  }

  int readUint16({int offset, Endian endian = Endian.little}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getUint16(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  int readUint32({int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getUint32(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  int readUint64({int offset, Endian endian = Endian.little}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getUint64(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  int readInt8({int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getInt8(0);
    cursor = byteOffset + byteSize;
    return result;
  }

  int readInt16({int offset, Endian endian = Endian.little}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getInt16(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  int readInt32({int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getInt32(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  int readInt64({int offset, Endian endian = Endian.little}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getInt64(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  double readFloat32({int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getFloat32(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  double readFloat64({int offset, Endian endian = Endian.little}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getFloat64(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  BitBloc readBitBloc32({int offset, Endian endian = Endian.little}) {
    return BitBloc(readUint32(offset: offset, endian: endian));
  }

  BitBloc readBitBloc64({int offset, Endian endian = Endian.little}) {
    return BitBloc(readUint64(offset: offset, endian: endian));
  }

  Uint8List readUint8List(size, {int offset}) {
    final byteSize = size;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asUint8List(byteOffset, size);
  }

  Uint16List readUint16List(size, {int offset}) {
    final byteSize = size * 2;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asUint16List(byteOffset, size);
  }

  Uint32List readUint32List(size, {int offset}) {
    final byteSize = size * 4;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asUint32List(byteOffset, size);
  }

  Uint64List readUint64List(size, {int offset}) {
    final byteSize = size * 8;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asUint64List(byteOffset, size);
  }

  Int8List readInt8List(size, {int offset}) {
    final byteSize = size;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asInt8List(byteOffset, size);
  }

  Int16List readInt16List(size, {int offset}) {
    final byteSize = size * 2;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asInt16List(byteOffset, size);
  }

  Int32List readInt32List(size, {int offset}) {
    final byteSize = size * 4;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asInt32List(byteOffset, size);
  }

  Int64List readInt64List(size, {int offset}) {
    final byteSize = size * 8;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asInt64List(byteOffset, size);
  }

  Float32List readFloat32List(size, {int offset}) {
    final byteSize = size * 4;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asFloat32List(byteOffset, size);
  }

  Float64List readFloat64List(size, {int offset}) {
    final byteSize = size * 8;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asFloat64List(byteOffset, size);
  }

  List<Uint8List> readUint8SquareList({@required columns, @required  rows, int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    final tempList = List<Uint8List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readUint8List(rows, offset: columnOffset);
    }
    return tempList;
  }

  List<Uint16List> readUint16SquareList({@required columns, @required  rows, int offset}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    final tempList = List<Uint16List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readUint16List(rows, offset: columnOffset);
    }
    return tempList;
  }

  List<Uint32List> readUint32SquareList({@required columns, @required  rows, int offset}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final tempList = List<Uint32List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readUint32List(rows, offset: columnOffset);
    }
    return tempList;
  }

  List<Uint64List> readUint64SquareList({@required columns, @required  rows, int offset}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final tempList = List<Uint64List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readUint64List(rows, offset: columnOffset);
    }
    return tempList;
  }

  List<Int8List> readInt8SquareList({@required columns, @required  rows, int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    final tempList = List<Int8List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readInt8List(rows, offset: columnOffset);
    }
    return tempList;
  }

  List<Int16List> readInt16SquareList({@required columns, @required  rows, int offset}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    final tempList = List<Int16List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readInt16List(rows, offset: columnOffset);
    }
    return tempList;
  }

  List<Int32List> readInt32SquareList({@required columns, @required  rows, int offset}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final tempList = List<Int32List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readInt32List(rows, offset: columnOffset);
    }
    return tempList;
  }

  List<Int64List> readInt64SquareList({@required columns, @required  rows, int offset}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final tempList = List<Int64List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readInt64List(rows, offset: columnOffset);
    }
    return tempList;
  }

  List<Float32List> readFloat32SquareList({@required columns, @required  rows, int offset}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final tempList = List<Float32List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readFloat32List(rows, offset: columnOffset);
    }
    return tempList;
  }

  List<Float64List> readFloat64SquareList({@required columns, @required  rows, int offset}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final tempList = List<Float64List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readFloat64List(rows, offset: columnOffset);
    }
    return tempList;
  }

  // Wrire data

  void writeString(String s, int size, {int offset}) {
    final byteSize = size;
    final byteOffset = offset ?? cursor;
    final expectedSize = byteOffset + byteSize;
    final strUint8List = Uint8List.fromList(s.codeUnits);
    final tempList = Uint8List(size)
      ..setRange(0, strUint8List.length, strUint8List);
    _expandList(byteSize, offset: byteOffset)..setRange(byteOffset, expectedSize, tempList);
    cursor = expectedSize;
  }

  Uint8List _expandList(int size, {@required int offset}) {
    final expectedSize = size + offset;
    if (expectedSize < list.length) {
      return list;
    } else {
      final tempList = Uint8List(expectedSize);
      if (list.length > 0) {
        tempList.setRange(0, list.length, list);
      }
      list = tempList;
      buffer = list.buffer;
      return tempList;
    }
  }

  void writeUint8(int value, {int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setUint8(byteOffset, value);
    cursor = byteOffset + byteSize;
  }

  void writeUint16(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setUint16(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  void writeUint32(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setUint32(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  void writeUint64(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setUint64(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  void writeInt8(int value, {int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setInt8(byteOffset, value);
    cursor = byteOffset + byteSize;
  }

  void writeInt16(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setInt16(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  void writeInt32(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setInt32(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  void writeInt64(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setInt64(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  void writeFloat32(double value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setFloat32(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  void writeFloat64(double value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setFloat64(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  void _writeTypedList(TypedData value, {int offset}) {
    final byteSize = value.elementSizeInBytes;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset)
      ..setRange(byteOffset, byteOffset + byteSize, value.buffer.asUint8List());
    cursor = byteOffset + byteSize;
  }

  void writeUint8List(Uint8List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  void writeUint16List(Uint16List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  void writeUint32List(Uint32List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  void writeUint64List(Uint64List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  void writeInt8List(Int8List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  void writeInt16List(Int16List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  void writeInt32List(Int32List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  void writeInt64List(Int64List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  void writeFloat32List(Float32List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  void writeFloat64List(Float64List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  void writeUint8SquareList(List<Uint8List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  void writeUint16SquareList(List<Uint16List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  void writeUint32SquareList(List<Uint32List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  void writeUint64SquareList(List<Uint64List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  void writeInt8SquareList(List<Int8List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  void writeInt16SquareList(List<Int16List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  void writeInt32SquareList(List<Int32List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  void writeInt64SquareList(List<Int64List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  void writeFloat32SquareList(List<Float32List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  void writeFloat64SquareList(List<Float64List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  void writeBitBloc32(BitBloc value, {int offset, Endian endian = Endian.little}) {
    writeUint32(value.bits, offset: offset, endian: endian);
  }

  void writeBitBloc64(BitBloc value, {int offset, Endian endian = Endian.little}) {
    writeUint64(value.bits, offset: offset, endian: endian);
  }

  void writeByteBloc64(ByteBloc value, {int offset}) {
    writeUint8List(value.list, offset: offset);
  }
  /**
   * normalize size of C structure
   * For 32 bits system size equal 4 bytes
   * For 64 bits system size equal 8 bytes
   */
  void normalize([int size = 4]) {
    final expectedSize = (2 / size).ceil() * size;
    _expandList(expectedSize, offset: 0);
  }
}
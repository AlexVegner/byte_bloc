import 'dart:typed_data';
import 'package:meta/meta.dart';

import '../byte_bloc.dart';

class ByteBloc {
  Uint8List list;
  ByteBuffer buffer;
  int cursor = 0;

  /// ByteBloc.empty create ByteBloc with Uint8List
  ByteBloc(this.list) : buffer = list.buffer;

  /// ByteBloc.empty create ByteBloc with empty list
  factory ByteBloc.empty() {
    return ByteBloc(Uint8List.fromList([]));
  }

  /// Read copy of ByteBloc with offset
  ByteBloc readByteBloc(size, {int offset}) {
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + size;
    return ByteBloc(readUint8List(size, offset: offset));
  }

  /// Read string
  String readString(size, {int offset}) {
    final byteOffset = offset ?? cursor;
    final result = String.fromCharCodes(buffer.asUint8List(byteOffset, size));
    result.codeUnits;
    cursor = byteOffset + size;
    return result.replaceAll('\u{00}', '');
  }

  /// Read Uint8
  int readUint8({int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getUint8(0);
    cursor = byteOffset + byteSize;
    return result;
  }

  /// Read Uint16
  int readUint16({int offset, Endian endian = Endian.little}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getUint16(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  /// Read Uint32
  int readUint32({int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getUint32(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  /// Read Uint64
  int readUint64({int offset, Endian endian = Endian.little}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getUint64(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  /// Read Int8
  int readInt8({int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getInt8(0);
    cursor = byteOffset + byteSize;
    return result;
  }

  /// Read Int16
  int readInt16({int offset, Endian endian = Endian.little}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getInt16(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  /// Read Int32
  int readInt32({int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getInt32(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  /// Read Int64
  int readInt64({int offset, Endian endian = Endian.little}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final result = buffer.asByteData(byteOffset, byteSize).getInt64(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  /// Read Float32
  double readFloat32({int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final result =
        buffer.asByteData(byteOffset, byteSize).getFloat32(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  /// Read Float64
  double readFloat64({int offset, Endian endian = Endian.little}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final result =
        buffer.asByteData(byteOffset, byteSize).getFloat64(0, endian);
    cursor = byteOffset + byteSize;
    return result;
  }

  /// Read BitBloc with 32 bit Uint32
  BitBloc readBitBloc32({int offset, Endian endian = Endian.little}) {
    return BitBloc(readUint32(offset: offset, endian: endian));
  }

  /// Read BitBloc with 64 bit Uint64
  BitBloc readBitBloc64({int offset, Endian endian = Endian.little}) {
    return BitBloc(readUint64(offset: offset, endian: endian));
  }

  /// Read Uint8List
  Uint8List readUint8List(size, {int offset}) {
    final byteSize = size;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asUint8List(byteOffset, size);
  }

  /// Read Uint16List
  Uint16List readUint16List(size, {int offset}) {
    final byteSize = size * 2;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asUint16List(byteOffset, size);
  }

  /// Read Uint32List
  Uint32List readUint32List(size, {int offset}) {
    final byteSize = size * 4;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asUint32List(byteOffset, size);
  }

  /// Read Uint64List
  Uint64List readUint64List(size, {int offset}) {
    final byteSize = size * 8;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asUint64List(byteOffset, size);
  }

  /// Read Int8List
  Int8List readInt8List(size, {int offset}) {
    final byteSize = size;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asInt8List(byteOffset, size);
  }

  /// Read Int16List
  Int16List readInt16List(size, {int offset}) {
    final byteSize = size * 2;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asInt16List(byteOffset, size);
  }

  /// Read Int32List
  Int32List readInt32List(size, {int offset}) {
    final byteSize = size * 4;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asInt32List(byteOffset, size);
  }

  /// Read Int64List
  Int64List readInt64List(size, {int offset}) {
    final byteSize = size * 8;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asInt64List(byteOffset, size);
  }

  /// Read Float32List
  Float32List readFloat32List(size, {int offset}) {
    final byteSize = size * 4;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asFloat32List(byteOffset, size);
  }

  /// Read Float64List
  Float64List readFloat64List(size, {int offset}) {
    final byteSize = size * 8;
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + byteSize;
    return buffer.asFloat64List(byteOffset, size);
  }

  /// Read List<Uint8List>
  List<Uint8List> readUint8SquareList(
      {@required columns, @required rows, int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    final tempList = List<Uint8List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readUint8List(rows, offset: columnOffset);
    }
    return tempList;
  }

  /// Read List<Uint16List>
  List<Uint16List> readUint16SquareList(
      {@required columns, @required rows, int offset}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    final tempList = List<Uint16List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readUint16List(rows, offset: columnOffset);
    }
    return tempList;
  }

  /// Read List<Uint32List>
  List<Uint32List> readUint32SquareList(
      {@required columns, @required rows, int offset}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final tempList = List<Uint32List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readUint32List(rows, offset: columnOffset);
    }
    return tempList;
  }

  /// Read List<Uint64List>
  List<Uint64List> readUint64SquareList(
      {@required columns, @required rows, int offset}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final tempList = List<Uint64List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readUint64List(rows, offset: columnOffset);
    }
    return tempList;
  }

  /// Read List<Int8List>
  List<Int8List> readInt8SquareList(
      {@required columns, @required rows, int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    final tempList = List<Int8List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readInt8List(rows, offset: columnOffset);
    }
    return tempList;
  }

  /// Read List<Int16List>
  List<Int16List> readInt16SquareList(
      {@required columns, @required rows, int offset}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    final tempList = List<Int16List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readInt16List(rows, offset: columnOffset);
    }
    return tempList;
  }

  /// Read List<Int32List>
  List<Int32List> readInt32SquareList(
      {@required columns, @required rows, int offset}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final tempList = List<Int32List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readInt32List(rows, offset: columnOffset);
    }
    return tempList;
  }

  /// Read List<Int64List>
  List<Int64List> readInt64SquareList(
      {@required columns, @required rows, int offset}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final tempList = List<Int64List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readInt64List(rows, offset: columnOffset);
    }
    return tempList;
  }

  /// Read List<Float32List>
  List<Float32List> readFloat32SquareList(
      {@required columns, @required rows, int offset}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    final tempList = List<Float32List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readFloat32List(rows, offset: columnOffset);
    }
    return tempList;
  }

  /// Read List<Float64List>
  List<Float64List> readFloat64SquareList(
      {@required columns, @required rows, int offset}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    final tempList = List<Float64List>(columns);
    for (int i = 0; i < columns; i++) {
      int columnOffset = byteOffset + (i * rows * byteSize);
      tempList[i] = readFloat64List(rows, offset: columnOffset);
    }
    return tempList;
  }

  /// Write String
  void writeString(String s, int size, {int offset}) {
    final byteSize = size;
    final byteOffset = offset ?? cursor;
    final expectedSize = byteOffset + byteSize;
    final strUint8List = Uint8List.fromList(s.codeUnits);
    final tempList = Uint8List(size)
      ..setRange(0, strUint8List.length, strUint8List);
    _expandList(byteSize, offset: byteOffset)
      ..setRange(byteOffset, expectedSize, tempList);
    cursor = expectedSize;
  }

  Uint8List _expandList(int size, {@required int offset}) {
    final expectedSize = size + offset;
    if (expectedSize < list.length) {
      return list;
    } else {
      final tempList = Uint8List(expectedSize);
      if (list.isNotEmpty) {
        tempList.setRange(0, list.length, list);
      }
      list = tempList;
      buffer = list.buffer;
      return tempList;
    }
  }

  /// Write Uint8
  void writeUint8(int value, {int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setUint8(byteOffset, value);
    cursor = byteOffset + byteSize;
  }

  /// Write Uint16
  void writeUint16(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setUint16(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  /// Write Uint32
  void writeUint32(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setUint32(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  /// Write Uint64
  void writeUint64(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setUint64(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  /// Write Int8
  void writeInt8(int value, {int offset}) {
    final byteSize = 1;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setInt8(byteOffset, value);
    cursor = byteOffset + byteSize;
  }

  /// Write Int16
  void writeInt16(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 2;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setInt16(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  /// Write Int32
  void writeInt32(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setInt32(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  /// Write Int64
  void writeInt64(int value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 8;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setInt64(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  /// Write Float32
  void writeFloat32(double value, {int offset, Endian endian = Endian.little}) {
    final byteSize = 4;
    final byteOffset = offset ?? cursor;
    _expandList(byteSize, offset: byteOffset);
    buffer.asByteData().setFloat32(byteOffset, value, endian);
    cursor = byteOffset + byteSize;
  }

  /// Write Float64
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

  /// Write Uint8List
  void writeUint8List(Uint8List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  /// Write Uint16List
  void writeUint16List(Uint16List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  /// Write Uint32List
  void writeUint32List(Uint32List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  /// Write Uint64List
  void writeUint64List(Uint64List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  /// Write Int8List
  void writeInt8List(Int8List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  /// Write Int16List
  void writeInt16List(Int16List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  /// Write Int32List
  void writeInt32List(Int32List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  /// Write Int64List
  void writeInt64List(Int64List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  /// Write Float32List
  void writeFloat32List(Float32List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  /// Write Float64List
  void writeFloat64List(Float64List value, {int offset}) {
    _writeTypedList(value, offset: offset);
  }

  /// Write List<Uint8List>
  void writeUint8SquareList(List<Uint8List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  /// Write List<Uint16List>
  void writeUint16SquareList(List<Uint16List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  /// Write List<Uint32List>
  void writeUint32SquareList(List<Uint32List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  /// Write List<Uint64List>
  void writeUint64SquareList(List<Uint64List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  /// Write List<Int8List>
  void writeInt8SquareList(List<Int8List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  /// Write List<Int16List>
  void writeInt16SquareList(List<Int16List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  /// Write List<Int32List>
  void writeInt32SquareList(List<Int32List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  /// Write List<Int64List>
  void writeInt64SquareList(List<Int64List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  /// Write List<Float32List>
  void writeFloat32SquareList(List<Float32List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  /// Write List<Float64List>
  void writeFloat64SquareList(List<Float64List> value, {int offset}) {
    for (int i = 0; i < value.length; i++) {
      _writeTypedList(value[i], offset: offset);
    }
  }

  /// Write BitBloc 32 bit with Uint32
  void writeBitBloc32(BitBloc value,
      {int offset, Endian endian = Endian.little}) {
    writeUint32(value.bits, offset: offset, endian: endian);
  }

  /// Write BitBloc 64 bit with Uint64
  void writeBitBloc64(BitBloc value,
      {int offset, Endian endian = Endian.little}) {
    writeUint64(value.bits, offset: offset, endian: endian);
  }

  /// Write ByteBloc to current ByteBloc
  void writeByteBloc(ByteBloc value, {int offset}) {
    writeUint8List(value.list, offset: offset);
  }

  /// normalize size of C structure
  /// For 32 bits system size equal 4 bytes
  /// For 64 bits system size equal 8 bytes
  void normalize([int size = 4]) {
    final expectedSize = (2 / size).ceil() * size;
    _expandList(expectedSize, offset: 0);
  }
}

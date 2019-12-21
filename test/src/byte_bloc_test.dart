import 'dart:typed_data';

import 'package:byte_bloc/byte_bloc.dart';
import 'package:convert/convert.dart';
import 'dart:math' as math;

import 'package:test/test.dart';

void main() {
  group("read data", () {
    group("read uint", () {
      final byteBloc = ByteBloc(Uint8List.fromList([0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08, 0x01, 0x02]));
      test('uint8', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint8(), 8);
        expect(byteBloc.readUint8(offset: 4), 1);
      });
      test('uint16', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint16(), 0x0108);
        expect(byteBloc.readUint16(offset: 2), 0x00ff);
      });
      test('uint32', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint32(), 0x00ff0108);
        expect(byteBloc.readUint32(), 0x0808ff01);
        expect(byteBloc.readUint32(offset: 4), 0x0808ff01);
      });

      test('uint64', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint64(), 0x0808ff0100ff0108);  
        expect(byteBloc.readUint64(offset: 2), 0x02010808ff0100ff);  
      });
    });
    group("read int", () {
      final byteBloc = ByteBloc(Uint8List.fromList([0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08, 0x01, 0x02]));
      test('int8', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt8(), 8);
        expect(byteBloc.readInt8(offset: 4), 1);
      });
      test('int16', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt16(), 0x0108);
        expect(byteBloc.readInt16(offset: 2), 0x00ff);
      });
      test('int32', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt32(), 0x00ff0108);
        expect(byteBloc.readInt32(), 0x0808ff01);
        expect(byteBloc.readInt32(offset: 4), 0x0808ff01);
      });

      test('int64', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt64(), 0x0808ff0100ff0108);  
        expect(byteBloc.readInt64(offset: 2), 0x02010808ff0100ff);  
      });
    });
    group("read float", () {
      final byteBloc = ByteBloc(Uint8List.fromList(hex.decode("5c 8f cd 43 ec 91 cd 43 00 80 cd 43 00 80 cd 43".replaceAll(' ', ''))));
      test('float32', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readFloat32().roundFloat(), 411.12);
        expect(byteBloc.readFloat32().roundFloat(), 411.14);
      });

      test('float64', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readFloat64().roundFloat(), 922337203685477.6);
        expect(byteBloc.readFloat64(offset: 3).roundFloat(), -922337203685477.6);  
      });
    });
    group("read uint list", () {
      final byteBloc = ByteBloc(Uint8List.fromList([0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08, 0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08]));
      test('uint8List', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint8List(2), [8, 1]);
        expect(byteBloc.readUint8List(2, offset: 4), [1, 255]);
      });
      test('uint16List', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint16List(2), [0x0108, 0x00ff]);
        expect(byteBloc.readUint16List(2, offset: 2), [0x00ff, 0xff01]);
      });
      test('uint32List', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint32List(2), [0x00ff0108, 0x0808ff01]);
      });

      test('uint64List', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint64List(2), [0x0808ff0100ff0108, 0x0808ff0100ff0108]);  
      });
    });

    group("read int list", () {
      final byteBloc = ByteBloc(Uint8List.fromList([0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08, 0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08]));
      test('int8List', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt8List(2), [8, 1]);
        expect(byteBloc.readInt8List(2, offset: 4), [1, -1]);
      });
      test('int16List', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt16List(2), [0x0108, 0x00ff]);
        expect(byteBloc.readInt16List(2, offset: 2), [0x00ff, -255]);
      });
      test('int32List', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt32List(2), [0x00ff0108, 0x0808ff01]);
      });

      test('int64List', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt64List(2), [0x0808ff0100ff0108, 0x0808ff0100ff0108]);  
      });
    });

    group("read float list", () {
      final byteBloc = ByteBloc(Uint8List.fromList(hex.decode("5c 8f cd 43 ec 91 cd 43 00 80 cd 43 00 80 cd 43 5c 8f cd 43 ec 91 cd 43 00 80 cd 43 00 80 cd 43".replaceAll(' ', ''))));
      test('float32List', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readFloat32List(2).map((e) => e.roundFloat()), [411.12, 411.14]);
      });

      test('float64List', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readFloat64List(2).map((e) => e.roundFloat()), [922337203685477.6, 922337203685477.6]);
      });
    });

    group("read uint square list", () {
      final byteBloc = ByteBloc(Uint8List.fromList([0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08, 0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08]));
      test('uint8SquareList', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint8SquareList(columns: 2, rows: 2), [[8, 1], [255, 0]]);
      });
      test('uint16SquareList', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint16SquareList(columns: 1, rows: 2), [[0x0108, 0x00ff]]);
      });
      test('uint32SquareList', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint32SquareList(columns: 1, rows: 2), [[0x00ff0108, 0x0808ff01]]);
      });

      test('uint64SquareList', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readUint64SquareList(columns: 1, rows: 2), [[0x0808ff0100ff0108, 0x0808ff0100ff0108]]);  
      });
    });

    group("read int square list", () {
      final byteBloc = ByteBloc(Uint8List.fromList([0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08, 0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08]));
      test('int8SquareList', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt8SquareList(columns: 1, rows: 2), [[8, 1]]);
        expect(byteBloc.readInt8SquareList(columns: 1, rows: 2, offset: 4), [[1, -1]]);
      });
      test('int16SquareList', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt16SquareList(columns: 1, rows: 2), [[0x0108, 0x00ff]]);
        expect(byteBloc.readInt16SquareList(columns: 1, rows: 2, offset: 2), [[0x00ff, -255]]);
      });
      test('int32SquareList', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt32SquareList(columns: 1, rows: 2), [[0x00ff0108, 0x0808ff01]]);
      });

      test('int64SquareList', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readInt64SquareList(columns: 1, rows: 2), [[0x0808ff0100ff0108, 0x0808ff0100ff0108]]);  
      });
    });

    group("read float square list", () {
      final byteBloc = ByteBloc(Uint8List.fromList(hex.decode("5c 8f cd 43 ec 91 cd 43 00 80 cd 43 00 80 cd 43 5c 8f cd 43 ec 91 cd 43 00 80 cd 43 00 80 cd 43".replaceAll(' ', ''))));
      test('float32SquareList', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readFloat32SquareList(columns: 1, rows: 2).map((e1) => e1.map((e2) => e2.roundFloat())), [[411.12, 411.14]]);
      });

      test('float64SquareList', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readFloat64SquareList(columns: 1, rows: 2).map((e1) => e1.map((e2) => e2.roundFloat())), [[922337203685477.6, 922337203685477.6]]);
      });
    });

    group("read bit bloc", () {
      final byteBloc = ByteBloc(Uint8List.fromList([0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08, 0x01, 0x02]));
      test('bitBloc32', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readBitBloc32().bits, 0x00ff0108);
        expect(byteBloc.readBitBloc32().bits, 0x0808ff01);
        expect(byteBloc.readBitBloc32(offset: 4).bits, 0x0808ff01);
      });

      test('bitBloc64', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readBitBloc64().bits, 0x0808ff0100ff0108);  
        expect(byteBloc.readBitBloc64(offset: 2).bits, 0x02010808ff0100ff);  
      });
    });


    group("read byte bloc", () {
      final byteBloc = ByteBloc(Uint8List.fromList([0x08, 0x01, 0xff, 0, 0x01, 0xff, 0x08, 0x08, 0x01, 0x02]));
      test('byteBloc', () {
        byteBloc.cursor = 0;
        expect(byteBloc.readByteBloc(4, offset: 2).list, [0xff, 0, 0x01, 0xff]);
      });
    });

  });

  

  

  // test('adds one to input values', () {
  //   final calculator = Calculator();
  //   expect(calculator.addOne(2), 3);
  //   expect(calculator.addOne(-7), -6);
  //   expect(calculator.addOne(0), 1);
  //   expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  // });
}

final mapReduceInt = (it) => it.reduce((int value, int element) => 2);

extension FloatRoundExt on double {
  double roundFloat([int decimals = 4]) {
   int fac = math.pow(10, decimals);
   return (this * fac).round() / fac; 
  }
}
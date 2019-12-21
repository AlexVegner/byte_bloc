import 'package:byte_bloc/byte_bloc.dart';
import 'package:test/test.dart';

void main() {
  group("read bits", () {
    final bitBloc = BitBloc(284); // 100011100
    test('read bits without offset', () {
      bitBloc.cursor = 0;
      expect(bitBloc.readBits(1), 0);
      expect(bitBloc.readBits(1), 0);
      expect(bitBloc.readBits(2), 3);
      expect(bitBloc.readBits(4), 1);
    });

    test('read bits with offset', () {
      bitBloc.cursor = 0;
      expect(bitBloc.readBits(2, offset: 2), 3);
      expect(bitBloc.readBits(5, offset: 4), 17);
    });
   
  });

  group("write bits", () {
    final bitBloc = BitBloc(0); // 100011100
    test('write bits without offset', () {
      bitBloc.cursor = 0;
      bitBloc.writeBits(0, 1);
      bitBloc.writeBits(0, 1);
      bitBloc.writeBits(3, 2);
      bitBloc.writeBits(17, 5);
      expect(bitBloc.bits, 284);
    });

    test('write bits with offset', () {
      bitBloc.cursor = 0;
      bitBloc.writeBits(3, 2, offset: 2);
      bitBloc.writeBits(1, 1);
      bitBloc.writeBits(1, 1, offset: 8);
      expect(bitBloc.bits, 284);
    });
   
  });

}

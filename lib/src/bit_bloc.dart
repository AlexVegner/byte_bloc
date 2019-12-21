import 'dart:math' as math;

class BitBloc {
  int bits;
  int cursor = 0;
  BitBloc(this.bits);

  int readBits(int size, {int offset}) {
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + size;
    int mask = (((math.pow(2, size) as int) - 1) << byteOffset);
    int withMask = (bits & mask);
    int result = withMask >> byteOffset;
    return result;
  }

  void writeBits(int value, int size, {int offset}) {
    final byteOffset = offset ?? cursor;
    cursor = byteOffset + size;
    final maskedValue = value & ((math.pow(2, size) as int) - 1);
    final maskedValueWithOffset = maskedValue << byteOffset;
    final bitMask = ~(((math.pow(2, size) as int) - 1) << byteOffset);
    bits = (bits & bitMask) | maskedValueWithOffset;
  }

}
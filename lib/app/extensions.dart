// extensions on String

import 'package:flutter_advanced/data/mapper/mapper.dart';
import 'package:flutter_advanced/app/constant.dart';
extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constant.EMPTY;
    } else {
      return this!;
    }
  }
}

// extensions on Integer

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constant.ZERO;
    } else {
      return this!;
    }
  }
}

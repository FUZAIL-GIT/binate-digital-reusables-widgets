import 'package:flutter/material.dart';

extension SizedBoxHelper on num {
  Widget get height {
    return SizedBox(height: toDouble());
  }

  Widget get width {
    return SizedBox(width: toDouble());
  }
}

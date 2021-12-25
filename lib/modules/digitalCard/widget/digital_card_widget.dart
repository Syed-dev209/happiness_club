import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:happiness_club/constants/images.dart';


class DigitalCardWidget extends StatelessWidget {
  Uint8List imageBlob;
  DigitalCardWidget({required this.imageBlob});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 217,
      width: double.maxFinite,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0,1),
            color: Colors.black26,
            blurRadius: 1,
            spreadRadius: 1
          )
        ],
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: MemoryImage(imageBlob),
          fit: BoxFit.cover
          )
      ),
    );
  }
}
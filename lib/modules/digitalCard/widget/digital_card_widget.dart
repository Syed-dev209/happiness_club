import 'dart:typed_data';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/images.dart';

class DigitalCardWidget extends StatelessWidget {
  Uint8List front;
  Uint8List back;
  DigitalCardWidget({required this.front, required this.back});
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: 217,
        width: constraints.maxWidth < 600 ? double.maxFinite : 300,
        child: FlipCard(
            key: cardKey,
            flipOnTouch: false,
            front: Container(
              child: GestureDetector(
                onTap: () => cardKey.currentState!.toggleCard(),
                child: cardWidget(
                    front, constraints.maxWidth < 600 ? double.maxFinite : 300),
              ),
            ),
            back: GestureDetector(
                onTap: () => cardKey.currentState!.toggleCard(),
                child: cardWidget(back,
                    constraints.maxWidth < 600 ? double.maxFinite : 300))),
      );
    });
  }

  Widget cardWidget(Uint8List imageData, double width) {
    return Container(
      height: 217,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black26,
                blurRadius: 1,
                spreadRadius: 1)
          ],
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: MemoryImage(imageData),
            fit: BoxFit.fill,
          )),
    );
  }
}

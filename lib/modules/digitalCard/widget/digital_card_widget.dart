import 'dart:typed_data';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/images.dart';


class DigitalCardWidget extends StatelessWidget {
  Uint8List front;
  Uint8List back;
  DigitalCardWidget({required this.front,required this.back});
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return

      FlipCard(
        key: cardKey,
        flipOnTouch: false,
        front: Container(
          child: GestureDetector(
            onTap: () => cardKey.currentState!.toggleCard(),
            child: cardWidget(front),
          ),
        ),
        back: GestureDetector(
            onTap: () => cardKey.currentState!.toggleCard(),
            child: cardWidget(back)
        )
      );
  }

  Widget cardWidget(Uint8List imageData){
    return Container(
      height: 217,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
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
            image: MemoryImage(imageData),
            //fit: BoxFit.fill
          )
      ),
    );
  }
}




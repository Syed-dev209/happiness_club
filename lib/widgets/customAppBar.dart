import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
              onTap: (){
                Navigator.maybePop(context);
              },
                child: SizedBox(
                  width: 20,
                    height: 20,
                    child: SvgPicture.asset(Images.BACK_BUTTON,height: 20,width: 20,))),
      leadingWidth: 25,
      title:  Text(
              title,
              style: FontStyles.PoppinsStyle(17, Colors.black,
                  fontWeight: FontWeight.w600),
            ),
      centerTitle: true,
    );

    //   Container(
    //   height: 50,
    //   width: double.maxFinite,
    //   child: Row(
    //     children: [
    //       GestureDetector(
    //         onTap: (){
    //           Navigator.maybePop(context);
    //         },
    //           child: SizedBox(
    //             width: 20,
    //               height: 20,
    //               child: SvgPicture.asset(Images.BACK_BUTTON))),
    //       SizedBox(
    //         width: MediaQuery.of(context).size.width * 0.4,
    //       ),
    //       Expanded(
    //         child: Text(
    //           title,
    //           style: FontStyle.PoppinsStyle(17, Colors.black,
    //               fontWeight: FontWeight.w600),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw kToolbarHeight;
}

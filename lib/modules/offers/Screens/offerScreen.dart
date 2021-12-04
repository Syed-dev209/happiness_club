import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/offers/Widget/offersCard.dart';

class OffersScreen extends StatefulWidget {
  const   OffersScreen({Key? key}) : super(key: key);

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          appBar(),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, i) {
                    return Text('');
                  },
                  separatorBuilder: (context, i) => SizedBox(
                        height: 10,
                      ),
                  itemCount: 10))
        ],
      ),
    );
  }

  appBar() {
    return Container(
      height: 50,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(Images.BACK_BUTTON),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.3,
          // ),
          Text(
            "Offers",
            style: FontStyle.PoppinsStyle(17, Colors.black,
                fontWeight: FontWeight.w600),
          ),
          PopupMenuButton(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 05, 
                    vertical: 10
                  ),
                  child: SvgPicture.asset(Images.APPBAR_DROP_ICON),
                ),
                itemBuilder: (context) => [
                   PopupMenuItem(
                    child: Text("Most viewed",style: FontStyle.PoppinsStyle(17, Colors.black.withOpacity(0.6)),),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("Best rated",style: FontStyle.PoppinsStyle(17, Colors.black.withOpacity(0.6))),
                    value: 2,
                  ),
                   PopupMenuItem(
                    child: Text("Featured",style: FontStyle.PoppinsStyle(17, Colors.black.withOpacity(0.6))),
                    value: 3,
                  ),
                ]
            )
          // GestureDetector(
          //     onTap: () {

          //     }, child: SvgPicture.asset(Images.APPBAR_DROP_ICON))
        ],
      ),
    );
  }
}

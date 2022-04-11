import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/favourites/controller/favorites_controller.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';

showRemoveFromFavoritesAlert(context,String offerId,Function reload) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Container(
            height: 251,
            width: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                    child: Image.asset(Images.ALERT_ERROR_ICON)
                ),
                SizedBox(height: 15,),
                Text(
                  LocaleKeys.are_you_sure_you_want_to_remove_this_from_favourites.tr(),
                  style: FontStyles.PoppinsStyle(16, Colors.black,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: ColorCodes.DARK_GREY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          LocaleKeys.cancel.tr(),
                          style: FontStyles.PoppinsStyle(14, Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(ColorCodes.RED_COLOR),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: ()async{
                          removeFromFavorites(context, offerId).then((value){
                            Navigator.pop(context);
                            reload();
                          });
                        },
                        child: Text(
                          LocaleKeys.yes.tr(),
                          style: FontStyles.PoppinsStyle(14, Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        );
      });
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/companies/Model/companies_model.dart';
import 'package:happiness_club/modules/companies/Screens/companyDetailsScreen.dart';

class CompanyCard extends StatelessWidget {
  CompaniesModelData modelData;
  CompanyCard({required this.modelData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>CompanyDetailsScreen(companyId: modelData.id.toString(),)));
      },
      child: Container(
        height: 50,
        width: 65,
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
                imageUrl: modelData.logo ?? Constants.ALT_IMAGE,
                errorWidget: (context,a,s){
                  return CachedNetworkImage(imageUrl: Constants.NOT_FOUND_IMAGE_URL,);
                },
              )
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: AutoSizeText(
                '${modelData.title}',
                style: FontStyles.PoppinsStyle(18, Colors.black,
                    fontWeight: FontWeight.w600),
                minFontSize: 8,

              ),
            )
          ]),
        ),
      ),
    );
  }
}

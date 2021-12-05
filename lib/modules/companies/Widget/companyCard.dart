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
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>CompanyDetailsScreen()));
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
              child: Container(
                height: 76,
                width: 76,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1,1),
                        color: Colors.black26,
                        blurRadius: 5

                      )
                    ],
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          modelData.logo ?? Constants.ALT_IMAGE
                        ), fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: AutoSizeText(
                '${modelData.title}',
                style: FontStyle.PoppinsStyle(18, Colors.black,
                    fontWeight: FontWeight.w600),
                minFontSize: 12,

              ),
            )
          ]),
        ),
      ),
    );
  }
}

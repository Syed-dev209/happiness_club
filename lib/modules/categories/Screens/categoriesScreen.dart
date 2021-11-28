import 'package:flutter/material.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/categories/Widget/categoriesCard.dart';
import 'package:happiness_club/modules/categories/model/offers_category_model.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          CustomAppBar(
            title: "Categories",
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "200 Categories",
            style: FontStyle.PoppinsStyle(15, Colors.black,
                fontWeight: FontWeight.w400),
          ),
          Expanded(
              child: Consumer<CategoriesOfferProvider>(
                builder: (context,data,_) {
                  return  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: List.generate(data.modelData!.data!.length, (i) {
                      return CategoriesCard(modelData: data.modelData!.data![i]!,);
                    }),
                  );
                },
              )


          )
        ],
      ),
    );
  }
}

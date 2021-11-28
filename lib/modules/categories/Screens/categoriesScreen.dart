import 'package:flutter/material.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/categories/Widget/categoriesCard.dart';
import 'package:happiness_club/modules/categories/Widget/category_card_shimmer.dart';
import 'package:happiness_club/modules/categories/controller/categoriesController.dart';
import 'package:happiness_club/modules/categories/model/offers_category_model.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  onRefreshCalled()async{
    Provider.of<CategoriesOfferProvider>(context,listen: false).clearProvider();
    await getOfferCategories(context);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
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
          Expanded(
            child: Consumer<CategoriesOfferProvider>(
              builder: (context,data,_){
                if(data.modelData==null){
                  return shimmerEffect();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.modelData!.data!.length} Categories",
                      style: FontStyle.PoppinsStyle(15, Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Expanded(
                        child: RefreshIndicator(
                          onRefresh: (){
                            return onRefreshCalled();
                          },
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            children: List.generate(data.modelData!.data!.length, (i) {
                              return CategoriesCard(modelData: data.modelData!.data![i]!,);
                            }),
                          ),
                        )
                    )
                  ],
                );
              },
            ),
          ),
        ],
      )
    );
  }

  shimmerEffect(){
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: List.generate(4, (i) {
        return CategoryCardShimmer();
      }),
    );
  }
}

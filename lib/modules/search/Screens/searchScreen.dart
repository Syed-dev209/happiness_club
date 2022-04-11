import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/categories/model/offers_category_model.dart';
import 'package:happiness_club/modules/offers/Screens/offers_by_category_screen.dart';
import 'package:happiness_club/modules/search/Screens/search_controller.dart';
import 'package:happiness_club/modules/search/Screens/search_result_screen.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController search = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    FocusNode focus = FocusNode();
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
            //  height: size.height*0.5,
             // width: double.maxFinite,
              child: Column(
                children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: CustomAppBar(title: LocaleKeys.search.tr()),
            ),
            SizedBox(
              height: 10,
            ),
            searchTextFeild(focus),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Consumer<CategoriesOfferProvider>(
                  builder: (context, data,_){
                    if(data.modelData==null){
                      return Center(
                        child: getLoader(),
                      );
                    }

                    return Wrap(
                      spacing: 15,
                      runSpacing: 3,
                      children: List.generate(data.modelData!.data!.length, (i) => tagsCard(
                          data.modelData!.data![i]!.categoryName!,data.modelData!.data![i]!.id.toString()))
                    );
                  },
                )
              ),
            ),

                ],
              ),
            ),

            Container(
              height: 15,
              width: double.maxFinite,
              color: Color(0xfff2f2f2),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(LocaleKeys.recent_searches.tr(),style: FontStyles.PoppinsStyle(19, Colors.black,fontWeight: FontWeight.bold),),
            ),
            Expanded(
              //height: size.height*04,
              //width: double.maxFinite,
              //child: recentSearches(),
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }

  tagsCard(String tag,String id) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>OffersByCategoryScreen(catId: id, catName: tag)));

      },
      child: Container(
        height: 32.5,
        padding: EdgeInsets.only(left: 10, top: 3, bottom: 3, right: 10),
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffcbcbcb), width: 1.5),
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          tag,
          style: FontStyles.PoppinsStyle(15, Colors.black),
        ),
      ),
    );
  }

  recentSearches() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView.separated(
          itemBuilder: (context, i) {
            return TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Lorem",
                hintStyle: FontStyles.PoppinsStyle(16, Colors.black.withOpacity(0.6),fontWeight: FontWeight.w600),
                prefixIcon: Image.asset(Images.SEARCH_ICON),
                suffixIcon: Icon(Icons.close)
              ),
            );
          },
          separatorBuilder: (context, i) => SizedBox(
                height: 10,
              ),
          itemCount: 10),
    );
  }

  searchTextFeild(FocusNode focus) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: TextFormField(
                controller: search,
                focusNode: focus,
                decoration: InputDecoration(
                    // contentPadding: EdgeInsets.symmetric(horizontal: 100),
                    fillColor: Color(0xfff2f2f2),
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    // Container(
                    //   width: 20,
                    //   child: SvgPicture.asset(
                    //     Images.SEARCH_ICON,
                    //   ),
                    // ),
                    // prefixIconConstraints: BoxConstraints(
                    //     maxHeight: 25,
                    //     maxWidth: 25,
                    //     minHeight: 25,
                    //     minWidth: 25),
                    hintText: "Search",
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Expanded(
              child: !loading? GestureDetector(
                onTap: () async{
                  focus.unfocus();
                  setState(() {
                    loading = true;
                  });
                  searchUserInput(context,search.text).then((value) {
                    setState(() {
                      loading = false;
                    });
                    if(value!=null){
                      Navigator.push(context, CupertinoPageRoute(builder: (_)=>SearchResultsScreen(modelData: value)));
                    }
                  });
                },
                child: SvgPicture.asset(
                  Images.SEARCH_ACTIVE,
                  // height: 20,
                  // width: 20,
                ),
              ):getLoader(),
            )
          ],
        ),
      ),
    );
  }
}

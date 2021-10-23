import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/widgets/customAppBar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    FocusNode focus = FocusNode();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: CustomAppBar(title: "Search"),
          ),
          SizedBox(
            height: 10,
          ),
          searchTextFeild(focus),
          SizedBox(
            height: 12,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Wrap(
                spacing: 15,
                runSpacing: 3,
                children: [
                  tagsCard("Automotive"),
                  tagsCard("Education"),
                  tagsCard("Family"),
                  tagsCard("Health"),
                  tagsCard("Online Shopping"),
                  tagsCard("Residential"),
                  tagsCard("Resturant"),
                ],
              ),
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
            child: Text("Recent Searches",style: FontStyle.PoppinsStyle(19, Colors.black,fontWeight: FontWeight.bold),),
          ),
          Expanded(flex: 2, child: recentSearches())
        ],
      ),
    );
  }

  tagsCard(String tag) {
    return Container(
      height: 32.5,
      padding: EdgeInsets.only(left: 10, top: 3, bottom: 3, right: 10),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffcbcbcb), width: 1.5),
          borderRadius: BorderRadius.circular(12)),
      child: Text(
        tag,
        style: FontStyle.PoppinsStyle(15, Colors.black),
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
                hintStyle: FontStyle.PoppinsStyle(16, Colors.black.withOpacity(0.6),fontWeight: FontWeight.w600),
                prefixIcon: Image.asset(Images.SEARCH_ICON),
                suffixIcon: Icon(Icons.close)
              ),
            );
          },
          separatorBuilder: (context, i) => SizedBox(
                height: 10,
              ),
          itemCount: 5),
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
              child: GestureDetector(
                onTap: () {
                  focus.unfocus();
                },
                child: SvgPicture.asset(
                  Images.FILTER_ICON,
                  // height: 20,
                  // width: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

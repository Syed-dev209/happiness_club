import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          CustomAppBar(title: "Search"),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    focusNode: focus,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 100),
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
                      print('filter');
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
          )
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/categories/Widget/categoriesCard.dart';
import 'package:happiness_club/modules/categories/model/offers_category_model.dart';
import 'package:happiness_club/modules/home/Model/offers_slider_model.dart';
import 'package:happiness_club/modules/home/widgets/dealCard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imgList = [
    Images.DISCOUNT_OFFER,
    Images.DISCOUNT_OFFER,
    Images.DISCOUNT_OFFER,
    Images.DISCOUNT_OFFER,
    Images.DISCOUNT_OFFER,
    Images.DISCOUNT_OFFER,
  ];
  int currentPos = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height + 300,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(),
              SizedBox(
                height: 25,
              ),
              creditCard(), ///credit card
              SizedBox(
                height: 20,
              ),
              discountSlider(), ///slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: FontStyle.PoppinsStyle(14, Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "View All",
                    style: FontStyle.PoppinsStyle(
                        12, Color(ColorCodes.GOLDEN_COLOR),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Consumer<CategoriesOfferProvider>(
                  builder: (context,data,_){
                return SizedBox( ///categories
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return CategoriesCard(modelData: data.modelData!.data![i]!,);
                      },
                      separatorBuilder: (context, i) => SizedBox(
                        width: 10,
                      ),
                      itemCount:data.modelData!.data!.length),
                );
              }),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 260,
                //flex: 2,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return DealCard(
                        width: 230,
                        smallBox: false,
                      );
                    },
                    separatorBuilder: (context, i) => SizedBox(
                          width: 10,
                        ),
                    itemCount: 10),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Deals",
                    style: FontStyle.PoppinsStyle(14, Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "View All",
                    style: FontStyle.PoppinsStyle(
                        12, Color(ColorCodes.GOLDEN_COLOR),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 220,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return DealCard(
                        width: 161,
                        smallBox: true,
                      );
                    },
                    separatorBuilder: (context, i) => SizedBox(
                          width: 10,
                        ),
                    itemCount: 10),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Deals",
                    style: FontStyle.PoppinsStyle(14, Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "View All",
                    style: FontStyle.PoppinsStyle(
                        12, Color(ColorCodes.GOLDEN_COLOR),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 220,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return DealCard(
                        width: 161,
                        smallBox: true,
                      );
                    },
                    separatorBuilder: (context, i) => SizedBox(
                          width: 10,
                        ),
                    itemCount: 10),
              )
            ],
          ),
        ),
      ),
    );
  }

  discountSlider() {
    return Consumer<OffersSliderProvider>(
      builder: (context,data,_){
        return Container(
            height: 230,
            child: Column(
              children: [
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: data.modelData!.data!.length,
                    options: CarouselOptions(
                        aspectRatio: 2.5,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        onPageChanged: (index, val) {
                          //print("Index $index");
                          setState(() {
                            currentPos = index;
                          });
                        }),
                    itemBuilder: (context, index, h) {
                      return sliderImageContainer(data.modelData!.data![index]!.imageFilename!);
                    },
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(data.modelData!.data!.length, (index) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPos == index
                              ? Color(ColorCodes.GOLDEN_COLOR)
                              : Color(ColorCodes.LITE_GOLDEN_COLOR),
                        ),
                      );
                    }))
              ],
            ));
      },
    );


  }

  Widget sliderImageContainer(String image) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: CachedNetworkImageProvider(image), fit: BoxFit.cover)),
    );
  }

  appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 30,
          width: 20,
          child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: SvgPicture.asset(Images.DRAWER_ICON)),
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 45,
            width: 45,
            child: Image.asset(
              Images.LOGO,
            ),
          ),
        ),
        Expanded(
          child: Text("Sign Up/Login",
              style: FontStyle.PoppinsStyle(11, Color(ColorCodes.GOLDEN_COLOR),
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  creditCard() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          Images.CREDIT_CARD,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

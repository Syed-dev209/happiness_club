import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/offers/Controller/offers_controller.dart';
import 'package:happiness_club/modules/offers/Models/offer_revies_model.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

class OffersReview extends StatefulWidget {
  String offerId;
  OffersReview({required this.offerId});

  @override
  _OffersReviewState createState() => _OffersReviewState();
}

class _OffersReviewState extends State<OffersReview> with AutomaticKeepAliveClientMixin{
  bool keepAlive = false;
  TextEditingController reviewController = TextEditingController();
  StreamController<OfferReviesModel?>? offersReviewStream;

  loadOfferReviews()async{
    //print(widget.offerId);
    getOfferReviews(offerId: widget.offerId).then((value) {
      if(value!=null){
        offersReviewStream!.add(value);
        return value;
      }
      else{
        offersReviewStream!.add(null);
        return null;
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offersReviewStream = StreamController<OfferReviesModel>();
    loadOfferReviews();
    keepAlive= true;
    updateKeepAlive();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<OfferReviesModel?>(
          stream: offersReviewStream!.stream,
            builder: (context,snapshot){
              if(!snapshot.hasData || snapshot.hasError || snapshot.connectionState == ConnectionState.waiting){
                return getLoader();
              }
              if(snapshot.data==null){
                return Center(
                  child: Image.asset(Images.NO_REVIEW),
                );
              }
              List<Widget> offerCard=[];
              for(var i in snapshot.data!.data!) {
                offerCard.add(reviewCard(i!));
              }
              return offerCard.length<=0?
              Center(
                child: Image.asset(Images.NO_REVIEW,height: 100,),
              )
                  :Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "${offerCard.length} Reviews",
                    style: FontStyles.PoppinsStyle(17, Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh:()async{
                        loadOfferReviews();
                      },
                      child: ListView.separated(
                          itemBuilder: (context, i) {
                            return offerCard[i];
                          },
                          separatorBuilder: (context, i) => SizedBox(
                            height: 10,
                          ),
                          itemCount:offerCard.length),
                    ),
                  ),
                ],
              );
            }
            ),

        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                height: 55,
                width: double.maxFinite,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      reviewPopup();
                    },
                    child: Text(
                      "Add a review",
                      style: FontStyles.PoppinsStyle(16, Colors.white,
                          fontWeight: FontWeight.w600),
                    ))),
          ),
        )
      ],
    );
  }

  reviewCard(OfferReviesModelData data) {
    String rating = data.ratingStars.toString();
    DateTime createdAt = DateTime.parse(data.createdAt!);
    int days = createdAt.difference(DateTime.now()).inDays;
    return Container(
      height: 120,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 23,
              backgroundImage: CachedNetworkImageProvider(Constants.NOT_FOUND_IMAGE_URL),
            ),
            title: Text(
              "${data.fullName}",
              style: FontStyles.PoppinsStyle(14, Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            subtitle: RatingBar.builder(
              ignoreGestures: true,
              itemSize: 20,
              initialRating: double.parse(rating),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Color(ColorCodes.STAR_COLOR),
                size: 10,
              ),
              onRatingUpdate: (val) {},
            ),
            trailing: Text(
              "$days days ago",
              style: FontStyles.PoppinsStyle(12, Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 82),
            child: Text(
              "${data.feedbacks}",
              style: FontStyles.PoppinsStyle(12, Colors.black.withOpacity(0.5)),
            ),
          )
        ],
      ),
    );
  }

  reviewPopup() {
    double rating = 0;
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              content: Container(
                height: 250,
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add a review',
                          style: FontStyles.PoppinsStyle(17, Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black.withOpacity(0.6),
                            child: Icon(Icons.close,color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Rate",
                      style: FontStyles.PoppinsStyle(
                          14, Colors.black.withOpacity(0.5)),
                    ),
                    SizedBox(height: 5,),
                    RatingBar.builder(
                      itemSize: 20,
                      initialRating: 1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Color(ColorCodes.STAR_COLOR),
                        size: 10,
                      ),
                      onRatingUpdate: (val) {
                        rating = val;
                      },
                    ),
                     SizedBox(height: 5,),
                    Text(
                      "Your review",
                      style: FontStyles.PoppinsStyle(
                          14, Colors.black.withOpacity(0.5)),
                    ),
                     SizedBox(height: 5,),
                    TextFormField(
                      controller: reviewController,
                    ),
                     SizedBox(height: 20,),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: double.maxFinite,
                        child: ElevatedButton (
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          onPressed: () {
                            final userCheck = Provider.of<UserModelProvider>(context,listen: false).loggedIn;
                            if(userCheck) {
                              postAReview(context, widget.offerId,
                                  reviewController.text, rating).then((value) {
                                Navigator.pop(context);
                              });
                            }
                            else{
                              Navigator.pop(context);
                              showToast(context, "You must Log in to post a review.");
                            }
                          },
                        child: Text("Submit review")
                        ),
                      )
                      )
                  ],
                ),
              ),
            ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => keepAlive;
}

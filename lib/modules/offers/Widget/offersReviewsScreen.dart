import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';

class OffersReview extends StatefulWidget {
  const OffersReview({Key? key}) : super(key: key);

  @override
  _OffersReviewState createState() => _OffersReviewState();
}

class _OffersReviewState extends State<OffersReview> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              "506 Rweviews",
              style: FontStyle.PoppinsStyle(17, Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, i) {
                    return reviewCard();
                  },
                  separatorBuilder: (context, i) => SizedBox(
                        height: 10,
                      ),
                  itemCount: 10),
            ),
          ],
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
                      style: FontStyle.PoppinsStyle(16, Colors.white,
                          fontWeight: FontWeight.w600),
                    ))),
          ),
        )
      ],
    );
  }

  reviewCard() {
    return Container(
      height: 120,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 23,
            ),
            title: Text(
              "Peter Parker",
              style: FontStyle.PoppinsStyle(18, Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: RatingBar.builder(
              itemSize: 20,
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Color(ColorCodes.STAR_COLOR),
                size: 10,
              ),
              onRatingUpdate: (val) {},
            ),
            trailing: Text(
              "2 days ago",
              style: FontStyle.PoppinsStyle(15, Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut .",
              style: FontStyle.PoppinsStyle(14, Colors.black.withOpacity(0.5)),
            ),
          )
        ],
      ),
    );
  }

  reviewPopup() {
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
                          style: FontStyle.PoppinsStyle(17, Colors.black,
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
                      style: FontStyle.PoppinsStyle(
                          14, Colors.black.withOpacity(0.5)),
                    ),
                    SizedBox(height: 5,),
                    RatingBar.builder(
                      itemSize: 20,
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Color(ColorCodes.STAR_COLOR),
                        size: 10,
                      ),
                      onRatingUpdate: (val) {},
                    ),
                     SizedBox(height: 5,),
                    Text(
                      "Your review",
                      style: FontStyle.PoppinsStyle(
                          14, Colors.black.withOpacity(0.5)),
                    ),
                     SizedBox(height: 5,),
                    TextFormField(),
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
                          onPressed: () {}, 
                        child: Text("Submit review")
                        ),
                      )
                      )
                  ],
                ),
              ),
            ));
  }
}

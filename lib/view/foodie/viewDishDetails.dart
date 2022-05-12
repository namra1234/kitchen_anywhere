import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../../model/dishModel.dart';

class ViewInDeatils extends StatefulWidget {
  // DishModel dish_;

  const ViewInDeatils({Key? key,}) : super(key: key);

  @override
  State<ViewInDeatils> createState() => _ViewInDeatilsState();
}

class _ViewInDeatilsState extends State<ViewInDeatils> {
  late double _rating;
  double _initialRating = 4.0;
  String titleImage_ = "assets/images/fastfood.png";
  String lblFoodTitle = "Sandwich";
  double foodPrice = 120.0;
  String lblFoodDescription = "A food with a sharp taste. Often used to refer to tart or sour foods as well.";
  bool isLoading = false;
  int qtyNumber = 1;
  bool isFavorite = true;

  @override
  void initState() {
    super.initState();
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TitleImage(),
          const SizedBox(height: 5),
          BodyPart(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Ratings(),
              NumberPicker(),
            ],
          ),
          bottomPart(),
        ],
      ),
    );
  }

  Widget TitleImage() {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset(titleImage_,
            height: MediaQuery.of(context).size.height * .45,
          ),
          Positioned(
            child: FloatingActionButton(
                elevation: 3,
                child: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.pink : Colors.grey,
                  size: 35.0,
                  semanticLabel: 'Text',
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  //---------------------------------------------------
                      setState(() {
                        isFavorite = !isFavorite;
                      });

                }),
            bottom: 0,
            right: 20,
          ),

        ],
      ),
    );
  }

  Widget BodyPart() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lblFoodTitle,
                        style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: HexColor("005555")),
                      ),
                      Text(
                        '\$$foodPrice',
                        style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: HexColor("8E3200")),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  description(),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: HexColor('dcdde2'),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget description() {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.list_alt_outlined),
          title: Text(
            lblFoodDescription,
            textAlign: TextAlign.justify,
            style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),
          ),
        )
      ],
    ));
  }

  Widget Ratings() {
    return RatingBar.builder(
      glowColor: Colors.white,
      initialRating: _initialRating,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
          default:
            return Container();
        }
      },
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
          print("Rating : $rating");
        });
      },
      updateOnDrag: true,
    );
  }

  Widget NumberPicker() {
    return RaisedButton(onPressed: () => {
    showPickerNumber(context, 20)
    },
    child: Text("Qty: $qtyNumber",style: TextStyle(color: Colors.white),),
      color: HexColor("006778"),
      elevation: 2,
      hoverElevation: 4,
      hoverColor: HexColor("243D25"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
    );
  }

  Widget bottomPart() {
    return Container(
      height: 70,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                print("Add to cart");
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: HexColor("446A46"),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        '+ Add to Cart',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
          // SizedBox(width: 70),
        ],
      ),
    );
  }

  showPickerNumber(BuildContext context, int pendingLimit) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
              begin: 0,
              end: pendingLimit,
            initValue: qtyNumber
              ),
        ]),
        hideHeader: true,
        title: Text("Please Select Qty"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          // print(picker.getSelectedValues());
          print(picker.selecteds.first);
          setState(() {
            qtyNumber = picker.selecteds.first;
          });

        }).showDialog(context);
  }
}

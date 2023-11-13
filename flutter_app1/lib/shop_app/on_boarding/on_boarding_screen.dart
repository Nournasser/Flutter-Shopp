import 'package:flutter/material.dart';
import 'package:flutter_app1/shop_app/login/login_screen.dart';
import 'package:flutter_app1/shop_app/network/sharedprefrunce/shared_prefrunce.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body});
}
class OnBoardingScreen extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() => _OnBoardingScreen();

}

class _OnBoardingScreen extends State<OnBoardingScreen>
{
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/123.jpg',
      body: 'On Board 1 Body',
      title: 'On Board 1 Title',
    ),
    BoardingModel(
      image: 'assets/images/12345.jpg',
      body: 'On Board 2 Body',
      title: 'On Board 2 Title',
    ),
    BoardingModel(
      image: 'assets/images/1234.jpg',
      body: 'On Board 3 Body',
      title: 'On Board 3 Title',
    ),
  ];
  var boardingController = PageController();

  bool  isLast = false;

  void submit()
  {
    CashHelper.saveDate(key : 'onBoarding', value : true).then((value) {
      if(value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: submit,
            child: Text(
                'Skip'),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if(index == boarding.length - 1)
                  {
                    setState(()
                    {
                      isLast = true;
                    });
                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardingController,
                itemBuilder: (context, index) => BuildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardingController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ), count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      submit();
                    }
                    else
                    {
                      boardingController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child:  Icon(
                    Icons.arrow_forward_ios,
                  ),)
              ],
            ),
          ],
        ),
      ),
    ) ;
  }

  // ignore: non_constant_identifier_names
  Widget BuildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage(model.image),)),
      SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style:  TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style:  TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
    ],
  );
}

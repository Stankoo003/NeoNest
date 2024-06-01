
import 'package:flutter/material.dart';
import 'package:smarthome/Constants.dart';


class ResponsiveLayout extends StatelessWidget{
  const ResponsiveLayout({
    Key? key,
    this.homeView,
    this.desktopView,
  }) : super(key: key);
  final Widget? homeView;
  final Widget? desktopView;




  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimens) {
        if (dimens.maxWidth <= mobileWidth) {
          //Should return error when there is not mobile/desktop view
          return homeView ?? Text("Mobile view");
        } else {
          return desktopView ?? Text("Desktop view");
        }
    });



  }



}
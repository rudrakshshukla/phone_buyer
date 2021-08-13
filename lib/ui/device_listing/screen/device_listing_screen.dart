import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_buyer/base/di/locator.dart';
import 'package:phone_buyer/base/navigation/navigation_utils.dart';
import 'package:phone_buyer/ui/device_listing/controller/device_listing_controller.dart';
import 'package:phone_buyer/utils/const/color_utils.dart';
import 'package:phone_buyer/utils/const/font_size_utils.dart';
import 'package:phone_buyer/utils/localization/localization.dart';
class DeviceListingScreen extends StatefulWidget {

  @override
  _DeviceListingScreenState createState() => _DeviceListingScreenState();
}

class _DeviceListingScreenState extends State<DeviceListingScreen> {

  @override
  Widget build(BuildContext context) {
    getScreenSize(context);

    return GetBuilder<DeviceListingController>(

        builder: (deviceController){
          return DefaultTabController(
            length: deviceController.tabs.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text(Localization.of(context).appName),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          child: Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: screenSize.height/3,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: screenSize.height/15,

                                    child: Center(child: Text(Localization.of(context).short,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      locator<NavigationUtils>().pop(context);
                                      Get.find<DeviceListingController>().sortByPrice(false);
                                    },
                                    child: Container(
                                      height: screenSize.height/15,
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey),
                                          top: BorderSide(color: Colors.grey),
                                        )
                                      ),

                                      child: Center(child: Text(Localization.of(context).priceLowToHigh)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      locator<NavigationUtils>().pop(context);
                                      Get.find<DeviceListingController>().sortByPrice(true);

                                    },
                                    child: Container(
                                      height: screenSize.height/15,
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(color: Colors.grey),
                                            top: BorderSide(color: Colors.grey),
                                          )
                                      ),
                                      child: Center(child: Text(Localization.of(context).priceHighToLow)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Get.find<DeviceListingController>().sortByRating();
                                      locator<NavigationUtils>().pop(context);

                                    },
                                    child: Container(
                                      height: screenSize.height/15,
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(color: Colors.grey),
                                            top: BorderSide(color: Colors.grey),
                                          )
                                      ),
                                      child: Center(child: Text(Localization.of(context).deviceRating)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      locator<NavigationUtils>().pop(context);
                                      Get.find<DeviceListingController>().cleanFilter();

                                    },
                                    child: Container(
                                      height: screenSize.height/15,
                                      color: primaryColor,

                                      child: Center(child: Text(Localization.of(context).clear)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: deviceController.isFilterApply.value?Icon(Icons.filter_alt_rounded):Icon(Icons.filter_alt_outlined),
                    ),
                  )
                ],
                centerTitle: true,
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.phone_android), ),
                    Tab(icon: Icon(Icons.favorite)),
                  ],
                ),
              ),
              body: TabBarView(
                children:deviceController.tabs
              ),
            ),
          );

    });



  }
}

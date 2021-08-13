import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:phone_buyer/base/di/locator.dart';
import 'package:phone_buyer/base/navigation/navigation_utils.dart';
import 'package:phone_buyer/ui/device_details/model/res/device_model.dart';
import 'package:phone_buyer/ui/device_listing/controller/device_listing_controller.dart';
import 'package:phone_buyer/utils/const/font_size_utils.dart';
import 'package:phone_buyer/utils/const/navigation_param.dart';
import 'package:phone_buyer/utils/localization/localization.dart';
import 'package:shimmer/shimmer.dart';
class FavDevices extends StatefulWidget {

  @override
  _FavDevicesState createState() => _FavDevicesState();
}

class _FavDevicesState extends State<FavDevices> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<DeviceListingController>().getAllFavDevices();


  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceListingController>(
      builder: (deviceController){
        return deviceController.isFavDeviceLoading.value?
        Container(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: ListView.builder(
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 64.0,
                      height: 64.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 12.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 12.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 10.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              itemCount: 6,
            ),
          ),
        ):deviceController.resFavDeviceListing.value.devices.length==0?Container(
          child: Center(
           child: Text(Localization.of(context).noDeviceFound)
          ),
        ):
        Container(
          child: ListView.builder(
            itemCount: deviceController.resFavDeviceListing.value.devices.length,
            itemBuilder: (context,index){
              return Dismissible(
                direction: DismissDirection.startToEnd,
                resizeDuration: Duration(milliseconds: 200),
                key: ObjectKey( deviceController.resFavDeviceListing.value.devices[index].id),
                onDismissed: (direction) {
                  deviceController.removeDeviceFromFav( deviceController.resFavDeviceListing.value.devices[index].id,context);
                },
                background: Container(
                  padding: EdgeInsets.only(left: 28.0),
                  alignment: AlignmentDirectional.centerStart,
                  color: Colors.red,
                  child: Icon(Icons.delete_forever, color: Colors.white,),
                ),
                child: InkWell(
                  onTap: (){
                    DeviceModel deviceModel=DeviceModel(
                        deviceName: deviceController.resFavDeviceListing.value.devices[index].name,
                        deviceDesciption: deviceController.resFavDeviceListing.value.devices[index].description,
                        deviceId: deviceController.resFavDeviceListing.value.devices[index].id,
                        devicePrice: deviceController.resFavDeviceListing.value.devices[index].price,
                        deviceRating: deviceController.resFavDeviceListing.value.devices[index].rating,
                        isDeviceIsFav: true);
                    locator<NavigationUtils>().push(context, routeDeviceDetails,arguments: {"deviceModel":deviceModel});
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Material(
                      elevation: 8,
                      color: Colors.white,
                      borderRadius:  BorderRadius.all(
                          Radius.circular(8.0)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(8.0)
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 0,top: 12,bottom: 12),
                                height: 128,
                                width: 92,
                                child:CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:deviceController.resFavDeviceListing.value.devices[index].thumbImageURL,
                                )),
                            SizedBox(width: 16,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(deviceController.resFavDeviceListing.value.devices[index].name.trim(),style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                ),),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Text(Localization.of(context).devicePrice+" : ",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),),
                                    Text("\$"+deviceController.resFavDeviceListing.value.devices[index].price.toString(),style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),),

                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Text(Localization.of(context).brandName+" : ",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),),
                                    Text(deviceController.resFavDeviceListing.value.devices[index].brand,style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),),

                                  ],
                                ),
                                SizedBox(height: 8,),
                                Container(
                                  width: screenSize.width/1.6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(Localization.of(context).deviceRating+" : ",style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),),
                                          Text(deviceController.resFavDeviceListing.value.devices[index].rating.toString(),style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold
                                          ),),

                                        ],
                                      ),

                                    ],
                                  ),
                                )

                              ],
                            )


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phone_buyer/base/di/locator.dart';
import 'package:phone_buyer/base/sqlservice/database_helper.dart';
import 'package:phone_buyer/ui/device_listing/model/res/res_add_fav_device.dart';
import 'package:phone_buyer/ui/device_listing/model/res/res_device_listing.dart';
import 'package:phone_buyer/ui/device_listing/repo/device_listing_repo.dart';
import 'package:phone_buyer/ui/device_listing/screen/all_devices.dart';
import 'package:phone_buyer/ui/device_listing/screen/fav_devices.dart';
import 'package:phone_buyer/utils/progress_dialog.dart';

class DeviceListingController extends GetxController{

  //Storing all data which getting from api
  var resDeviceListing=ResDeviceListing().obs;
  var isLoading=false.obs;
  var olderResDeviceListing=ResDeviceListing();

  //Storing All the fav device
  var resFavDeviceListing=FavDeviceModel().obs;
  var oldResFavDeviceListing=FavDeviceModel();
  var isFavDeviceLoading=false.obs;


  //checking filter apply
  var isFilterApply=false.obs;



  var tabs=[
    AllDevices(),
    FavDevices()
  ];


  //getAllDevices from api
  getDeviceList()
  {
    isLoading(true);
    locator<DeviceListingRepo>().getAllDevices().then((value) {
      resDeviceListing.value.devices=[];
      value.devices.forEach((element) async {

        var isExistsInFav =await DatabaseHelper.instance.queryMobileData(element.id);
        if(isExistsInFav.length>0)
          {
            value.devices[value.devices.indexOf(element)].isFavProduct=true;
          }else{
          value.devices[value.devices.indexOf(element)].isFavProduct=false;

        }

        update();
      });
      olderResDeviceListing=value;

      resDeviceListing(value);
      isLoading(false);

      update();
    });
    update();

  }

  //add Device into fav list
  markDeviceAsFav(DeviceData deviceData,int index,BuildContext context)
  {
    ProgressDialogUtils.showProgressDialog(context);
    resDeviceListing.value.devices[index].isFavProduct=true;
    olderResDeviceListing.devices[index].isFavProduct=true;

    update();

    locator<DeviceListingRepo>().insertData(deviceData);
    ProgressDialogUtils.dismissProgressDialog();


  }


  //remove Device into fav list
  removeDeviceFromFav(String id,BuildContext context)
  {
    ProgressDialogUtils.showProgressDialog(context);

    resFavDeviceListing.value.devices.removeWhere((element) => element.id == id);
    update();
    olderResDeviceListing.devices[ olderResDeviceListing.devices.indexWhere((element) => element.id==id)].isFavProduct=false;

    resDeviceListing.value.devices[ resDeviceListing.value.devices.indexWhere((element) => element.id==id)].isFavProduct=false;
    update();
    locator<DeviceListingRepo>().removeData(id);

    ProgressDialogUtils.dismissProgressDialog();


  }

  //get Devices from fav list
  getAllFavDevices()
  {
    isFavDeviceLoading(true);
    locator<DeviceListingRepo>().getAllFavDevices().then((value) {
      resFavDeviceListing.value.devices=[];

      oldResFavDeviceListing=value;
      resFavDeviceListing(value);
      isFavDeviceLoading(false);

      update();
    });
    update();
  }

  //sort by price
  sortByPrice(bool isDeciding){
    isFilterApply(true);

    resDeviceListing.value.devices.sort((a, b) => a.price.compareTo(b.price));
    if(resFavDeviceListing.value.devices !=null)
      {
        resFavDeviceListing.value.devices.sort((a, b) => a.price.compareTo(b.price));

      }

    if(isDeciding)
      {
        resDeviceListing.value.devices=resDeviceListing.value.devices.reversed.toList();
        if(resFavDeviceListing.value.devices  !=null)
        {
          resFavDeviceListing.value.devices=resFavDeviceListing.value.devices.reversed.toList();
        }

      }
    update();

  }

  //sort by rating
  sortByRating(){
    isFilterApply(true);

    resDeviceListing.value.devices.sort((a, b) => a.rating.compareTo(b.rating));
    resDeviceListing.value.devices=resDeviceListing.value.devices.reversed.toList();
    if(resFavDeviceListing.value.devices !=null)
      {
        resFavDeviceListing.value.devices.sort((a, b) => a.rating.compareTo(b.rating));
        resFavDeviceListing.value.devices=resFavDeviceListing.value.devices.reversed.toList();

      }


    update();
  }

  //clean all filter
  cleanFilter(){
    isFilterApply(false);
   resDeviceListing.value=olderResDeviceListing;
   resFavDeviceListing.value=oldResFavDeviceListing;
  }



}
import 'package:get/get.dart';
import 'package:phone_buyer/base/di/locator.dart';
import 'package:phone_buyer/ui/device_details/model/res/res_device_images_model.dart';
import 'package:phone_buyer/ui/device_details/repo/device_details_repo.dart';

class DeviceDetailsController extends GetxController{

  var isLoading=false.obs;
  var resDeviceImages=ResDeviceImages().obs;


  getDeviceImages(String id)
  {
    isLoading(true);
    locator<DeviceDetailRepo>().getDeviceImages(id).then((value) {
      resDeviceImages.value.deviceImages=[];

      resDeviceImages(value);
      isLoading(false);
      update();
    });
    update();

  }
}
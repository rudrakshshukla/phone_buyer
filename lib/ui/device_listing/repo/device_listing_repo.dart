import 'package:dio/dio.dart';
import 'package:phone_buyer/base/api/api_manager.dart';
import 'package:phone_buyer/base/api/res_base_model.dart';
import 'package:phone_buyer/base/sqlservice/database_helper.dart';
import 'package:phone_buyer/ui/device_listing/model/res/res_add_fav_device.dart';
import 'package:phone_buyer/ui/device_listing/model/res/res_device_listing.dart';
import 'package:phone_buyer/utils/const/api_endpoint.dart';

class DeviceListingRepo{
  Future<ResDeviceListing> getAllDevices() async {
    try {
      final response = await ApiService().get(
        apiDeviceList,
      );
      return ResDeviceListing.fromJson(response.data);
    } on DioError catch (error) {
      throw ResBaseModel.fromJson(error.response.data);
    }
  }

  Future<FavDeviceModel> getAllFavDevices() async{
    var data=await DatabaseHelper.instance.queryAllRows();
    return FavDeviceModel.fromJson(data);

  }

   insertData(DeviceData deviceData) async{
    DatabaseHelper.instance.insert(deviceData.toJson());

  }

   removeData(String id) async{
    DatabaseHelper.instance.deleteRow(id);

  }
}
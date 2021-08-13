
import 'package:get_it/get_it.dart';
import 'package:phone_buyer/ui/device_details/repo/device_details_repo.dart';
import 'package:phone_buyer/ui/device_listing/repo/device_listing_repo.dart';
import "../api/api_manager.dart";
import '../navigation/navigation_utils.dart';
//init instance fot di
GetIt locator = GetIt.instance;


Future<void> setupLocator() async {
  //register all class here which you want to inject

  //for navigation
  locator.registerSingleton<NavigationUtils>(NavigationUtils());
  locator.registerSingleton<ApiService>(ApiService());



  //repo
  locator.registerSingleton<DeviceListingRepo>(DeviceListingRepo());
  locator.registerSingleton<DeviceDetailRepo>(DeviceDetailRepo());






}

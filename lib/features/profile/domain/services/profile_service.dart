import 'dart:io';
import 'package:karingo_seller/common/basewidgets/custom_snackbar_widget.dart';
import 'package:karingo_seller/features/profile/domain/models/profile_body.dart';
import 'package:karingo_seller/data/model/response/base/api_response.dart';
import 'package:karingo_seller/features/profile/domain/models/profile_info.dart';
import 'package:karingo_seller/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:karingo_seller/features/profile/domain/services/profice_service_interface.dart';
import 'package:karingo_seller/helper/api_checker.dart';
import 'package:karingo_seller/main.dart';

class ProfileService implements ProfileServiceInterface {
  final ProfileRepositoryInterface profileRepoInterface;
  ProfileService({required this.profileRepoInterface});

  @override
  Future deleteUserAccount() async {
    ApiResponse apiResponse = await profileRepoInterface.deleteUserAccount();
    if (apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String? message = map['message'];
      showCustomSnackBarWidget(message, Get.context!,
          isToaster: true, isError: false);
      return apiResponse;
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  @override
  Future getSellerInfo() {
    return profileRepoInterface.getSellerInfo();
  }

  @override
  Future updateProfile(ProfileInfoModel userInfoModel, ProfileBody seller,
      File? file, String token, String password) {
    return profileRepoInterface.updateProfile(
        userInfoModel, seller, file, token, password);
  }
}

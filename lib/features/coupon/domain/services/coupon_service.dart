import 'package:karingo_seller/common/basewidgets/custom_snackbar_widget.dart';
import 'package:karingo_seller/data/model/response/base/api_response.dart';
import 'package:karingo_seller/features/coupon/domain/models/coupon_model.dart';
import 'package:karingo_seller/features/coupon/domain/repositories/coupon_repository_interface.dart';
import 'package:karingo_seller/features/coupon/domain/services/coupon_service_interface.dart';
import 'package:karingo_seller/helper/api_checker.dart';
import 'package:karingo_seller/localization/language_constrants.dart';
import 'package:karingo_seller/main.dart';

class CouponService implements CouponServiceInterface {
  CouponRepositoryInterface couponRepoInterface;
  CouponService({required this.couponRepoInterface});

  @override
  Future addNewCoupon(Coupons coupons, {bool update = false}) {
    return couponRepoInterface.add(coupons, update: update);
  }

  @override
  Future deleteCoupon(int? id) async {
    ApiResponse apiResponse = await couponRepoInterface.delete(id!);
    if (apiResponse.response!.statusCode == 200) {
      showCustomSnackBarWidget(
          getTranslated('coupon_deleted_successfully', Get.context!),
          Get.context!,
          isError: false);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  @override
  Future getCouponCustomerList(String search) {
    return couponRepoInterface.getCouponCustomerList(search);
  }

  @override
  Future getCouponList(int offset) async {
    return await couponRepoInterface.getList(offset: offset);
  }

  @override
  Future updateCouponStatus(int? id, int status) {
    return couponRepoInterface.updateCouponStatus(id, status);
  }
}

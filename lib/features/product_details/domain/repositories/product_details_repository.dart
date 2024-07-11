import 'package:karingo_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:karingo_seller/data/datasource/remote/exception/api_error_handler.dart';
import 'package:karingo_seller/data/model/response/base/api_response.dart';
import 'package:karingo_seller/features/product_details/domain/repositories/product_details_repository_interface.dart';
import 'package:karingo_seller/utill/app_constants.dart';

class ProductDetailsRepository implements ProductDetailsRepositoryInterface {
  final DioClient? dioClient;
  ProductDetailsRepository({required this.dioClient});

  @override
  Future<ApiResponse> getProductDetails(int? productId) async {
    try {
      final response = await dioClient!.get(
        '${AppConstants.productDetails}$productId',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> productStatusOnOff(int? productId, int status) async {
    try {
      final response = await dioClient!.post(AppConstants.productStatusOnOff,
          data: {"id": productId, "status": status, "_method": "put"});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
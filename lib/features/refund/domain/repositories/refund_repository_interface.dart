import 'package:karingo_seller/data/model/response/base/api_response.dart';
import 'package:karingo_seller/interface/repository_interface.dart';

abstract class RefundRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> getRefundReqDetails(int? orderDetailsId);
  Future<ApiResponse> refundStatus(int? refundId, String status, String note);
  Future<ApiResponse> getRefundStatusList(String type);
}

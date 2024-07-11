import 'package:karingo_seller/data/model/response/base/api_response.dart';
import 'package:karingo_seller/interface/repository_interface.dart';

abstract class BarcodeRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> barCodeDownLoad(int? id, int quantity);
}

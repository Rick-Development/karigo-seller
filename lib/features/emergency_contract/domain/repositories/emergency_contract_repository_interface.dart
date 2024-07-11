import 'package:karingo_seller/data/model/response/base/api_response.dart';
import 'package:karingo_seller/interface/repository_interface.dart';

abstract class EmergencyContractRepositoryInterface
    implements RepositoryInterface {
  Future<ApiResponse> addNewEmergencyContact(String name, String phone, int? id,
      {bool isUpdate = false});
  Future<ApiResponse> statusOnOffEmergencyContact(int? id, int status);
}

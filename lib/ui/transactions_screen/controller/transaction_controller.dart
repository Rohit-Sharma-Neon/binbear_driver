import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../backend/api_end_points.dart';
import '../../../backend/base_api_service.dart';
import '../../../utils/base_functions.dart';
import '../model/transactions_response.dart';


class TransactionController extends GetxController{
  // List<String> options = <String>['Monthly Total Compensation', 'Two', 'Three', 'Four'];
  List<String> options = <String>['Monthly Total Compensation'];
  String? dropdownValue ="Monthly Total Compensation";
  final now = DateTime.now();
  RxBool isTransactionLoading = false.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  RxList<BookingData>? transactionData = <BookingData>[].obs;
  RxInt? totalPayment = 0.obs;


  getTransactionHistory() async {
    Map<String, dynamic> params = {
      'filter':'',
    };
    try {
      await BaseApiService().post(apiEndPoint: ApiEndPoints().transactionHistory,data: params).then((value){
        refreshController.refreshCompleted();
        if (value?.statusCode ==  200) {
          TransactionResponse response = TransactionResponse.fromJson(value?.data);
          if (response.success??false) {
            transactionData?.value = response.data?.bookingData??[];
            totalPayment?.value= response.data?.totalPayment??0;
          }else{
            showSnackBar(subtitle: response.message??"");
          }
        }else{
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      refreshController.refreshCompleted();
    }
  }
}
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:binbeardriver/ui/transactions_screen/model/transactions_response.dart';


class TransactionController extends GetxController{
  List<String> options = <String>['January','February','March','April','May','June','July','August','September','October','November','December'];
  String? dropdownValue ;
  final now = DateTime.now();
  RxBool isTransactionLoading = false.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  RxList<BookingData>? transactionData = <BookingData>[].obs;
  RxString? totalPayment = "0".obs;


  getTransactionHistory() async {
    Map<String, dynamic> params = {
      'filter': dropdownValue != null ? options.indexOf(dropdownValue??'') :'',
    };
    try {
      await BaseApiService().post(apiEndPoint: ApiEndPoints().transactionHistory,data: params).then((value){
        refreshController.refreshCompleted();
        if (value?.statusCode ==  200) {
          TransactionResponse response = TransactionResponse.fromJson(value?.data);
          if (response.success??false) {
            transactionData?.value = response.data?.bookingData??[];
            if(response.data?.totalPayment != null) {
              totalPayment?.value = response.data?.totalPayment?.toString()??"0";
            }
          }else{
            showSnackBar(message: response.message??"");///TODO
          }
        }else{
          showSnackBar(message: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      refreshController.refreshCompleted();
    }

  }
}
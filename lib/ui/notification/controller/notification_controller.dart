import 'package:binbeardriver/backend/api_end_points.dart';
import 'package:binbeardriver/backend/base_api_service.dart';
import 'package:binbeardriver/backend/base_responses/base_success_response.dart';
import 'package:binbeardriver/ui/notification/model/notification_response.dart';
import 'package:binbeardriver/utils/base_functions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationController extends GetxController{
  RxBool isNotificationLoading = false.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  RxList<NotificationListData>? list = <NotificationListData>[].obs;
  final now = DateTime.now();

  @override
  void onInit() {
    getNotificationsList();
    super.onInit();
  }

  getNotificationsList() async {
    list?.value = [];
    isNotificationLoading.value = true;
    try {
      await BaseApiService().get(apiEndPoint: ApiEndPoints().notificationList, showLoader: false).then((value){
        refreshController.refreshCompleted();
        if (value?.statusCode ==  200) {
          NotificationListResponse response = NotificationListResponse.fromJson(value?.data);
          if (response.success??false) {
            list?.value = response.data??[];
          }else{
            showSnackBar(subtitle: response.message??"");
          }
        }else{
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
        isNotificationLoading.value = false;
      });
    } on Exception catch (e) {
      isNotificationLoading.value = false;
      refreshController.refreshCompleted();
    }
  }

  markAllAsReadApi() {
    Map<String, String> data = {
      "is_read": "1",
    };
    try {
      BaseApiService().post(apiEndPoint: ApiEndPoints().markAllAsRead, data: data).then((value){
        if (value?.statusCode ==  200) {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.success??false) {
            list?.forEach((element) {
              element.isRead = 1;
            });
            list?.refresh();
          }else{
            showSnackBar(subtitle: response.message??"");
          }
        }else{
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  String getDate(date) {
    final difference = now.difference(date);

    final formatter = DateFormat('yMd');
    final formattedDate = formatter.format(date);

    final timeAgo = _timeAgo(difference);
    print('$formattedDate, $timeAgo');
    return timeAgo;
  }

  String _timeAgo(Duration duration) {
    if (duration.inDays >= 365) {
      final years = (duration.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (duration.inDays >= 30) {
      final months = (duration.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (duration.inDays >= 1) {
      return '${duration.inDays} ${duration.inDays == 1 ? 'day' : 'days'} ago';
    } else if (duration.inHours >= 1) {
      return '${duration.inHours} ${duration.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (duration.inMinutes >= 1) {
      return '${duration.inMinutes} ${duration.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }
}
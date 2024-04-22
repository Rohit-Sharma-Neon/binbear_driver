class ApiEndPoints {
  /// Debug Server: https://v1.checkprojectstatus.com/binbear/api/

  final String baseUrl = 'https://v1.checkprojectstatus.com/binbear/api/';

  /// OnBoarding EndPoints
  final String signUpEndPoint = "register";
  final String verifyOtp = "otp/verify";
  final String aboutUs = "aboutus";
  final String termsAndConditions = "terms_and_conditions";
  final String privacyPolicies = "privacy/policies";
  final String helpSupport = "faq";
  final String introductory = "videos";
  final String login = "login";
  final String contactUs = "contact_us";
  final String enableNotifications = "usernotify";
  final String changePassword = "change-password";
  final String getUserProfile = "getuserprofile";
  final String editUserProfile = "edituserprofile";
  final String getHomeData = "home/screen";
  final String myBookings = "bookings/data";
  final String bookingsDetails = "bookings/detail";
  final String notificationList = "notificationlist";
  final String markAllAsRead = "allmarkasread";
  final String bookingDetail = "booking_detail";
  final String giveBookingRating = "addrating";
  final String addAddress = "addaddress";
  final String couponList = "couponlist";
  final String addressList = "addresslist";
  final String setDefaultAddress = "defaultaddressset";
  final String bookingCreate = "bookingcreate";
  final String transactionHistory = "transactionhistory";
  final String driverList = "binbear/list";
  final String editDriver = "edit/binbear";
  final String driverDelete = "delete/binbear";
  final String addDriver = "create/beanbear";
  final String providerBookingAction = "bookings/action";
  final String providerAvailablity = "available";
  final String bookingAction = "driver/actions";
  final String assignBooking = "assign/booking";
  final String driverHomeData = "driver/home/screen";
  final String updateDriverStatus = "driver/statusupdate";
  final String socketUrl = "https://v1.checkprojectstatus.com:2363";
  final String forgotPassword = "forgotPassword";
  final String resetPassword = "reset_password";
  final String fileUpload = "fileUpload";
  final String driverLocationUpdate = "driver/location/update";
}

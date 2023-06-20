class WebService {
  static const String _baseUrl =
      "http://103.15.67.180/developer_7/star_gate/RestApi/";
  static String baseUrl = _baseUrl;
  static Auth auth = Auth();
  static Basic basic = Basic();
}

class Auth {
  static const String _auth = WebService._baseUrl;
  String login = "${_auth}login";
  String forgetPassword = "${_auth}forgotPassword";
  String verifyOtp = "${_auth}verifyOtp";
  String resetPassword = "${_auth}resetPassword";
  String getProfile = "${WebService._baseUrl}user/profile";
  String updateProfile = "${WebService.baseUrl}driverUpdateProfile";
}

class Basic {
  static const String _basic = WebService._baseUrl;
  String getContent = "${_basic}informationContent";
  String todayRides = "${_basic}todayDriverRides";
  String myRides = "${_basic}previousDriverRides";
  String rideDetail = "${_basic}rideDetails";
  String pickStart = "${_basic}pickStartRide";
  String pickVerifyOtp = "${_basic}pickPickedOtpVerify";
  String dropStart = "${_basic}dropStartRideOtpVerify";
  String dropDropped = "${_basic}dropDroppedRide";
  String endRide = "${_basic}endRide";
  String contactUs = "${_basic}contactUs";
}

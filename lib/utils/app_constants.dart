class AppConstants {
  // might need to add a forward slash at the end of the base url
  // for emulated android: 10.0.2.2
  // for emulated iOS and everything else: 127.0.0.1 or localhost
  // for physical android devices use IPv4 address with port num
  static const String BASE_URL = "http://10.0.2.2:8080";
  static const String GET_TASKS = "/gettasks";
  static const String POST_TASK = "/create";
  static const String GET_TASK = "/gettask/";
  static const String UPDATE_TASK = "/update/";
  static const String DELETE_TASK = "/delete/";
}

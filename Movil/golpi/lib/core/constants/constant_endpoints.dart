class ConstantEndpoints {
  static String baseUrl = '192.168.0.27:8092';
  //static String baseUrl = 'golpipruebas.up.railway.app';
  static String login = '/authentication/login';
  static String createUser = '/user/create';
  static String sendOtpMobileNumber = '/otp/send-mobilenumber';
  static String sendOtpEmail = '/otp/send-email';
  static String validateOtp = '/otp/validate';
  static String validateOtpEmail = '/otp/validate-email';
  static String changePassword = '/user/change-password';
  static String getUserById = '/user/get-by-id';
  static String getUserByMobileNumber = '/user/get-by-mobile-number';
  static String getAllZones = '/zone/get-all';
  static String getAllPositionPlayer = '/position-player/get-all';
  static String getAllDominantFoot = '/dominant-foot/get-all';
  static String createPlayerProfile = '/player-profile/create';
  static String createTeam = '/team/create';
  static String getTeamByUserId = '/team/get-by-user-id';
  static String addUserTeam = '/team/add-user-team';

  static List<String> get blackList => [
        ConstantEndpoints.login,
        ConstantEndpoints.createUser,
        ConstantEndpoints.sendOtpMobileNumber,
        ConstantEndpoints.sendOtpEmail,
        ConstantEndpoints.validateOtp,
        ConstantEndpoints.validateOtpEmail,
        ConstantEndpoints.changePassword,
      ];
}

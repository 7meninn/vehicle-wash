abstract class AuthRepository {
  Future<bool> requestOtp(String mobileNumber);
  Future<Map<String, dynamic>> verifyOtp(String mobileNumber, String otp);
}

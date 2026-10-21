 
class loginmodel {
  String? accessToken;
  String? refreshToken;

  loginmodel({this.accessToken, this.refreshToken});

  loginmodel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  
}
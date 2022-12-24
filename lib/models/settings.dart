class Settings {
  String accessCode = '';
  String url = '';
  String login = '';
  String password = '';

  Settings(this.accessCode, this.url, this.password, this.login);

  Map<String, dynamic> toJson() {
    return {'accessCode': accessCode, 'url': url, 'login': login, 'password': password};
  }

  Settings.fromJson(Map<String, dynamic> json) {
    accessCode = json['accessCode'];
    url = json['url'];
    login = json['login'];
    password = json['password'];
  }
}

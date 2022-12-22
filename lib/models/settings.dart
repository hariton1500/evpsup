class Settings {
  String accessCode = '';
  String url = '';

  Settings(this.accessCode);

  Map<String, dynamic> toJson() {
    return {'accessCode': accessCode, 'url': url};
  }

  Settings.fromJson(Map<String, dynamic> json) {
    accessCode = json['accessCode'];
    url = json['url'];
  }
}

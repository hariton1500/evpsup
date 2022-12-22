class Settings {
  String accessCode = '';

  Settings(this.accessCode);

  Map<String, dynamic> toJson() {
    return {'accessCode': accessCode};
  }

  Settings.fromJson(Map<String, dynamic> json) {
    accessCode = json['accessCode'];
  }
}

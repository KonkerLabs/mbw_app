class Log {
  String _line;
  String _car;
  int _ts;

  Log.fromJson(Map<String, dynamic> data) {
    _line = data['line'];
    _car = data['car'];
    _ts = data['ts'];
  }

}

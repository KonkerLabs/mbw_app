class Car {
  String id;
  String name;
  bool active;
  String line;

  Car({this.id, this.name, this.active, this.line});

  factory Car.fromJson(Map<String, dynamic> data) {
    return Car(name:data['name'], id:data['_id'], active:data['active'], line:data['line']);
  }

  String toString() => '(name:$name, id:$id, active:$active, line:$line)';
}

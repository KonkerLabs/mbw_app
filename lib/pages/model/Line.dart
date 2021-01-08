import './Car.dart';

class Line {
  String name;
  String color;
  List<Car> _cars;
  List<Map<String, dynamic>> stops;

  List<Car> getCars() => _cars;

  Line({this.name, this.color, this.stops});

  int getNumberOfCars() {
    return _cars?.length ?? 0;
  }

  factory Line.fromJson(Map<String, dynamic> data) {
    print(data);
    return Line(name:data["name"], color:data['color'], stops:data['stops'].cast<Map<String, dynamic>>());
  }

  void addCar(Car c) {
    if (_cars == null) _cars = new List<Car>();
    _cars.add(c);
  }

  List<String> get buses {
    var x = _cars?.map((car) {return car.name;})?.toList() ?? [];
    return x; 
  }

  String toString() {
    return '(name:$name, color:$color)';
  }
}

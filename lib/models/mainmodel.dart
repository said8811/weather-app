class Main {
  double temp;

  Main({required this.temp});

  factory Main.fromJson(Map<String, dynamic> jsondata) {
    return Main(temp: jsondata['temp']);
  }
}

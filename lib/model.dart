
class Tour {
  String name;
  int price;
  int distance;
  int temperature;

  Tour({this.distance, this.name, this.price, this.temperature});
  static List<Tour> tours = [
    Tour(price: 945, temperature: 9, distance: 15, name: 'Lac Blanc'),
    Tour(price: 250, temperature: 29, distance: 65, name: 'Andaman Islands'),
    Tour(price: 465, temperature: 14, distance: 42, name: 'Machu Picchu'),
    Tour(price: 70, temperature: 17, distance: 45, name: 'Great Wall of China'),
    Tour(price: 55, temperature: 30, distance: 100, name: 'Serengeti National Park'),
  ];
}

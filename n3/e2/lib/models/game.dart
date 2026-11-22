class Game {
  final int? id;
  final String name;
  final String category;
  final String description;
  final String status;

  const Game({
    this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'status': status,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'] as int?,
      name: map['name'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
    );
  }
}

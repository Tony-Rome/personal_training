class ExerciseDTO {
  String? id;
  String? name;
  String? mode;
  String? description;

  @override
  toString() {
    return '{name: $name, mode: $mode, description: $description}';
  }
}
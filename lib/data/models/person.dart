class Person {
  final String? id;

  Person({this.id});

  Person.fromFirebase(String uid) : id = uid;
}

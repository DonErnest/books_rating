class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});
}

var scienceFiction = Genre(id: 1, name: "Научная фантастика");
var compScience = Genre(id: 2, name: "Информатика");
var nonFiction = Genre(id: 3, name: "Нехудожественная");
var classic = Genre(id: 4, name: "Классика");
var detective = Genre(id: 5, name: "Детектив");


List<Genre> allGenres = [
  scienceFiction, compScience, nonFiction, classic, detective
];

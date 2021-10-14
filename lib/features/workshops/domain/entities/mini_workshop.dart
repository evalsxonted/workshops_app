
class MiniWorkshops{
  final List<MiniWorkshop> workshops;
  final bool available;
  MiniWorkshops({this.workshops, this.available});
}


class MiniWorkshop{
  final String id;
  final String title;
  final String image;
  MiniWorkshop({this.id, this.title, this.image});
}

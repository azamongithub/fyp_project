class Disease {
  String id;
  String name;
  String introduction;
  String type1Description;
  String type2Description;
  String gestationalDescription;
  List<String> symptoms;
  List<String> managementAndTreatment;
  List<String> thingsToAvoid;

  Disease({
    required this.id,
    required this.name,
    required this.introduction,
    required this.type1Description,
    required this.type2Description,
    required this.gestationalDescription,
    required this.symptoms,
    required this.managementAndTreatment,
    required this.thingsToAvoid,
  });
}

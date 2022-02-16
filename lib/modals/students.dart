class Student{
  String name;
  String collegeName;
  String year;
  String dept;
  List skills;
  String awards;
  String jobs;


  Student(this.name,this.collegeName,this.year,this.dept,this.skills,this.awards,this.jobs);

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        json["name"],
        json["college"],
        json["year"],
        json["dept"],
        json["badges"]["Skill"],
        json["badges"]["Awards"],
        json["badges"]["Jobs"]
    );
  }
}
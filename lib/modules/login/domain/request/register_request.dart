class RegisterRequest {
  String? fullname;
  String? fullnameAr;
  String? email;
  String? phone;
  String? dob;
  String? gender;
  String? role;
  String? timezone;
  var country;
  var city;
  var nationality;
  String? workfield;
  String? experience;
  String? nos;
  var language;
  String? achievement;
  String? idNumber;
  String? age;
  String? qualification;
  String? about;
  String? about_ar;
  String? experienceInclude;
  String? price;
  List<int>? fields;
  List<int>? languages;
  bool? isSocial;

  RegisterRequest({this.fullname,this.languages, this.fullnameAr, this.email, this.phone, this.dob, this.gender, this.role, this.timezone,
      this.country, this.city,this.about_ar, this.price,this.nationality,this.experienceInclude, this.about, this.workfield,
    this.experience, this.nos, this.qualification, this.achievement, this.idNumber, this.language, this.age, this.isSocial,
    this.fields});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullname;
    data['fullNameAr'] = fullnameAr;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = "12345678";

    if(dob!=null) data['dob'] = dob;
    if(gender!=null)  data['gender'] = gender;
    if(role!=null)  data['role'] = role;
     if(idNumber!=null) data['identity'] = idNumber;
     if(qualification!=null) data['qualification'] = qualification;
     if(country!=null) data['country'] = country;
    if(nationality!=null)  data['nationality'] = nationality;
    if(city!=null)  data['city'] = city;
    if (experience !=null)  data['experience'] = experience;
    if (fields != null) data['fields'] = fields;
    if (languages != null) data['languages'] = languages;

    return data;
  }
}

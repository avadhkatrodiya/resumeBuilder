class MyCompletedData {
  String? name;
  String? designation;
  String? city;
  String? img;
  String? email;
  String? phone;
  String? linkedInId;
  String? university;
  String? website;
  String? course;
  String? startDate;
  String? endDate;
  MyCompletedData({
    this.name,
    this.designation,
    this.city,
    this.img,
    this.email,
    this.phone,
    this.linkedInId,
    this.university,
    this.website,
    this.course,
    this.startDate,
    this.endDate,
  });

  factory MyCompletedData.fromJson(Map<String, dynamic> json) =>
      MyCompletedData(
        name: json['name'],
        designation: json['designation'],
        city: json['city'],
        img: json['img'],
        email: json['email'],
        phone: json['phone'],
        linkedInId: json['linkedInId'],
        university: json['university'],
        website: json['website'],
        course: json['course'],
        startDate: json['startDate'],
        endDate: json['endDate'],
      );

  Map toJson() => {
        'name': name,
        'designation': designation,
        'city': city,
        'img': img,
        'email': email,
        'phone': phone,
        'linkedInId': linkedInId,
        'university': university,
        'website': website,
        'course': course,
        'startDate': startDate,
        'endDate': endDate
      };
}

List<MyCompletedData> completeRoomList = [
  // MyCompletedData(
  //     iconName: '',
  //     furnitureItemList: [],
  //     assets: '',
  //     value: '',
  //     iconList: [],
  //     weight: ''),
];



class StoreData {
  int? id;
  String? addressFromMap;
  String? flatNo;
  String? addressTitle;


  StoreData(
      {this.id,
        this.addressFromMap,
        this.flatNo,
        this.addressTitle,

      });

  Map<String, dynamic> toStore() {
    var map = <String, dynamic>{
      'id': id,
      'address_title': addressTitle,
      'address_from_map': addressFromMap,
      'flat_no': flatNo,

    };

    return map;
  }

  StoreData.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    addressTitle = map['address_title'];
    addressFromMap = map['address_from_map'];
    flatNo = map['flat_no'];

  }
}

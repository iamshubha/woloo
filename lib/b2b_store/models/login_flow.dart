class StoreCustomersRes {
  Customer? customer;

  StoreCustomersRes({this.customer});

  StoreCustomersRes.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? email;
  Null? companyName;
  Null? firstName;
  Null? lastName;
  Null? phone;
  Null? metadata;
  bool? hasAccount;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Null>? addresses;

  Customer(
      {this.id,
      this.email,
      this.companyName,
      this.firstName,
      this.lastName,
      this.phone,
      this.metadata,
      this.hasAccount,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.addresses});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    companyName = json['company_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    metadata = json['metadata'];
    hasAccount = json['has_account'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // if (json['addresses'] != null) {
    //   addresses = <Null>[];
    //   json['addresses'].forEach((v) {
    //     addresses!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['company_name'] = this.companyName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['metadata'] = this.metadata;
    data['has_account'] = this.hasAccount;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.addresses != null) {
    //   data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

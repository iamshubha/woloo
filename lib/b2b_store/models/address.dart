class AddressReqBody {
  String? address1;
  String? addressName;
  String? city;
  String? firstName;
  String? lastName;
  String? phone;
  String? postalCode;
  String? province;

  AddressReqBody(
      {this.address1,
      this.addressName,
      this.city,
      this.firstName,
      this.lastName,
      this.phone,
      this.postalCode,
      this.province});

  AddressReqBody.fromJson(Map<String, dynamic> json) {
    address1 = json['address_1'];
    addressName = json['address_name'];
    city = json['city'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    postalCode = json['postal_code'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_1'] = this.address1;
    data['address_name'] = this.addressName;
    data['city'] = this.city;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['postal_code'] = this.postalCode;
    data['province'] = this.province;
    return data;
  }
}

class AddAddressResBody {
  Customer? customer;

  AddAddressResBody({this.customer});

  AddAddressResBody.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  Null? phone;
  Null? metadata;
  bool? hasAccount;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Addresses>? addresses;

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
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
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
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  String? id;
  String? addressName;
  bool? isDefaultShipping;
  bool? isDefaultBilling;
  Null? company;
  String? firstName;
  String? lastName;
  String? address1;
  Null? address2;
  String? city;
  Null? countryCode;
  String? province;
  String? postalCode;
  String? phone;
  Null? metadata;
  String? customerId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Addresses(
      {this.id,
      this.addressName,
      this.isDefaultShipping,
      this.isDefaultBilling,
      this.company,
      this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.city,
      this.countryCode,
      this.province,
      this.postalCode,
      this.phone,
      this.metadata,
      this.customerId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressName = json['address_name'];
    isDefaultShipping = json['is_default_shipping'];
    isDefaultBilling = json['is_default_billing'];
    company = json['company'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    countryCode = json['country_code'];
    province = json['province'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    metadata = json['metadata'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_name'] = this.addressName;
    data['is_default_shipping'] = this.isDefaultShipping;
    data['is_default_billing'] = this.isDefaultBilling;
    data['company'] = this.company;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['country_code'] = this.countryCode;
    data['province'] = this.province;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    data['metadata'] = this.metadata;
    data['customer_id'] = this.customerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class AddressesData {
  List<Addresses>? addresses;
  int? count;
  int? offset;
  int? limit;

  AddressesData({this.addresses, this.count, this.offset, this.limit});

  AddressesData.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
    count = json['count'];
    offset = json['offset'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    return data;
  }
}

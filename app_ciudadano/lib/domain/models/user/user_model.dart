class UserModel {
  final String name;
  final String documentID;
  final String documentType;
  final String email;
  final String address;
  final String postalCode;
  final String telephone;
  final String cellphone;
  final bool subscribed;

  UserModel(
    this.name,
    this.documentID,
    this.documentType,
    this.email,
    this.address,
    this.postalCode,
    this.telephone,
    this.cellphone,
    this.subscribed,
  );

  UserModel copyWith(
    String? name,
    String? documentID,
    String? documentType,
    String? email,
    String? address,
    String? postalCode,
    String? telephone,
    String? cellphone,
    bool? subscribed,
  ) =>
      UserModel(
        name ?? this.name,
        documentID ?? this.documentID,
        documentType ?? this.documentType,
        email ?? this.email,
        address ?? this.address,
        postalCode ?? this.postalCode,
        telephone ?? this.telephone,
        cellphone ?? this.cellphone,
        subscribed ?? this.subscribed,
      );

  static UserModel placeholder = UserModel(
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    false,
  );
}

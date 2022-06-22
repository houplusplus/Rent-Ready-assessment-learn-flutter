class Account {
  final String name; //Account Name
  String accountID; //AccountId
  String accountNumber; //Accountnumber
  String entityImage; // Default Image
  String description; //Description
  String address1; //address1_composite
  String city; //address1_city
  String country; //address1_country
  String zipCode; //address1_postalCode
  String stateOrProvince; //address1_stateorprovince
  int stateCode; //stateCode

  String email; // Email: emailaddress1
  String mainPhone; //Main Phone : telephone1
  String website; //websiteurl
  String payload;
  Account(
      this.name,
      this.accountID,
      this.accountNumber,
      this.entityImage,
      this.description,
      this.address1,
      this.city,
      this.country,
      this.zipCode,
      this.stateOrProvince,
      this.stateCode,
      this.email,
      this.mainPhone,
      this.website,
      this.payload);
}

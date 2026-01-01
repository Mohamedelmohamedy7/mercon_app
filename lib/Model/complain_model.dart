class Complaint {
  final String descriptionComplaint;
  final String email;
  final String? image;
  final String? UnitName;
  Complaint({
    required this.descriptionComplaint,
    required this.email,
    required this.image,
    required this.UnitName,
  });

  // Method to convert Complaint to JSON
  Map<String, dynamic> toJson() {
    return {
      'descriptionComplaint': descriptionComplaint,
      'email': email,
      "imageUrl":image,
      "UnitName":UnitName
    };
  }
}

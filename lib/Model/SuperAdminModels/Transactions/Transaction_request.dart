class TransactionRequest {
  int? id;
  String? description;
  String? attachmentUrl;
  int? transactionTypeID;
  int? compID;

  TransactionRequest(
      {required this.description,
        required  this.attachmentUrl,
        required  this.transactionTypeID,
        required  this.compID,this.id});

  TransactionRequest.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    attachmentUrl = json['attachmentUrl'];
    transactionTypeID = json['transactionTypeID'];
    compID = json['compID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['attachmentUrl'] = this.attachmentUrl;
    data['transactionTypeID'] = this.transactionTypeID;
    data['compID'] = this.compID;
    return data;
  }
}

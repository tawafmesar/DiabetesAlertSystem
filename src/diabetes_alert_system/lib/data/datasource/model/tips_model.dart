class tips_model {
  int? tipsId;
  String? tipsTitle;
  String? tipsContent;
  String? tipsCreate;

  tips_model({this.tipsId, this.tipsTitle, this.tipsContent, this.tipsCreate});

  tips_model.fromJson(Map<String, dynamic> json) {
    tipsId = json['tips_id'];
    tipsTitle = json['tips_title'];
    tipsContent = json['tips_content'];
    tipsCreate = json['tips_create'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tips_id'] = this.tipsId;
    data['tips_title'] = this.tipsTitle;
    data['tips_content'] = this.tipsContent;
    data['tips_create'] = this.tipsCreate;
    return data;
  }
}
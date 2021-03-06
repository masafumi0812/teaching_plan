class TrainingPlanListModel {
  //リスト表示フラグ
  bool openFlg;
  //トレーニンニング番号
  double trainingNumber;
  //トレーニング名
  String trainingName;
  //カテゴリ選択リスト
  List<int> selectedCategoryList;

  TrainingPlanListModel({
    this.openFlg: false,
    this.trainingNumber,
    this.trainingName,
    this.selectedCategoryList,
  });
}

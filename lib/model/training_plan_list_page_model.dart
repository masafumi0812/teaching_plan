import 'package:flutter/material.dart';
import 'training_plan_list_model.dart';

class TrainingPlanListPageModel extends ChangeNotifier {
  //トレーニングリスト
  var trainingList = [];
  //選択したカテゴリ番号のリスト
  List<int> selectedCategoryList = [];

  TrainingPlanListModel trainingPlanListModel;

  //トレーニングプラン一覧の取得
  Future getTrainingPlanList() async {
    notifyListeners();
  }

  //トレーニングプラン（カテゴリ）の初期化
  Future resetTrainingCategory() async {
    //カテゴリ選択の初期化
    selectedCategoryList = [];
  }

  //トレーニングプラン（カテゴリ）の設定
  Future setTrainingCategory(int categoryNumber) async {
    if (selectedCategoryList.contains(categoryNumber)) {
      selectedCategoryList.remove(categoryNumber);
    } else {
      selectedCategoryList.add(categoryNumber);
    }
  }

  //トレーニングプランの追加
  Future addTrainingPlanList(String trainingName) async {
    selectedCategoryList.sort((num1, num2) => num1 - num2);
    trainingPlanListModel = TrainingPlanListModel(
        trainingName: trainingName, selectedCategoryList: selectedCategoryList);
    trainingList.add(trainingPlanListModel);
    //カテゴリ選択の初期化
    //selectedCategoryList = [];
    notifyListeners();
  }

  //トレーニングプランの更新
  Future updTrainingPlanList(String trainingName, int index) async {
    selectedCategoryList.sort((num1, num2) => num1 - num2);
    trainingPlanListModel = TrainingPlanListModel(
        trainingName: trainingName, selectedCategoryList: selectedCategoryList);
    trainingList[index] = trainingPlanListModel;
    notifyListeners();
  }

  //トレーニングプランの削除
  Future delTrainingPlanList(int index) async {
    trainingList.removeAt(index);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:teaching_plan_app/model/training_plan_list_page_model.dart';
import 'package:teaching_plan_app/properties/common_properties.dart';

// ignore: must_be_immutable
class MultiSelectChipList extends StatefulWidget {
  TrainingPlanListPageModel model;
  String index;
  MultiSelectChipList(this.model, this.index);

  @override
  _MultiSelectChipListState createState() => _MultiSelectChipListState();
}

class _MultiSelectChipListState extends State<MultiSelectChipList> {
  final List<String> categoryNameList =
      CommonProperties.trainingCategoryNameList;

  List<String> selectedList = [];

  @override
  void initState() {
    super.initState();
    //編集時のカテゴリの初期設定
    if (widget.index != 'new') {
      widget.model.trainingList[int.parse(widget.index)].selectedCategoryList
          .forEach((selectedCategory) {
        selectedList
            .add(CommonProperties.trainingCategoryNameList[selectedCategory]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _choiceList,
    );
  }

  List<Widget> get _choiceList {
    List<Widget> choices = [];

    categoryNameList.asMap().forEach((int categoryNumber, categoryName) {
      choices.add(Container(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: ChoiceChip(
          label: Container(
            width: 90,
            child: Center(
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          selected: selectedList.contains(categoryName), // 判定
          onSelected: (_) {
            setState(() {
              selectedList.contains(categoryName)
                  ? selectedList.remove(categoryName)
                  : selectedList.add(categoryName);
              widget.model.setTrainingCategory(categoryNumber);
            });
          },
          selectedColor: Colors.black,
        ),
      ));
    });
    return choices;
  }
}

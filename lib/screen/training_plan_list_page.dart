import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:teaching_plan_app/model/training_plan_list_page_model.dart';
import 'package:teaching_plan_app/properties/common_properties.dart';
import 'common/MultiSelectChipList.dart';
import 'common/background_design.dart';

class TrainingPlanListPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<TrainingPlanListPageModel>(
      create: (_) => TrainingPlanListPageModel()..getTrainingPlanList(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff202f55),
          title: Text(
            '指導案一覧',
          ),
          elevation: 2.0,
        ),
        body: Consumer<TrainingPlanListPageModel>(
            builder: (context, model, child) {
          var _visible = false;
          if (model.trainingList.length != 0) {
            _visible = true;
          }
          return Stack(
            children: [
              Container(
                color: Color(0xfffff3b8),
              ),
              ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  width: size.width,
                  height: size.height,
                  color: Color(0xff202f55),
                ),
              ),
              Visibility(
                visible: !_visible,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Container(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(
                                "images/screen_image/training_plna_list_page_top.jpg"),
                            width: 250,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'さあ、指導案を作成してみましょう！',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _visible,
                child: ListView.builder(
                  itemCount: model.trainingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, left: 10.0, top: 10.0, bottom: 5.0),
                      //リストを横スワイプで削除する設定
                      child: Slidable(
                        actionExtentRatio: 0.2,
                        actionPane: SlidableDrawerActionPane(),
                        // 左側に表示するWidget

                        actions: <Widget>[
                          IconSlideAction(
                            caption: '共有',
                            color: Colors.blue,
                            icon: Icons.share,
                            onTap: () {
                              //TODO:共有機能の作成
                            },
                          ),
                        ],

                        // 右側に表示するWidget
                        secondaryActions: [
                          IconSlideAction(
                            caption: '編集',
                            color: Colors.green,
                            icon: Icons.border_color,
                            onTap: () async {
                              _openModalBottomSheet(
                                  context, model, index.toString());
                            },
                          ),
                          IconSlideAction(
                            caption: '削除',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              model.delTrainingPlanList(index);
                            },
                          ),
                        ],
                        //ボタン押下でリスト枠を大きくし、各カテゴリへ遷移するためのボタンを表示
                        child: ExpansionPanelList(
                          expandedHeaderPadding: const EdgeInsets.all(5.0),
                          animationDuration: Duration(seconds: 1),
                          children: [
                            ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.trainingList[index]
                                                .trainingName,
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Wrap(
                                              children:
                                                  _categoryList(index, model),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              body: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: 1, color: Color(0xff202f55)),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child:
                                                trainingButton(context, 'W-UP'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child:
                                                trainingButton(context, 'TR2'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child:
                                                trainingButton(context, 'TR1'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child:
                                                trainingButton(context, 'GAME'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              isExpanded: model.trainingList[index].openFlg,
                            ),
                          ],
                          expansionCallback: (int item, bool status) {
                            model.trainingList[index].openFlg =
                                !model.trainingList[index].openFlg;
                            model.getTrainingPlanList();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40, right: 20),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    elevation: 4,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      await model.resetTrainingCategory();
                      _openModalBottomSheet(context, model, 'new');
                    },
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  //w-up,tr1,tr2,gameボタン共通部分のWidget
  Widget trainingButton(BuildContext context, String name) {
    return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            flex: 8,
          ),
          Expanded(
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.black,
            ),
            flex: 1,
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        elevation: 2,
        primary: Colors.white,
        onPrimary: Colors.grey,
      ),
      onPressed: () async {
        await Navigator.pushNamed(
          context,
          '/TrainingPlanTopPage',
          arguments: name,
        );
      },
    );
  }

  //カテゴリ表示用Widget
  //chipは幅をとるので自前のサイズで作成
  List<Widget> _categoryList(int index, TrainingPlanListPageModel model) {
    List<Widget> resultList = [];
    //カテゴリを表示するWidgetを構築
    model.trainingList[index].selectedCategoryList.forEach(
      (selectedCategory) {
        resultList.add(
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.1,
                    blurRadius: 5.0,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 2.0, bottom: 2.0, right: 5.0, left: 5.0),
                child: Text(
                  CommonProperties.trainingCategoryNameList[selectedCategory],
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
    return resultList;
  }

  //トレーニングプラン作成入力ボトムシート表示
  void _openModalBottomSheet(
      BuildContext context, TrainingPlanListPageModel model, String index) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        //入力項目格納用変数（トレーニング名）
        String _inputTrainingName;
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //トレーニング名
              Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'トレーニング名*',
                    hintText: 'トレーニング名を入力してください',
                  ),
                  //TODO:後で長さは調整（もう少し長くして、表示をどう制御するか考える。auto_sizeは微妙かな。）
                  maxLength: 15,
                  initialValue: index == 'new'
                      ? ''
                      : model.trainingList[int.parse(index)].trainingName,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'トレーニング名は必須です。';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _inputTrainingName = value;
                  },
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              //カテゴリ選択
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      'カテゴリを選択',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              MultiSelectChipList(model, index),
              //トレーニング追加ボタン
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    child: index == 'new' ? const Text('追加') : const Text('更新'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff202f55),
                      onPrimary: Colors.white,
                    ),
                    //ボタン押下時に、バリデータを実施し、入力項目を持ちにリストを作成し、ボトムシートを削除。
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        if (index == 'new') {
                          model.addTrainingPlanList(_inputTrainingName);
                        } else {
                          model.updTrainingPlanList(
                              _inputTrainingName, int.parse(index));
                        }
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

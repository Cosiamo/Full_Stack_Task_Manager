import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:flutter_golang_yt/controllers/data_controller.dart';
import 'package:flutter_golang_yt/screens/view_task.dart';
import 'package:flutter_golang_yt/widgets/button_widget.dart';
import 'package:flutter_golang_yt/widgets/task_widget.dart';
import 'package:get/get.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({Key? key}) : super(key: key);
  // need to make the UI wait until the data is available from the server
  // because we need to use async/await, we needed to move this logic to it's own function
  // cannot use async/await in build method
  _loadData() async {
    await Get.find<DataController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    print(Get.find<DataController>().myData.length);
    _loadData();
    List myData = [
      "Try Harder",
      "Try Smarter",
    ];
    final leftEditIcon = Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      color: const Color(0xFF2e3253).withOpacity(0.5),
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
      alignment: Alignment.centerLeft,
    );
    final rightDeleteIcon = Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      color: Colors.redAccent,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
      alignment: Alignment.centerRight,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              top: 60,
            ),
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.secondaryColor,
              ),
            ),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 3.2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/header1.jpg",
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.home,
                  color: AppColors.secondaryColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.5),
                    color: Colors.black,
                  ),
                ),
                // creates a gap in between the row
                Expanded(
                  child: Container(),
                ),
                Icon(
                  Icons.calendar_month_sharp,
                  color: AppColors.secondaryColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "2",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: GetBuilder<DataController>(builder: (controller) {
              return ListView.builder(
                  itemCount: controller.myData.length,
                  itemBuilder: (context, index) {
                    // Dismissible lets you slide the widget left or right to dismiss it
                    return Dismissible(
                      background: leftEditIcon,
                      secondaryBackground: rightDeleteIcon,
                      onDismissed: (DismissDirection direction) {
                        print("Dismissed");
                      },
                      // will return a future bool, that's why we need async
                      confirmDismiss: (DismissDirection direction) async {
                        // startToEnd means left to right
                        if (direction == DismissDirection.startToEnd) {
                          showModalBottomSheet(
                              // the bottom modal color
                              backgroundColor: Colors.transparent,
                              // the color of the screen when the bottom modal is active
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (_) {
                                return Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF2e3253)
                                          .withOpacity(0.4),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // parsing the string to an int
                                            Get.off(() => ViewTask(id: int.parse(controller.myData[index]["id"].toString())));
                                          },
                                          child: ButtonWidget(
                                              backgroundcolor:
                                                  AppColors.mainColor,
                                              text: "View",
                                              textColor: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ButtonWidget(
                                            backgroundcolor:
                                                AppColors.mainColor,
                                            text: "Edit",
                                            textColor: Colors.white),
                                      ],
                                    ),
                                  ),
                                );
                              });
                          return false;
                        } else {
                          // delays the animation
                          return Future.delayed(Duration(seconds: 1),
                              () => direction == DismissDirection.endToStart);
                        }
                      },
                      key: ObjectKey(index),
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child: TaskWidget(
                          text: controller.myData[index]["task_name"],
                          color: Colors.blueGrey,
                        ),
                      ),
                    );
                  });
            }),
          )
        ],
      ),
    );
  }
}

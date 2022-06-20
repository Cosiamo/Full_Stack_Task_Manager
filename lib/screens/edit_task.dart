import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:flutter_golang_yt/controllers/data_controller.dart';
import 'package:flutter_golang_yt/routes/routes.dart';
import 'package:flutter_golang_yt/screens/all_tasks.dart';
import 'package:flutter_golang_yt/widgets/button_widget.dart';
import 'package:flutter_golang_yt/widgets/error_warning_ms.dart';
import 'package:flutter_golang_yt/widgets/textfield_widget.dart';
import 'package:get/get.dart';

class EditTask extends StatelessWidget {
  final int id;
  const EditTask({Key? key, required this.id}) : super(key: key);

  _loadSingleTask() async {
    print("Passed id is " + id.toString());
    // loads the data from data_controller.dart (Map<String, dynamic> get singleData => _singleData;)
    await Get.find<DataController>().getSingleData(id.toString());
  }

  @override
  Widget build(BuildContext context) {
    _loadSingleTask();
    // Task Name
    TextEditingController nameController = TextEditingController();
    // Task Detail
    TextEditingController detailController = TextEditingController();

    bool _dataValidation() {
      // checks if the task name is empty
      if (nameController.text.trim() == '') {
        Message.taskErrorOrWarning("Task name", "Your task name is empty.");
        return false;
        // checks if the task detail is empty
      } else if (detailController.text.trim() == '') {
        Message.taskErrorOrWarning("Task detail", "Your task detail is empty.");
        return false;
      }

      return true;
    }

    return Scaffold(
      // wrapped the Container around GetBuilder because it can get data that would be updated immediately as the widget continued to be updated
      body: GetBuilder<DataController>(builder: (controller) {
        // `??` is a null operator
        nameController.text =
            controller.singleData["task_name"] ?? "Task name not found";
        detailController.text =
            controller.singleData["task_detail"] ?? "Task detail not found";
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/addtask1.jpg",
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // showing top space
              Column(
                children: [
                  // change the height of the arrow
                  const SizedBox(
                    height: 60,
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              // showing the input fields
              Column(
                children: [
                  TextFieldWidget(
                    textController: nameController,
                    hintText: "Task name",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    textController: detailController,
                    hintText: "Task detail",
                    borderRadius: 15,
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_dataValidation()) {
                        Get.find<DataController>().updateData(
                          nameController.text.trim(),
                          detailController.text.trim(),
                          // id var in updateData
                          int.parse(controller.singleData["id"]),
                        );
                        // Get.to(
                        //   () => AllTasks(),
                        //   transition: Transition.circularReveal,
                        // );
                        Get.offNamed(RoutesClass.getAllTasksRoute());
                      }
                    },
                    child: ButtonWidget(
                      backgroundcolor: AppColors.mainColor,
                      text: "Add",
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
              // space between bottom and input fields
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
            ],
          ),
        );
      }),
    );
  }
}

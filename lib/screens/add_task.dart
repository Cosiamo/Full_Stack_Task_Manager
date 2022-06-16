import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:flutter_golang_yt/controllers/data_controller.dart';
import 'package:flutter_golang_yt/screens/all_tasks.dart';
import 'package:flutter_golang_yt/widgets/button_widget.dart';
import 'package:flutter_golang_yt/widgets/error_warning_ms.dart';
import 'package:flutter_golang_yt/widgets/textfield_widget.dart';
import 'package:get/get.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      } //else if (nameController.text.length <= 10) {
      //   Message.taskErrorOrWarning(
      //       "Task name", "Your task name is less than 10 characters.");
      // } else if (detailController.text.length <= 20) {
      //   Message.taskErrorOrWarning(
      //       "Task detail", "Your task detail is less than 20 characters.");
      // }

      return true;
    }

    return Scaffold(
      body: Container(
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
                  height: 40,
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
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
                      Get.find<DataController>().postData(
                        nameController.text.trim(),
                        detailController.text.trim(),
                      );
                      Get.to(
                        () => AllTasks(),
                        transition: Transition.circularReveal,
                      );
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
      ),
    );
  }
}

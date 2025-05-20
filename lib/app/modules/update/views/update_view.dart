import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/update_controller.dart';

class UpdateView extends GetView<UpdateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Post'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Heading Text
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Describe",
                  style: TextStyle(
                    fontSize: 20, // Slightly larger text
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                children: [
                  Obx(
                    () => ToggleButtons(
                      isSelected: [
                        controller.selectedIcon.value == '😊',
                        controller.selectedIcon.value == '😡',
                        controller.selectedIcon.value == '😐',
                      ],
                      onPressed: (int index) {
                        switch (index) {
                          case 0:
                            controller.selectedIcon.value = '😊';
                            break;
                          case 1:
                            controller.selectedIcon.value = '😡';
                            break;
                          case 2:
                            controller.selectedIcon.value = '😐';
                            break;
                        }
                      },
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('😊', style: TextStyle(fontSize: 36)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('😡', style: TextStyle(fontSize: 36)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('😐', style: TextStyle(fontSize: 36)),
                        ),
                      ],
                      color: Colors.white, 
                      selectedColor: Colors.blue, 
                      borderRadius: BorderRadius.circular(8), 
                    ),
                  ),
                ],
              ),
            ),

            // Title Input
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: controller.judul,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Title',
                  labelStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  controller.title.value = value;
                },
              ),
            ),

            // Moment Input 
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: TextFormField(
                initialValue: controller.moment,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Moments',
                  labelStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  controller.momentText.value = value;
                },
              ),
            ),

            // Save Button
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: const Text('Save Changes'),
                onPressed: () {
                  controller.updateData(controller.arg, controller.title.value,
                      controller.momentText.value);
                  print(controller.arg);
                  print(controller.title.value);
                  print(controller.momentText.value);
                  print(controller.selectedIcon.value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/button.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/profile_controller.dart';

class ProfileDetailsScreen extends StatelessWidget {
  ProfileDetailsScreen({Key? key}) : super(key: key);

  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: Constants.decoration,
        child: Scaffold(
          body: Obx(() {
            return controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => controller.getRecords(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          const CustTitle(
                            title: "Profile",
                            noBorder: true,
                          ),
                          const SizedBox(height: 20),
                          _header(),
                          _body(),
                          const SizedBox(height: 20),
                          _footer(),
                        ],
                      ),
                    ),
                  );
          }),
        ));
  }

  Widget _header() {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      initState: (_) {},
      builder: (cnt) {
        return InkWell(
          onTap: () {
            cnt.pickFile();
          },
          child: Badge(
            badgeContent: const Icon(Icons.edit),
            badgeColor: Colors.white,
            position: BadgePosition.bottomEnd(),
            child: SizedBox(
              height: 150,
              width: 150,
              child: cnt.file == null
                  ? Image.network(cnt.profile[0].avatar!)
                  : Image.file(cnt.file!),
            ),
          ),
        );
      },
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 50),
          custTextField(
            controller: controller.nameController,
            hintText: "Name",
          ),
          const SizedBox(height: 10),
          custTextField(
            controller: controller.emailController,
            hintText: "Email",
          ),
          const SizedBox(height: 10),
          custTextField(
            hintText: "Phone",
            controller: controller.phoneController,
          ),
          const SizedBox(height: 10),
          // custTextField(
          //     hintText: "Bank branch name",
          //     controller: controller.branchNameController),
          // const SizedBox(height: 10),
          // custTextField(
          //     hintText: "UPI id", controller: controller.upiIdController),
          // const SizedBox(height: 10),
          // custTextField(
          //     hintText: "Name", controller: controller.upiNameController),
          // const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _footer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          CustButton(
            isLoading: controller.isLoading.value,
            title: "Save",
            onPressed: () => controller.uploadFile(controller.file),
          ),
        ],
      ),
    );
  }

  Widget custTextField(
      {required String hintText, TextEditingController? controller}) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
        ),
      ),
    );
  }
}

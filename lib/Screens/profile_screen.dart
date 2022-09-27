import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Controller/profile_controller.dart';
import 'package:lets_earn/Model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController controller = Get.put(ProfileController());
  List<ProfileBalance> data = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        data = controller.profile;
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => controller.getRecords(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _header(),
                      const SizedBox(height: 20),
                      _body(),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Widget _header() {
    return Column(
      children: [
        SizedBox(
            height: 150, width: 150, child: Image.network(data[0].avatar!)),
        const SizedBox(height: 10),
        Text(
          data[0].name!,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        Text(
          "Account balance: ${data[0].balance}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        Text(
          "Vip expiry date: ${data[0].expiryDate}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          InkWell(
            child: const CustTitle(title: "Withdrawal now"),
            onTap: () => Get.toNamed("/WidrawScreen"),
          ),
          const SizedBox(height: 5),
          tabs(
            icon: FontAwesomeIcons.userLarge,
            title: "Personal Details",
            onTap: () => Get.toNamed("/ProfileDetailsScreen"),
          ),
          tabs(
            icon: FontAwesomeIcons.userLarge,
            title: "Bank Details",
            onTap: () => Get.toNamed("/BankDetailsScreen"),
          ),
          tabs(
            icon: FontAwesomeIcons.moneyBill,
            title: "Withdrawal Record",
            onTap: () => Get.toNamed("/WidthrawalRecordScreen"),
          ),
          tabs(
              icon: Icons.group_add,
              title: "Invite your friends",
              onTap: () => showAlertDialog(context)),
          tabs(
            icon: FontAwesomeIcons.users,
            title: "Team report",
            onTap: () => Get.toNamed("/TeamReport"),
          ),
          tabs(
              icon: FontAwesomeIcons.users,
              title: "Income & expenditure",
              onTap: () => Get.toNamed("/IncomeExpenditureScreen")),
          tabs(
            icon: FontAwesomeIcons.headset,
            title: "Help center",
            onTap: () => Get.toNamed("/HelpCentreScreen"),
          ),
          tabs(
            icon: FontAwesomeIcons.moneyBill,
            title: "Refer Rewards",
            onTap: () => Get.toNamed("/ReferRewards"),
          ),
          // tabs(icon: FontAwesomeIcons.language, title: "Language"),
          tabs(
            icon: FontAwesomeIcons.download,
            title: "Download App",
            onTap: () => _launchUrl(),
          ),
          tabs(
            icon: FontAwesomeIcons.info,
            title: "Member Ship Level And Benefits",
            onTap: () => Get.toNamed("/InfoScreen"),
          ),
          tabs(
            icon: FontAwesomeIcons.arrowRightFromBracket,
            title: "Log out",
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.clear().then((value) => Get.offAndToNamed("/SignUpScreen"));
            },
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(controller.url.string),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${controller.url.string}';
    }
  }

  Widget tabs(
      {required IconData icon, required String title, void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        iconColor: Colors.black,
        textColor: Colors.black,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(width: 2)),
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: onTap,
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget shareButton = TextButton(
      child: const Text("Share"),
      onPressed: () {
        FlutterShare.share(title: "Refferal Code", text: data[0].referralCode);
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Get.back(),
    );
    Widget continueButton = TextButton(
        child: const Text("Copy"),
        onPressed: () =>
            Clipboard.setData(ClipboardData(text: data[0].referralCode))
                .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Refferal Code coppied"))))
                .then((value) => Get.back()));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Refferal Code"),
      content: SelectableText("Your refferal code: ${data[0].referralCode}"),
      actions: [
        cancelButton,
        shareButton,
        // continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

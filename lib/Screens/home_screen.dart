import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Model/banner_model.dart';
import 'package:lets_earn/Services/remote_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String>? items;
  bool isLoading = true;

  @override
  void initState() {
    getBanner();
    super.initState();
  }

  Future getBanner() async {
    var data = await RemoteService.get(key: "banner");
    BannerModel banner = bannerModelFromJson(data);
    items = banner.banner;
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _header(),
              const SizedBox(height: 20),
              isLoading == true
                  ? const CircularProgressIndicator()
                  : _carouselSlider(),
              const SizedBox(height: 20),
              _body(),
              _footer(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 25, bottom: 50),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF335DBA), Color(0xFFD1587F)])),
            child: Column(
              children: [
                const Text(
                  "Total Earning",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                const SizedBox(height: 10),
                Text(
                  "Rs. 199.00",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Constants.primaryColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _carouselSlider() {
    return CarouselSlider(
      items: items!.map((e) {
        return Builder(builder: (context) {
          return Image.network(e);
        });
      }).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        viewportFraction: 1,
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              _button(title: "Buy now"),
              const SizedBox(width: 16),
              _button(title: "Withdraw"),
            ],
          ),
          const SizedBox(height: 10),
          _socialButton(
              title: "Youtube",
              titleColor: Colors.red,
              icon: const Icon(
                FontAwesomeIcons.youtube,
                color: Colors.red,
                size: 50,
              )),
          _socialButton(
              title: "Instagram",
              titleColor: Constants.instagram,
              icon: Icon(
                FontAwesomeIcons.instagramSquare,
                color: Constants.instagram,
                size: 50,
              )),
          _socialButton(
              title: "Facebook",
              titleColor: Constants.facebook,
              icon: Icon(
                FontAwesomeIcons.facebookSquare,
                color: Constants.facebook,
                size: 50,
              )),
          const SizedBox(height: 10),
          _inviteFriends(),
          const SizedBox(height: 20),
          isLoading == true
              ? const CircularProgressIndicator()
              : Image.network(items![0]),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _footer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Row(
              children: const [
                Text(
                  "Member Score board",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text("Congrates",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("****96547"),
                          Row(
                            children: const [
                              Text("Current level:-"),
                              Text(
                                "VIP7",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text("+4000",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              )),
                          Text("Today's earning",
                              style: TextStyle(
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _inviteFriends() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Constants.accentBlue),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  "Invite Your Friends",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding _socialButton(
      {required Widget icon, required String title, Color? titleColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: icon,
          title: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w900, color: titleColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _button(
      {required String title,
      void Function()? onPressed,
      bool isLoading = false}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Constants.yellow),
            minimumSize: MaterialStateProperty.all(const Size(0, 50))),
        child: isLoading
            ? const SizedBox(
                height: 16.0,
                width: 16.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                title,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
      ),
    );
  }
}

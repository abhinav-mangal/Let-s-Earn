import 'package:flutter/material.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Constants/constants.dart';

class InfoScreen extends StatelessWidget {
  InfoScreen({Key? key}) : super(key: key);

  List levelPrice = [
    "0",
    "499rs",
    "1199RS",
    "3999RS",
    "19999RS",
    "49999RS",
    "69999RS",
    "100000RS"
  ];
  List numOftask = ["5", "5", "10", "20", "40", "65", "80", "100"];
  List amountofMoney = [
    "5Rs",
    "5Rs",
    "6Rs",
    "10Rs",
    "20Rs",
    "30Rs",
    "35Rs",
    "40Rs"
  ];
  List daysIncome = [
    "25Rs",
    "25Rs",
    "60Rs",
    "200Rs",
    "800Rs",
    "1950Rs",
    "2800Rs",
    "4000Rs"
  ];
  List weeklyIncome = [
    "",
    "175Rs",
    "420Rs",
    "1400Rs",
    "5600Rs",
    "13650Rs",
    "19600Rs",
    "28000Rs"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 60),
            const CustTitle(
                title: "Earn Commissions For Tasks", noBorder: true),
            _body(),
            _footer(),
          ]),
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(width: 2)),
          child: const Text(
            "Member Ship Level And Benefits",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              _row("Tingkat Vip", isIterator: true),
              _row("Level Price", child: levelPrice),
              _row("Tasks", child: numOftask),
              _row("Amount", child: amountofMoney),
              _row("Days Income", child: daysIncome),
              _row("Weehly Income", child: weeklyIncome),
            ],
          ),
        )
      ],
    );
  }

  Widget _footer() {
    return Column(
      children: [
        _discription("LV1",
            "You need to recharge 499Rs, you can get 5 tasks per day,5Rs for one Task,25Rs per day,and you can get your money back in 20 days. if you do it again in the future,it will be pure profit.it can make a profit of 175Rs in one week."),
        _discription("LV2",
            "You need to recharge 1199Rs, you can get 10 tasks per day,6Rs for one Task,60Rs per day,and you can get your money back in 25 days. if you do it again in the future, it will be pure profit.it can make a profit of 420Rs in one week."),
        _discription("LV3",
            "You need to recharge 3999Rs, you can get 20 tasks per day, 10Rs for one Task 200Rs per day,and you can get your money back in 25 days. if you do it again in the future,it will be pure profit it can make a p of 1400Rs in one week."),
        _discription("LV4",
            "You need to recharge 19999Rs, you can get 40 tasks per day,20Rs for one Task,800Rs per day,and you can get your money back in 25 days. if you do it again in the future, it will be pure profit.it can make a profit of 5600Rs in one week."),
        _discription("LV5",
            "You need to recharge 49999Rs,you can get 65 tasks per day, 30Rs for one Task, 1950Rs per day, and you can get your money back in 25 days. if you do it again in the future,it will be pure profit.it can make a profit of 13650Rs in one week."),
        _discription("LV6",
            "You need to recharge 69999Rs, you can get 80 tasks per day,35Rs for one Task,2800Rs per day,and you can get your money back in 25 if you do it again in the future,it will be pure profit.it can make a of 19600Rs in one week."),
        _discription("LV7",
            "You need to recharge 100000Rs,you can get 100 tasks per day 40 Prog one Task 4000Rs per day, and you can get your money back in 25 days. if you do it again in the future, it will be pure profit it can make a profit of 28000Rs in one week."),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _discription(String title, String discription) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(discription)
      ]),
    );
  }

  Widget _row(String title, {List? child, bool isIterator = false}) {
    return Expanded(
      child: Column(
        children: [
          _box(title, isBold: true),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 8,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return isIterator ? _box("LV$index") : _box(child![index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _box(String title, {bool isBold = false}) {
    return Container(
        height: 60,
        width: 70,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(width: 2)),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: isBold
              ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)
              : null,
        ));
  }
}

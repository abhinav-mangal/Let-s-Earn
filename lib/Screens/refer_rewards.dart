import 'package:flutter/material.dart';
import 'package:lets_earn/Constants/constants.dart';

List column1 = [
  "Tingkat Vip",
  "LV1",
  "LV2",
  "LV3",
  "LV4",
  "LV5",
  "LV6",
  "LV7",
];
List column2 = [
  "Recommend Ratio of three Levels",
  "12% 5% 3%",
  "12% 5% 3%",
  "12% 5% 3%",
  "12% 5% 3%",
  "12% 5% 3%",
  "12% 5% 3%",
  "12% 5% 3%",
];
List column3 = [
  "First Level Recommendation income",
  "59.8Rs",
  "143.8Rs",
  "497.8Rs",
  "2400Rs",
  "6000Rs",
  "8400Rs",
  "12000Rs",
];
List column4 = [
  "Secondary Recommendation Income",
  "24.9Rs",
  "79.9Rs",
  "199.9RS",
  "1000Rs",
  "2500Rs",
  "3500Rs",
  "5000Rs",
];
List column5 = [
  "Third Level Recommendation Income",
  "14.9Rs",
  "35.9Rs",
  "199Rs",
  "600Rs",
  "1500Rs",
  "2100Rs",
  "3000Rs",
];

class ReferRewards extends StatelessWidget {
  const ReferRewards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border.all(width: 2)),
                        child: const Text(
                          "Refer Friends To Get Rewards",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Recommend The Tirst Charge Income Of Subordinate",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: column1.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return Table(children: [
                      TableRow(children: [
                        Column(children: [
                          Text(
                            column1[index],
                            textAlign: TextAlign.center,
                          )
                        ]),
                        Column(children: [
                          Text(
                            column2[index],
                            textAlign: TextAlign.center,
                          )
                        ]),
                        Column(children: [
                          Text(
                            column3[index],
                            textAlign: TextAlign.center,
                          )
                        ]),
                        Column(children: [
                          Text(
                            column4[index],
                            textAlign: TextAlign.center,
                          )
                        ]),
                        Column(children: [
                          Text(
                            column5[index],
                            textAlign: TextAlign.center,
                          )
                        ]),
                      ])
                    ]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _text(
    String text,
    String lv1,
    String lv2,
    String lv3,
    String lv4,
    String lv5,
    String lv6,
    String lv7,
  ) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 3)),
      child: Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            lv1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            lv2,
            textAlign: TextAlign.center,
          ),
          Text(
            lv3,
            textAlign: TextAlign.center,
          ),
          Text(
            lv4,
            textAlign: TextAlign.center,
          ),
          Text(
            lv5,
            textAlign: TextAlign.center,
          ),
          Text(
            lv6,
            textAlign: TextAlign.center,
          ),
          Text(
            lv7,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

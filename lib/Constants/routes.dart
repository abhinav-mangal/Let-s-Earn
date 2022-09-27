import 'package:get/get.dart';
import 'package:lets_earn/Screens/Investment_screen.dart';
import 'package:lets_earn/Screens/%20purchase_screen.dart';
import 'package:lets_earn/Screens/bank_details_screen.dart';
import 'package:lets_earn/Screens/help_centre_screen.dart';
import 'package:lets_earn/Screens/home_screen.dart';
import 'package:lets_earn/Screens/income_expenditure_screen.dart';
import 'package:lets_earn/Screens/info_screen.dart';
import 'package:lets_earn/Screens/membership_screen.dart';
import 'package:lets_earn/Screens/profile_detail_screen.dart';
import 'package:lets_earn/Screens/profile_screen.dart';
import 'package:lets_earn/Screens/records_screen.dart';
import 'package:lets_earn/Screens/refer_rewards.dart';
import 'package:lets_earn/Screens/task_screen.dart';
import 'package:lets_earn/Screens/team_report.dart';
import 'package:lets_earn/Screens/widraw_screen.dart';
import 'package:lets_earn/Screens/widthrawal_record_screen.dart';
import 'package:lets_earn/tab_bar_controller.dart';

import '../Screens/signin_screen.dart';
import '../Screens/signup_screen.dart';

class Routes {
  static List<GetPage<dynamic>>? pages = [
    GetPage(name: "/SignInScreen", page: () => SignInScreen()),
    GetPage(name: '/SignUpScreen', page: () => const SignUpScreen()),
    GetPage(name: '/TabBarController', page: () => const TabBarController()),
    GetPage(name: '/HomeScreen', page: () => HomeScreen()),
    GetPage(name: '/TaskScreen', page: () => TaskScreen()),
    GetPage(name: '/MemberShipScreen', page: () => MemberShipScreen()),
    GetPage(name: '/RecordsScreen', page: () => const RecordsScreen()),
    GetPage(name: '/ProfileScreen', page: () => const ProfileScreen()),
    GetPage(name: '/InvestmentScreen', page: () => InvestmentScreen()),
    GetPage(name: '/TeamReport', page: () => TeamReportScreen()),
    GetPage(name: '/PurchaseScreen', page: () => const PurchaseScreen()),
    GetPage(name: '/WidrawScreen', page: () => const WidrawScreen()),
    GetPage(name: '/HelpCentreScreen', page: () => HelpCentreScreen()),
    GetPage(
        name: '/WidthrawalRecordScreen', page: () => WidthrawalRecordScreen()),
    GetPage(name: '/BankDetailsScreen', page: () => BankDetailsScreen()),
    GetPage(
        name: '/IncomeExpenditureScreen',
        page: () => IncomeExpenditureScreen()),
    GetPage(name: '/ProfileDetailsScreen', page: () => ProfileDetailsScreen()),
    GetPage(name: '/InfoScreen', page: () => InfoScreen()),
    GetPage(name: '/ReferRewards', page: () => const ReferRewards()),
  ];
}

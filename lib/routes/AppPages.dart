import 'package:warmindo_user_ui/pages/address_page/controller/address_page_controller.dart';
import 'package:warmindo_user_ui/pages/address_page/view/address_page_view.dart';
import 'package:warmindo_user_ui/pages/cart_page/binding/cart_binding.dart';
import 'package:warmindo_user_ui/pages/cart_page/view/cart_page.dart';
import 'package:warmindo_user_ui/pages/change-password_page/binding/change_pass_binding.dart';
import 'package:warmindo_user_ui/pages/change-password_page/view/change_pass_page.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/binding/detail_menu_binding.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/view/detail_menu_page.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/edit-profile/binding/edit_profile_binding.dart';
import 'package:warmindo_user_ui/pages/edit-profile/view/edit_profile_page.dart';
import 'package:warmindo_user_ui/pages/forgot_password/binding/forgot_password_binding.dart';
import 'package:warmindo_user_ui/pages/forgot_password/view/forgot_password_page.dart';
import 'package:warmindo_user_ui/pages/guest_home_page/binding/guest_home_binding.dart';
import 'package:warmindo_user_ui/pages/guest_home_page/view/guest_home_page.dart';
import 'package:warmindo_user_ui/pages/guest_menu_page/binding/guest_menu_binding.dart';
import 'package:warmindo_user_ui/pages/guest_menu_page/view/guest_menu_page.dart';
import 'package:warmindo_user_ui/pages/guest_navigator_page/binding/guest_navigator_binding.dart';
import 'package:warmindo_user_ui/pages/guest_navigator_page/view/guest_navigator_page.dart';
import 'package:warmindo_user_ui/pages/guest_profile_page/binding/guest_profile_binding.dart';
import 'package:warmindo_user_ui/pages/guest_profile_page/view/guest_profile_page.dart';
import 'package:warmindo_user_ui/pages/history-detail_page/view/history_detail_page.dart';

import 'package:warmindo_user_ui/pages/history_page/binding/history_binding.dart';

import 'package:warmindo_user_ui/pages/history_page/view/history_page.dart';
import 'package:warmindo_user_ui/pages/home_page/binding/home_binding.dart';
import 'package:warmindo_user_ui/pages/home_page/view/home_page.dart';
import 'package:warmindo_user_ui/pages/login_page/binding/login_binding.dart';
import 'package:warmindo_user_ui/pages/login_page/view/login_page.dart';
import 'package:warmindo_user_ui/pages/menu_page/binding/menu_binding.dart';
import 'package:warmindo_user_ui/pages/menu_page/view/menu_page.dart';
import 'package:warmindo_user_ui/pages/navigator_page/view/navigator_page.dart';
import 'package:warmindo_user_ui/pages/onboard_page/binding/onboard_binding.dart';
import 'package:warmindo_user_ui/pages/onboard_page/view/onboard_page.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/binding/pembayaran_binding.dart';
import 'package:warmindo_user_ui/pages/pembayaran-page/view/pembayaran_page.dart';
import 'package:warmindo_user_ui/pages/policy_page/binding/policy_binding.dart';
import 'package:warmindo_user_ui/pages/policy_page/view/policy_page.dart';
import 'package:warmindo_user_ui/pages/profile_page/binding/profile_binding.dart';
import 'package:warmindo_user_ui/pages/profile_page/view/profile_page.dart';
import 'package:warmindo_user_ui/pages/register_page/binding/register_binding.dart';
import 'package:warmindo_user_ui/pages/register_page/view/register_page.dart';
import 'package:warmindo_user_ui/pages/splash_page/binding/splash_binding.dart';
import 'package:warmindo_user_ui/pages/splash_page/view/splash_page.dart';
import 'package:warmindo_user_ui/pages/verification_profile_page/binding/verification_profile_binding.dart';
import 'package:warmindo_user_ui/pages/verification_profile_page/view/verification_profile_Page.dart';
import 'package:warmindo_user_ui/pages/veritification_page/binding/veritification_binding.dart';
import 'package:warmindo_user_ui/pages/veritification_page/view/veritification_page.dart';

import '../common/model/history2_model.dart';
import '../pages/address_page/binding/address_page_binding.dart';



part 'AppRoutes.dart';

class AppPages {

  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;


  static final routes = [
    GetPage(
        name: _Paths.BOTTOM_NAVBAR,
        page: () => BottomNavbar(),
        bindings: [
          HomeBinding(),
          MenuPageBinding(),
          CartBinding(),
          HistoryBinding(),
          ProfileBinding(),
        ],
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.SPLASH_SCREEN,
        page: () => const SplashPage(),
        binding: SplashBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.ONBOARD_PAGE,
        page: () => OnboardPage(),
        binding: OnboardBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.PROFILE_VERIFICATION_PAGE,
        page: () => VerificationProfilePage(isEdit: Get.arguments['isEdit'],),
        binding: VeritificationProfileBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.HOME_PAGE,
        page: () => HomePage(),
        binding: HomeBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.REGISTER_PAGE,
        page: () => RegisterPage(),
        binding: RegisterBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 150)),
    GetPage(
        name: _Paths.LOGIN_PAGE,
        page: () => LoginPage(),
        binding: LoginPageBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 150)),
    GetPage(
        name: _Paths.FORGOT_PASSWORD_PAGE,
        page: () => ForgotPasswordPage(),
        binding: ForgotPasswordBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 150)),
    GetPage(
        name: _Paths.CART_PAGE,
        page: () => CartPage(),
        binding: CartBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.DETAIL_MENU_PAGE,
        page: () => DetailMenuPage(menu: Get.arguments['menu'], isGuest: Get.arguments['isGuest'],),
        binding: DETAILMENUBinding(),
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.HISTORYDETAIL_PAGE,
        page: () => HistoryDetailPage(initialOrder: Get.arguments as Order2,),
        // page: () => HistoryDetailPage(menu: Get.arguments['menu'], isGuest: Get.arguments['isGuest'],),
        binding: HistoryBinding(),
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.MENU_PAGE,
        page: () => MenuPage(),
        binding: MenuPageBinding(),
        transition: Transition.fadeIn,
        popGesture: false,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.PROFILE_PAGE,
        page: () => ProfilePage(),
        binding: ProfileBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.HISTORY_PAGE,
        page: () => HistoryPage(),
        binding: HistoryBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),


    GetPage(
        name: _Paths.POLICY_PAGE,
        page: () => const PolicyPage(),
        binding: PolicyBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.VERITIFICATION_PAGE,
        page: () => VerificationPage(isLogged: Get.arguments['isLogged'],),
        binding: VeritificationBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),

    GetPage(
        name: _Paths.EDITPROFILE_PAGE,
        page: () => EditProfileScreen(),
        binding: EditProfileBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.CHANGEPASS_PAGE,
        page: () => ChangePasswordPage(),
        binding: ChangePasswordBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.PROFILE_PAGE,
        page: () => ProfilePage(),
        binding: ProfileBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.GUEST_HOME_PAGE,
        page: () => GuestHomePage(),
        binding: GuestHomeBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.GUEST_MENU_PAGE,
        page: () => GuestMenuPage(),
        binding: GuestMenuBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.GUEST_NAVIGATOR_PAGE,
        page: () => GuestNavigatorPage(),
        binding: GuestNavigatorBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.GUEST_PROFILE_PAGE,
        page: () => const GuestProfilePage(),
        binding: GuestProfileBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.PEMBAYARAN_PAGE,
        page: () => PembayaranPage(),
        binding: PembayaranBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.ADDRESS_PAGE,
        page: () => AddressPageView(),
        binding: AddressPageBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
  ];
}

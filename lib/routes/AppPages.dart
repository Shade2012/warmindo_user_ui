import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:warmindo_user_ui/pages/cart_page/binding/cart_binding.dart';
import 'package:warmindo_user_ui/pages/cart_page/view/cart_page.dart';
import 'package:warmindo_user_ui/pages/change-password_page/binding/change_pass_binding.dart';
import 'package:warmindo_user_ui/pages/change-password_page/view/change_pass_page.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/binding/detail_menu_binding.dart';
import 'package:warmindo_user_ui/pages/detail-menu_page/view/detail_menu_page.dart';
import 'package:warmindo_user_ui/pages/edit-profile/binding/edit_profile_binding.dart';
import 'package:warmindo_user_ui/pages/edit-profile/view/edit_profile_page.dart';
import 'package:warmindo_user_ui/pages/guest_home_page/binding/guest_home_binding.dart';
import 'package:warmindo_user_ui/pages/guest_home_page/view/guest_home_page.dart';
import 'package:warmindo_user_ui/pages/guest_menu_page/binding/guest_menu_binding.dart';
import 'package:warmindo_user_ui/pages/guest_menu_page/view/guest_menu_page.dart';
import 'package:warmindo_user_ui/pages/guest_navigator_page/binding/guest_navigator_binding.dart';
import 'package:warmindo_user_ui/pages/guest_navigator_page/view/guest_navigator_page.dart';
import 'package:warmindo_user_ui/pages/guest_navigator_page/controller/guest_navigator_controller.dart';
import 'package:warmindo_user_ui/pages/guest_profile_page/binding/guest_profile_binding.dart';
import 'package:warmindo_user_ui/pages/guest_profile_page/view/guest_profile_page.dart';
import 'package:warmindo_user_ui/pages/history-detail_page/binding/history_detail_binding.dart';
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
import 'package:warmindo_user_ui/pages/policy_page/binding/policy_binding.dart';
import 'package:warmindo_user_ui/pages/policy_page/view/policy_page.dart';
import 'package:warmindo_user_ui/pages/profile_page/binding/profile_binding.dart';
import 'package:warmindo_user_ui/pages/profile_page/view/profile_page.dart';
import 'package:warmindo_user_ui/pages/register_page/binding/register_binding.dart';
import 'package:warmindo_user_ui/pages/register_page/view/register_page.dart';
import 'package:warmindo_user_ui/pages/splash_page/binding/splash_binding.dart';
import 'package:warmindo_user_ui/pages/splash_page/view/splash_page.dart';
import 'package:warmindo_user_ui/pages/veritification_page/binding/veritification_binding.dart';
import 'package:warmindo_user_ui/pages/veritification_page/view/veritification_page.dart';
import 'package:warmindo_user_ui/pages/voucher_page/binding/voucher_binding.dart';
import 'package:warmindo_user_ui/pages/voucher_page/view/voucher_page.dart';
import '../pages/guest_home_page/view/guest_home_page.dart';

part 'AppRoutes.dart';

class AppPages {
  AppPages._();


  static const INITIAL = Routes.POLICY_PAGE;


  static final routes = [
    GetPage(
        name: _Paths.BOTTOM_NAVBAR,
        page: () => BottomNavbar(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.SPLASH_SCREEN,
        page: () => SplashPage(),
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
        name: _Paths.CART_PAGE,
        page: () => CartPage(),
        binding: CartBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.MENU_PAGE,
        page: () => MenuPage(),
        binding: MenuPageBinding(),
        transition: Transition.fadeIn,
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
        name: _Paths.HISTORYDETAIL_PAGE,
        page: () => HistoryDetailPage(),
        binding: HISTORYDETAILBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.DETAILMENU_PAGE,
        page: () => DetailMenuPage(),
        binding: DETAILMENUBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.POLICY_PAGE,
        page: () => PolicyPage(),
        binding: PolicyBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.VERITIFICATION_PAGE,
        page: () => VerificationPage(),
        binding: VeritificationBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.VOUCHER_PAGE,
        page: () => VoucherPage(),
        binding: VoucherBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.EDITPROFILE_PAGE,
        page: () => EditProfile(),
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
        page: () => GuestProfilePage(),
        binding: GuestProfileBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),

  ];
}

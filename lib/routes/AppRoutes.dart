part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const HOME_PAGE = _Paths.HOME_PAGE;
  static const CART_PAGE = _Paths.CART_PAGE;
  static const PROFILE_PAGE = _Paths.PROFILE_PAGE;
  static const LOGIN_PAGE = _Paths.LOGIN_PAGE;
  static const REGISTER_PAGE = _Paths.REGISTER_PAGE;
  static const ONBOARD_PAGE = _Paths.ONBOARD_PAGE;
  static const MENU_PAGE = _Paths.MENU_PAGE;
  static const HISTORY_PAGE = _Paths.HISTORY_PAGE;
  static const CHANGEPASS_PAGE = _Paths.CHANGEPASS_PAGE;
  static const VOUCHER_PAGE = _Paths.VOUCHER_PAGE;
  static const PAYMENT_PAGE = _Paths.PAYMENT_PAGE;
  static const DETAIL_PAGE = _Paths.DETAIL_PAGE;
  static const CHECKOUT_PAGE = _Paths.CHECKOUT_PAGE;
  static const ORDER_PAGE = _Paths.ORDER_PAGE;
  static const ORDERDETAIL_PAGE = _Paths.ORDERDETAIL_PAGE;
  static const ORDERHISTORY_PAGE = _Paths.ORDERHISTORY_PAGE;
  static const ORDERHISTORYDETAIL_PAGE = _Paths.ORDERHISTORYDETAIL_PAGE;
  static const POLICY_PAGE = _Paths.POLICY_PAGE;
  static const VERITIFICATION_PAGE = _Paths.VERITIFICATION_PAGE;
  static const DETAILMENU_PAGE = _Paths.DETAILMENU_PAGE;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH_SCREEN = '/splash-screen';
  static const HOME_PAGE = '/home-page';
  static const CART_PAGE = '/cart-page';
  static const PROFILE_PAGE = '/profile-page';
  static const LOGIN_PAGE = '/login-page';
  static const REGISTER_PAGE = '/register-page';
  static const ONBOARD_PAGE = '/onboard-page';
  static const MENU_PAGE = '/menu-page';
  static const DETAILMENU_PAGE = '/detail-menu-page';
  static const HISTORY_PAGE = '/history-page';
  static const CHANGEPASS_PAGE = '/change-pass-page';
  static const VOUCHER_PAGE = '/voucher-page';
  static const PAYMENT_PAGE = '/payment-page';
  static const DETAIL_PAGE = '/detail-page';
  static const CHECKOUT_PAGE = '/checkout-page';
  static const ORDER_PAGE = '/order-page';
  static const ORDERDETAIL_PAGE = '/order-detail-page';
  static const ORDERHISTORY_PAGE = '/order-history-page';
  static const ORDERHISTORYDETAIL_PAGE = '/order-history-detail-page';
  static const POLICY_PAGE = '/policy-page';
  static const VERITIFICATION_PAGE = '/verification-page';
}
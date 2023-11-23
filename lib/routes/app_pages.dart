import 'package:get/get.dart';
import 'package:tixcash/main.dart';
import 'package:tixcash/pages/Stack/Stack_Views.dart';
import 'package:tixcash/pages/Stack/stack_Binding.dart';
import 'package:tixcash/pages/Stack_Income/Stackincome_views.dart';
import 'package:tixcash/pages/Stack_Income/stack_Binding.dart';
import 'package:tixcash/pages/account/auth_fingerprint/bindings/auth_fingerprint_binding.dart';
import 'package:tixcash/pages/account/auth_fingerprint/views/auth_fingerprint_view.dart';
import 'package:tixcash/pages/dashboard/tabs/Wallet_Premium/Premium_Binding.dart';
import 'package:tixcash/pages/dashboard/tabs/Wallet_Premium/Premium_Views.dart';
import 'package:tixcash/pages/dashboard/tabs/invite/My_Referrals/bindings/myReferral_binding.dart';
import 'package:tixcash/pages/dashboard/tabs/invite/My_Referrals/views/myReferralViews.dart';
import 'package:tixcash/pages/dashboard/tabs/invite/bindings/invite_binding.dart';
import 'package:tixcash/pages/dashboard/tabs/invite/views/invite_view.dart';
import 'package:tixcash/pages/splash/Instruction.dart';
import 'package:tixcash/pages/splash/start1.dart';
import '../pages/account/backup_words/backup_words_binding.dart';
import '../pages/account/backup_words/backup_words_view.dart';
import '../pages/account/create_account/create_account_binding.dart';
import '../pages/account/create_account/create_account_view.dart';
import '../pages/account/create_wallet/create_wallet_binding.dart';
import '../pages/account/finger_print_login/finger_print_login_binding.dart';
import '../pages/account/finger_print_login/finger_print_login_view.dart';
import '../pages/add_coin/add_coin_binding.dart';
import '../pages/add_coin/add_coin_view.dart';
import '../pages/admin/add_notification/add_notification_binding.dart';
import '../pages/admin/add_notification/add_notification_view.dart';
import '../pages/admin/add_store/add_store_binding.dart';
import '../pages/admin/add_store/add_store_view.dart';
import '../pages/admin/commission_fee/commission_fee_binding.dart';
import '../pages/admin/commission_fee/commission_fee_view.dart';
import '../pages/contact_support/contact_support_binding.dart';
import '../pages/contact_support/contact_support_view.dart';
import '../pages/dashboard/dashboard_file/dashboard_binding.dart';
import '../pages/dashboard/dashboard_file/dashboard_view.dart';
import '../pages/dashboard/scan_qr/scan_qr_binding.dart';
import '../pages/dashboard/scan_qr/scan_qr_view.dart';
import '../pages/dashboard/tabs/d_apps/d_apps_binding.dart';
import '../pages/dashboard/tabs/d_apps/d_apps_view.dart';
import '../pages/dashboard/tabs/home/home_binding.dart';
import '../pages/dashboard/tabs/home/home_view.dart';
import '../pages/dashboard/tabs/liquidity/liquidity_binding.dart';
import '../pages/dashboard/tabs/liquidity/liquidity_view.dart';
import '../pages/dashboard/tabs/send_tyv/send_tyv_binding.dart';
import '../pages/dashboard/tabs/send_tyv/send_tyv_view.dart';
import '../pages/dashboard/tabs/settings/settings_binding.dart';
import '../pages/dashboard/tabs/settings/settings_view.dart';
import '../pages/dashboard/tabs/swap/swap_binding.dart';
import '../pages/dashboard/tabs/swap/swap_view.dart';
import '../pages/dashboard/tyv_market/tyv_market_binding.dart';
import '../pages/dashboard/tyv_market/tyv_market_view.dart';
import '../pages/dashboard/tyv_scan/tyv_scan_binding.dart';
import '../pages/dashboard/tyv_scan/tyv_scan_view.dart';
import '../pages/select_coin/select_coin_binding.dart';
import '../pages/select_coin/select_coin_view.dart';
import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_view.dart';
import '../pages/swap_list/swap_list_binding.dart';
import '../pages/swap_list/swap_list_view.dart';
import '../pages/transaction_detail/transaction_detail_binding.dart';
import '../pages/transaction_detail/transaction_detail_view.dart';
import '../pages/transaction_history/transaction_history_binding.dart';
import '../pages/transaction_history/transaction_history_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.Dashboard,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.REFRAL,
      page: () => const InviteView(),
      binding: InviteBinding(),
    ),
    GetPage(
      name: Routes.START,
      page: () => Startview1(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.STACK,
      page: () => const StackViews(),
      binding: StackBinding(),
    ),
    GetPage(
      name: Routes.STACKINCOME,
      page: () => const txhincome(),
      binding: StackBinding(),
    ),
    GetPage(
      name: Routes.CREATE_WALLET,
      page: () => const CreateWalletView(),
      binding: CreateWalletBinding(),
    ),
    GetPage(
      name: Routes.CREATE_ACCOUNT,
      page: () => const CreateAccountView(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: Routes.BACKUP_WORDS,
      page: () => const BackupWordsView(),
      binding: BackupWordsBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.SCAN_QR,
      page: () => const ScanQrView(),
      binding: ScanQrBinding(),
    ),
    GetPage(
      name: Routes.FINGER_PRINT_LOGIN,
      page: () => const FingerPrintLoginView(),
      binding: FingerPrintLoginBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTION_HISTORY,
      page: () => const TransactionHistoryView(),
      binding: TransactionHistoryBinding(),
    ),
    GetPage(
      name: Routes.SEND_TYV,
      page: () => SendTyvView(),
      binding: SendTyvBinding(),
    ),
    GetPage(
      name: Routes.TYV_MARKET,
      page: () => const TyvMarketView(),
      binding: TyvMarketBinding(),
    ),
    GetPage(
      name: Routes.TYV_SCAN,
      page: () => const TyvScanView(),
      binding: TyvScanBinding(),
    ),
    GetPage(
      name: Routes.CONTACT_SUPPORT,
      page: () => const ContactSupportView(),
      binding: ContactSupportBinding(),
    ),
    GetPage(
      name: Routes.SELECT_COIN,
      page: () => const SelectCoinView(),
      binding: SelectCoinBinding(),
    ),
    GetPage(
      name: Routes.COMMISSION_FEE,
      page: () => const CommissionFeeView(),
      binding: CommissionFeeBinding(),
    ),
    GetPage(
      name: Routes.ADD_STORE,
      page: () => const AddStoreView(),
      binding: AddStoreBinding(),
    ),
    GetPage(
      name: Routes.ADD_NOTIFICATION,
      page: () => const AddNotificationView(),
      binding: AddNotificationBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTION_DETAIL,
      page: () => const TransactionDetailView(),
      binding: TransactionDetailBinding(),
    ),
    GetPage(
      name: Routes.SWAP,
      page: () => SwapView(),
      binding: SwapBinding(),
    ),
    GetPage(
      name: Routes.SWAP_LIST,
      page: () => SwapListView(),
      binding: SwapListBinding(),
    ),
    GetPage(
      name: Routes.D_APPS,
      page: () => const DAppsView(),
      binding: DAppsBinding(),
    ),
    GetPage(
      name: Routes.ADD_COIN,
      page: () => const AddCoinView(),
      binding: AddCoinBinding(),
    ),
    GetPage(
      name: Routes.LIQUIDITY,
      page: () => const LiquidityView(),
      binding: LiquidityBinding(),
    ),
    GetPage(
      name: Routes.AUTH_FINGERPRINT,
      page: () => const AuthFingerprintView(),
      binding: AuthFingerprintBinding(),
    ),
    GetPage(
      name: Routes.PREMIUM_VIEW,
      page: () => const PremiumViews(),
      binding: PremiumBinding(),
    ),
    GetPage(
      name: Routes.MYREFERRAL,
      page: () => const MyReferral(),
      binding: MyReferralBinding(),
    ),
  ];
}

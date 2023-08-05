
class UrlContainer{

  static const String baseUrl = 'https://yoururl.com/';
  static const String registrationEndPoint='api/register';
  static const String deviceTokenEndPoint='api/device-token';
  static const String loginEndPoint='api/login';
  static const String userDashboardEndPoint='user/dashboard';
  static const String forgetPasswordEndPoint='api/password/email';
  static const String passwordVerifyEndPoint='api/password/verify-code';
  static const String resetPasswordEndPoint='api/password/reset';
  static const String countryEndPoint='api/countries';
  static const String logoutEndPoint='api/logout';

  static const String languageUrl             = 'api/language/';

  static const String verify2FAUrl = 'api/verify-g2fa';

  static const String walletListEndpoint='api/wallets';
  static const String walletAddressListEndpoint='api/single/wallet/';
  static const String generateCryptoWalletAddress='api/wallet-generate/';
  static const String generateAddressEndpoint='api/wallet-list';



  static const String dashboardEndpoint = 'api/dashboard' ;

  static const String cryptoListEndpoint='api/cryptos';


  static const String publicProfileEndpoint='api/public-profile/';

  static const String transactionEndpoint='api/transactions';
  static const String marketEndPoint='api/advertisement/search?';



  static const String fiatGatewayListEndpoint='api/fiat-gateways';
  static const String adFilterEndpoint='api/ad-filter';




  static const String verifyEmailEndPoint='api/verify-email';
  static const String verifySmsEndPoint='api/verify-mobile';
  static const String resendVerifyCodeEndPoint='api/resend-verify';




  static const String depositHistoryEndPoint='api/deposit-history?page=';
  static const String depositMethodEndPoint='api/deposit/methods';
  static const String depositInsertEndPoint='api/deposit/insert';

  static const String allWithdrawHistoryEndPoint = 'api/withdraw/history?page=';

  static const String authorizationCodeEndPoint='api/authorization';
  static const String generalSettingEndPoint='api/general-setting';
  static const String privacyPolicyEndPoint='api/polices';

  static const String getProfileEndPoint='api/user-info';
  static const String updateProfileEndPoint='api/profile-setting';
  static const String profileCompleteEndPoint='api/user-data-submit';
  static const String changePasswordEndPoint='api/change-password';


  //notification
  static const String notificationEndPoint='api/notifications';
  static const String readNotificationEndPoint='api/notification-mark-read/';



  //deposit
  static const String advertisementHistoryEndPoint='api/advertisement/index';
  static const String newAdvertisementEndPoint='api/advertisement/new';
  static const String editAdvertisementEndPoint='api/advertisement/edit/';
  static const String storeAdvertisementEndPoint='api/advertisement/store';
  static const String updateAdvertisementStatusEndPoint='api/advertisement/status-update';
  static const String advertisementUpdateEndPoint ='api/advertisement/update/';
  static const String advertisementReviewEndPoint = 'api/advertisement/reviews/';


  //referral
  static const String referralCommissionEndPoint='api/referral/commissions';
  static const String referralUserEndPoint='api/refereed/users';

  //trade
  static const String tradeEndPoint='api/trade/index?page=';
  static const String newTradeResponseEndPoint='api/trade/new/';
  static const String storeTradeEndPoint='api/trade/store/';
  static const String tradeDetailsEndPoint='api/trade/details/';
  static const String storeChatEndPoint='api/trade-chat/store/';

  //review
  static const String storeReviewEndPoint = 'api/trade-review/store';

  //deposit
  static const String depositHistoryUrl='deposit/history';
  static const String depositMethodUrl='deposit/methods';
  static const String depositInsertUrl='deposit/insert';
  static const String allTransactionUrl='transactions';



  // withdraw
  static const String withdrawRequestUrl='api/withdraw-request/';
  static const String submitWithdrawRequestUrl='api/withdraw-request/confirm';
  static const String previousWithdrawUrl='api/past-withdrawals/';

  static const String kycFormUrl='api/kyc-form';
  static const String kycSubmitUrl='api/kyc-submit';

}
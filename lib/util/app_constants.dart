class AppConstants {
  static const String baseUrl = "https://desigro.languagenectar.in";
  static const String registerLoginUri = '/api/v1/auth/register';
  static const String verifyOtp = '/api/v1/auth/verify-phone';
  static const String getUserDetails = '/api/v1/customer/info';
  static const String addToCart = '/api/v1/customer/order/add-to-cart';
  static const String updateUserDetails = '/api/v1/customer/update-profile';
  static const String removeItemFromCart = '/api/v1/customer/order/remove';
  static const String resendOtp = '/api/v1/auth/resend-otp';
  static const String getBanners = '/api/v1/banners';
  static const String getCartDetails = '/api/v1/customer/order/cart';
  static const String deleteAllNotificationUri =
      '/api/v1/customer/delete-notifications';
  static const String getCategories = '/api/v1/categories';
  static const String getItems = '/api/get-product-list';
  static const String locationRequest = '/api/v1/customer/add-request';
  static const String placeOrder = '/api/v1/customer/order/place';
  static const String addDeliveryAddress = '/api/v1/customer/address/add';
  static const String getUserAddress = '/api/get-delivery-address';
  static const String getSubCategory = '/api/v1/categories/products';
  static const String getAllProduct = '/api/v1/services/all';
  static const String updateCartDetails = '/api/v1/customer/order/update';
  static const String getRegions = '/api/v1/services/zone/list';
  static const String getLocationByRegion = '/api/v1/services/zone/city';
  static const String getDeliveryAddress = '/api/v1/customer/address/list';
  static const String updateDeliveryAddress = '/api/v1/customer/address/update';
  static const String getTransactionHistory = '/api/v1/customer/wallet/history';
  static const String getOrderDetails = '/api/v1/customer/order/list';
  static const String updateVacation = '/api/v1/customer/update-vacation';
  static const String addVacation = '/api/v1/customer/add-vacation';
  static const String searchProducts = '/api/v1/services/search';
  static const String deleteAccount = '/api/v1/customer/delete';
  static const String getHubDetails = '/api/v1/config';
  static const String getProductDetails = '/api/v1/services/details/';
  static const String getCoupons = '/api/v1/coupon/list';
  static const String applyCouponCode = '/api/v1/coupon/apply';
  static const String filterSubscription =
      '/api/v1/customer/order/get-filter-subscription';
  static const String getNotification = '/api/v1/customer/notifications';
  static const String getDeliveryManDetails =
      '/api/v1/customer/get-delivery-man';
  static const String subscriptionStatus =
      '/api/v1/customer/active-subscriptions';
  static const String getVacationDetails = '/api/v1/customer/get-vacation';
  static const String deleteSubscription =
      '/api/v1/customer/order/delete-subscription';

  static const String updateSubscriptionDetails =
      '/api/v1/customer/order/update-subscription';
  static const String getSubscriptionDetails =
      '/api/v1/customer/order/get-subscription';
  static const String deleteVacationDetails =
      '/api/v1/customer/delete-vacation';
  static const String addSubscription =
      '/api/v1/customer/order/add-subscription';
  static const String checkAvailabilityUri =
      '/api/v1/customer/check-availibility';

  static const String categoryImageUrl =
      "https://desigro.languagenectar.in/storage/app/public/category/";
  static const String productImageUrl =
      "https://desigro.languagenectar.in/storage/app/public/product/";
  static const String bannerImageUrl =
      "https://desigro.languagenectar.in/storage/app/public/banner/";

  /// Shared Key
  static const String token = 'auth_token';
  static const String zoneId = 'zone_id';
  static const String mapApiKey = 'AIzaSyCC4YQogkc2PCPxzwmLwe08VUpPZlWl988';
}

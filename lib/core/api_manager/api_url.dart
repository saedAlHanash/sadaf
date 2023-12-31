class GetUrl {
  static const getHome = 'home';

  //--------------

  static const getAllCourses = 'courses';

  static const getAllLessons = 'lessons';

  static const getAllLessonsFree = 'lessons/free';

  static const getAllSeasons = 'seasons';

  static const getAllSummaries = 'summaries';

  static const getCourseProgress = 'courses/progress-user';
  static const getMe = 'auth/me';

  static const getAllNotifications = 'notifications';

  static const getSocialMedia = 'social-media';

  static const privacyPolicy = 'privacy-policy';

  static const getAnnouncements = 'announcements';

  static const favorite = 'favorites';

  static const productById = 'products';
  static const products = 'products';
  static const search = 'products/search';

  static const offers = 'products/offers';
  static const bestSeller = 'products/best-seller';
  static const setting = 'setting';

  static const orders = 'orders';

  static const categoryById = 'category';
  static const subCategoryById = 'subCategory';

  static const coupon = 'carts/redeem-coupon';

  static const flashDeals = 'products/flash-deals';

  static const categories = 'categories';
  static const banners = 'ads/banners';
  static const slider = 'ads/sliders';

  static const colors = 'colors';

  static const manufacturers = 'manufacturers';

  static const newArrivalProducts = 'products/new-arrivals';

  static const cart = 'carts';

  static const profile = 'profile';

  static var orderById = 'orders';

  static var subCategories = 'categories/sub';

  static var governors = 'governors';
}

class PostUrl {
  static const loginUrl = 'login';
  static const signup = 'register';

  static const forgetPassword = 'password/email';

  static const resetPassword = 'password/reset';

  static const closeVideo = 'lessons/close-video';

  static const insertFireBaseToken = 'auth/me/update-fcm-token';
  static const uploadFile = 'media';

  static const insertCode = 'courses/insert-code';
  static const logout = 'logout';

  static const confirmCode = 'opt-check';
  static const otpPassword = 'password/check';

  static const addFavorite = 'favorites';

  static const restPass = 'reset-password';

  static const createOrder = 'checkout/cash';

  static const resendCode = 'opt-resend';

  static const addToCart = 'carts';

  static const updateProfile = 'profile/update';

  static String increase(int id) {
    return 'carts/products/$id/quantity/increase';
  }

  static String decrease(int id) {
    return 'carts/products/$id/quantity/decrease';
  }
}

class PutUrl {
  static const updateName = 'update-name';
  static const updatePhone = 'update-phone';
  static const updateAddress = 'update-address';
}

class DeleteUrl {
  static const removeFavorite = 'favorites';

  static const removeFromCart = 'carts/products';

  static const clearCart = 'carts';
}

const additionalConst = 'api/mobile/';
const baseUrl = 'back.sadafiq.com';

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

  static const resendCode = 'send-code';

  static const slider = 'slider';

  static const favorite = 'favorites';

  static const productById = 'products';
  static const search = 'products/search';

  static const offers = 'products/offers';
  static const bestSeller = 'products/best-seller';
  static var setting = 'setting';

  static var orders = 'orders';

  static var categoryById = 'category';
  static var subCategoryById = 'subCategory';

  static var coupon ='coupon';
}

class PostUrl {
  static const loginUrl = 'login';
  static const signup = 'register';

  static const forgetPassword = 'auth/forget-password';
  static const resetPassword = 'auth/reset-password';

  static const closeVideo = 'lessons/close-video';

  static const insertFireBaseToken = 'auth/me/update-fcm-token';
  static const uploadFile = 'media';

  static const insertCode = 'courses/insert-code';
  static const logout = 'logout';

  static const confirmCode = 'verify-email';

  static const addFavorite = 'favorites';

  static const restPass = 'reset-password';

  static var createOrder = 'orders';
}

class PutUrl {
  static const updateName = 'update-name';
  static const updatePhone = 'update-phone';
  static const updateAddress = 'update-address';
}

class DeleteUrl {
  static const removeFavorite = 'favorites';
}

//https://robin-medical.com/Snail/public/api/v1
const additionalConst = 'api/v1/';
const baseUrl = 'snailstoreiq.com';

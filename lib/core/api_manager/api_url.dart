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

  static var createOrder = 'orders';

  static const resendCode = 'opt-resend';
}

class PutUrl {
  static const updateName = 'update-name';
  static const updatePhone = 'update-phone';
  static const updateAddress = 'update-address';
}

class DeleteUrl {
  static const removeFavorite = 'favorites';
}

const additionalConst = 'api/mobile/';
const baseUrl = '5.bandtech.co';

class APIS {
  //https://hpcapi.softlinks.ae //test
  //https://hpcapi.happinessclub.ae //live
  static const String BASE_URL = "https://hpcapi.happinessclub.ae/api/v1/";
  static const String SLIDER_IMAGED = BASE_URL + "offers/slider";
  static const String DASHBOARD_DATA = BASE_URL + "dashboard";
  static const String OFFER_CATEGORIES = BASE_URL + "offers/categories";
  static const String MOST_VIEWED_OFFERS = BASE_URL + "offers/most-viewed";
  static const String LATEST_OFFERS = BASE_URL + "offers/latest";
  static const String FEATURED_OFFERS = BASE_URL + "offers/featured";
  static const String NEARBY_OFFERS =
      BASE_URL + "offers/nearby-all"; // params lat lang
  static const String NEARBY_MAP_OFFERS =
      BASE_URL + "offers/nearby-map";
  static const String OFFER_DETAILS =BASE_URL+"offers/detail"; //param in link
  static const String OFFER_LOCATION =BASE_URL+"offers/locations"; //param in link
  static const String OFFER_REVIEWS =BASE_URL+"offers/reviews"; //param in link
  static const String OFFER_BY_CATEGORY =BASE_URL+"offers/category"; //param in query parameters
  static const String ABOUT = BASE_URL+"about";
  static const String PRIVACY = BASE_URL+"privacy";
  static const String TERMS = BASE_URL+"terms";
  static const String CONTACT = BASE_URL+"contact";
  static const String ALL_OFFERS = BASE_URL+"offers/all";
  static const String COMPANIES = BASE_URL+"companies";
  static const String COMPANIES_DETAIL = BASE_URL+"company-details";
  static const String CHAMPIONS = BASE_URL+"champions";
  static const String LOGIN = BASE_URL+"login";
  static const String NEWSLETTER = BASE_URL+"newsletters";
  static const String ADD_REVIEW = BASE_URL+"offers/rating";
  static const String SCAN_QR = BASE_URL+"event/scan";
  static const String FAVORITES_LIST = BASE_URL+"favorites/listing";
  static const String REMOVE_FAVORITES = BASE_URL+"favorites/remove";
  static const String ADD_TO_FAVORITES = BASE_URL+"favorites/add";
  static const String VALIDATE_QR = BASE_URL+"event/customer-info";
  static const String ADD_CUSTOMER = BASE_URL+"event/customer-add";
  static const String ADD_VIEW = BASE_URL+"offers/add-view";
  static const String HELP = BASE_URL+"help";
  static const String DIGITAL_CARD = BASE_URL+"dc";
  static const String ANNOUNCEMENTS = BASE_URL+"announcements";
  static const String ANNOUNCEMENT = BASE_URL+"announcement";
  static const String SEARCH = BASE_URL+"offers/search";
  static const String REGISTER_TOKEN = BASE_URL+"get-token";
}

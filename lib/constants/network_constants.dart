class APIS {
  static const String BASE_URL = "https://hpcapi.softlinks.ae/api/v1/";
  static const String SLIDER_IMAGED = BASE_URL + "offers/slider";
  static const String OFFER_CATEGORIES = BASE_URL + "offers/categories";
  static const String MOST_VIEWED_OFFERS = BASE_URL + "offers/most-viewed";
  static const String LATEST_OFFERS = BASE_URL + "offers/latest";
  static const String FEATURED_OFFERS = BASE_URL + "offers/featured";
  static const String NEARBY_OFFERS =
      BASE_URL + "offers/nearby-limited"; // params lat lang
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
  static const String CHAMPIONS = BASE_URL+"champions";
  static const String LOGIN = BASE_URL+"login";
  static const String NEWSLETTER = BASE_URL+"newsletters";
  static const String ADD_REVIEW = BASE_URL+"offers/rating";
  static const String SCAN_QR = BASE_URL+"event/scan";
}

import 'dart:developer';

import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/services/navigatorKey.dart';
import 'package:provider/provider.dart';

class APIS {
  //https://hpcapi.softlinks.ae //test
  //https://hpcapi.happinessclub.ae //live
  APIS() {
    int lang =
        Provider.of<UserModelProvider>(GlobalVariable.navState.currentContext!)
                .language ??
            0;
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    log(BASE_URL);
  }

  static String BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";

  static get SLIDER_IMAGED {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/slider";
  }

  static get DASHBOARD_DATA {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "dashboard";
  }

  static get OFFER_CATEGORIES {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/categories";
  }

  static get MOST_VIEWED_OFFERS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/most-viewed";
  }

  static get LATEST_OFFERS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/latest";
  }

  static get FEATURED_OFFERS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/featured";
  }

  static get NEARBY_OFFERS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/nearby-all";
  } // params lat lang

  static get NEARBY_MAP_OFFERS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/nearby-map";
  }

  static get OFFER_DETAILS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/detail";
  } //param in link

  static get OFFER_LOCATION {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/locations";
  } //param in link

  static get OFFER_REVIEWS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/reviews";
  } //param in link

  static get OFFER_BY_CATEGORY {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/category";
  } //param in query parameters

  static get ABOUT {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "about";
  }

  static get PRIVACY {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "privacy";
  }

  static get TERMS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "terms";
  }

  static get CONTACT {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "contact";
  }

  static get ALL_OFFERS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/all";
  }

  static get COMPANIES {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "companies";
  }

  static get COMPANIES_DETAIL {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "company-details";
  }

  static get CHAMPIONS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "champions";
  }

  static get LOGIN {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    //old end point 'login'
    // new end point 'validate-login'
    return BASE_URL + "validate-login";
  }

  static get VALIDATE_OTP {
       int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "validate-otp";
  }

  static get NEWSLETTER {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "newsletters";
  }

  static get ADD_REVIEW {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/rating";
  }

  static get SCAN_QR {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "event/scan";
  }

  static get FAVORITES_LIST {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "favorites/listing";
  }

  static get REMOVE_FAVORITES {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "favorites/remove";
  }

  static get ADD_TO_FAVORITES {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "favorites/add";
  }

  static get VALIDATE_QR {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "event/customer-info";
  }

  static get ADD_CUSTOMER {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "event/customer-add";
  }

  static get ADD_VIEW {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/add-view";
  }

  static get HELP {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "help";
  }

  //static const String DIGITAL_CARD = BASE_URL+"dc";
  static get DIGITAL_CARD {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "dc-both-sides";
  }

  static get ANNOUNCEMENTS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "announcements";
  }

  static get ANNOUNCEMENT {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "announcement";
  }

  static get SEARCH {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "offers/search";
  }

  static get REGISTER_TOKEN {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "get-token";
  }

  static get UAE_PASS_LOGIN {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "uaepass-login";
  }

  static get LUCKY_DRAW_EVENTS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "event/luckydraw-event-listing";
  }

  static get SUBSCRIBE_EVENTS {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "event/luckydraw-event-registration";
  }

  static get PRIZE_HISTORY {
    int lang = Provider.of<UserModelProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .language ??
        0;
    BASE_URL = "https://hpcapi.happinessclub.ae/api/v2/";
    if (lang != 0) {
      BASE_URL = BASE_URL + "ar/";
    }
    return BASE_URL + "customer/prize-history";
  }

  static const String UAE_PASS_URL = "https://happinessclub.ae/m/uaepass";
  static const Map<String, dynamic> HEADER = {
    "api-key": "KZ85YttM4ZYMD4avjgTWr3QtXnAhk7aF"
  };
}

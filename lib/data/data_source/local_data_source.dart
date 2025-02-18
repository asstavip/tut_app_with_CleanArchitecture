import 'package:flutter_advanced/data/network/error_handler.dart';
import 'package:flutter_advanced/data/responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_DETAILS_KEY = "CACHE_DETAILS_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000;
const CACHE_DETAILS_INTERVAL = 60 * 1000;

abstract class LocalDataSource {
  // ! get home data from cache
  Future<HomeResponse> getHomeData();

  // ! save home data in cache
  Future<void> saveHomeCache(HomeResponse homeResponse);


  // ! get store details data from cache
  Future<StoreDetailsResponse> getStoreDetails();

  // ! save store details data in cache
  Future<void> saveStoreDetailsCache(StoreDetailsResponse storeDetailsResponse);
  void clearCache();

  void removeFromCache(String key);
}
  
class LocalDataSourceImplementer implements LocalDataSource {
  Map<String, CachedItem> cacheMap = <String, CachedItem>{};

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      // ! return homeResponse from cache
      return cachedItem.data;
    } else {
      // ! return an error
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

// in local_data_source.dart
  @override
  Future<StoreDetailsResponse> getStoreDetails() async{
    
    CachedItem? cachedItem = cacheMap[CACHE_DETAILS_KEY];
    
    if (cachedItem != null) {
      
    }
    if (cachedItem != null && cachedItem.isValid(CACHE_DETAILS_INTERVAL)) {
      
      return cachedItem.data;
    } else {
      
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsCache(StoreDetailsResponse storeDetailsResponse) async{
    
    cacheMap[CACHE_DETAILS_KEY] = CachedItem(storeDetailsResponse);
    
  }

}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expireAfterSeconds) =>
      DateTime.now().millisecondsSinceEpoch - cacheTime <= expireAfterSeconds;
}

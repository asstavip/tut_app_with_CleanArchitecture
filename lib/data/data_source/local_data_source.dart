import 'package:flutter_advanced/data/responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<void> saveHomeCache(HomeResponse homeResponse);
}

class LocalDataSourceImplementer implements LocalDataSource {

  Map<String, CachedItem> cacheMap = <String, CachedItem>{};
  
  @override
  Future<HomeResponse> getHomeData() {
    // TODO: implement getHomeData
    throw UnimplementedError();
  }

  @override
  Future<void> saveHomeCache(HomeResponse homeResponse) async{
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

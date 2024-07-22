import 'package:news_app_test/src/core/hive/hive_services.dart';
import 'package:news_app_test/src/feature/home/data/model/popular_model/popular_model.dart';

class PopularNewsLocalSource extends HiveService<List<PopularNewsResult>?> {
  PopularNewsLocalSource() : super(HiveBoxes.cachedNews);
}

import 'package:news_app_test/core/hive/hive_services.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';

class PopularNewsLocalSource extends HiveService<List<PopularNewsResult>?> {
  PopularNewsLocalSource() : super(HiveBoxes.cachedNews);
}

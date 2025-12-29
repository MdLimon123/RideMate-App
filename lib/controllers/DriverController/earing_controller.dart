import 'package:get/get.dart';
import 'package:radeef/models/Driver/parcel_earn_model.dart';
import 'package:radeef/models/Driver/trip_earn_model.dart';
import 'package:radeef/service/api_client.dart';

class EaringController extends GetxController {
  var isLoading = false.obs;

  final RxString selectedTab = 'trip'.obs;

  final RxList<TripEarnItem> tripList = <TripEarnItem>[].obs;
  final RxList<ParcelEarnItem> parcelList = <ParcelEarnItem>[].obs;

  ParcelEarnMeta? parcelMeta;

  final RxString selectedOption = 'This Week'.obs;
  int days = -1;

  int page = 1;
  bool hasMore = true;

final Map<String, String> optionsMap = {
    'This Week': 'this_week',
    'This Month': 'this_month',
  };

  void changeOption(String newValue) {
    selectedOption.value = newValue;
    page = 1;
    hasMore = true;
    tripList.clear();
    parcelList.clear();
    fetchEarnings();
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
    resetAndFetch();
  }

  void resetAndFetch() {
    page = 1;
    hasMore = true;
    tripList.clear();
    parcelList.clear();
    fetchEarnings();
  }

  void loadMore() {
    if (!isLoading.value && hasMore) {
      page++;
      fetchEarnings();
    }
  }

  Future<void> fetchEarnings() async {
    if (!hasMore) return;

    isLoading(true);

      String url = '/drivers/earnings';
    if (selectedOption.value.isNotEmpty) {
      String dateRange = optionsMap[selectedOption.value] ?? '-1';
      url = '/drivers/earnings?tab=${selectedTab.value}&dateRange=$dateRange&page=$page';
    }

    final response = await ApiClient.getData(
      url,
    );

    if (response.statusCode == 200) {
      final json = response.body;

      if (selectedTab.value == 'parcel') {
        final model = ParcelEarnModel.fromJson(json);
        parcelMeta = model.meta;
        parcelList.addAll(model.data);
        hasMore = model.data.isNotEmpty;
      } else {
        final model = TripEarnModel.fromJson(json);
        tripList.addAll(model.data);
        hasMore = model.data.isNotEmpty;
      }
    }

    isLoading(false);
  }
}

import 'package:book_a_hall/constants/consonants.dart';

class HallModel {
  final String? hallName;
  final String? hallAddress;
  final String? ratePerPerson;
  final String? maxCapacity;
  final List<dynamic>? hallFeatures;
  final String? hallId;
  final List<dynamic>? hallImages;

  HallModel(
      {this.hallFeatures,
      this.hallAddress,
      this.hallName,
      this.hallId,
      this.hallImages,
      this.maxCapacity,
      this.ratePerPerson});

  Map<String, dynamic> asMap() {
    return {
      kHallName: hallName ?? '',
      kHallAddress: hallAddress ?? '',
      kHallFeatures: hallFeatures ?? '',
      kMaxCapacity: maxCapacity ?? '',
      kRatePerPerson: ratePerPerson ?? '',
      kHallImages: hallImages ?? [],
    };
  }
}

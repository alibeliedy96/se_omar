// File: fake_data_generator.dart
import 'dart:math';
import '../modules/explore/domain/models/slider_response.dart';
import '../modules/explore/domain/models/units_response.dart';
import '../modules/hotel_details/domain/models/unit_details_response.dart';

class FakeDataGenerator {

  /// Generates a list of fake slider data.
  static List<SliderData> generateFakeSliders({int count = 3}) {
    return List.generate(count, (index) {
      return SliderData(
        id: index + 1,
        title: 'شريحة وهمية ${index + 1}',
        image: 'https://via.placeholder.com/600x400.png/007d77?text=Slider+${index + 1}',
        order: index,
      );
    });
  }

  /// Generates a list of fake unit data with nested objects.
  static List<UnitsData> generateFakeUnits({int count = 5}) {
    final random = Random();
    return List.generate(count, (index) {
      return UnitsData(
        id: index + 100,
        name: 'وحدة سكنية وهمية ${index + 1}',
        unitNumber: 'A-${index + 1}',
        description: 'وصف وهمي للوحدة السكنية رقم ${index + 1} يحتوي على تفاصيل جذابة.',
        status: 'available',
        bedrooms: random.nextInt(3) + 1,
        bathrooms: random.nextInt(2) + 1,
        maxGuests: random.nextInt(4) + 2,
        size: '${random.nextInt(100) + 80} متر مربع',
        address: 'عنوان وهمي ${index + 1}، القاهرة، مصر',
        unitType: UnitType(id: 1, name: 'شقة', isActive: true),
        images: List.generate(3, (i) => Images(
          id: (index * 10) + i,
          imagePath: 'https://via.placeholder.com/400x300.png/009688?text=Unit+Image+${i + 1}',
          isPrimary: i == 0,
        )),
        amenities: [
          Amenities(id: 1, name: 'Wi-Fi'),
          Amenities(id: 2, name: 'مكيف هواء'),
        ],
        pricing: Pricing(
          basePrice: '${random.nextInt(500) + 500}',
          weekendPrice: '${random.nextInt(600) + 600}',
        ),
        createdAt: DateTime.now().toIso8601String(),
      );
    });
  }

  /// Generates a single, detailed fake data object for the unit details screen.
  static UnitDetailsData generateFakeUnitDetails({required int unitId}) {
    final random = Random();
    return UnitDetailsData(
      id: unitId,
      name: 'شاليه الأحلام على البحر',
      unitNumber: 'C-${random.nextInt(100)}',
      description: 'استمتع بإقامة فاخرة في هذا الشاليه المطل على البحر مباشرة. يحتوي على كل وسائل الراحة الحديثة التي تحتاجها لقضاء عطلة لا تنسى.',
      status: 'available',
      bedrooms: 3,
      bathrooms: 2,
      maxGuests: 6,
      size: '${random.nextInt(50) + 120} متر مربع',
      address: 'طريق الكورنيش، الإسكندرية، مصر',
      unitType: UnitType(
        id: 1,
        name: 'شاليه',
        description: 'وحدة سكنية فاخرة للعطلات',
        maxCapacity: 8,
        isActive: true,
      ),
      images: List.generate(5, (i) => Images(
        id: (unitId * 10) + i,
        unitId: unitId,
        imagePath: 'https://via.placeholder.com/800x600.png/009688?text=Chalet+View+${i + 1}',
        caption: 'منظر ${i + 1}',
        order: i,
        isPrimary: i == 0,
        isActive: true,
      )),
      amenities: [
        Amenities(id: 1, name: 'Wi-Fi', icon: 'wifi_icon'),
        Amenities(id: 2, name: 'مكيف هواء', icon: 'ac_icon'),
        Amenities(id: 3, name: 'مطبخ مجهز بالكامل', icon: 'kitchen_icon'),
        Amenities(id: 4, name: 'حمام سباحة خاص', icon: 'pool_icon'),
        Amenities(id: 5, name: 'موقف سيارات', icon: 'parking_icon'),
      ],
      pricing: Pricing(
        id: unitId,
        unitId: unitId,
        basePrice: '1500',
        weekendPrice: '2000',
        holidayPrice: '2500',
        weeklyPrice: '9000',
        monthlyPrice: '30000',
        cleaningFee: '200',
        securityDeposit: '1000',
        isActive: true,
        validFrom: DateTime.now().toIso8601String(),
        validTo: DateTime.now().add(const Duration(days: 365)).toIso8601String(),
      ),
      createdAt: DateTime.now().subtract(const Duration(days: 60)).toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

}
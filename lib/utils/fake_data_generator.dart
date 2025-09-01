// File: fake_data_generator.dart
import 'dart:math';
import '../modules/explore/domain/models/slider_response.dart';
import '../modules/explore/domain/models/units_response.dart';
import '../modules/myTrips/domain/models/get_reservations_response.dart' hide RatingStatistics;
import '../modules/search/domain/models/search_response.dart';
import '../modules/unit_details/domain/models/unit_details_response.dart';

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
      createdAt: DateTime.now().subtract(const Duration(days: 60)).toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  /// Generates a list of fake Reservations data.
  static generateFakeReservationsResponse({int count = 10}) {
    final random = Random();

    return List.generate(count, (index) {
      return ReservationsData(
        id: index + 1,
        reservationNumber: "RSV-${1000 + index}",
        checkInDate: "2025-09-${10 + index}",
        checkOutDate: "2025-09-${11 + index}",
        nights: 1 + random.nextInt(7),
        specialRequests: "Extra pillows, late check-in",
        adminNotes: "Handled by admin ${index + 1}",
        reservationNotes: "Customer requested sea view",

        cancellationPolicy: CancellationPolicy(

          name: "Flexible",
          description: "Full refund 24 hours before check-in.",

        ),
        guestInformation: GuestInformation(

          email: "john.doe${index}@mail.com",
          phone: "+20100${123456 + index}",
        ),
        depositRequirements: DepositRequirements(

        ),
        pricing: Pricing(
            cleaningFee: "100"
        ),
        transferPayment: TransferPayment(

        ),

        timestamps: Timestamps(
          createdAt: "2025-08-15",
          updatedAt: "2025-08-20",
        ),
      );
    });
  }

  /// Generates a list of fake search data.
  static List<SearchData> generateFakeSearchResponse({int count = 10}) {
    final random = Random();
    final statuses = ["available", "booked", "maintenance"];
    final unitTypes = ["Apartment", "Villa", "Studio", "Penthouse"];
    final amenitiesList = ["WiFi", "Pool", "Parking", "AC", "Gym"];

    return List.generate(count, (index) {
      return SearchData(
        id: index + 1,
        name: "Luxury Unit ${index + 1}",
        unitNumber: "A-${100 + index}",
        description:
        "This is a modern and fully furnished unit with all amenities included. Perfect for families and travelers.",
        status: statuses[random.nextInt(statuses.length)],
        bedrooms: "${1 + random.nextInt(4)}",
        bathrooms: "${1 + random.nextInt(3)}",
        maxGuests: "${2 + random.nextInt(6)}",
        size: "${80 + random.nextInt(120)} sqm",
        address: "Street ${10 + index}, Cairo, Egypt",
        unitType: UnitType(id: index, name: unitTypes[random.nextInt(unitTypes.length)]),

        amenities: amenitiesList
            .map((a) => Amenities(id: random.nextInt(1000), name: a))
            .toList(),

        minimumReservationDays: "${1 + random.nextInt(5)}",
        createdAt: DateTime.now().subtract(Duration(days: random.nextInt(100))).toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),

      );
    });
  }
}


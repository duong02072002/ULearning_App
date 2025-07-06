// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeScreenBannerDotsHash() =>
    r'44c3f15bab8bacef82ebfe414b4828aab1c80408';

/// See also [HomeScreenBannerDots].
@ProviderFor(HomeScreenBannerDots)
final homeScreenBannerDotsProvider =
    NotifierProvider<HomeScreenBannerDots, int>.internal(
      HomeScreenBannerDots.new,
      name: r'homeScreenBannerDotsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$homeScreenBannerDotsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HomeScreenBannerDots = Notifier<int>;
String _$homeUserProfileHash() => r'88174b85992d30a03ee01a0f56e009cf96aa942e';

/// See also [HomeUserProfile].
@ProviderFor(HomeUserProfile)
final homeUserProfileProvider =
    AsyncNotifierProvider<HomeUserProfile, UserProfile>.internal(
      HomeUserProfile.new,
      name: r'homeUserProfileProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$homeUserProfileHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HomeUserProfile = AsyncNotifier<UserProfile>;
String _$homeCourseListHash() => r'9cff2bf624079fc20831215ed11b531434dced29';

/// See also [HomeCourseList].
@ProviderFor(HomeCourseList)
final homeCourseListProvider =
    AsyncNotifierProvider<HomeCourseList, List<CourseItem>?>.internal(
      HomeCourseList.new,
      name: r'homeCourseListProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$homeCourseListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HomeCourseList = AsyncNotifier<List<CourseItem>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

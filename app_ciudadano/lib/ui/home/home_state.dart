
import 'package:equatable/equatable.dart';
import '../../domain/models/user/user_model.dart';
import '../../utils/constants.dart';

class HomeState extends Equatable {

  /// Indicates if the app is loading the data and components.
  final bool isLoading;

  /// Indicates the current app section.
  final String appSection;

  /// The information of the user logged.
  final UserModel? userInfo;
  final int countNotifications ;

  const HomeState({
    this.isLoading = false,
    this.appSection = AppConstants.sectionNews,
    this.userInfo ,
    this.countNotifications = 0
  });

   @override
  List<Object?> get props => [isLoading,appSection,userInfo,countNotifications];

  HomeState copyWith({
    bool? isLoading,
    String? appSection,
    UserModel? userInfo,
    int? countNotifications
  }) =>
    HomeState(
      isLoading : isLoading ?? this.isLoading,
      appSection: appSection ?? this.appSection,
      userInfo : userInfo ?? this.userInfo,
      countNotifications: countNotifications ?? this.countNotifications
    );

 
}

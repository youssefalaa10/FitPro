import 'package:fitpro/Core/DI/dependency.dart';
import 'package:fitpro/Core/Shared/Routes.dart';
import 'package:fitpro/Features/Home/home_screen.dart';
import 'package:fitpro/Features/Profile/UI/edit_profile_screen.dart';
import 'package:fitpro/Features/TrackSteps/Logic/cubit/track_step_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Features/Profile/UI/profile_screen.dart';
import '../../Features/TrackSteps/Ui/track_steps_screen.dart';
import '../../Features/UserInfo/UI/body_metrics.dart';
import '../../Features/UserInfo/UI/user_age_screen.dart';
import '../../Features/UserInfo/UI/user_gender_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.trackStepsScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<TrackStepCubit>(),
                  child: const TrackStepsScreen(),
                ));

      case Routes.userGenderScreen:
        return MaterialPageRoute(builder: (_) => const UserGenderScreen());

      case Routes.userAgeScreen:
        return MaterialPageRoute(builder: (_) => const UserAgeScreen());
      case Routes.bodyMetricsScreen:
        return MaterialPageRoute(builder: (_) => const BodyMetricsScreen());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.editProfileScreen:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text("No Routes defined"),
                  ),
                ));
    }
  }
}

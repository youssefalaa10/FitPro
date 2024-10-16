import 'package:fitpro/Core/DI/dependency.dart';
import 'package:fitpro/Core/Shared/Routes.dart';
import 'package:fitpro/Features/Auth/ChangePassword/UI/change_password.dart';
import 'package:fitpro/Features/Auth/ForgotPassword/UI/forgot_password.dart';
import 'package:fitpro/Features/Auth/Verification/UI/verification_screen.dart';

import 'package:fitpro/Features/AuthHelper/cubit/tokencheck_cubit.dart';
import 'package:fitpro/Features/AuthHelper/token_check.dart';
import 'package:fitpro/Features/Calories/Ui/calories_details.dart';
import 'package:fitpro/Features/Calories/Ui/calories_screen.dart';
import 'package:fitpro/Features/FoodDiary/ui/food_details.dart';
import 'package:fitpro/Features/FoodDiary/ui/food_diary.dart';
import 'package:fitpro/Features/Home/home_screen.dart';
import 'package:fitpro/Features/MyPlan/myplan_screen.dart';
import 'package:fitpro/Features/Layout/layout_screen.dart';
import 'package:fitpro/Features/Profile/Data/Model/user_model.dart';
import 'package:fitpro/Features/Profile/UI/edit_profile_screen.dart';
import 'package:fitpro/Features/Sleep/set_alarm.dart';
import 'package:fitpro/Features/Sleep/sleep_screan.dart';
import 'package:fitpro/Features/TrackSteps/Logic/cubit/track_step_cubit.dart';
import 'package:fitpro/Features/TrackSteps/Ui/track_step_details.dart';
import 'package:fitpro/Features/UserInfo/UI/info_pageveiw.dart';
import 'package:fitpro/Features/Water/Logic/cubit/water_intake_cubit.dart';
import 'package:fitpro/Features/Water/water_screen.dart';
import 'package:fitpro/Features/Water/water_target.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Features/Auth/Login/Logic/cubit/login_cubit.dart';
import '../../Features/Auth/Login/Ui/login_screen.dart';

import '../../Features/Auth/Register/Logic/cubit/register_cubit.dart';
import '../../Features/Auth/Register/Ui/register_screen.dart';
import '../../Features/Exercises/Logic/cubit/exercise_cubit.dart';
import '../../Features/Exercises/UI/exercise_screen.dart';
import '../../Features/Exercises/UI/get_ready_screen.dart';
import '../../Features/Exercises/UI/rest_screen.dart';
import '../../Features/Exercises/UI/training_screen.dart';
import '../../Features/Exercises/UI/weekly_exercise_screen.dart';
import '../../Features/Profile/Logic/cubit/profile_cubit.dart';
import '../../Features/Profile/UI/profile_screen.dart';
import '../../Features/Sleep/Components/timer_picker.dart';
import '../../Features/TrackSteps/Ui/track_steps_screen.dart';
import '../../Features/UserInfo/UI/body_metrics.dart';
import '../../Features/UserInfo/UI/user_age_screen.dart';
import '../../Features/UserInfo/UI/user_gender_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
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

      case Routes.foodDiary:
        return MaterialPageRoute(builder: (_) => const FoodDiaryScreen());

      case Routes.foodDatails:
        return MaterialPageRoute(builder: (_) => const FoodDetailScreen());

      case Routes.userAgeScreen:
        return MaterialPageRoute(builder: (_) => const UserAgeScreen());
      case Routes.bodyMetricsScreen:
        return MaterialPageRoute(builder: (_) => const BodyMetricsScreen());

      case Routes.infoPageView:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<RegisterCubit>(),
                  child: const InfoPageView(),
                ));
      case Routes.profileScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<ProfileCubit>(),
                  child: const ProfileScreen(),
                ));
      case Routes.editProfileScreen:
        final user =
            settings.arguments as UserModel; // Get the passed user object
        return MaterialPageRoute(
          builder: (_) => EditProfileScreen(userModel: user),
        );
      case Routes.layoutScreen:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());

      case Routes.myPlanScreen:
        return MaterialPageRoute(builder: (_) => const MyPlanScreen());
      case Routes.caloriesScreen:
        return MaterialPageRoute(builder: (_) => const CaloriesScreen());

      case Routes.waterScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<WaterIntakeCubit>(),
                  child: const WaterScreen(),
                ));

      case Routes.sleepScreen:
        return MaterialPageRoute(builder: (_) => const SleepScrean());
      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIT<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<LoginCubit>(),
                  child: const LoginScreen(),
                ));

      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case Routes.verificationScreen:
        return MaterialPageRoute(builder: (_) => const VerificationScreen());

      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      case Routes.exerciseScreen:
        return MaterialPageRoute(
          builder: (context) {
            final bodyPart = settings.arguments as String? ?? 'chest';
            return BlocProvider(
              create: (context) {
                final cubit = getIT<ExerciseCubit>();
                cubit.fetchExercises(bodyPart);
                return cubit;
              },
              child: ExerciseScreen(bodyPart: bodyPart),
            );
          },
        );

      case Routes.weeklyExerciseScreen:
        return MaterialPageRoute(builder: (_) => const WeeklyExerciseScreen());

      case Routes.checkToken:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => TokencheckCubit(),
                  child: const TokenCheck(),
                ));
      case Routes.detaildCaloriesScreen:
        return MaterialPageRoute(builder: (_) => const CaloriesDetails());

      case Routes.waterDetails:
        return MaterialPageRoute(builder: (_) => const WaterDetails());
      case Routes.trackStepsDetailsScreen:
        return MaterialPageRoute(builder: (_) => const TrackStepDetails());

      case Routes.getReadyScreen:
        return MaterialPageRoute(builder: (_) => const GetReadyScreen());

      case Routes.restScreen:
        return MaterialPageRoute(builder: (_) => const RestScreen());

      case Routes.trainingScreen:
        return MaterialPageRoute(builder: (_) => const TrainingScreen());

      case Routes.setAlarm:
        return MaterialPageRoute(builder: (_) => const SetAlarm());

      case Routes.timerPicker:
        return MaterialPageRoute(builder: (_) => const TimerPickerScreen());

      default:
        return null;
    }
  }
}

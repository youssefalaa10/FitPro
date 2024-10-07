import 'package:fitpro/Core/Components/back_button.dart';
import 'package:fitpro/Core/Components/custom_button.dart';
import 'package:fitpro/Core/Components/custom_icon_button.dart';
import 'package:fitpro/Core/Components/custom_sizedbox.dart';
import 'package:fitpro/Core/Shared/app_colors.dart';
import 'package:fitpro/Core/Shared/app_string.dart';
import 'package:fitpro/Core/Shared/routes.dart';
import 'package:fitpro/Features/Water/Logic/cubit/water_intake_cubit.dart';
import 'package:flutter/material.dart';
import 'package:fitpro/Core/Components/media_query.dart'; // Correct import for CustomMQ
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WaterIntakeCubit>(context).fetchTodayIntake();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This will refresh the data every time the screen comes into view
    BlocProvider.of<WaterIntakeCubit>(context).fetchTodayIntake();
  }

  @override
  Widget build(BuildContext context) {
    final mq = CustomMQ(context); // Instantiate CustomMQ

    return Scaffold(
      backgroundColor: ColorManager.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeaderSection(context, mq),
            const CustomSizedbox(height: 30),
            _buildWelcomeMessage(mq),
            const CustomSizedbox(height: 30),
            _buildStackedLottieImage(mq),
            const CustomSizedbox(height: 30),
            _buildPercentIndicator(mq),
            const CustomSizedbox(height: 20),
            CustomButton(
                label: "Add Water Intake +",
                onPressed: () {
                  Navigator.pushNamed(context, Routes.waterAddScreen);
                })
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, CustomMQ mq) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.width(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomBackButton(),
          _buildHeaderTitle(mq),
          CustomIconButton(
            icon: Icons.edit,
            onPressed: () async {
              final result =
                  await Navigator.pushNamed(context, Routes.waterAddScreen);
              print(result);
              // Check if the result is true
              if (result == true) {
                print("D");
                // Fetch the updated water intake after the user adds water
                BlocProvider.of<WaterIntakeCubit>(context).fetchTodayIntake();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderTitle(CustomMQ mq) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width(7.5)),
        child: Text(
          "Water Intake Details",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: mq.width(4.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage(CustomMQ mq) {
    return Column(
      children: [
        Text(
          AppString.greatWork,
          style: TextStyle(
            fontSize: mq.width(3.75),
            fontWeight: FontWeight.bold,
            color: ColorManager.lightGreyColor,
          ),
        ),
        const CustomSizedbox(height: 5),
        Text(
          AppString.yourDailytasksAlmostDone,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: mq.width(7),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPercentIndicator(CustomMQ mq) {
    return BlocBuilder<WaterIntakeCubit, WaterIntakeState>(
        builder: (context, state) {
      if (state is WaterIntakeSuccess) {
        int intake = state.totalIntake;
        print(intake);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: LinearPercentIndicator(
                leading: Icon(
                  Icons.water_drop,
                  color: ColorManager.blueColor,
                  size: mq.width(8),
                ),
                barRadius: const Radius.circular(30),
                lineHeight: mq.height(3),
                width: mq.width(75),
                animation: true,
                animationDuration: 1000,
                backgroundColor: const Color.fromARGB(255, 228, 225, 225),
                progressColor: Colors.blue,
                percent: (intake / 20000).clamp(0.0, 1.0),
              ),
            ),
          ],
        );
      }
      return const CircularProgressIndicator();
    });
  }
}

Widget _buildStackedLottieImage(CustomMQ mq) {
  return Center(
    child: SizedBox(
      height: mq.height(25),
      width: mq.width(62.5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          LottieBuilder.asset(
            AppString.waterLottie,
            height: mq.height(25),
            width: mq.width(62.5),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "2",
                  style: TextStyle(
                    fontSize: mq.width(11.25),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: "lits",
                  style: TextStyle(
                    fontSize: mq.width(5),
                    color: ColorManager.backGroundColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

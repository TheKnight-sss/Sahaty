import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sihati/components/buttons/custom_button.dart';
import 'package:sihati/core/functions/dailog.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/routes/routes.dart';
import 'package:sihati/core/utils/appcolors.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/order/presentation/cubit/buyer_state.dart';
import 'package:sihati/features/order/presentation/cubit/person_cubit.dart';
import 'package:sihati/features/order/presentation/widgets/order_field.dart';

class AddorderAttributesScreen extends StatefulWidget {
  const AddorderAttributesScreen({super.key});

  @override
  State<AddorderAttributesScreen> createState() =>
      _AddorderAttributesScreenState();
}

class _AddorderAttributesScreenState extends State<AddorderAttributesScreen> {
  bool addingbuyer = false;
  bool addingrep = false;

  @override
  void initState(){
    super.initState();
    context.read<PersonCubit>().resetbuyer();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<PersonCubit>();
    return Scaffold(
      appBar: AppBar(title: Text("Order Attributes"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: BlocListener<PersonCubit, PersonState>(
          listener: (context, state) {
            if (state is PersonLoading) {
              showLoadingDialog(context);
            } else if (state is PersonLoaded) {
              pop(context); // close loading dialog
        
              pushReplacementTo(context, Routes.dashboard);
            }else if (state is PersonFailure){
              pop(context);
              showMyDialog(context, state.message, type: DialogType.error);
            }
          },
          child: Form(
            key: cubit.formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Appcolors.slcard.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Buyer",
                              style: Style.loginFieldLabel.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  addingbuyer = !addingbuyer;
                                });
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Appcolors.signinbg,
                              ),
                            ),
                          ],
                        ),
                        if (addingbuyer == true) ...[
                          Gap(10),
                          OrderField(
                            head: "Buyer",
                            hintText: 'Enter Buyer Name'.tr(),
                            prefixIcon: Icon(Icons.person_outline_sharp),
                            controller: cubit.buyerNameController,
                          ),
                          Gap(5),
                          OrderField(
                            head: "Location",
                            hintText: 'Enter Location'.tr(),
                            prefixIcon: Icon(Icons.person_outline_sharp),
                            controller: cubit.locationController,
                          ),
                          Gap(5),
                          OrderField(
                            head: "Phone",
                            hintText: 'Enter Phone Number'.tr(),
                            prefixIcon: Icon(Icons.phone),
                            controller: cubit.buyerphoneController,
                          ),
                          Gap(6),
                          CustomButton(
                            onPressed: () {
                              cubit.addBuyers();
                              pushReplacementTo(context,Routes.dashboard);
                            },
                            color1: Appcolors.splashup,
                            color2: Appcolors.splashcenter,
                            color3: Appcolors.splashdown,
                            child: Text(
                              "Add Buyer",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
              
                  Gap(15),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Appcolors.slcard.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Representative",
                              style: Style.loginFieldLabel.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  addingrep = !addingrep;
                                });
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Appcolors.signinbg,
                              ),
                            ),
                          ],
                        ),
                        if (addingrep == true) ...[
                          Gap(10),
                          OrderField(
                            head: "Rep",
                            hintText: 'Enter Rep Name'.tr(),
                            prefixIcon: Icon(Icons.person_outline_sharp),
                            controller: cubit.repNameController,
                          ),
                          Gap(5),
                          OrderField(
                            head: "Phone",
                            hintText: 'Enter Phone Number'.tr(),
                            prefixIcon: Icon(Icons.phone),
                            controller: cubit.repphoneController,
                          ),
                          Gap(5),
                          CustomButton(
                            onPressed: () {
                              cubit.addReps();
                              pushReplacementTo(context,Routes.dashboard);
                            },
                            color1: Appcolors.splashup,
                            color2: Appcolors.splashcenter,
                            color3: Appcolors.splashdown,
                            child: Text(
                              "Add Representative",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

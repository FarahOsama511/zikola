import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/core/theming/text_style_manager.dart';
import 'package:zikola/features/Home/business%20logic/cubit/log_out_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/log_out_state.dart';
import 'package:zikola/features/Home/business%20logic/cubit/my_orders_cubit.dart';


class ProfileScreen extends StatefulWidget {

 const  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDark=false;

  @override
  Widget build(BuildContext context) {
    return 
    
    BlocListener<LogOutCubit,LogOutState>(listener: (context,state){
      if(state is SuccessLogOut){
        context.go('/');
      }
      else if(state is ErrorLogOut){
           ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.error.message)));
      }
    },child:
    
    
    Scaffold(
     
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentGeometry.topLeft,
                      end: AlignmentGeometry.bottomRight,
                      colors: [ColorManager.orangeColor,ColorManager.primaryColor])
                  ),
                ),
                Positioned(
                  top: 160,
                  right: 20,
                  left:20,
                  child: Container(
                    height: 130.h,
                    padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 14.h),
                   decoration: BoxDecoration(
                  
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
           color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 9,
            offset: const Offset(0, 2),
                      ),
                 
                    ]
                   ),
                    child: Column(
                      children: [
                        Row(

                          children: [
                            IconButton(onPressed: (){}, icon:Icon(Icons.sunny,size: 35,)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Dark Mode",style: TextStyleManager.font15Bold,),
                                Text("Disabled",style: TextStyleManager.font15Bold.copyWith(color: ColorManager.greyColor),)
                              ],
                            ),
                            Spacer(),
                            Switch(
                              inactiveThumbColor: Colors.white,
                              activeThumbColor: ColorManager.orangeColor,
                       inactiveTrackColor:ColorManager.lightGrey ,
                              value: isDark, onChanged: (value){
                             setState(() {
                                  isDark=!isDark;
                             });
                              }),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                                  IconButton(onPressed: (){}, icon:Icon(Icons.lock  ,size: 35,)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Change Password",style: TextStyleManager.font15Bold,),
                                Text("Update your password",style: TextStyleManager.font15Bold.copyWith(color: ColorManager.greyColor),)
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
           
           SizedBox(height: 70.h,),
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: ColorManager.lightGrey),
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 14.w,vertical: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Stats",style: TextStyleManager.font20Bold,),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       Text(
                      textAlign: TextAlign.center,
                        "${context.read<GetMyOrdersCubit>().allOrders.length}",style:TextStyleManager.font15Bold.copyWith(color: ColorManager.orangeColor)),
                       Text("${context.read<GetMyOrdersCubit>().pendingOrder.length}",style:TextStyleManager.font15Bold.copyWith(color: ColorManager.primaryColor)),
                      ],
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       Text("Total Orders",style:TextStyleManager.font15Bold.copyWith(color: ColorManager.greyColor)),
                       Text("This week",style:TextStyleManager.font15Bold.copyWith(color: ColorManager.greyColor)),
                      ],
                    ),
                  ],
                ),
              )
              ,
            ),
             SizedBox(height: 80.h,),
         InkWell(
          onTap: ()async{
          await  BlocProvider.of<LogOutCubit>(context).logOut();
          },
          child: Container(
               width: double.infinity,
              height: 45.h,
              padding: EdgeInsets.symmetric(vertical: 7.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red,width: 2),
                borderRadius: BorderRadius.circular(10.r),
        
              ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout,color: Colors.red,),
                Text("Logout",style: TextStyleManager.font20RegularBlack.copyWith(color: Colors.red),)

              ],
            ),
          ),
         )
          ],
          
        ),
      ),),
     ), );
  }
}
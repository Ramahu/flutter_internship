import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

Widget loadingWidget() => const Center(
        child: CircularProgressIndicator(
      color: AppColors.defaultBlue2,
    ));

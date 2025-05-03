import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';

Widget loadingWidget() => const Center(
        child: CircularProgressIndicator(
      color: AppColors.defaultBlue2,
    ));

Widget errorWidget(errorMsg) => Center(child: Text('Error: $errorMsg'));

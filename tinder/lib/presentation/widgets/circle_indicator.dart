import 'package:tinder/presentation/base/base_page_mixin.dart';

class CircleIndication extends StatelessWidget {
  const CircleIndication({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
      backgroundColor: AppColors.primaryColor.withAlpha(100),
      strokeWidth: 5,
    );
  }
}

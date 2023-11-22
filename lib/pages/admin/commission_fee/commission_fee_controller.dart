import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommissionFeeController extends GetxController {

  final TextEditingController controllerAmountLesIntern   = TextEditingController();
  final TextEditingController controllerFeeLesIntern      = TextEditingController();
  final TextEditingController controllerAmountMoreIntern  = TextEditingController();
  final TextEditingController controllerFeeMoreIntern     = TextEditingController();

  final TextEditingController controllerAmountLesExtern     = TextEditingController();
  final TextEditingController controllerFeeLesExtern        = TextEditingController();
  final TextEditingController controllerAmountMoreExtern    = TextEditingController();
  final TextEditingController controllerFeeMoreExtern       = TextEditingController();


  final TextEditingController controllerExternalTrans      = TextEditingController();


  @override
  void onInit(){
    super.onInit();
    initController();
  }

  void initController(){
    controllerAmountLesIntern.text = '50';
    controllerFeeLesIntern.text = '0.2';

    controllerAmountMoreIntern.text = '50';
    controllerFeeMoreIntern.text = '2';

    controllerAmountLesExtern.text = '50';
    controllerFeeLesExtern.text = '0.2';

    controllerAmountMoreExtern.text = '50';
    controllerFeeMoreExtern.text = '2';

    controllerExternalTrans.text = '20';
  }

  void submitData(){

  }

}

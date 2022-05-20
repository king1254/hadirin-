import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/history_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<OrderController>().getAllOrders();

    return Scaffold(
      appBar: CustomAppBar(title: 'my_orders'.tr, isBackButtonExist: false),
      body: GetBuilder<OrderController>(builder: (orderController) {

        return orderController.deliveredOrderList != null ? orderController.deliveredOrderList.length > 0 ? RefreshIndicator(
          onRefresh: () async {
            await orderController.getAllOrders();
          },
          child: Scrollbar(child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(child: SizedBox(
              width: 1170,
              child: ListView.builder(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                itemCount: orderController.deliveredOrderList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return HistoryOrderWidget(orderModel: orderController.deliveredOrderList[index], isRunning: false, index: index);
                },
              ),
            )),
          )),
        ) : Center(child: Text('no_order_found'.tr)) : Center(child: CircularProgressIndicator());
      }),
    );
  }
}

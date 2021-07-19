import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/forms.dart';
import 'package:superbaleia/widgets/texts.dart';

class LoginAdm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ControllerAdm c = Get.put(ControllerAdm());
    TextEditingController email = TextEditingController();
    TextEditingController senha = TextEditingController();
    return Obx(
      () => Scaffold(
        body: c.carregando.value == true
            ? BaleiaExtras.widgetLoading
            : Center(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: ResponsiveGridRow(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ResponsiveGridCol(
                          lg: 12,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            height: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/logo.png'),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          child: Column(
                            children: [
                              Text(
                                "Painel Administrativo",
                                style: textHeavy(
                                  28,
                                  corBackDark,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Entre para continuar",
                                style: textRegular(
                                  16,
                                  corGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ResponsiveGridCol(lg: 4, child: SizedBox()),
                        ResponsiveGridCol(
                          lg: 4,
                          child: Padding(
                            padding: EdgeInsets.only(top: 40, bottom: 40),
                            child: Column(
                              children: [
                                BaleiaForms.textFormField("Email", email, []),
                                SizedBox(height: 15),
                                BaleiaForms.textFormField("Senha", senha, []
                                    // c.login(
                                    //   email: email.text,
                                    //   pass: senha.text,
                                    // );
                                    ),
                              ],
                            ),
                          ),
                        ),
                        ResponsiveGridCol(lg: 4, child: SizedBox()),
                        ResponsiveGridCol(lg: 4, child: SizedBox()),
                        ResponsiveGridCol(
                          lg: 4,
                          child: BaleiaButtons.buttonPrimary(
                            "Login",
                            Get.context.width,
                            45,
                            () => c.loginAdmin(
                              email: email.text,
                              pass: senha.text,
                            ),
                          ),
                        ),
                        ResponsiveGridCol(lg: 4, child: SizedBox()),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

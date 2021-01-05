import 'package:flutter/material.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';
import 'package:zein_holistic/widgets/widgets.dart';

///*********************************************
/// Created by ukietux on 1/5/21 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _conName = TextEditingController();
  var _conDateBirth = TextEditingController();
  var _conAddress = TextEditingController();
  var _conPhoneNumber = TextEditingController();
  var _conAge = TextEditingController();

  var _fnName = FocusNode();
  var _fnDateBirth = FocusNode();
  var _fnAddress = FocusNode();
  var _fnPhoneNumber = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.addPatient),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              TextF(
                hint: Strings.name,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: _conName,
                curFocusNode: _fnName,
                nextFocusNode: _fnDateBirth,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextF(
                      hint: Strings.dateBirth,
                      textInputAction: TextInputAction.next,
                      controller: _conDateBirth,
                      curFocusNode: DisableFocusNode(),
                      nextFocusNode: _fnAddress,
                      validator: (value) =>
                          value.isEmpty ? Strings.errorEmpty : null,
                      onTap: () async {
                        var _result = await context.datePicker();
                        if (_result != null) {
                          _conDateBirth.text = _result.toString().toDate();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: context.dp16()),
                  Expanded(
                    flex: 2,
                    child: TextF(
                      textInputAction: TextInputAction.next,
                      curFocusNode: DisableFocusNode(),
                      controller: _conAge,
                    ),
                  ),
                ],
              ),
              TextF(
                hint: Strings.address,
                textInputAction: TextInputAction.next,
                controller: _conAddress,
                curFocusNode: _fnAddress,
                nextFocusNode: _fnPhoneNumber,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
              TextF(
                hint: Strings.phoneNumber,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.phone,
                controller: _conPhoneNumber,
                curFocusNode: _fnPhoneNumber,
                validator: (value) => value.isEmpty ? Strings.errorEmpty : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

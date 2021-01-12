import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/blocs/medical_record/detail/detail_medical_record_bloc.dart';
import 'package:zein_holistic/data/models/entities/medical_record_entity.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';
import 'package:zein_holistic/widgets/widgets.dart';

///*********************************************
/// Created by ukietux on 1/7/21 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class EditMedicalRecordPage extends StatefulWidget {
  EditMedicalRecordPage({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _EditMedicalRecordPageState createState() => _EditMedicalRecordPageState();
}

class _EditMedicalRecordPageState extends State<EditMedicalRecordPage> {
  TextEditingController _conMainComplaint = TextEditingController();
  TextEditingController _conAdditionalComplaint = TextEditingController();
  TextEditingController _conHistoryOfDisease = TextEditingController();
  TextEditingController _conCheckUpResult = TextEditingController();
  TextEditingController _conConclusionDiagnosis = TextEditingController();
  TextEditingController _conSuggestion = TextEditingController();
  TextEditingController _conExaminer = TextEditingController();

  FocusNode _fnMainComplaint = FocusNode();
  FocusNode _fnAdditionalComplaint = FocusNode();
  FocusNode _fnHistoryOfDisease = FocusNode();
  FocusNode _fnConclusionDiagnosis = FocusNode();
  FocusNode _fnSuggestion = FocusNode();
  FocusNode _fnExaminer = FocusNode();

  var _formKey = GlobalKey<FormState>();
  var _isFirstLoad = true;

  EditMedicalRecordBloc _editMedicalRecordBloc;
  DetailMedicalRecordBloc _detailMedicalRecordBloc;

  @override
  void initState() {
    super.initState();
    _editMedicalRecordBloc = BlocProvider.of(context);
    _detailMedicalRecordBloc = BlocProvider.of(context);
    _detailMedicalRecordBloc.getDetailMedicalRecord(widget.id);

    _conMainComplaint.addListener(() {
      logs("listener : ${_conMainComplaint.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    logs("isBuild");
    return Parent(
      appBar: context.appBar(title: Strings.editMedicalRecord),
      child: SingleChildScrollView(
        child: BlocListener(
          cubit: _editMedicalRecordBloc,
          listener: (_, state) {
            switch (state.status) {
              case Status.LOADING:
                {
                  Strings.pleaseWait.toToastLoading();
                }
                break;
              case Status.ERROR:
                {
                  state.message.toString().toToastError();
                }
                break;
              case Status.SUCCESS:
                {
                  Strings.successSaveData.toToastSuccess();
                  Navigator.pop(context);
                }
                break;
            }
          },
          child: BlocBuilder(
            cubit: _detailMedicalRecordBloc,
            builder: (_, state) {
              switch (state.status) {
                case Status.LOADING:
                  {
                    return Center(child: Loading());
                  }
                  break;
                case Status.ERROR:
                  {
                    return Center(
                      child: Empty(
                        errorMessage: state.message.toString(),
                      ),
                    );
                  }
                  break;
                case Status.SUCCESS:
                  {
                    //set initial data
                    if (_isFirstLoad) {
                      MedicalRecordEntity _medicalRecordEntity = state.data;
                      _conMainComplaint.text =
                          _medicalRecordEntity.mainComplaint;
                      _conAdditionalComplaint.text =
                          _medicalRecordEntity.additionalComplaint;
                      _conHistoryOfDisease.text =
                          _medicalRecordEntity.historyOfDisease;
                      _conCheckUpResult.text =
                          _medicalRecordEntity.checkUpResult;
                      _conConclusionDiagnosis.text =
                          _medicalRecordEntity.conclusionDiagnosis;
                      _conSuggestion.text = _medicalRecordEntity.suggestion;
                      _conExaminer.text = _medicalRecordEntity.examiner;

                      _isFirstLoad = false;
                    }
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextF(
                            hint: Strings.mainComplaint,
                            textInputAction: TextInputAction.next,
                            controller: _conMainComplaint,
                            curFocusNode: _fnMainComplaint,
                            nextFocusNode: _fnAdditionalComplaint,
                            validator: (value) =>
                                value.isEmpty ? Strings.errorEmpty : null,
                          ),
                          TextF(
                            hint: Strings.additionalComplaint,
                            textInputAction: TextInputAction.next,
                            controller: _conAdditionalComplaint,
                            curFocusNode: _fnAdditionalComplaint,
                            nextFocusNode: _fnHistoryOfDisease,
                          ),
                          TextF(
                            hint: Strings.historyOfDisease,
                            textInputAction: TextInputAction.next,
                            controller: _conHistoryOfDisease,
                            curFocusNode: _fnHistoryOfDisease,
                            nextFocusNode: _fnConclusionDiagnosis,
                          ),
                          TextF(
                            hint: Strings.conclusionDiagnosis,
                            textInputAction: TextInputAction.next,
                            controller: _conConclusionDiagnosis,
                            curFocusNode: _fnConclusionDiagnosis,
                            nextFocusNode: _fnSuggestion,
                          ),
                          TextF(
                            hint: Strings.suggestion,
                            textInputAction: TextInputAction.next,
                            controller: _conSuggestion,
                            curFocusNode: _fnSuggestion,
                            nextFocusNode: _fnExaminer,
                          ),
                          TextF(
                            hint: Strings.examiner,
                            textInputAction: TextInputAction.next,
                            controller: _conExaminer,
                            curFocusNode: _fnExaminer,
                            nextFocusNode: null,
                            validator: (value) =>
                                value.isEmpty ? Strings.errorEmpty : null,
                          ),
                          SizedBox(height: context.dp16()),
                          Button(
                            title: Strings.save,
                            color: Palette.colorPrimary,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                var _params = {
                                  'id': widget.id,
                                  'mainComplaint': _conMainComplaint.text,
                                  'additionalComplaint':
                                      _conAdditionalComplaint.text,
                                  'historyOfDisease': _conHistoryOfDisease.text,
                                  'checkUpResult': _conCheckUpResult.text,
                                  'conclusionDiagnosis':
                                      _conConclusionDiagnosis.text,
                                  'suggestion': _conSuggestion.text,
                                  'examiner': _conExaminer.text
                                };
                                _editMedicalRecordBloc
                                    .editMedicalRecord(_params);
                              }
                            },
                          )
                        ],
                      ),
                    );
                  }
                  break;
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

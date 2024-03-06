import 'package:flutter/material.dart';
import 'package:myrealtor/model/rent.dart';

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false,
  });
}

class AddRentTransaction extends StatefulWidget {
  const AddRentTransaction({super.key, required this.addRent});

  final void Function(Rent rent) addRent;

  @override
  State<StatefulWidget> createState() {
    return _AddRentTransactionState();
  }
}

class _AddRentTransactionState extends State<AddRentTransaction> {
  var enteredName = '';
  var enteredLastname = '';
  var enteredPhone = '';
  var enteredEmail = '';
  var enteredTenants = 0;
  var enteredKids = 0;
  var petInfo = '';
  List<String> propertytypes = [];
  var bed = 0;
  var bath = 0;
  var park = 0;
  DateTime contractTerminationDate = DateTime.now();
  DateTime movingDate = DateTime.now();
  var monthlyPay = 0;
  var searchAreas = '';
  var additionalNotes = '';

  final allCheckBox = CheckBoxState(title: "All Types");

  final List<CheckBoxState> propertyTypes = [
    CheckBoxState(title: 'Single-Family'),
    CheckBoxState(title: 'Multi-Family'),
    CheckBoxState(title: 'Efficiency'),
    CheckBoxState(title: 'Townhouse'),
    CheckBoxState(title: 'Apartment'),
    CheckBoxState(title: 'Mobile'),
    CheckBoxState(title: 'Villa'),
    CheckBoxState(title: 'Condo'),
  ];

  Widget buildGroupCheckbox(CheckBoxState checkBox) => CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: checkBox.value,
      title: Text(checkBox.title),
      onChanged: toggleGroupCheckbox);

  void toggleGroupCheckbox(bool? value) {
    if (value == null) return;
    setState(() {
      allCheckBox.value = value;
      for (final type in propertyTypes) {
        type.value = value;
      }
    });
  }

  Widget buildCheckBox(CheckBoxState checkBox) => CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: checkBox.value,
      title: Text(checkBox.title),
      onChanged: (newVal) {
        setState(() {
          checkBox.value = newVal!;
          allCheckBox.value = propertyTypes.every((element) => element.value);
        });
      });

  void storePropertyDetails() {
    propertytypes = [];
    for (final type in propertyTypes) {
      if (type.value) {
        propertytypes.add(type.title);
      }
    }
  }

  int currentStep = 0;
  final DateTime firstDate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
  final _sectionIformKey = GlobalKey<FormState>();
  final _sectionIIFormKey = GlobalKey<FormState>();
  final _sectionIIIFormKey = GlobalKey<FormState>();

  bool isCompleted = false;

  void saveSection(GlobalKey<FormState> sectionKey) {
    if (sectionKey.currentState!.validate()) {
      sectionKey.currentState!.save();

      if (sectionKey != _sectionIIIFormKey) {
        setState(() {
          currentStep += 1;
        });
      } else {
        setState(() {
          isCompleted = true;
        });
      }

      if (context.mounted) {
        return;
      }
    } else {
      return;
    }
  }

  final snackBar = const SnackBar(
    content: Text('Please select at least 1 property type'),
  );

  Widget finishScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Finished'),
          ElevatedButton(
            onPressed: () {
              var rent = Rent(
                  client: Client(
                      phone: enteredPhone,
                      name: enteredName,
                      lastName: enteredLastname,
                      email: enteredEmail),
                  tenants: enteredTenants,
                  kids: enteredKids,
                  pets: petInfo,
                  propertyType: propertytypes,
                  totalBed: bed,
                  totalBath: bath,
                  parkingSpaces: park,
                  contractTerminationDate: contractTerminationDate,
                  movingDate: movingDate,
                  maxMonthlyPayment: monthlyPay,
                  searchAreas: searchAreas,
                  additionalNotes: additionalNotes);
              widget.addRent(rent);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: Text(
              'Personal Info.',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            content: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _sectionIformKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 50,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        label: Text('Name'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return 'Must be between 1 and 50 Characters.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredName = value!;
                      },
                    ),
                    TextFormField(
                      maxLength: 50,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        label: Text('Last name'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return 'Must be between 1 and 50 Characters.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredLastname = value!;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 12,
                      decoration: const InputDecoration(
                        label: Text('Phone'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50 ||
                            value[0] == '-') {
                          return 'Must be between 1 and 12 digits.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredPhone = value!;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Email'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return 'Must be between 1 and 50 Characters.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredEmail = value!;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Tenants'),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.tryParse(value) == null ||
                                  int.tryParse(value)! <= 0) {
                                return 'Must be a valid positive number.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              enteredTenants = int.parse(value!);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 38,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Kids'),
                            ),
                            keyboardType: TextInputType.number,
                            initialValue: '0',
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.tryParse(value) == null ||
                                  int.tryParse(value)! < 0) {
                                return 'Must be a valid positive number.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              enteredKids = int.parse(value!);
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Please enter pet type and quantity'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isActive: currentStep >= 0),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            title: Text(
              'Property Req.',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            content: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                  key: _sectionIIFormKey,
                  child: Column(
                    children: [
                      buildGroupCheckbox(allCheckBox),
                      Divider(
                          color: Theme.of(context).colorScheme.onBackground),
                      ...propertyTypes.map(buildCheckBox).toList(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: '1',
                              maxLength: 2,
                              decoration: const InputDecoration(
                                label: Text('Bedr.'),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || int.parse(value) <= 0) {
                                  return 'Must be a positive number and > 0';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                bed = int.parse(value!);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '/',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: '1',
                              maxLength: 2,
                              decoration: const InputDecoration(
                                label: Text('Bath.'),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || int.parse(value) <= 0) {
                                  return 'Must be a positive number and > 0';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                bath = int.parse(value!);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '/',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                              maxLength: 2,
                              initialValue: '0',
                              decoration: const InputDecoration(
                                label: Text('Park.'),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || int.parse(value) < 0) {
                                  return 'Must be a positive number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                park = int.parse(value!);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
            isActive: currentStep >= 1),
        Step(
            title: Text(
              'Additional Info.',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _sectionIIIFormKey,
                child: Column(
                  children: [
                    InputDatePickerFormField(
                      fieldLabelText: 'Contract Exp.',
                      keyboardType: TextInputType.datetime,
                      firstDate: firstDate,
                      lastDate: lastDate,
                      initialDate: DateTime.now(),
                      errorFormatText: 'Invalid format',
                      errorInvalidText: 'Inavlid text',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputDatePickerFormField(
                      fieldLabelText: 'Moving Date',
                      keyboardType: TextInputType.datetime,
                      firstDate: firstDate,
                      lastDate: lastDate,
                      initialDate: DateTime.now(),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text('Max. Monthly Payments'),
                          prefixText: '\$'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! < 0) {
                          return 'Must be a valid positive number.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        monthlyPay = int.parse(value!);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLength: 200,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Search Areas',
                        border: OutlineInputBorder(),
                        hintText: 'Enter all possibles search areas.',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLength: 200,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Additional Notes',
                        border: OutlineInputBorder(),
                        hintText: 'Start Typing.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isActive: currentStep >= 2),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Rent Transaction'),
      ),
      body: isCompleted
          ? finishScreen()
          : Stepper(
              type: StepperType.vertical,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                if (currentStep == 0) {
                  saveSection(_sectionIformKey);
                  return;
                }
                if (currentStep == 1) {
                  storePropertyDetails();
                  if (propertytypes.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (propertytypes.isNotEmpty) {
                    saveSection(_sectionIIFormKey);
                    return;
                  }
                }
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  saveSection(_sectionIIIFormKey);
                  //Send data
                }
              },
              onStepTapped: (step) => setState(() => currentStep = step),
              onStepCancel: () {
                currentStep == 0 ? null : setState(() => currentStep -= 1);
              },
              controlsBuilder: (context, details) {
                final isLastStep = currentStep == getSteps().length - 1;
                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: Text(isLastStep ? 'Finish' : 'Next'),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      if (currentStep != 0)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: details.onStepCancel,
                            child: const Text('Back'),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

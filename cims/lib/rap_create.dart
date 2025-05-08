import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:flutter/material.dart';

class RapIdEntryScreen extends StatefulWidget {
  const RapIdEntryScreen({super.key});

  @override
  State<RapIdEntryScreen> createState() => _RapIdEntryScreenState();
}

class _RapIdEntryScreenState extends State<RapIdEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String rapId = '';
  String interviewerName = '';
  @override
  void initState() {
    super.initState();
    rapId = AppPrefs().getRapId() ?? '';
    interviewerName = AppPrefs().getInterviewerName(rapId) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter RAP Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: rapId,
                decoration: const InputDecoration(labelText: 'RAP ID'),
                onChanged: (val) => rapId = val,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: interviewerName,
                decoration:
                    const InputDecoration(labelText: 'Interviewer Name'),
                onChanged: (val) => interviewerName = val,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await AppPrefs().setRapId(rapId);
                    await AppPrefs().setInterviewerName(interviewerName, rapId);
                    Keys.rapId = rapId;

                    Navigator.pushReplacementNamed(context, '/formlist');
                  }
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

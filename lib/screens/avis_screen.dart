import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../models/avis.dart';

class AvisScreen extends StatefulWidget {
  final Destination destination;

  const AvisScreen({super.key, required this.destination});

  @override
  State<AvisScreen> createState() => _AvisScreenState();
}

class _AvisScreenState extends State<AvisScreen> {
  final _formKey = GlobalKey<FormState>();
  final _prenomCtrl = TextEditingController();
  final _commentaireCtrl = TextEditingController();
  int _note = 0;
  AutovalidateMode _autoValidation = AutovalidateMode.disabled;

  @override
  void dispose() {
    _prenomCtrl.dispose();
    _commentaireCtrl.dispose();
    super.dispose();
  }

  void _publier() {
    
    if (!_formKey.currentState!.validate()) {
      setState(() => _autoValidation = AutovalidateMode.onUserInteraction);
      return;
    }
    
    if (_note == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Choisissez une note (étoiles)')),
      );
      return;
    }

    final avis = Avis(
      auteur: _prenomCtrl.text.trim(),
      note: _note,
      commentaire: _commentaireCtrl.text.trim(),
    );
    Navigator.pop(context, avis);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Avis sur ${widget.destination.nom}')),
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Text('Votre note',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  final etoile = index + 1;
                  return IconButton(
                    onPressed: () => setState(() => _note = etoile),
                    icon: Icon(
                      etoile <= _note ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

             
              TextFormField(
                controller: _prenomCtrl,
                decoration: const InputDecoration(
                  labelText: 'Votre prénom',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().length < 2) {
                    return 'Au moins 2 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

             
              TextFormField(
                controller: _commentaireCtrl,
                maxLines: 4,
                maxLength: 300,
                decoration: const InputDecoration(
                  labelText: 'Votre commentaire',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().length < 20) {
                    return 'Au moins 20 caractères';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FilledButton.icon(
            onPressed: _publier,
            icon: const Icon(Icons.publish),
            label: const Text('Publier'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
          ),
        ),
      ),
    );
  }
}
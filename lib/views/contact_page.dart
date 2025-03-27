import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // stockage local
import 'dart:convert'; // pour encoder/décoder json

import '../widgets/app_scaffold.dart'; // scaffold avec menu etc.

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>(); // clé du formulaire
  final _nameController = TextEditingController(); // champ nom
  final _emailController = TextEditingController(); // champ email
  final _messageController = TextEditingController(); // champ message

  @override
  void dispose() {
    // nettoyage des contrôleurs
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _saveFormData() async {
    final newEntry = {
      'name': _nameController.text,
      'email': _emailController.text,
      'message': _messageController.text,
      'timestamp': DateTime.now().toIso8601String(),
    };

    final prefs = await SharedPreferences.getInstance(); // accès au stockage
    final existing =
        prefs.getString('contactMessages'); // récup anciennes données

    List<dynamic> messages = [];

    if (existing != null && existing.trim().isNotEmpty) {
      messages = jsonDecode(existing); // transforme json → liste
    }

    messages.add(newEntry); // ajoute le msg

    await prefs.setString(
        'contactMessages', jsonEncode(messages)); // sauvegarde
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await _saveFormData(); // sauvegarde locale

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message envoyé !')),
      );

      // reset form + champs
      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Contact',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // associe la clé au form
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Veuillez entrer votre nom'
                    : null,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Veuillez entrer votre email';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                    return 'Veuillez entrer un email valide';
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Veuillez entrer un message'
                    : null,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submitForm, // valide et sauvegarde
                child: const Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

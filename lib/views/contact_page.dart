import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../widgets/app_scaffold.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
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

    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString('contactMessages');

    List<dynamic> messages = [];

    if (existing != null && existing.trim().isNotEmpty) {
      messages = jsonDecode(existing);
    }

    messages.add(newEntry);

    await prefs.setString('contactMessages', jsonEncode(messages));
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await _saveFormData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message envoyé !')),
      );

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
          key: _formKey,
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
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
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
                onPressed: _submitForm,
                child: const Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

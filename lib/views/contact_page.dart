import 'package:flutter/material.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; // stockage local (clé/valeur)
import 'dart:convert'; // pour gérer JSON (encodage/décodage)
import '../widgets/app_scaffold.dart'; 

class ContactPage extends StatefulWidget {
  const ContactPage({super.key}); 

  @override
  State<ContactPage> createState() =>
      _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<
      FormState>(); // identifie le formulaire, sert pour la validation
  final _nameController = TextEditingController(); // champ nom
  final _emailController = TextEditingController(); // "" email
  final _messageController = TextEditingController(); // "" message

  @override
  void dispose() {
    // appelé quand le widget est détruit puis libère les données
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // save le message dans le stockage local (shared prefs)
  Future<void> _saveFormData() async {
    final newEntry = {
      'name': _nameController.text,
      'email': _emailController.text,
      'message': _messageController.text,
      'timestamp': DateTime.now().toIso8601String(), // date ISO
    };

    final prefs =
        await SharedPreferences.getInstance(); // récup accès au stockage
    final existing =
        prefs.getString('contactMessages'); // récup les données existantes

    List<dynamic> messages = [];

    if (existing != null && existing.trim().isNotEmpty) {
      messages = jsonDecode(existing); // convertit le json string en liste
    }

    messages.add(newEntry); // ajoute la nouvelle entrée

    await prefs.setString(
      'contactMessages',
      jsonEncode(messages), // convertit la liste complète en string JSON
    );
  }

  // appelé quand l'utilisateur press Envoyer
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await _saveFormData(); // enregistre dans shared_preferences

      ScaffoldMessenger.of(context).showSnackBar(
        // feedback visuel
        const SnackBar(content: Text('Message envoyé !')),
      );

      // reset du formulaire et des champs
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
          key: _formKey, // associe le formulaire à sa clé
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController, // champ lié à Nom
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Veuillez entrer votre nom'
                    : null, // valide : champ obligatoire
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _emailController, // champ lié à Email
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    TextInputType.emailAddress, // clavier adapté email
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Veuillez entrer votre email';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                    return 'Veuillez entrer un email valide'; // regex simple
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _messageController, // champ lié à Message
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4, // zone de texte plus grande
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Veuillez entrer un message'
                    : null,
              ),
              const SizedBox(height: 24.0),

              ElevatedButton(
                onPressed: _submitForm, // déclenche validation + sauvegarde
                child: const Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

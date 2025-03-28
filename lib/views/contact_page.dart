import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // pour ouvrir client e-mail
import '../widgets/app_scaffold.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>(); // identifie le formulaire, sert pour la validation
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

  // construit et ouvre un mailto: avec le contenu du formulaire
  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'benjamin.bonnevial@my-digital-school.org', // destinataire du message
      query: Uri.encodeFull(
        'subject=Message depuis le formulaire de votre app Flutter&body=' // objet du mail
        'Nom : ${_nameController.text}\n'
        'Email : ${_emailController.text}\n'
        'Message : ${_messageController.text}',
      ),
    );

    if (!await launchUrl(emailUri)) {
      throw Exception('Impossible d\'ouvrir le client mail'); // gestion erreur
    }
  }

  // appelé quand l'utilisateur press Envoyer
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await _sendEmail(); // ouvre le client mail

      if (!mounted) return; // évite erreurs si le widget a été démonté

      ScaffoldMessenger.of(context).showSnackBar(
        // feedback visuel
        const SnackBar(content: Text('Client mail ouvert.')),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                }, // valide : champ obligatoire
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _emailController, // champ lié à Email
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress, // clavier adapté email
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer un email valide'; // regex simple
                  }
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),

              ElevatedButton(
                onPressed: _submitForm, // déclenche validation + ouverture client mail
                child: const Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

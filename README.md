# rihla

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
## Questions de compréhension (palier 2):

# Q1. Sans Expanded, où se place l'avatar ?
L'avatar se place juste après le texte. Avec Expanded, il se place à droite

# Q2. Pourquoi prenom est final ?
Parce que sa valeur ne change pas

# Q3. Différence entre cs.primary et Colors.teal ?
cs.primary change avec le theme. Colors.teal reste toujours la meme couleur

## capture de resultat (palier 2):
![alt text](image.png)

## Questions de compréhension (palier 3):

# Q4. Pourquoi placer DecoratedBox en premier ?
Le degrade sera cache par l'image et le texte sera difficile a lire

# Q5. Que se passe-t-il si on retire ClipRRect ?
Les coins arrondis disparaissent

# Q6. Pourquoi right: 130 dans Positioned ?
Pour laisser de la place au bouton Decouvrir 

## capture de resultat (palier 3):
![alt text](image-1.png)

## Questions de compréhension (palier 4):

# Q7.	Pourquoi la Row « note / prix » a-t-elle besoin que la Column soit dans un Expanded pour que Spacer fonctionne ?
Expanded donne toute la place disponible à la Column. Spacer pousse alors le prix a droite.

# Q8.	Combien de lignes faudrait-il ajouter pour afficher une 7e destination ? Dans quel fichier ?
Ajouter une ligne dans lib/data/destinations.dart. La nouvelle destination s'affiche automatiquement.

## capture de resultat (palier 4):
![alt text](image-2.png)


## Questions de compréhension (palier 5):

# Q9. Écrivez _categorie = c; sans setState. Que se passe-t-il à l'écran ? Et en mémoire ?
La valeur de _categorie change en memoire, mais l'ecran ne se met pas a jour automatiquement

# Q10. Pourquoi _filtrees est-il un getter recalculé à chaque build() plutôt qu'une variable ?
Le getter recalcule les destinations selon la categorie choisie a chaque build(), pour afficher les bons resultats

# Q11. Pourquoi HeroBanner peut-il rester un StatelessWidget alors que l'écran change ?
Parce qu'il n'a pas d'etat qui change. Il affiche simplement la destination recue en parametre

## capture de resultat (palier 5):
![alt text](image-3.png)

## Explication de l'exercice (palier 6):
Sans ValueKey, Flutter peut associer un favori a la mauvaise destination apres un filtrage. Avec ValueKey(d.nom), chaque carte garde son propre favori, meme si la liste change

## captures de resultat (palier 6):
![alt text](image-4.png)
![alt text](image-5.png)

## captures de resultat (palier 7):
![alt text](image-6.png)
![alt text](image-7.png)
![alt text](image-8.png)
## captures de resultat (Devoir):
![alt text](image-9.png)


### TP4 :

## capture de resultat (palier1):
![alt text](image-10.png)

## captures de resultat (palier2+bouton découvrir):

# Cliquez sur le bouton « Découvrir »
![alt text](image-11.png)
# Cliquez sur la flèche retour
![alt text](image-12.png)

## Questions de compréhension (palier 2):

# Q1.	Filtrez « Désert », ouvrez Tozeur, puis revenez. Le filtre est-il conservé ? Expliquez avec la notion de pile.

Oui, le filtre est conserve, car push ouvre une nouvelle page et pop revient à la page precedente sans perdre son etat

# Q2.	Comment DetailScreen connaît-il la destination à afficher ? Quel mécanisme du TP 3 est réutilisé ?

DetailScreen reçoit la destination par son constructeur

# Q3.	Retirez clipBehavior. Que remarquez-vous quand vous touchez la carte ?

Sans clipBehavior, l'effet d'animation depasse les coins arrondis de la carte

## captures de resultat (palier3):

# messages d'erreur pour les champs vides 
![alt text](image-13.png)
# Formulaire valide
![alt text](image-14.png)

## Questions de compréhension (palier 3):
# Q1.	Que fait exactement _formKey.currentState!.validate() ? Que renvoie-t-elle ?

validate() verifie tous les champs et renvoie true si tout est correct, sinon false avec les messages d'erreur

# Q2.	inputFormatters et validator contrôlent tous deux le téléphone. Quelle est la différence de rôle ?

inputFormatters bloque les caracteres interdits pendant la saisie, tandis que validator verifie la valeur finale

# Q3.	Pourquoi faut-il appeler dispose() sur les contrôleurs ?

dispose() libere la mémoire utilisee par les controleurs quand on quitte l'ecran

## captures de resultat (palier4):

![alt text](image-15.png)
![alt text](image-16.png)
![alt text](image-17.png)

## Questions de compréhension (palier 4):

# Q1.	Pourquoi le champ date est-il en readOnly ? Que se passerait-il sinon ?

readOnly empeche l'utilisateur de taper une date manuellement et oblige a utiliser le calendrier

# Q2.	_total est un getter. Pourquoi n'a-t-on pas besoin de le mettre à jour nous-mêmes quand la formule change ?

_total se recalcule automatiquement à chaque build() quand _formule change avec setState()


## capture de resultat (palier5):

![alt text](image-18.png)

## Questions de compréhension (palier 5):

# Q1.	Que vaut reservation si l'utilisateur quitte le formulaire avec la flèche retour ?

reservation vaut null, car le bouton retour ferme le formulaire sans renvoyer de resultat

# Q2.	Retirez le test mounted : quel avertissement affiche VS Code ? Que signifie-t-il ?

VS Code affiche un avertissement car on utilise context apres un await, alors que l'ecran peut etre deja ferme. mounted verifie que l'ecran existe encore

# Q3.	Le bouton « Parfait » ferme la boîte de dialogue avec Navigator.pop. Qu'est-ce que cela vous apprend sur les boîtes de dialogue ?

Une boite de dialogue est comme un ecran : Navigator.pop() permet de la fermer et de revenir a l'ecran precedent

## capture de resultat (Checkpoint 1):
![alt text](image-20.png)
![alt text](image-19.png)

## captures des testes avec Thunder Client (palier 0):

![alt text](image-21.png)
![alt text](image-22.png)

## Questions de compréhension (palier 0):

# Q1. Quel code renvoie /destinations/99 ? À quelle famille de codes appartient-il ?
Le code est 404 Not Found. Il appartient a la famille 4xx. Cela signifie que la destination 99 n'existe pas.

# Q2.	Qui a choisi l'id de la réservation créée : vous ou le serveur ?

C'est le serveur qui a cree l'id automatiquement. Nous n'avons pas envoye d'id dans la requete POST.

# Q3.	Pourquoi la requête GET n'a-t-elle pas de corps, contrairement au POST ?

GET : sert a recuperer des donnees. On utilise l'URL pour choisir les donnees.

POST : sert a creer une nouvelle donnee. On envoie les informations dans le corps de la requete.
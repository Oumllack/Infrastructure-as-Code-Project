# Projet DevOps : Infrastructure as Code avec Terraform sur Oracle Cloud

Ce projet permet de déployer une infrastructure Oracle Cloud complète incluant un VCN, une instance Compute et un bucket Object Storage en utilisant Terraform. Il s'appuie sur l'offre "Always Free" d'Oracle Cloud qui permet de déployer gratuitement certaines ressources.

## Architecture

L'infrastructure déployée comprend :

- Un VCN (Virtual Cloud Network) avec un sous-réseau public et un sous-réseau privé
- Une instance Compute (VM.Standard.E2.1.Micro) éligible à l'offre gratuite dans le sous-réseau public
- Un bucket Object Storage privé avec versionnement et politique de cycle de vie

## Captures d'écran

Des captures d'écran du déploiement sont disponibles dans le dossier `screenshots/` :

- Création du VCN et des sous-réseaux
- Configuration de l'instance Compute
- Configuration du bucket Object Storage
- Logs de déploiement Terraform

Vous pouvez également consulter une simulation du déploiement en ouvrant le fichier `demo/index.html`.

## Avantages de l'offre gratuite d'Oracle Cloud

- 2 instances Compute VM.Standard.E2.1.Micro gratuites à vie
- Storage Object gratuit jusqu'à 10 Go
- Pas de carte de crédit requise pour certains pays
- Ressources dédiées (pas de limite de temps)

## Prérequis

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0 ou ultérieur)
- Un compte Oracle Cloud (inscription gratuite sur https://www.oracle.com/cloud/free/)
- Configuration API OCI (clés API, OCIDs)

## Installation

1. Créez un compte sur Oracle Cloud si ce n'est pas déjà fait.

2. Configurez les clés API pour l'authentification :
   ```
   mkdir -p ~/.oci
   openssl genrsa -out ~/.oci/oci_api_key.pem 2048
   chmod 600 ~/.oci/oci_api_key.pem
   openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
   ```

3. Téléchargez la clé publique dans la console Oracle Cloud (Profile > User Settings > API Keys).

4. Notez tous vos OCIDs (tenancy, user, compartment) et le fingerprint de la clé.

5. Modifiez le fichier `terraform.tfvars` avec vos informations.

6. Initialisez Terraform :
   ```
   terraform init
   ```

7. Planifiez le déploiement :
   ```
   terraform plan
   ```

8. Déployez l'infrastructure :
   ```
   terraform apply
   ```

## Utilisation

Une fois l'infrastructure déployée, vous pouvez :

- Accéder à l'instance Compute via SSH en utilisant votre clé privée et l'IP publique affichée dans les sorties
- Accéder au serveur web via l'URL http://<IP_PUBLIQUE_INSTANCE>
- Utiliser le bucket Object Storage pour stocker des fichiers de manière sécurisée via la console Oracle Cloud ou l'API

## Nettoyage

Pour supprimer toute l'infrastructure déployée :
```
terraform destroy
```

## Sécurité

Ce déploiement inclut plusieurs mesures de sécurité :
- Sous-réseau privé isolé
- Bucket Object Storage privé avec versionnement
- Groupes de sécurité configurés avec des règles minimales

## Personnalisation

Vous pouvez personnaliser ce déploiement en modifiant :
- Les variables dans le fichier `terraform.tfvars`
- Les configurations des modules dans le répertoire `modules/` 
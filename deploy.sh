#!/bin/bash

# Couleurs pour les messages
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Projet DevOps : Déploiement de l'Infrastructure as Code sur Oracle Cloud${NC}"
echo "=================================================================="

# Vérifier si Terraform est installé
if ! command -v terraform &> /dev/null
then
    echo -e "${RED}Terraform n'est pas installé. Veuillez l'installer d'abord.${NC}"
    echo "Téléchargement: https://www.terraform.io/downloads.html"
    exit 1
fi

# Vérifier si la clé API OCI existe
if [ ! -f ~/.oci/oci_api_key.pem ]; then
    echo -e "${YELLOW}La clé API OCI n'a pas été trouvée.${NC}"
    echo -e "Voulez-vous créer une nouvelle clé API ? (oui/non)"
    read answer
    
    if [ "$answer" == "oui" ] || [ "$answer" == "o" ]; then
        echo -e "${YELLOW}Création du répertoire et des clés...${NC}"
        mkdir -p ~/.oci
        openssl genrsa -out ~/.oci/oci_api_key.pem 2048
        chmod 600 ~/.oci/oci_api_key.pem
        openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
        
        echo -e "${GREEN}Clés générées avec succès !${NC}"
        echo -e "${YELLOW}Veuillez télécharger la clé publique dans la console Oracle Cloud :${NC}"
        echo -e "1. Connectez-vous à la console Oracle Cloud"
        echo -e "2. Accédez à Profil > Paramètres utilisateur > Clés API"
        echo -e "3. Cliquez sur 'Ajouter une clé API' et téléchargez le fichier ~/.oci/oci_api_key_public.pem"
        echo -e "4. Notez le fingerprint de la clé et mettez à jour votre fichier terraform.tfvars"
        
        echo -e "\n${YELLOW}Contenu de la clé publique à copier :${NC}"
        cat ~/.oci/oci_api_key_public.pem
        
        echo -e "\n${YELLOW}Appuyez sur Entrée une fois que vous avez terminé...${NC}"
        read
    else
        echo -e "${RED}Veuillez configurer les clés API OCI avant de continuer.${NC}"
        exit 1
    fi
fi

# Vérifier le fichier terraform.tfvars
if grep -q "ocid1.tenancy.oc1..aaaaaaa" terraform.tfvars; then
    echo -e "${RED}Attention : Vous devez mettre à jour les OCIDs dans le fichier terraform.tfvars avant de continuer.${NC}"
    echo -e "Voulez-vous éditer ce fichier maintenant ? (oui/non)"
    read answer
    
    if [ "$answer" == "oui" ] || [ "$answer" == "o" ]; then
        ${EDITOR:-vi} terraform.tfvars
    else
        echo -e "${RED}Veuillez mettre à jour terraform.tfvars avant de continuer.${NC}"
        exit 1
    fi
fi

# Initialiser Terraform
echo -e "\n${YELLOW}Initialisation de Terraform...${NC}"
terraform init

if [ $? -ne 0 ]; then
    echo -e "${RED}Erreur lors de l'initialisation de Terraform.${NC}"
    exit 1
fi

# Planifier le déploiement
echo -e "\n${YELLOW}Planification du déploiement...${NC}"
terraform plan -out=tfplan

if [ $? -ne 0 ]; then
    echo -e "${RED}Erreur lors de la planification du déploiement.${NC}"
    exit 1
fi

# Demander confirmation avant de déployer
echo -e "\n${YELLOW}Voulez-vous déployer l'infrastructure sur Oracle Cloud ? (oui/non)${NC}"
read answer

if [ "$answer" == "oui" ] || [ "$answer" == "o" ]; then
    echo -e "\n${YELLOW}Déploiement de l'infrastructure...${NC}"
    terraform apply tfplan
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}Erreur lors du déploiement de l'infrastructure.${NC}"
        exit 1
    else
        echo -e "\n${GREEN}Déploiement réussi !${NC}"
        echo -e "${GREEN}Pour voir les informations de sortie, exécutez : terraform output${NC}"
        
        # Afficher l'IP publique si disponible
        if terraform output instance_public_ip &> /dev/null; then
            IP=$(terraform output -raw instance_public_ip)
            echo -e "${GREEN}Vous pouvez accéder au serveur web via : http://$IP${NC}"
            echo -e "${GREEN}Vous pouvez vous connecter à l'instance via : ssh opc@$IP${NC}"
        fi
    fi
else
    echo -e "\n${YELLOW}Déploiement annulé.${NC}"
fi

exit 0 
# SCRIPT : Importation automatisée d'utilisateurs Active Directory via CSV

#Import du fichier csv
$csvFiles = "C:\Scripts\nouveaux_employes.csv"
$csvData = Import-CSV -Path $csvFiles -Delimiter "," -Encoding UTF8

#Extraction des variables du CSV
Foreach($Utilisateur in $csvData){
    $UtilisateurPrenom = $Utilisateur.Prenom
    $UtilisateurNom = $Utilisateur.Nom
    $UtilisateurLogin = "$UtilisateurPrenom.$UtilisateurNom"
    $UtilisateurEmail = "$UtilisateurLogin@Lab.fr"
    $UtilisateurMotDePasse = "Azerty77"
    $UtilisateurFonction = $Utilisateur.Fonction


    #Vérification la présence de l'utilisateur dans l'AD
    if (Get-ADUser -Filter "SamAccountName -eq '$UtilisateurLogin'")
    {
    Write-Warning "L'identifiant $UtilisateurLogin existe déjà dans l'AD"
    }
    else {
        #Création du compte utilisateur
        New-ADUser -Name "$UtilisateurNom $UtilisateurPrenom" `
                    -DisplayName "$UtilisateurNom $UtilisateurPrenom" `
                    -GivenName $UtilisateurPrenom `
                    -Surname $UtilisateurNom `
                    -SamAccountName $UtilisateurLogin `
                    -UserPrincipalName "$UtilisateurLogin@fofana.lab" `
                    -EmailAddress $UtilisateurEmail `
                    -Title $UtilisateurFonction `
                    -Path "OU=Utilisateurs,OU=fofana,DC=fofana,DC=lab" `
                    -AccountPassword (ConvertTo-SecureString $UtilisateurMotDePasse -AsPlainText -Force) `
                    -ChangePasswordAtLogon $true `
                    -HomeDirectory "\\SRV-AD\Dossier\$UtilisateurLogin" `
                    -HomeDrive "H:" `
                    -Enabled $true

        Write-Output "Création de l'utilisateur : $UtilisateurLogin ($UtilisateurNom $UtilisateurPrenom)"

        #Ajout au groupe
        if ($UtilisateurFonction) {
            Add-ADGroupMember -Identity $UtilisateurFonction -Members $UtilisateurLogin
            Write-Output "Utilisateur $UtilisateurLogin ajouté au groupe $UtilisateurFonction"
        }
    }
}
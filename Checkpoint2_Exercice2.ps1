###############################################################
#
# Q.2.1 : Pour le partage de fichier j'ai fait un clic droit sur le dossier Scripts sur la racine C: puis cliquer sur properties puis l'onglet Sharing,
#         et ensuite Share puis dans la nouvelle fenetre a nouveaux share car le parametrage par défaut est correct puis done
#         Coté client, j'ai ouvert un explorateur windows et j'ai entrer \\winserv pour aller sur les dossier partagé, une fenetre m'a demander les 
#         identifiants, j'ai mis Administrator / P@ssw0rdAdmin$!2023
#         Et j'ai copié le dossier Scripts sur la racine C: du pc client
#
###############################################################

###############################################################
#
# Main.ps1
#
# Q.2.2
# A l'execution une nouvelle fenetre powershell s'ouvre, affiche un message d'erreur et se ferme aussitot
#
# La seule ligne présente est Start-Process -FilePath "powershell.exe" -ArgumentList "C:\Temp\AddLocalUsers.ps1" -Verb RunAs -WindowStyle Maximized, le FilePath pointe vers C:\temp alors qu'il devrait aller vers C:\Scripts la bonne ligne est 
# Start-Process -FilePath "powershell.exe" -ArgumentList "C:\Scripts\AddLocalUsers.ps1" -Verb RunAs -WindowStyle Maximized
#
# Q.2.3
# -Verb RunAs sert a obtenir une elevation de privilege
#
# Q.2.4
# -WindowsStyle Maximized permet d'avoir d'ouvir une nouvelle fenetre en grand format
#
###############################################################

###############################################################

Write-Host "--- Début du script ---"

Function Random-Password ($length = 6)
{
    $punc = 46..46
    $digits = 48..57
    $letters = 65..90 + 97..122

    $password = get-random -count $length -input ($punc + $digits + $letters) |`
        ForEach -begin { $aa = $null } -process {$aa += [char]$_} -end {$aa}
    Return $password.ToString()
}

Function ManageAccentsAndCapitalLetters
{
    param ([String]$String)
    
    $StringWithoutAccent = $String -replace '[éèêë]', 'e' -replace '[àâä]', 'a' -replace '[îï]', 'i' -replace '[ôö]', 'o' -replace '[ùûü]', 'u'
    $StringWithoutAccentAndCapitalLetters = $StringWithoutAccent.ToLower()
    $StringWithoutAccentAndCapitalLetters
}

$Path = "C:\Scripts"
$CsvFile = "$Path\Users.csv"
$LogFile = "$Path\Log.log"
# Q.2.5 pour que le premier utilisateur du fichier Users.csv soit pris en compte il faut ecrire select-object -skip 1
# Q.2.7 Suppression des elements inutile pour la creation des utilisateurs "societe","fonction","service" "mail","mobile","scriptPath","telephoneNumber"
$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","description" -Encoding UTF8  | Select-Object -Skip 1

foreach ($User in $Users)
{
    $Prenom = ManageAccentsAndCapitalLetters -String $User.prenom
    $Nom = ManageAccentsAndCapitalLetters -String $User.Nom
# Q.2.6 Ajout de la variable description avec l'application de la fonction qui format l'ecriture qui n'apparaissait pas avant 
    $Description = ManageAccentsAndCapitalLetters -String $User.description
    $Name = "$Prenom.$Nom"
    If (-not(Get-LocalUser -Name "$Prenom.$Nom" -ErrorAction SilentlyContinue))
    {
        $Pass = Random-Password
        $Password = (ConvertTo-secureString $Pass -AsPlainText -Force)
        $Description = "$($user.description) - $($User.fonction)"
        $UserInfo = @{
            Name                 = "$Prenom.$Nom"
            FullName             = "$Prenom.$Nom"
# Q.2.6 Ajout de la ligne description qui n'apparaissait pas avant 
            Description          = $Description
            Password             = $Password
            AccountNeverExpires  = $true
            PasswordNeverExpires = $false
        }

        New-LocalUser @UserInfo
        Add-LocalGroupMember -Group "Utilisateur" -Member "$Prenom.$Nom"
        Write-Host "L'utilisateur $Prenom.$Nom a été crée"
    }
# Q.2.8 Ajout de la ligne avec le "else" pour la vérification de l'existance de l'utilisateur    
    else { write-host " L'utilisateur $Prenom.$Nom existe deja " }
}

pause
Write-Host "--- Fin du script ---"
Start-Sleep -Seconds 10

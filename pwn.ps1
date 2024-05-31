$activity = "Opération en cours"
$status = "Veuillez patienter..."
$url = "https://br1m4l.github.io/fakeupdate/windows/xp/update/"

for ($i = 1; $i -le 100; $i++ )
{ 
    Write-Progress -Activity $activity -Status "$i% Terminé :" -PercentComplete $i
    Start-Sleep -Milliseconds 2
    [System.Console]::Beep(1000, 100)
}

Write-Progress -Activity $activity -Status "100% Terminé :" -Completed

Write-Host "ERREUR CRITIQUE !" -ForegroundColor Red
Write-Host "Une erreur critique a été détectée dans les fichiers système (C:\Windows\System32)."  
Write-Host "Code d'erreur : 0xC0000221. Corruption détectée dans les fichiers suivants :"
Write-Host "- ntoskrnl.exe"
Write-Host "- hal.dll" 
Write-Host "- winload.exe"
Write-Host "Les fichiers système corrompus vont être supprimés."
Write-Host "Redémarrage imminent du système pour finaliser les changements."

Add-Type -AssemblyName PresentationCore,PresentationFramework

do {
    $msgBoxInput = [System.Windows.MessageBox]::Show("AVERTISSEMENT : Le système a détecté une corruption critique des fichiers système.`n`nCode d'erreur : 0xC0000221`nFichiers affectés : ntoskrnl.exe, hal.dll, winload.exe`n`nPour réparer cette erreur et éviter une instabilité du système, un redémarrage est nécessaire afin de supprimer les fichiers corrompus.`n`nVoulez-vous redémarrer maintenant ?`n`nEn cliquant sur Oui, vous serez redirigé vers une page d'aide.", 'Corruption système détectée - Redémarrage requis','YesNo','Error')

    switch ($msgBoxInput) {

      'Yes' {
        Write-Host "Redémarrage en cours..."
        Start-Sleep -Seconds 5
        Start-Process -FilePath "msedge.exe" -ArgumentList "--kiosk $url --edge-kiosk-type=fullscreen" -WindowStyle Maximized
        break
      }

      'No' {
        Write-Host "AVERTISSEMENT : Redémarrage annulé par l'utilisateur malgré l'erreur critique 0xC0000221." -ForegroundColor Red
        Write-Host "Le système risque de devenir instable. Il est fortement recommandé de redémarrer dès que possible."
      }

    }
} while ($msgBoxInput -eq 'No')

Write-Host "C'était juste une blague ! Aucun fichier n'a été supprimé ou modifié :)" -ForegroundColor Green


# フォルダをzip圧縮して保存
$folderPath = "${HOME}\MyWorks"
$getDate = (Get-Date).ToString('yyyyMMdd')
$zipFile = "MyWorks_${getDate}.zip"
$archivePath = "${HOME}\OneDrive\Backup"
if (!(Test-Path -Path "${archivePath}\${zipFile}")) {
  try {
    Compress-Archive -Path $folderPath -DestinationPath "${archivePath}\${zipFile}" -Force
    Write-Host "${zipFile} を作成しました" -ForegroundColor Green
  }
  catch {
    Write-Host "${zipFile} の作成に失敗しました" -ForegroundColor Red
  }
}

# 新しいzipファイルを3つ残し、それ以外を削除
$zipFiles = Get-ChildItem -Path $archivePath -Filter '*.zip' | Sort-Object LastWriteTime -Descending
$filesToDelete = $zipFiles | Select-Object -Skip 3
if ($zipFiles.Count -gt 3) {
  foreach ($file in $filesToDelete) {
    try {
        Remove-Item -Path $file.FullName -Force
        Write-Host ($file.Name + " を削除しました") -ForegroundColor Green
    }
    catch {
        Write-Host ($file.Name + " の削除に失敗しました") -ForegroundColor Red
    }
  }
}
# Fun��o para exibir a caixa de di�logo de sele��o de pasta
function Get-FolderDialog($initialDirectory)
{
    $folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderDialog.SelectedPath = $initialDirectory
    $dialogResult = $folderDialog.ShowDialog()

    if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK)
    {
        return $folderDialog.SelectedPath
    }

    return $null
}

# Exibe a caixa de di�logo de sele��o de pasta e obt�m a pasta selecionada
$folder = Get-FolderDialog -Title "Selecione uma pasta"
if ($folder -eq $null)
{
    Write-Host "Nenhuma pasta selecionada, por favor selecione uma pasta"
    exit
}

# Obt�m todos os arquivos .exe na pasta selecionada e os instala em fila
$files = Get-ChildItem -Path $folder -Filter *.exe | Sort-Object Name
foreach ($file in $files)
{
    Write-Host "Instalando arquivo $($file.Name) ..."
    Start-Process -FilePath $file.FullName -Wait
}

Write-Host "Arquivos instalados com sucesso!"



# Criado por Gabriel Boscaratto

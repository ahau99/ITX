﻿#
# Beschreibung :
# --------------
# FileBrowserDialogbox um genau ein (1) CSV-File zu selektieren, welches die zu erstellende OrdnerStruktur ernthalen sollte.
#


Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    Multiselect = $false # Multiple files can be chosen
	Filter = 'csv |*.csv' # Specified file types
}
 
[void]$FileBrowser.ShowDialog()

$file = $FileBrowser.FileName;

If($FileBrowser.FileNames -like "*\*") {

	# Do something 
	$FileBrowser.FileName #Lists selected files (optional)
	
}

else {
    Write-Host "Cancelled by user"
}

Write-Output $FileBrowser.FileName
﻿<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    DeploymentApp
#>

# Globale Variablen
$Global:ListOfPortalFoldersCsv



Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '978,695'
$Form.text                       = "Form"
$Form.TopMost                    = $false

$btDeploySingleReportFile        = New-Object system.Windows.Forms.Button
$btDeploySingleReportFile.text   = "Deploy File xxxx"
$btDeploySingleReportFile.width  = 136
$btDeploySingleReportFile.height  = 30
$btDeploySingleReportFile.location  = New-Object System.Drawing.Point(465,26)
$btDeploySingleReportFile.Font   = 'Microsoft Sans Serif,10'

$cbListofPortalFoldersCsv        = New-Object system.Windows.Forms.ComboBox
$cbListofPortalFoldersCsv.width  = 226
$cbListofPortalFoldersCsv.height  = 51
$cbListofPortalFoldersCsv.location  = New-Object System.Drawing.Point(219,354)
$cbListofPortalFoldersCsv.Font   = 'Microsoft Sans Serif,10'

#dieser Code manuell inzufügen um die Anzeige in der Combobox zu steuern    AHA
$cbListofPortalFoldersCsv.DataSource = [system.Collections.ArrayList]$ListOfPortalFoldersCsv
$cbListofPortalFoldersCsv.DisplayMember= 'RSFolder'


$Form.controls.AddRange(@($gbSingleReport,$gbDeployFolder,$gbCreateFoldersOnPortal,$cbListofPortalFoldersCsv))
$gbCreateFoldersOnPortal.controls.AddRange(@($btCreateDirectoryOnServer,$btChooseCsv,$tbPathToCsvFile))


$btCreateDirectoryOnServer.Add_Click({ createDirectoryFromCsv })
$btChooseCsv.Add_Click({ chooseDirectoryFile })
$btChooseReportFile.Add_Click({ chooseSingleReportFile })
$btDeploySingleReportFile.Add_Click({ deploySingleReportFile })

function deploySingleReportFile { 
#
# Beschreibung :
# --------------
# FileBrowserDialogbox um genau ein (1) ReportingFile zu selektieren
#

    Add-Type -AssemblyName System.Windows.Forms
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        Multiselect = $false # Multiple files can be chosen
    	Filter = 'BI-Files (*.rdl, *.pbix, *.xls*)|*.rdl;*.pbix;*.xls*' # Specified file types
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
    
    #Write-Output $FileBrowser.FileName
    
}

function chooseSingleReportFile { 
#
# Beschreibung :
# --------------
# FileBrowserDialogbox um genau ein (1) ReportingFile zu selektieren
#
    Add-Type -AssemblyName System.Windows.Forms
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        Multiselect = $false # Multiple files can be chosen
    	Filter = 'BI-Files (*.rdl, *.pbix, *.xls*)|*.rdl;*.pbix;*.xls*' # Specified file types
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
    
    #Write-Output $FileBrowser.FileName
}

# AHA
function fuCreateDirectoryFromCsv {      
#
# Beschreibung :
# --------------
# CSV File einlesen welches 2 spalten names "source" und "target" hat
#


# Statische Variablen
$reportServerUri = 'https://sv-rc-310.rega.local/Reportserver'
$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'

# Variablen leeren
#Clear-Variable -Name ListOfPortalFoldersCsv
Clear-Variable -Name $i1

# csv importieren
#$ListOfPortalFoldersCsv = Import-Csv -Delimiter ';' -Encoding UTF8 -Path chooseDirectoryFile -ErrorAction  'Continue'
$ListOfPortalFoldersCsv = Import-Csv -Delimiter ';' -Encoding UTF8 -Path '\\rega.local\dfs\userdata\ser-haa\Documents\Git\ITX\PowerShell\Projekt - Deployment Script\Powershell_import.csv' -ErrorAction  'Continue'

$i1=0
# importiertes cvs lesen, variablen zuweisen und neue Ordner auf Portal erstellen
ForEach ($item in $ListOfPortalFoldersCsv)
    {
     $RSFolder     = $item.RSFolder
     $FolderName   = $item.FolderName

     # Ordner auf Portal erstellen
     $i1++
     New-RsFolder -ReportServerUri $ReportServerURI -RSFolder $RSFolder -FolderName $FolderName 
     Write-Output "${i1} - Ordner : ${Foldername}                     Verzeichnis : ${RSFolder}"
    
    }

   
}

function chooseDirectoryFile { 
#
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
}

function setSourceDirectoryPath { 
    #---------------------------------------------------------------------------------------------------------------------- 
    # Step 3 - Reports in Verzeichnis auf Portal raufladen
    #----------------------------------------------------------------------------------------------------------------------
}    

function deployReportsOnServer { 
    #---------------------------------------------------------------------------------------------------------------------- 
    # Step 3 - Reports in Verzeichnis auf Portal raufladen
    #----------------------------------------------------------------------------------------------------------------------
    
    Write-Host
    ,'# ---------------------------------------------------------------------------------------------------------------'
    ,'# Step 3 - ReportServer - Neues Verzeichnis $Folder1 auf $ReportPortalUri befüllen mit Report-Artefakten'
    ,'# ---------------------------------------------------------------------------------------------------------------'
    ," "
    ,"                 Windows (lokal)                                                    Portal  "
    ," ----------------------------------------------------------         ---------------------------------------------"
    ," "
    
    $i=0
    Get-ChildItem $ReportPath -Recurse -Name -Directory  | #-include('*.xlsx','*.rdl','*.pbx')  
    
        ForEach-Object { 
            $SubFolderParentPath = '/' + ((Split-Path -Parent $_) -replace '\\', '/')
            $SubFolderNameSource = Split-Path -Leaf $_ 
            $SubFolderNameTarget = '/' + (Split-Path -Leaf $_) #-replace '\\', '/')
            $TargetPathFullRaw   = $SubFolderParentPath  + $SubFolderNameTarget
            $TargetPathFull      =  if ($TargetPathFullRaw.Contains("//")){
                                        $TargetPathFullRaw.Replace("//","/")
                                    }
                                    else {
                                        $TargetPathFullRaw
                                    }
    
        Try{
            Write-RsRestFolderContent -Path $ReportPath -RsFolder $TargetPathFull -ReportPortalUri $ReportPortalUri  -Overwrite
    
            $i=$i+1       
            Write-Host " No.${i}     ${SubFolderParentPath}"
            Write-Host " No.${i}     ${SubFolderNameSource}"
            Write-Host " No.${i}     ${TargetPathFull}"
            Write-Host " No.${i}     ${ReportPortalUri}${TargetPathFull}   "        
            Write-Host ""
    
        }
        Catch{
            Write-Host "#---------------- Error Beginn ----------------------------------------#" 
            Write-Host "# No.${i} !!!!!! An error occurred for : "
            Write-Host "# No.${i}     ${SubFolderParentPath}"
            Write-Host "# No.${i}     ${SubFolderNameSource}"
            Write-Host "# No.${i}     ${TargetPathFull}"
            Write-Host "# No.${i}     ${ReportPortalUri}${TargetPathFull}   "
        
            ,'#',$Error[0]
            Write-Host "#----------------- Error End ------------------------------------------#" 
        }
    
      }
}


function createDirectoryOnServer { 
    
    #----------------------------------------------------------------------------------------------------------------------
    # Step 2 - Ordner auf dem Portal erstellen
    #----------------------------------------------------------------------------------------------------------------------
    
    
    Try{

        Get-ChildItem $ReportPath -Recurse -Directory -Name | 
        
        ForEach-Object {
        # Split the relative input path into leaf (directory name)
        # and parent path, and convert the parent path to the target parent path
        # by prepending "/" and converting path-internal "\" instances to "/".
    
        $SubFolderParentPath = '/' + ((Split-Path -Parent $_) -replace '\\', '/')
        $SubFolderName = Split-Path -Leaf $_
    
            try{
                New-RsFolder -ReportServerUri $ReportServerURI -Path $SubFolderParentPath -FolderName $SubFolderName 
                Write-Host "Created folder ${SubFolderParentPath}/${SubFolderName}"
            }
            catch {
                # Report the specific error that occurred, accessible via $_
                Write-Host "An error occurred for ${SubFolderPath}/${SubFolder}: $_"
            }
        }
    }
    
    Catch{
        $ErrorMsgConsole = $Error[0]
    #    Write-Host 
         '# ---------------------------------------------------------------------------------------------------------------'
        ,'# Step 2 - ReportServer -  !!!! Verzeichnis schon vorhanden !!!! '
        ,'#'
        ,'# Fehlermeldung lautet wie folgt :'
        ,'#',$Error[0]
        ,'#'
        ,'# Ende der Fehlermeldung'
        ,'#----------------------------------------------------------------------------------------------------------------
         '
    }

    
} #Funktion


#----------------------------------------------------------------------------------------------------------------------
# Report server Variablen setzen
#----------------------------------------------------------------------------------------------------------------------

$reportServerUri = 'https://sv-rc-310.rega.local/Reportserver'
$ReportPortalUri = 'https://sv-rc-310.rega.local/Reports'
$Folder1         = 'TestFolder1'
$Folder1         = 'TestFolder2'
$ErrorAction     = 'Continue'
$ErrorMsgConsole = ' '
$ReportPath      = 'C:\Users\ser-haa\Downloads\SSRS_Portal_TEST' 


[void]$Form.ShowDialog()
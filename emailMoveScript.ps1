#Script to process file with email addresses.
#Script finds all emails that have "@abc.edu" and moves them to new file with datestamp
#to folder c:\temp\outgoing

# Full path of the files to process
$fileNameWithExtention = 'C:\Temp\incoming\users.csv'

#Array list that stores all records to move to new file
$movedRecordsArray = [System.Collections.ArrayList]::new()

#log file to record no file exist to process
$logNoFile = "c:\temp\outgoing\log_NoFile $(get-date -Format 'yyyyMMddHHmmss').txt" 

$logNothingToMove = "c:\temp\outgoing\log_NothingToMove $(get-date -Format 'yyyyMMddHHmmss').txt" 

#New file with moved email addresses matching criteria
$newUserFile = "c:\temp\outgoing\users.csv $(get-date -Format 'yyyyMMddHHmmss')"


#Check if file exist. If file exist process it
if ((Test-Path -Path $fileNameWithExtention -PathType leaf)){
    Write-Host " ---------------------------------------"
    Write-Host "File exist. Below are records to process "
    
    #Read all lines in file and store in an array
    $fileLines = Get-Content -Path $fileNameWithExtention 

    #Get emails with @abc.edu in them and store them in array list 
    foreach ($line in $fileLines) {
        $lineArray = $line.Split(",");
        Write-Host $lineArray[1]
       
        #if record matches criteria then to in movedRecordsArray
        if ($lineArray[1] -like "*@abc.edu*") { 
            [void]$movedRecordsArray.Add($lineArray[1])
          }
    }
}
else { #if file does not exist write to log nothing to move
New-Item -ItemType "file" -Path $logNoFile -Value "There is no file to process at $(get-date -Format 'yyyy-MMM-dd_HH-mm-ss-tt')"
Write-Host "The new file [$logNoFile] has been created"
Exit  #Stop Script since no file to process
}

#Write emails that meet correct criteria to a new file
$movedRecordsArray | Out-File -Append $newUserFile

#Write to console records moved
Write-Host "-----------------------------------------"
Write-Host "Matching records processed are below"
foreach ($line in $movedRecordsArray) {
    Write-Host $line
}

#Job ran.  Now send email with job run details.
#Declaration of variables to put in body of email
$jobRunTime = get-date -Format 'yyyy-MMM-dd_hh-mm-ss-tt'
$jobFileCount = $fileLines.Count
$jobMovedCount = $movedRecordsArray.Count

#if movedRecordArray count = 0 then create a log file saying nothing to move.
if ($movedRecordsArray.count -eq 0){
    New-Item -ItemType "file" -Path $logNothingToMove -Value "Nothing to move for records processed at $(get-date -Format 'yyyy-MMM-dd_HH-mm-ss-tt')"
    Write-Host "The new file [$logNothingToMove] has been created"
    Exit  #Stop Script since nothing go move

}

#Body of email to send if records are processed
$Body = @"
Email Move Job Run Status  
Time job ran  $($jobRunTime)
Number of records in original file  $($jobFileCount)
Numb of records moved to new file $($jobMovedCount)
"@


#Email parameters used to send email
$SMTP = "smtp.gmail.com"
#Do not change from email address as it used and setup to send emails
$From = "AsadTest540@gmail.com"
#Change to email address below to test
$To="Asadkc@gmail.com" 
$Subject = "Job run status"

$Email = New-Object Net.Mail.SmtpClient($SMTP,587)
$Email.EnableSsl = $true
$Email.Credentials = New-Object System.Net.NetworkCredential("AsadTest540@gmail.com", "rgfljcqmvplapyya");
$Email.Send($From,$To,$Subject,$Body)

# SCBHRS
Stanislaus County BHRS
This ReadMe is to document steps and process to run a job to move certain emails
to a new file.

========================================
Start section :Prequisite to running script
---------------------------------------
In order for the job to run the following two folders have to be created be running job
	C:\Temp\incoming
	C:\Temp\outgoing

Store powershell script "emailMoveScript.ps1" in c:\Temp folder

Change execution Policy to run on windows 10 if applicable.
	See Section How to run Powershell script file on windows 10 below for instructions

See section setup task scheduler 
	for instructions on setting up windows task scheduler to run script 
	in an automated time interval. 

Change To email address in script(emailMoveScript.ps1)
	Open up script in an editor.
	Line 84 of script contains variable used to store email address to send
        	to with summarry info when script is run.
	Current the To email variable is $To="Asadkc@gmail.com" 
	Change this to different appropiate email to recieve summary email

---------------------------------------
End Section  :Prequisites to running script
========================================



=========================================
Start section:  decription of what job does
------------------------------------------
If no file exist in the folder during check time.  
	A txt file called LogNofile(with time stamp of when job ran) in the the 
	folder "c:\temp\outgoing" will be created.  The file will state there is 
	not file to process and time checked. And script will stop runnining.

If file users.csv exist and there are no records to move during check time then 
	a Log file(with time stamp of when job ran) will be created in 
	the "c:\temp\outgoing" folder.

If there is a file called users.csv 2to be processed then
	file with correct email addresses will be created in the 
	"c:\temp\outgoing" folder. 
  
------------------------------------------
End section: of what job does
=========================================


=========================================
Start section:  How to run PowerShell script file on Windows 10
------------------------------------------
On Windows 10, to run a script file with the PowerShell console, you have to change
the execution policy.

To change the execution policy to run PowerShell scripts on Windows 10,
 use these steps:

1 Open Start.
2 Search for PowerShell, right-click the top result,
 and select the Run as administrator option.
3 Type the following command to allow scripts to run 
and press Enter:Set-ExecutionPolicy RemoteSigned
4. Type A and press Enter (if applicable).

------------------------------------------
End section: How to run PowerShell script file on Windows 10
=========================================
Below are steps to run task scheduler 


=========================================
Start section:  Steps to set up Task Scheduler
------------------------------------------
Open up Task scheduler.
1. Click Create Task
2. In General tab name task.
3. In Triggers tab set the frequency of when to run job to execute script.
4. In the actions tab
	Put powershel.exe in the Porgram/script textbox
	put C:\Temp\emailMoveScript.ps1 in the Add arguments(optional): textbox
5.Change options for Conditions and settings tab if needs be. 

------------------------------------------
End section: Steps to set up Task Scheduler
=========================================


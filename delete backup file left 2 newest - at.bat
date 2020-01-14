@Echo Off
SetLocal EnableDelayedExpansion
:: User Variables
:: Set this to the number of files you want to keep
Set _NumtoKeep=2
:: Parent Folder
Set _Source=D:\BEBE\backupDB
:: set backup folder to check. Must be quoted if the name contains a space
Set _Folders="Newfolder"
::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Do Not Edit below this line
::::::::::::::::::::::::::::::::::::::::::::::::::::::
Set _TFile=%temp%\tf}1{
If Exist "%_TFile%" Del "%_TFile%" 
Set _s=%_NumtoKeep%
If %_NumtoKeep%==1 set _s=single
::Echo Please wait, searching for files other than the %_s% most recent
For %%I In (%_Folders%) Do (
  PushD "%_Source%\%%~I" 
  For /F "Tokens=* skip=2 Delims=" %%J In ('Dir /A-D /B /O-D *.bak')  Do (
    If Exist "%_TFile%" (
      Echo %%~fJ>>"%_TFile%"
    ) Else (
      Echo.>"%_TFile%"
      Echo Do you wish to delete the following Files?>>"%_TFile%"
      Echo.            Name>>"%_TFile%"
      Echo %%~fJ>>"%_TFile%"
    ))
   PopD)
If Not Exist "%_TFile%" Echo No Files Found to delete & Goto :EOF
Type "%_TFile%" | More
For /F "tokens=* skip=3 Delims=" %%I In ('type "%_TFile%"') Do ( 
	echo "%%I is deleting %date% %time%">>%_Source%\%_Folders%\LogFile_%date:/=%.log || echo "error deleting %_Source%\%%~I %date% %time%">>%_Folders%\LogFile_%date:/=%.err
Del "%%I" 
echo "%%I is deleted %date% %time%">>%_Source%\%_Folders%\LogFile_%date:/=%.log || echo "error deleted %%I %date% %time%">>%_Folders%\LogFile_%date:/=%.err"
)
::forfiles -p %dump_path% -m ('Dir /A-D /B /O-D *.bak') -d -c "cmd /c && echo "%_TFile%">>logfile.log || echo "%_TFile%">>logfile.err"
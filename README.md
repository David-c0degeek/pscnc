# pscnc
Powershell script to copy files from a folder structure (recursive) into a flat destination, 
1. Changes filename if destination already has a file with the same name
1. [Optional] Checks for duplicates (rundamentary, based on hash)

Usage: 
``` Shell
fcopy -SourceDir "C:\Source\Directory\" -DestinationDir "C:\Destination\Directory\"  -CheckDuplicates 1
```

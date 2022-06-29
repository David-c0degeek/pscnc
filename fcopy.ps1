function fcopy ([string]$SourceDir, [string]$DestinationDir, [bool]$CheckDuplicates = $false) {
	$DestinationFileHashes = @()
	$AllFilesInSource = Get-ChildItem $SourceDir -Recurse | Where-Object { $_.PSIsContainer -eq $false }
	foreach ($SourceFile in $AllFilesInSource) {

		$SourceFileHash = $(Get-FileHash $SourceFile).Hash

		# Very rundamentary, checks hash to compare images. need to implement a proper way
		if ($CheckDuplicates) {
			if($DestinationFileHashes -contains $SourceFileHash){
				continue;
			}
		}

		$i = 0
		$DestinationFile = $DestinationDir + $SourceFile.BaseName + $SourceFile.extension
		while (Test-Path $DestinationFile) {
			$DestinationFile = $DestinationDir + $SourceFile.BaseName + $i + $SourceFile.extension
			$i += 1
		}
		
		Copy-Item -Path $SourceFile -Destination $DestinationFile -Verbose -Force
		$DestinationFileHashes += $SourceFileHash
	}
}

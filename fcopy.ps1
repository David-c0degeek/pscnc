function fcopy ([string]$SourceDir, [string]$DestinationDir, [bool]$CheckDuplicates = $false) {
	Get-ChildItem $SourceDir -Recurse | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object ($_) {
		$SourceFile = $_.FullName
		$i = 0
		$DestinationFile = $DestinationDir + $_.BaseName + $_.extension
		while (Test-Path $DestinationFile) {
			if ($CheckDuplicates) {
				# Very rundamentary, need to implement a proper way
				# 	1. Doesn't take into account different filenames
				# 	2. Only checks hash to compare images
				if ($(Get-FileHash $SourceFile).Hash -eq $(Get-FileHash $DestinationFile).Hash) {
					return;
				}
			}
			$DestinationFile = $DestinationDir + $_.BaseName + $i + $_.extension
			$i += 1
		}
		Copy-Item -Path $SourceFile -Destination $DestinationFile -Verbose -Force
	}
}

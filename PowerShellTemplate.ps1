<#
    .SYNOPSIS

    .DESCRIPTION
    
    .PARAMETER LogPath
    
    .INPUTS

    .OUTPUTS

    .EXAMPLE

    .LINK
#>


##-- SupportsShouldProcess adds the -confirm and -WhatIf parameters.
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory = $false, HelpMessage = 'Path to Save Log Files')]
	[ValidateScript(
		{
			if(Test-Path -Path $PSItem){
				$true
			} else {
				Throw "Unable to locate $PSItem."
			}
		}
	)]
    [string]$LogPath
)

begin{
    #-- BEGIN: Executes First. Executes once. Useful for setting up and initializing. Optional
	##-- The $PSBoundParameters.ContainsKey() will check if there's a parameter that matches that's been called
	##-- so, for example, instead of forcing a logfile each time it will only create a log file when specified
	if($PSBoundParameters.ContainsKey('LogPath')){
		if($LogPath -match '\\$'){
			$LogPath = $LogPath.Substring(0,($LogPath.Length - 1))
		}
		Write-Verbose -Message "Creating log file at $LogPath."
		#-- Use Start-Transcript to create a .log file
		#-- If you use "Throw" you'll need to use "Stop-Transcript" before to stop the logging.
		#-- Major Benefit is that Start-Transcript also captures -Verbose and -Debug messages.
		$ScriptName = & { $myInvocation.ScriptName }
		$ScriptName =  (Split-Path -Path $ScriptName -Leaf)
		Start-Transcript -Path "$LogPath\$($ScriptName.Substring(0,($ScriptName.Length) -4)).log"
	}

}
process{
    #-- PROCESS: Executes second. Executes multiple times based on how many objects are sent to the function through the pipeline. Optional.
    try{
        #-- Try the things
    } catch {
        #-- Catch the error
	    Write-Error $_.Exception.Message
	    Write-Error $_.Exception.ItemName
    }
}
end{
    # END: Executes Once. Executes Last. Useful for all things after process, like cleaning up after script. Optional.
    Stop-Transcript
}
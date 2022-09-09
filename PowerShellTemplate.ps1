<#
    .SYNOPSIS

    .DESCRIPTION
    
    .PARAMETER Path
    
    .INPUTS

    .OUTPUTS

    .EXAMPLE

    .LINK
#>



[CmdletBinding()]
param(
    [Parameter(Mandatory = $false, HelpMessage = 'Path to Save Log Files')]
    [string]$LogPath = "$env:Windir\Logs"
)

begin{
    #-- BEGIN: Executes First. Executes once. Useful for setting up and initializing. Optional
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
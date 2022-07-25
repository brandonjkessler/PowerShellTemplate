[CmdletBinding()]
param(
    [Parameter(Mandatory = $false, HelpMessage = 'Path to Save Log Files')]
    [string]$LogPath = "$env:Windir\Logs"
)

begin{
    # BEGIN: Executes First. Executes once. Useful for setting up and initializing. Optional
    if($LogPath -match '\\$'){
        $LogPath = $LogPath.Substring(0,($LogPath.Length - 1))
    }
    Write-Verbose -Message "Creating log file at $LogPath."
    # Use Start-Transcript to create a .log file
    Start-Transcript -Path "$LogPath\NameofScript.log"
}
process{
    # PROCESS: Executes second. Executes multiple times based on how many objects are sent to the function through the pipeline. Optional.
}
end{
    # END: Executes Once. Executes Last. Useful for all things after process, like cleaning up after script. Optional.
    Stop-Transcript
}
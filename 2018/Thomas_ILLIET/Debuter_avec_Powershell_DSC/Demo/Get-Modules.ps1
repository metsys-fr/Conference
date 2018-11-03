$ModuleList = @('ComputerManagementDsc', 'NetworkingDsc', 'CertificateDsc', 'xActiveDirectory')

foreach( $Module in $ModuleList ) {
    $Params = @{
        Name  = $Module
        Path  = Join-Path -Path $PSScriptRoot -ChildPath 'Modules'
        Force = $True
    }
    Save-Module @Params
}
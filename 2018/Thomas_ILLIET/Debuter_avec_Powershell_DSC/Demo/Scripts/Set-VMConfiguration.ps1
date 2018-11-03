param (
    [string]$NodeName = "localhost",
    [string]$IPAddress
)

Configuration Set-VMConfiguration {
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$NodeName = 'localhost',

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$IPAddress
    )

    Import-DscResource -ModuleName NetworkingDsc

    Node $NodeName
    {
        IPAddress NewIPv4Address
        {
            IPAddress      = "$IPAddress/24"
            InterfaceAlias = 'Ethernet'
            AddressFamily  = 'IPV4'
        }

        DnsServerAddress DnsServerAddress {
            Address        = '172.16.10.11', '172.16.10.12'
            InterfaceAlias = 'Ethernet'
            AddressFamily  = 'IPv4'
            Validate       = $False
        }

        DefaultGatewayAddress SetDefaultGateway
        {
            Address        = '172.16.10.254'
            InterfaceAlias = 'Ethernet'
            AddressFamily  = 'IPv4'
        }
    }
}

# DSC configuration data
$ConfigurationData = @{
    AllNodes = @(
        @{
            NodeName = "*"
        }
    )
}

Set-VMConfiguration -ConfigurationData $ConfigurationData -NodeName $NodeName -IPAddress $IPAddress -OutputPath $MofFolder

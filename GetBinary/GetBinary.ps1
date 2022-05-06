# Byte-to-Binary Conversion

function Get-Binary {

    param (
        [Parameter(mandatory, position=0)]
        [string] $Path
    )

    function Get-BinaryConversion {

        param (
            [Byte]$Byte,
            $Position = 7
        )

        if ($Position -lt 0) { return $null }
        
        if ($Byte -ge [math]::Pow(2, $Position)) {
            return "1" + [string]$(Get-BinaryConversion -Byte $($Byte - [math]::Pow(2, $Position)) -Position $($Position - 1))
        }

        return "0" + [string]$(Get-BinaryConversion -Byte $Byte -Position $($Position - 1))
    }

    $Results = @()

    $ByteStream = Get-Content -Path $Path -Encoding Byte
    
    foreach ($Byte in $ByteStream) {
        $Results += Get-BinaryConversion -Byte $Byte
    }

    return $Results
}

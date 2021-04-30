<#
.SYNOPSIS
    Generate a random password by real random numbers.
.DESCRIPTION
    This Script generates a random password with a default length of 20 characters. 
    The random numbers will be generate by the api of random.org. The numbers are real random numbers, because
    random.org generate them by the atmospheric noise.
.NOTES
    File Name      : Get-RandomPassword.ps1
    Author         : SeMaTh (SeMaTh+G1tHub{at]posteo.de.)
    Prerequisite   : 
    Copyright 2021 - SeMaTh
.LINK
    Script posted over:
    https://github.com/SeMaTh-Coding/Powershell-Scripts
.EXAMPLE
    Get-RandomPassword
    This get a random password with a length of 20 characters
.EXAMPLE
    Get-RandomPassword -Length 30
    This get a random password with a length of 30 characters
#>
Function Get-RandomPassword () {
    
    Param
      (
        [parameter(Mandatory=$false)]
        [Int]
        $Length = 20
      )

    $Char = @()

    foreach ($C in 33..93 | %{"$([char]$_)"}) {
        $Char += $C
    }
    foreach ($C in 97..125 | %{"$([char]$_)"}) {
        $Char += $C
    }

    $Char = $Char | Sort-Object {Get-Random}
    $Char = $Char | Sort-Object {Get-Random}
    $Char = $Char | Sort-Object {Get-Random}


    $Url = [STRING]::Format("https://www.random.org/integers/?num={0}&min=0&max=90&format=plain&col=1&base=10&rnd=new", $Length)

    $Random = [STRING]::Format("{0}", (Wget -Uri $Url).Content)

    $Password = ""
    foreach ($R in $Random.Split('')) {
        $Password = [STRING]::Format("{0}{1}", $Password, $Char[$R])
    }

    Write-Host $Password

}
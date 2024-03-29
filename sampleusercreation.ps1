if(-not (Get-Module AzureAD)){
    Install-Module -Name AzureAD -Force
}

#Log into Azure
Connect-AzureAD

$data = import-csv -Path .\Userdata.csv
$domain = "abc.onmicrosoft.com"
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "agxsFX72xwsSAi"

foreach($item in $data){
    $user = @{
        City = $item.City
        Country = $item.Country
        Department = $item.Department
        DisplayName = "$($item.GivenName) $($item.Surname)"
        GivenName = $item.GivenName
        JobTitle = $item.Occupation
        UserPrincipalName = "$($item.Username)@$domain"
        PasswordProfile = $PasswordProfile
        PostalCode = $item.ZipCode
        State = $item.State
        StreetAddress = $item.StreetAddress
        Surname = $item.Surname
        TelephoneNumber = $item.TelephoneNumber
        MailNickname = $item.Username
        AccountEnabled = $true
    }

    New-AzureADUser @user
}

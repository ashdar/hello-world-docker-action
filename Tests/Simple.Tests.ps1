
Describe 'Foo' {
    Context 'Bar' {
        It 'is true' {
            $true | Should -BeTrue
        }
        It "ain't true should force a failure" {
            $false | Should -BeTrue
        }
    }
}


Describe 'SQL Checks' {


    BeforeEach {
        # Where are we going?
        if (($ENV:TEST_SQLINSTANCE).Count -gt 0) {
            $script:ServerInstance = $ENV:TEST_SQLINSTANCE
        }
        else {
            $script:ServerInstance = 'localHost'
        }

        # Need to build a $Credential that I cn log into the SQL Server with
        $Username = 'sa'
        $Password = $env:SA_PASSWORD
        $SecureString = ConvertTo-SecureString -AsPlainText $Password -Force
        $script:cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $SecureString
    }

    Context 'Is SQL alive' {
        It 'must have a password available' {
            ($env:SA_PASSWORD).Count | Should -BeGreaterThan 0
        }

        It 'must know which server instance to use' {
            ($script:ServerInstance).Count | Should -BeGreaterThan 0
        }

        It "is $($Script:ServerInstance) connectible" {

            $Query = 'select getdate() RightNow'
            $Result = @(Invoke-Sqlcmd2 -ServerInstance $script:ServerInstance -Credential $script:Cred -Query $Query -AppendServerInstance)
            $Result.Count | Should -BeGreaterThan 0
        }
    }
}
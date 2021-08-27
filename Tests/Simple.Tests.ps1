
Describe 'Foo' {
    Context 'Bar' {
        It 'is true' {
            $true | Should -BeTrue
        }
        # It "ain't true should force a failure" {
        #     $false | Should -BeTrue
        # }
        It "ain't true should NOT force a failure" {
            $false | Should -BeFalse
        }
    }
}


Describe 'SQL Checks' {

    BeforeAll {
        # Where are we going and who are we going as?
        $Script:SqlInstance = (Invoke-Expression -Command (Join-Path -Path $PSScriptRoot -ChildPath 'Get-TestSqlInstance.ps1'))
        $SqlCredential = (Invoke-Expression -Command (Join-Path -Path $PSScriptRoot -ChildPath 'Get-TestSqlCredential.ps1'))

        $cp = @{
            SqlInstance   = $Script:SqlInstance
            SqlCredential = $SqlCredential
        }
    }

    Context 'Need good parameters to test against SQL Server' {
        It 'have a SQL credential available' {
            $SqlCredential | Should -Not -BeNullOrEmpty
        }

        It 'know which SQL Server instance is the test instance' {
            $SqlInstance | Should -Not -BeNullOrEmpty
        }
    }

    Context "Is Test Server usable" {
        It "connectible" {
            write-host $Script:SqlInstance -ForegroundColor Green

            $Query = 'select getdate() RightNow'
            $Result = @(Invoke-DbaQuery @cp -Query $Query -AppendServerInstance)
            $Result.Count | Should -BeGreaterThan 0 -Because "Test server should be up"
        }
    }
}
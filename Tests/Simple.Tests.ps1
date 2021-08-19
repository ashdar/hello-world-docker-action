
Describe "Foo" {
    context "Bar" {
        It "is true" {
            $true | Should -BeTrue
        }
        It "ain't true should force a failure" {
            $false | Should -BeTrue
        }
    }
}


Describe "SQL Checks" {

    # FIXME: This set up code would be better using BeforeAll/BeforeEach. This is just a demo.

    # Where are we going?
    if ($ENV:TEST_SQLINSTANCE) {
        $ServerInstance = $ENV:TEST_SQLINSTANCE
    }
    else {
        $ServerInstance = 'localhost'
    }

    # Need to build a $Credential that I cn log into the SQL Server with
    $Username = 'sa'
    $Password = $env:SA_PASSWORD
    $SecureString = ConvertTo-SecureString -AsPlainText $Password -Force
    $cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username,$SecureString

    Context "Is SQL alive" {
        It "is connectible" {
            $Query = "select getdate() RightNow"
            $Result = Invoke-Sqlcmd2 -ServerInstance $ServerInstance -Credential $Cred -Query $Query
            ($Result).Count | Should -BeGreaterThan 0
        }
    }
}
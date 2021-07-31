
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
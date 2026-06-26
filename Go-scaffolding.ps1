Write-Host "Setting up a Golang CLI project`n" -ForegroundColor Green

# testign if go is installed
if (Get-Command go -ErrorAction SilentlyContinue) {
    Write-Host "Go is installed! Ready to code." -ForegroundColor Green
} else {
    Write-Host "Go is NOT installed. Please download it from golang.org." -ForegroundColor Red
    exit 1
}

$projectName = Read-Host -Prompt "Please enter a project name"
Write-Host "Project will be named, $projectName" -ForegroundColor Cyan

# setting up the root project and init go
mkdir $projectName
cd $projectName
go mod init $projectName
go get github.com/spf13/cobra@latest

# making the folder structure
mkdir "cmd/$projectName"
mkdir "internal/cli"
mkdir "pkg/models"
mkdir "pkg/runner"


# setting up the main.go file 
$mainGo = "package main

import (
	`"fmt`"
	`"os`"
	`"$projectName/internal/cli`"
)

func main() {
	if err := cli.Execute(); err != nil {
		fmt.Fprintf(os.Stderr, `"Error: %v\n`", err)
		os.Exit(1)
	}
}
"
Set-Content -Path "cmd/$projectName/main.go" -Value $mainGo

# setting up the root.go file 
$rootGo = "package cli

import (
	`"fmt`"
	`"github.com/spf13/cobra`"
)

var verbose bool

// RootCmd represents the base command when called without any subcommands
var RootCmd = &cobra.Command{
	Use:   `"$projectName`",
	Short: `"$projectName is a powerful example CLI tool`",
	Long:  `"A longer description that explains your tool in depth.`",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println(`"Welcome to $projectName! Use --help to see available commands.`")
		if verbose {
			fmt.Println(`"Verbose mode is enabled.`")
		}
	},
}

func Execute() error {
	return RootCmd.Execute()
}

func init() {
	// Define your global flags here
	RootCmd.PersistentFlags().BoolVarP(&verbose, `"verbose`", `"v`", false, `"enable verbose output`")
}
"
Set-Content -Path "internal/cli/root.go" -Value $rootGo

# setting up version.go file 
$versionGo = "
package cli

import (
	`"fmt`"
	`"github.com/spf13/cobra`"
)

var versionCmd = &cobra.Command{
	Use:   `"version`",
	Short: `"Print the version number`",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println(`"$projectName v1.0.0`")
	},
}

func init() {
	// This attaches the subcommand to your main root command
	RootCmd.AddCommand(versionCmd)
}
"
Set-Content -Path "internal/cli/verion.go" -Value $versionGo

go mod tidy

Write-Host "All done 👍 👍`n" -ForegroundColor Green
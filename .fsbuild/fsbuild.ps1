<#
    FS Build - Created by Open Modding Alliance (w33zl)

    This script automates the process of building mods for Farming Simulator. The tools will take care of automatic compression to zip archive,
    automated execution of TestRunner tool, and automatic version increment.

    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    FS Build is licensed under CC BY-NC-ND 4.0 (Creative Commons Attribution-NonCommercial-ShareAlike).

    TL;DR: You are ALLOWED TO SHARE (copy and redistribute) the material in any medium or format 
    as long as you ATTRIBUTE (give appropriate credit to) the original author, 
    do NOT MAKE ANY DERIVATIVES (i.e. do not modify and re-publish this as your own work) and 
    as long as it is NOT USED FOR COMMERCIAL PURPOSES.

    DISCLAIMER: THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
    WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#>

$SCRIPT_VERSION = "0.5.0-alpha"
$DEBUG_MODE = $false
$VERBOSE_MODE = $true

function main {
    param(
        [string[]]$parameters
    )

    ShowHeader

    InitBuilder

    GetProjectConfig

    if($VERBOSE_MODE){
        Write-Host "Running script in: $currentDirectory"
    }
    

    # foreach ($param in $parameters) {
    #     Write-Host "Command line parameter: $param"
    # }

    # if ($parameters[0] -eq "run") {
    #     Write-Host "Running..."
        
    #     # Clone the array and remove the first item
    #     $clonedArray = $parameters.Clone()
    #     $clonedArray = $clonedArray[1..($clonedArray.Length - 1)]
        
    #     # Output the cloned array without the first item
    #     CommandRun -parameters $clonedArray
    # }

    $commandParameters = $parameters.Clone()
    $commandParameters = $commandParameters[1..($commandParameters.Length - 1)]

    switch ($parameters[0]) {
        # "" { CommandRun -parameters $commandParameters }
        "run" { CommandRun -parameters $commandParameters }
        "build" { CommandBuild -parameters $commandParameters }
        "install" { ShowNotImplemented -text "install" }
        "init" { CommandInit -parameters $commandParameters }
        Default { CommandHelp -parameters $commandParameters }
    }

    # Write-Host "Parameter 1: $param1"
    # Write-Host "Parameter 2: $param1"

}

function CommandRun {
    param(
        [string[]]$parameters
    )


    Write-Host "RUN COMMAND: $parameters"

    foreach ($param in $parameters) {
        Write-Host "Run Param: $param"
    }
    
}

function CommandInit {
    param(
        [string[]]$parameters
    )

    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()

    # Write-Host "INIT COMMAND: $parameters"

    # foreach ($param in $parameters) {
    #     Write-Host "Init Param: $param"
    # }
    
}

function CommandInstall {
    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()
}

function CommandHelp {
    $HELP = "HELP:"
    SuccessAndExit -Text $HELP
}

function CommandVersion {
    $VERSION = "VERSION:"
    SuccessAndExit -Text $VERSION
}


function CommandBuild {

    BumpVersion $false $true

    $outputFilename = CreateArchive $false

    if(Test-Path $outputFilename){
        SuccessAndExit -Text "Successfully created archive: $outputFilename"
    }
}

function CommandRelease {
    $outputFilename = CreateArchive $true



    if(Test-Path $outputFilename){
        SuccessAndExit -Text "Successfully created archive: $outputFilename"
    }
}

function ShowError {
    param(
        [string]$text
    )

    Write-Host "`n*** Error: $text***`n"
}

function ShowHeader {


    Write-Host "`nFS Build Tool v$SCRIPT_VERSION - Created by w33zl (Open Modding Alliance)`n"
}

function ShowWarning {
    param(
        [string]$text
    )

    Write-Host "`n*** Warning: $text***`n"
}

function ShowNotImplemented {
    param(
        [string]$text
    )

    Write-Host "`n*** Not implemented: $text ***`n"
}

function SuccessAndExit {
    param(
        [string]$text
    )

    Write-Host "`n$text`n"
    exit 0
}

function FailAndExit {
    param(
        [string]$text
    )

    Write-Host "`nFAILED: $text`n"
    exit 1
}

function AutoFindTestRunner {
    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()
}

function AutoFindGameInstall {
    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()
}

function GetCurrentModVersion {
    param (
        [bool]$showVersion = $false
    )
    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()

    

    $xmlFile = "$rootDirectory\modDesc.xml"

    # # Load the XML file
    # [xml]$xml = Get-Content $xmlFile

    # # Modify values in the XML
    # $xml.modDesc.name = "New Mod Name"
    # $xml.modDesc.version = "2.0"
    # $xml.modDesc.description = "New description for the mod"

    Write-Host "XML file: $xmlFile"
    

}

function BumpVersion {
    param (
        [bool]$isRelease = $false,
        [bool]$showVersion = $false
    )

    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()
    return 

    $xmlFile = "$rootDirectory\modDesc.xml"

    if($DEBUG_MODE) {
        Write-Host "XML file: $xmlFile"
        Write-Host "increase on build $increaseOnBuild"
        Write-Host "isRelease $isRelease"
        Write-Host "showVersion $showVersion"
    }

    if(-not(Test-Path $xmlFile)){
        if($increaseOnBuild -gt 0 -and -not $isRelease){
            ShowWarning -text "Config 'increaseOnBuild' is set to '$increaseOnBuild', but modDesc file '$xmlFile' does not exist. Cannot bump version number."
        }

        if ($increaseOnRelease -gt 0 -and $isRelease) {
            ShowWarning -text "Config 'increaseOnRelease' is set to '$increaseOnRelease', but modDesc file '$xmlFile' does not exist. Cannot bump version number."
        }

    } else {
        # Load the XML file
        [xml]$xml = Get-Content $xmlFile

        # # Modify values in the XML
        # $xml.modDesc.name = "New Mod Name"
        # $xml.modDesc.version = "2.0"
        # $xml.modDesc.description = "New description for the mod"
        $versionString = $xml.modDesc.version

        if(-not ($xml.modDesc.version -eq $null) ) {
            Write-Host "Current version: $versionString"
        }
    }

    # # Load the XML file
    # [xml]$xml = Get-Content $xmlFile

    # # Modify values in the XML
    # $xml.modDesc.name = "New Mod Name"
    # $xml.modDesc.version = "2.0"
    # $xml.modDesc.description = "New description for the mod"

    $versionString = "1.0-beta"
    # $versionString = $versionString -replace "-beta", ""

    if ($versionString -match '^[0-9.]+$') {
        # String contains only numbers and dots

        try {
            $versionParts = $versionString.Split('.')
            $incrementedParts = $versionParts | ForEach-Object { [int]$_ + 1 }
        }
        catch {
            ShowWarning -text "Invalid version number string '$versionString', automatic version increment is disabled."
        }
    
        $incrementedVersionString = $incrementedParts -join '.'
    
        Write-Host "Inc version: $incrementedVersionString"
    } else {
        ShowWarning -text "Invalid version number string '$versionString', automatic version increment is disabled."    
    }

    # $choice = Read-Host "Choose an option (A or B)"
# if ($choice -eq "A") {
#     Write-Host "Option A chosen"
# } elseif ($choice -eq "B") {
#     Write-Host "Option B chosen"
# } else {
#     Write-Host "Invalid choice"
# }


    #TODO: save currentVersion and bumpedVersion globally
    

}

function CreateArchive {
    param(
        [bool]$isRelease = $false
    )

    $blacklist = GetBlacklist $isRelease

    $includebasedirectory = $true
    $compressionLevel= [System.IO.Compression.CompressionLevel]::Optimal

    $destinationZip = $outputDirectory + "\" + $modArchiveName

    if($DEBUG_MODE) {
        Write-Host "Source Folder: $rootDirectory"
        Write-Host "Archive path: $destinationZip"
        Write-Host "Compression Level: $compressionLevel"
        Write-Host "Include Base Directory: $includebasedirectory"
        Write-Host "Blacklist: $blacklist"
    }

    if (-not (Test-Path -Path "$outputDirectory")) {
        New-Item -ItemType Directory -Path "$outputDirectory"
    }

    # Remove old zip if exists
    if (Test-Path -Path "$destinationZip") {

        try {
            Remove-Item -Force -Path "$destinationZip"
        }
        catch {
            <#Do this if a terminating exception happens#>
            ShowWarning -text "Failed to remove old archive '$destinationZip', please try removing it manually."
        }
    }


    Add-Type -Assembly 'System.IO.Compression.FileSystem'


    $rootDirectoryPath = (Get-Item $rootDirectory).FullName
    $rootDirectoryPath = Join-Path -Path $rootDirectoryPath -ChildPath ""
    
    
    try {

        $filesToInclude = Get-ChildItem -Path $rootDirectory -File -Recurse

        $archive = [System.IO.Compression.ZipFile]::Open($destinationZip, 'create')

        if($archive -eq $null){
            FailAndExit -text "Failed to create archive '$destinationZip', please try again."
        }

        foreach ($file in $filesToInclude) {
            $relativePath = $file.FullName -replace [regex]::Escape($rootDirectoryPath), ""
    
            $isBlacklisted = $false
            foreach ($bl in $blacklist) {
                $isMatch = $relativePath -match $bl
                # $isMatch = [regex]::Escape($relativePath) -match $bl
                if($isMatch) {
                    # Write-Host "BL: $bl $m"
                    $isBlacklisted = $true
                    break
                }
                
                # $relativePath = $file.FullName -replace [regex]::Escape($rootDirectoryPath), ""
            }
            
            if ( $isBlacklisted ) {
                if($VERBOSE_MODE) {
                    Write-Host "Ignoring file: $relativePath"
                }
                
            } else {
                # Write-Host "Relative Path: $relativePath"
                [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($archive, $file.FullName, $relativePath, $compressionLevel) > $null
            }
            
    
            
        }
     
        # Check if output zip exists
        if (-not(Test-Path -Path "$destinationZip")) {
            FailAndExit -text "Failed to create archive '$destinationZip', please try again."
        }
    }
    catch {
        <#Do this if a terminating exception happens#>
        FailAndExit -text "Failed to create archive '$destinationZip', please try again."
    }
    finally {
        if(!$archive -eq $null){
            $archive.Dispose()
        }
    }

    # Compress-Archive -Path $filesToInclude.FullName -DestinationPath $destinationZip -Update -CompressionLevel $compressionLevel
    

    return $destinationZip
}

function CreateBuildArchive {
    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()
}

function CreateReleaseArchive {
    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()
}


function CleanBlacklistFilePattern {
    param (
        [string]$inputString
    )

    # $inputString = "/olle\kal*le\\nisse.**"
    # $inputString = $inputString -replace "[\\]{1,2}", "/"
    # $inputString = $inputString -replace "[\*]{1,2}", "*"
    # $inputString = $inputString -replace "^./", ""
    # $inputString = $inputString -replace "^/", ""

    # Make regex friendly
    $inputString = $inputString -replace "[/]{1,2}", "\"
    # $inputString = $inputString -replace "\.", "\\\."
    # $inputString = $inputString -replace "*", "."

    $inputString = [Regex]::Escape($inputString) -replace '\\\*', '.*'
    
    return $inputString
}



function GetBlacklist {
    param(
        [bool]$isRelease = $false
    )

    # Write-Host "RELEASE: $isRelease"

    $defaultBlacklist = @("fsproj.json", "fsbuild.ps1", ".fsbuild")
    $mergedBlacklist = $defaultBlacklist + $buildBlacklist

    if ($isRelease) {
        $mergedBlacklist = $mergedBlacklist + $releaseBlacklist
    }
    # $mergedBlacklist = $mergedBlacklist + $releaseBlacklist

    if($DEBUG_MODE){
        Write-Host "Raw blacklist: $mergedBlacklist"        
    }

    $mergedBlacklist = $mergedBlacklist | Sort-Object -Unique


    # Validate and correct each string in the array
    $finalBlacklist = foreach ($item in $mergedBlacklist) {
        CleanBlacklistFilePattern -inputString $item
    }

    if($DEBUG_MODE){
        Write-Host "Final blacklist: $finalBlacklist"        
    }


    return $finalBlacklist
}

function GetGlobalConfig {
    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()
}

function GetProjectConfig {
    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()



    # $jsonFile = "C:\path\to\your\file.json"
    $jsonFile = "$rootDirectory\fsproj.json"

    # Check if the JSON file exists
    if (-not (Test-Path $jsonFile)) {
        $usage = "No 'fsproj.json' file found in the root directory. Please create one manually or use the command 'fsbuild init' to generate one auto0matically."
        FailAndExit -text $usage
        exit
    }

    # Read the JSON file and convert it to a PowerShell object
    $jsonData = Get-Content $jsonFile | ConvertFrom-Json

    # Access the values from the PowerShell object
    $name = $jsonData.name
    $version = $jsonData.version
    $increaseOnBuild = $version.increaseOnBuild
    $increaseOnRelease = $version.increaseOnRelease
    $devVersionSuffix = $version.devVersionSuffix
    $buildBlacklist = $jsonData.buildBlacklist
    $releaseBlacklist = $jsonData.releaseBlacklist

    if($DEBUG_MODE){
        Write-Host "Name: $name"
        Write-Host "Version: $version"
        Write-Host "Build Blacklist: $buildBlacklist"
        Write-Host "Release Blacklist: $releaseBlacklist"            
    }

    if(-not($null -eq $increaseOnBuild)){
        $Global:increaseOnBuild = 0
        switch ($increaseOnBuild) {
            "always" { $Global:increaseOnBuild = 1 }
            "never" {  }
            Default { ShowWarning -text "Invalid value '$increaseOnBuild' for 'increaseOnBuild' in 'fsproj.json'." }
        }
    }

    if(-not($null -eq $increaseOnRelease)){
        $Global:increaseOnRelease = 0
        switch ($increaseOnRelease) {
            "major" { $Global:increaseOnRelease = 4 }
            "minor" { $Global:increaseOnRelease = 3 }
            "patch" { $Global:increaseOnRelease = 2 }
            "ask" { $Global:increaseOnRelease = 1 }
            "never" {  }
            Default { ShowWarning -text "Invalid value '$increaseOnRelease' for 'increaseOnRelease' in 'fsproj.json'." }
        }
    }

    # Export global variables
    $Global:buildBlacklist = $buildBlacklist
    $Global:releaseBlacklist = $releaseBlacklist

}

function SaveGlobalConfig {
    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()
}

function SaveProjectConfig {
    ShowNotImplemented -text $MyInvocation.MyCommand.ToString()
}

function InitBuilder {
    $currentDirectory = $PWD.Path
    $currentDirectoryName = Split-Path $currentDirectory -Leaf
    $DEPLOY_DIR_NAME = ".fsbuild"
    $OUTPUT_DIR_NAME = "output"
    $TEMP_DIR_NAME = ".temp"
    
    if ($currentDirectoryName -eq "$DEPLOY_DIR_NAME") {
        $scriptDirectory = $currentDirectory
        $rootDirectory = Split-Path $currentDirectory -Parent
    } else {
        $rootDirectory = $currentDirectory
        $scriptDirectory = "$rootDirectory\$DEPLOY_DIR_NAME"
    }
    $modName = Split-Path $rootDirectory -Leaf
    $rawModName = $modName # Maybe needed later
    # $modName = "my_!mod-ule_123 name"
    $modName = $modName -replace "[- ]", "_"
    $modName = $modName -replace "[^\w]", ""
    
    $modArchiveName = "$modName.zip"

    $tempDirectory = "$scriptDirectory\$TEMP_DIR_NAME"
    $outputDirectory = "$scriptDirectory\$OUTPUT_DIR_NAME"
    
    # if ($modName -match "^[a-zA-Z0-9_]*$") {
    #     Write-Host "The variable contains only alphanumeric letters and underscores."
    # } else {
    #     Write-Host "The variable contains invalid characters."
    # }
    
    
    
    # Remove all characters that are not alphanumeric or underscores
    
    if($DEBUG_MODE -eq $true) {
        Write-Host "Current Directory: $currentDirectory"
        Write-Host "Directory Name: $currentDirectoryName"
        Write-Host "Root Directory: $rootDirectory"
        Write-Host "Script Directory: $scriptDirectory"
        Write-Host "Temp Directory: $tempDirectory"
        Write-Host "Output Directory: $outputDirectory"
        Write-Host "Mod Name: $rawModName"
        Write-Host "Modified module name: $modName"
        Write-Host "Mod Archive Name: $modArchiveName"
    }

    # Export variables to global scope
    $global:currentDirectory = $currentDirectory
    $global:currentDirectoryName = $currentDirectoryName
    $global:rootDirectory = $rootDirectory
    $global:scriptDirectory = $scriptDirectory
    $global:tempDirectory = $tempDirectory
    $global:outputDirectory = $outputDirectory
    $global:modName = $modName
    $global:modArchiveName = $modArchiveName

}


# New-Item -ItemType Junction -Path "$rootDirectory\dep" -Target "$deployDirectory\output"


if(!$wrapper -eq $true){
    main -parameters $args    
}



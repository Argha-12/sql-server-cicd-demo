<<<<<<< HEAD
param($Server, $Database, $User, $Password)
$ErrorActionPreference = 'Stop'

function Run($q) {
    $out = sqlcmd -S $Server -d $Database -U $User -P $Password -C -b -h -1 -W -Q $q
    if ($LASTEXITCODE -ne 0) { throw "Query failed: $q" }
    return $out
}

Run "IF OBJECT_ID('dbo.SchemaVersion') IS NULL CREATE TABLE dbo.SchemaVersion (ScriptName NVARCHAR(255) PRIMARY KEY, AppliedOn DATETIME2 DEFAULT SYSUTCDATETIME());"
$applied = Run "SET NOCOUNT ON; SELECT ScriptName FROM dbo.SchemaVersion;"

Get-ChildItem ./db/migrations/*.sql | Sort-Object Name | ForEach-Object {
    if ($applied -notcontains $_.Name) {
        Write-Host "Applying $($_.Name)"
        sqlcmd -S $Server -d $Database -U $User -P $Password -C -b -i $_.FullName
        if ($LASTEXITCODE -ne 0) { throw "Script failed: $($_.Name)" }
        Run "INSERT INTO dbo.SchemaVersion (ScriptName) VALUES ('$($_.Name)');"
    } else {
        Write-Host "Skipping $($_.Name) (already applied)"
    }
=======
param($Server, $Database, $User, $Password)
$ErrorActionPreference = 'Stop'

function Run($q) {
    $out = sqlcmd -S $Server -d $Database -U $User -P $Password -C -b -h -1 -W -Q $q
    if ($LASTEXITCODE -ne 0) { throw "Query failed: $q" }
    return $out
}

Run "IF OBJECT_ID('dbo.SchemaVersion') IS NULL CREATE TABLE dbo.SchemaVersion (ScriptName NVARCHAR(255) PRIMARY KEY, AppliedOn DATETIME2 DEFAULT SYSUTCDATETIME());"
$applied = Run "SET NOCOUNT ON; SELECT ScriptName FROM dbo.SchemaVersion;"

Get-ChildItem ./db/migrations/*.sql | Sort-Object Name | ForEach-Object {
    if ($applied -notcontains $_.Name) {
        Write-Host "Applying $($_.Name)"
        sqlcmd -S $Server -d $Database -U $User -P $Password -C -b -i $_.FullName
        if ($LASTEXITCODE -ne 0) { throw "Script failed: $($_.Name)" }
        Run "INSERT INTO dbo.SchemaVersion (ScriptName) VALUES ('$($_.Name)');"
    } else {
        Write-Host "Skipping $($_.Name) (already applied)"
    }
>>>>>>> 0d8aa05 (Add Jenkins database deployment scripts)
}
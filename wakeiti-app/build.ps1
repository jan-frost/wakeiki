# Function to run Elm
function Run-Elm {
    $elmCommand = "elm"
    if (!(Get-Command $elmCommand -ErrorAction SilentlyContinue)) {
        Write-Host "Global Elm not found. Trying to use local npm version..."
        $elmCommand = "npx elm"
    }
    
    Invoke-Expression "$elmCommand $args"
    if ($LASTEXITCODE -ne 0) {
        throw "Elm command failed with exit code $LASTEXITCODE"
    }
}

# Build Elm app
Run-Elm make src/Main.elm --optimize --output=www/elm.js

# Create index.html in Cordova www directory
$indexHtml = @"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elm Android App</title>
</head>
<body>
    <div id="elm-app"></div>
    <script src="elm.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('DOM content loaded');
            if (typeof Elm === 'undefined') {
                console.error('Elm is not defined');
                document.body.innerHTML += '<p>Error: Elm is not defined</p>';
            } else {
                console.log('Initializing Elm app');
                Elm.Main.init({
                    node: document.getElementById('elm-app')
                });
            }
        });

        document.addEventListener('deviceready', function() {
            console.log('Device ready event fired');
        }, false);
    </script>
</body>
</html>
"@

$indexHtml | Out-File -FilePath "www/index.html" -Encoding utf8

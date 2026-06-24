# Run after: gh auth login
$ErrorActionPreference = "Stop"

$repoName = "larp-kettu-plugin"

Write-Host "Creating GitHub repo and pushing..." -ForegroundColor Cyan
gh repo create $repoName --public --source=. --remote=origin --push

$owner = gh api user -q .login
Write-Host "Enabling GitHub Pages (Actions)..." -ForegroundColor Cyan
gh api "repos/$owner/$repoName/pages" -X POST -f build_type=workflow 2>$null
if ($LASTEXITCODE -ne 0) {
    gh api "repos/$owner/$repoName/pages" -X PUT -f build_type=workflow
}

$url = "https://$owner.github.io/$repoName/"
Write-Host ""
Write-Host "Done! Install URL for Kettu:" -ForegroundColor Green
Write-Host $url
Write-Host ""
Write-Host "Wait 1-2 minutes for GitHub Actions to deploy, then paste that URL in Kettu Plugins."

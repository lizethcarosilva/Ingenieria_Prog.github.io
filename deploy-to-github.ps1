# ========================================
# Script de Deploy Automatizado
# Para: IngenieriaProg - GitHub Pages
# ========================================

Write-Host "`n=== INICIANDO DEPLOY A GITHUB PAGES ===" -ForegroundColor Cyan

# 1. BUILD DEL PROYECTO
Write-Host "`n[1/5] Compilando proyecto..." -ForegroundColor Yellow
npm run build
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error en el build. Revisa los errores arriba." -ForegroundColor Red
    exit 1
}
Write-Host "✅ Build completado" -ForegroundColor Green

# 2. CREAR .nojekyll
Write-Host "`n[2/5] Creando archivo .nojekyll..." -ForegroundColor Yellow
New-Item -Path "dist\.nojekyll" -ItemType File -Force | Out-Null
Write-Host "✅ Archivo .nojekyll creado" -ForegroundColor Green

# 3. COMMIT A MAIN (OPCIONAL)
Write-Host "`n[3/5] ¿Deseas hacer commit de los cambios a main? (S/N)" -ForegroundColor Yellow
$commitMain = Read-Host "Respuesta"
if ($commitMain -eq "S" -or $commitMain -eq "s") {
    Write-Host "Escribe el mensaje del commit:" -ForegroundColor Yellow
    $commitMessage = Read-Host "Mensaje"
    git add -A
    git commit -m $commitMessage
    git push origin main
    Write-Host "✅ Cambios pusheados a main" -ForegroundColor Green
} else {
    Write-Host "⏭️  Saltando commit a main" -ForegroundColor Gray
}

# 4. DEPLOY A GH-PAGES
Write-Host "`n[4/5] Desplegando a gh-pages..." -ForegroundColor Yellow

# Navegar a dist
Set-Location dist

# Limpiar git anterior si existe
if (Test-Path .git) {
    Remove-Item -Recurse -Force .git
}

# Inicializar repo
git init | Out-Null
git checkout -b gh-pages | Out-Null

# Agregar archivos
git add -A

# Commit
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
git commit -m "Deploy: $timestamp" | Out-Null

# Configurar remote
$remoteUrl = "https://github.com/lizethcarosilva/Ingenieria_Prog.github.io.git"
git remote add origin $remoteUrl

# Push a gh-pages
Write-Host "Pusheando a GitHub..." -ForegroundColor Yellow
git push origin gh-pages --force

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error al pushear a gh-pages" -ForegroundColor Red
    Set-Location ..
    exit 1
}

# Volver al directorio raíz
Set-Location ..

# 5. LIMPIAR
Write-Host "`n[5/5] Limpiando archivos temporales..." -ForegroundColor Yellow
Remove-Item -Recurse -Force dist\.git -ErrorAction SilentlyContinue
Write-Host "✅ Limpieza completada" -ForegroundColor Green

# RESUMEN
Write-Host "`n=== ✅ DEPLOY COMPLETADO EXITOSAMENTE ===" -ForegroundColor Green
Write-Host "`nTu sitio estará disponible en:" -ForegroundColor Cyan
Write-Host "https://lizethcarosilva.github.io/Ingenieria_Prog.github.io/`n" -ForegroundColor White
Write-Host "Nota: GitHub Pages puede tardar 1-2 minutos en actualizar." -ForegroundColor Gray
Write-Host "      Presiona Ctrl+F5 en el navegador para forzar recarga.`n" -ForegroundColor Gray


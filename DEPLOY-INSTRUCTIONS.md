# 📘 Guía de Deploy - IngenieriaProg

## 🚀 Cómo Actualizar el Sitio en GitHub Pages

### Método 1: Script Automatizado (Recomendado)

```powershell
# Ejecutar en PowerShell desde la raíz del proyecto:
.\deploy-to-github.ps1
```

El script hará todo automáticamente:
- ✅ Compilar el proyecto
- ✅ Crear .nojekyll
- ✅ Hacer commit (opcional)
- ✅ Deploy a gh-pages
- ✅ Limpiar archivos temporales

---

### Método 2: Manual Paso a Paso

#### Paso 1: Hacer cambios
Edita tus archivos en `src/`

#### Paso 2: Build
```bash
npm run build
```

#### Paso 3: Crear .nojekyll
```powershell
New-Item -Path dist\.nojekyll -ItemType File -Force
```

#### Paso 4: Commit a main (opcional)
```bash
git add -A
git commit -m "Descripción de cambios"
git push origin main
```

#### Paso 5: Deploy a gh-pages
```powershell
cd dist
git init
git checkout -b gh-pages
git add -A
git commit -m "Deploy"
git remote add origin https://github.com/lizethcarosilva/Ingenieria_Prog.github.io.git
git push origin gh-pages --force
cd ..
```

#### Paso 6: Limpiar
```powershell
Remove-Item -Recurse -Force dist\.git
```

---

## 🐛 Errores Comunes y Soluciones

### Error: "Sitio sin estilos (CSS)"
**Causa**: Falta archivo `.nojekyll`
**Solución**: Asegúrate de crear el archivo `.nojekyll` en `dist/` antes del deploy

### Error: "Enlaces no funcionan (404)"
**Causa**: Base path incorrecto
**Solución**: Verifica que `astro.config.mjs` tenga: `base: '/Ingenieria_Prog.github.io'`

### Error: "Imágenes no cargan"
**Causa**: Rutas sin base path
**Solución**: Usa `${base}/nombre-imagen.png` en lugar de `/nombre-imagen.png`

### Error: "Cambios no se reflejan"
**Solución**: 
1. Espera 1-2 minutos (GitHub tarda en procesar)
2. Presiona Ctrl + F5 en el navegador (limpiar caché)
3. Verifica que pusheaste a la rama `gh-pages`

---

## 📁 Estructura del Proyecto

```
IngenieriaProg/
├── src/
│   ├── pages/          ← Aquí editas tus páginas
│   ├── layouts/        ← Layout principal
│   ├── components/     ← Componentes reutilizables
│   └── styles/         ← Estilos globales
├── public/             ← Imágenes y archivos estáticos
├── dist/               ← Archivos compilados (generados automáticamente)
├── astro.config.mjs    ← Configuración de Astro (base path)
└── package.json        ← Scripts y dependencias
```

---

## ⚙️ Configuración de GitHub Pages

1. Ve a: https://github.com/lizethcarosilva/Ingenieria_Prog.github.io/settings/pages
2. Configura:
   - **Source**: Deploy from a branch
   - **Branch**: gh-pages
   - **Folder**: / (root)
3. Guarda los cambios

---

## 🔗 URLs del Sitio

- **Producción**: https://lizethcarosilva.github.io/Ingenieria_Prog.github.io/
- **About**: https://lizethcarosilva.github.io/Ingenieria_Prog.github.io/about
- **Structure**: https://lizethcarosilva.github.io/Ingenieria_Prog.github.io/structure
- **Financial**: https://lizethcarosilva.github.io/Ingenieria_Prog.github.io/financial
- **Contact**: https://lizethcarosilva.github.io/Ingenieria_Prog.github.io/contact

---

## 📝 Notas Importantes

1. **Siempre** usa `${base}/ruta` para enlaces internos
2. **Siempre** crea `.nojekyll` antes del deploy
3. **NO** uses rutas absolutas como `/about` directamente
4. El archivo `.nojekyll` es crítico para que funcione Tailwind CSS
5. GitHub Pages tarda 1-2 minutos en actualizar después del deploy

---

## 💡 Tips

### Ver el sitio localmente antes de publicar:
```bash
npm run dev
# Visita: http://localhost:4321/Ingenieria_Prog.github.io/
```

### Ver preview de producción:
```bash
npm run build
npm run preview
```

### Comandos útiles:
```bash
# Desarrollo
npm run dev

# Build
npm run build

# Preview
npm run preview

# Deploy (con script)
.\deploy-to-github.ps1
```

---

## 🆘 Soporte

Si encuentras problemas:
1. Verifica que el base path esté configurado
2. Asegúrate de que existe el archivo .nojekyll
3. Espera 1-2 minutos después del deploy
4. Limpia el caché del navegador (Ctrl + F5)
5. Verifica en GitHub que la rama gh-pages exista

---

**Última actualización**: 9 de octubre de 2025


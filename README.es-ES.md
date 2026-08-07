

# 🔐 Codificador de Enlaces Seguros en Farsi - Versión de Escritorio

Una aplicación de escritorio elegante, segura y completamente offline para cifrar direcciones web a texto en farsi utilizando cifrado AES-256-GCM.

![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux-blue)
![License](https://img.shields.io/badge/License-MIT-yellow)
![Encryption](https://img.shields.io/badge/Encryption-AES--256--GCM-red)

---

## ✨ Funcionalidades

### 🔒 Seguridad

- **Cifrado AES-256-GCM** (estándar militar)
- **Derivación de clave PBKDF2-SHA256** (100,000 iteraciones)
- **IV aleatorio** para cada cifrado
- **Cifrado autenticado** (prevención de manipulaciones)
- **Protección con contraseña opcional**

### 🎨 Interfaz de Usuario

- **Diseño moderno** con CustomTkinter
- **Tema claro/oscuro** intercambiable
- **Efectos visuales tipo cristal**
- **Animaciones fluidas**
- **Diseño responsivo**

### 🌐 Capacidades

- **Dos modos**: cifrado y descifrado
- **Codificación en farsi** (Base-50 con 50 caracteres farsi)
- **Completamente offline** - no requiere conexión a internet
- **Copiar al portapapeles**
- **Abrir el enlace descifrado** directamente en el navegador
- **Multiplataforma** (Windows y Linux)

---

## 📋 Requisitos

- **Python 3.8 o superior**
- **pip** (gestor de paquetes de Python)

### Requisitos del Sistema

- **Windows**: Windows 10/11 (64 bits)
- **Linux**: Ubuntu 20.04+ o equivalente
- **RAM**: mínimo 512 MB
- **Espacio en disco**: 100 MB

---

## 🚀 Instalación

### Método 1: Ejecutar desde el código fuente (recomendado para desarrollo)

#### 1. Descargar o clonar este repositorio

```bash
git clone https://github.com/yourusername/secure-persian-link-encoder.git
cd secure-persian-link-encoder/desktop
```

#### 2. Instalar dependencias

```bash
pip install -r requirements.txt
```

#### 3. Ejecutar la aplicación

```bash
python main.py
```

### Método 2: Crear un archivo ejecutable independiente

#### Windows:

```batch
build_windows.bat
```

#### Linux:

```bash
chmod +x build_linux.sh
./build_linux.sh
```

El archivo ejecutable se generará en la carpeta `dist/`.

---

## 📖 Guía de Uso

### 🔒 Cifrar un enlace

1. **Abre la pestaña de cifrado**
2. **Introduce tu enlace** (por ejemplo, `https://example.com/secret`)
3. **Opcional**: Introduce una contraseña para mayor seguridad
4. **Haz clic en "🔒 Cifrar enlace"**
5. **Copia el texto en farsi** y envíalo por mensaje de texto (SMS)

### 🔓 Descifrar texto en farsi

1. **Abre la pestaña de descifrado**
2. **Pega el texto en farsi**
3. **Opcional**: Introduce la contraseña (si se utilizó durante el cifrado)
4. **Haz clic en "🔓 Descifrar enlace"**
5. **Copia el enlace** o **ábrelo directamente en el navegador**

---

## 🎯 Casos de Uso

### Caso 1: Enviar un enlace seguro por SMS

```
Problema: Los enlaces en SMS pueden ser interceptados o registrados
Solución: Cifrar enlace → Enviar texto en farsi → El destinatario descifra
```

### Caso 2: Enlaces protegidos con contraseña

```
Cifrar con contraseña → Enviar texto por SMS
                      → Enviar contraseña por WhatsApp
El destinatario necesita ambos para acceder al enlace
```

### Caso 3: Ofuscar enlaces sensibles

```
Oculta los enlaces sensibles a la vista de todos
El texto en farsi parece un texto aleatorio para personas externas
```

---

## 🔐 Notas de Seguridad

### Sin contraseña:

- ✅ Rápido y cómodo
- ✅ Adecuado para enlaces no sensibles
- ⚠️ Cualquier persona con esta herramienta puede descifrarlo
- **Uso recomendado**: Enlaces públicos, compartición temporal

### Con contraseña:

- ✅ Máxima seguridad
- ✅ Solo el titular de la contraseña puede descifrarlo
- ⚠️ Debes compartir la contraseña de forma segura (por un canal separado)
- **Uso recomendado**: Enlaces sensibles, datos privados

### Mejores prácticas:

1. **Utiliza siempre enlaces HTTPS** para sitios sensibles
2. **Utiliza contraseñas fuertes** (12+ caracteres, mayúsculas y minúsculas, números, símbolos)
3. **Comparte la contraseña por separado** (SMS para el texto + WhatsApp para la contraseña)
4. **Enlaces de un solo uso**: Elimínalos después de usarlos
5. **Mantén el software actualizado**

---

## 🏗️ Arquitectura

### Proceso de cifrado:

```
Entrada de enlace
   ↓
[Contraseña opcional] → PBKDF2 (100k iteraciones) → Clave de 32 bytes
   ↓
Cifrado AES-256-GCM
   ↓
[Versión][Salt][IV][Texto cifrado+Etiqueta de autenticación]
   ↓
Codificación Base-50 en farsi
   ↓
Salida de texto en farsi
```

### Formato de datos:

```
[1 byte]    Versión
[16 bytes]  Salt (para derivación de clave)
[12 bytes]  IV (Vector de inicialización)
[N bytes]   Texto cifrado + Etiqueta de autenticación
```

### Alfabeto farsi (50 caracteres):

```
32 letras farsi: ابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی
10 dígitos farsi:  ۰۱۲۳۴۵۶۷۸۹
8 caracteres adicionales: آأإؤئة
Total: 50 caracteres para codificación Base-50
```

---

## 📁 Estructura del Proyecto

```
desktop/
├── main.py                 # Programa principal de la interfaz
├── crypto_core.py          # Motor de cifrado
├── requirements.txt        # Dependencias de Python
├── build_windows.bat       # Script de compilación para Windows
├── build_linux.sh          # Script de compilación para Linux
├── README.md               # Documentación en inglés
├── README_FA.md            # Documentación en farsi
└── icon.ico                # Icono de la aplicación (opcional)
```

---

## 🧪 Pruebas

Ejecutar las pruebas internas:

```bash
python crypto_core.py
```

Este comando ejecuta 4 pruebas:

1. ✅ Cifrado/descifrado sin contraseña
2. ✅ Cifrado/descifrado con contraseña
3. ✅ Detección de contraseña incorrecta
4. ✅ Gestión de enlaces largos

---

## 🛠️ Solución de Problemas

### Error: "Module not found"

```bash
# Reinstalar dependencias
pip install -r requirements.txt --force-reinstall
```

### Error: "Failed to execute script"

```bash
# Ejecutar en la terminal para ver el error exacto
python main.py
```

### Error: "Cannot build executable"

```bash
# Asegúrate de que PyInstaller está instalado
pip install pyinstaller --upgrade
```

### Linux: "Permission denied"

```bash
# Hacer los scripts ejecutables
chmod +x build_linux.sh
chmod +x "dist/Secure Persian Link Encoder"
```

---

## 🌍 Internacionalización

Actualmente soporta:

- 🇬🇧 Inglés (interfaz de usuario)
- 🇮🇷 Farsi (salida codificada)

¿Quieres añadir más idiomas? ¡Contribuye!

---

## 🤝 Contribución

¡Las contribuciones son bienvenidas! Por favor, envía un Pull Request.

### Cómo contribuir:

1. Haz un Fork del repositorio
2. Crea tu rama de característica (`git checkout -b feature/AmazingFeature`)
3. Haz commit de tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Haz push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📝 Licencia

Este proyecto se publica bajo la licencia MIT - texto completo:

```
Licencia MIT

Derechos de autor (c) 2025 Tu Nombre

Se concede permiso, libre de cargos, a cualquier persona que obtenga una copia
de este software y de los archivos de documentación asociados (el «Software»),
para utilizar el Software sin restricción, incluyendo sin limitación los derechos
a usar, copiar, modificar, fusionar, publicar, distribuir, sublicenciar y/o
vender copias del Software, y a permitir a las personas a las que se les proporcione
el Software que lo hagan, sujetos a las siguientes condiciones:

El aviso de derechos de copyright anterior y este aviso de permiso se incluirán
en todas las copias o partes sustanciales del Software.

EL SOFTWARE SE PROPORCIONA «TAL CUAL», SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O
IMPLÍCITA, INCLUYENDO PERO NO LIMITÁNDOSE A GARANTÍAS DE COMERCIALIZACIÓN,
APTITUD PARA UN PROPÓSITO EN PARTICULAR Y NO INFRACCIÓN. EN NINGÚN CASO LOS
AUTORES O TITULARES DE LOS DERECHOS DE AUTOR SERÁN RESPONSABLES DE NINGUNA
REIVINDICACIÓN, DAÑO U OTRA RESPONSABILIDAD, YA SEA EN UNA ACCIÓN DE CONTRATO,
AGRAVIO O CUALQUIER OTRA, QUE SURJA DE, FUERA DE O EN RELACIÓN CON EL SOFTWARE
O EL USO U OTROS TRATOS EN EL SOFTWARE.
```

---

## 📧 Contacto

- **GitHub**: [@amirk1998](https://github.com/amirk1998)
- **Correo electrónico**: amirk1998.pv@gmail.com

---

## 🙏 Agradecimientos

- **CustomTkinter** - Framework de interfaz de usuario moderno
- **Cryptography.io** - Biblioteca de cifrado segura
- **Python** - El lenguaje de programación increíble

---

## 📊 Historial de Versiones

### Versión 1.0.0 (2025-01-01)

- ✅ Lanzamiento inicial
- ✅ Cifrado AES-256-GCM
- ✅ Codificación en farsi
- ✅ Tema claro/oscuro
- ✅ Soporte para Windows y Linux

---

## 🔮 Hoja de Ruta

- [ ] Soporte para macOS
- [ ] Aplicación móvil (Android/iOS)
- [ ] Generación de códigos QR
- [ ] Cifrado por lotes
- [ ] Importar/Exportar configuraciones
- [ ] Interfaz de usuario multilingüe
- [ ] Alfabeto farsi personalizado
- [ ] Funcionalidad de enlaces con vencimiento

---

## ⚠️ Descargo de Responsabilidad

Este software se proporciona únicamente con fines educativos y legales. Los autores
no se hacen responsables de ningún mal uso o actividades ilegales realizadas con
este software. Asegúrate siempre de contar con la autorización para cifrar
y compartir los datos con los que trabajas.

---

## 💡 Consejos y Trucos

### Consejo 1: Cambio rápido de tema

¡Haz clic en el interruptor del tema para cambiar instantáneamente entre modo claro/oscuro!

### Consejo 2: Atajos de teclado

- `Ctrl+C` después de hacer clic en el botón de copiar
- `Tab` para moverte entre campos
- `Enter` después de escribir el enlace para cifrar rápidamente

### Consejo 3: Compartir contraseña de forma segura

- Cifra el enlace con una contraseña
- Envía el texto en farsi por SMS
- Envía la contraseña por Signal/WhatsApp
- Elimina los mensajes después de que el destinatario descifre

### Consejo 4: Pruebas

¡Siempre prueba el cifrado/descifrado con un enlace de prueba antes de usarlo con enlaces importantes!

---

Creado con ❤️ por Amirhossein Kaveh

🔐 **¡Mantente seguro, mantente privado!**

# LIVELIVE Lab — v0.7 «Reels»

Instrumento para descubrir, guardar y exportar piezas de la identidad LIVELIVE
(medio de entretenimiento y eSports) en formatos de redes. La interfaz está en inglés.

## Correr

```sh
cd livelive-lab
python3 -m http.server 8777
# abrir http://127.0.0.1:8777/lab/index.html
```

- Es un solo archivo, `lab/index.html`, más el muxer de MP4 en `lab/vendor/`.
- No hay build ni dependencias.
- Solo la fuente de la interfaz (Oswald) viene de Google Fonts. Las letras de la
  marca se construyen en el propio código, no dependen de ninguna fuente.

## Idea

Cada columna de la marca es una **bobina** de letras. La ventana de cada
columna se divide en cajas: una, dos o tres líneas. Las líneas divisorias se
mueven y las cajas cambian de alto. Las letras nunca se escalan: se vuelven a
construir a cada altura. LIVE/LIVE es el estado de reposo.

## Reglas tipográficas

### 1. Construcción: nada se escala

- **Medidas por columna.** El ancho de cada signo y el grosor de trazo son fijos
  para cada ancho de columna `u`. Salen de Slide 2 (a 3840 px, `u` = 178 px):

  | Medida | Valor | En Slide 2 |
  |---|---|---|
  | Asta | 0,124 u | 22 px |
  | Brazo | 0,112 u | 20 px |
  | Diagonal (trazo perpendicular) | 0,118 u | 21 px |
  | Altura natural | 0,79 u | 140 px |
  | Línea del marco | 0,09 u | 16 px |

- **Qué puede alargarse.** Cada signo tiene segmentos concretos:
  - las astas rectas;
  - los contraformas entre brazos (E, F, H, B, P, R);
  - los tramos rectos de las curvas (O, C, G, D, U, J, S);
  - las diagonales (V, A, M, N, W, X, Y, K, Z, 7, /), que mantienen constante
    su **trazo perpendicular**, no su ancho horizontal.
- **S** sigue la estructura de Akzidenz MdCn: arco superior, lado izquierdo y
  terminal derecho, espina, lado derecho y terminal izquierdo, arco inferior.
  Arcos (0,28 × ancho) y espina (0,85 × ancho) quedan fijos. Al crecer, se
  alargan los **cuatro** tramos rectos, así los terminales crecen con los lados.
- **A**:
  - la parte superior es plana (0,36 × ancho);
  - la barra está baja, con su borde inferior al 18 % de la altura, y mantiene
    su grosor;
  - crece debajo de la barra y en la contraforma.
- **C** tiene terminales rectos que crecen con la letra. La apertura es el 36 %
  del tramo recto.
- **S (v0.7):** el terminal inferior izquierdo sube solo la mitad de su tramo
  recto. Así la curva inferior se lee continua, sin el corte horizontal en el
  centro.
- **J (v0.7):**
  - tiene el ancho de O y U (0,36 u);
  - el gancho es redondo, a todo el ancho, con profundidad fija (0,83 × ancho ≈
    0,30 u) y terminal cortado recto;
  - crece solo el asta;
  - su mínimo pasa a 0,64 u.
- **Y (v0.7):**
  - como en Akzidenz, los brazos mantienen su tamaño (hasta 1,3 × ancho) y
    crece solo el asta;
  - los bordes exteriores de los brazos llegan exactamente a los bordes del
    asta, recortados a la silueta de la Y;
  - el vértice y el asta comparten eje a cualquier altura, sin escalón lateral.
- **V, A, M:** las diagonales también se recortan a la silueta del signo, así
  no hay escalones en pies ni vértices.

### 2. Rango de altura por signo

Cada signo conserva su construcción entre una altura mínima y una máxima
(`RANGE` en el código, en unidades `u`). Por defecto el rango es 0,50–6 u:

| Signo | Rango | Signo | Rango | Signo | Rango |
|---|---|---|---|---|---|
| A | 0,72–6 | S | 0,60–5 | G | 0,58–6 |
| J | 0,64–6 | | | | |
| C | 0,52–6 | Q | 0,56–6 | B | 0,62–6 |
| R | 0,58–6 | M, W | 0,56–6 | K | 0,54–6 |
| Y | 0,55–6 | 2, 5, 6, 9 | 0,62–6 | 3, 8 | 0,64–6 |
| ? | 0,62–3,5 | `-` `+` `.` `:` `'` | 0,16–0,40 mín. | # | 0,50–6 |

- **Por encima del máximo,** el signo se queda en su máximo, centrado.
- **Por debajo del mínimo,** el signo no puede construirse. Por eso el
  movimiento y la composición nunca dejan una caja más baja que lo que su signo
  necesita.

### 3. Espacio seguro fijo

- **Medida.** Cada caja (el interior blanco de un marco, o el bloque entero)
  tiene una banda vacía de **0,20 u** arriba y otra abajo. Los márgenes laterales
  son de 0,08 u.
- **Siempre igual.** La medida no cambia con el signo, el alto de la caja ni el
  momento de la animación. El signo vive solo entre las bandas, centrado.
- **Guía.** El botón **Safe area** del dock muestra las bandas rayadas en azul.
  Si una caja no alcanzara para su signo, se vería en rojo, pero el sistema no
  lo permite. Es solo una guía de revisión: nunca se exporta.

### 4. Movimiento

- **Tamaño mínimo de caja.** Cada caja mide al menos: altura mínima del signo
  (más acento, si tiene) + 2 × 0,20 u + bordes.
- **Amplitud.** La de cada columna se calcula una sola vez para no bajar nunca
  de ese mínimo. No hay recortes a mitad del movimiento: ninguna caja colapsa y
  ninguna letra aparece, desaparece ni se corta.
- **Motores:**
  - *Still:* sin movimiento.
  - *Pulse:* un pulso suave cada dos tiempos.
  - *Wave:* onda que viaja entre columnas.
  - *Roll:* barrido; con textos de varias filas, las filas siguientes entran en
    cada compás.
- **Con una línea** no hay divisor: las cajas quedan quietas y las letras
  respiran dentro de su rango.

Verificado en 104.760 dibujos en movimiento (1, 2 y 3 líneas; Pulse, Wave y
Roll; tres formatos): ninguna letra omitida, el margen más ajustado fue 1,03
veces el mínimo, y la banda fue siempre 0,20 u.

### 5. Líneas y formatos

- **1, 2 o 3 líneas** se eligen en *Layout*. Dos líneas es el lockup de
  referencia. Tres líneas alternan marco / bloque / marco.
- **Si el lienzo es bajo para sus líneas,** la marca se hace más angosta; los
  signos nunca se achican.

## Uso

- **Barra superior:**
  - `FORMAT` (1:1 · 4:5 · 9:16 · 16:9).
  - `SPACE` → **Randomize** (contorno), junto a Mutate, Variations y Save.
  - **Download as**, el único botón lleno.
- **Logo LIVELIVE:** abre el panel del **brand book** (borrador). El PDF se
  descarga solo desde su botón, nunca con el clic en el logo.
- **Dock sobre el lienzo:** Text, Saved (con contador), Shortcuts y Safe area.
  Los paneles flotan y el lienzo se reacomoda al espacio libre.
- **Text:**
  - espacio = fila siguiente;
  - `_` = celda vacía;
  - de 4 a 12 columnas.
- **Variations:**
  - clic en una card = seleccionar y editar;
  - ícono de copia = código `LL1z.…` que reproduce la pieza exacta.
- **Saved:**
  - miniaturas con nombre, formato, líneas e id corto;
  - clic para abrir, íconos para copiar o borrar;
  - un código se abre con *Open* o pegándolo con ⌘V.
- **Paleta:**
  - los cuatro primarios, cada uno con su tinte, su tono y su sombra;
  - los tintes están disponibles como fondos;
  - la interfaz no usa magenta ni transparencias en los controles.

## Exportación

- **Download as → PNG:** fotograma al tamaño exacto del formato (1080×1080,
  1080×1350, 1080×1920, 1920×1080).
- **Download as → MP4:**
  - H.264 High, `yuv420p`, 30 fps, de 1 a 30 s.
  - Se codifica con WebCodecs y se empaqueta con mp4-muxer 5.2.1 (MIT), más
    rápido que el tiempo real.
  - Si el navegador no tiene WebCodecs, usa el grabador MP4 del propio
    navegador; si tampoco puede hacer MP4, guarda WebM con el comando para
    convertirlo.
- **Qué exporta:** siempre la versión seleccionada, o la actual si no hay
  selección.
- **Verificado (v0.6):** PNG y MP4 en los cuatro formatos, con 1, 2 y 3
  líneas. `ffprobe` da h264 High, `yuv420p`, 30/1, 90 frames y 3,000 s, y
  todos decodifican sin errores.

| Tecla | Acción |
|---|---|
| `Space` | Randomize (en Variations: lote Far) |
| `M` | Mutate (en Variations: lote Near) |
| `G` | Variations |
| `S` | Save |
| `E` / `V` | Descargar PNG / MP4 |
| `P` | Pausa |
| `←` `→` | Avanzar la bobina |
| `1`–`4` | Formato |
| `T` / `Esc` | Texto |
| `+` `−` `0` | Zoom de la vista previa |

## Brand book

- **Archivos:** `lab/brandbook/livelive-brand-book-DRAFT.pdf`, 8 páginas A4
  apaisadas, generado desde `lab/brandbook/index.html`. Cada ejemplo lo dibuja
  el mismo motor del Lab.
- **Regenerar:** `./scripts/brandbook.sh`, con el servidor local corriendo.
- **Tipografías del PDF:** solo Oswald e Inter (ambas SIL OFL, cargadas desde
  Google Fonts). No se usa la fuente del sistema, para no embeber fuentes
  propietarias en el PDF.
- **Estado:** es un **borrador para revisión**.
  - El contenido de marca requiere aprobación.
  - Los tintes, tonos y sombras son una propuesta.
  - La fuente Akzidenz-Grotesk Condensed no tiene licencia web confirmada.

## Material local (no publicar)

- **La fuente** `lab/public/*.pfb` y `lab/local-fonts/` son solo para
  comparación local. Hay una copia WOFF2, los contornos y
  `type-compare.html`. La licencia de Adobe/Berthold no está confirmada.
- **Capturas y referencias:** `lab/verify/` y `references/` no se publican.
- **Credenciales:** `.wrangler/` contiene datos de la cuenta de Cloudflare.
- Todo esto está en `.gitignore`.

## Repositorio público

Archivos que entran:

```
.gitignore
README.md                                   ← presentación breve (inglés)
lab/index.html                              ← el instrumento
lab/README.md                               ← esta documentación
lab/vendor/mp4-muxer.js                     ← MIT
lab/vendor/mp4-muxer.LICENSE
lab/brandbook/index.html                    ← fuente del brand book
lab/brandbook/livelive-brand-book-DRAFT.pdf ← borrador generado
scripts/build.sh                            ← arma dist/ con lista blanca
scripts/brandbook.sh                        ← regenera el PDF
wrangler.jsonc                              ← proyecto Cloudflare Pages «livelive» (sin credenciales)
```

- **Quedan fuera:** `*.pfb`, `lab/public/`, `lab/local-fonts/`, `lab/verify/`,
  `references/`, `dist/`, `.wrangler/` y `.DS_Store`.
- **Licencias:** ver «License status» en el `README.md` de la raíz. El código no
  tiene licencia abierta (todos los derechos reservados hasta que se decida);
  la marca LIVELIVE y el brand book no se licencian.

## Publicación

- **Proyecto:** Cloudflare Pages `livelive`, igual que `okemo.estudioblanco.org`.
- **Para publicar:**

```sh
./scripts/build.sh
npx wrangler pages deploy dist --project-name=livelive --branch=main --commit-dirty=true
```

- **En línea:** https://livelive.estudioblanco.org sirve la v0.7 (DNS: CNAME
  `livelive` → `livelive-7i7.pages.dev`, con proxy). No se tocan el sitio
  principal ni otros subdominios.

## Pendiente

- Dígitos (2, 3, 4, 5), K, `?` y acentos: todavía no están reconstruidos con la
  lógica de franjas de Akzidenz, como sí lo están S, A, C, G, J y Y.
- Definir la licencia web de Akzidenz-Grotesk Condensed y el peso usado en las
  láminas.
- Aprobar el brand book y la propuesta de tintes, tonos y sombras.
- Audio real como fuente del pulso; bloquear parámetros antes de Randomize;
  arrastrar las líneas en el lienzo.

## Changelog

- **v0.7**
  - S con terminal inferior más bajo y curva continua.
  - J con gancho a todo el ancho y profundidad fija; mínimo 0,64 u.
  - Y con brazos fijos, unión alineada y sin escalón.
  - Diagonales recortadas a la silueta.
  - SPACE / Randomize junto a Mutate.
  - Verificación: barrido continuo de mínimo a máximo (240 pasos) sin cortes;
    86.400 signos en movimiento con SAJY, ninguno omitido.
  - Brand book con Inter (OFL) en lugar de la fuente del sistema.
  - Publicada en livelive.estudioblanco.org.
- **v0.6**
  - S y A reconstruidas.
  - Diagonales con trazo perpendicular constante; C con terminales que crecen.
  - Rangos de altura por signo, sin escalado.
  - Espacio seguro fijo de 0,20 u.
  - Composiciones de 1, 2 y 3 líneas.
  - Brand book (borrador) desde el logo.
  - Saved con miniaturas y captions.
  - SPACE / Randomize en contorno.
  - Paleta de primarios con tintes, tonos y sombras; sin magenta ni
    transparencias en los controles.
- **v0.5**
  - Paneles flotantes.
  - Variations con selección y código.
  - Download as.
  - Espacio seguro variable (reemplazado en v0.6).
- **v0.4:** comparación con Akzidenz, S/G elásticas, rediseño de la interfaz y
  Export to.
- **v0.3:** letras construidas, Pulse estable, MP4, zoom y light UI.
- **v0.2:** light UI, barra de texto y grilla ajustada al píxel.
- **v0.1:** Bobinas, motores, formatos, hallazgos y PNG/WebM.

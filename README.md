# Metamorfosis — El Valle de los Colosos

Aventura de plataformas en 3D para navegador, contenida en un único fichero: `index.html` (HTML + CSS + JavaScript, con [three.js](https://threejs.org/) cargado desde CDN).

Controlas a un ser que **cambia de forma cada 10 segundos** entre cinco monstruos gigantes. En el HUD ves cuál será la siguiente forma, así que puedes planificar la ruta según el monstruo que viene.

## Cómo jugar

Abre `index.html` en un navegador moderno (Chrome, Edge o Firefox) con conexión a internet, necesaria para cargar three.js desde jsDelivr. También puedes servirlo en local, por ejemplo con `npx http-server .`.

| Control | Acción |
|---|---|
| `W A S D` | Moverse |
| `Espacio` | Saltar · doble salto (Lobo) · aletear / planear manteniendo (Dragón) |
| Ratón | Cámara |
| Clic izquierdo | Ataque principal (mantener para los alientos) |
| `E` / clic derecho | Habilidad especial |
| `Esc` | Pausa |
| `M` | Silenciar |

### En el móvil

En móviles y tablets el juego detecta la pantalla táctil y activa el modo táctil. Se juega mejor en horizontal; al empezar se intenta pasar a pantalla completa y bloquear la orientación.

| Control | Acción |
|---|---|
| Mitad izquierda | Joystick analógico flotante: aparece bajo el pulgar |
| Mitad derecha | Arrastra para girar la cámara |
| Botón de flechas | Saltar (mantén pulsado para planear con el Dragón) |
| Botón de garras | Ataque principal (mantén pulsado para los alientos) |
| Botón de estrella | Habilidad especial; se ilumina cuando está lista o hay un anclaje a la vista |
| ⏸ | Pausa |

El modo táctil incluye apuntado asistido hacia el enemigo más cercano, una cámara que se recoloca sola detrás del personaje al girar, vibración al recibir golpes y al transformarte, un HUD compacto que respeta el notch y calidad gráfica adaptada al móvil. Se puede forzar la alta con `?high`, el modo táctil con `?touch` o el modo ratón con `?desktop`.

## Docker y despliegue en Sliplane

El repositorio incluye un `Dockerfile` que sirve el juego con nginx (Alpine) en el puerto **8080**. El puerto se puede cambiar con la variable de entorno `PORT`.

```bash
docker build -t metamorfosis .
docker run --rm -p 8080:8080 metamorfosis
# o bien
docker compose up --build
```

Luego abre http://localhost:8080. La ruta `/healthz` responde `ok` y sirve como comprobación de salud.

Para desplegar en [Sliplane](https://sliplane.io):

1. Crea un servicio nuevo de tipo **Repository** y elige este repositorio y la rama `main`.
2. Deja el contexto de build en `.` y el Dockerfile en `Dockerfile`.
3. Activa **Public** con el puerto HTTP `8080`. Si cambias `PORT` en las variables de entorno, usa ese mismo valor.
4. Opcional: pon `/healthz` como ruta de comprobación de salud.
5. Despliega. Con el despliegue automático activado, cada push a `main` genera una versión nueva.

## Las cinco formas

| Monstruo | Ataque | Habilidad | Movilidad / pasiva |
|---|---|---|---|
| **Hombre Lobo** | Combo de garras | Embestida (también en el aire) | Doble salto, muy rápido |
| **Araña Colosal** | Telaraña que atrapa | Gancho de seda a los anclajes brillantes | Trepa paredes de roca |
| **Oso Titán** | Zarpazo que rompe roca agrietada | Golpe sísmico (más fuerte desde el aire) | −50 % de daño |
| **Dragón Carmesí** | Aliento de fuego: quema madera y enciende braseros | Bola de fuego explosiva | 3 aleteos y planeo |
| **Yeti Glacial** | Aliento gélido: congela el agua y a los enemigos | Pilar de hielo que te eleva | −30 % de daño |

## El nivel

1. **Claro del Despertar**: tutorial, circuito de bloques, geoda de roca agrietada y jaula de madera con almas.
2. **Río de la Niebla**: lo cruzas saltando por la roca central (Lobo), enganchándote a los tocones (Araña), congelando el agua (Yeti) o planeando (Dragón).
3. **Orilla de los Caídos / Acantilado**: se sube trepando (Araña), por las cornisas (Lobo), con pilares de hielo (Yeti) o aleteando (Dragón).
4. **Fortaleza de Umbravel**: muros rúnicos que no se pueden trepar, puerta de madera (Dragón), roca agrietada (Oso), muralla derruida (Araña, Yeti o Dragón), braseros que abren el rastrillo y cajas para subir.
5. **Abismo de Magma**: islas flotantes, plataformas móviles, ceniza que se desmorona, géiseres y bombas de lava.
6. **Santuario del Coloso**: combate final contra el Coloso de Obsidiana, con ondas sísmicas, rocas lanzadas y esbirros.

Hay 34 Almas Antiguas repartidas por el nivel, muchas escondidas en zonas a las que solo llega una forma concreta. Los santuarios sirven de punto de control y te curan.

## Los once niveles

En la pantalla de inicio eliges el nivel en una rejilla de tarjetas con dos pestañas: **Metamorfosis** (los niveles donde manejas a los cinco monstruos) y **Desafíos** (los modos con mecánica propia). Cada tarjeta muestra tu mejor tiempo y la medalla conseguida (se guardan en el navegador). También se puede entrar directamente con `?level=<id>`.

### Metamorfosis: cinco monstruos, seis reglas de cambio

En todos estos niveles controlas a los cinco monstruos con sus habilidades del Valle; lo que cambia es **cuándo y cómo te transformas**, y cada nivel tiene su propio estilo gráfico (con un pase de post-proceso propio).

| # | Nivel (`?level=`) | Regla de cambio | Estilo | De qué va |
|---|---|---|---|---|
| 1 | El Valle de los Colosos (`valle`) | Cada 10 segundos | Natural | La aventura original. |
| 2 | Catedral de Vitral (`vitral`) | **Por zonas**: pisar un cristal de color te convierte en su monstruo; el cristal blanco conserva tu forma | Vitral gótico al anochecer | Lleva formas de una zona a otra, salta franjas para no perder la tuya, cruza el rosetón giratorio, congela la cripta y sube el campanario para tañer las cinco campanas. |
| 3 | Coliseo de Tinta (`tinta`) | **Por bajas**: cada baja carga el cambio; con una carga pulsas `R` y te transformas en la forma elegida (`1`-`5`, rueda o el panel) | Sumi-e: papel de arroz, aguadas de tinta y acentos bermellón | Seis oleadas. Cada enemigo lleva el sello del monstruo que le hace el doble de daño. La quinta oleada inunda la arena de tinta y el Oni final cambia de sello con cada cuarto de vida. |
| 4 | Teatro de Papel (`papel`) | **Por máscaras**: tocar una máscara de pedestal te transforma; además puedes guardar una máscara portátil y ponértela con `R` | Libro desplegable de papel y cartón | Cuatro actos que se despliegan al acercarte: bosque y río de papel, castillo que se quema, mar de origami con barcos que llevan máscaras y una escalera de libros hasta el telón. |
| 5 | Espiral de Neón (`neon`) | **Cinco vidas**: empiezas con el monstruo que elijas; si cae, lo pierdes para siempre y eliges el siguiente | Synthwave / neón | Asciende una espiral de 26 plataformas con láseres, losas que se desmoronan, cortafuegos, huecos y géiseres de datos. Cada tramo tiene una solución universal y atajos según la forma. Los núcleos verdes recuperan al último monstruo perdido. |
| 6 | Templo del Pulso (`pulso`) | **Al ritmo**: la música (120 ppm) te transforma cada dos compases según una partitura de 8 pasos; los gongs reescriben el siguiente paso | Art déco negro y oro | Pistones que caen al compás, un puente de losas intermitentes, lanzaderas que disparan en el primer tiempo y una coreografía final sobre las placas de colores. |

### Desafíos

Cada desafío tiene su propia mecánica, cuenta atrás de salida, medallas de oro, plata y bronce, y una pantalla de resultados con *Reintentar*, *Siguiente nivel* y *Menú*.

| Nivel (`?level=`) | Mecánica | Controles propios |
|---|---|---|
| Rápidos del Colmillo (`rapidos`) | Carrera de motos de agua a 3 vueltas contra 3 diablillos, con rampas, pads de turbo, rebufo y giros de 360° en el aire que recargan el turbo | `A D` girar · `W`/`S` acelerar o frenar · `Shift`/clic turbo · `Espacio` saltar |
| Corona de Nubes (`nubes`) | Vuelo contrarreloj con el Dragón por 28 anillos entre islas flotantes | `W S` subir/bajar · `A D` o ratón girar · `Espacio` aletear · `Shift` turbo |
| Descenso Glacial (`glaciar`) | Huida en trineo del Yeti perseguido por una avalancha | `A D` girar · `W` agacharse · `S` frenar · mantener `Espacio` para cargar el salto |
| Telaraña del Abismo (`abismo`) | La Araña cruza un abismo balanceándose con física de péndulo | Mantener clic/`Shift` (o `Espacio` en el aire) para lanzar seda |
| Bola Rúnica (`bola`) | El Oso hecho bola recorre un circuito de canicas en el cielo | `WASD` rodar · ratón cámara · `Espacio` saltar · clic/`E` embestida |

Todos los niveles se juegan también en el móvil: el joystick y los botones cambian de función y de texto según el nivel, y en los niveles con cambio manual aparece el botón **CAMBIAR**/**MÁSCARA**.

## Tecnología

- Iluminación física: cielo atmosférico, sombras suaves, mapa de entorno (PMREM), tono ACES y *bloom*.
- Terreno procedural con colores por altura y pendiente, hierba instanciada que se mece con el viento y se aparta al pasar, bosques instanciados, agua con normales animadas, lava y cascada con *shaders* propios.
- Texturas procedurales generadas en *canvas*: roca, ladrillo, madera, pelaje, escamas, runas y grietas incandescentes.
- Modelos y animaciones procedurales para los cinco monstruos, los enemigos y el jefe.
- Sistema de partículas, audio sintetizado con Web Audio (sin ficheros externos) y resolución dinámica según el rendimiento.
- Optimizaciones de rendimiento: vegetación troceada por zonas con LOD y descarte por distancia, geometría estática fusionada, modelos con piezas rígidas fusionadas, cielo precalculado en un cubemap, sombras a 30 Hz, un pool fijo de 2 luces puntuales, materiales Lambert en las superficies mates, *bloom* a media resolución y post-proceso en un único pase.

El juego ajusta la resolución interna en tiempo real para mantener unos 60 FPS. Si tu equipo es modesto, añade `?low` a la URL.

Parámetros de URL opcionales: `?low` baja la calidad para equipos modestos; `?debug` activa atajos de prueba (`1`–`5` para cambiar de forma, `N` para ir al siguiente santuario, `G` para el modo dios).

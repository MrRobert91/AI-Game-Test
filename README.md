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

## Los seis niveles

En la pantalla de inicio eliges el nivel en una rejilla de tarjetas; cada tarjeta muestra tu mejor tiempo y la medalla conseguida (se guardan en el navegador). También se puede entrar directamente con `?level=<id>`. Cada nivel nuevo tiene su propia mecánica, cuenta atrás de salida, medallas de oro, plata y bronce, y una pantalla de resultados con *Reintentar*, *Siguiente nivel* y *Menú*.

| # | Nivel (`?level=`) | Mecánica | Controles propios |
|---|---|---|---|
| 1 | El Valle de los Colosos (`valle`) | Aventura con cambio de forma | Los de arriba |
| 2 | Rápidos del Colmillo (`rapidos`) | Carrera de motos de agua a 3 vueltas contra 3 diablillos, con rampas, pads de turbo, rebufo y giros de 360° en el aire que recargan el turbo | `A D` girar · `W`/`S` acelerar o frenar · `Shift`/clic turbo · `Espacio` saltar |
| 3 | Corona de Nubes (`nubes`) | Vuelo contrarreloj con el Dragón por 28 anillos entre islas flotantes: cada anillo da tiempo y los perfectos más; hay térmicas que recargan energía | `W S` subir/bajar · `A D` o ratón girar · `Espacio` aletear · `Shift` turbo |
| 4 | Descenso Glacial (`glaciar`) | Huida en trineo del Yeti perseguido por una avalancha: slalom entre pinos y rocas, rampas sobre grietas, puertas turbo y trucos (giros y mortales) | `A D` girar · `W` agacharse · `S` frenar · mantener `Espacio` para cargar el salto |
| 5 | Telaraña del Abismo (`abismo`) | La Araña cruza un abismo balanceándose con física de péndulo entre agujas, arcos y cristales móviles, con ráfagas de viento | Mantener clic/`Shift` (o `Espacio` en el aire) para lanzar seda · soltar para salir disparado · `WASD` para impulsarse |
| 6 | Bola Rúnica (`bola`) | El Oso hecho bola recorre un circuito de canicas en el cielo: vigas, barras giratorias, pinball, pistones, muros de cristal, trampolín y plataformas móviles; hay que reunir 5 runas para abrir el portal | `WASD` rodar · ratón cámara · `Espacio` saltar · clic/`E` embestida (en el aire, golpe hacia abajo) |

Todos los niveles se juegan también en el móvil: el joystick y los botones cambian de función y de texto según el nivel.

## Tecnología

- Iluminación física: cielo atmosférico, sombras suaves, mapa de entorno (PMREM), tono ACES y *bloom*.
- Terreno procedural con colores por altura y pendiente, hierba instanciada que se mece con el viento y se aparta al pasar, bosques instanciados, agua con normales animadas, lava y cascada con *shaders* propios.
- Texturas procedurales generadas en *canvas*: roca, ladrillo, madera, pelaje, escamas, runas y grietas incandescentes.
- Modelos y animaciones procedurales para los cinco monstruos, los enemigos y el jefe.
- Sistema de partículas, audio sintetizado con Web Audio (sin ficheros externos) y resolución dinámica según el rendimiento.
- Optimizaciones de rendimiento: vegetación troceada por zonas con LOD y descarte por distancia, geometría estática fusionada, modelos con piezas rígidas fusionadas, cielo precalculado en un cubemap, sombras a 30 Hz, un pool fijo de 2 luces puntuales, materiales Lambert en las superficies mates, *bloom* a media resolución y post-proceso en un único pase.

El juego ajusta la resolución interna en tiempo real para mantener unos 60 FPS. Si tu equipo es modesto, añade `?low` a la URL.

Parámetros de URL opcionales: `?low` baja la calidad para equipos modestos; `?debug` activa atajos de prueba (`1`–`5` para cambiar de forma, `N` para ir al siguiente santuario, `G` para el modo dios).

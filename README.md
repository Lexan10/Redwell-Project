# Redwell-Project

**Redwell** és un videojoc 2D inspirat en l’estil visual dels títols clàssics de *Pokémon*, amb una narrativa pròpia i un toc de misteri.  
L’objectiu del projecte és desenvolupar un petit món interactiu on el jugador pugui explorar, interactuar i resoldre petits trencaclosques mentre descobreix la història.

---

## Descripció del joc

- **Gènere:** Aventura narrativa amb exploració  
- **Estil gràfic:** Pixel art retro  
- **Perspectiva:** Top-down 2D  
- **Motor de joc:** Godot Engine 4.x  
- **Plataforma prevista:** Windows/Linux

L’objectiu és oferir una experiència immersiva i reflexiva a través d’un món pixelat, amb interaccions amb personatges, trencaclosques i un fil argumental profund.

---

## Objectius del projecte

- Explorar eines lliures com **Godot** per al desenvolupament de videojocs.  
- Treballar l’estètica i la narrativa pròpia dins d’un entorn interactiu.  
- Crear una estructura **modular, escalable** i amb bona gestió de recursos.  
- Experimentar amb mecàniques de resolució de trencaclosques i narrativa emergent.

---

## Estat del desenvolupament

Actualment el joc es troba en fase inicial. Ja es pot:

- Observar l’entorn gràfic implementat  
- Moure el personatge principal  
- Testar el sistema bàsic de moviment i col·lisió

Encara no hi ha versió executable (`.exe`). Les futures versions es publicaran com a *releases* d’aquest repositori.

---

## Com provar el projecte

Per executar el projecte localment:

1. Assegura’t de tenir instal·lat **Godot Engine 4.x**  
   (https://godotengine.org/download)
2. Clona o descarrega aquest repositori.
3. Obre el fitxer `project.godot` des de Godot.
4. Executa l’escena principal (`Town.tscn`) o la definida per defecte.

---

## Estructura de carpetes

```
├── Assets/              # Recursos visuals (tilesets, personatges, UI)
│   ├── Player/
│   ├── Trees/
│   ├── Buildings/
│   └── ...
├── Player.gd            # Script del moviment del personatge
├── Player.tscn          # Escena del jugador
├── Town.tscn            # Primera escena del joc
├── project.godot        # Fitxer principal de configuració Godot
├── LICENSE.txt          # Llicència d’ús
├── README.md            # Aquest fitxer
└── .gitignore           # Arxius a ignorar per git
```

## Llicència

Aquest projecte està llicenciat sota **Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)**.

Ets lliure de:
- **Compartir** — copiar i redistribuir el material en qualsevol mitjà o format.
- **Adaptar** — remesclar, transformar i construir a partir del material.

Sota les condicions següents:
- **Reconeixement** — Has de donar el crèdit adequat.
- **NoComercial** — No pots utilitzar el material amb finalitats comercials.
- **CompartirIgual** — Si modifiques el material, has de distribuir-lo amb la mateixa llicència que l’original.

Més informació: [https://creativecommons.org/licenses/by-nc-sa/4.0/](https://creativecommons.org/licenses/by-nc-sa/4.0/)

## Autor i crèdits

**Autor:** Alex Martínez  
**Universitat:** Universitat Oberta de Catalunya (UOC)  
**Assignatura:** Treball Final de Grau  
**Curs acadèmic:** 2025–2026

Els gràfics i recursos visuals que no són de creació pròpia han estat extrets de fonts amb llicència lliure o **Creative Commons**, i es referenciaran degudament a l’entrega final del treball.




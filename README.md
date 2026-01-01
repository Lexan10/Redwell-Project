# Redwell-Project

**Project Redwell** és una **demo jugable d’un videojoc 2D d’exploració i misteri**, desenvolupada com a **Treball Final de Grau**.
El projecte combina narrativa ambiental, exploració i petits enigmes dins d’un món pixel art inspirat en l’estètica clàssica, amb una atmosfera fosca i inquietant.

---

## Descripció del joc

- **Gènere:** Aventura narrativa amb exploració  
- **Estil gràfic:** Pixel art retro  
- **Perspectiva:** Top-down 2D  
- **Motor de joc:** Godot Engine 3.5  
- **Plataforma prevista:** Windows (demo executable)

El jugador controla un antic inspector que arriba a un poble aparentment abandonat. A través de l’exploració, la interacció amb l’entorn i els personatges, i la resolució de petits trencaclosques, es va revelant una història fragmentada marcada pel misteri.

---

## Objectius del projecte

L’objectiu del treball és desenvolupar una **demo funcional i coherent** que demostri:

- Disseny d’un món interactiu amb narrativa ambiental
- Implementació de sistemes bàsics de videojoc (moviment, col·lisions, diàlegs, transicions, enigmes)
- Gestió d’estats narratius i progressió del jugador
- Avaluació del joc mitjançant proves amb usuaris (beta testers)

Aquest projecte no pretén ser un joc complet, sinó una **prova de concepte** amb potencial d’expansió.

---

## Estat del projecte

Versió **GOLD MASTER** (Demo final)
El projecte es considera complet dins l'abast definit per al Treball Final de Grau

## Com provar el projecte

- Ves a l’apartat Releases del repositori.
- Descarrega l’arxiu .zip de l’última versió.
- Descomprimeix la carpeta.
- Executa RedwellProject.exe.

No cal instal·lació.

---

## Controls bàsics

- Fletxes / WASD - Moure el personatge
- E / tecla d'interacció - Interactuar amb NPCs i objectes
- ESC - Pausa / menú

---

## Contingut de la demo

La demo es considera completada quan el jugador:

- Explora totes les zones accessibles
- Parla amb tots els NPCs
- Entra a totes les cases
- Interactua amb els elements clau
- Resol l’enigma principal

---

## Avaluació amb usuaris

El projecte ha estat provat per beta testers, mitjançant qüestionaris estructurats que han permès recollir:

- Valoracions quantitatives (escala 1–5)
- Feedback qualitatiu
- Detecció de bugs i àrees de millora

Els resultats d’aquesta avaluació s’inclouen i s’analitzen a la memòria del Treball Final de Grau.

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
├── Town.tscn            # Segona escena del joc
├── Main_Menu.gd         # Script del menú
├── Main_Menu.tscn       # Primera escena del joc
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




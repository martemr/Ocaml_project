# Source code 
Base project for Ocaml project on Ford-Fulkerson. This project contains some simple configuration files to facilitate editing Ocaml in VSCode.

To use, you should install the *OCaml* extension in VSCode. Other extensions might work as well but make sure there is only one installed.
Then open VSCode in the root directory of this repository (command line: `code path/to/ocaml-maxflow-project`).

Features :
 - full compilation as VSCode build task (Ctrl+Shift+b)
 - highlights of compilation errors as you type
 - code completion
 - automatic indentation on file save


A makefile provides some useful commands:
 - `make build` to compile. This creates an ftest.native executable
 - `make demo` to run the `ftest` program with some arguments
 - `make format` to indent the entire project
 - `make edit` to open the project in VSCode
 - `make clean` to remove build artifacts

In case of trouble with the VSCode extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).

# Projet Ford-Fulkerson Noé et Martin :

Le projet est contenu dans le fichier FordFulkerson. Il utilise le fichier dfs pour chercher des chemins dans le graphe. Pour tester, les fichiers ftest et readFile sont utilisés
La partie Medium du projet est contenue dans le fichier moneySharing, qui est aussi utilisé pour tester cette partie. Ce programme est un algorithme de partage de coûts, où l'on donne la participation de chacun à un projet et l'algorithme nous dit qui doit combien à qui.

Chaque exécution crée 3 fichiers :
    - 'oufile' : le graphe renvoyé par le programme au format compatible svg
    - 'oufile.txt' : le graphe renvoyé par le programme au format compatible au site https://algorithms.discrete.ma.tum.de/graph-algorithms/flow-ford-fulkerson/index_en.html
    - 'output-graph.svg' : l'image du graphe de retour 

**Pour utiliser l'algorithme Ford Fulkerson :**
    `make test` applique l'algorithme au fichier graph1.txt du dossier graphs
    
**Pour utiliser l'algorithme Money Sharing :**
    Commenter le contenu de ftest.ml 
    Utiliser la commande `make money` pour appliquer l'algorithme au fichier data.txt
    Les lignes du fichier data.txt doit être de la forme "[id] [Nom] [Contribution]" avec :
        - [id] un int différent de 0 et 1000
        - [Nom] un string ne contenant pas d'espace
        - [Contribution] un int correspondant à la contribution de la personne
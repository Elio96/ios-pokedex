# ios-pokedex

L'applicazione mostra una lista di pokemon recuperata dall'api https://pokeapi.co/api/v2/pokemon/ .

Il framework utilizzato per la costruzione della UI è **UIKit**, ed è stato implementato il pattern MVVM-C, che coglie gli aspetti positivi del Coordinator (organizzazione migliore dei flussi di navigazione) e del MVVM (separa la business logic dalla UI).
L'approccio adottato per la costruzione delle viste è prevalentemente programmatico. Ho utilizzato uno xib soltanto per la cella dei preferiti.

Il dependency manager utilizzato per lo sviluppo è **Cocoapod** ed è stato utilizzato per il suo ampio  parco di dipendenze e perché è presente da più tempo.

Di seguito le dipendenze utilizzate:
- Kingfisher
- Lottie
- ReachabilitySwift

La prima dipendenza, Kingfisher, permette di scaricare le immagini in maniera asincrona e si possono memorizzare in una cache che le recupera attraverso una chiave univoca ogni volta che viene eseguita l'istruzione di download.
Questo permette una maggiore efficienza e di risparmiare chiamate di rete se l'immagine è già presente in cache.
La gestione è automatizzata ed è possibile impostare i limiti di memoria nell'app delegate.

La seconda è Lottie, un framework che permette di utilizzare delle animazioni in formato JSON, scaricabili dalla pagina ufficiale di lottie: https://lottiefiles.com/ .
Questa dipendenza è stata utilizzata per l'animazione di caricamento.

L'ultima invece è ReachabilitySwift. Grazie a questa dipendenza sarà possibile verificare i cambiamenti di connsessione e, qualora non ci fosse, permette recuperare dal CoreData i Pokemon salvati dopo il download.

## Features

- Salvare i pokemon ottenuti all'iterno di CoreData
- Salvare i pokemon preferiti nel CoreData e visualizzarli nell'apposita schermata
- Rimuovere i pokemon preferiti ed eliminarli dal CoreData

## Esecuzione del progetto una volta clonato

Recarsi nella directory principale del progetto in corrispondenza del **Podfile**.
Aprire un terminale nella cartella e lanciare il seguente comando per installare le dipendenze descritte sopra.

```sh
pod install
```
Dopo aver installato le dipendenze, aprire il file **Pokedex.xcworkspace** ed eseguire l'app su qualsiasi device si voglia.
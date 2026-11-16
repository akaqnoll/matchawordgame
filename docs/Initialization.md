1. Select first random *N* letter word *InitialWord* from *LNG_Dictionary*
2. Select second random *N* letter word *TargetWord* from *LNG_Dictionary*
3. If thee words are the same, choose another second word until it's not the same
4. Assign *InitialWord* to a *CurrentWord*
5. Add *CurrentWord* to *History* with *\0* at the end 
6. Assign each letter from *CurrentWord* to a Cube that will together represent the word you change
7. Depending on language chosen, select according keyboard (will be an according Prefab)
8. Animate Keyboard
9. Animate Cubes

### Gameplay loop:
1. Player is able to drag and drop letters from the keyboard that is on the screen onto the cubes
2. Players can't drag n drop same letters on same letters
3. Each time player makes a new word, the updated *CurrentWord* will be compared to all words in *LNG_Dictionary* with the ALGORITHM_X algorithm
4. When the word that player build it a legitimate word, player proceeds to next turn
5. The goal is to reachg the *TargetWord* as soon as possible
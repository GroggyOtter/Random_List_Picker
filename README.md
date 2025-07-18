# Random_List_Picker

This is a simple script that will pick X amount of items from a larger list.  
This kind of thing can be used to choose something at random, pick winners from a list of names, choose what you want to eat for dinner, or any other number of situations where "random choice" needs to happen.  

A GUI is provided.  

It can be summoned and dismissed with F1. (Feel free to rebind the hotkey to whatever you want)  
It can also be summoned by double clicking the tray icon or by picking the "show picker" option in the tray icon menu.  

To use:
1. Paste a list of one or more items into the top edit box.
1. Each item must be on its own line.
1. Next, choose how many items you want picked.
1. Click the "Randomly select item(s)" button.

<img width="382" height="680" alt="image" src="https://github.com/user-attachments/assets/fd4d4457-dfc5-4329-870c-6dd586b21598" />

Items will **not** be picked more than once.  
Once an item is picked, it is removed from the pool.  
In order for an item to be eligible for being picked twice, it must appear twice in the list.  

EG: In the list "Alpha, Bravo, Charlie", the option Bravo cannot be picked more than once.  
But if the list "Alpha, Bravo, Bravo, Charlie" is used, it becomes possible for Bravo to show up twice in the end list.

SNAKE is a simple game which illustrates Linux assembly
programming. You move around a snake which grows every 10 moves.

Requirements
------------
* Linux
* nasm
* root access on tty2

Usage
-----

The game must be run as root on tty2 with 80 columns and 25 rows. The
following steps describe how to launch the game.

1. Compile with `make`.
2. Switch to tty2 by pressing CTRL+ALT+F2 and log in as root. You can
   switch back to the GUI with CTRL+ALT+F7.
3. Set the required number of columns and rows:
```
stty columns 80
stty rows 25
```
4. Run `snake`.
5. To exit press `q`.

Copyright and license
---------------------

Copyright (C) 2006 by Lukasz Czajka.

Distributed under the MIT license. See [LICENSE](LICENSE).

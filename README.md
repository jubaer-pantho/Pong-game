# Pong Game
vivado project:
This is a simple pong game design implemented on zybo.
The design works like this:

The image is generated in the arm processor and loaded it in the bram. The hardware part reads the image from the the bram and projects it on a vga monitor using a vga controller.

The bar can be moved using the push buttons. The arm processor takes input from the push buttons and draws the next position of the bar.

To play:
- plugin the vga port into the zybo
- load the bitstream
- run the c code from the vivado sdk
- use push buttons to play


Jubaer Hossain (timeline : Feb 2016)

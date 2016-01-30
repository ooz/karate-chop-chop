#!/usr/bin/python

import Image

for color in ["yellow", "orange", "green", "blue", "brown"]:
    blank_image = Image.open("tree00_80_copy.png")

    top = Image.open("upper_body_80.png")
    bot = Image.open(color + "_front_80.png")
    out = color + "_whole_front_80.png"

    blank_image.paste(top, (0,0))
    blank_image.paste(bot, (0,71))

    blank_image.save(out)

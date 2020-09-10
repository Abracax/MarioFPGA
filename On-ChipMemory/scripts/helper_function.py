import numpy as np
from PIL import Image
import struct

# filename = "bk"
# input_file = "../sprite_originals/" + filename + ".png"
# output_file = "../sprite_bytes/" + filename + "_ram" + ".ram"
# im = Image.open("./sprite_originals/" + filename + ".png") #Can be many different formats.
# im = im.convert("RGBA")

color_arr = []
def png2ram(input_file):
    with open(input_file) as f:
        for line in f:
            hex_val = int(line, 16)
            R = (hex_val >> 16) & 0xff
            G = (hex_val >> 8) & 0xff
            B = hex_val & 0xff
            color = ((R >> 3) << 11) | ((G >> 2) << 5) | ((B >> 3))
            color_16 = struct.pack('H', color)
            color_arr.append(color_16)
    print(input_file + "    ok", len(color_arr), color_arr[10])
    


def main():
    input_file = "../sprite_bytes/mario.txt"
    png2ram(input_file)

    input_file = "../sprite_bytes/brick.txt"
    png2ram(input_file)

    input_file = "../sprite_bytes/mushroom.txt"
    png2ram(input_file)

    input_file = "../sprite_bytes/bg.txt"
    png2ram(input_file)

    input_file = "../sprite_bytes/mario_run1.txt"
    png2ram(input_file)
    
    input_file = "../sprite_bytes/mario_jump.txt"
    png2ram(input_file)
    
    input_file = "../sprite_bytes/left.txt"
    png2ram(input_file)

    input_file = "../sprite_bytes/left_run1.txt"
    png2ram(input_file)
    
    input_file = "../sprite_bytes/left_jump.txt"
    png2ram(input_file)

    input_file = "../sprite_bytes/coin.txt"
    png2ram(input_file)


    print("color_arr length",len(color_arr))
   
    with open("../sprite_bytes/lalalalal.ram",'wb') as output:
        for c in color_arr:
            output.write(c)





# def png2bm(input_file, output_file):
#     with open(output_file, 'w') as output:
#         with Image.open(input_file) as img:
#             img_arr = np.array(img)
#             for line in img_arr:
#                 output.write(str(len(line))+"'b")
#                 for pixel in line:
#                     R_diff = abs(pixel[0] - 243)
#                     G_diff = abs(pixel[1] - 32)
#                     B_diff = abs(pixel[2] - 231)
#                     if R_diff < 30 and G_diff < 30 and B_diff < 30:
#                         output.write('0')
#                     else:
#                         output.write('1')
#                 output.write(',\n')
#             output.write('height: ' + str(len(img_arr)))

# # def png2palette(input_file, output_index, output_palette):
# def png2palette_check(input_file):
#     # with open(output_index, 'wb') as op_idx:
#     palette = []
#     with Image.open(input_file) as img:
#         img_arr = np.array(img)
#         for line in img_arr:
#             for pixel in line:
#                 R = pixel[0]
#                 G = pixel[1]
#                 B = pixel[2]
#                 color = ((R >> 3) << 11) | ((G >> 3) << 6) | ((B >> 3))
#                 if color not in palette:
#                     palette.append(color)
#     print(len(palette))
#                     # color_16 = struct.pack('H', color)
#                     # output.write(color_16)


main()
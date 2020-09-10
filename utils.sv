package Numbers;
   
    parameter  int BRICK_RAM_X = 'd20;
    parameter  int BRICK_RAM_Y = 'd20;
    parameter  int MARIO_RAM_X = 'd16;
    parameter int MARIO_RAM_Y = 'd32;
    parameter int MUSHROOM_RAM_X = 'd20;
    parameter int MUSHROOM_RAM_Y = 'd20;
    parameter int PIPE_RAM_X = 'd50;
    parameter int PIPE_RAM_Y = 'd80;
    parameter int CLOUD_RAM_X = 'd50;
    parameter int CLOUD_RAM_Y = 'd40;
    parameter int BG_RAM_X = 'd1000;
    parameter int BG_RAM_Y = 'd480;


    parameter int MARIO_RAM_OFFSET = 0;
    parameter int BRICK_RAM_OFFSET = 'd512;
    parameter int MUSHROOM_RAM_OFFSET = BRICK_RAM_OFFSET + BRICK_RAM_X*BRICK_RAM_Y;
    parameter int BG_RAM_OFFSET= MUSHROOM_RAM_OFFSET+MUSHROOM_RAM_X*MUSHROOM_RAM_Y;
    parameter int RIGHT_RUN_1_RAM_OFFSET = BG_RAM_OFFSET+BG_RAM_X*BG_RAM_Y;
    parameter int RIGHT_JUMP_RAM_OFFSET = RIGHT_RUN_1_RAM_OFFSET + MARIO_RAM_X*MARIO_RAM_Y;
    parameter int LEFT_MARIO_RAM_OFFSET = RIGHT_JUMP_RAM_OFFSET + MARIO_RAM_X*MARIO_RAM_Y;
    parameter int LEFT_RUN_1_RAM_OFFSET = LEFT_MARIO_RAM_OFFSET + MARIO_RAM_X*MARIO_RAM_Y;
    parameter int LEFT_JUMP_RAM_OFFSET = LEFT_RUN_1_RAM_OFFSET + MARIO_RAM_X*MARIO_RAM_Y;


    parameter int PIPE_RAM_OFFSET = MUSHROOM_RAM_OFFSET + PIPE_RAM_X*PIPE_RAM_Y;
    parameter int CLOUD_RAM_OFFSET = PIPE_RAM_OFFSET + CLOUD_RAM_X*CLOUD_RAM_Y;
	 

    parameter [3:0] SPRITE_BG = 4'd0;
    parameter [3:0] SPRITE_MARIO = 4'd1;
    parameter [3:0] SPRITE_BRICK = 4'd2;
    parameter [3:0] SPRITE_MUSHROOM = 4'd3;
    parameter [3:0] SPRITE_PIPE = 4'd4;
    parameter [3:0] SPRITE_CLOUD = 4'd5;
    parameter [3:0] SPRITE_RIGHT_RUN_1 = 4'd6;
    parameter [3:0] SPRITE_RIGHT_JUMP = 4'd9;
    parameter [3:0] SPRITE_LEFT_MARIO = 4'd10;
    parameter [3:0] SPRITE_LEFT_RUN_1 = 4'd11;
    parameter [3:0] SPRITE_LEFT_JUMP = 4'd14;
    parameter [3:0] SPRITE_FONT_1 = 4'd14;


    parameter [3:0] MARIO_RIGHT = 4'd0;
    parameter [3:0] MARIO_RIGHT_RUN_1 = 4'd1;
    parameter [3:0] MARIO_RIGHT_JUMP = 4'd2;
    parameter [3:0] MARIO_LEFT = 4'd3;
    parameter [3:0] MARIO_LEFT_RUN_1 = 4'd4;
    parameter [3:0] MARIO_LEFT_JUMP = 4'd5;
    

    // Mario
   
    parameter [15:0] MARIO_X_SIZE = 16'd16;
    parameter [15:0] MARIO_Y_SIZE = 16'd32;
    parameter [15:0] MARIO_X_LEFT = 16'd50; 
    parameter [15:0] MARIO_Y_LEFT = GND_HEIGHT - MARIO_Y_SIZE;
    parameter [15:0] MARIO_X_MAX = SCREEN_X - MUSHROOM_X_SIZE;
    parameter [15:0] MARIO_X_MIN = 16'd0;
    parameter [15:0] MARIO_Y_MAX = GND_HEIGHT - MARIO_Y_SIZE;
    parameter [15:0] MARIO_Y_MIN = 16'd0;

    
    parameter [15:0] MUSHROOM_X_SIZE = 16'd20;
    parameter [15:0] MUSHROOM_Y_SIZE = 16'd20;

    parameter [15:0] BRICK_SIZE = 16'd20;

    parameter [15:0] GND_HEIGHT = 16'd360;
    parameter [15:0] SCREEN_Y = 'd480;
    parameter [15:0] SCREEN_X = 'd640;

    // Mushroom 1
    parameter [15:0] MUSHROOM1_X_LEFT = MARIO_X_LEFT +  MARIO_X_SIZE + 'd10;  
    parameter [15:0] MUSHROOM1_Y_LEFT =  GND_HEIGHT - MUSHROOM_Y_SIZE;
    parameter [15:0] MUSHROOM1_X_RIGHT = MUSHROOM1_X_LEFT + 'd100;  
    parameter [15:0] MUSHROOM1_Y_RIGHT = GND_HEIGHT - MUSHROOM_Y_SIZE;
    
    // platform 1
    parameter [15:0] PLATFORM1_X_LEFT = 16'd200;
    parameter [15:0] PLATFORM1_X_SIZE = 16'd100;
    parameter [15:0] PLATFORM1_X_RIGHT = PLATFORM1_X_LEFT + PLATFORM1_X_SIZE;
    parameter [15:0] PLATFORM1_Y_LEFT = GND_HEIGHT - 'd100;
    parameter [15:0] PLATFORM1_Y_RIGHT = PLATFORM1_Y_LEFT;
    parameter [15:0] PLATFORM1_Y_SIZE = BRICK_SIZE;

    // platform 2
    parameter [15:0] PLATFORM2_X_LEFT = 16'd330;
    parameter [15:0] PLATFORM2_X_SIZE = 16'd150;
    parameter [15:0] PLATFORM2_X_RIGHT = PLATFORM2_X_LEFT + PLATFORM2_X_SIZE;
    parameter [15:0] PLATFORM2_Y_LEFT = PLATFORM1_Y_LEFT - 'd100;
    parameter [15:0] PLATFORM2_Y_RIGHT = PLATFORM2_Y_LEFT;
    parameter [15:0] PLATFORM2_Y_SIZE = BRICK_SIZE;

    // platform 3
    parameter [15:0] PLATFORM3_X_LEFT = 16'd640;
    parameter [15:0] PLATFORM3_X_SIZE = 16'd20;
    parameter [15:0] PLATFORM3_X_RIGHT = PLATFORM3_X_LEFT + PLATFORM3_X_SIZE;
    parameter [15:0] PLATFORM3_Y_UP = GND_HEIGHT - 'd80;
    parameter [15:0] PLATFORM3_Y_DOWN = PLATFORM3_Y_UP + BRICK_SIZE;
    parameter [15:0] PLATFORM3_Y_SIZE = BRICK_SIZE;

    // platform 4
    parameter [15:0] PLATFORM4_X_LEFT = PLATFORM3_X_RIGHT + 16'd20;
    parameter [15:0] PLATFORM4_X_SIZE = 16'd20;
    parameter [15:0] PLATFORM4_X_RIGHT = PLATFORM4_X_LEFT + PLATFORM4_X_SIZE;
    parameter [15:0] PLATFORM4_Y_UP = PLATFORM3_Y_UP - 'd80;
    parameter [15:0] PLATFORM4_Y_DOWN = PLATFORM4_Y_UP + BRICK_SIZE;
    parameter [15:0] PLATFORM4_Y_SIZE = BRICK_SIZE;

     // platform 5
    parameter [15:0] PLATFORM5_X_LEFT = PLATFORM4_X_RIGHT + 16'd20;
    parameter [15:0] PLATFORM5_X_SIZE = 16'd200;
    parameter [15:0] PLATFORM5_X_RIGHT = PLATFORM5_X_LEFT + PLATFORM5_X_SIZE;
    parameter [15:0] PLATFORM5_Y_UP = PLATFORM4_Y_UP - 'd80;
    parameter [15:0] PLATFORM5_Y_DOWN = PLATFORM5_Y_UP + BRICK_SIZE;
    parameter [15:0] PLATFORM5_Y_SIZE = BRICK_SIZE;

   
endpackage


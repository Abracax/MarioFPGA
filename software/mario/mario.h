#include "helper.h"
#include "io_handler.h"
#include <unistd.h>

#define W 26
#define A 4
#define D 7
#define JUMP_MAX 120
#define JUMP_STEP 4
#define ESC 41


#define MUSH_X_MAX 120
#define GND_HEIGHT 360
#define SCREEN_Y 480
#define SCREEN_X 640
#define MARIO_Y_SIZE 32
#define MARIO_X_SIZE 16
#define BRICK_SIZE 20


#define PLATFORM1_X_LEFT 200
#define PLATFORM1_X_SIZE 100
#define PLATFORM1_X_RIGHT (PLATFORM1_X_LEFT + PLATFORM1_X_SIZE)
#define PLATFORM1_Y_UP (GND_HEIGHT - 100)
#define PLATFORM1_Y_SIZE BRICK_SIZE

#define PLATFORM2_X_LEFT 330
#define PLATFORM2_X_SIZE 150
#define PLATFORM2_X_RIGHT (PLATFORM2_X_LEFT + PLATFORM2_X_SIZE)
#define PLATFORM2_Y_UP (PLATFORM1_Y_UP - 100)
#define PLATFORM2_Y_SIZE BRICK_SIZE

#define MUSHROOM_X_SIZE 20
#define MUSHROOM_Y_SIZE 20

#define MARIO_RIGHT 0
#define MARIO_RIGHT_RUN_1 1
#define MARIO_RIGHT_JUMP 2
#define MARIO_LEFT 3
#define MARIO_LEFT_RUN_1 4
#define MARIO_LEFT_JUMP 5

 // platform 3
#define PLATFORM3_X_LEFT 640
#define PLATFORM3_X_SIZE 20
#define PLATFORM3_X_RIGHT (PLATFORM3_X_LEFT + PLATFORM3_X_SIZE)
#define PLATFORM3_Y_UP  (GND_HEIGHT - 80)
#define PLATFORM3_Y_DOWN  (PLATFORM3_Y_UP + BRICK_SIZE)
#define PLATFORM3_Y_SIZE BRICK_SIZE

// platform 4
#define PLATFORM4_X_LEFT  (PLATFORM3_X_RIGHT + 20)
#define PLATFORM4_X_SIZE  20
#define PLATFORM4_X_RIGHT  (PLATFORM4_X_LEFT + PLATFORM4_X_SIZE)
#define PLATFORM4_Y_UP  (PLATFORM3_Y_UP - 80)
#define PLATFORM4_Y_DOWN  (PLATFORM4_Y_UP + BRICK_SIZE)
#define PLATFORM4_Y_SIZE  BRICK_SIZE

    // platform 5
#define PLATFORM5_X_LEFT  (PLATFORM4_X_RIGHT + 20)
#define PLATFORM5_X_SIZE  200
#define PLATFORM5_X_RIGHT (PLATFORM5_X_LEFT + PLATFORM5_X_SIZE)
#define PLATFORM5_Y_UP  (PLATFORM4_Y_UP - 80)
#define PLATFORM5_Y_DOWN  (PLATFORM5_Y_UP + BRICK_SIZE)
#define PLATFORM5_Y_SIZE  BRICK_SIZE



void move_mario();
int get_mario_x();
int get_mario_y();
void jump();
void move_while_jump();
int stopJump();
int stopFall();
int stopLeft();
int stopRight();

void move_mush();
void restart();
void die();

extern volatile int marioX;
extern volatile int marioY;
extern volatile int mushX;
extern volatile int mushY;
extern volatile int marioAlive;
extern volatile int mushAlive;
extern volatile int keycode;
extern volatile int screen_offset;

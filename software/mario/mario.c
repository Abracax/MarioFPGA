#include "mario.h"


volatile int marioX = 50;
volatile int marioY = GND_HEIGHT-MARIO_Y_SIZE;
volatile int mushX = 450;
volatile int mushY = 340;
volatile int marioAlive = 1;
volatile int mushAlive = 1;

const int X_max = 620;
const int Y_max = GND_HEIGHT-MARIO_Y_SIZE;

volatile int is_jump = 0;
volatile int is_fall = 0;
volatile int keycode = 0;
volatile int mario_X_vel = 0;
volatile int mush_X_vel = 0;
volatile int jumpCount = 0;
volatile int mushCount = 0;
volatile int screen_offset = 0;
volatile int dieCount = 0;

volatile int mario_state = MARIO_RIGHT;

volatile int marioXmax = (SCREEN_X - MARIO_X_SIZE)/2;


void move_mush()
{

	if (mushCount < MUSH_X_MAX) {
		mushX += 1;
		mushCount += 1;
	} else if (mushCount < 2*MUSH_X_MAX){
		mushX -= 1;
		mushCount +=1;
	} else {
		mushCount = 0;
	}
//	printf("mushX: %d", mushX);
	*mush_x_base = mushX;
	*mush_y_base = mushY;
}

void move_mario()
{
	if (marioAlive  == 0) {
			die();
	}
	marioX += mario_X_vel;
	if (stopLeftRight()) {
		marioX -= mario_X_vel;
		is_jump = 0;
		// jumpCount = 2*JUMP_MAX - jumpCount;
	}
	if (is_jump) {
		marioY -= JUMP_STEP;
		jumpCount += JUMP_STEP;
		if (jumpCount > JUMP_MAX || headTouchWall()) {
			marioY += JUMP_STEP;
			jumpCount = 0;
			is_jump = 0;
		}
	} else {
		marioY += JUMP_STEP;
		if (hitGround()) {
			marioY -= JUMP_STEP;
		}
	}
	int can_kill = canKillMush();
	if(can_kill == -1) {
		marioAlive = 0;	
		is_jump = 0;
	} else if (can_kill) {
		mushAlive++;
		is_jump = 0;
		mushX += 1000;
	}
	if (marioX > marioXmax) {
		marioXmax = marioX;
	}
	if (mario_X_vel > 0) {
		if (!onGround()) {
			mario_state = MARIO_RIGHT_JUMP;
		} else {
			mario_state = MARIO_RIGHT;
		}
	} else if (mario_X_vel < 0){
		if (!onGround()) {
			mario_state = MARIO_LEFT_JUMP;
		} else {
			mario_state = MARIO_LEFT;
		}
	} else {
		if (!onGround()) {
			if (mario_state <= MARIO_RIGHT_JUMP) {
				mario_state = MARIO_RIGHT_JUMP;
			} else {
				mario_state = MARIO_LEFT_JUMP;
			}
		} else {
			if (mario_state <= MARIO_RIGHT_JUMP) {
				mario_state = MARIO_RIGHT;
			} else {
				mario_state = MARIO_LEFT;
			}
		}
	}
	
	screen_offset = marioXmax-((SCREEN_X - MARIO_X_SIZE)/2);
	*mario_x_base = marioX;
	*mario_y_base = marioY;
	*mario_alive_base = marioAlive;
	*mush_alive_base = mushAlive;
	*screen_offset_base = screen_offset;
	*mario_state_base = mario_state & 0xff;


}

int hitGround() {
	if(XCloseObstacle(PLATFORM1_X_LEFT,PLATFORM1_X_RIGHT) && marioY > PLATFORM1_Y_UP-MARIO_Y_SIZE && marioY < PLATFORM1_Y_UP) {
		return 1;
	}
	if(XCloseObstacle(PLATFORM2_X_LEFT,PLATFORM2_X_RIGHT) && marioY > PLATFORM2_Y_UP-MARIO_Y_SIZE && marioY < PLATFORM2_Y_UP) {
		return 1;
	}
	if(XCloseObstacle(PLATFORM3_X_LEFT,PLATFORM3_X_RIGHT) && marioY > PLATFORM3_Y_UP-MARIO_Y_SIZE && marioY < PLATFORM3_Y_UP) {
		return 1;
	}
	if(XCloseObstacle(PLATFORM4_X_LEFT,PLATFORM4_X_RIGHT) && marioY > PLATFORM4_Y_UP-MARIO_Y_SIZE && marioY < PLATFORM4_Y_UP) {
		return 1;
	}
	if(XCloseObstacle(PLATFORM5_X_LEFT,PLATFORM5_X_RIGHT) && marioY > PLATFORM5_Y_UP-MARIO_Y_SIZE && marioY < PLATFORM5_Y_UP) {
		return 1;
	}
	if(marioY > Y_max) {
		return 1;
	}
	
	return 0;
}

int onGround() {
	int ret;
	marioY += JUMP_STEP;
	ret = hitGround();
	marioY -= JUMP_STEP;
	return ret;
}

int checkIsFall() {
	if (!is_jump) return 0;
	if( jumpCount < 2*JUMP_MAX || jumpCount == 0) return 0;
	if (marioY != PLATFORM1_Y_UP && marioY != PLATFORM2_Y_UP && marioY != GND_HEIGHT && marioY != PLATFORM3_Y_UP && marioY != PLATFORM4_Y_UP && marioY != PLATFORM5_Y_UP){
		jumpCount = 0;
		is_fall = 1;
		return 1;
	}
		
	return 0;
}


void handle_keycode()
{
	int keycode1 = keycode & 0xff;
	int keycode2 = (keycode & 0xff00)>>8;
	mario_X_vel = 0;
	switch(keycode1) {
	case D:

		mario_X_vel++;

		break;
	case A:

		mario_X_vel--;

		break;
	case W:
		marioY += JUMP_STEP;
		if (hitGround()) {
			is_jump=1;
		}
		marioY -= JUMP_STEP;
		break;
	case ESC:
		restart();
		break;
	default:
		break;
	}
	if (keycode1 != keycode2) {
		switch(keycode2) {
			case D:

				mario_X_vel++;

				break;
			case A:
			
				mario_X_vel--;

				break;
			case W:
				marioY += JUMP_STEP;
				if (hitGround()) {
					is_jump = 1;
				}
				marioY -= JUMP_STEP;
				break;
			case ESC:
				restart();
				break;
			default:
				break;
		}
	}
//	printf("x: %d", mario_X_vel);
}

int headTouchWall() {
	if (YUpperCloseObstacle(PLATFORM1_Y_UP+PLATFORM1_Y_SIZE, PLATFORM1_Y_UP) 
		&& XCloseObstacle(PLATFORM1_X_LEFT, PLATFORM1_X_RIGHT)) return 1;
	if (YUpperCloseObstacle(PLATFORM2_Y_UP+PLATFORM2_Y_SIZE, PLATFORM2_Y_UP) 
		&& XCloseObstacle(PLATFORM2_X_LEFT, PLATFORM2_X_RIGHT)) return 1;
	if (YUpperCloseObstacle(PLATFORM3_Y_UP+PLATFORM3_Y_SIZE, PLATFORM3_Y_UP) 
		&& XCloseObstacle(PLATFORM3_X_LEFT, PLATFORM3_X_RIGHT)) return 1;
	if (YUpperCloseObstacle(PLATFORM4_Y_UP+PLATFORM4_Y_SIZE, PLATFORM4_Y_UP) 
		&& XCloseObstacle(PLATFORM4_X_LEFT, PLATFORM4_X_RIGHT)) return 1;
	if (YUpperCloseObstacle(PLATFORM5_Y_UP+PLATFORM5_Y_SIZE, PLATFORM5_Y_UP) 
		&& XCloseObstacle(PLATFORM5_X_LEFT, PLATFORM5_X_RIGHT)) return 1;
	if (marioY < 0) return 1;
	return 0;
}

void die() {
	dieCount++;
	marioAlive = 0;
	if (dieCount >= 80) {
		dieCount = 0;
		restart();
	}
}

void restart() {
	marioX = 50;
	marioY = GND_HEIGHT-MARIO_Y_SIZE;
	mushX = 450;
	mushY = 340;
	marioAlive = 1;
	mushAlive = 1;
	is_jump = 0;
	is_fall = 0;
	keycode = 0;
	mario_X_vel = 0;
	mush_X_vel = 0;
	jumpCount = 0;
	mushCount = 0;
	screen_offset = 0;

	mario_state = MARIO_RIGHT;
	dieCount = 0;
	marioXmax = (SCREEN_X - MARIO_X_SIZE)/2;
}

int stopJump()
{

 	return (is_jump >= JUMP_MAX) || marioY <= 0;
}

int stopFall()
{

	return (is_jump == 0) || marioY > 479;
}

int stopLeftRight()
{
	if(YCloseObstacle(PLATFORM1_Y_UP+PLATFORM1_Y_SIZE, PLATFORM1_Y_UP) 
		&& (marioX%1000 == PLATFORM1_X_RIGHT || (marioX + MARIO_X_SIZE)%1000 == PLATFORM1_X_LEFT)) return 1;
	if(YCloseObstacle(PLATFORM2_Y_UP+PLATFORM2_Y_SIZE, PLATFORM2_Y_UP) 
		&& (marioX%1000 == PLATFORM2_X_RIGHT || (marioX + MARIO_X_SIZE)%1000 == PLATFORM2_X_LEFT)) return 1;
	if(YCloseObstacle(PLATFORM3_Y_UP+PLATFORM3_Y_SIZE, PLATFORM3_Y_UP) 
		&& (marioX%1000 == PLATFORM3_X_RIGHT || (marioX + MARIO_X_SIZE)%1000 == PLATFORM3_X_LEFT)) return 1;
	if(YCloseObstacle(PLATFORM4_Y_UP+PLATFORM4_Y_SIZE, PLATFORM4_Y_UP) 
		&& (marioX%1000 == PLATFORM4_X_RIGHT || (marioX + MARIO_X_SIZE)%1000 == PLATFORM4_X_LEFT)) return 1;
	if(YCloseObstacle(PLATFORM5_Y_UP+PLATFORM5_Y_SIZE, PLATFORM5_Y_UP) 
		&& (marioX%1000 == PLATFORM5_X_RIGHT || (marioX + MARIO_X_SIZE)%1000 == PLATFORM5_X_LEFT)) return 1;
	return (marioX < screen_offset); //|| (marioX >= SCREEN_X);
}

int stopRight()
{



	return (marioX >= 639);

}


int XCloseObstacle(int obs_X_left, int obs_X_right){
	if (mushX == obs_X_left) {
		return ((marioX + MARIO_X_SIZE) >= obs_X_left && marioX  < obs_X_right);
	} else {
		return ((marioX + MARIO_X_SIZE)%1000 >= obs_X_left && (marioX%1000)  < obs_X_right);
	}
}

int YCloseObstacle(int obs_Y_down, int obs_Y_up){
	return ((marioY+ MARIO_Y_SIZE) > obs_Y_up && marioY < obs_Y_down);
}

int YUpperCloseObstacle(int obs_Y_down, int obs_Y_up){
	return (marioY >= obs_Y_up && marioY <= obs_Y_down);
}

int YDownCloseObstacle(int obs_Y_down, int obs_Y_up){
	return ((marioY+MARIO_Y_SIZE) >= obs_Y_up && (marioY+MARIO_Y_SIZE) <= obs_Y_down);
}


/*
	return 0 if not close to mushroom, 1 if kills, -1 if mario dead.
*/
int canKillMush() {
	if(!mushAlive) return 0;
	if (XCloseObstacle(mushX, mushX+MUSHROOM_X_SIZE)){
		if (!YDownCloseObstacle(mushY+MUSHROOM_Y_SIZE, mushY))
			return 0;
		if(YDownCloseObstacle(mushY+4, mushY))
			return 1;
		return -1;
	}
	return 0;
}

void jump()
{if (is_jump != 0) {
	if (is_jump > 0) {
		if (stopJump()) {
			is_jump = -JUMP_MAX;
		} else {
			marioY -= 1;
			is_jump += 1;
			*mario_y_base = marioY;
			//usleep(1000);
		}
	} else {
		if (stopFall()) {
			is_jump = 0;
		} else {
			marioY += 1;
			is_jump += 1;
			*mario_y_base = marioY;
			//usleep(1000);
		}
	}
}
}

void fall()
{
	marioY += 10;
	is_jump += 10;
	*mario_y_base = marioY;
	//usleep(1000);
}




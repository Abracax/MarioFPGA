//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------
import Numbers::*;
// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper (  input    logic    Clk, Reset,
                        input logic [15:0]   keycode,
                        input logic [15:0] MarioX, MarioY,
                        input logic [15:0] mushX, mushY,
                        input logic [7:0] mushAlive, MarioAlive,
                        input logic [15:0] screen_offset,
                        input    logic    [9:0]  DrawX, DrawY,
                        input    logic    [23:0] Data_In,	
                        output   logic    [7:0] VGA_R, VGA_G, VGA_B,
                        output   logic    [19:0] Addr,
                        input    logic    [3:0] Mario_Animation,
                        input    logic    [7:0] scores
                     );
    
    logic [7:0] Red, Green, Blue, R, G, B, Rx, Bx, Gx;
	 logic    [3:0] Sprite;
    int read_address, address_next, AX, AY,X,Y;
    logic [15:0] ActualX, ActualY;

    int points;
    assign points = score;



        
    always_comb begin
        ActualX = {6'b0, DrawX} + screen_offset;
        ActualY = {6'b0, DrawY};

        point_fir = 'h30 + points / 100;
        point_sec = 'h30+ (points-point_fir*100)/10;
        point_third = 'h30 + points % 10;

        point_fir_addr_start = 11'(point_fir * 16);
        point_fir_addr_end = 11'(point_fir * 16 + 15);

        point_sec_addr_start = 11'(point_sec * 16);
        point_sec_addr_end = 11'(point_sec * 16 + 15);

        point_third_addr_start = 11'(point_third * 16);
        point_third_addr_end = 11'(point_third * 16 + 15);
          
        

        if ((Mario_Animation==MARIO_RIGHT) && MarioAlive && (ActualX >= MarioX) && (ActualX < (MarioX + MARIO_X_SIZE)) && (ActualY >= MarioY) && (ActualY < (MarioY + MARIO_Y_SIZE))) begin
             Sprite = SPRITE_MARIO;
             X = ActualX-MarioX;
             Y = ActualY-MarioY;
        end
        else if ((Mario_Animation==MARIO_RIGHT_JUMP) && MarioAlive && (ActualX >= MarioX) && (ActualX < (MarioX + MARIO_X_SIZE)) && (ActualY >= MarioY) && (ActualY < (MarioY + MARIO_Y_SIZE))) begin
            Sprite = SPRITE_RIGHT_JUMP;
            X = ActualX-MarioX;
            Y = ActualY-MarioY;
        end
        else if ((Mario_Animation==MARIO_LEFT) && MarioAlive && (ActualX >= MarioX) && (ActualX < (MarioX + MARIO_X_SIZE)) && (ActualY >= MarioY) && (ActualY < (MarioY + MARIO_Y_SIZE))) begin
            Sprite = SPRITE_LEFT_MARIO;
            X = ActualX-MarioX;
            Y = ActualY-MarioY;
        end
		else if (Mario_Animation==MARIO_LEFT_JUMP && MarioAlive && (ActualX >= MarioX) && (ActualX < (MarioX + MARIO_X_SIZE)) && (ActualY >= MarioY) && (ActualY < (MarioY + MARIO_Y_SIZE))) begin
            Sprite = SPRITE_LEFT_JUMP;
            X = ActualX-MarioX;
            Y = ActualY-MarioY;
        end
        else if (ActualY >= GND_HEIGHT && ActualY < GND_HEIGHT + 2*BRICK_SIZE)
        begin
            Sprite = SPRITE_BRICK;
            X = ActualX % BRICK_SIZE;
            Y= (ActualY-GND_HEIGHT) % BRICK_SIZE;
        end
        else if (mushAlive && ActualX >= mushX && ActualY < mushY+MUSHROOM_RAM_Y && ActualY >= mushY && ActualX < mushX+MUSHROOM_RAM_X)
        begin
            Sprite = SPRITE_MUSHROOM;
            X = ActualX - mushX;
            Y= ActualY-mushY;
        end
        else if (ActualY >= PLATFORM1_Y_LEFT && ActualY < (PLATFORM1_Y_LEFT+PLATFORM1_Y_SIZE) && (ActualX%16'd1000) >= PLATFORM1_X_LEFT && (ActualX%16'd1000) <= (PLATFORM1_X_LEFT+PLATFORM1_X_SIZE))
        begin
            Sprite = SPRITE_BRICK;
            X = (ActualX%16'd1000) % BRICK_SIZE;
            Y= (ActualY-PLATFORM1_Y_LEFT) % BRICK_SIZE;
        end
        else if (ActualY >= PLATFORM2_Y_LEFT && ActualY < (PLATFORM2_Y_LEFT+PLATFORM2_Y_SIZE) && (ActualX%16'd1000) >= PLATFORM2_X_LEFT && (ActualX%16'd1000) <= (PLATFORM2_X_LEFT+PLATFORM2_X_SIZE))
        begin
            Sprite = SPRITE_BRICK;
            X = (ActualX%16'd1000) % BRICK_SIZE;
            Y= (ActualY-PLATFORM2_Y_LEFT) % BRICK_SIZE;
        end
        else if (ActualY >= PLATFORM3_Y_UP && ActualY < PLATFORM3_Y_DOWN && (ActualX%16'd1000) >= PLATFORM3_X_LEFT && (ActualX%16'd1000) <= PLATFORM3_X_RIGHT)
        begin
            Sprite = SPRITE_BRICK;
            X = (ActualX%16'd1000) % BRICK_SIZE;
            Y= (ActualY-PLATFORM3_Y_UP) % BRICK_SIZE;
        end
        else if (ActualY >= PLATFORM4_Y_UP && ActualY < PLATFORM4_Y_DOWN && (ActualX%16'd1000) >= PLATFORM4_X_LEFT && (ActualX%16'd1000) <= PLATFORM4_X_RIGHT)
        begin
            Sprite = SPRITE_BRICK;
            X = (ActualX%16'd1000) % BRICK_SIZE;
            Y= (ActualY-PLATFORM4_Y_UP) % BRICK_SIZE;
        end
        else if (ActualY >= PLATFORM5_Y_UP && ActualY < PLATFORM5_Y_DOWN && (ActualX%16'd1000) >= PLATFORM5_X_LEFT && (ActualX%16'd1000) <= PLATFORM5_X_RIGHT)
        begin
            Sprite = SPRITE_BRICK;
            X = (ActualX%16'd1000) % BRICK_SIZE;
            Y= (ActualY-PLATFORM5_Y_UP) % BRICK_SIZE;
        end
        else begin
            Sprite = SPRITE_BG;
            X = ActualX % BG_RAM_X;
            Y= ActualY;
        end
    end


    enum logic [1:0] {FIRST, SECOND,THIRD} state, next_state;

    always_ff @ (posedge Clk)
    begin
        if (Reset) begin
            read_address <= BG_RAM_OFFSET+ ActualY*BG_RAM_X+ActualX;;
            state <= FIRST;
            VGA_R <= R;
            VGA_G <= G;
            VGA_B <= B;
		  end
        else begin
            read_address <= address_next;
            state <= next_state;
            VGA_R <= R;
            VGA_G <= G;
            VGA_B <= B;
		  end
    end

    assign AX = X;
    assign AY = Y;

    always_comb
    begin
        case(state) 
            FIRST:begin
                next_state = SECOND;
                R=VGA_R;
                G=VGA_G;
                B=VGA_B;
                case(Sprite)
                    SPRITE_MARIO:begin
                         address_next=AY*MARIO_RAM_X+AX;
                    end
                    SPRITE_RIGHT_JUMP:begin
                        address_next=RIGHT_JUMP_RAM_OFFSET+AY*MARIO_RAM_X+AX;
                    end
                    SPRITE_LEFT_MARIO:begin
                        address_next=LEFT_MARIO_RAM_OFFSET+AY*MARIO_RAM_X+AX;
                    end
                    SPRITE_LEFT_JUMP:begin
                        address_next=LEFT_JUMP_RAM_OFFSET+AY*MARIO_RAM_X+AX;
                    end
                    SPRITE_BRICK:begin
                        address_next=BRICK_RAM_OFFSET+AY*BRICK_RAM_X+AX;
                    end
                    SPRITE_MUSHROOM:begin
                        address_next=MUSHROOM_RAM_OFFSET+AY*MUSHROOM_RAM_X+AX;
                    end
                    SPRITE_PIPE:begin
                        address_next=PIPE_RAM_OFFSET+AY*PIPE_RAM_X+AX;
                    end
                    SPRITE_CLOUD:begin
                        address_next=CLOUD_RAM_OFFSET+AY*CLOUD_RAM_X+AX;
                    end
                    SPRITE_BG:begin
                        address_next=BG_RAM_OFFSET+AY*BG_RAM_X+AX;
                    end
                    default:begin
                        address_next=BG_RAM_OFFSET+AY*BG_RAM_X+AX;
                    end
                endcase
            end
            SECOND:begin 
                R = Data_In[23:16];
                G = Data_In[15:8];
                B = Data_In[7:0];             
                if(Data_In == 24'd0 && Sprite != SPRITE_BRICK) begin
                    next_state = THIRD;
                    address_next=BG_RAM_OFFSET+ ActualY*BG_RAM_X+ActualX;
                    R=VGA_R;
                    G=VGA_G;
                    B=VGA_B;
                end else begin
                    next_state = FIRST;
					address_next=read_address;
                end
            end
			THIRD: begin
                address_next=BG_RAM_OFFSET+ ActualY*BG_RAM_X+ActualX;
                next_state = FIRST;
                R = Data_In[23:16];
                G = Data_In[15:8];
                B = Data_In[7:0];
            end
            default:begin
                address_next=BG_RAM_OFFSET+ ActualY*BG_RAM_X+ActualX;
                next_state = FIRST;
                R = Data_In[23:16];
                G = Data_In[15:8];
                B = Data_In[7:0];
            end
        endcase
            
    end

    assign Addr = 20'(read_address);

	 
endmodule

// Created by Seok 2021.11.18 
// Morse Code -- CS207 Digital Design Final Project

module input_led (
    input            clk,               // clock          
    input            reset,             // reset signal
    input            dot,               // short input
    input            dush,              // long input
    input            decode,            // decode button
    input            backspace,         // backspace button
    input      [7:0] sw_encoder,        // switch for each number
    input            sw_total,          // switch for total number
    input            speed_dot,         // the time of dot beep
    input            speed_dush,        // the time of dush beep
    input            sw_state,          // switch the state (encode or decode)
    input      [3:0] row,               // keyboard row
    output     [3:0] col,               // keyboard col
    output reg [2:0] error,             // led lights flash when meet error
    output           sw_state_show,     // To show the state(encode or decode) 
    output           sw_state_show2,
    output           sw_state_show3,
    output reg       beep,
    output     [4:0] in,                // To show the state of input now
    output     [4:0] out,               // To show the state of input now
    output     [7:0] seg_en,            // For 7-SEG
    output     [7:0] seg_out            // For 7-SEG
);

//-------------------参数部分---------------------
localparam  NO_INPUT = 5'b00000,
            INPUT_1 = 5'b10000,
            INPUT_2 = 5'b11000,
            INPUT_3 = 5'b11100,
            INPUT_4 = 5'b11110,
            INPUT_5 = 5'b11111,

            l_00000 = 5'b00000,
            l_10000 = 5'b10000,
            l_01000 = 5'b01000,
            l_11000 = 5'b11000,
            l_00100 = 5'b00100,
            l_10100 = 5'b10100,
            l_01100 = 5'b01100,
            l_11100 = 5'b11100,
            l_00010 = 5'b00010,
            l_10010 = 5'b10010,
            l_01010 = 5'b01010,
            l_11010 = 5'b11010,
            l_00110 = 5'b00110,
            l_10110 = 5'b10110,
            l_01110 = 5'b01110,
            l_11110 = 5'b11110,
            l_00001 = 5'b00001,
            l_10001 = 5'b10001,
            l_01001 = 5'b01001,
            l_11001 = 5'b11001,
            l_00101 = 5'b00101,
            l_10101 = 5'b10101,
            l_01101 = 5'b01101,
            l_11101 = 5'b11101,
            l_00011 = 5'b00011,
            l_10011 = 5'b10011,
            l_01011 = 5'b01011,
            l_11011 = 5'b11011,
            l_00111 = 5'b00111,
            l_10111 = 5'b10111,
            l_01111 = 5'b01111,
            l_11111 = 5'b11111;


localparam[ 5 : 0 ] BLANK = 6 'b000000,
                    A     = 6 'b000001,
                    B     = 6 'b000010,
                    C     = 6 'b000011,
                    D     = 6 'b000100,
                    E     = 6 'b000101,
                    F     = 6 'b000110,
                    G     = 6 'b000111,
                    H     = 6 'b001000,
                    I     = 6 'b001001,
                    J     = 6 'b001010,
                    K     = 6 'b001011,
                    L     = 6 'b001100,
                    M     = 6 'b001101,
                    N     = 6 'b001110,
                    O     = 6 'b001111,
                    P     = 6 'b010000,
                    Q     = 6 'b010001,
                    R     = 6 'b010010,
                    S     = 6 'b010011,
                    T     = 6 'b010100,
                    U     = 6 'b010101,
                    V     = 6 'b010110,
                    W     = 6 'b010111,
                    X     = 6 'b011000,
                    Y     = 6 'b011001,
                    Z     = 6 'b011010,
                    ONE   = 6 'b011011,
                    TWO   = 6 'b011100,
                    THREE = 6 'b011101,
                    FOUR  = 6 'b011110,
                    FIVE  = 6 'b011111,
                    SIX   = 6 'b100000,
                    SEVEN = 6 'b100001,
                    EIGHT = 6 'b100010,
                    NINE  = 6 'b100011,
                    ZERO  = 6 'b100100,
                    BEFORETWO = 6 'b100101,
                    BEFOREEIGHT = 6 'b100110,
                    BEFORENINE = 6 'b100111;

//----------------------------------------------------

// --------------LED显示当前状态(编码还是解码)---------------
assign sw_state_show = sw_state;
assign sw_state_show2 = sw_state;
assign sw_state_show3 = sw_state;

// -----------键盘输入模块-------------
wire [5:0] keyboard_val;
key_top u1(clk,reset,decode,row,col,keyboard_val);


// -------------蜂鸣器部分--------------
// ---------每个拨码开关对应一个七段数码显示管-----------
reg [5:0] val1;
reg [5:0] val2;
reg [5:0] val3;
reg [5:0] val4;
reg [5:0] val5;
reg [5:0] val6;
reg [5:0] val7;
               
reg [5:0]val;
reg [5:0]val_next;

wire beep0;
wire beep1;
wire beep2;
wire beep3;
wire beep4;
wire beep5;
wire beep6;
wire beep7;

beep_encoder b0(clk,speed_dot,speed_dush,~sw_encoder[0],val ,beep0);
beep_encoder b1(clk,speed_dot,speed_dush,~sw_encoder[1],val1,beep1);
beep_encoder b2(clk,speed_dot,speed_dush,~sw_encoder[2],val2,beep2);
beep_encoder b3(clk,speed_dot,speed_dush,~sw_encoder[3],val3,beep3);
beep_encoder b4(clk,speed_dot,speed_dush,~sw_encoder[4],val4,beep4);
beep_encoder b5(clk,speed_dot,speed_dush,~sw_encoder[5],val5,beep5);
beep_encoder b6(clk,speed_dot,speed_dush,~sw_encoder[6],val6,beep6);
beep_encoder b7(clk,speed_dot,speed_dush,~sw_encoder[7],val7,beep7);

// ---------一个拨码开关播放所有字符-----------
wire beep_total;
beep_encoder_total b8(clk,speed_dot,speed_dush,~sw_total,val,val1,val2,val3,val4,val5,val6,val7,beep_total);

always @(*) begin
    case ({sw_encoder,sw_total})
        9'b0000_00001: beep = beep_total;
        9'b0000_00010: beep = beep0;
        9'b0000_00100: beep = beep1;
        9'b0000_01000: beep = beep2;
        9'b0000_10000: beep = beep3;
        9'b0001_00000: beep = beep4;
        9'b0010_00000: beep = beep5;
        9'b0100_00000: beep = beep6;
        9'b1000_00000: beep = beep7;
        default: beep = 1'b0;
    endcase
end
// ---------------蜂鸣器部分结束--------------


// ------------------分频块---------------------

reg [23:0] cnt;                     // 计数子
wire key_clk;
always @ (posedge clk or posedge reset)begin
    if (reset)
        cnt <= 0;
    else
        cnt <= cnt + 1'b1;
end

assign key_clk = cnt[23]; 
// ----------分频结束------------


// ----------解码状态机部分------------
reg [4:0] current_state, next_state;
assign in = current_state;
reg [4:0] led;
reg [4:0] led_next;
assign out = led;

// 刷新状态
always @(posedge key_clk or posedge reset) begin
    if(reset) begin
            current_state <= NO_INPUT;
            led <= l_00000;
            val <= BLANK;
            val1 <= BLANK;
            val2 <= BLANK;
            val3 <= BLANK;
            val4 <= BLANK;
            val5 <= BLANK;
            val6 <= BLANK;
            val7 <= BLANK;
        end
    else
    case(sw_state)
        1'b1:    
            if (decode) begin
                if (val==BLANK) begin
                    error = 3'b111;
                    current_state <= NO_INPUT;
                    led <= l_00000;

                end
                else begin
                    current_state <= NO_INPUT;
                    led <= l_00000;
                    val7 <= val6;
                    val6 <= val5;
                    val5 <= val4;
                    val4 <= val3;
                    val3 <= val2;
                    val2 <= val1;
                    val1 <= val;
                    val <= BLANK;
                end
            end
            else begin
                error = 3'h0;
                current_state <= next_state;
                led <= led_next;
                val <= val_next;
            end
   
        1'b0: begin
            if(decode) begin
                if (val==BLANK) begin
                    
                end
                else begin
                    val7 <= val6;
                    val6 <= val5;
                    val5 <= val4;
                    val4 <= val3;
                    val3 <= val2;
                    val2 <= val1;
                    val1 <= val;
                    val <= BLANK;
                end
            end
            //  实现退格功能
            else if (backspace)begin
                val7 <= BLANK;
                val6 <= val7;
                val5 <= val6;
                val4 <= val5;
                val3 <= val4;
                val2 <= val3;
                val1 <= val2;
                // val <= val1;
            end

            else begin
                val <= keyboard_val;
            end
        end
        default:begin

        end
    endcase
end

// 解码状态机
always @(dot or dush or backspace)begin
    case(current_state)
        NO_INPUT:begin
                // error2 = 3'b000;
                case({dot,dush})
                    2'b10: begin
                        next_state = INPUT_1;
                        led_next = l_00000;
                        val_next = E;
                    end
                    2'b01: begin
                        next_state = INPUT_1;
                        led_next = l_10000;
                        val_next = T;
                   end
                    default: begin 
                        next_state = NO_INPUT;
                        led_next = led;
                        val_next = BLANK;
                    end
                endcase
        end
        INPUT_1:begin
                case({dot,dush,backspace})
                    3'b100: begin
                        next_state = INPUT_2; 
                        case (led[4])
                            0:begin 
                                led_next = l_00000;
                                val_next = I;
                            end
                            1:begin
                                led_next = l_10000; 
                                val_next = N;
                            end
                            default: begin
                                led_next = led;
                                val_next = val;
                            end
                        endcase
                    end
                    3'b010: begin
                        next_state = INPUT_2;
                        case (led[4])
                            0:begin
                                led_next = l_01000;
                                val_next = A;
                            end
                            1:begin
                                led_next = l_11000; 
                                val_next = M;
                            end
                            default: begin
                                led_next = led;
                                val_next = val;
                            end
                        endcase
                    end
                    3'b001: begin
                        next_state = NO_INPUT;
                        led_next = l_00000;
                        val_next = BLANK;

                    end
                    default: begin 
                        next_state = INPUT_1;
                        led_next = led;
                        val_next = val;
                    end
                endcase
        end
        INPUT_2:begin
                case({dot,dush,backspace})
                    3'b100: begin
                        next_state = INPUT_3; 
                        case ({led[4],led[3]})
                            2'b00:begin
                                led_next = l_00000; 
                                val_next = S;
                            end
                            2'b01:begin
                                led_next = l_01000; 
                                val_next = R;
                            end
                            2'b10:begin
                                led_next = l_10000; 
                                val_next = D;
                            end
                            2'b11:begin
                                led_next = l_11000; 
                                val_next = G;
                            end
                            default: begin
                                led_next = led;
                                val_next = val;
                            end
                        endcase
                    end
                    3'b010: begin
                        next_state = INPUT_3;
                        case ({led[4],led[3]})
                            2'b00:begin
                                led_next = l_00100; 
                                val_next = U;
                            end
                            2'b01:begin
                                led_next = l_01100; 
                                val_next = W; 
                            end
                            2'b10:begin
                                led_next = l_10100; 
                                val_next = K;
                            end
                            2'b11:begin
                                led_next = l_11100; 
                                val_next = O; 
                            end
                            default: begin
                                led_next = led;
                                val_next = val; 
                            end
                        endcase
                    end
                    3'b001:begin
                        next_state = INPUT_1;
                        case (led[4])
                            1'b0:begin
                                led_next = l_00000;
                                val_next = E;
                            end 
                            1'b1:begin
                                led_next = l_10000;
                                val_next = T;
                            end
                            default: begin
                                led_next = led;
                                val_next = val; 
                            end
                        endcase

                    end
                    default: begin 
                        next_state = INPUT_2;
                        led_next = led;
                        val_next = val;
                    end
                endcase
        end
        INPUT_3: begin
                case({dot,dush,backspace}) 
                    3'b100: begin
                        next_state = INPUT_4; 
                        case ({led[4],led[3],led[2]})
                            3'b000:begin
                                led_next = l_00000; 
                                val_next = H;
                            end
                            3'b001:begin
                                led_next = l_00100; 
                                val_next = F;
                            end
                            3'b010:begin 
                                led_next = l_01000; 
                                val_next = L;
                            end    
                            3'b011:begin
                                led_next = l_01100; 
                                val_next = P;
                            end
                            3'b100:begin
                                led_next = l_10000; 
                                val_next = B;
                            end
                            3'b101:begin
                                led_next = l_10100; 
                                val_next = C;
                            end
                            3'b110:begin 
                                led_next = l_11000; 
                                val_next = Z;
                            end    
                            3'b111:begin
                                led_next = l_11100; 
                                val_next = BLANK;                   
                            end
                            default: begin 
                                led_next = led;
                                val_next = val;
                            end
                        endcase
                    end
                    3'b010:begin
                        next_state = INPUT_4;
                        case ({led[4],led[3],led[2]})
                            3'b000:begin
                                led_next = l_00010; 
                                val_next = V;
                            end
                            3'b001:begin
                                led_next = l_00110; 
                                val_next = BLANK;
                            end
                            3'b010:begin 
                                led_next = l_01010; 
                                val_next = BLANK;
                            end    
                            3'b011:begin
                                led_next = l_01110; 
                                val_next = J;
                            end
                            3'b100:begin
                                led_next = l_10010; 
                                val_next = X;
                            end
                            3'b101:begin
                                led_next = l_10110; 
                                val_next = Y;
                            end
                            3'b110:begin 
                                led_next = l_11010; 
                                val_next = Q;
                            end    
                            3'b111:begin
                                led_next = l_11110; 
                                val_next = BLANK;                   
                            end
                            default: begin 
                                led_next = led;
                                val_next = val;
                            end
                        endcase
                    end
                    3'b001:begin
                        next_state = INPUT_2;
                        case({led[4],led[3]})
                            2'b00:begin
                                led_next = l_00000;
                                val_next = I;
                            end
                            2'b01:begin
                                led_next = l_01000;
                                val_next = A;
                            end
                            2'b10:begin
                                led_next = l_10000; 
                                val_next = N;
                            end
                            2'b11:begin
                                led_next = l_11000; 
                                val_next = M;
                            end
                            default:begin
                               led_next = led;
                               val_next = val; 
                            end
                        endcase
                    end
                    default: begin 
                        next_state = INPUT_3;
                        led_next = led;
                        val_next = val;
                    end
                endcase
        end
        INPUT_4:begin
                case({dot,dush,backspace})
                    3'b100: begin
                        next_state = INPUT_5; 
                        case ({led[4],led[3],led[2],led[1]})
                            4'b0000:begin
                                led_next = l_00000; 
                                val_next = FIVE;
                            end
                            4'b0001:begin
                                led_next = l_00010; 
                                val_next = BLANK;
                            end
                            4'b0010:begin
                                led_next = l_00100; 
                                val_next = BLANK;
                            end
                            4'b0011:begin
                                led_next = l_00110; 
                                val_next = BLANK;
                            end
                            4'b0100:begin
                                led_next = l_01000; 
                                val_next =  BLANK;
                            end
                            4'b0101:begin
                                led_next = l_01010; 
                                val_next = BLANK;
                            end
                            4'b0110:begin
                                led_next = l_01100; 
                                val_next =  BLANK;
                            end
                            4'b0111:begin
                                led_next = l_01110; 
                                val_next = BLANK;
                            end
                            4'b1000:begin
                                led_next = l_10000; 
                                val_next = SIX; 
                            end
                            4'b1001:begin
                                led_next = l_10010; 
                                val_next = BLANK; 
                            end
                            4'b1010:begin
                                led_next = l_10100; 
                                val_next = BLANK; 
                            end
                            4'b1011:begin
                                led_next = l_10110; 
                                val_next = BLANK; 
                            end
                            4'b1100:begin
                                led_next = l_11000; 
                                val_next = SEVEN; 
                            end
                            4'b1101:begin
                                led_next = l_11010; 
                                val_next = BLANK; 
                            end
                            4'b1110:begin
                                led_next = l_11100; 
                                val_next = EIGHT; 
                            end 
                            4'b1111:begin
                                led_next = l_11110; 
                                val_next = NINE; 
                            end 
                            default: begin
                                led_next = led;
                                val_next = val;
                            end 
                        endcase
                    end
                    3'b010: begin
                        next_state = INPUT_5;
                        
                        case ({led[4],led[3],led[2],led[1]})
                            4'b0000:begin
                                led_next = l_00001; 
                                val_next = FOUR;
                            end
                            4'b0001:begin
                                led_next = l_00011; 
                                val_next = THREE;
                            end
                            4'b0010:begin
                                led_next = l_00101; 
                                val_next = BLANK;
                            end
                            4'b0011:begin
                                led_next = l_00111; 
                                val_next = TWO;
                            end
                            4'b0100:begin
                                led_next = l_01001; 
                                val_next =  BLANK;
                            end
                            4'b0101:begin
                                led_next = l_01011; 
                                val_next = BLANK;
                            end
                            4'b0110:begin
                                led_next = l_01101; 
                                val_next =  BLANK;
                            end
                            4'b0111:begin
                                led_next = l_01111; 
                                val_next = ONE;
                            end
                            4'b1000:begin
                                led_next = l_10001; 
                                val_next = BLANK; 
                            end
                            4'b1001:begin
                                led_next = l_10011; 
                                val_next = BLANK; 
                            end
                            4'b1010:begin
                                led_next = l_10101; 
                                val_next = BLANK; 
                            end
                            4'b1011:begin
                                led_next = l_10111; 
                                val_next = BLANK; 
                            end
                            4'b1100:begin
                                led_next = l_11001; 
                                val_next = SEVEN; 
                            end
                            4'b1101:begin
                                led_next = l_11011; 
                                val_next = BLANK; 
                            end
                            4'b1110:begin
                                led_next = l_11101; 
                                val_next = EIGHT; 
                            end 
                            4'b1111:begin
                                led_next = l_11111; 
                                val_next = ZERO; 
                            end 
                            default: begin
                                led_next = led;
                                val_next = val;
                            end 
                        endcase
                    end
                    3'b001:begin
                        next_state = INPUT_3;
                        case({led[4],led[3],led[2]})
                            3'b000:begin
                                led_next = l_00000;
                                val_next = S;
                            end
                            3'b001:begin
                                led_next = l_00100;
                                val_next = U;
                            end
                            3'b010:begin
                                led_next = l_01000;
                                val_next = R;
                            end
                            3'b011:begin
                                led_next = l_01100;
                                val_next = W;
                            end
                            3'b100:begin
                                led_next = l_10000;
                                val_next = D;
                            end
                            3'b101:begin
                                led_next = l_10100;
                                val_next = K;
                            end
                            3'b110:begin
                                led_next = l_11000;
                                val_next = G;
                            end
                            3'b111:begin
                                led_next = l_11100;
                                val_next = O;
                            end
                            default:begin
                                led_next = led;
                                val_next = val;
                            end
                        endcase
                    end
                    default: begin 
                        next_state = INPUT_4;
                        led_next = led;
                        val_next = val;
                    end
                endcase
        end
        INPUT_5: 
                case({dot,dush,backspace}) 
                    3'b100: begin
                        next_state = NO_INPUT; 
                        led_next = l_00000;
                        val_next = BLANK;
                    end
                    3'b010: begin
                        next_state = NO_INPUT;
                        led_next = l_00000;
                        val_next = BLANK;
                    end
                    3'b001:begin
                        next_state = INPUT_4;
                        case ({led[4],led[3],led[2],led[1]})
                            4'b0000:begin
                                led_next = l_00000;
                                val_next = H;
                            end 
                            4'b0001:begin
                                led_next = l_00010;
                                val_next = V;
                            end 
                            4'b0010:begin
                                led_next = l_00100;
                                val_next = F;
                            end 
                            4'b0011:begin
                                led_next = l_00110;
                                val_next = BLANK;
                            end 
                            4'b0100:begin
                                led_next = l_01000;
                                val_next = L;
                            end 
                            4'b0101:begin
                                led_next = l_01010;
                                val_next = BLANK;
                            end 
                            4'b0110:begin
                                led_next = l_01100;
                                val_next = P;
                            end 
                            4'b0111:begin
                                led_next = l_01110;
                                val_next = J;
                            end 
                            4'b1000:begin
                                led_next = l_10000;
                                val_next = B;
                            end 
                            4'b1001:begin
                                led_next = l_10010;
                                val_next = X;
                            end 
                            4'b1010:begin
                                led_next = l_10100;
                                val_next = C;
                            end 
                            4'b1011:begin
                                led_next = l_10110;
                                val_next = Y;
                            end 
                            4'b1100:begin
                                led_next = l_11000;
                                val_next = Z;
                            end 
                            4'b1101:begin
                                led_next = l_11010;
                                val_next = Q;
                            end 
                            4'b1110:begin
                                led_next = l_11100;
                                val_next = BLANK;
                            end 
                            4'b1111:begin
                                led_next = l_11110;
                                val_next = BLANK;
                            end 
                            default:begin
                                led_next = led;
                                val_next = val;
                            end
                        endcase
                    end
                    default: begin 
                        next_state = INPUT_5;
                        led_next = led;
                        val_next = val;
                    end
                endcase
        default: begin
            next_state = NO_INPUT;
            led_next = led;
            val_next = val;
        end
    endcase
end     
// ----------解码状态机部分结束-----------------


// ------------七段数码显示管显示模块-------------
seg_display s1(val,val1,val2,val3,val4,val5,val6,val7,cnt,seg_en,seg_out);

endmodule
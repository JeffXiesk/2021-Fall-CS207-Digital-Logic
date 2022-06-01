module key_top(
  input           clk,
  input           reset,
  input           decode,
  input      [3:0] row,                 // 矩阵键盘 行
  output reg [3:0] col,                 // 矩阵键盘 列
  output reg [5:0] keyboard_val
);
 
//++++++++++++++++++++++++++++++++++++++
// 分频部分 开始
//++++++++++++++++++++++++++++++++++++++
reg [19:0] cnt;                         // 计数子
wire key_clk;
 
always @ (posedge clk or posedge reset)
  if (reset|decode)
    cnt <= 0;
  else
    cnt <= cnt + 1'b1;
    
assign key_clk = cnt[19];
//--------------------------------------
// 分频部分 结束
//--------------------------------------
 
//++++++++++++++++++++++++++++++++++++++
// 状态机部分 开始
//++++++++++++++++++++++++++++++++++++++
// 状态数较少，独热码编码
parameter NO_KEY_PRESSED = 6'b000_001;  // 没有按键按下  
parameter SCAN_COL0      = 6'b000_010;  // 扫描第0列 
parameter SCAN_COL1      = 6'b000_100;  // 扫描第1列 
parameter SCAN_COL2      = 6'b001_000;  // 扫描第2列 
parameter SCAN_COL3      = 6'b010_000;  // 扫描第3列 
parameter KEY_PRESSED    = 6'b100_000;  // 有按键按下

reg [5:0] current_state_encode, next_state_encode;    // 现态、次态
 
always @ (posedge key_clk or posedge reset)
  if (reset|decode)
    current_state_encode <= NO_KEY_PRESSED;
  else
    current_state_encode <= next_state_encode;
 
// 根据条件转移状态
always @ (*)
  case (current_state_encode)
    NO_KEY_PRESSED :                    // 没有按键按下
        if (row != 4'hF)
          next_state_encode = SCAN_COL0;
        else
          next_state_encode = NO_KEY_PRESSED;
    SCAN_COL0 :                         // 扫描第0列 
        if (row != 4'hF)
          next_state_encode = KEY_PRESSED;
        else
          next_state_encode = SCAN_COL1;
    SCAN_COL1 :                         // 扫描第1列 
        if (row != 4'hF)
          next_state_encode = KEY_PRESSED;
        else
          next_state_encode = SCAN_COL2;    
    SCAN_COL2 :                         // 扫描第2列
        if (row != 4'hF)
          next_state_encode = KEY_PRESSED;
        else
          next_state_encode = SCAN_COL3;
    SCAN_COL3 :                         // 扫描第3列
        if (row != 4'hF)
          next_state_encode = KEY_PRESSED;
        else
          next_state_encode = NO_KEY_PRESSED;
    KEY_PRESSED :                       // 有按键按下
        if (row != 4'hF)
          next_state_encode = KEY_PRESSED;
        else
          next_state_encode = NO_KEY_PRESSED;                      
  endcase
 
reg       key_pressed_flag;             // 键盘按下标志
reg [3:0] col_val, row_val;             // 列值、行值
 
// 根据次态，给相应寄存器赋值
always @ (posedge key_clk or posedge reset)
  if (reset|decode)
  begin
    col              <= 4'h0;
    key_pressed_flag <=    0;
  end
  else
    case (next_state_encode)
      NO_KEY_PRESSED :                  // 没有按键按下
      begin
        col              <= 4'h0;
        key_pressed_flag <=    0;       // 清键盘按下标志
      end
      SCAN_COL0 :                       // 扫描第0列
        col <= 4'b1110;
      SCAN_COL1 :                       // 扫描第1列
        col <= 4'b1101;
      SCAN_COL2 :                       // 扫描第2列
        col <= 4'b1011;
      SCAN_COL3 :                       // 扫描第3列
        col <= 4'b0111;
      KEY_PRESSED :                     // 有按键按下
      begin
        col_val          <= col;        // 锁存列值
        row_val          <= row;        // 锁存行值
        key_pressed_flag <= 1;          // 置键盘按下标志  
      end
    endcase
//--------------------------------------
// 状态机部分 结束
//--------------------------------------
 
 
//++++++++++++++++++++++++++++++++++++++
// 扫描行列值部分 开始
//++++++++++++++++++++++++++++++++++++++
// reg [5:0] keyboard_val;
always @ (posedge key_clk or posedge reset)
  if (reset|decode)
    keyboard_val <= 6'h0;
  else
    if (key_pressed_flag)
      case ({col_val, row_val})
        8'b1110_1110 : keyboard_val <= 6'd27;
        8'b1110_1101 : keyboard_val <= 6'd30;
        8'b1110_1011 : keyboard_val <= 6'd33;
        8'b1101_1110 : keyboard_val <= 6'd28;
        8'b1101_1101 : keyboard_val <= 6'd31;
        8'b1101_1011 : keyboard_val <= 6'd34;
        8'b1101_0111 : keyboard_val <= 6'd36;
        8'b1011_1110 : keyboard_val <= 6'd29;
        8'b1011_1101 : keyboard_val <= 6'd32;
        8'b1011_1011 : keyboard_val <= 6'd35;
        default: keyboard_val <= 6'b111111; 
      endcase
//--------------------------------------
//  扫描行列值部分 结束
//--------------------------------------

endmodule
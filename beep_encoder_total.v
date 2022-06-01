module  beep_encoder_total(clk,speed_dot,speed_dush,sw,val,val1,val2,val3,val4,val5,val6,val7,beep); //模块名称song     
input          clk;              //系统时钟50MHz
input          speed_dot;
input          speed_dush;
input          sw;               // 开关
input [5:0]    val;
input [5:0]    val1;
input [5:0]    val2;
input [5:0]    val3;
input [5:0]    val4;
input [5:0]    val5;
input [5:0]    val6;
input [5:0]    val7;
output         beep;                //蜂鸣器输出端

reg [5:0] b0;
reg [5:0] b1;
reg [5:0] b2;
reg [5:0] b3;
reg [5:0] b4;
reg [5:0] b5;
reg [5:0] b6;
reg [5:0] b7;
reg       beep_r;             //寄存器
reg[7:0]  state;             //乐谱状态机
reg[16:0] count,count_end;
reg[24:0] count1;

parameter   M_3 = 17'd37919;    //音调
parameter   TIME = 25000000;    //控制每一个音的长短(250ms)  

assign beep = beep_r;           //输出音乐

always@(posedge clk or posedge sw) begin
    if (sw) begin
       count <= 17'h0;
    end
    else begin
      count <= count + 1'b1;      //计数器加1
      if(count == count_end) begin   
          count <= 17'h0;         //计数器清零
          beep_r <= !beep_r;      //输出取反
      end
    end
end

always @(*) begin
   case(val)
      6'b100100: b0 = 6'b111111;
      6'b011011: b0 = 6'b111110;
      6'b011100: b0 = 6'b111100;
      6'b011101: b0 = 6'b111000;
      6'b011110: b0 = 6'b110000;
      6'b011111: b0 = 6'b100000;
      6'b100011: b0 = 6'b101111;
      6'b100010: b0 = 6'b100111;
      6'b100001: b0 = 6'b100011;
      6'b100000: b0 = 6'b100001;
      default:   b0 = 6'b000000;
   endcase
   case(val1)
      6'b100100: b1 = 6'b111111;
      6'b011011: b1 = 6'b111110;
      6'b011100: b1 = 6'b111100;
      6'b011101: b1 = 6'b111000;
      6'b011110: b1 = 6'b110000;
      6'b011111: b1 = 6'b100000;
      6'b100011: b1 = 6'b101111;
      6'b100010: b1 = 6'b100111;
      6'b100001: b1 = 6'b100011;
      6'b100000: b1 = 6'b100001;
      default:   b1 = 6'b000000;
   endcase
   case(val2)
      6'b100100: b2 = 6'b111111;
      6'b011011: b2 = 6'b111110;
      6'b011100: b2 = 6'b111100;
      6'b011101: b2 = 6'b111000;
      6'b011110: b2 = 6'b110000;
      6'b011111: b2 = 6'b100000;
      6'b100011: b2 = 6'b101111;
      6'b100010: b2 = 6'b100111;
      6'b100001: b2 = 6'b100011;
      6'b100000: b2 = 6'b100001;
      default:   b2 = 6'b000000;
   endcase
   case(val3)
      6'b100100: b3 = 6'b111111;
      6'b011011: b3 = 6'b111110;
      6'b011100: b3 = 6'b111100;
      6'b011101: b3 = 6'b111000;
      6'b011110: b3 = 6'b110000;
      6'b011111: b3 = 6'b100000;
      6'b100011: b3 = 6'b101111;
      6'b100010: b3 = 6'b100111;
      6'b100001: b3 = 6'b100011;
      6'b100000: b3 = 6'b100001;
      default:   b3 = 6'b000000;
   endcase
   case(val4)
      6'b100100: b4 = 6'b111111;
      6'b011011: b4 = 6'b111110;
      6'b011100: b4 = 6'b111100;
      6'b011101: b4 = 6'b111000;
      6'b011110: b4 = 6'b110000;
      6'b011111: b4 = 6'b100000;
      6'b100011: b4 = 6'b101111;
      6'b100010: b4 = 6'b100111;
      6'b100001: b4 = 6'b100011;
      6'b100000: b4 = 6'b100001;
      default:   b4 = 6'b000000;
   endcase
   case(val5)
      6'b100100: b5 = 6'b111111;
      6'b011011: b5 = 6'b111110;
      6'b011100: b5 = 6'b111100;
      6'b011101: b5 = 6'b111000;
      6'b011110: b5 = 6'b110000;
      6'b011111: b5 = 6'b100000;
      6'b100011: b5 = 6'b101111;
      6'b100010: b5 = 6'b100111;
      6'b100001: b5 = 6'b100011;
      6'b100000: b5 = 6'b100001;
      default:   b5 = 6'b000000;
   endcase
   case(val6)
      6'b100100: b6 = 6'b111111;
      6'b011011: b6 = 6'b111110;
      6'b011100: b6 = 6'b111100;
      6'b011101: b6 = 6'b111000;
      6'b011110: b6 = 6'b110000;
      6'b011111: b6 = 6'b100000;
      6'b100011: b6 = 6'b101111;
      6'b100010: b6 = 6'b100111;
      6'b100001: b6 = 6'b100011;
      6'b100000: b6 = 6'b100001;
      default:   b6 = 6'b000000;
   endcase
   case(val7)
      6'b100100: b7 = 6'b111111;
      6'b011011: b7 = 6'b111110;
      6'b011100: b7 = 6'b111100;
      6'b011101: b7 = 6'b111000;
      6'b011110: b7 = 6'b110000;
      6'b011111: b7 = 6'b100000;
      6'b100011: b7 = 6'b101111;
      6'b100010: b7 = 6'b100111;
      6'b100001: b7 = 6'b100011;
      6'b100000: b7 = 6'b100001;
      default:   b7 = 6'b000000;
   endcase

end

always @(posedge clk or posedge sw) begin
   if (sw) begin
      count1 <= 24'd0;
      state = 8'd0;
   end
   else begin
      if(count1 < TIME)             
         count1 = count1 + 1'b1;
      else begin
         count1 = 24'd0;
         if(state == 8'd220)
            state = 8'd0;
         else
            state = state + 1'b1;

         case (state)
            8'd0:   count_end =17'h0;
            8'd1:   count_end =17'h0;
            8'd2:   count_end =17'h0;
            8'd3:   count_end =17'h0;
            8'd4:   count_end =17'h0;
            8'd5:   count_end =17'h0;
            8'd6:   count_end =17'h0;
            8'd7:   count_end =17'h0;
            8'd8:   count_end =17'h0;
            8'd9:   count_end =17'h0;
            8'd10:  count_end = b0[5]?M_3:17'h0; 
            8'd11:  count_end = (b0[5]&(b0[0]|speed_dot))?M_3:17'h0; 
            8'd12:  count_end = b0[0]?M_3:17'h0; 
            8'd13:  count_end = (b0[0]&speed_dush)?M_3:17'h0; 
            8'd14:  count_end = 17'h0;
            8'd15:  count_end = b0[5]?M_3:17'h0; 
            8'd16:  count_end = (b0[5]&(b0[1]|speed_dot))?M_3:17'h0; 
            8'd17:  count_end = b0[1]?M_3:17'h0; 
            8'd18:  count_end = (b0[1]&speed_dush)?M_3:17'h0; 
            8'd19:  count_end = 17'h0; 
            8'd20:  count_end = b0[5]?M_3:17'h0; 
            8'd21:  count_end = (b0[5]&(b0[2]|speed_dot))?M_3:17'h0; 
            8'd22:  count_end = b0[2]?M_3:17'h0; 
            8'd23:  count_end = (b0[2]&speed_dush)?M_3:17'h0; 
            8'd24:  count_end = 17'h0;
            8'd25:  count_end = b0[5]?M_3:17'h0; 
            8'd26:  count_end = (b0[5]&(b0[3]|speed_dot))?M_3:17'h0; 
            8'd27:  count_end = b0[3]?M_3:17'h0; 
            8'd28:  count_end = (b0[3]&speed_dush)?M_3:17'h0; 
            8'd29:  count_end = 17'h0;
            8'd30:  count_end = b0[5]?M_3:17'h0; 
            8'd31:  count_end = (b0[5]&(b0[4]|speed_dot))?M_3:17'h0; 
            8'd32:  count_end = b0[4]?M_3:17'h0; 
            8'd33:  count_end = (b0[4]&speed_dush)?M_3:17'h0; 
            8'd34:  count_end = 17'h0;
            8'd35:  count_end = 17'h0;
            8'd36:  count_end = 17'h0;
            8'd37:  count_end = 17'h0;
            8'd38:  count_end = 17'h0;
            8'd39:  count_end = 17'h0;
            8'd40:  count_end = b1[5]?M_3:17'h0; 
            8'd41:  count_end = (b1[5]&(b1[0]|speed_dot))?M_3:17'h0; 
            8'd42:  count_end = b1[0]?M_3:17'h0; 
            8'd43:  count_end = (b1[0]&speed_dush)?M_3:17'h0; 
            8'd44:  count_end = 17'h0;
            8'd45:  count_end = b1[5]?M_3:17'h0; 
            8'd46:  count_end = (b1[5]&(b1[1]|speed_dot))?M_3:17'h0; 
            8'd47:  count_end = b1[1]?M_3:17'h0; 
            8'd48:  count_end = (b1[1]&speed_dush)?M_3:17'h0; 
            8'd49:  count_end = 17'h0; 
            8'd50:  count_end = b1[5]?M_3:17'h0; 
            8'd51:  count_end = (b1[5]&(b1[2]|speed_dot))?M_3:17'h0; 
            8'd52:  count_end = b1[2]?M_3:17'h0; 
            8'd53:  count_end = (b1[2]&speed_dush)?M_3:17'h0; 
            8'd54:  count_end = 17'h0;
            8'd55:  count_end = b1[5]?M_3:17'h0; 
            8'd56:  count_end = (b1[5]&(b1[3]|speed_dot))?M_3:17'h0; 
            8'd57:  count_end = b1[3]?M_3:17'h0; 
            8'd58:  count_end = (b1[3]&speed_dush)?M_3:17'h0; 
            8'd59:  count_end = 17'h0;
            8'd60:  count_end = b1[5]?M_3:17'h0; 
            8'd61:  count_end = (b1[5]&(b1[4]|speed_dot))?M_3:17'h0; 
            8'd62:  count_end = b1[4]?M_3:17'h0; 
            8'd63:  count_end = (b1[4]&speed_dush)?M_3:17'h0; 
            8'd64:  count_end = 17'h0;
            8'd65:  count_end = 17'h0;
            8'd66:  count_end = 17'h0;
            8'd67:  count_end = 17'h0;
            8'd68:  count_end = 17'h0;
            8'd69:  count_end = 17'h0;
            8'd70:  count_end = b2[5]?M_3:17'h0; 
            8'd71:  count_end = (b2[5]&(b2[0]|speed_dot))?M_3:17'h0; 
            8'd72:  count_end = b2[0]?M_3:17'h0; 
            8'd73:  count_end = (b2[0]&speed_dush)?M_3:17'h0; 
            8'd74:  count_end = 17'h0;
            8'd75:  count_end = b2[5]?M_3:17'h0; 
            8'd76:  count_end = (b2[5]&(b2[1]|speed_dot))?M_3:17'h0; 
            8'd77:  count_end = b2[1]?M_3:17'h0; 
            8'd78:  count_end = (b2[1]&speed_dush)?M_3:17'h0; 
            8'd79:  count_end = 17'h0; 
            8'd80:  count_end = b2[5]?M_3:17'h0; 
            8'd81:  count_end = (b2[5]&(b2[1]|speed_dot))?M_3:17'h0; 
            8'd82:  count_end = b2[2]?M_3:17'h0; 
            8'd83:  count_end = (b2[2]&speed_dush)?M_3:17'h0; 
            8'd84:  count_end = 17'h0;
            8'd85:  count_end = b2[5]?M_3:17'h0; 
            8'd86:  count_end = (b2[5]&(b2[3]|speed_dot))?M_3:17'h0; 
            8'd87:  count_end = b2[3]?M_3:17'h0; 
            8'd88:  count_end = (b2[3]&speed_dush)?M_3:17'h0; 
            8'd89:  count_end = 17'h0;
            8'd90:  count_end = b2[5]?M_3:17'h0; 
            8'd91:  count_end = (b2[5]&(b2[4]|speed_dot))?M_3:17'h0; 
            8'd92:  count_end = b2[4]?M_3:17'h0; 
            8'd93:  count_end = (b2[4]&speed_dush)?M_3:17'h0; 
            8'd94:  count_end = 17'h0;
            8'd95:  count_end = 17'h0;
            8'd96:  count_end = 17'h0;
            8'd97:  count_end = 17'h0;
            8'd98:  count_end = 17'h0;
            8'd99:  count_end = 17'h0;
            8'd100: count_end = b3[5]?M_3:17'h0; 
            8'd101: count_end = (b3[5]&(b3[0]|speed_dot))?M_3:17'h0; 
            8'd102: count_end = b3[0]?M_3:17'h0; 
            8'd103: count_end = (b3[0]&speed_dush)?M_3:17'h0; 
            8'd104: count_end = 17'h0;
            8'd105: count_end = b3[5]?M_3:17'h0; 
            8'd106: count_end = (b3[5]&(b3[1]|speed_dot))?M_3:17'h0; 
            8'd107: count_end = b3[1]?M_3:17'h0; 
            8'd108: count_end = (b3[1]&speed_dush)?M_3:17'h0; 
            8'd109: count_end = 17'h0; 
            8'd110: count_end = b3[5]?M_3:17'h0; 
            8'd111: count_end = (b3[5]&(b3[2]|speed_dot))?M_3:17'h0; 
            8'd112: count_end = b3[2]?M_3:17'h0; 
            8'd113: count_end = (b3[2]&speed_dush)?M_3:17'h0; 
            8'd114: count_end = 17'h0;
            8'd115: count_end = b3[5]?M_3:17'h0; 
            8'd116: count_end = (b3[5]&(b3[3]|speed_dot))?M_3:17'h0; 
            8'd117: count_end = b3[3]?M_3:17'h0; 
            8'd118: count_end = (b3[3]&speed_dush)?M_3:17'h0; 
            8'd119: count_end = 17'h0;
            8'd120: count_end = b3[5]?M_3:17'h0; 
            8'd121: count_end = (b3[5]&(b3[4]|speed_dot))?M_3:17'h0; 
            8'd122: count_end = b3[4]?M_3:17'h0; 
            8'd123: count_end = (b3[4]&speed_dush)?M_3:17'h0; 
            8'd124: count_end = 17'h0;
            8'd125: count_end = 17'h0;
            8'd126: count_end = 17'h0;
            8'd127: count_end = 17'h0;
            8'd128: count_end = 17'h0;
            8'd129: count_end = 17'h0;
            8'd130: count_end = b4[5]?M_3:17'h0; 
            8'd131: count_end = (b4[5]&(b4[0]|speed_dot))?M_3:17'h0; 
            8'd132: count_end = b4[0]?M_3:17'h0; 
            8'd133: count_end = (b4[0]&speed_dush)?M_3:17'h0; 
            8'd134: count_end = 17'h0;
            8'd135: count_end = b4[5]?M_3:17'h0; 
            8'd136: count_end = (b4[5]&(b4[1]|speed_dot))?M_3:17'h0; 
            8'd137: count_end = b4[1]?M_3:17'h0; 
            8'd138: count_end = (b4[1]&speed_dush)?M_3:17'h0; 
            8'd139: count_end = 17'h0; 
            8'd140: count_end = b4[5]?M_3:17'h0; 
            8'd141: count_end = (b4[5]&(b4[2]|speed_dot))?M_3:17'h0; 
            8'd142: count_end = b4[2]?M_3:17'h0; 
            8'd143: count_end = (b4[2]&speed_dush)?M_3:17'h0; 
            8'd144: count_end = 17'h0;
            8'd145: count_end = b4[5]?M_3:17'h0; 
            8'd146: count_end = (b4[5]&(b4[3]|speed_dot))?M_3:17'h0; 
            8'd147: count_end = b4[3]?M_3:17'h0; 
            8'd148: count_end = (b4[3]&speed_dush)?M_3:17'h0; 
            8'd149: count_end = 17'h0;
            8'd150: count_end = b4[5]?M_3:17'h0; 
            8'd151: count_end = (b4[5]&(b4[4]|speed_dot))?M_3:17'h0; 
            8'd152: count_end = b4[4]?M_3:17'h0; 
            8'd153: count_end = (b4[4]&speed_dush)?M_3:17'h0; 
            8'd154: count_end = 17'h0;
            8'd155: count_end = 17'h0;
            8'd156: count_end = 17'h0;
            8'd157: count_end = 17'h0;
            8'd158: count_end = 17'h0;
            8'd159: count_end = 17'h0;
            8'd160: count_end = b5[5]?M_3:17'h0; 
            8'd161: count_end = (b5[5]&(b5[0]|speed_dot))?M_3:17'h0; 
            8'd162: count_end = b5[0]?M_3:17'h0; 
            8'd163: count_end = (b5[0]&speed_dush)?M_3:17'h0; 
            8'd164: count_end = 17'h0;
            8'd165: count_end = b5[5]?M_3:17'h0; 
            8'd166: count_end = (b5[5]&(b5[1]|speed_dot))?M_3:17'h0; 
            8'd167: count_end = b5[1]?M_3:17'h0; 
            8'd168: count_end = (b5[1]&speed_dush)?M_3:17'h0; 
            8'd169: count_end = 17'h0; 
            8'd170: count_end = b5[5]?M_3:17'h0; 
            8'd171: count_end = (b5[5]&(b5[2]|speed_dot))?M_3:17'h0; 
            8'd172: count_end = b5[2]?M_3:17'h0; 
            8'd173: count_end = (b5[2]&speed_dush)?M_3:17'h0; 
            8'd174: count_end = 17'h0;
            8'd175: count_end = b5[5]?M_3:17'h0; 
            8'd176: count_end = (b5[5]&(b5[3]|speed_dot))?M_3:17'h0; 
            8'd177: count_end = b5[3]?M_3:17'h0; 
            8'd178: count_end = (b5[3]&speed_dush)?M_3:17'h0; 
            8'd179: count_end = 17'h0;
            8'd180: count_end = b5[5]?M_3:17'h0; 
            8'd181: count_end = (b5[5]&(b5[4]|speed_dot))?M_3:17'h0; 
            8'd182: count_end = b5[4]?M_3:17'h0; 
            8'd183: count_end = (b5[4]&speed_dush)?M_3:17'h0; 
            8'd184: count_end = 17'h0;
            8'd185: count_end = 17'h0;
            8'd186: count_end = 17'h0;
            8'd187: count_end = 17'h0;
            8'd188: count_end = 17'h0;
            8'd189: count_end = 17'h0;
            8'd190: count_end = b6[5]?M_3:17'h0; 
            8'd191: count_end = (b6[5]&(b6[0]|speed_dot))?M_3:17'h0; 
            8'd192: count_end = b6[0]?M_3:17'h0; 
            8'd193: count_end = (b6[0]&speed_dush)?M_3:17'h0; 
            8'd194: count_end = 17'h0;
            8'd195: count_end = b6[5]?M_3:17'h0; 
            8'd196: count_end = (b6[5]&(b6[1]|speed_dot))?M_3:17'h0; 
            8'd197: count_end = b6[1]?M_3:17'h0; 
            8'd198: count_end = (b6[1]&speed_dush)?M_3:17'h0; 
            8'd199: count_end = 17'h0; 
            8'd200: count_end = b6[5]?M_3:17'h0; 
            8'd201: count_end = (b6[5]&(b6[2]|speed_dot))?M_3:17'h0; 
            8'd202: count_end = b6[2]?M_3:17'h0; 
            8'd203: count_end = (b6[2]&speed_dush)?M_3:17'h0; 
            8'd204: count_end = 17'h0;
            8'd205: count_end = b6[5]?M_3:17'h0; 
            8'd206: count_end = (b6[5]&(b6[3]|speed_dot))?M_3:17'h0; 
            8'd207: count_end = b6[3]?M_3:17'h0; 
            8'd208: count_end = (b6[3]&speed_dush)?M_3:17'h0; 
            8'd209: count_end = 17'h0;
            8'd210: count_end = b6[5]?M_3:17'h0; 
            8'd211: count_end = (b6[5]&(b6[4]|speed_dot))?M_3:17'h0; 
            8'd212: count_end = b6[4]?M_3:17'h0; 
            8'd213: count_end = (b6[4]&speed_dush)?M_3:17'h0; 
            8'd214: count_end = 17'h0;
            8'd215: count_end = 17'h0;
            8'd216: count_end = 17'h0;
            8'd217: count_end = 17'h0;
            8'd218: count_end = 17'h0;
            8'd219: count_end = 17'h0;
            8'd220: count_end = b7[5]?M_3:17'h0; 
            8'd221: count_end = (b7[5]&(b7[0]|speed_dot))?M_3:17'h0; 
            8'd222: count_end = b7[0]?M_3:17'h0; 
            8'd223: count_end = (b7[0]&speed_dush)?M_3:17'h0; 
            8'd224: count_end = 17'h0;
            8'd225: count_end = b7[5]?M_3:17'h0; 
            8'd226: count_end = (b7[5]&(b7[1]|speed_dot))?M_3:17'h0; 
            8'd227: count_end = b7[1]?M_3:17'h0; 
            8'd228: count_end = (b7[1]&speed_dush)?M_3:17'h0; 
            8'd229: count_end = 17'h0; 
            8'd230: count_end = b7[5]?M_3:17'h0; 
            8'd231: count_end = (b7[5]&(b7[2]|speed_dot))?M_3:17'h0; 
            8'd232: count_end = b7[2]?M_3:17'h0; 
            8'd233: count_end = (b7[2]&speed_dush)?M_3:17'h0; 
            8'd234: count_end = 17'h0;
            8'd235: count_end = b7[5]?M_3:17'h0; 
            8'd236: count_end = (b7[5]&(b7[3]|speed_dot))?M_3:17'h0; 
            8'd237: count_end = b7[3]?M_3:17'h0; 
            8'd238: count_end = (b7[3]&speed_dush)?M_3:17'h0; 
            8'd239: count_end = 17'h0;
            8'd240: count_end = b7[5]?M_3:17'h0; 
            8'd241: count_end = (b7[5]&(b7[4]|speed_dot))?M_3:17'h0; 
            8'd242: count_end = b7[4]?M_3:17'h0; 
            8'd243: count_end = (b7[4]&speed_dush)?M_3:17'h0; 
            8'd244: count_end = 17'h0;
            default:count_end = 17'h0;
         endcase      
      end
   end
end
endmodule
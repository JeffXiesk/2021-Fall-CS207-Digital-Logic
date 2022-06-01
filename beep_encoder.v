module  beep_encoder(clk,speed_dot,speed_dush,sw,val,beep); //模块名称song     
input      clk;                 //系统时钟100MHz
input      speed_dot;           //控制短码的长度
input      speed_dush;          //控制长码的长度
input      sw;                  //开关
input [5:0]val;
output  beep;                   //蜂鸣器输出端

reg     beep_r;             //寄存器
reg[4:0] state;             //乐谱状态机
reg[16:0]count,count_end;
reg[24:0]count1;

parameter   M_3 = 17'd37919;    //中音3
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

always @(posedge clk or posedge sw) begin
   if (sw) begin
      count1 <= 24'd0;
      state = 8'd0;  
   end
   else begin
      if(count1 < TIME)             //一个节拍250mS
         count1 = count1 + 1'b1;
      else begin
         count1 = 24'd0;
         if(state == 8'd63)
            state = 8'd0;
         else
            state = state + 1'b1;
       case(val)
      6 'b100100:begin
         case (state)
            8'd0: count_end = 17'h0;
            8'd1: count_end = 17'h0;
            8'd2: count_end = M_3;  
            8'D3: count_end = M_3;  
            8'd4: count_end = M_3;
            8'd5: count_end = speed_dush?M_3:17'h0;
            8'd6: count_end = 17'h0;
            8'd7: count_end = M_3;  
            8'D8: count_end = M_3;  
            8'd9: count_end = M_3;
            8'd10:count_end = speed_dush?M_3:17'h0;
            8'd11:count_end = 17'h0;    
            8'd12:count_end = M_3;  
            8'D13:count_end = M_3;  
            8'd14:count_end = M_3;
            8'd15:count_end = speed_dush?M_3:17'h0;
            8'd16:count_end = 17'h0;
            8'd17:count_end = M_3;  
            8'D18:count_end = M_3;  
            8'd19:count_end = M_3;
            8'd20:count_end = speed_dush?M_3:17'h0;
            8'd21:count_end = 17'h0;
            8'd22:count_end = M_3;  
            8'D23:count_end = M_3;
            8'd24:count_end = M_3;
            8'd25:count_end = speed_dush?M_3:17'h0;
            8'd26:count_end = 17'h0;
            default: count_end = 17'h0;
         endcase
      end

      6'b011011:begin
         case (state)
            8'd0: count_end = 17'h0;
            8'd1: count_end = 17'h0;
            8'd2: count_end = M_3;  
            8'D3: count_end = speed_dot?M_3:17'h0;  
            8'd4: count_end = 17'h0;
            8'd5: count_end = 17'h0;
            8'd6: count_end = 17'h0;
            8'd7: count_end = M_3;  
            8'D8: count_end = M_3;  
            8'd9: count_end = M_3;
            8'd10:count_end = speed_dush?M_3:17'h0;
            8'd11:count_end = 17'h0;    
            8'd12:count_end = M_3;  
            8'D13:count_end = M_3;  
            8'd14:count_end = M_3;
            8'd15:count_end = speed_dush?M_3:17'h0;
            8'd16:count_end = 17'h0;
            8'd17:count_end = M_3;  
            8'D18:count_end = M_3;  
            8'd19:count_end = M_3;
            8'd20:count_end = speed_dush?M_3:17'h0;
            8'd21:count_end = 17'h0;
            8'd22:count_end = M_3;  
            8'D23:count_end = M_3;
            8'd24:count_end = M_3;
            8'd25:count_end = speed_dush?M_3:17'h0;
            8'd26:count_end = 17'h0;
            default: count_end = 17'h0;
         endcase
      end

      6'b011100:begin
         case (state)
            8'd0: count_end = 17'h0;
            8'd1: count_end = 17'h0;
            8'd2: count_end = M_3;  
            8'D3: count_end = speed_dot?M_3:17'h0;  
            8'd4: count_end = 17'h0;
            8'd5: count_end = 17'h0;
            8'd6: count_end = 17'h0;
            8'd7: count_end = M_3;  
            8'D8: count_end = speed_dot?M_3:17'h0;  
            8'd9: count_end = 17'h0;
            8'd10:count_end = 17'h0;
            8'd11:count_end = 17'h0;    
            8'd12:count_end = M_3;  
            8'D13:count_end = M_3;  
            8'd14:count_end = M_3;
            8'd15:count_end = speed_dush?M_3:17'h0;
            8'd16:count_end = 17'h0;
            8'd17:count_end = M_3;  
            8'D18:count_end = M_3;  
            8'd19:count_end = M_3;
            8'd20:count_end = speed_dush?M_3:17'h0;
            8'd21:count_end = 17'h0;
            8'd22:count_end = M_3;  
            8'D23:count_end = M_3;
            8'd24:count_end = M_3;
            8'd25:count_end = speed_dush?M_3:17'h0;
            8'd26:count_end = 17'h0;
            default: count_end = 17'h0;
         endcase
      end

      6'b011101:begin
         case (state)
            8'd0: count_end = 17'h0;
            8'd1: count_end = 17'h0;
            8'd2: count_end = M_3;  
            8'D3: count_end = speed_dot?M_3:17'h0;  
            8'd4: count_end = 17'h0;
            8'd5: count_end = 17'h0;
            8'd6: count_end = 17'h0;
            8'd7: count_end = M_3;  
            8'D8: count_end = speed_dot?M_3:17'h0;  
            8'd9: count_end = 17'h0;
            8'd10:count_end = 17'h0;
            8'd11:count_end = 17'h0;    
            8'd12:count_end = M_3;  
            8'D13:count_end = speed_dot?M_3:17'h0;  
            8'd14:count_end = 17'h0;
            8'd15:count_end = 17'h0;
            8'd16:count_end = 17'h0;
            8'd17:count_end = M_3;  
            8'D18:count_end = M_3;  
            8'd19:count_end = M_3;
            8'd20:count_end = speed_dush?M_3:17'h0;
            8'd21:count_end = 17'h0;
            8'd22:count_end = M_3;  
            8'D23:count_end = M_3;
            8'd24:count_end = M_3;
            8'd25:count_end = speed_dush?M_3:17'h0;
            8'd26:count_end = 17'h0;
            default: count_end = 17'h0;
         endcase
      end

      6'b011110:begin
         case (state)
            8'd0: count_end = 17'h0;
            8'd1: count_end = 17'h0;
            8'd2: count_end = M_3;  
            8'D3: count_end = speed_dot?M_3:17'h0;  
            8'd4: count_end = 17'h0;
            8'd5: count_end = 17'h0;
            8'd6: count_end = 17'h0;
            8'd7: count_end = M_3;  
            8'D8: count_end = speed_dot?M_3:17'h0;  
            8'd9: count_end = 17'h0;
            8'd10:count_end = 17'h0;
            8'd11:count_end = 17'h0;    
            8'd12:count_end = M_3;  
            8'D13:count_end = speed_dot?M_3:17'h0;  
            8'd14:count_end = 17'h0;
            8'd15:count_end = 17'h0;
            8'd16:count_end = 17'h0;
            8'd17:count_end = M_3;  
            8'D18:count_end = speed_dot?M_3:17'h0;  
            8'd19:count_end = 17'h0;
            8'd20:count_end = 17'h0;
            8'd21:count_end = 17'h0;
            8'd22:count_end = M_3;  
            8'D23:count_end = M_3;
            8'd24:count_end = M_3;
            8'd25:count_end = speed_dush?M_3:17'h0;
            8'd26:count_end = 17'h0;
            default: count_end = 17'h0;
         endcase
      end

      6'b011111:begin
         case (state)
            8'd0: count_end = 17'h0;
            8'd1: count_end = 17'h0;
            8'd2: count_end = M_3;  
            8'D3: count_end = speed_dot?M_3:17'h0;  
            8'd4: count_end = 17'h0;
            8'd5: count_end = 17'h0;
            8'd6: count_end = 17'h0;
            8'd7: count_end = M_3;  
            8'D8: count_end = speed_dot?M_3:17'h0;  
            8'd9: count_end = 17'h0;
            8'd10:count_end = 17'h0;
            8'd11:count_end = 17'h0;    
            8'd12:count_end = M_3;  
            8'D13:count_end = speed_dot?M_3:17'h0;  
            8'd14:count_end = 17'h0;
            8'd15:count_end = 17'h0;
            8'd16:count_end = 17'h0;
            8'd17:count_end = M_3;  
            8'D18:count_end = speed_dot?M_3:17'h0;  
            8'd19:count_end = 17'h0;
            8'd20:count_end = 17'h0;
            8'd21:count_end = 17'h0;
            8'd22:count_end = M_3;  
            8'D23:count_end = speed_dot?M_3:17'h0;
            8'd24:count_end = 17'h0;
            8'd25:count_end = 17'h0;
            8'd26:count_end = 17'h0;
            default: count_end = 17'h0;
         endcase
      end

      6'b100011:begin
         case (state)
            8'd0: count_end = 17'h0;
            8'd1: count_end = 17'h0;
            8'd2: count_end = M_3;  
            8'D3: count_end = M_3;  
            8'd4: count_end = M_3;
            8'd5: count_end = speed_dush?M_3:17'h0;
            8'd6: count_end = 17'h0;
            8'd7: count_end = M_3;  
            8'D8: count_end = M_3;  
            8'd9: count_end = M_3;
            8'd10:count_end = speed_dush?M_3:17'h0;
            8'd11:count_end = 17'h0;    
            8'd12:count_end = M_3;  
            8'D13:count_end = M_3;  
            8'd14:count_end = M_3;
            8'd15:count_end = speed_dush?M_3:17'h0;
            8'd16:count_end = 17'h0;
            8'd17:count_end = M_3;  
            8'D18:count_end = M_3;  
            8'd19:count_end = M_3;
            8'd20:count_end = speed_dush?M_3:17'h0;
            8'd21:count_end = 17'h0;
            8'd22:count_end = M_3;  
            8'D23:count_end = speed_dot?M_3:17'h0;
            8'd24:count_end = 17'h0;
            8'd25:count_end = 17'h0;
            8'd26:count_end = 17'h0;
            default: count_end = 17'h0;
         endcase
      end

      6'b100010:begin
         case (state)
            8'd0: count_end = 17'h0;
            8'd1: count_end = 17'h0;
            8'd2: count_end = M_3;  
            8'D3: count_end = M_3;  
            8'd4: count_end = M_3;
            8'd5: count_end = speed_dush?M_3:17'h0;
            8'd6: count_end = 17'h0;
            8'd7: count_end = M_3;  
            8'D8: count_end = M_3;  
            8'd9: count_end = M_3;
            8'd10:count_end = speed_dush?M_3:17'h0;
            8'd11:count_end = 17'h0;    
            8'd12:count_end = M_3;  
            8'D13:count_end = M_3;  
            8'd14:count_end = M_3;
            8'd15:count_end = speed_dush?M_3:17'h0;
            8'd16:count_end = 17'h0;
            8'd17:count_end = M_3;  
            8'D18:count_end = speed_dot?M_3:17'h0;  
            8'd19:count_end = 17'h0;
            8'd20:count_end = 17'h0;
            8'd21:count_end = 17'h0;
            8'd22:count_end = M_3;  
            8'D23:count_end = speed_dot?M_3:17'h0;
            8'd24:count_end = 17'h0;
            8'd25:count_end = 17'h0;
            8'd26:count_end = 17'h0;
            default: count_end = 17'h0;
         endcase
      end

      6'b100001:begin
         case (state)
            8'd0: count_end = 17'h0;
            8'd1: count_end = 17'h0;
            8'd2: count_end = M_3;  
            8'D3: count_end = M_3;  
            8'd4: count_end = M_3;
            8'd5: count_end = speed_dush?M_3:17'h0;
            8'd6: count_end = 17'h0;
            8'd7: count_end = M_3;  
            8'D8: count_end = M_3;  
            8'd9: count_end = M_3;
            8'd10:count_end = speed_dush?M_3:17'h0;
            8'd11:count_end = 17'h0;    
            8'd12:count_end = M_3;  
            8'D13:count_end = speed_dot?M_3:17'h0;  
            8'd14:count_end = 17'h0;
            8'd15:count_end = 17'h0;
            8'd16:count_end = 17'h0;
            8'd17:count_end = M_3;  
            8'D18:count_end = speed_dot?M_3:17'h0;  
            8'd19:count_end = 17'h0;
            8'd20:count_end = 17'h0;
            8'd21:count_end = 17'h0;
            8'd22:count_end = M_3;  
            8'D23:count_end = speed_dot?M_3:17'h0;
            8'd24:count_end = 17'h0;
            8'd25:count_end = 17'h0;
            8'd26:count_end = 17'h0;
            default: count_end = 17'h0;
         endcase
      end

      6'b100000:begin
         case (state)
            8'd0: count_end = 17'h0;
            8'd1: count_end = 17'h0;
            8'd2: count_end = M_3;  
            8'D3: count_end = M_3;  
            8'd4: count_end = M_3;
            8'd5: count_end = speed_dush?M_3:17'h0;
            8'd6: count_end = 17'h0;
            8'd7: count_end = M_3;  
            8'D8: count_end = speed_dot?M_3:17'h0;  
            8'd9: count_end = 17'h0;
            8'd10:count_end = 17'h0;
            8'd11:count_end = 17'h0;    
            8'd12:count_end = M_3;  
            8'D13:count_end = speed_dot?M_3:17'h0;  
            8'd14:count_end = 17'h0;
            8'd15:count_end = 17'h0;
            8'd16:count_end = 17'h0;
            8'd17:count_end = M_3;  
            8'D18:count_end = speed_dot?M_3:17'h0;  
            8'd19:count_end = 17'h0;
            8'd20:count_end = 17'h0;
            8'd21:count_end = 17'h0;
            8'd22:count_end = M_3;  
            8'D23:count_end = speed_dot?M_3:17'h0;
            8'd24:count_end = 17'h0;
            8'd25:count_end = 17'h0;
            8'd26:count_end = 17'h0;
            default: count_end = 17'h0;
         endcase
      end

      6'b011111:begin
         case (state)
            8'd0: count_end = 17'h0;
            8'd1: count_end = 17'h0;
            8'd2: count_end = M_3;  
            8'D3: count_end = speed_dot?M_3:17'h0;  
            8'd4: count_end = 17'h0;
            8'd5: count_end = 17'h0;
            8'd6: count_end = 17'h0;
            8'd7: count_end = M_3;  
            8'D8: count_end = speed_dot?M_3:17'h0;  
            8'd9: count_end = 17'h0;
            8'd10:count_end = 17'h0;
            8'd11:count_end = 17'h0;    
            8'd12:count_end = M_3;  
            8'D13:count_end = speed_dot?M_3:17'h0;  
            8'd14:count_end = 17'h0;
            8'd15:count_end = 17'h0;
            8'd16:count_end = 17'h0;
            8'd17:count_end = M_3;  
            8'D18:count_end = speed_dot?M_3:17'h0;  
            8'd19:count_end = 17'h0;
            8'd20:count_end = 17'h0;
            8'd21:count_end = 17'h0;
            8'd22:count_end = M_3;  
            8'D23:count_end = speed_dot?M_3:17'h0;
            8'd24:count_end = 17'h0;
            8'd25:count_end = 17'h0;
            8'd26:count_end = 17'h0;
            default: count_end = 17'h0;
         endcase
      end

      default: count_end = 17'h0;
      
      endcase
      end
   end
end
endmodule
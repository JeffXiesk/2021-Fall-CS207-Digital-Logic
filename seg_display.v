module seg_display (
    input [5:0]val,
    input [5:0]val1,
    input [5:0]val2,
    input [5:0]val3,
    input [5:0]val4,
    input [5:0]val5,
    input [5:0]val6,
    input [5:0]val7,
    input [23:0] cnt,
    output reg [7:0] seg_en,
    output reg [7:0] seg_out
);
    
reg [5:0] val_to_show;

// 解码输出值
always @(val_to_show) begin
    case(val_to_show)
        6'd1:   seg_out=8'b1000_1000;  // A
        6'd2:   seg_out=8'b1000_0011;  // b
        6'd3:   seg_out=8'b1100_0110;  // c
        6'd4:   seg_out=8'b1010_0001;  // d
        6'd5:   seg_out=8'b1000_0110;  // E
        6'd6:   seg_out=8'b1000_1110;  // F
        6'd7:   seg_out=8'b1100_0010;  // G
        6'd8:   seg_out=8'b1000_1001;  // H
        6'd9:   seg_out=8'b1111_0000;  // I
        6'd10:  seg_out=8'b1111_0001;  // J
        6'd11:  seg_out=8'b1000_1010;  // K
        6'd12:  seg_out=8'b1100_0111;  // L
        6'd13:  seg_out=8'b1100_1000;  // M
        6'd14:  seg_out=8'b1010_1011;  // N
        6'd15:  seg_out=8'b1010_0011;  // O
        6'd16:  seg_out=8'b1000_1100;  // P
        6'd17:  seg_out=8'b1001_1000;  // Q
        6'd18:  seg_out=8'b1100_1110;  // R
        6'd19:  seg_out=8'b1011_0110;  // S
        6'd20:  seg_out=8'b1000_0111;  // T
        6'd21:  seg_out=8'b1100_0001;  // U
        6'd22:  seg_out=8'b1110_0011;  // V
        6'd23:  seg_out=8'b1000_0001;  // W
        6'd24:  seg_out=8'b1001_1011;  // X
        6'd25:  seg_out=8'b1001_0001;  // Y
        6'd26:  seg_out=8'b1010_0101;  // Z
        6'd27:  seg_out=8'b1111_1001;  // 1
        6'd28:  seg_out=8'b1010_0100;  // 2
        6'd29:  seg_out=8'b1011_0000;  // 3
        6'd30:  seg_out=8'b1001_1001;  // 4
        6'd31:  seg_out=8'b1001_0010;  // 5
        6'd32:  seg_out=8'b1000_0010;  // 6
        6'd33:  seg_out=8'b1101_1000;  // 7
        6'd34:  seg_out=8'b1000_0000;  // 8
        6'd35:  seg_out=8'b1001_0000;  // 9
        6'd36:  seg_out=8'b1100_0000;  // 0
        default: seg_out = 8'b1111_1111;
    endcase
end

// 七段数码管显示内容
always @(cnt) begin
    case (cnt[19:17])
    3'b000:begin
        seg_en = 8'b1111_1110;
        val_to_show = val;
    end
    3'b001:begin
        seg_en = 8'b1111_1101;
        val_to_show = val1;
    end
    3'b010:begin
        seg_en = 8'b1111_1011;
        val_to_show = val2;
  end
    3'b011:begin
        seg_en = 8'b1111_0111;
        val_to_show = val3;
    end
    3'b100:begin
        seg_en = 8'b1110_1111;
        val_to_show = val4;
   end
    3'b101:begin
        seg_en = 8'b1101_1111;
        val_to_show =val5;
    end
    3'b110:begin
        seg_en = 8'b1011_1111;
        val_to_show = val6;
    end
    3'b111:begin
        seg_en = 8'b0111_1111;
        val_to_show = val7;
    end
    default: begin
        seg_en = 8'b1111_1111;
        val_to_show = 6'h0;
    end
    endcase
end

endmodule
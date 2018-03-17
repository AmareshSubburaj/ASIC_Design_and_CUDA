//Student ID:200207571
//asubbur@ncsu.edu

// synopsys translate_off
 
`include "///afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW02_mac.v"
// synopsys translate_on

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------



module steptwo (				   input wire  clk,
						   input wire  reset,
						   input wire  start,
						   input wire sram_enabled, 
						   output reg steptwo_sel,
						   output reg done,
						   input wire reiterate,
						   
// b-vector memory 
						  output reg  [ 9:0]          qone__cdut__bvm__address  , 
						  input  wire [15:0]          bvm__cdut__quadone__data     ,//     read data    
//---------------------------------------------------------------------------
// Input data memory 

						 output reg  [ 8:0]          qone__cdut__dim__address  , 
						 input  wire [15:0]          dim__cdut__quadone__data     , //   read data


//---------------------------------------------------------------------------
// Output data memory 

						output reg  [ 2:0]          qone__cdut__dom__address  , //
						output reg  [15:0]          qone__cdut__dom__data     ,  //  write data
						output reg                  qone__cdut__dom__write    ); // 
			       
							
reg [15:0] A_data_reg;
reg [15:0] B_data_reg;
reg [8:0]quad_dim_muxsel2reg;
reg [9:0]quad_bvm_muxsel2reg;
reg mac2scompsel;
wire signed [31:0] MAC_inst;
reg [15:0] Z_data; 

//synopsys template
parameter [8:0]
Z_0 = 9'h100,
Z_1 = 9'h101,
Z_2 = 9'h102,
Z_3 = 9'h103,
Z_4 = 9'h104,
Z_5 = 9'h105,
Z_6 = 9'h106,
Z_7 = 9'h107,
Z_8 = 9'h108,

Z_9  = 9'h109,
Z_10 = 9'h10A,
Z_11 = 9'h10B,
Z_12 = 9'h10C,
Z_13 = 9'h10D,
Z_14 = 9'h10E,
Z_15 = 9'h10F,

Z_16 = 9'h110,
Z_17 = 9'h111,

Z_18 = 9'h112,
Z_19 = 9'h113,
Z_20 = 9'h114,
Z_21 = 9'h115,
Z_22 = 9'h116,
Z_23 = 9'h117,
Z_24 = 9'h118,
Z_25 = 9'h119,
Z_26 = 9'h11A,

Z_27 = 9'h11B,
Z_28 = 9'h11C,
Z_29 = 9'h11D,
Z_30 = 9'h11E,
Z_31 = 9'h11F,
Z_32 = 9'h120,
Z_33 = 9'h121,
Z_34 = 9'h122,
Z_35 = 9'h123,
Z_36 = 9'h124,
Z_37 = 9'h125,
Z_38 = 9'h126,
Z_39 = 9'h127,
Z_40 = 9'h128,
Z_41 = 9'h129,
Z_42 = 9'h12A,
Z_43 = 9'h12B,
Z_44 = 9'h12C,
Z_45 = 9'h12D,
Z_46 = 9'h12E,
Z_47 = 9'h12F,
Z_48 = 9'h130,
Z_49 = 9'h131,
Z_50 = 9'h132,
Z_51 = 9'h133,
Z_52 = 9'h134,
Z_53=  9'h135,
Z_54 = 9'h136,
Z_55 = 9'h137,
Z_56 = 9'h138,
Z_57 = 9'h139,
Z_58 = 9'h13A,
Z_59 = 9'h13B,
Z_60 = 9'h13C,
Z_61 = 9'h13D,
Z_62 = 9'h13E,
Z_63 = 9'h13F;

parameter [9:0]
M0_0 =10'h40,
M0_1 =10'h80,
M0_2 =10'hC0,
M0_3 =10'h100,
M0_4 =10'h140,
M0_5 =10'h180,
M0_6 =10'h1C0,
M0_7 =10'h200;

parameter [6:0]
CASE_0 = 7'h00,
CASE_1 = 7'h01,
CASE_2 = 7'h02,

CASE_3 = 7'h03,
CASE_4 = 7'h04,
CASE_5 = 7'h05,
CASE_6 = 7'h06,
CASE_7 = 7'h07,
CASE_8 = 7'h08,
CASE_9 = 7'h09,
CASE_10 = 7'h0a,
CASE_11 = 7'h0b,
CASE_12 = 7'h0c,
CASE_13 = 7'h0d,
CASE_14 = 7'h0e,
CASE_15 = 7'h0f,
CASE_16 = 7'h10,
CASE_17 = 7'h11,
CASE_18 = 7'h12,
CASE_19 = 7'h13,
CASE_20 = 7'h14,
CASE_21 = 7'h15,
CASE_22 = 7'h16,
CASE_23 = 7'h17,
CASE_24 = 7'h18,
CASE_25 = 7'h19,
CASE_26 = 7'h1a,
CASE_27 = 7'h1b,
CASE_28 = 7'h1c,
CASE_29 = 7'h1d,
CASE_30 = 7'h1e,
CASE_31 = 7'h1f,
CASE_32 = 7'h20,
CASE_33 = 7'h21,
CASE_34 = 7'h22,
CASE_35 = 7'h23,
CASE_36 = 7'h24,
CASE_37 = 7'h25,
CASE_38 = 7'h26,
CASE_39 = 7'h27,
CASE_40 = 7'h28,

CASE_41 = 7'h29,
CASE_42 = 7'h2a,
CASE_43 = 7'h2b,
CASE_44 = 7'h2c,
CASE_45 = 7'h2d,
CASE_46 = 7'h2e,
CASE_47 = 7'h2f,
CASE_48 = 7'h30,
CASE_49 = 7'h31,
CASE_50 = 7'h32,
CASE_51 = 7'h33,
CASE_52 = 7'h34,
CASE_53 = 7'h35,
CASE_54 = 7'h36,
CASE_55 = 7'h37,
CASE_56 = 7'h38,
CASE_57 = 7'h39,
CASE_58 = 7'h3a,
CASE_59 = 7'h3b,
CASE_60 = 7'h3c,
CASE_61 = 7'h3d,
CASE_62 = 7'h3e,
CASE_63 = 7'h3f;

reg [6:0] slave_count;
reg [3:0] master_count;
reg [2:0] buffer_count;
/**********************controller****************************/
always@(posedge clk or posedge reset)
begin

if(reset)
begin 
  slave_count<=7'h0;
  master_count<=4'h0;
  buffer_count<=3'h0;

end
else if(reiterate)
begin 
  slave_count<=7'h0;
  master_count<=4'h0;
  buffer_count<=3'h0;

end
else if (sram_enabled && start)
begin

	if(master_count==4'h8)  
		slave_count<=7'hxx;
	else if(slave_count==7'h3F) begin
	 	slave_count<=7'h0;
   	 	master_count<=master_count+4'h1;
	end
    	else slave_count<= slave_count+3'h1;
	
	
        if((master_count==4'h8)&&(buffer_count!=3'h6))
	   buffer_count<=buffer_count+3'h1;

end

end




/***********************reiterate logic*************************/
always@(posedge clk or posedge reset)
begin
if(reset) begin	
	mac2scompsel<=0;
	steptwo_sel<=0;
          done<=0;
	
end 
else if(reiterate) begin	
	mac2scompsel<=0;
	steptwo_sel<=0;
          done<=0;
	
end 
else if(buffer_count==3'h5) done<=1; 

else if(start && ~done) begin
	steptwo_sel<=1;
	mac2scompsel<=1;end
	
else if(done)
	steptwo_sel<=0;	
end


//write to dom memory
always@(posedge clk or posedge reset)             
begin
	if(reset)begin
		 qone__cdut__dom__write <= 1'b0;
		 qone__cdut__dom__data <= 16'hxxxx;
		 qone__cdut__dom__address <=3'bxxx;
	         end
        else if(reiterate)begin
		 qone__cdut__dom__write <= 1'b0;
		 qone__cdut__dom__data <= 16'hxxxx;
		 qone__cdut__dom__address <=3'bxxx;
	         end
  else if (sram_enabled && start) begin
     

	      
		 if((quad_dim_muxsel2reg==Z_4)&&(master_count==4'h1)) begin qone__cdut__dom__address <=3'b000;
							qone__cdut__dom__write <= 1'b1;
							qone__cdut__dom__data <= Z_data; end

   		else if  ((quad_dim_muxsel2reg==Z_4)&&(master_count==4'h2)) begin qone__cdut__dom__address <=3'b001;
							qone__cdut__dom__write <= 1'b1;
							qone__cdut__dom__data <= Z_data; end

  		 else if  ((quad_dim_muxsel2reg==Z_4)&&(master_count==4'h3)) begin qone__cdut__dom__address <=3'b010;
							qone__cdut__dom__write <= 1'b1;
							qone__cdut__dom__data <= Z_data; end

  		 else if  ((quad_dim_muxsel2reg==Z_4)&&(master_count==4'h4)) begin qone__cdut__dom__address <=3'b011;
							qone__cdut__dom__write <= 1'b1;
							qone__cdut__dom__data <= Z_data; end

  		 else if  ((quad_dim_muxsel2reg==Z_4)&&(master_count==4'h5)) begin qone__cdut__dom__address <=3'b100;
							qone__cdut__dom__write <= 1'b1;
							qone__cdut__dom__data <= Z_data; end

   		else if  ((quad_dim_muxsel2reg==Z_4)&&(master_count==4'h6)) begin qone__cdut__dom__address <=3'b101;
							qone__cdut__dom__write <= 1'b1;
							qone__cdut__dom__data <= Z_data; end

   		else if  ((quad_dim_muxsel2reg==Z_4)&&(master_count==4'h7)) begin qone__cdut__dom__address <=3'b110;
							qone__cdut__dom__write <= 1'b1;
							qone__cdut__dom__data <= Z_data; end

  		 else if  ((buffer_count==3'h4)&&(master_count==4'h8)) begin qone__cdut__dom__address <=3'b111;
							qone__cdut__dom__write <= 1'b1;
							qone__cdut__dom__data <= Z_data; end
  		 	  
		else begin       qone__cdut__dom__address <=9'bxxx;
				 qone__cdut__dom__write <= 1'b0; end
//		end
	end
end




	

//read filter vector memory
always@(posedge clk or posedge reset)             
begin
if(reset)begin
	 qone__cdut__bvm__address <=10'hxxx;
	 B_data_reg <= 16'h0; end

else if (reiterate)begin
	 qone__cdut__bvm__address <=10'hxxx;
	 B_data_reg <= 16'h0; end
else if (sram_enabled && start) begin

	if (master_count!=4'h8)begin qone__cdut__bvm__address <=quad_bvm_muxsel2reg+slave_count;end
	else begin qone__cdut__bvm__address <=10'hxxx; end		
	
	if (((slave_count>2)||(master_count!=0)))begin B_data_reg <= bvm__cdut__quadone__data; end		
	else begin B_data_reg <=16'h0; end
end
end


//read dim vector memory //scratch pad
always@(posedge clk or posedge reset)             
begin
if(reset)begin
	 qone__cdut__dim__address <=10'hxxx;
	 A_data_reg <= 16'h0; end
else if (reiterate)begin
	 qone__cdut__dim__address <=10'hxxx;
	 A_data_reg <= 16'h0; end

else if (sram_enabled && start) begin

	if (master_count!=4'h8)begin qone__cdut__dim__address <=quad_dim_muxsel2reg;end
	else begin qone__cdut__dim__address <=10'hxxx; end		
	
	if (((slave_count>2)||(master_count!=0))&&(buffer_count!=4'h3))begin A_data_reg <= dim__cdut__quadone__data; end		
	else begin A_data_reg <=16'h0; end
end
end

//select addresses input data memory
always@(slave_count)
begin
quad_dim_muxsel2reg=Z_0;
 
if(sram_enabled && start) begin 
case (slave_count)
	   CASE_0: begin	
			quad_dim_muxsel2reg=Z_0; 
		   end
	   CASE_1: begin
			quad_dim_muxsel2reg=Z_1;
		   end
	   CASE_2: begin
			quad_dim_muxsel2reg=Z_2;
		   end
	   CASE_3: begin	
			quad_dim_muxsel2reg=Z_3; 
		   end
	    CASE_4: begin
			quad_dim_muxsel2reg=Z_4;
	            end
	    CASE_5: begin
			quad_dim_muxsel2reg=Z_5;
                    end
	    CASE_6: begin
			quad_dim_muxsel2reg=Z_6;
                    end
	    CASE_7: begin
			quad_dim_muxsel2reg=Z_7;  
                    end
	    CASE_8: begin
			quad_dim_muxsel2reg=Z_8;
                    end
	    CASE_9: begin
			quad_dim_muxsel2reg=Z_9;
                    end
	    CASE_10: begin
			quad_dim_muxsel2reg=Z_10;
                     end
	    CASE_11: begin
			quad_dim_muxsel2reg=Z_11;
                     end

	    CASE_12: begin
			quad_dim_muxsel2reg=Z_12;
                     end
	    CASE_13: begin
			quad_dim_muxsel2reg=Z_13;
	             end
	    CASE_14: begin
			quad_dim_muxsel2reg=Z_14;
                     end
	    CASE_15: begin
			quad_dim_muxsel2reg=Z_15;
	             end
	    CASE_16: begin
			quad_dim_muxsel2reg=Z_16;
	             end
	    CASE_17: begin
			quad_dim_muxsel2reg=Z_17;
		     end
	    CASE_18: begin
			quad_dim_muxsel2reg=Z_18;
		     end
	    CASE_19: begin
			quad_dim_muxsel2reg=Z_19;
		     end
	    CASE_20: begin
			quad_dim_muxsel2reg=Z_20;
		     end

	    CASE_21: begin
			quad_dim_muxsel2reg=Z_21;
		     end
	    CASE_22: begin
			quad_dim_muxsel2reg=Z_22;
		     end
	    CASE_23: begin
			quad_dim_muxsel2reg=Z_23;
		     end
	    CASE_24: begin
			quad_dim_muxsel2reg=Z_24;
	             end
	    CASE_25: begin
			quad_dim_muxsel2reg=Z_25;
		     end
	    CASE_26: begin
			quad_dim_muxsel2reg=Z_26;
		     end
	    CASE_27: begin
			quad_dim_muxsel2reg=Z_27;
		     end
	    CASE_28: begin
			quad_dim_muxsel2reg=Z_28;
		     end
	   CASE_29: begin
			quad_dim_muxsel2reg=Z_29;
		    end

	    CASE_30: begin
			quad_dim_muxsel2reg=Z_30;
		    end
	    CASE_31: begin
			quad_dim_muxsel2reg=Z_31;
		     end

	    CASE_32: begin
			quad_dim_muxsel2reg=Z_32;
		     end
	    CASE_33: begin
			quad_dim_muxsel2reg=Z_33;
		    end
	    CASE_34: begin
			quad_dim_muxsel2reg=Z_34;
		     end
	    CASE_35: begin
			quad_dim_muxsel2reg=Z_35;
		    end
	    CASE_36: begin
			quad_dim_muxsel2reg=Z_36;
		     end
	    CASE_37: begin
			quad_dim_muxsel2reg=Z_37;
		    end
	    CASE_38: begin
			quad_dim_muxsel2reg=Z_38;
		     end
	   CASE_39: begin
			quad_dim_muxsel2reg=Z_39;
		    end
	   CASE_40: begin
			quad_dim_muxsel2reg=Z_40;
		    end
	   CASE_41: begin
			quad_dim_muxsel2reg=Z_41; 
		    end
	   CASE_42: begin
			quad_dim_muxsel2reg=Z_42; 
		    end
 
	   CASE_43: begin
			quad_dim_muxsel2reg=Z_43; 
		    end
			 
	   CASE_44: begin
			quad_dim_muxsel2reg=Z_44; 
		    end
		 
	   CASE_45: begin
			quad_dim_muxsel2reg=Z_45; 
		    end
		
	   CASE_46: begin
			quad_dim_muxsel2reg=Z_46; 
		    end
		 
	   CASE_47: begin			
			quad_dim_muxsel2reg=Z_47; 
	            end
			 
	   CASE_48: begin			
			quad_dim_muxsel2reg=Z_48; 
		    end
	 
   	   CASE_49: begin			
			quad_dim_muxsel2reg=Z_49; 
		    end
		 
	   CASE_50: begin			
			quad_dim_muxsel2reg=Z_50;
		    end
		 
	   CASE_51: begin
			quad_dim_muxsel2reg=Z_51; 
		    end
		 
	   CASE_52: begin
			quad_dim_muxsel2reg=Z_52;
		    end
	   CASE_53: begin
 			quad_dim_muxsel2reg=Z_53;
		    end
	   CASE_54: begin
	 		quad_dim_muxsel2reg=Z_54;
		    end
	   CASE_55: begin
			quad_dim_muxsel2reg=Z_55;
		    end
			 
	   CASE_56: begin 
			quad_dim_muxsel2reg=Z_56;
		    end

	   CASE_57: begin 
			quad_dim_muxsel2reg=Z_57;
		    end
	   CASE_58: begin 
			quad_dim_muxsel2reg=Z_58;
		    end
	   CASE_59: begin 
			quad_dim_muxsel2reg=Z_59;
		    end
	   CASE_60: begin 
			quad_dim_muxsel2reg=Z_60;
		    end
	   CASE_61: begin 
			quad_dim_muxsel2reg=Z_61;
		    end
	   CASE_62: begin 
			quad_dim_muxsel2reg=Z_62;
		    end
	   CASE_63: begin 
			quad_dim_muxsel2reg=Z_63;
		    end

endcase
end
end

//select starting addresses of filter data memory
always@(master_count)
begin
//quad_bvm_muxsel2reg=8'hxx;
quad_bvm_muxsel2reg=M0_0; 
if(sram_enabled && start) begin 
case (master_count)
	    CASE_0: begin	
			quad_bvm_muxsel2reg=M0_0;
                    end
	    CASE_1: begin
			quad_bvm_muxsel2reg=M0_1;
                    end
	    CASE_2: begin
			quad_bvm_muxsel2reg=M0_2;
                    end
	    CASE_3: begin	
			quad_bvm_muxsel2reg=M0_3;
                    end
	    CASE_4: begin
			quad_bvm_muxsel2reg=M0_4;
                    end
	    CASE_5: begin
			quad_bvm_muxsel2reg=M0_5;
		   end
	    CASE_6: begin
			quad_bvm_muxsel2reg=M0_6;
                   end
	    CASE_7: begin
			quad_bvm_muxsel2reg=M0_7;
                   end
endcase
end
end


reg signed [31:0] accum;

always@(posedge clk or posedge reset)
begin
if(reset) begin
accum<=32'b0; end
else if(reiterate) begin
accum<=32'b0; end
else if(quad_dim_muxsel2reg==Z_3 || buffer_count == 3'h4 ) begin accum<=32'b0; end
else begin 
accum <=MAC_inst; end
end

//multiplier accumulator instance
DW02_mac #(16, 16)
U1 ( .A(A_data_reg), .B(B_data_reg), .C(accum), .TC(mac2scompsel), .MAC(MAC_inst) );

always@(posedge clk or posedge reset)
begin

if(reset) Z_data<=0;
else if(reiterate) Z_data<=0;
else Z_data<= (MAC_inst[31]?0:MAC_inst[31:16]);

end

endmodule


//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

module QuadOperator (input wire  clk,
						   input wire  reset,
						   input wire start,
						   input wire sram_enabled, 
						   output reg quadone_sel,
						   output reg done,
						   input wire reiterate,
						   
// b-vector memory 
						  output reg  [ 9:0]          qone__cdut__bvm__address  , 
						  input  wire [15:0]          bvm__cdut__quadone__data     ,//        read data    
//---------------------------------------------------------------------------
// Input data memory 

						 output reg  [ 8:0]          qone__cdut__dim__address  , 
                          			 output reg                  qone__cdut__dim__write    ,
                          			 output reg  [15:0]          qone__cdut__dim__data     , //   write data
						 input  wire [15:0]          dim__cdut__quadone__data    //   read data

 );  
			       
							
reg [15:0] A_data_reg;
reg [15:0] B_data_reg;
reg [8:0] dim_quad_vaddress_select;
reg [7:0] bvm_quad_vaddress_select;
reg dim_NewAddressReady,dim_NewDataReady;
reg bvm_NewAddressReady,bvm_NewDataReady;
reg [8:0]quad_dim_muxsel2reg;
reg [7:0]quad_bvm_muxsel2reg;
reg mac2scompsel;
wire signed [31:0] MAC_inst;
reg [15:0] Z_data; 
reg [8:0]
next_state;

reg [15:0]

Inst0_B0_0,
Inst0_B0_1,
Inst0_B0_2,
Inst0_B0_3,

Inst0_B1_0,
Inst0_B1_1,
Inst0_B1_2,
Inst0_B1_3,

Inst0_B2_0,
Inst0_B2_1,
Inst0_B2_2,
Inst0_B2_3,
 
Inst0_B3_0,
Inst0_B3_1,
Inst0_B3_2,
Inst0_B3_3;
//synopsys template
parameter [7:0]
A_SUBQUAD_0_0 = 8'h00,
A_SUBQUAD_0_1 = 8'h01,
A_SUBQUAD_0_2 = 8'h02,
A_SUBQUAD_0_3 = 8'h10,
A_SUBQUAD_0_4 = 8'h11,
A_SUBQUAD_0_5 = 8'h12,
A_SUBQUAD_0_6 = 8'h20,
A_SUBQUAD_0_7 = 8'h21,
A_SUBQUAD_0_8 = 8'h22,

A_SUBQUAD_1_0 = 8'h03,
A_SUBQUAD_1_1 = 8'h04,
A_SUBQUAD_1_2 = 8'h05,
A_SUBQUAD_1_3 = 8'h13,
A_SUBQUAD_1_4 = 8'h14,
A_SUBQUAD_1_5 = 8'h15,
A_SUBQUAD_1_6 = 8'h23,
A_SUBQUAD_1_7 = 8'h24,
A_SUBQUAD_1_8 = 8'h25,

A_SUBQUAD_2_0 = 8'h30,
A_SUBQUAD_2_1 = 8'h31,
A_SUBQUAD_2_2 = 8'h32,
A_SUBQUAD_2_3 = 8'h40,
A_SUBQUAD_2_4 = 8'h41,
A_SUBQUAD_2_5 = 8'h42,
A_SUBQUAD_2_6 = 8'h50,
A_SUBQUAD_2_7 = 8'h51,
A_SUBQUAD_2_8 = 8'h52,

A_SUBQUAD_3_0 = 8'h33,
A_SUBQUAD_3_1 = 8'h34,
A_SUBQUAD_3_2 = 8'h35,
A_SUBQUAD_3_3 = 8'h43,
A_SUBQUAD_3_4 = 8'h44,
A_SUBQUAD_3_5 = 8'h45,
A_SUBQUAD_3_6 = 8'h53,
A_SUBQUAD_3_7 = 8'h54,
A_SUBQUAD_3_8 = 8'h55,
A_SUBQUAD_Z_Z = 8'hxx;

parameter [8:0]
OUT_INST0_B0_0= 9'h100,
OUT_INST0_B0_1= 9'h101,
OUT_INST0_B0_2= 9'h104,
OUT_INST0_B0_3= 9'h105,

OUT_INST0_B1_0= 9'h110,
OUT_INST0_B1_1= 9'h111,
OUT_INST0_B1_2= 9'h114,
OUT_INST0_B1_3= 9'h115,

OUT_INST0_B2_0= 9'h120,
OUT_INST0_B2_1= 9'h121,
OUT_INST0_B2_2= 9'h124,
OUT_INST0_B2_3= 9'h125,

OUT_INST0_B3_0= 9'h130,
OUT_INST0_B3_1= 9'h131,
OUT_INST0_B3_2= 9'h134,
OUT_INST0_B3_3= 9'h135;

parameter [8:0]
B0_0 = 9'h00,
B0_1 = 9'h01,
B0_2 = 9'h02,
B0_3 = 9'h03,
B0_4 = 9'h04,
B0_5 = 9'h05,
B0_6 = 9'h06,
B0_7 = 9'h07,
B0_8 = 9'h08,

B1_0 = 9'h10,
B1_1 = 9'h11,
B1_2 = 9'h12,
B1_3 = 9'h13,
B1_4 = 9'h14,
B1_5 = 9'h15,
B1_6 = 9'h16,
B1_7 = 9'h17,
B1_8 = 9'h18,

B2_0 = 9'h20,
B2_1 = 9'h21,
B2_2 = 9'h22,
B2_3 = 9'h23,
B2_4 = 9'h24,
B2_5 = 9'h25,
B2_6 = 9'h26,
B2_7 = 9'h27,
B2_8 = 9'h28,

B3_0 = 9'h30,
B3_1 = 9'h31,
B3_2 = 9'h32,
B3_3 = 9'h33,
B3_4 = 9'h34,
B3_5 = 9'h35,
B3_6 = 9'h36,
B3_7 = 9'h37,
B3_8 = 9'h38;



parameter [7:0]
CASE_0 = 8'h00,
CASE_1 = 8'h01,
CASE_2 = 8'h02,

CASE_3 = 8'h03,
CASE_4 = 8'h04,
CASE_5 = 8'h05,
CASE_6 = 8'h06,
CASE_7 = 8'h07,
CASE_8 = 8'h08,
CASE_9 = 8'h09,
CASE_10 = 8'h10,
CASE_11 = 8'h11,
CASE_12 = 8'h12,
CASE_13 = 8'h13,
CASE_14 = 8'h14,
CASE_15 = 8'h15,
CASE_16 = 8'h16,
CASE_17 = 8'h17,
CASE_18 = 8'h18,
CASE_19 = 8'h19,
CASE_20 = 8'h20,
CASE_21 = 8'h21,
CASE_22 = 8'h22,
CASE_23 = 8'h23,
CASE_24 = 8'h24,
CASE_25 = 8'h25,
CASE_26 = 8'h26,
CASE_27 = 8'h27,
CASE_28 = 8'h28,
CASE_29 = 8'h29,
CASE_30 = 8'h30,
CASE_31 = 8'h31,
CASE_32 = 8'h32,
CASE_33 = 8'h33,
CASE_34 = 8'h34,
CASE_35 = 8'h35,
CASE_36 = 8'h36,
CASE_37 = 8'h37,
CASE_38 = 8'h38,
CASE_39 = 8'h39,
CASE_40 = 8'h40,

CASE_41 = 8'h41,//starts write to dom
CASE_42 = 8'h42,
CASE_43 = 8'h43,
CASE_44 = 8'h44,
CASE_45 = 8'h45,
CASE_46 = 8'h46,
CASE_47 = 8'h47,
CASE_48 = 8'h48,
CASE_49 = 8'h49,
CASE_50 = 8'h50,
CASE_51 = 8'h51,
CASE_52 = 8'h52,
CASE_53 = 8'h53,
CASE_54 = 8'h54,
CASE_55 = 8'h55,
CASE_56 = 8'h56;

parameter [7:0]
// synopsys enum states
  S0 = 8'b00000000,             
  S1 = 8'b00000001,            
  S2 = 8'b00000010,          
  S3 = 8'b00000011,               
  S4 = 8'b00000100,             
  S5 = 8'b00000101,           
  S6 = 8'b00000110,                
  S7 = 8'b00000111,            
  S8 = 8'b00001000,              
  S9 = 8'b00001001,               
 S10 = 8'b00001010,                
 S11 = 8'b00001011,                
 S12 = 8'b00001100,                 
 S13 = 8'b00001101,              
 S14 = 8'b00001110,                 
 S15 = 8'b00001111,                 
 S16 = 8'b00010000,                 
 S17 = 8'b00010001,               
 S18 = 8'b00010010, 
 S19 = 8'b00010011,                
 S20 = 8'b00010100,                
 S21 = 8'b00010101,                 
 S22 = 8'b00010110,                
 S23 = 8'b00010111,            
 S24 = 8'b00011000,             
 S25 = 8'b00011001,           
 S26 = 8'b00011010,           
 S27 = 8'b00011011,            
 S28 = 8'b00011100,            
 S29 = 8'b00011101,            
 S30 = 8'b00011110,         
 S31 = 8'b00011111,             
 S32 = 8'b00100000,          
 S33 = 8'b00100001,          
 S34 = 8'b00100010,            
 S35 = 8'b00100011,             
 S36 = 8'b00100100,          
 S37 = 8'b00100101,            
 S38 = 8'b00100110,            
 S39 = 8'b00100111,            
 S40 = 8'b00101000,           
 S41 = 8'b00101001,          
 S42 = 8'b00101010,          
 S43 = 8'b00101011,           
 S44 = 8'b00101100,           
 S45 = 8'b00101101,            
 S46 = 8'b00101110,          
 S47 = 8'b00101111,            
 S48 = 8'b00110000,           
 S49 = 8'b00110001,            
 S50 = 8'b00110010,            
 S51 = 8'b00110011,            
 S52 = 8'b00110100,           
 S53 = 8'b00110101,          
 S54 = 8'b00110110,           
 S55 = 8'b00110111,            
 S56 = 8'b00111000,           
 S57 = 8'b00111001,            
 S58 = 8'b00111010,        
 S59 = 8'b00111011,           
 S60 = 8'b00111100,           
 S61 = 8'b00111101,           
 S62 = 8'b00111110,            
 S63 = 8'b00111111,        
 S64 = 8'b01000000,
 S65 = 8'b01000001,
 S66 = 8'b01000010,
 S67 = 8'b01000011,
 S68 = 8'b01000100,
 S69 = 8'b01000101,
 S70 = 8'b01000110 ,
 S71 = 8'b01000111,
 S72 = 8'b01001000,
 S73 = 8'b01001001,
 S74 = 8'b01001010,
 S75 = 8'b01001011,
 S76 = 8'b01001100,
 S77 = 8'b01001101,
 S78 = 8'b01001110,
 S79 = 8'b01001111,
 S80 = 8'b01010000,
 S81 = 8'b01010001 ,
 S82 = 8'b01010010,
 S83 = 8'b01010011,
 S84 = 8'b01010100,
 S85 = 8'b01010101,
 S86 = 8'b01010110,
 S87 = 8'b01010111,
 S88 = 8'b01011000,
 S89 = 8'b01011001,
 S90 = 8'b01011010,
 S91 = 8'b01011011,
 S92 = 8'b01011100,
 S93 = 8'b01011101, 
 S94 = 8'b01011110 ,
 S95 = 8'b01011111,
 S96 = 8'b01100000,
 S97 = 8'b01100001 ,
 S98 = 8'b01100010,
 S99 = 8'b01100011,
 S100= 8'b01100100 ,
 S101= 8'b01100101,
 S102= 8'b01100110,
 S103= 8'b01100111,
 S104= 8'b01101000,
 S105= 8'b01101001,
 S106= 8'b01101010,
 S107= 8'b01101011, 
 S108  = 8'b01101100,
 S109  = 8'b01101101,
 S110  = 8'b01101110,
 S111  = 8'b01101111,
 S112  = 8'b01110000,
 S113  = 8'b01110001,
 S114  = 8'b01110010,
 S115  = 8'b01110011,
 S116  = 8'b01110100,
 S117  = 8'b01110101,
 S118  = 8'b01110110,
 S119  = 8'b01110111,
 S120  = 8'b01111000,
 S121  = 8'b01111001,
 S122  = 8'b01111010, 
 S123  = 8'b01111011,
 S124  = 8'b01111100,
 S125  = 8'b01111101,
 S126  = 8'b01111110,
 S127  = 8'b01111111,
 S128  = 8'b10000000,
 S129  = 8'b10000001,
 S130  = 8'b10000010,
 S131  = 8'b10000011,
 S132  = 8'b10000100,
 S133  = 8'b10000101,
 S134  = 8'b10000110 ,
 S135  = 8'b10000111,
 S136  = 8'b10001000,
 S137  = 8'b10001001,
 S138  = 8'b10001010,
 S139  = 8'b10001011,
 S140  = 8'b10001100,
 S141  = 8'b10001101,
 S142  = 8'b10001110,
 S143  = 8'b10001111,
 S144  = 8'b10010000,
 S145  = 8'b10010001,
 S146  = 8'b10010010,
 S147  = 8'b10010011,
 S148  = 8'b10010100,
 S149  = 8'b10010101,
 S150  = 8'b10010110,
 S151  = 8'b10010111,
 S152  = 8'b10011000,
 S153  = 8'b10011001,
 S154  = 8'b10011010,
 S155  = 8'b10011011,
 S156  = 8'b10011100,
 S157  = 8'b10011101,
 S158  = 8'b10011110,
 S159  = 8'b10011111,
 S160  = 8'b10100000,
 S161  = 8'b10100001,
 S162  = 8'b10100010,
 S163  = 8'b10100011,
 S164  = 8'b10100100,
 S165  = 8'b10100101,
 S166  = 8'b10100110;
/******************************store in temp store****************************/
always@(posedge clk or posedge reset)
begin
if(reset)
begin
Inst0_B0_0<=0;
Inst0_B0_1<=0;
Inst0_B0_2<=0;
Inst0_B0_3<=0;

Inst0_B1_0<=0;
Inst0_B1_1<=0;
Inst0_B1_2<=0;
Inst0_B1_3<=0;

Inst0_B2_0<=0;
Inst0_B2_1<=0;
Inst0_B2_2<=0;
Inst0_B2_3<=0;
 
Inst0_B3_0<=0;
Inst0_B3_1<=0;
Inst0_B3_2<=0;
Inst0_B3_3<=0;
end
else if(reiterate) begin
Inst0_B0_0<=0;
Inst0_B0_1<=0;
Inst0_B0_2<=0;
Inst0_B0_3<=0;

Inst0_B1_0<=0;
Inst0_B1_1<=0;
Inst0_B1_2<=0;
Inst0_B1_3<=0;

Inst0_B2_0<=0;
Inst0_B2_1<=0;
Inst0_B2_2<=0;
Inst0_B2_3<=0;
 
Inst0_B3_0<=0;
Inst0_B3_1<=0;
Inst0_B3_2<=0;
Inst0_B3_3<=0;
end
else if(next_state == S15)
Inst0_B0_0<= Z_data;
else if(next_state == S24)
Inst0_B0_1<= Z_data;
else if(next_state == S33) 
Inst0_B0_2<= Z_data;
else if(next_state == S42)
 
Inst0_B0_3<= Z_data;
else if(next_state == S51) 
Inst0_B1_0<= Z_data;
else if(next_state == S60) 
Inst0_B1_1<= Z_data;
else if(next_state == S69) 
Inst0_B1_2<= Z_data;
else if(next_state == S78)
Inst0_B1_3<= Z_data;

else if(next_state == S87)
Inst0_B2_0<= Z_data;
else if(next_state == S96)
Inst0_B2_1<= Z_data;
else if(next_state == S105)
Inst0_B2_2<= Z_data;
else if(next_state == S114)
Inst0_B2_3<= Z_data;

else if(next_state == S123)
Inst0_B3_0<= Z_data;
else if(next_state == S132)
Inst0_B3_1<= Z_data;
else if(next_state == S141)
Inst0_B3_2<= Z_data;
else if(next_state == S150)
Inst0_B3_3<= Z_data;

end
/* represents the register which stores the next_state*/
always@(posedge clk or posedge reset )
begin

if(reset) begin
	next_state <= S0;
	done<=1'b0;
	dim_quad_vaddress_select<=CASE_39;
	bvm_quad_vaddress_select<=CASE_39;				  
end

else if (reiterate)
begin
	next_state <= S0;
	done<=1'b0;
	dim_quad_vaddress_select<=CASE_39;
	bvm_quad_vaddress_select<=CASE_39;
end

else if(sram_enabled && start) begin
			
next_state <=S1;	     				
case(next_state)    //synopsys full_case parallel_case



	S1:begin 
		dim_quad_vaddress_select<=CASE_0;
		bvm_quad_vaddress_select<=CASE_0;
			next_state<=S2;		
	  end

	S2:begin 
		dim_quad_vaddress_select<=CASE_1;
		bvm_quad_vaddress_select<=CASE_1;				    
	               next_state <=S3;
	  end

	S3:begin 
		dim_quad_vaddress_select<=CASE_2;
		bvm_quad_vaddress_select<=CASE_2;
		      next_state <=S4;				    
	  end

	S4:begin 
		dim_quad_vaddress_select<=CASE_6;
		bvm_quad_vaddress_select<=CASE_6;
		      next_state <=S5;				    
	  end

	S5:begin 
		dim_quad_vaddress_select<=CASE_7;
		bvm_quad_vaddress_select<=CASE_7;
		      next_state <=S6;				    
	  end	

	S6:begin 
		dim_quad_vaddress_select<=CASE_8;
		bvm_quad_vaddress_select<=CASE_8;
		      next_state <=S7;				    
	  end

	S7:begin 
		dim_quad_vaddress_select<=CASE_9;
		bvm_quad_vaddress_select<=CASE_9;
		     next_state <=S8;				    
	  end

	S8:begin 
		dim_quad_vaddress_select<=CASE_10;
		bvm_quad_vaddress_select<=CASE_10;
		     next_state <=S9;				    
	  end

	S9:begin 
		dim_quad_vaddress_select<=CASE_11;
		bvm_quad_vaddress_select<=CASE_11;
		     next_state <=S10;				    
	  end
//-------------------------
	S10:begin 
		dim_quad_vaddress_select<=CASE_12;
		bvm_quad_vaddress_select<=CASE_3;
		    next_state <=S11;				    
	  end


	S11:begin 
		dim_quad_vaddress_select<=CASE_13;
		bvm_quad_vaddress_select<=CASE_4;
		   next_state <=S12;				    
	  end

	S12:begin 
		dim_quad_vaddress_select<=CASE_14;
		bvm_quad_vaddress_select<=CASE_5;
		   next_state <=S13;					    
	  end

	S13:begin 
		dim_quad_vaddress_select<=CASE_15;
		bvm_quad_vaddress_select<=CASE_6;
		  next_state <=S14;					    
	  end

	S14:begin 
		dim_quad_vaddress_select<=CASE_16;
		bvm_quad_vaddress_select<=CASE_7;
		  next_state <=S15;					    
	  end

	S15:begin 
		dim_quad_vaddress_select<=CASE_17;
		bvm_quad_vaddress_select<=CASE_8;
                  next_state <=S16;					    
	  end

	S16:begin 
		dim_quad_vaddress_select<=CASE_18;
		bvm_quad_vaddress_select<=CASE_9;
		  next_state <=S17;	
      				    
	  end

	S17:begin 
		dim_quad_vaddress_select<=CASE_19;
		bvm_quad_vaddress_select<=CASE_10;
                  next_state <=S18;					    
	  end

	S18:begin 
		dim_quad_vaddress_select<=CASE_20;
		bvm_quad_vaddress_select<=CASE_11;
		  next_state <=S19;					    
	  end

//------------------------------
	S19:begin 
		dim_quad_vaddress_select<=CASE_21;
		bvm_quad_vaddress_select<=CASE_3;
		 next_state <=S20;					    
	  end
	S20:begin 
		dim_quad_vaddress_select<=CASE_22;
		bvm_quad_vaddress_select<=CASE_4;
		next_state <=S21;					    
	  end
	S21:begin 
		dim_quad_vaddress_select<=CASE_23;
		bvm_quad_vaddress_select<=CASE_5;
	        next_state <=S22;					    
	  end
	S22:begin 
		dim_quad_vaddress_select<=CASE_24;
		bvm_quad_vaddress_select<=CASE_6;
		next_state <=S23;					    
	  end
	S23:begin 
		dim_quad_vaddress_select<=CASE_25;
		bvm_quad_vaddress_select<=CASE_7;
                next_state <=S24;					    
	  end
	S24:begin 
		dim_quad_vaddress_select<=CASE_26;
		bvm_quad_vaddress_select<=CASE_8;
		next_state <=S25;				    
	  end
	S25:begin 
		dim_quad_vaddress_select<=CASE_27;
		bvm_quad_vaddress_select<=CASE_9;
		next_state <=S26;				    
	  end
	S26:begin 
		dim_quad_vaddress_select<=CASE_28;
		bvm_quad_vaddress_select<=CASE_10;
		next_state <=S27;				    
	  end
	S27:begin 
		dim_quad_vaddress_select<=CASE_29;
		bvm_quad_vaddress_select<=CASE_11;	
		next_state <=S28;			    
	  end
//-----------------------------------
	S28:begin 
		dim_quad_vaddress_select<=CASE_30;
		bvm_quad_vaddress_select<=CASE_3;
		next_state <=S29;				    
	  end

	S29:begin 
		dim_quad_vaddress_select<=CASE_31;
		bvm_quad_vaddress_select<=CASE_4;
		next_state <=S30;				    
	  end

	S30:begin 
		dim_quad_vaddress_select<=CASE_32;
		bvm_quad_vaddress_select<=CASE_5;
		next_state <=S31;				    
	  end

	S31:begin 
		dim_quad_vaddress_select<=CASE_33;
		bvm_quad_vaddress_select<=CASE_6;
		next_state <=S32;				    
	  end

	S32:begin 
		dim_quad_vaddress_select<=CASE_34;
		bvm_quad_vaddress_select<=CASE_7;
		next_state <=S33;				    
	  end

	S33:begin 
		dim_quad_vaddress_select<=CASE_35;
		bvm_quad_vaddress_select<=CASE_8;
		next_state <=S34;				    
	  end

	S34:begin 
		dim_quad_vaddress_select<=CASE_36;
		bvm_quad_vaddress_select<=CASE_9;
		next_state <=S35;				    
	  end

	S35:begin 
		dim_quad_vaddress_select<=CASE_37;
		bvm_quad_vaddress_select<=CASE_10;
		next_state <=S36;				    
	  end

	S36:begin 
		dim_quad_vaddress_select<=CASE_38;
		bvm_quad_vaddress_select<=CASE_11;
		next_state <=S37;				    
	  end
//---------------------------------
	S37:begin 
		dim_quad_vaddress_select<=CASE_3;
		bvm_quad_vaddress_select<=CASE_12;
		next_state <=S38;				    
	  end

	S38:begin 
		dim_quad_vaddress_select<=CASE_4;
		bvm_quad_vaddress_select<=CASE_13;
		next_state <=S39;				    
	  end

	S39:begin 
		dim_quad_vaddress_select<=CASE_5;
		bvm_quad_vaddress_select<=CASE_14;
		next_state <=S40;				    
	  end

	S40:begin 
		dim_quad_vaddress_select<=CASE_6;
		bvm_quad_vaddress_select<=CASE_15;
		next_state <=S41;				    
	  end

	S41:begin 
		dim_quad_vaddress_select<=CASE_7;
		bvm_quad_vaddress_select<=CASE_16;
		next_state <=S42;				    
	  end

	S42:begin 
		dim_quad_vaddress_select<=CASE_8;
		bvm_quad_vaddress_select<=CASE_17;
		next_state <=S43;				    
	  end

	S43:begin 
		dim_quad_vaddress_select<=CASE_9;
		bvm_quad_vaddress_select<=CASE_18;
		next_state <=S44;				    
	  end

	S44:begin 
		dim_quad_vaddress_select<=CASE_10;
		bvm_quad_vaddress_select<=CASE_19;
		next_state <=S45;				    
	  end

	S45:begin 
		dim_quad_vaddress_select<=CASE_11;
		bvm_quad_vaddress_select<=CASE_20;
		next_state <=S46;				    
	  end

//-----------------------

	S46:begin 
		dim_quad_vaddress_select<=CASE_12;
		bvm_quad_vaddress_select<=CASE_12;
		next_state <=S47;				    
	  end

	S47:begin 
		dim_quad_vaddress_select<=CASE_13;
		bvm_quad_vaddress_select<=CASE_13;
		next_state <=S48;				    
	  end

	S48:begin 
		dim_quad_vaddress_select<=CASE_14;
		bvm_quad_vaddress_select<=CASE_14;
		next_state <=S49;				    
	  end

	S49:begin 
		dim_quad_vaddress_select<=CASE_15;
		bvm_quad_vaddress_select<=CASE_15;
		next_state <=S50;				    
	  end

	S50:begin 
		dim_quad_vaddress_select<=CASE_16;
		bvm_quad_vaddress_select<=CASE_16;
		next_state <=S51;				    
	  end

	S51:begin 
		dim_quad_vaddress_select<=CASE_17;
		bvm_quad_vaddress_select<=CASE_17;
		next_state <=S52;				    
	  end

	S52:begin 
		dim_quad_vaddress_select<=CASE_18;
		bvm_quad_vaddress_select<=CASE_18;
		next_state <=S53;				    
	  end

	S53:begin 
		dim_quad_vaddress_select<=CASE_19;
		bvm_quad_vaddress_select<=CASE_19;
		next_state <=S54;				    
	  end

	S54:begin 
		dim_quad_vaddress_select<=CASE_20;
		bvm_quad_vaddress_select<=CASE_20;
		next_state <=S55;				    
	  end
//-------------------


	S55:begin 
		dim_quad_vaddress_select<=CASE_21;
		bvm_quad_vaddress_select<=CASE_12;
		next_state <=S56;				    
	  end

	S56:begin 
		dim_quad_vaddress_select<=CASE_22;
		bvm_quad_vaddress_select<=CASE_13;
		next_state <=S57;				    
	  end

	S57:begin 
		dim_quad_vaddress_select<=CASE_23;
		bvm_quad_vaddress_select<=CASE_14;
		next_state <=S58;				    
	  end

	S58:begin 
		dim_quad_vaddress_select<=CASE_24;
		bvm_quad_vaddress_select<=CASE_15;
		next_state <=S59;				    
	  end

	S59:begin 
		dim_quad_vaddress_select<=CASE_25;
		bvm_quad_vaddress_select<=CASE_16;
		next_state <=S60;				    
	  end

	S60:begin 
		dim_quad_vaddress_select<=CASE_26;
		bvm_quad_vaddress_select<=CASE_17;
		next_state <=S61;				    
	  end

	S61:begin 
		dim_quad_vaddress_select<=CASE_27;
		bvm_quad_vaddress_select<=CASE_18;
		next_state <=S62;				    
	  end

	S62:begin 
		dim_quad_vaddress_select<=CASE_28;
		bvm_quad_vaddress_select<=CASE_19;
		next_state <=S63;				    
	  end

	S63:begin 
		dim_quad_vaddress_select<=CASE_29;
		bvm_quad_vaddress_select<=CASE_20;
		next_state <=S64;				    
	  end
//------------


	S64:begin 
		dim_quad_vaddress_select<=CASE_30;
		bvm_quad_vaddress_select<=CASE_12;
		next_state <=S65;				    
	  end

	S65:begin 
		dim_quad_vaddress_select<=CASE_31;
		bvm_quad_vaddress_select<=CASE_13;
		next_state <=S66;				    
	  end

	S66:begin 
		dim_quad_vaddress_select<=CASE_32;
		bvm_quad_vaddress_select<=CASE_14;
		next_state <=S67;				    
	  end

	S67:begin 
		dim_quad_vaddress_select<=CASE_33;
		bvm_quad_vaddress_select<=CASE_15;
		next_state <=S68;				    
	  end

	S68:begin 
		dim_quad_vaddress_select<=CASE_34;
		bvm_quad_vaddress_select<=CASE_16;
		next_state <=S69;				    
	  end

	S69:begin 
		dim_quad_vaddress_select<=CASE_35;
		bvm_quad_vaddress_select<=CASE_17;
		next_state <=S70;				    
	  end

	S70:begin 
		dim_quad_vaddress_select<=CASE_36;
		bvm_quad_vaddress_select<=CASE_18;
		next_state <=S71;				    
	  end

	S71:begin 
		dim_quad_vaddress_select<=CASE_37;
		bvm_quad_vaddress_select<=CASE_19;
		next_state <=S72;				    
	  end

	S72:begin 
		dim_quad_vaddress_select<=CASE_38;
		bvm_quad_vaddress_select<=CASE_20;
		next_state <=S73;				    
	  end
//---------------------------------
	S73:begin 
		dim_quad_vaddress_select<=CASE_3;
		bvm_quad_vaddress_select<=CASE_21;
		next_state <=S74;				    
	  end

	S74:begin 
		dim_quad_vaddress_select<=CASE_4;
		bvm_quad_vaddress_select<=CASE_22;
		next_state <=S75;				    
	  end

	S75:begin 
		dim_quad_vaddress_select<=CASE_5;
		bvm_quad_vaddress_select<=CASE_23;
		next_state <=S76;				    
	  end

	S76:begin 
		dim_quad_vaddress_select<=CASE_6;
		bvm_quad_vaddress_select<=CASE_24;
		next_state <=S77;				    
	  end

	S77:begin 
		dim_quad_vaddress_select<=CASE_7;
		bvm_quad_vaddress_select<=CASE_25;
		next_state <=S78;				    
	  end

	S78:begin 
		dim_quad_vaddress_select<=CASE_8;
		bvm_quad_vaddress_select<=CASE_26;
		next_state <=S79;				    
	  end

	S79:begin 
		dim_quad_vaddress_select<=CASE_9;
		bvm_quad_vaddress_select<=CASE_27;
		next_state <=S80;				    
	  end

	S80:begin 
		dim_quad_vaddress_select<=CASE_10;
		bvm_quad_vaddress_select<=CASE_28;
		next_state <=S81;				    
	  end

	S81:begin 
		dim_quad_vaddress_select<=CASE_11;
		bvm_quad_vaddress_select<=CASE_29;
		next_state <=S82;				    
	  end

//-----------------------

	S82:begin 
		dim_quad_vaddress_select<=CASE_12;
		bvm_quad_vaddress_select<=CASE_21;
		next_state <=S83;				    
	  end

	S83:begin 
		dim_quad_vaddress_select<=CASE_13;
		bvm_quad_vaddress_select<=CASE_22;
		next_state <=S84;				    
	  end

	S84:begin 
		dim_quad_vaddress_select<=CASE_14;
		bvm_quad_vaddress_select<=CASE_23;
		next_state <=S85;				    
	  end

	S85:begin 
		dim_quad_vaddress_select<=CASE_15;
		bvm_quad_vaddress_select<=CASE_24;
		next_state <=S86;				    
	  end

	S86:begin 
		dim_quad_vaddress_select<=CASE_16;
		bvm_quad_vaddress_select<=CASE_25;
		next_state <=S87;				    
	  end

	S87:begin 
		dim_quad_vaddress_select<=CASE_17;
		bvm_quad_vaddress_select<=CASE_26;
		next_state <=S88;				    
	  end

	S88:begin 
		dim_quad_vaddress_select<=CASE_18;
		bvm_quad_vaddress_select<=CASE_27;
		next_state <=S89;				    
	  end

	S89:begin 
		dim_quad_vaddress_select<=CASE_19;
		bvm_quad_vaddress_select<=CASE_28;
		next_state <=S90;				    
	  end

	S90:begin 
		dim_quad_vaddress_select<=CASE_20;
		bvm_quad_vaddress_select<=CASE_29;
		next_state <=S91;				    
	  end
//-------------------


	S91:begin 
		dim_quad_vaddress_select<=CASE_21;
		bvm_quad_vaddress_select<=CASE_21;
		next_state <=S92;				    
	  end

	S92:begin 
		dim_quad_vaddress_select<=CASE_22;
		bvm_quad_vaddress_select<=CASE_22;
		next_state <=S93;				    
	  end

	S93:begin 
		dim_quad_vaddress_select<=CASE_23;
		bvm_quad_vaddress_select<=CASE_23;
		next_state <=S94;				    
	  end

	S94:begin 
		dim_quad_vaddress_select<=CASE_24;
		bvm_quad_vaddress_select<=CASE_24;
		next_state <=S95;				    
	  end

	S95:begin 
		dim_quad_vaddress_select<=CASE_25;
		bvm_quad_vaddress_select<=CASE_25;
		next_state <=S96;				    
	  end

	S96:begin 
		dim_quad_vaddress_select<=CASE_26;
		bvm_quad_vaddress_select<=CASE_26;
		next_state <=S97;				    
	  end

	S97:begin 
		dim_quad_vaddress_select<=CASE_27;
		bvm_quad_vaddress_select<=CASE_27;
		next_state <=S98;				    
	  end

	S98:begin 
		dim_quad_vaddress_select<=CASE_28;
		bvm_quad_vaddress_select<=CASE_28;
		next_state <=S99;				    
	  end

	S99:begin 
		dim_quad_vaddress_select<=CASE_29;
		bvm_quad_vaddress_select<=CASE_29;
		next_state <=S100;				    
	  end
//------------


	S100:begin 
		dim_quad_vaddress_select<=CASE_30;
		bvm_quad_vaddress_select<=CASE_21;
		next_state <=S101;				    
	  end

	S101:begin 
		dim_quad_vaddress_select<=CASE_31;
		bvm_quad_vaddress_select<=CASE_22;
		next_state <=S102;				    
	  end

	S102:begin 
		dim_quad_vaddress_select<=CASE_32;
		bvm_quad_vaddress_select<=CASE_23;
		next_state <=S103;				    
	  end

	S103:begin 
		dim_quad_vaddress_select<=CASE_33;
		bvm_quad_vaddress_select<=CASE_24;
		next_state <=S104;				    
	  end

	S104:begin 
		dim_quad_vaddress_select<=CASE_34;
		bvm_quad_vaddress_select<=CASE_25;
		next_state <=S105;				    
	  end

	S105:begin 
		dim_quad_vaddress_select<=CASE_35;
		bvm_quad_vaddress_select<=CASE_26;
		next_state <=S106;				    
	  end

	S106:begin 
		dim_quad_vaddress_select<=CASE_36;
		bvm_quad_vaddress_select<=CASE_27;
		next_state <=S107;				    
	  end

	S107:begin 
		dim_quad_vaddress_select<=CASE_37;
		bvm_quad_vaddress_select<=CASE_28;
		next_state <=S108;				    
	  end

	S108:begin 
		dim_quad_vaddress_select<=CASE_38;
		bvm_quad_vaddress_select<=CASE_29;
		next_state <=S109;				    
	  end
//---------------------------------
	S109:begin 
		dim_quad_vaddress_select<=CASE_3;
		bvm_quad_vaddress_select<=CASE_30;
		next_state <=S110;				    
	  end

	S110:begin 
		dim_quad_vaddress_select<=CASE_4;
		bvm_quad_vaddress_select<=CASE_31;
		next_state <=S111;				    
	  end

	S111:begin 
		dim_quad_vaddress_select<=CASE_5;
		bvm_quad_vaddress_select<=CASE_32;
		next_state <=S112;				    
	  end

	S112:begin 
		dim_quad_vaddress_select<=CASE_6;
		bvm_quad_vaddress_select<=CASE_33;
		next_state <=S113;				    
	  end

	S113:begin 
		dim_quad_vaddress_select<=CASE_7;
		bvm_quad_vaddress_select<=CASE_34;
		next_state <=S114;				    
	  end

	S114:begin 
		dim_quad_vaddress_select<=CASE_8;
		bvm_quad_vaddress_select<=CASE_35;
		next_state <=S115;				    
	  end

	S115:begin 
		dim_quad_vaddress_select<=CASE_9;
		bvm_quad_vaddress_select<=CASE_36;
		next_state <=S116;				    
	  end

	S116:begin 
		dim_quad_vaddress_select<=CASE_10;
		bvm_quad_vaddress_select<=CASE_37;
		next_state <=S117;				    
	  end

	S117:begin 
		dim_quad_vaddress_select<=CASE_11;
		bvm_quad_vaddress_select<=CASE_38;
		next_state <=S118;				    
	  end

//-----------------------

	S118:begin 
		dim_quad_vaddress_select<=CASE_12;
		bvm_quad_vaddress_select<=CASE_30;
		next_state <=S119;				    
	  end

	S119:begin 
		dim_quad_vaddress_select<=CASE_13;
		bvm_quad_vaddress_select<=CASE_31;
		next_state <=S120;				    
	  end

	S120:begin 
		dim_quad_vaddress_select<=CASE_14;
		bvm_quad_vaddress_select<=CASE_32;
		next_state <=S121;				    
	  end

	S121:begin 
		dim_quad_vaddress_select<=CASE_15;
		bvm_quad_vaddress_select<=CASE_33;
		next_state <=S122;				    
	  end

	S122:begin 
		dim_quad_vaddress_select<=CASE_16;
		bvm_quad_vaddress_select<=CASE_34;
		next_state <=S123;				    
	  end

	S123:begin 
		dim_quad_vaddress_select<=CASE_17;
		bvm_quad_vaddress_select<=CASE_35;
		next_state <=S124;				    
	  end

	S124:begin 
		dim_quad_vaddress_select<=CASE_18;
		bvm_quad_vaddress_select<=CASE_36;
		next_state <=S125;				    
	  end

	S125:begin 
		dim_quad_vaddress_select<=CASE_19;
		bvm_quad_vaddress_select<=CASE_37;
		next_state <=S126;				    
	  end

	S126:begin 
		dim_quad_vaddress_select<=CASE_20;
		bvm_quad_vaddress_select<=CASE_38;
		next_state <=S127;				    
	  end
//-------------------


	S127:begin 
		dim_quad_vaddress_select<=CASE_21;
		bvm_quad_vaddress_select<=CASE_30;
		next_state <=S128;				    
	  end

	S128:begin 
		dim_quad_vaddress_select<=CASE_22;
		bvm_quad_vaddress_select<=CASE_31;
		next_state <=S129;				    
	  end

	S129:begin 
		dim_quad_vaddress_select<=CASE_23;
		bvm_quad_vaddress_select<=CASE_32;
		next_state <=S130;				    
	  end

	S130:begin 
		dim_quad_vaddress_select<=CASE_24;
		bvm_quad_vaddress_select<=CASE_33;
		next_state <=S131;				    
	  end

	S131:begin 
		dim_quad_vaddress_select<=CASE_25;
		bvm_quad_vaddress_select<=CASE_34;
		next_state <=S132;				    
	  end

	S132:begin 
		dim_quad_vaddress_select<=CASE_26;
		bvm_quad_vaddress_select<=CASE_35;
		next_state <=S133;				    
	  end

	S133:begin 
		dim_quad_vaddress_select<=CASE_27;
		bvm_quad_vaddress_select<=CASE_36;
		next_state <=S134;				    
	  end

	S134:begin 
		dim_quad_vaddress_select<=CASE_28;
		bvm_quad_vaddress_select<=CASE_37;
		next_state <=S135;				    
	  end

	S135:begin 
		dim_quad_vaddress_select<=CASE_29;
		bvm_quad_vaddress_select<=CASE_38;
		next_state <=S136;				    
	  end
//------------


	S136:begin 
		dim_quad_vaddress_select<=CASE_30;
		bvm_quad_vaddress_select<=CASE_30;
		next_state <=S137;				    
	  end

	S137:begin 
		dim_quad_vaddress_select<=CASE_31;
		bvm_quad_vaddress_select<=CASE_31;
		next_state <=S138;				    
	  end

	S138:begin 
		dim_quad_vaddress_select<=CASE_32;
		bvm_quad_vaddress_select<=CASE_32;
		next_state <=S139;				    
	  end

	S139:begin 
		dim_quad_vaddress_select<=CASE_33;
		bvm_quad_vaddress_select<=CASE_33;
		next_state <=S140;				    
	  end

	S140:begin 
		dim_quad_vaddress_select<=CASE_34;
		bvm_quad_vaddress_select<=CASE_34;
		next_state <=S141;				    
	  end

	S141:begin 
		dim_quad_vaddress_select<=CASE_35;
		bvm_quad_vaddress_select<=CASE_35;
		next_state <=S142;				    
	  end

	S142:begin 
		dim_quad_vaddress_select<=CASE_36;
		bvm_quad_vaddress_select<=CASE_36;
		next_state <=S143;				    
	  end

	S143:begin 
		dim_quad_vaddress_select<=CASE_37;
		bvm_quad_vaddress_select<=CASE_37;
		next_state <=S144;				    
	  end

	S144:begin 
		dim_quad_vaddress_select<=CASE_38;
		bvm_quad_vaddress_select<=CASE_38;
		next_state <=S145;
		end

	S145:begin 
		dim_quad_vaddress_select<=CASE_40;
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S146;					    
	  end

	S146:begin 
		dim_quad_vaddress_select<=CASE_40;
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S147;					    
	  end

	S147:begin 
		dim_quad_vaddress_select<=CASE_40;
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S148;
	     end

	S148:begin 
		dim_quad_vaddress_select<=CASE_40;
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S149;					    
	  end

	S149:begin //------------------write to reg gets over
		dim_quad_vaddress_select<=CASE_40;
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S150;					    
	  end

	S150:begin 
		dim_quad_vaddress_select<=CASE_41;  //need to change only the dim to write.
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S151;					    
	  end

	S151:begin 
		dim_quad_vaddress_select<=CASE_42;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S152;					    
	  end
	S152:begin 
		dim_quad_vaddress_select<=CASE_43; 
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S153;					    
	  end
	S153:begin 
		dim_quad_vaddress_select<=CASE_44;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S154;					    
	  end
	S154:begin 
		dim_quad_vaddress_select<=CASE_45;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S155;					    
	  end
	S155:begin 
		dim_quad_vaddress_select<=CASE_46;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S156;					    
	  end
	S156:begin 
		dim_quad_vaddress_select<=CASE_47;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S157;					    
	  end
	S157:begin 
		dim_quad_vaddress_select<=CASE_48;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S158;					    
	  end
	S158:begin 
		dim_quad_vaddress_select<=CASE_49;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S159;					    
	  end
	S159:begin 
		dim_quad_vaddress_select<=CASE_50;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S160;					    
	  end
	S160:begin 
		dim_quad_vaddress_select<=CASE_51;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S161;					    
	  end
	S161:begin 
		dim_quad_vaddress_select<=CASE_52;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S162;					    
	  end

	S162:begin 
		dim_quad_vaddress_select<=CASE_53;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S163;					    
	  end

	S163:begin 
		dim_quad_vaddress_select<=CASE_54;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S164;					    
	  end

	S164:begin 
		dim_quad_vaddress_select<=CASE_55;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S165;					    
	  end
	S165:begin 
		dim_quad_vaddress_select<=CASE_56;  
		bvm_quad_vaddress_select<=CASE_40;
		next_state <=S166;					    
	  end

	S166:begin 
		dim_quad_vaddress_select<=CASE_40;  
		bvm_quad_vaddress_select<=CASE_40;
		done<=1'b1;
		next_state <=S166;					    
	  end


//---------------------


endcase
end
end
/***********reiterate logic**************/
always@(posedge clk or posedge reset)
begin
if(reset) begin	
	mac2scompsel<=0;
	quadone_sel<=0;
end
else if (reiterate)
begin
	mac2scompsel<=0;
	quadone_sel<=0;
end
else if(start && ~done) begin
	quadone_sel<=1;
	mac2scompsel<=1;
end
else if(done)
	quadone_sel<=0;	
end




//read data input memory
always@(posedge clk or posedge reset)             
begin
	if(reset)begin
		 qone__cdut__dim__write <= 1'b0;
		 qone__cdut__dim__data <= 16'hxxxx;
		 qone__cdut__dim__address <=9'bxxx;
		 A_data_reg <= 16'h0;
	end

       else if (reiterate)
      begin
		 qone__cdut__dim__write <= 1'b0;
		 qone__cdut__dim__data <= 16'hxxxx;
		 qone__cdut__dim__address <=9'bxxx;
		 A_data_reg <= 16'h0;
      end				  

  else if (sram_enabled && start) begin
     
	if (dim_NewAddressReady)begin
	      
		if(quad_dim_muxsel2reg == OUT_INST0_B0_0) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B0_0; end

   		else if  (quad_dim_muxsel2reg == OUT_INST0_B0_1) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B0_1; end

  		 else if  (quad_dim_muxsel2reg == OUT_INST0_B0_2) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B0_2; end

  		 else if  (quad_dim_muxsel2reg == OUT_INST0_B0_3) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B0_3; end

  		 else if  (quad_dim_muxsel2reg == OUT_INST0_B1_0) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B1_0; end

   		else if  (quad_dim_muxsel2reg == OUT_INST0_B1_1) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B1_1; end

   		else if  (quad_dim_muxsel2reg == OUT_INST0_B1_2) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B1_2; end

  		 else if  (quad_dim_muxsel2reg == OUT_INST0_B1_3) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B1_3; end

  		 else if  (quad_dim_muxsel2reg == OUT_INST0_B2_0) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B2_0; end

  		 else if  (quad_dim_muxsel2reg == OUT_INST0_B2_1) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B2_1; end
  		 else if  (quad_dim_muxsel2reg == OUT_INST0_B2_2) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B2_2; end
   		else if  (quad_dim_muxsel2reg == OUT_INST0_B2_3) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B2_3; end
   		else if  (quad_dim_muxsel2reg == OUT_INST0_B3_0) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B3_0; end
  		 else if  (quad_dim_muxsel2reg == OUT_INST0_B3_1) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B3_1; end
   		else if  (quad_dim_muxsel2reg == OUT_INST0_B3_2) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B3_2; end
   		else if  (quad_dim_muxsel2reg == OUT_INST0_B3_3) begin qone__cdut__dim__address <=quad_dim_muxsel2reg;
							qone__cdut__dim__write <= 1'b1;
							qone__cdut__dim__data <= Inst0_B3_3; end		  
		else begin      qone__cdut__dim__address <=quad_dim_muxsel2reg;
			        qone__cdut__dim__write <= 1'b0; end
						
	end
	else begin qone__cdut__dim__address <=9'bxxx;  qone__cdut__dim__write <= 1'b0;end		
	


	if (dim_NewDataReady)begin A_data_reg <= dim__cdut__quadone__data; end		
	else begin A_data_reg <=16'b0; end
end
end


//read filter vector memory
always@(posedge clk or posedge reset)             
begin
if(reset)begin
	 qone__cdut__bvm__address <=10'hxxx;
	 B_data_reg <= 16'h0; end

else if (reiterate)
begin
	 qone__cdut__bvm__address <=10'hxxx;
	 B_data_reg <= 16'h0;
end

else if (sram_enabled && start) begin

	if (bvm_NewAddressReady)begin qone__cdut__bvm__address <=quad_bvm_muxsel2reg;end
	else begin qone__cdut__bvm__address <=10'hxxx; end		
	
	if (bvm_NewDataReady)begin B_data_reg <= bvm__cdut__quadone__data; end		
	else begin B_data_reg <=16'h0; end
end
end





//select addresses input data memory
always@(dim_quad_vaddress_select)
begin
quad_dim_muxsel2reg=A_SUBQUAD_0_0;
dim_NewAddressReady=1'b0;
dim_NewDataReady=1'b0; 
 
if(sram_enabled && start) begin 
case (dim_quad_vaddress_select)
	   CASE_0: begin	
			quad_dim_muxsel2reg=A_SUBQUAD_0_0; //for 3 cycles after 0 only value is stored in reg
			dim_NewAddressReady=1'b1;
			dim_NewDataReady=1'b0; end
	   CASE_1: begin
			quad_dim_muxsel2reg=A_SUBQUAD_0_1;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b0; end
	   CASE_2: begin
			quad_dim_muxsel2reg=A_SUBQUAD_0_2;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b0; end

//---------------------------next cycle---------------------------

	    CASE_3: begin	
			quad_dim_muxsel2reg=A_SUBQUAD_0_0; //for 3 cycles after 0 only value is stored in reg
			dim_NewAddressReady=1'b1;
			dim_NewDataReady=1'b1; end
	    CASE_4: begin
			quad_dim_muxsel2reg=A_SUBQUAD_0_1;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_5: begin
			quad_dim_muxsel2reg=A_SUBQUAD_0_2;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_6: begin
			quad_dim_muxsel2reg=A_SUBQUAD_0_3;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_7: begin
			quad_dim_muxsel2reg=A_SUBQUAD_0_4;  //start acc but acc=0
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_8: begin
			quad_dim_muxsel2reg=A_SUBQUAD_0_5;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_9: begin
			quad_dim_muxsel2reg=A_SUBQUAD_0_6;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_10: begin
			quad_dim_muxsel2reg=A_SUBQUAD_0_7;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_11: begin
			quad_dim_muxsel2reg=A_SUBQUAD_0_8;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
//--------------------------q1-----------------------

	    CASE_12: begin
			quad_dim_muxsel2reg=A_SUBQUAD_1_0;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_13: begin
			quad_dim_muxsel2reg=A_SUBQUAD_1_1;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_14: begin
			quad_dim_muxsel2reg=A_SUBQUAD_1_2;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_15: begin
			quad_dim_muxsel2reg=A_SUBQUAD_1_3;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_16: begin
			quad_dim_muxsel2reg=A_SUBQUAD_1_4;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_17: begin
			quad_dim_muxsel2reg=A_SUBQUAD_1_5;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_18: begin
			quad_dim_muxsel2reg=A_SUBQUAD_1_6;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_19: begin
			quad_dim_muxsel2reg=A_SUBQUAD_1_7;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_20: begin
			quad_dim_muxsel2reg=A_SUBQUAD_1_8;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
//--------------------------q2-----------------------
	    CASE_21: begin
			quad_dim_muxsel2reg=A_SUBQUAD_2_0;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_22: begin
			quad_dim_muxsel2reg=A_SUBQUAD_2_1;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_23: begin
			quad_dim_muxsel2reg=A_SUBQUAD_2_2;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_24: begin
			quad_dim_muxsel2reg=A_SUBQUAD_2_3;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_25: begin
			quad_dim_muxsel2reg=A_SUBQUAD_2_4;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_26: begin
			quad_dim_muxsel2reg=A_SUBQUAD_2_5;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_27: begin
			quad_dim_muxsel2reg=A_SUBQUAD_2_6;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_28: begin
			quad_dim_muxsel2reg=A_SUBQUAD_2_7;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	   CASE_29: begin
			quad_dim_muxsel2reg=A_SUBQUAD_2_8;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
//--------------------------q3-----------------------
	    CASE_30: begin
			quad_dim_muxsel2reg=A_SUBQUAD_3_0;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_31: begin
			quad_dim_muxsel2reg=A_SUBQUAD_3_1;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end

	    CASE_32: begin
			quad_dim_muxsel2reg=A_SUBQUAD_3_2;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	   CASE_33: begin
			quad_dim_muxsel2reg=A_SUBQUAD_3_3;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_34: begin
			quad_dim_muxsel2reg=A_SUBQUAD_3_4;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_35: begin
			quad_dim_muxsel2reg=A_SUBQUAD_3_5;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_36: begin
			quad_dim_muxsel2reg=A_SUBQUAD_3_6;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_37: begin
			quad_dim_muxsel2reg=A_SUBQUAD_3_7;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	    CASE_38: begin
			quad_dim_muxsel2reg=A_SUBQUAD_3_8;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	   CASE_39: begin
			quad_dim_muxsel2reg=A_SUBQUAD_Z_Z;
			dim_NewAddressReady=1'b0;
			dim_NewDataReady= 1'b0; end
	   CASE_40: begin
			quad_dim_muxsel2reg=A_SUBQUAD_Z_Z;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	   CASE_41: begin
			quad_dim_muxsel2reg=OUT_INST0_B0_0; //starts write to dom
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	   CASE_42: begin
			quad_dim_muxsel2reg=OUT_INST0_B0_1; 
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
 
	   CASE_43: begin
			quad_dim_muxsel2reg=OUT_INST0_B0_2; 
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
			 
	   CASE_44: begin
			quad_dim_muxsel2reg=OUT_INST0_B0_3; 
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
		 
	   CASE_45: begin
			quad_dim_muxsel2reg=OUT_INST0_B1_0; 
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
		
	   CASE_46: begin
			
			quad_dim_muxsel2reg=OUT_INST0_B1_1; 
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
		 
	   CASE_47: begin
			
			quad_dim_muxsel2reg=OUT_INST0_B1_2; 
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
			 
	   CASE_48: begin
			
			quad_dim_muxsel2reg=OUT_INST0_B1_3; 
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	 
   	   CASE_49: begin
			
			quad_dim_muxsel2reg=OUT_INST0_B2_0; 
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
		 
	   CASE_50: begin
			
			quad_dim_muxsel2reg=OUT_INST0_B2_1;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
		 
	   CASE_51: begin
			quad_dim_muxsel2reg=OUT_INST0_B2_2; 
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
		 
	   CASE_52: begin
			quad_dim_muxsel2reg=OUT_INST0_B2_3;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	   CASE_53: begin
 			quad_dim_muxsel2reg=OUT_INST0_B3_0;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	   CASE_54: begin
	 		quad_dim_muxsel2reg=OUT_INST0_B3_1;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
	   CASE_55: begin
			quad_dim_muxsel2reg=OUT_INST0_B3_2;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end
			 
	   CASE_56: begin 
			quad_dim_muxsel2reg=OUT_INST0_B3_3;
			dim_NewAddressReady=1'b1;
			dim_NewDataReady= 1'b1; end





endcase
end
end

//select addresses filter data memory
always@(bvm_quad_vaddress_select)
begin
quad_bvm_muxsel2reg=8'h00;
bvm_NewAddressReady=1'b0;
bvm_NewDataReady=1'b0;
 
if(sram_enabled && start) begin 
case (bvm_quad_vaddress_select)
	    CASE_0: begin	
			quad_bvm_muxsel2reg=B0_0;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady=1'b0; end
	    CASE_1: begin
			quad_bvm_muxsel2reg=B0_1;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b0; end
	    CASE_2: begin
			quad_bvm_muxsel2reg=B0_2;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b0; end

//-----------------------------next cycle---------
	    CASE_3: begin	
			quad_bvm_muxsel2reg=B0_0;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady=1'b1; end
	    CASE_4: begin
			quad_bvm_muxsel2reg=B0_1;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	   CASE_5: begin
			quad_bvm_muxsel2reg=B0_2;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	   CASE_6: begin
			quad_bvm_muxsel2reg=B0_3;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_7: begin
			quad_bvm_muxsel2reg=B0_4;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_8: begin
			quad_bvm_muxsel2reg=B0_5;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_9: begin
			quad_bvm_muxsel2reg=B0_6;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_10: begin
			quad_bvm_muxsel2reg=B0_7;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_11: begin
			quad_bvm_muxsel2reg=B0_8;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
//------------------------------B1-------------------------
	    CASE_12: begin
			quad_bvm_muxsel2reg=B1_0;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	   CASE_13: begin
			quad_bvm_muxsel2reg=B1_1;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_14: begin
			quad_bvm_muxsel2reg=B1_2;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_15: begin
			quad_bvm_muxsel2reg=B1_3;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_16: begin
			quad_bvm_muxsel2reg=B1_4;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_17: begin
			quad_bvm_muxsel2reg=B1_5;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_18: begin
			quad_bvm_muxsel2reg=B1_6;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end

	    CASE_19: begin
			quad_bvm_muxsel2reg=B1_7;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end

	    CASE_20: begin
			quad_bvm_muxsel2reg=B1_8;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
//-------------------------B2----------------------------

	    CASE_21: begin
			quad_bvm_muxsel2reg=B2_0;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_22: begin
			quad_bvm_muxsel2reg=B2_1;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_23: begin
			quad_bvm_muxsel2reg=B2_2;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_24: begin
			quad_bvm_muxsel2reg=B2_3;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_25: begin
			quad_bvm_muxsel2reg=B2_4;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_26: begin
			quad_bvm_muxsel2reg=B2_5;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_27: begin
			quad_bvm_muxsel2reg=B2_6;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end

	    CASE_28: begin
			quad_bvm_muxsel2reg=B2_7;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end

	    CASE_29: begin
			quad_bvm_muxsel2reg=B2_8;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
//------------------------B3--------------------------

	   CASE_30: begin
			quad_bvm_muxsel2reg=B3_0;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_31: begin
			quad_bvm_muxsel2reg=B3_1;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_32: begin
			quad_bvm_muxsel2reg=B3_2;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_33: begin
			quad_bvm_muxsel2reg=B3_3;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	   CASE_34: begin
			quad_bvm_muxsel2reg=B3_4;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_35: begin
			quad_bvm_muxsel2reg=B3_5;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
	    CASE_36: begin
			quad_bvm_muxsel2reg=B3_6;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end

	   CASE_37: begin
			quad_bvm_muxsel2reg=B3_7;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end

	    CASE_38: begin
			quad_bvm_muxsel2reg=B3_8;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end
//-------------------------Buffer at the end---------------

	    CASE_39: begin
			quad_bvm_muxsel2reg=A_SUBQUAD_Z_Z;
			bvm_NewAddressReady=1'b0;
			bvm_NewDataReady= 1'b0; end

	    CASE_40: begin
			quad_bvm_muxsel2reg=A_SUBQUAD_Z_Z;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end

	    CASE_41: begin
			quad_bvm_muxsel2reg=A_SUBQUAD_Z_Z;
			bvm_NewAddressReady=1'b1;
			bvm_NewDataReady= 1'b1; end

endcase
end
end


reg signed [31:0] accum;

always@(posedge clk or posedge reset)
begin
if(reset) begin
accum<=32'b0; end

else if (reiterate)
begin
accum<=32'b0; 
end

else if(dim_quad_vaddress_select==9'h6 || dim_quad_vaddress_select== 9'h15 || dim_quad_vaddress_select== 9'h24 || dim_quad_vaddress_select== 9'h33 ) begin accum<=32'b0; end
else begin accum <=MAC_inst; end
end

//multiplier accumulator instance
 DW02_mac #(16, 16)
U1 ( .A(A_data_reg), .B(B_data_reg), .C(accum), .TC(mac2scompsel), .MAC(MAC_inst) );

always@(posedge clk or posedge reset)
begin

if(reset) Z_data<=0;
else if (reiterate)
begin
Z_data<=0;
end
else  Z_data<= (MAC_inst[31]?0:MAC_inst[31:16]); end

endmodule
/**********************************************top module*****************************/
module MyDesign (

            //---------------------------------------------------------------------------
            // Control
            //
            output reg                  dut__xxx__finish   ,
            input  wire                 xxx__dut__go       ,  

            //---------------------------------------------------------------------------
            // b-vector memory 
            //
            output reg  [ 9:0]          dut__bvm__address  ,
            output reg                  dut__bvm__enable   ,
            output reg                  dut__bvm__write    ,
            output reg  [15:0]          dut__bvm__data     ,  // write data
            input  wire [15:0]          bvm__dut__data     ,  // read data
            
            //---------------------------------------------------------------------------
            // Input data memory 
            //
            output reg  [ 8:0]          dut__dim__address  ,
            output reg                  dut__dim__enable   ,
            output reg                  dut__dim__write    ,
            output reg  [15:0]          dut__dim__data     ,  // write data
            input  wire [15:0]          dim__dut__data     ,  // read data


            //---------------------------------------------------------------------------
            // Output data memory 
            //
            output reg  [ 2:0]          dut__dom__address  ,
            output reg  [15:0]          dut__dom__data     ,  // write data
            output reg                  dut__dom__enable   ,
            output reg                  dut__dom__write    ,


            //-------------------------------
            // General
            //
            input  wire                 clk             ,
            input  wire                 reset  

            );




Controller C1(		.clk(clk),
			.reset(reset), 
			.xxx__cdut__go(xxx__dut__go), 
			.cdut__xxx__finish(dut__xxx__finish),  
			.cdut__dim__enable(dut__dim__enable),

			.cdut__dim__write(dut__dim__write),
			.cdut__dim__address(dut__dim__address),
			.cdut__dim__data(dut__dim__data) ,  // an output to sram
			.dim__cdut__data(dim__dut__data), //an input to instances.
			
			.cdut__bvm__enable(dut__bvm__enable),  
			.cdut__bvm__write(dut__bvm__write),
			.cdut__bvm__address(dut__bvm__address) , 
			.cdut__bvm__data(dut__bvm__data) ,  // an output to sram
			.bvm__cdut__data(bvm__dut__data), //an input to instances.
			
			.cdut__dom__enable(dut__dom__enable) ,
			.cdut__dom__write(dut__dom__write) ,
			.cdut__dom__address(dut__dom__address) ,
			.cdut__dom__data(dut__dom__data));	
		
		
			

endmodule

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

module Controller (	 
		  	 input wire 		clk		    ,
			 input wire 		reset		    , 
			 input wire 		xxx__cdut__go       ,
			 output reg 		cdut__xxx__finish   ,

			 output reg		cdut__dim__enable   ,
			 output reg             cdut__dim__write    ,
    			 output reg  [ 8:0]     cdut__dim__address  ,
             		 output reg  [15:0]     cdut__dim__data     ,  // write data
             		 input  wire [15:0]      dim__cdut__data     ,  //read data from dim 

//---------------------------bvm related------------------
			 output reg		cdut__bvm__enable   ,
			 output reg             cdut__bvm__write    ,
            		 output reg  [ 9:0]     cdut__bvm__address  ,
            		 output reg  [15:0]     cdut__bvm__data     ,  // write data
            		 input  wire [15:0]     bvm__cdut__data     ,  // read data

//---------------------------output data mem related------

			 output reg		cdut__dom__enable   ,
			 output reg             cdut__dom__write    ,
            		 output reg  [ 2:0]     cdut__dom__address  ,
             		 output reg  [15:0]     cdut__dom__data       // write data
			 );

reg              reiterate;
wire [4:0]	 Inst_selector;
reg 	    	Inst0_sel,Inst1_sel,Inst2_sel,Inst3_sel,Inst4_sel;
reg             sram_enabled,start_quad_1_operate;

wire            Inst0__cdut__dim__write;
wire   [9:0]	Inst0__cdut__bvm__address;
wire   [8:0]	Inst0__cdut__dim__address;
reg    [15:0]   Inst0__cdut__dim__data;

reg  [15:0]     dim__cdut__Inst0__data;  //connect to Inst0
reg  [15:0]     bvm__cdut__Inst0__data;  //output to Inst0 module

//*****************quadrant two************

wire            Inst1__cdut__dim__write;
wire   [9:0]	Inst1__cdut__bvm__address;
wire   [8:0]	Inst1__cdut__dim__address;
reg    [15:0]   Inst1__cdut__dim__data;

reg  [15:0]     dim__cdut__Inst1__data;  //connect to Inst1
reg  [15:0]     bvm__cdut__Inst1__data;  //output to Inst1 module

//******************quadrant three********

wire            Inst2__cdut__dim__write;
wire   [9:0]	Inst2__cdut__bvm__address;
wire   [8:0]	Inst2__cdut__dim__address;
reg    [15:0]   Inst2__cdut__dim__data;

reg  [15:0]     dim__cdut__Inst2__data;  //connect to Inst2
reg  [15:0]     bvm__cdut__Inst2__data;  //output to Inst2 module

//******************quadrant four********

wire            Inst3__cdut__dim__write;
wire   [9:0]	Inst3__cdut__bvm__address;
wire   [8:0]	Inst3__cdut__dim__address;
reg    [15:0]   Inst3__cdut__dim__data;

reg  [15:0]     dim__cdut__Inst3__data;  //connect to Inst3
reg  [15:0]     bvm__cdut__Inst3__data;  //output to Inst3 module

//******************step2****************

wire   [9:0]	Inst4__cdut__bvm__address;
wire   [8:0]	Inst4__cdut__dim__address;
wire   [2:0]	Inst4__cdut__dom__address;
reg    [15:0]   Inst4__cdut__dom__data;
wire            Inst4__cdut__dom__write;  

reg  [15:0]     dim__cdut__Inst4__data;  //connect to Inst4
reg  [15:0]     bvm__cdut__Inst4__data;  //output to Inst4 module

QuadOperator #(8'h00, 8'h01, 8'h02, 8'h10,8'h11, 8'h12, 8'h20, 8'h21,8'h22, 8'h03, 8'h04, 8'h05,8'h13, 8'h14,8'h15,8'h23, 8'h24, 8'h25,8'h30,
 8'h31, 8'h32,8'h40,8'h41, 8'h42, 8'h50, 8'h51, 8'h52, 8'h33, 8'h34, 8'h35,8'h43,8'h44, 8'h45, 8'h53,8'h54, 8'h55, 8'h00,9'h100, 9'h101,9'h104,9'h105, 9'h110, 9'h111,9'h114,9'h115,9'h120, 9'h121, 9'h124,9'h125,9'h130,9'h131, 9'h134, 9'h135)
			 Q1(  .clk(clk),
			   .reset(reset),
			 .start(start_quad_1_operate),
			 .sram_enabled(sram_enabled), 
			 .quadone_sel(Inst0_sel),
			 .done(start_quad_2_operate),
			 .reiterate(reiterate),
						   
			 .qone__cdut__bvm__address(Inst0__cdut__bvm__address), 
			 .bvm__cdut__quadone__data(bvm__cdut__Inst0__data), 


		           .qone__cdut__dim__address(Inst0__cdut__dim__address), 
                           .qone__cdut__dim__write(Inst0__cdut__dim__write),
                           .qone__cdut__dim__data(Inst0__cdut__dim__data), 
                           .dim__cdut__quadone__data(dim__cdut__Inst0__data)
);


QuadOperator 

#(8'h06, 8'h07,8'h08,8'h16, 8'h17,8'h18,8'h26, 8'h27,8'h28,8'h09,8'h0A, 8'h0B, 8'h19, 8'h1A,8'h1B, 8'h29, 8'h2A, 8'h2B,
 8'h36, 8'h37,8'h38,8'h46, 8'h47, 8'h48,8'h56, 8'h57, 8'h58, 8'h39, 8'h3A, 8'h3B, 8'h49, 8'h4A, 8'h4B,8'h59, 8'h5A, 8'h5B, 8'h00,9'h102, 9'h103,
 9'h106, 9'h107, 9'h112, 9'h113, 9'h116, 9'h117, 9'h122, 9'h123, 9'h126, 9'h127, 9'h132, 9'h133, 9'h136, 9'h137)
			Q2 (  .clk(clk),
			 .reset(reset),
			 .start(start_quad_2_operate),
			 .sram_enabled(sram_enabled), 
			 .quadone_sel(Inst1_sel),
			 .done(start_quad_3_operate),
			 .reiterate(reiterate),
						   
			 .qone__cdut__bvm__address(Inst1__cdut__bvm__address), 
			 .bvm__cdut__quadone__data(bvm__cdut__Inst1__data), 


		           .qone__cdut__dim__address(Inst1__cdut__dim__address), 
                           .qone__cdut__dim__write(Inst1__cdut__dim__write),
                           .qone__cdut__dim__data(Inst1__cdut__dim__data), 
                           .dim__cdut__quadone__data(dim__cdut__Inst1__data)
);



QuadOperator #(8'h60, 8'h61, 8'h62, 8'h70, 8'h71, 8'h72, 8'h80, 8'h81, 8'h82, 8'h63, 8'h64, 8'h65, 8'h73, 8'h74, 8'h75, 8'h83, 8'h84, 8'h85,  8'h90,
8'h91, 8'h92, 8'hA0, 8'hA1, 8'hA2, 8'hB0, 8'hB1, 8'hB2, 8'h93, 8'h94, 8'h95,8'hA3, 8'hA4, 8'hA5,8'hB3,8'hB4, 8'hB5,8'h00 ,9'h108, 9'h109, 9'h10C,9'h10D, 9'h118, 9'h119, 9'h11C, 9'h11D, 9'h128, 9'h129,9'h12C, 9'h12D, 9'h138, 9'h139,9'h13C, 9'h13D)
			 Q3( .clk(clk),
			 .reset(reset),
			 .start(start_quad_3_operate),
			 .sram_enabled(sram_enabled), 
			 .quadone_sel(Inst2_sel),
			 .done(start_quad_4_operate),
			 .reiterate(reiterate),
						   
			 .qone__cdut__bvm__address(Inst2__cdut__bvm__address), 
			 .bvm__cdut__quadone__data(bvm__cdut__Inst2__data), 


		           .qone__cdut__dim__address(Inst2__cdut__dim__address), 
                           .qone__cdut__dim__write(Inst2__cdut__dim__write),
                           .qone__cdut__dim__data(Inst2__cdut__dim__data), 
                           .dim__cdut__quadone__data(dim__cdut__Inst2__data)
);



QuadOperator #( 8'h66,8'h67, 8'h68,8'h76,8'h77,8'h78,8'h86, 8'h87,8'h88, 8'h69, 8'h6A,8'h6B, 8'h79, 8'h7A, 8'h7B, 8'h89, 8'h8A, 8'h8B,8'h96, 8'h97,8'h98, 8'hA6, 8'hA7,8'hA8,8'hB6, 8'hB7,8'hB8, 8'h99, 8'h9A, 8'h9B,8'hA9, 8'hAA, 8'hAB, 8'hB9, 8'hBA,8'hBB,8'h00,9'h10A, 9'h10B,9'h10E,9'h10F, 9'h11A,9'h11B,
 9'h11E, 9'h11F,9'h12A,9'h12B,9'h12E, 9'h12F, 9'h13A, 9'h13B, 9'h13E, 9'h13F)

			Q4( .clk(clk),
			 .reset(reset),
			 .start(start_quad_4_operate),
			 .sram_enabled(sram_enabled), 
			 .quadone_sel(Inst3_sel),
			 .done(start_quad_5_operate),
			 .reiterate(reiterate),
						   
			 .qone__cdut__bvm__address(Inst3__cdut__bvm__address), 
			 .bvm__cdut__quadone__data(bvm__cdut__Inst3__data), 


		           .qone__cdut__dim__address(Inst3__cdut__dim__address), 
                           .qone__cdut__dim__write(Inst3__cdut__dim__write),
                           .qone__cdut__dim__data(Inst3__cdut__dim__data), 
                           .dim__cdut__quadone__data(dim__cdut__Inst3__data)
);

steptwo Q5( .clk(clk),
			 .reset(reset),
			 .start(start_quad_5_operate),
			 .sram_enabled(sram_enabled), 
			 .steptwo_sel(Inst4_sel),
			 .done(start_quad_6_operate),
			 .reiterate(reiterate),
						   
			 .qone__cdut__bvm__address(Inst4__cdut__bvm__address), 

			 .bvm__cdut__quadone__data(bvm__cdut__Inst4__data), 


		           .qone__cdut__dim__address(Inst4__cdut__dim__address), 
                           .dim__cdut__quadone__data(dim__cdut__Inst4__data),
                           .qone__cdut__dom__address(Inst4__cdut__dom__address), 
                           .qone__cdut__dom__data(Inst4__cdut__dom__data),  
                           .qone__cdut__dom__write(Inst4__cdut__dom__write));


assign  Inst_selector = {Inst0_sel,Inst1_sel,Inst2_sel,Inst3_sel,Inst4_sel};

/*Input data memory read enable */ /*b-vector memory  read enable*/
always@(posedge clk or posedge reset)
	begin
	    if(reset) begin 			   //first reset
			cdut__xxx__finish<=1'b1;
			cdut__dim__enable<=0;
			cdut__bvm__enable<=0;
			cdut__dom__enable<=0;
			sram_enabled<=0;
			reiterate<=0;
			 end
	    else if(!start_quad_6_operate && xxx__cdut__go ) begin  //go after first reset	
			cdut__xxx__finish<=1'b0;
	    		cdut__dim__enable<=1;
			cdut__bvm__enable<=1; 
			cdut__dom__enable<=1;
			sram_enabled<=1;
			start_quad_1_operate<=1;
			reiterate<=0; end

	   else if(start_quad_6_operate && !xxx__cdut__go && reiterate !=1) begin //cycle finished and no go
			cdut__xxx__finish<=1'b1;
			cdut__dim__enable<=0;
			cdut__bvm__enable<=0;
			cdut__dom__enable<=0;
			sram_enabled<=0;
			reiterate<=0; end

	   else if(xxx__cdut__go)  begin //cycle finished and got go
			cdut__xxx__finish<=1'b0;
	    		cdut__dim__enable<=1;
			cdut__bvm__enable<=1; 
			cdut__dom__enable<=1;					
			reiterate<=1; end

	else if (reiterate==1) begin reiterate<=0; sram_enabled<=1; start_quad_1_operate<=1; end		
			
		       
end


always@(posedge clk or posedge reset)  
     begin
	if(reset) begin
 			cdut__dim__address 	<= 9'b0;
		        cdut__dim__data		<= 16'b0;
			cdut__dim__write	<= 0;

			cdut__bvm__address	<= 10'b0;
		        cdut__bvm__data		<= 16'b0;
			cdut__bvm__write	<= 0;


			cdut__dom__address	<= 3'b0;
		        cdut__dom__data		<= 16'b0;
			cdut__dom__write	<= 0;
			dim__cdut__Inst0__data  <= 16'b0; 
			bvm__cdut__Inst0__data  <= 16'b0;
			dim__cdut__Inst1__data  <= 16'b0; 
			bvm__cdut__Inst1__data  <= 16'b0;
			dim__cdut__Inst2__data  <= 16'b0; 
			bvm__cdut__Inst2__data  <= 16'b0;
			dim__cdut__Inst3__data  <= 16'b0; 
			bvm__cdut__Inst3__data  <= 16'b0;
			dim__cdut__Inst4__data  <= 16'b0; 
			bvm__cdut__Inst4__data  <= 16'b0; 
end

   else begin //to dim address , //to dim data , // to dim write, //from dim data.
	
 	case (Inst_selector)
	    5'b10000: begin
			cdut__dim__address 	<= Inst0__cdut__dim__address;
		        cdut__dim__data		<= Inst0__cdut__dim__data;
			cdut__dim__write	<= Inst0__cdut__dim__write;
			dim__cdut__Inst0__data	<= dim__cdut__data;
							end

	    5'b01000: begin cdut__dim__address	<= Inst1__cdut__dim__address;
			   cdut__dim__data	<= Inst1__cdut__dim__data;
			   cdut__dim__write	<= Inst1__cdut__dim__write;
			   dim__cdut__Inst1__data	<= dim__cdut__data;
							end

	    5'b00100: begin cdut__dim__address	<= Inst2__cdut__dim__address;
			cdut__dim__data		<= Inst2__cdut__dim__data;
			cdut__dim__write	<= Inst2__cdut__dim__write;
			dim__cdut__Inst2__data	<= dim__cdut__data;
							end

	    5'b00010: begin
			cdut__dim__address	<= Inst3__cdut__dim__address;	
			cdut__dim__data		<= Inst3__cdut__dim__data;
			cdut__dim__write	<= Inst3__cdut__dim__write;
			dim__cdut__Inst3__data	<= dim__cdut__data;
							 end


	    5'b00001: begin
			cdut__dim__address	<= Inst4__cdut__dim__address;	
			cdut__dim__data		<= 16'bxx;
			cdut__dim__write	<= 1'b0;
			dim__cdut__Inst4__data	<= dim__cdut__data;
							 end
		endcase
	
 
	//to bvm address , //to bvm data , // to bvm write, //from bvm data.
	case (Inst_selector)
 
	    5'b10000: begin cdut__bvm__address	<= Inst0__cdut__bvm__address;
		           cdut__bvm__data	<= 16'bxxxx;
			   cdut__bvm__write	<= 1'b0;
			   bvm__cdut__Inst0__data<= bvm__cdut__data;
							end

	    5'b01000: begin
			cdut__bvm__address	<= Inst1__cdut__bvm__address;
			cdut__bvm__data		<= 16'bxxxx;
			cdut__bvm__write	<= 1'b0;
			bvm__cdut__Inst1__data	<= bvm__cdut__data;
							end

	    5'b00100: begin
			cdut__bvm__address	<= Inst2__cdut__bvm__address;
			cdut__bvm__data		<= 16'bxxxx;
			cdut__bvm__write	<= 1'b0;
			bvm__cdut__Inst2__data	<= bvm__cdut__data;
							end

	    5'b00010: begin
			cdut__bvm__address	<= Inst3__cdut__bvm__address;	
			cdut__bvm__data		<= 16'bxxxx;
			cdut__bvm__write	<= 1'b0;
			bvm__cdut__Inst3__data	<= bvm__cdut__data;
			 end

	    5'b00001: begin
			cdut__bvm__address	<= Inst4__cdut__bvm__address;	
			cdut__bvm__data		<= 16'bxxxx;
			cdut__bvm__write	<= 1'b0;
			bvm__cdut__Inst4__data	<= bvm__cdut__data;
			 end



	endcase


	 //to dom address , //to dom data , // to dom write, //from dom data.
	case (Inst_selector)
 
	    5'b10000: begin cdut__dom__address	<= 3'hx;
		            cdut__dom__data	<= 16'bxxxx;
			    cdut__dom__write	<= 1'b0;
							end

	    5'b01000: begin cdut__dom__address	<= 3'hx;
			cdut__dom__data		<= 16'bxxxx;
			cdut__dom__write	<= 1'b0;
							end

	    5'b00100: begin cdut__dom__address	<= 3'hx;
			cdut__dom__data		<= 16'bxxxx;
			cdut__dom__write	<= 1'b0;
							end

	    5'b00010: begin cdut__dom__address	<= 3'hx;	
			cdut__dom__data		<= 16'bxxxx;
			cdut__dom__write	<= 1'b0;
							end

	    5'b00001: begin cdut__dom__address	<= Inst4__cdut__dom__address;	
			cdut__dom__data		<= Inst4__cdut__dom__data;
			cdut__dom__write	<= Inst4__cdut__dom__write;
							end
	endcase
						

end

end

endmodule



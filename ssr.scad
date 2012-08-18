mount_t = 3;
mount_gap = .75;
mount_lipinset = 1;


ssr_w=45.15;
ssr_l=60.27;
ssr_t=22.95;
ssr_lip_t=2.54;
ssr_lip_w=2.23;
ssr_slot_width=10;
ssr_slot_depth = 11.33;
ssr_slot_bottom_thickness=4.04;
ssr_hole_diam = 4.08;
ssr_hole_diam2 = 6.4;
ssr_indent_l = 30.06;
ssr_indent_w = 42.85;
ssr_indent_t = 0.96;
ssr_posthole_in = 3.2;
ssr_posthole_w = 11.08;
ssr_posthole_l = 14.03;
ssr_posthole_t = 8.55;


//this is set fo a #4 machine screw.
nutTrapWidth=1/4*25.4;
nutTrapHieight=3/32*25.4;

mount_h_d=5;
mount_head_clear = 4;
mount_dist=50;
mount_round=9;

wire_hole_w = mount_dist-2*(mount_head_clear+mount_h_d/2);
wire_hole_d = 15;
wire_hole_h1 = 12;
wire_hole_h2 = 8;

module ssr(){


	difference(){
		union(){
			//body
			color("gray")
			translate([0,0,ssr_t/2])
			cube([ssr_w,ssr_l,ssr_t], center=true);
			//bottom plate
			color("silver")
			translate([0,0,ssr_lip_t/2])
			cube([ssr_w,ssr_l+2*ssr_lip_w,ssr_lip_t], center=true);
		}

		for (y=[-1,1]){
			//screw slot
			translate([0,y*(ssr_l/2-ssr_slot_depth+ssr_slot_width/2),ssr_t/2+ssr_slot_bottom_thickness])
			cylinder(r=ssr_slot_width/2, h=ssr_t, center=true);
		
			translate([0,y*(ssr_l/2),ssr_t/2+ssr_slot_bottom_thickness])
			cube([ssr_slot_width, 2*(ssr_slot_depth-ssr_slot_width/2), ssr_t], center=true);

			//screw hole
			translate([0,y*(ssr_l/2-ssr_slot_depth+ssr_slot_width/2),0])
			cylinder(r=ssr_hole_diam/2, h=ssr_t*3, center=true);
		}

		//label and light indent
		translate([0,0,ssr_t])
		cube([ssr_indent_w,ssr_indent_l,ssr_indent_t*2], center=true);

		//binding post holes
		for (x=[-1,1])
		for (y=[-1,1])
			translate([x*(ssr_w/2-ssr_posthole_w/2-ssr_posthole_in),y*ssr_l/2,ssr_t])
			cube([ssr_posthole_w,ssr_posthole_l*2,ssr_posthole_t*2], center=true);
	}
}



module nut(w, h){
	translate([0,0,h/2])
	for (i=[1:3])
		rotate([0,0,60*i])
		cube([w, w/sqrt(3), h], center=true);
}

module mount_plate(){

	difference(){
		union(){
			//smaller rectangle
			translate([0,0,(mount_t+mount_lipinset)/2])
			cube([ssr_w+2*(mount_gap),ssr_l+2*ssr_lip_w+2*(mount_gap),mount_t+mount_lipinset], center=true);

			//big rectangle
			translate([0,0,mount_t/2])
			cube([ssr_w+2*(mount_t+mount_gap),ssr_l+2*ssr_lip_w+2*(mount_t+mount_gap),mount_t], center=true);

			//mounting tabs
			for (y=[-1,1]){
				translate([0,y*(ssr_l/2+ssr_lip_w+mount_gap+mount_h_d/2+mount_t+mount_head_clear),mount_t/2])
				cube([mount_dist,2*mount_round,mount_t], center=true);
				for (x=[-mount_dist/2,mount_dist/2])
					translate([x,y*(ssr_l/2+ssr_lip_w+mount_gap+mount_h_d/2+mount_t+mount_head_clear),0])
					cylinder(r=mount_round, h=mount_t);
			}
		}
	
		//ssr screw hole
		for (y=[-1,1]){
			translate([0,y*(ssr_l/2-ssr_slot_depth+ssr_slot_width/2),0]){
				cylinder(r=ssr_hole_diam/2, h=(mount_t+mount_lipinset)*3, center=true);
				//nut trap
				translate([0,0,-1])
				nut(nutTrapWidth, nutTrapHieight+1);
			}

		//mount screw hole
		for (y=[-1,1])
		for (x=[-mount_dist/2,mount_dist/2])
			translate([x,y*(ssr_l/2+ssr_lip_w+mount_gap+mount_h_d/2+mount_t+mount_head_clear),0])
			cylinder(r=mount_h_d/2, h=mount_t*3, center=true);


		}

	}
}


module mount_cover(){
	difference(){
		union(){
			//big rectangle
			translate([0,0,(mount_lipinset+ssr_t+mount_gap+mount_t)/2])
			cube([ssr_w+2*(mount_t+mount_gap),ssr_l+2*ssr_lip_w+2*(mount_t+mount_gap),mount_lipinset+ssr_t+mount_gap+mount_t], center=true);

			//wire covers
			translate([0,0,(wire_hole_h1+wire_hole_h2+mount_t)/2])
			cube([wire_hole_w+2*mount_t, ssr_l+2*wire_hole_d+2*mount_t, wire_hole_h1+wire_hole_h2+mount_t], center=true);

			//mounting tabs
			for (y=[-1,1]){
				translate([0,y*(ssr_l/2+ssr_lip_w+mount_gap+mount_h_d/2+mount_t+mount_head_clear),mount_t/2])
				cube([mount_dist,2*mount_round,mount_t], center=true);
				for (x=[-mount_dist/2,mount_dist/2])
					translate([x,y*(ssr_l/2+ssr_lip_w+mount_gap+mount_h_d/2+mount_t+mount_head_clear),0])
					cylinder(r=mount_round, h=mount_t);
			}

		}
		//smaller rectangle
		translate([0,0,(mount_lipinset+ssr_t+mount_gap)/2-1])
		cube([ssr_w+2*(mount_gap),ssr_l+2*ssr_lip_w+2*(mount_gap),mount_lipinset+ssr_t+mount_gap+2], center=true);

		//label hole
		translate([0,0,mount_lipinset+ssr_t+mount_gap+mount_t])
		cube([ssr_indent_w,ssr_indent_l,mount_t*3], center=true);

		//binding post holes
		translate([0,0,(wire_hole_h1+wire_hole_h2)/2-1])
		cube([wire_hole_w, ssr_l+2*wire_hole_d, wire_hole_h1+wire_hole_h2+2], center=true);
		translate([0,0,wire_hole_h1/2-1])
		cube([wire_hole_w, ssr_l+2*wire_hole_d+ 2*mount_round+1, wire_hole_h1+2], center=true);


		//mount screw hole
		for (y=[-1,1])
		for (x=[-mount_dist/2,mount_dist/2])
			translate([x,y*(ssr_l/2+ssr_lip_w+mount_gap+mount_h_d/2+mount_t+mount_head_clear),0])
			cylinder(r=mount_h_d/2, h=mount_t*3, center=true);

	}
}

module display_ssr(){

ssr();

	color("orange")
	translate([0,0,-mount_t-mount_lipinset])
	mount_plate();

	color("orange")
	translate([0,0,-mount_lipinset])
	mount_cover();

}

module print(){
	mount_plate();
	translate([mount_dist + 2* mount_round+2,0,0])
	mount_cover();
}

//display_ssr();
print();


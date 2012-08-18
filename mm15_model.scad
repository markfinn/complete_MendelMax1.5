use<z_endstop.scad>
use<y_endstop.scad>
use<ssr.scad>
use<motor_eMinebea_PG35L-048-USC0.scad>
use<bracket_HBLFSN5.scad>
	
module extrusion(l=200){
w=6; //width of the channel at the bottom.  not spec'ed in drawings from misumi, but I'm assuming it's the same as the opening width. looks about right.
r=1; //corner round radius

	color("silver")
	difference(){
		cube([20,20,l], center=true);

		for (r=[0:90:270])
			rotate([0,0,r])
			translate([0,20/2])
			linear_extrude(height = l+1, center = true, convexity = 10)
			polygon([[-3,1],[-3,-2], [-6, -2], [-6, -w/2], [-w/2, -6], [w/2, -6], [6, -w/2], [6, -2], [3, -2], [3, 1]], convexity = 10);

		cylinder(r=4.2/2, h=l+1, $fn=12, center=true);

		for (ro=[0:90:270])
			rotate([0,0,ro])
			translate([20/2-r,20/2-r, -(l+2)/2])
			difference(){
				cube([100,100,l+2]);

				cylinder(r=r, h=l+2, $fn=12);
			}
	}
}

module slideprofile(l=420, topcut=1){
	translate([0,0,14/2])
	difference(){
		cube([52,l,14], center=true);

		if(topcut)
			translate([0,0,8])
			cube([27,l+1,8*2], center=true);

		for (m=[[0,0,0], [1,0,0]])
		mirror(m)
		translate([37.1/2,-(l+1)/2,-1000-14/2+5.9])
		cube([1000,l+1,1000]);
	}
}

module slide (l=420, car=0){
	n=floor((l-40)/60)+1;
	o=(l-(n-1)*60)/2;

	color("darkgray")
	difference(){
		slideprofile(l=l);

		for (i=[0:n-1])
			translate([0,o-l/2+i*60,-500])
			cylinder(r=6.6/2, h=1000);
	}

	translate([0,car,0])
	color("gray")
	difference(){
		translate([-73/2,-50,0.1])
		cube([73,100,24-.1]);

		slideprofile(l=200, topcut=0);
	}
}


module zmotor (){
	import_stl("Z_lower_motor_mount_10mm_2_copies.stl", convexity=10);

	translate([-32,-10.5,47])
	rotate([-90,90,-90])
	import_stl("Z_lower_motor_mount_10mm_support_standard_2_copies.stl", convexity=10);

	translate([32,-27.5,24])
	rotate([-90,90,90])
	import_stl("Z_lower_motor_mount_10mm_support_mirrored_2_copies.stl", convexity=10);
	translate([0,0,65])
	import_stl("Z_rod_clasp_4_copies.stl", convexity=10);
}

module xaxis (w=300, color="blue"){
	o=9.5;
	o2=-10;

	color(color){

		translate([-35,o2+o-w/2+50,0])
		rotate([180,0,0])
		import_stl("z-endstop_integrated_clamp.stl", convexity=10);
		//import_stl("X End Clamp for MendelMax Leadscrew_1_copy.stl", convexity=10);
		translate([-35,o2+o-w/2,0])
		import_stl("X End Motor for MendelMax Leadscrew_1_copy.stl", convexity=10);

		translate([0,o2+w/2-o,-10])
		import_stl("X End Idler for MendelMax Leadscrew_1_copy.stl", convexity=10);
	}

	color("silver")
	for (x1=[-25,25])
	translate([x1,0,0])
	rotate([90,0,0])
	cylinder(r=8/2, h=w+30, center=true);


	translate([-29,-w/2-33.5,31]){
		rotate([0,-90,0])
		stepper();

		translate([-15,0,0])
		rotate([90,0,90])
		belt(l=w+10);
	}

}
module stepper(l=39, s=24){
	difference(){
		union(){
			translate([0,0,-l/2])
			color("black")
			cube([42.3, 42.3, l], center=true);
			translate([0,0,-l])
			color("silver")
			cylinder(r=22/2, h=l+2);
			translate([0,0,-l])
			color("silver")
			cylinder(r=5/2, h=l+s);
		}
		for(x=[-31/2, 31/2])
		for(y=[-31/2, 31/2])
		translate([x,y,-4.5])
		cylinder(r=3/2, h=4.5+30);
	}
}

module xcarriage(color="blue"){
	translate([0,45,12])
	rotate([0,180,90])
	color(color)
	difference(){//remove other parts in the stl
		import_stl("2FanBushingXCarriageNoloss_repaired.stl", convexity=10);
	translate([35,15,-5])
		cube([20,20,20]);
	translate([84,9,-5])
		cube([26,34,20]);
	translate([95,7,-5])
		cube([26,38,20]);
	translate([0,63,-100])
		cube([200,200,200]);
	}
	//translate([-3,11,0])	rotate([0,0,25])
	color(color)
	translate([-62,8.5,11.9])
	rotate([0,90,-90])
	difference(){
		import_stl("t-micro-v1.4.3.stl", convexity=10);
		translate([-31,-172,-100])
		cube([20,200,200]);
		translate([5,-100,-100])
		cube([200,200,200]);
	}

	translate([-25,0,-27])
	color("gold")
	cylinder(r=7, h=27);

	translate([-22,8.5,33])
	rotate([0,90,-90])
	rotate([0,0,37])
	motor();
}

module ybelt(l=420, color="blue"){

	translate([0,l/2+20,0])
	rotate([90,0,180])
	color(color)
	translate([0,0,-2]) import_stl("Y-Idler-mount_1_copy.stl", convexity=10);

	translate([0,l/2+20+4,26])
	rotate([90,0,180])
	color(color)
	import_stl("Y-Idler-tensioner_1_copy.stl", convexity=10);

	translate([30,-l/2-20,25])
	rotate([90,180,0])
	color(color)
	import_stl("Y_Motor_Mount_1_copy.stl", convexity=10);

	translate([12.5,-l/2-50,25])
	{
		rotate([0,-90,0])
		stepper();

		translate([-15,0,0])
		rotate([90,0,90])
		belt(l=l+85);

		rotate([180,90,0])
		color(color)
		difference(){ 
			import_stl("mm-y-belt-shield.stl", convexity=10); 
			translate([-500,-1000,8-1000]) 
			cube([1000,1000,1000]);
		}

		}

}

module table(){

	color("black")
	translate([0,0,3.18/2])
	cube([238,298,3.18], center=true);
	color("lightblue", .5)
	translate([0,0,15-4.13/2])
	cube([231,291,4.13], center=true);

}


module ramps(color="blue"){
	color(color)
	import_stl("arduinoMount.stl", convexity=10);

//http://www.thingiverse.com/thing:21497
	color("limegreen")
	translate([53.7,29.8,9])
	import_stl("ArduinoMegaBoard.stl", convexity=10);

	color("limegreen")
	translate([98.04,31.6,20.62])
	import_stl("Ramps14_3D.stl", convexity=10);
}


module mendelmax15(w=300, l=420, bs=50, color="orange", outervertex=false, x=30, y=50, z=24+15+27){


	d=l-80;
	t=w+120;

	for (r1=[0, 180])
		rotate([0,0,r1]){


		for (z1=[10, 10+bs]){
			translate([w/2-10,0,z1])
			rotate([90,0,0])
			extrusion(l=l);

			translate([0,-l/2-10,z1])
			rotate([0,90,0])
			extrusion(l=w);
		}

		translate([0,-l/2-10,bs])
		rotate([-30,0,0]){
			for (x1=[-w/2+10, w/2-10])
			translate([x1,-10,d/2+35])
			extrusion(l=d);

			translate([0,-10,d+10+35])
			rotate([0,90,0])
			extrusion(l=t);
		}

		color(color){
				translate([-w/2+10, -l/2+7, -4])
				rotate([0,0,90])
				import_stl("Lower Vertex Lower_Left_2_copies.stl", convexity=10);
				translate([-w/2+17, -l/2+7, bs+20])
				rotate([0,0,90])
				import_stl("Lower Vertex Upper_left_2_copies.stl", convexity=10);

				translate([w/2-10, -l/2+7, -4])
				rotate([0,0,90])
				import_stl("Lower Vertex Lower_Right_2_copies.stl", convexity=10);
				translate([w/2-17, -l/2+7, bs+20])
				rotate([0,0,90])
				import_stl("Lower Vertex Upper_right_2_copies.stl", convexity=10);

				translate([t/2+5,0,bs+l*sqrt(3)/2-25])
				rotate([-90,0,90]){
					import_stl("Z_Top_Vertex_10mm_2_copies.stl", convexity=10);
					translate([0,-1,0])
					mirror([0,0,1])
					import_stl("Z_rod_clasp_4_copies.stl", convexity=10);
				}


				translate([w/2,0,bs+10])
				rotate([90,0,90])
				zmotor();


				for (m1=[[0,0,0], [1,0,0]]){
					mirror(m1)
					translate([w/2-10, -l/2-10, bs])
					rotate([60,0,0])
					translate([0, l-35, 20])
					if (outervertex) translate([-10, -70, 0]) import_stl("TopVertexOuter80mm_fixed.stl", convexity=10);
					else translate([-40, -40, 0]) import_stl("Top_Vertex_X_2_or_4_copies.stl", convexity=10);

				}

			}

			color("silver")
			translate([w/2+65,0,bs+10-20])
			cylinder(r=10/2, h=10+l*sqrt(3)/2);

			translate([w/2+35,0,bs]){
				color("silver")
				translate([0,0,24+20-5])
				cylinder(r=3/8*25.4/2, h=-40+l*sqrt(3)/2);
				translate([0,0,20-5])
				stepper();
			}

	}


	translate([0,0,20/2+bs])
	rotate([90,0,0])
	extrusion(l=t);

	for (r=[0,180])
	rotate([0,0,r])
	for (x1=[1,-1])
	translate([x1*20/2,-l/2,bs-20*(x1-1)/2])
	rotate([0,(x1-1)*90,0])
	HBLFSN5();

	translate([0,0,bs+20]){
		slide(l=l, car=y);
		color(color)
		translate([0,y+12,-15.25])
		rotate([0,-90,90])
		import_stl("Belt Anchor for y-carriage-2.stl", convexity=10);
	}

	translate([0,0,bs+20+z])
	rotate([0,0,-90])
	xaxis(w=w+130, color=color);

	translate([x-74,0,bs+20+z])
	rotate([0,0,180])
	xcarriage(color=color);

	translate([0,0,10])
	ybelt(l=l, color=color);

	translate([0,y,bs+20+24])
	table(color=color);

	translate([-w/2,-57,bs+20])
	rotate([90,0,180])
	zendstop(color=color, switch=1);

	translate([-54,-l/2-10,bs+20])
	yendstop(color=color, switch=1);

	//power supply
	color("gold")
	translate([20,-30,5])
	cube([98, 158,40]);

	translate([w/2-20-4,-110,20+(bs-20)/2])
	rotate([0,-90,0])
	display_ssr(color=color);

	translate([-w/2+20,-140,20+(bs-20)/2-30])
	rotate([90,0,90])
	ramps(color);

	translate([-w/2+20+110/2+1,-l/2-20,20+(bs-20)/2])
	rotate([90,0,180])
	color(color)
	translate([0,0,-3.8]) import_stl("power_usb_panel.stl", convexity=10);

}
module belt(l=200, d1=10, d2=10, t=2, w=6){
	color("black")
	difference(){
		hull(){
			cylinder(r=d1/2+t, h=w, center=true);
			translate([l, 0, 0])
			cylinder(r=d2/2+t, h=w, center=true);
		}	
		hull(){
			cylinder(r=d1/2, h=w+1, center=true);
			translate([l, 0, 0])
			cylinder(r=d2/2, h=w+1, center=true);
		}	
	}
}




mendelmax15(outervertex=true);


/*
slide support corners
feet

import_stl("4corners.stl", convexity=10);
import_stl("clip.stl", convexity=10);
import_stl("spindleBearingAdapter.stl", convexity=10);

*/


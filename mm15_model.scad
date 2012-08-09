	
module extrusion(l=200, x=20){
	color("silver")
	difference(){
		cube([x,x,l], center=true);

		for (r=[0:90:270])
			rotate([0,0,r]){
				union(){
					translate([0, x/2+x*.35, 0])
					cube([x*.3,x,l*2], center=true);

					translate([0, x*.35, 0])
					cube([x*.4,x*.15,l*2], center=true);
				}
			}
	}
}

module slide (l=200){
	color("darkgray")
	translate([0,0,10/2])
	difference(){
		cube([40,l,10], center=true);

		translate([-9,0,3])
		cube([6,l,5], center=true);

		translate([9,0,3])
		cube([6,l,5], center=true);
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
		import_stl("X End Clamp for MendelMax Leadscrew_1_copy.stl", convexity=10);
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


	translate([-29,-w/2-33.5,31])
	rotate([0,-90,0])
	stepper();

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
//	import_stl("micro extruder v1.4.2c.stl", convexity=10);
//	import_stl("t-micro-with-bearing-plate.stl", convexity=10);
}

module mendelmax15(w=300, l=420, bs=50, color="blue", outervertex=false, x=100, y=100, z=100){


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

	translate([0,0,bs+20])
	slide(l=420);

	translate([0,0,bs+20+z])
	rotate([0,0,90])
	xaxis(w=w+130, color=color);

	translate([x-74,0,bs+20+z])
	xcarriage(color=color);

}

//xaxis(w=0);

mendelmax15();

/*
import_stl("4corners.stl", convexity=10);
import_stl("arduinoMount.stl", convexity=10);
import_stl("Belt Anchor for y-carriage-2.stl", convexity=10);
import_stl("clip.stl", convexity=10);
import_stl("mm-y-belt-shield.stl", convexity=10);
import_stl("power_usb_panel.stl", convexity=10);
import_stl("spindleBearingAdapter.stl", convexity=10);
import_stl("ssr.stl", convexity=10);
import_stl("Y-Idler-mount_1_copy.stl", convexity=10);
import_stl("Y-Idler-tensioner_1_copy.stl", convexity=10);
import_stl("Y_Motor_Mount_1_copy.stl", convexity=10);
import_stl("z_endstop_holder.stl", convexity=10);
import_stl("z-endstop_integrated_clamp.stl", convexity=10);
*/


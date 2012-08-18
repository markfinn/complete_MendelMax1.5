use<ss_3gl13p.scad>



module nut(w, h){
	translate([0,0,h/2])
	for (i=[1:3])
		rotate([0,0,60*i])
		cube([w, w/sqrt(3), h], center=true);

}



module	yendstop(color="blue", switch=0){
$fn=12;

switch_offset_side=5;
switch_offset_in=0;
switch_offset_height=15.8-15.8;

thickness=4;
extrusion_pad_width=50;
extrusion_pad_ridge_depth=1.5;
extrusion_pad_ridge_width=5.9;

strut_thickness=10;
strut_width=5.5;

switch_backing_width=19;
switch_backing_height=9;

switch_hole_dia=2.3;

	if(switch){
		translate([switch_offset_side,switch_offset_in,switch_offset_height+6.4])
		ss_3gl13p();}
	

	color(color)
	translate([-20/2, 0, 0])
	difference(){
		union(){
			rotate([90,0,90])
			difference(){
				union(){
					translate([-20/2, 0, 0])
					cube([20, thickness, extrusion_pad_width]);

					hull(){
						translate([-extrusion_pad_ridge_width/2, -.01, 0])
						cube([extrusion_pad_ridge_width, .02, extrusion_pad_width]);

						translate([-(extrusion_pad_ridge_width-.8)/2, -extrusion_pad_ridge_depth, 0])
						cube([extrusion_pad_ridge_width-.8, 2*extrusion_pad_ridge_depth, extrusion_pad_width]);
					}
				}

				for (x=[7, extrusion_pad_width-7])
				translate([0, 0, x])
				rotate([90,0,0])
					cylinder(r=5/2, h=thickness*3, center=true);
			}

			translate([20/2+switch_offset_side, -10, 0])
			cube([switch_backing_width, 20+switch_offset_in-3, 6.4+switch_offset_height]);
		}

		for (q=[switch_offset_side+5.15,switch_offset_side+5.15+9.5])
		translate([20/2+q, switch_offset_height+switch_offset_in, -extrusion_pad_ridge_depth-1])
		rotate([0,0,90]){
			cylinder(r=switch_hole_dia/2, h=strut_width*30, center=true);
			nut(w=4, h=extrusion_pad_ridge_depth+1.6+1);
		}
	}

}
yendstop(switch=0);


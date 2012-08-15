module	zendstop(color="blue", switch=0){
$fn=12;

switch_offset_side=5;
switch_offset_height=23+15+27-16-7;

thickness=4;
extrusion_pad_width=13;
extrusion_pad_ridge_depth=1.5;
extrusion_pad_ridge_width=5.9;

strut_thickness=10;
strut_width=5.5;

switch_backing_width=19;
switch_backing_height=9;

switch_hole_dia=2.3;

	if(switch){
		//SS-3GL13P
		translate([switch_offset_side,switch_offset_height,strut_width])
		difference(){
			union(){
				color("black")
				translate([0,-3.3,0]) cube([19.8,7.7+3.3,6.4]);
				color("silver")
				translate([5.15+15.8,10.7,0]) rotate([0,0,-170]) cube([20,1,6.4]);
			}
			translate([5.15,0,0])
			cylinder(r=2.3/2, h=100, center=true);
			translate([5.15+9.5,0,0])
			cylinder(r=2.3/2, h=100, center=true);
		}
	}

	color(color)
	translate([-20/2, 0, 0])
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
			intersection(){
				translate([20/2, 0, 0])
				rotate([0,0,atan2(switch_offset_height-switch_backing_height/2, switch_offset_side)])
				translate([-500, 0, 0])
				cube([1000, strut_thickness, strut_width]);

				translate([-20/2, 0, 0])
				cube([20+switch_offset_side, switch_offset_height+switch_backing_height/2, strut_width]);
			}

			translate([20/2+switch_offset_side, switch_offset_height-switch_backing_height/2, 0])
			cube([switch_backing_width, switch_backing_height, strut_width]);
		}
		translate([0, 0, extrusion_pad_width/2])
		rotate([90,0,0]){
			cylinder(r=5/2, h=thickness*3, center=true);
			translate([0,0,-thickness-1000])
			cylinder(r=8.4/2+.2, h=1000);
		}
		for (q=[switch_offset_side+5.15,switch_offset_side+5.15+9.5])
		translate([20/2+q, switch_offset_height, extrusion_pad_width/2])
		rotate([0,0,90])
		cylinder(r=switch_hole_dia/2, h=strut_width*3, center=true);
	}

}
//zendstop();


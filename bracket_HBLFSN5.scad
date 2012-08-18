//misumi reversal tabbed brackets HBLFSN5

//missing the bumps that fit into the extrusion.  1mm deep, no profile given.

side_l=30;
side_t=3;//measured
t=4.5;
w=20;
h1_d=18;
h2_d=10;
h_d=5.3;

module HBLFSN5(){
	color("SlateGray")
	difference(){
		cube([side_l, side_l, w]);
		translate([t,t,side_t])
		cube([side_l, side_l, w-side_t*2]);

		translate([side_l/2+t/2, side_l/2+t/2,0])
		rotate([0,0,45])
		translate([side_l, 0,0])
		cube([side_l*2, side_l*2, w*3], center=true);

		translate([0, h1_d, w/2])
		rotate([0,90,0])
		cylinder(r=h_d/2, h=1000, center=true);

		translate([0, h2_d, w/2])
		rotate([0,90,0])
		cylinder(r=h_d/2, h=1000, center=true);

		translate([h1_d, 0, w/2])
		rotate([90,0,0])
		cylinder(r=h_d/2, h=1000, center=true);
	}
}
HBLFSN5();


//SS-3GL13P microswitch

//the real lever has a bump that isn't depicted here, but the tip of the lever here is where the tip of the bump is on the real switch when the operating point is reached

module ss_3gl13p(){
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


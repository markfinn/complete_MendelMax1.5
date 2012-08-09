d=13+31/2;  //dist to cover on belt
h=29; // height off motor face
cut=8; //height of motor mount cutout

difference(){
	union(){
		//base mount
		hull(){
			cylinder(r=25/2+3, h=5);
			translate([31/2,31/2,0])
			cylinder(r=7/2, h=5);	
			translate([-31/2,31/2,0])
			cylinder(r=7/2, h=5);	
		}

		//main shell exterior
		hull(){
			cylinder(r=25/2+3, h=h);
			translate([-(25/2+3),-d,0])
			cube([25+3*2,1,h]);
		}
	}

	//main shell cutout	
	translate([0,0,-3])
	hull(){
		cylinder(r=25/2, h=h);
		translate([-25/2,-d*2,0])
		cube([25,1,h]);
	}

	//motor mount notch
	translate([0,-(d-3)/2,0])
#	cube([100,d-3,cut*2], center=true);

	//screw holes
	translate([31/2,31/2,0])
	cylinder(r=3/2, h=100, center=true);	
	translate([-31/2,31/2,0])
	cylinder(r=3/2, h=100, center=true);	
}

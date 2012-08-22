
t=5;
separation=145;
side_holes = [[19.27, 22.25], [9.2, 139.2], [9.2+18.06, 139.2]];
hole_d = .12*25.4;
hole_clear=11/2+1;
hole_w=7.5;
hole_inset=.5;
ps_l=158;

module flathead4_40(l=10, over=10){
hh = .047*25.4;
hd = .212*25.4;
ha = 82;
sd = .112*25.4;

	union(){
		cylinder(r1=hd/2, r2=hd/2 - hh*tan(ha/2), h=hh, $fn=12);
		cylinder(r=sd/2, h=l, $fn=12);
		if (over)
			translate([0,0,-over])
			cylinder(r=hd/2, h=over+.1, $fn=12);
	}
}


module power_supply_bracket1(){
	difference(){
		hull(){
			translate([t-hole_inset,side_holes[0][1],side_holes[0][0]])
			rotate([0,-90,0])	
			cylinder(r=hole_w+hole_d/2, h=t);

			translate([0,-hole_clear,0]){
				translate([0,0,10])
				rotate([0,90,0])	
				cylinder(r=hole_w+5/2, h=t);

				translate([0,0,10+50])
				rotate([0,90,0])	
				cylinder(r=hole_w+5/2, h=t);

				translate([0,15,10])//fake hole ust to put a flat spot on the bottom
				rotate([0,90,0])	
				cylinder(r=hole_w+5/2, h=t);
			}

		}
		translate([t-hole_inset,side_holes[0][1],side_holes[0][0]])
		rotate([0,-90,0])	
		flathead4_40(l=t+1, over=hole_inset+1);

		translate([0,-hole_clear,0]){
			translate([0,0,10])
			rotate([0,90,0])	
			cylinder(r=5/2, h=100, center=true);

			translate([0,0,10+50])
			rotate([0,90,0])	
			cylinder(r=5/2, h=100, center=true);
		}
	}

}

module power_supply_bracket2(){

	difference(){
		hull(){
			translate([t-hole_inset,side_holes[1][1],side_holes[1][0]])
			rotate([0,-90,0])	
			cylinder(r=hole_w+hole_d/2, h=t);

			translate([t-hole_inset,side_holes[2][1],side_holes[2][0]])
			rotate([0,-90,0])	
			cylinder(r=hole_w+hole_d/2, h=t);

			translate([0,ps_l+hole_clear,0]){
				translate([0,0,10])
				rotate([0,90,0])	
				cylinder(r=hole_w+5/2, h=t);

				translate([0,0,10+50])
				rotate([0,90,0])	
				cylinder(r=hole_w+5/2, h=t);

				translate([0,-20,10])//fake hole ust to put a flat spot on the bottom
				rotate([0,90,0])	
				cylinder(r=hole_w+5/2, h=t);
			}
		}

		translate([t-hole_inset,side_holes[1][1],side_holes[1][0]])
		rotate([0,-90,0])	
		flathead4_40(l=t+1, over=hole_inset+1);

		translate([t-hole_inset,side_holes[2][1],side_holes[2][0]])
		rotate([0,-90,0])	
		flathead4_40(l=t+1, over=hole_inset+1);

		translate([0,ps_l+hole_clear,0]){
			translate([0,0,10])
			rotate([0,90,0])	
			cylinder(r=5/2, h=100, center=true);

			translate([0,0,10+50])
			rotate([0,90,0])	
			cylinder(r=5/2, h=100, center=true);
		}
	}
}

translate([0,-130,0])
rotate([0,-90,0])
power_supply_bracket2();
translate([-65,0,0])
rotate([145,-90,0])
power_supply_bracket1();


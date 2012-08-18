//eMinebea PG35L-048-USC0

motor_d   = 35;
motor_l   = 20.3;

gearbox_d = 34.74;
gearbox_l = 22.47;
collar_l  = 4.5;
collar_d  = 9.85;
shaft_d   = 5;
shaft_l   = 18.3; //from gearbox face
shaft_back_d = 2;
shaft_back_l = 2.12; //from back face
back_circle_d = 21.72;
back_circle_l = 1.3;

//@ 30, 90, 150, 210, 270, 330
back_6smallcircles_d = 3.46;
back_6smallcircles_l = 1;
back_6smallcircles_centerpos_d = 30.85 - back_6smallcircles_d;

hobbed_d = 12.78;
hobbed_l = 11.25;
hobbed_minor_d = 11.16;
hobbed_minor_y = hobbed_l-7.27;
hobbed_dist_from_face = 7;

//@ 0, 120, 240
cuts_3_w = 8;
cuts_3_depth = gearbox_d - 33.6;

mounttabs_hd = 3.43;
mounttabs_t = 5;
mounttabs_w = 2;
mounttabs_l = 41.66;


wirebox_p = 27.48; //dist from mounting face
wirebox_l = 12.67;
wirebox_w = 15.7;
wirebox_t = 39.62-motor_d;
wirebox_a = -23.5;

module motor(){
	union(){

		color("silver")
		translate([0,0,-(gearbox_l+motor_l)])
		cylinder(r=motor_d/2, h=motor_l);

		color("ivory")
		difference(){
			union(){
				translate([0,0,-(gearbox_l+.1)])
				cylinder(r=gearbox_d/2, h=gearbox_l+.1);

				translate([0,0,-gearbox_l])
				cylinder(r=collar_d/2, h=collar_l+gearbox_l);

				hull(){
					translate([mounttabs_l/2,0,-mounttabs_t])
					cylinder(r=(mounttabs_hd+mounttabs_w)/2, h=mounttabs_t);
					translate([-mounttabs_l/2,0,-mounttabs_t])
					cylinder(r=(mounttabs_hd+mounttabs_w)/2, h=mounttabs_t);
					translate([0,0,-mounttabs_t])
					intersection(){
						cylinder(r=gearbox_d/2, h=mounttabs_t);
						translate([0,-500,0])
						cube([1000,1000,1000], center=true);
					}
				}
			}
			for (r=[0:120:240])
			rotate([0,0,r])
			translate([0,cuts_3_depth-gearbox_d/2-500,0])
			cube([cuts_3_w, 1000, 1000], center=true);

			translate([mounttabs_l/2,0,0])
			cylinder(r=mounttabs_hd/2, h=mounttabs_t*3, center=true);
			translate([-mounttabs_l/2,0,0])
			cylinder(r=mounttabs_hd/2, h=mounttabs_t*3, center=true);

		}

		color("silver")
		cylinder(r=shaft_d/2, h=shaft_l);

		color("silver")
		translate([0,0,hobbed_dist_from_face])
		difference(){
			cylinder(r=hobbed_d/2, h=hobbed_l);
	
			cylinder(r=shaft_d/2, h=hobbed_l*3, center=true);

			rotate_extrude(convexity = 10)
			translate([hobbed_d/2, hobbed_minor_y, 0])
			circle(r = hobbed_d-hobbed_minor_d);		
		}


		color("ivory")
		translate([0,0,-(gearbox_l+back_circle_l+motor_l)])
		cylinder(r=back_circle_d/2, h=back_circle_l+motor_l);

		color("ivory")
			for (r=[30:60:359])
			rotate([0,0,r])
			translate([0,back_6smallcircles_centerpos_d/2,-(gearbox_l+back_circle_l+motor_l)])
			cylinder(r=back_6smallcircles_d/2, h=back_6smallcircles_l+motor_l);
		
		color("ivory")
		rotate([0,0,wirebox_a])
		translate([-wirebox_w/2,0,-wirebox_p-wirebox_l])
		cube([wirebox_w, wirebox_t+motor_d/2, wirebox_l]);

	}

}

motor();

//power supply sopudar SPD-60W

//http://www.ebay.com/itm/190687975083 
//ebay seller hi-etech 

w=98;
l=158;
h=42.5;
side_holes = [[19.27, 22.25], [9.2, 139.2], [9.2+18.06, 139.2]];
bottom_holes = [[32.6, 24.21], [32.6, 102.28]];
hole_d=.116*25.4;//#4-40


t=1.55;
term_w=68.47;
term_h=25.4;
term_d=12.43;
term_o=18.9;

cover_holes_d=4;
cover_holes_o1=6;
cover_holes_o2=5.2;


back_indent_d=4.7;
back_indent_side=12.3;
back_indent_h=13.04;




module powersupply_SPD_60W(){

	color("silver")
	difference(){
		translate([-w,0,0])
		cube([w, l, h]);

		translate([-w-t,-back_indent_d-t,t])
		cube([w, l, h]);

		translate([-w-t,l-back_indent_d,back_indent_h])
		cube([w, l, h]);

		for (hi=side_holes)
		translate([0, hi[1], hi[0]])
		rotate([0,90,0])
		cylinder(r=hole_d/2, h=100, center=true);

		for (hi=bottom_holes)
		translate([-hi[0], hi[1], 0])
		cylinder(r=hole_d/2, h=100, center=true);
	}

	color("black")
	translate([-term_w-term_o-t,0,t])
	cube([term_w, term_d, term_h]);

	color("Goldenrod")
	translate([-w,term_d,h])
	union(){
		translate([0,0,-1])
		perf(w-t, l-term_d-back_indent_d, 1);

		rotate([0,90,0])
		perf(h-1, l-term_d-back_indent_d, 2);
	}
}


module perf(w,l, o){
	difference(){
		cube([w,l, 1]);

		for(x=[0:(floor(w/cover_holes_o1)-2)])
		for(y=[0:(floor(l/cover_holes_o2/2)-2)])
		translate([o+cover_holes_d/2+x*cover_holes_o1,6+cover_holes_d/2+y*cover_holes_o2*2,0])
		{
			cylinder(r=cover_holes_d/2, h=10, center=true);
			translate([-cover_holes_o1/2,cover_holes_o2,0])
			cylinder(r=cover_holes_d/2, h=10, center=true);
		}
	}

}

powersupply_SPD_60W();


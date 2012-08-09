//from http://www.wayneandlayne.com/files/common/arduino_mega_drawing.svg
arduino_dims =  [4.000 *25.4, 2.100 *25.4];
arduino_holeR = .125/2*25.4;
arduino_holes = [
				[0.550 *25.4, 0.100 *25.4],
				[0.600 *25.4, 2.000 *25.4],
				[3.800 *25.4, 0.100 *25.4],
				[2.600 *25.4, 0.300 *25.4],
				[3.550 *25.4, 2.000 *25.4],
				[2.600 *25.4, 1.400 *25.4]];

plateOverhang = 3;
plateThickness = 6;
standoffD = (arduino_holeR + 1.5)*2;
standoffH = 3;

underSlung = 0; //how low to dip the board below the bottom extrusion.  beware, on mine the ramps hangs lower than this, and I have feet that give me more clearance.


mountSpacingWidth=44;	//badly named.  not distance between mounts, but distance from edge to mount
mountSpacingHeight=50;
mountThickness=plateThickness;


//this is set fo a #4 machine screw.  I know it's not metric and I want to kill myself, but homedepot doesn't stock many small metric screws
nutTrapWidth=1/4*25.4;
nutTrapHieight=3/32*25.4+1;






plateWidth = arduino_dims[0]+plateOverhang*2;
plateHeight = arduino_dims[1]+plateOverhang*2;

module arduino_plate(){
	translate([plateOverhang,plateOverhang,0])
	difference(){
		union(){
			translate([-plateOverhang,-plateOverhang,])
			cube([plateWidth, plateHeight, plateThickness]);
			for (h = arduino_holes)
				translate([h[0], h[1], 0])
				cylinder(r=standoffD/2, h=standoffH+plateThickness);
		}
		for (h = arduino_holes)
			translate([h[0], h[1], -1]){
				cylinder(r=arduino_holeR, h=standoffH+plateThickness+2);
				nut(nutTrapWidth, nutTrapHieight+1);
			}
	}
}


module nut(w, h){
	translate([0,0,h/2])
	for (i=[1:3])
		rotate([0,0,60*i])
		cube([w, w/sqrt(3), h], center=true);

}

difference(){
	union(){
		arduino_plate();
		for (x = [mountSpacingWidth/2,plateWidth-13-mountSpacingWidth/2])
			translate([x, underSlung-(mountSpacingHeight-plateHeight)/2, plateThickness-mountThickness])
			cube([13, mountSpacingHeight, mountThickness]);
		for (x = [13/2+mountSpacingWidth/2,plateWidth-13/2-mountSpacingWidth/2])
		for (y = [plateHeight/2-mountSpacingHeight/2, plateHeight/2+mountSpacingHeight/2])
			translate([x, underSlung+y, plateThickness-mountThickness])
			cylinder(r=13/2, h=mountThickness);
	}

	for (x = [13/2+mountSpacingWidth/2,plateWidth-13/2-mountSpacingWidth/2])
	for (y = [plateHeight/2-mountSpacingHeight/2, plateHeight/2+mountSpacingHeight/2])
		translate([x, underSlung+y, 0]){
			translate([0,0, plateThickness-mountThickness-1])
			cylinder(r=5/2, h=mountThickness+2);

			translate([0,0, plateThickness-2.5])
			cylinder(r2=9.2/2+(9.2-5)/2.5*1, r1=5/2, h=2.5+1);
		}
}


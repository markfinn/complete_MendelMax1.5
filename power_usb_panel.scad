
//use <boxes.scad>
use</home/mark/data/openscad/libraries/MCAD/boxes.scad>
use</home/mark/data/telepresense/includedthings/GoblinOne.scad>

//StarTech 1-Feet Panel Mount USB Cable B to B - F/M (USBPNLBFBM1)
//http://www.amazon.com/gp/product/B002M8VBIS/ref=oh_details_o02_s00_i00


//3 Pin IEC320 C14 Inlet Male Power Socket w Fuse Switch 10A 250V
//http://www.amazon.com/IEC320-Inlet-Power-Socket-Switch/dp/B00511QVVK
//http://www.uxcell.com/pin-iec320-c14-inlet-male-power-socket-fuse-switch-10a-250v-p-104813.html

panel_width = 110;
panel_height = 69;
panel_depth = 3.8;
panel_hole_hedge_w=5;  //horizontal distance from edge to mounting hole
panel_hole_vspace=50;  //vertical spacing of mounting holes

mount_hole_d = 5;


IEC_offset=-20;	//position left / right on panel
IEC_width=47+.5*2;  //mounting width of IEC switch/fuse/socket
IEC_height=27+.5*2; //mounting height of IEC switch/fuse/socket
IEC_depth=1;     //mounting flange depth of IEC switch/fuse/socket
IEC_rim=1.5;		//width of flange before returning to full panel thickness
IEC_corner=6-.5;     //side length of the corner cutout on the IEC connect end of the power module

usb_offset=32;  //position left / right on panel
usb_height =11.2;  //USB socket hole height
usb_width = 12.4;  //USB socket hole width
usb_flange_height=14.5+1;  //indent in back for usb molding
usb_flange_width=39+1;   //indent in back for usb molding
usb_flange_thick=2.25;    //thinckness of plate over USB molding
usb_holes_distance = 25.5;  
usb_holes_vert_off = 0;
usb_holes_diameter = 3;

text_etch_depth=.5;  //depth of text etching. <=0 for off.

module text(str, h, t){

	s=h/45;
	scale(s)
	translate([0,-45/2,0])
	GoblinOne(str, height = t/s, center=true);

}

module panel () {
	translate(v = [0,0,panel_depth/2])
	rotate ([180,0,180])
	difference ()  {
		//panel
		roundedBox([panel_width,panel_height,panel_depth],10,true);

		//socket
		translate(v = [IEC_offset, 0, 0])
		difference(){
			union(){
				translate(v = [0, 0, -IEC_depth])
				cube(size = [IEC_width,IEC_height+IEC_rim*2,panel_depth], center = true );
				cube(size = [IEC_width,IEC_height,panel_depth+1], center = true);
			}
			for (x = [-1:2:1])
				translate([(IEC_width-IEC_corner)/2, x*(IEC_height-IEC_corner)/2,0])
				rotate([0,0,x*45])
				translate([0,-(IEC_width+IEC_height)/2,-(panel_depth+1)/2])
				cube([IEC_width+IEC_height,IEC_width+IEC_height,panel_depth+1]);
		}

		//usb socket
		translate(v = [usb_offset,0, 0])
		union(){
			translate(v = [0, 0, -usb_flange_thick])
			cube(size = [usb_flange_width,usb_flange_height,panel_depth], center = true );
			cube(size = [usb_width,usb_height,panel_depth+1], center = true );
		}
		
		//usb screws
		for (x = [-1:2:1])
			translate(v = [usb_offset+x*usb_holes_distance/2, usb_holes_vert_off, 0])
			cylinder(h = panel_depth+1, r=usb_holes_diameter/2, $fn=10,center = true);

		//M5 frame mounting holes
		for (x = [-1:2:1])
		for (y = [-1:2:1])
			translate(v = [x*(panel_width/2-panel_hole_hedge_w-mount_hole_d/2), y*(-panel_hole_vspace/2), 0])
			cylinder(h = 10, r=mount_hole_d/2, $fn=10,center = true);


		//text
		if(text_etch_depth>0){
			translate([0,panel_height/2-7/2-6,panel_depth-text_etch_depth])
			text("MendelMax", 7, panel_depth);
			translate([20,panel_height/2-7/2-6-7-3,panel_depth-text_etch_depth])
			text("1.5", 7, panel_depth);
			translate([IEC_offset,-IEC_height/2-7/2-5,panel_depth-text_etch_depth])
			text("Power", 7, panel_depth);
			translate([usb_offset,-usb_height/2-7/2-5,panel_depth-text_etch_depth])
			text("USB", 7, panel_depth);
		}


	}
}


panel() ;

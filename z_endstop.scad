module	zendstop(color="blue", switch=0){
$fn=12;
w=13;
t=4;
d=1.5;
dw=5.9;

t2=10;
w2=5.5;
oh=5;
ov=23+15+27-16-7;
os=19;

t3=9;

dia2=2.3;

	if(switch){
		//SS-3GL13P
		translate([oh,ov,w2])
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
			cube([20, t, w]);

			hull(){
				translate([-dw/2, -.01, 0])
				cube([dw, .02, w]);

				translate([-(dw-.8)/2, -d, 0])
				cube([dw-.8, 2*d, w]);
			}
			intersection(){
				translate([20/2, 0, 0])
				rotate([0,0,atan2(ov-t3/2, oh)])
				translate([-500, 0, 0])
				cube([1000, t2, w2]);

				translate([-20/2, 0, 0])
				cube([20+oh, ov+t3/2, w2]);
			}

			translate([20/2+oh, ov-t3/2, 0])
			cube([os, t3, w2]);
		}
		translate([0, 0, w/2])
		rotate([90,0,0]){
			cylinder(r=5/2, h=t*3, center=true);
			translate([0,0,-t-1000])
			cylinder(r=8.4/2+.2, h=1000);
		}
		for (q=[oh+5.15,oh+5.15+9.5])
		translate([20/2+q, ov, w/2])
		rotate([0,0,90])
		cylinder(r=dia2/2, h=w2*3, center=true);
	}

}
//zendstop();


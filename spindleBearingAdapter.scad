
module spindleBearingAdapter()
{

	spindleConeInnerDia2 = 51.87 - .5;  //spool ID minus a little slop
	spindleConeInnerDia1 = spindleConeInnerDia2-2;  //make a nice cone shape
	spindleThickness = 12;

	rimDia = spindleConeInnerDia2 + 15;
	rimWidth = 3;

	bearingOuterDia = 22+.5;
	bearingInnerDia = 9.5;
	bearingThickness = 7;
      
	PrintLayerThinckness = .25;  //used to place a single layer bellow the unsupported hole.  Must be drilled out, but it makes a cleaner bridge. 0 if you want to just have an uglier bridge that you scrape out with a knife.


	difference(){
		union(){
			translate([0, 0, 0])
			cylinder(r = rimDia/2, h = rimWidth);

			cylinder(r2 = spindleConeInnerDia1/2, r1 = (spindleConeInnerDia2+rimWidth*(spindleConeInnerDia2-spindleConeInnerDia1)/spindleThickness)/2, h = spindleThickness);
		}

		translate([0, 0, -1])
		cylinder(r = bearingOuterDia/2, h = bearingThickness+1);

		translate([0, 0, PrintLayerThinckness+bearingThickness])
	#	cylinder(r = bearingInnerDia/2, h = spindleThickness-bearingThickness+1);
		}
}

spindleBearingAdapter();


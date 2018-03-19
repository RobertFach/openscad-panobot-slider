module slider(type="all") {
    include <node_modules/extrusion-profiles/extrusionProfile.scad>
    include <node_modules/belt-idler/belt-idler.scad>
    
    
    var_sliderLength=500;
    var_railDistance=60;
    var_profileWidth=20;
    var_idlerWidth=15;
    var_idlerThickness=3;
    var_stepperMountWidth=30;

    module railConnector(width) {
        difference() {
            cube([var_railDistance+var_profileWidth,width,var_profileWidth+2*var_idlerThickness],center=true);
            for(i=[-1,+1])translate([i*var_railDistance/2,0,0])rotate([90,0,0]){    
                extrusionProfile(size="2020",type="boundingBox",length=width+2);
                extrusionProfile(size="2020",type="tools",length=width+2);
            }
            cube([var_railDistance-var_profileWidth-2*var_idlerThickness,width+2,var_profileWidth],center=true);    
        }        
    }

    module idlerSide() {
        //add a construction which connects both extrusion profiles
        railConnector(width=var_idlerWidth);
        fixedBeltIdler(type="positive",width=0,height=var_profileWidth+2*var_idlerThickness,depth=var_idlerWidth);
    }
    
    module stepperSide() {
        difference() {
            railConnector(width=var_stepperMountWidth);
        }
    }

    translate([0,var_sliderLength/2-var_idlerWidth/2,0])idlerSide();
    translate([0,-(var_sliderLength/2-var_stepperMountWidth/2),0])stepperSide();
    if (type=="all") for(i=[-1,+1])translate([i*var_railDistance/2,0,0])rotate([90,0,0])extrusionProfile(size="2020",type="positive",length=var_sliderLength);

    
}


slider();
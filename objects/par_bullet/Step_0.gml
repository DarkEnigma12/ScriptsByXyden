/// @description Code

//Handles bullet curve
if(bullet_curve != 0) {direction += radtodeg(speed)/bullet_curve; bullet_curve += sign(bullet_curve)*curve_growth;}
speed += acceleration;

//Destroys instance when a fair distance outside room
var offset = 200;
if(x < -offset)or(x > room_width + offset)or(y < -offset)or(y > room_height + offset) {instance_destroy();}
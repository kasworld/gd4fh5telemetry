extends Node2D
class_name DialSpeed

var radius1 :float
var radius2 :float
var thick :float
var deg_step :int
var normal_bars # [deg begin,deg  end, color]
var over_bars # [deg begin,deg  end, color]

var bars_normal :PackedVector2Array =[]
var bars_over :PackedVector2Array =[]

func init(
		r1 :float = 200.0,
		r2 :float = 220.0,
		t :float = 3.0,
		degstep :int = 10,
		normal = [-160,90, Color.WHITE],
		over = [90,170, Color.RED],
	)->void:
	self.radius1 = r1
	self.radius2 = r2
	self.thick = t
	self.deg_step = degstep
	self.normal_bars = normal
	self.over_bars = over
	make_dial_bars()

func _draw() -> void:
	draw_multiline(bars_normal,normal_bars[2], thick)
	draw_multiline(bars_over,over_bars[2], thick)

func make_dial_bars()->void:
	bars_normal.clear()
	for i in range(normal_bars[0],normal_bars[1],deg_step):
		var rad = deg_to_rad(-i+180)
		bars_normal.append_array([ make_pos_by_deg_r(rad,radius1),make_pos_by_deg_r(rad,radius2) ])
	bars_over.clear()
	for i in range(over_bars[0],over_bars[1],deg_step):
		var rad = deg_to_rad(-i+180)
		bars_over.append_array([ make_pos_by_deg_r(rad,radius1),make_pos_by_deg_r(rad,radius2) ])

func make_pos_by_deg_r(rad:float, r :float)->Vector2:
	return Vector2(sin(rad)*r, cos(rad)*r)

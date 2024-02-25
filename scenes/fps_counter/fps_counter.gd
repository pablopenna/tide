extends RichTextLabel

func _ready():
	position = get_viewport_rect().position

func _process(_delta):
	#_fix_position()
	text = "%s" % Engine.get_frames_per_second()
	
func _fix_position():
	var cam_position = get_viewport().get_camera_2d().position if get_viewport().get_camera_2d() else null
	var window_size = get_viewport().get_window().size
	var top_left = Vector2(cam_position.x - window_size.x/2, cam_position.y - window_size.y/2) if cam_position != null \
	else get_viewport().get_window().position
	position = top_left
	

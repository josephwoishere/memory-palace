extends RichTextLabel



func _physics_process(delta):
	if Input.is_action_just_pressed("right_mouse"):
		set_text("created object")
		#_hideOrShow()
	if Input.is_action_just_pressed("left_mouse"):
		set_text("placed object")
		#_hideOrShow()
	
func _ready():
	set_text("")
	pass # Replace with function body.

#func _hideOrShow():
	#set_hidden(!get_node("Sprite").is_hidden())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Control


var menues: Dictionary

var menue_open: bool = false
var on_main_menue: bool = false

var open_menue: String

var open_menues: Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if on_main_menue == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if get_parent().name == "mainWorld":
		get_parent().hud = self
	await owner.ready
	for i in get_children():
		menues[i.name] = i

func open_the_menue(menue_name: String):
	if menue_open == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		menue_open = true
	
	open_menue = menue_name
	fix_order()
	open_menues.append(menue_name)
	menues.get(menue_name).open()
	mouse_filter = Control.MOUSE_FILTER_STOP

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_slash") and !menue_open:
		open_the_menue("AdminMenue")
	if event.is_action_pressed("inventory") and !menue_open:
		open_the_menue("PlayerInventory")
	if event.is_action_pressed("esc"):
		close_menues()


func close_menues():
	PlayerInventory.deselect.emit()
	PlayerInventory.selected_item = null
	if menue_open:
		
		menues.get(open_menue).close()
		open_menues.pop_back()
		if open_menues.is_empty():
			open_menue = ""
		else:
			open_menue = open_menues[len(open_menues) - 1]
			fix_order()
		if open_menues.is_empty():
			mouse_filter = Control.MOUSE_FILTER_IGNORE
			if !on_main_menue:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			menue_open = false
	else:
		if !on_main_menue:
			open_the_menue("puase_menue")


func fix_order():
	for i in open_menues:
		menues.get(i).z_index = -1
	menues.get(open_menue).z_index = 1

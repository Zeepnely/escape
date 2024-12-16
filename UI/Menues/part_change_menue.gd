extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	close()


# Called every frame. 'delta' is the elapsed time since the previous frame.



func close():
	$".".hide()

func open():
	$".".show()

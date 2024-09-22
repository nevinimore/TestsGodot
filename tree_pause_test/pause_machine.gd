extends Node2D

var n_pro: int = 0
var n_phy: int = 0

@onready var pause_button: TextureButton = $Node2D/PauseButton
@onready var pause_node: Node2D = $Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_button.pressed.connect(_on_pause_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#n_pro+=1
	#print("In process" + str(n_pro))
	#print(get_tree().paused)
	if Input.is_action_just_pressed("pause"):
		print("keyboard pressed")
		toggle_pause()

func _physics_process(_delta):
	#n_phy+=1
	#print("In physics process" + str(n_phy))
	#print(get_tree().paused)
	pause_node.rotate(0.01)

func toggle_pause():
	print("toggling from "+ str(get_tree().paused))
	get_tree().paused = !get_tree().paused

func _on_pause_pressed():
	print("texture button pressed")
	toggle_pause()

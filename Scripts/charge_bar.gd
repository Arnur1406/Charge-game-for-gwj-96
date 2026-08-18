extends TextureProgressBar
class_name ChargeBar

const COLOUR_DANGER: Color = Color("#cc0000")
const COLOUR_MID: Color = Color("#ff9900")
const COLOUR_GOOD: Color = Color("#33cc33")
const REDUCTION_RATE: float = 10


@export var max_charge: int = 150
@export var start_charge: int = 150
@export var mid_charge: Array[int] = [35, 101]
@export var low_charge: Array[int] = [20, 130]

var over_under_charged: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = max_charge
	step = 0.0
	value = start_charge
	over_under_charged = false
	pass


func set_colour() -> void:
	if value < low_charge[0] or value > low_charge[1]:
		tint_progress = COLOUR_DANGER
	elif value < mid_charge[0] or value > mid_charge[1]:
		tint_progress = COLOUR_MID
	else:
		tint_progress = COLOUR_GOOD



func increment_value(val: float, delta: float) -> void:
	value += val * delta
	if value <= 0 or value >= max_charge:
		over_under_charged = true
	#set_colour()


func reduce_charge(reducing_value: float, delta: float) -> void:
	increment_value(-reducing_value, delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	reduce_charge(REDUCTION_RATE, delta)

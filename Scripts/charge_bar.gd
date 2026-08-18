extends TextureProgressBar
class_name ChargeBar

const COLOUR_DANGER: Color = Color("#cc0000")
const COLOUR_MID: Color = Color("#ff9900")
const COLOUR_GOOD: Color = Color("#33cc33")
const REDUCTION_RATE: float = 10

signal over_under_charged
signal good_charge

var has_good_charge: bool = true


@export var max_charge: int = 150
@export var start_charge: int = 150
@export var mid_charge: Array[int] = [35, 101]
@export var low_charge: Array[int] = [20, 130]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	has_good_charge = true
	max_value = max_charge
	step = 0.0
	value = start_charge

##redundant function for now
func set_colour() -> void:
	if value < low_charge[0] or value > low_charge[1]:
		tint_progress = COLOUR_DANGER
	elif value < mid_charge[0] or value > mid_charge[1]:
		tint_progress = COLOUR_MID
	else:
		tint_progress = COLOUR_GOOD


##changes charge value
func increment_value(val: float, delta: float) -> void:
	if delta == 0.0:
		value += val
	else:
		value += val * delta
	if (value <= 0 or value >= max_charge) and has_good_charge == true:
		has_good_charge = false
		over_under_charged.emit()
	else:
		has_good_charge = true
		good_charge.emit()


func reduce_charge(reducing_value: float, delta: float) -> void:
	increment_value(-reducing_value, delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	reduce_charge(REDUCTION_RATE, delta)

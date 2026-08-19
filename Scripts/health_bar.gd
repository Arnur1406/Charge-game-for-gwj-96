extends TextureProgressBar
class_name HealthBar


@onready var charge_bar: ChargeBar = $"../../charge_margin_container/charge_bar"



const REDUCTION_RATE: float = 10

@export var max_health: int = 100
@export var start_health: int = 100
@export var mid_health: int = 40
@export var low_health: int = 20


var drain_health: bool = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.deal_damage.connect(deal_damage)
	drain_health = false
	charge_bar.good_charge.connect(good_charge)
	charge_bar.over_under_charged.connect(over_under_charged)
	max_value = max_health
	step = 0.0
	value = start_health

##called when the charge amount is good
func good_charge() -> void:
	drain_health = false

##called when the charge amount is bad
func over_under_charged() -> void:
	drain_health = true


func deal_damage(val: float, delta: float) -> void:
	increment_value(-val, delta)


func increment_value(val: float, delta: float) -> void:
	if delta == 0.0:
		value += val
	else:
		value += val * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if drain_health == true:
		value -= REDUCTION_RATE * delta
	##checks if health is drained
	if value <= 0:
		SignalHub.player_died.emit()

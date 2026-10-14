extends Node
class_name HealthSystem

# --- CÁC TÍN HIỆU (SIGNALS) ---
signal hp_changed(current_hp, max_hp)
signal died

# --- THÔNG SỐ MÁU ---
@export var max_hp: float = 100.0
var current_hp: float

func _ready():
	current_hp = max_hp
	emit_signal("hp_changed", current_hp, max_hp)

# Hàm nhận sát thương
func take_damage(amount: float) -> void:
	if current_hp <= 0:
		return
		
	current_hp = max(0.0, current_hp - amount)
	emit_signal("hp_changed", current_hp, max_hp)
	print(get_parent().name, " nhận sát thương: ", amount, " | HP còn: ", current_hp)
	
	if current_hp <= 0:
		die()

# Hàm hồi máu
func heal(amount: float) -> void:
	if current_hp <= 0:
		return
		
	current_hp = min(max_hp, current_hp + amount)
	emit_signal("hp_changed", current_hp, max_hp)
	print(get_parent().name, " được hồi máu: ", amount)

# Xử lý khi hết máu
func die() -> void:
	emit_signal("died")
	print(get_parent().name, " đã bị tiêu diệt!")

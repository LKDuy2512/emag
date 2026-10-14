extends Node3D

# File này gắn vào Mesh3D chứa hiệu ứng Vệt đỏ hình chữ nhật trên mặt đất
@export var warning_time: float = 1.5 # Thời gian cảnh báo trước khi Boss chém
@onready var red_zone_mesh = $MeshInstance3D

func _ready():
	# Ẩn vùng đỏ ban đầu
	visible = false

func show_attack_warning():
	visible = true
	# Tạo hiệu ứng nhấp nháy đỏ cảnh báo
	var tween = create_tween()
	tween.tween_property(red_zone_mesh, "modulate:a", 0.8, warning_time / 2.0)
	tween.tween_property(red_zone_mesh, "modulate:a", 0.2, warning_time / 2.0)
	
	# Hết thời gian cảnh báo -> Tung đòn và ẩn vùng đỏ
	await get_tree().create_timer(warning_time).timeout
	execute_boss_attack()

func execute_boss_attack():
	print("Boss ra chiêu chém xuống sàn!")
	visible = false

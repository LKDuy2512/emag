extends Control
class_name UIManager

# --- CÁC THÀNH PHẦN GIAO DIỆN ---
@onready var player_hp_bar = $BottomUI/PlayerHPBar
@onready var boss_hp_bar = $TopUI/BossHPBar
@onready var boss_name_label = $TopUI/BossNameLabel
@onready var floor_label = $TopUI/FloorLabel

@onready var skill_1_btn = $BottomUI/Skill1Button
@onready var skill_2_btn = $BottomUI/Skill2Button
@onready var ulti_btn = $BottomUI/UltiButton

# Cập nhật thanh máu Nhân vật
func update_player_hp(current_hp: float, max_hp: float) -> void:
	if player_hp_bar:
		player_hp_bar.max_value = max_hp
		player_hp_bar.value = current_hp

# Cập nhật thanh máu Boss
func update_boss_hp(current_hp: float, max_hp: float) -> void:
	if boss_hp_bar:
		boss_hp_bar.max_value = max_hp
		boss_hp_bar.value = current_hp

# Cập nhật số Tầng tháp hiện tại
func set_floor_info(floor_number: int, floor_name: String) -> void:
	if floor_label:
		floor_label.text = "TẦNG " + str(floor_number) + "\n" + floor_name

# Hiển thị thời gian hồi chiêu lên nút
func update_skill_cooldown(button, cd_remaining: float) -> void:
	if cd_remaining > 0:
		button.disabled = true
		button.text = str(snapped(cd_remaining, 0.1)) + "s"
	else:
		button.disabled = false
		button.text = "SẴN SÀNG"

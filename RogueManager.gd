extends Node
class_name RogueManager

# Tín hiệu khi người chọn xong 1 nâng cấp
signal card_selected(upgrade_type, value)

# Danh sách các loại nâng cấp thẻ bài
enum UpgradeType {
	INCREASE_ATK,      # Tăng sát thương vật lý
	LIGHTNING_BLADE,   # Lưỡi kiếm sét (sát thương lan)
	SHIELD_LIGHT,      # Giáp ánh sáng (lá chắn + hồi HP)
	FIRE_SLASH,        # Chém lửa (sát thương thiêu đốt)
	CRIT_CHANCE        # Tăng tỉ lệ chí mạng
}

# Cấu trúc 1 thẻ bài
class CardOption:
	var title: String
	var description: String
	var type: UpgradeType
	var value: float

	func _init(p_title: String, p_desc: String, p_type: UpgradeType, p_val: float):
		title = p_title
		description = p_desc
		type = p_type
		value = p_val

var all_cards: Array[CardOption] = []

func _ready():
	# Khởi tạo danh sách thẻ bài mẫu
	all_cards.append(CardOption.new("🔥 Chém Lửa", "Tăng 15% Sát thương Vật lý", UpgradeType.FIRE_SLASH, 0.15))
	all_cards.append(CardOption.new("⚡ Lưỡi Kiếm Sét", "Đòn đánh thường gây sát thương lan", UpgradeType.LIGHTNING_BLADE, 1.0))
	all_cards.append(CardOption.new("🛡️ Giáp Ánh Sáng", "Tạo lá chắn và hồi 20% HP", UpgradeType.SHIELD_LIGHT, 0.20))
	all_cards.append(CardOption.new("🎯 Mắt Ưng", "Tăng 10% Tỉ lệ Chí mạng", UpgradeType.CRIT_CHANCE, 0.10))
	all_cards.append(CardOption.new("⚔️ Vệ Sĩ Cuồng Nổ", "Tăng 20% Tốc độ đánh", UpgradeType.INCREASE_ATK, 0.20))

# Hàm lấy ngẫu nhiên 3 thẻ bài không trùng lặp cho người chơi chọn
func get_random_3_cards() -> Array[CardOption]:
	var shuffled = all_cards.duplicate()
	shuffled.shuffle()
	return [shuffled[0], shuffled[1], shuffled[2]]

# Chọn thẻ bài
func select_card(card: CardOption) -> void:
	print("Người chơi đã chọn thẻ: ", card.title)
	emit_signal("card_selected", card.type, card.value)

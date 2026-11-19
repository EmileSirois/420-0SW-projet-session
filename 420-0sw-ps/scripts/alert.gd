extends PanelContainer

const TOOLTIP_SCENE := preload("res://scenes/tool_tip_container.tscn")
#@onready var message := %message

var details := ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	Events.alert_requested.connect(show_alert)

#func _make_custom_tooltip(_for_text: String) -> Object:
	#var tip := TOOLTIP_SCENE.instantiate()
	#tip.details = details   # on passe la donnée, rien d'autre
	#tip.update()
	#return tip

func show_alert(text: String):
	visible = true
	tooltip_text = text
	pass

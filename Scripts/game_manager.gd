extends Node

@export var stateLabel : Label
@export var hpLabel : Label
@export var gameOverScreen : ColorRect
func updateLabel(text):
	if text:
		stateLabel.text = "State: " + str(text)
		
func updateHP(text):
	if text:
		hpLabel.text = "HP: " + str(text)
func updateGameOver():
	gameOverScreen.visible = true

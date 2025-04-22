extends Node2D

signal start_text

var shown_axe = false
var shown_double = false
var shown_hover = false
var shown_tummy = false
var shown_window = false
var shown_doctor = false

var people = ["double", "hover", "tummy", "window", "doctor"]

func _ready():
	$canvas/title.show()


func _on_dialogue_box_rescued(ind):
	people.pop(ind)


func _on_virus_timer_timeout():
	game_over()
	

func game_over():
	$canvas/game_over.show()
	$canvas/game_over/lost.show()
	if len(people) > 0:
		$canvas/game_over/lost.text = "you missed "
		for i in range(len(people)):
			$canvas/game_over/lost.text += people[i] + ", "
		$canvas/game_over/lost.text += " :((("
	else:
		$canvas/game_over/lost.text = "you ran out of time :((("


func _on_title_start():
	$canvas/title.hide()
	$canvas/timer_label/virus_timer.start()
	

func _on_axe_man_start_convo(body):
	if body is CharacterBody2D && !shown_axe:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.axeman()
		shown_axe = true


func _on_double_man_start_convo(body):
	if body is CharacterBody2D && !shown_double:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.doubleman()
		shown_double = true


func _on_hover_man_start_convo(body):
	if body is CharacterBody2D && !shown_hover:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.hoverman()
		shown_hover = true


func _on_tummy_man_start_convo(body):
	if body is CharacterBody2D && !shown_tummy:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.tummyhurtman()
		shown_tummy = true


func _on_window_man_start_convo(body):
	if body is CharacterBody2D && !shown_window:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.windowman()
		shown_window = true


func _on_doctor_start_convo(body):
	if body is CharacterBody2D && !shown_doctor:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.doctor()
		shown_doctor = true

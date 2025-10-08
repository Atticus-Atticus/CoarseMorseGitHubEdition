extends Node2D

@onready var light = $Icon
@onready var notpressed = $Up
@onready var pressed = $Down
@onready var beep = $AudioStreamPlayer
@onready var outputmessage = $Output
@onready var textoutput = $Output2
@onready var alarm = $Alarm
@onready var money = $money

var time_of_day: int
var timer : Array[float] = [10, 100, 0, 0, 0]
var goals_array : Array[String] = ["","","","",""]
var goals_resistance : Array[bool] = [false,false,false,false,false]
var firstday : Array[String] = ["4TH TO EAST","WTHR RAIN","RMMBR TRGGR DSPLN","10TH CAN BREAK","DONT WASTE FUEL","NO CURRENT OPPS","5 O CLOCK CHANGE","SAVE OR CUTS","NO FIGHTING","GNRL ON LEAVE","NO WARNINGS"]
var firstday_res : Array[bool] = [false,false,false,false,false,false,false,false,false,false,false,false]
var goal_wordz = ""
var goal_position : int
var pos_in_goal : int
var output_message = str
var morse = false
var time: float = 0
var timebetween: float = 0
var difficulty: float = 2
var fading = true
var fading_timer: int
var fad_modulation = 1
#var day = 1 moved to Globals.gd
var foundspot = false
var rng = RandomNumberGenerator.new()
var transferpos : int
var cooldown = 30.0
var morse_code_translator : Dictionary ={
	"A" = " ● ━",
	"B" = " ━ ● ● ●",
	"C" = " ━ ● ━ ●",
	"D" = " ━ ● ●",
	"E" = " ●",
	"F" = " ● ● ━ ●",
	"G" = " ━ ━ ●",
	"H" = " ● ● ● ●",
	"I" = " ● ●",
	"J" = " ● ━ ━ ━",
	"K" = " ━ ● ━",
	"L" = " ● ━ ● ●",
	"M" = " ━ ━",
	"N" = " ━ ●",
	"O" = " ━ ━ ━",
	"P" = " ● ━ ━ ●",
	"Q" = " ━ ━ ● ━",
	"R" = " ● ━ ●",
	"S" = " ● ● ●",
	"T" = " ━",
	"U" = " ● ● ━",
	"V" = " ● ● ● ━",
	"W" = " ● ━ ━",
	"X" = " ━ ● ● ━",
	"Y" = " ━ ● ━ ━",
	"Z" = " ━ ━ ●",
	"1" = " ● ━ ━ ━ ━",
	"2" = " ● ● ━ ━ ━",
	"3" = " ● ● ● ━ ━",
	"4" = " ● ● ● ● ━",
	"5" = " ● ● ● ● ●",
	"6" = " ━ ● ● ● ●",
	"7" = " ━ ━ ● ● ●",
	"8" = " ━ ━ ━ ● ●",
	"9" = " ━ ━ ━ ━ ●",
	"0" = " ━ ━ ━ ━ ━",
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.rent += 5
	Globals.money - Globals.rent
	$Background.modulate = Color(0,0,0)
	
	light.hide()
	pressed.hide()

	if Globals.day == 2:
		firstday = ["5B TO SE","7H TO NW","8B WAIT","2N WAIT","AWAIT ORDERS","MILL EXERSIZES","MEDIUM ALERT","1ST TO EXIME","PAY WILL ARRIVE","RMBR NEW POLICY"]
		firstday_res = [false,false,false,false,false,false,false,false,false,false]

	if Globals.day == 3:
		firstday = ["WAR DECLARED","HIGH ALERT","UNITS ENGAGED","STAND UNTIL ORDERS","MORAL LOW","GNRL E E REMOVED","AVOID ENGAGEMNT","WAR DECLARED","WAR DECLARED","DFND THE HOME","HIGH ALERT","5N TO NE","7J TO SW","8N TO SE","2N WAIT","EASTER EGG"]
		firstday_res = [false,false,false,false,true,true,true,false,false,false,false,true,false,false,true,true]

	if Globals.day == 4:
		firstday = ["3L HOLD POS","5F ADVANCE","SURE VICTORY","9A TO WEST FRONT","ADVANCE TO GROZNA","ADVANCE TO LEVZI","KEEP ADVANCE","ENGAGE ALL FORCE","HIGH MORAL","2D DFND","6D AVANCE","MORAL LOW","AZXYN IES","GWA KS OELE","KO L N ADE"]
		firstday_res = [true,false,false,true,false,false,false,false,false,false,false,true,true,true,true,true,true]

	if Globals.day == 5:
		firstday = ["RSSTNCE NOT TOL","RAPID ADVANCE","SCORCH EARTH","ALL UNTS PUSH","SURE VICTORY","SURE VICTORY","2D PUSH","WARNING AMBUSHES","GUERRILLAS FOUND","RAIZE GROZNA","NO TOLERANCE","ALL UNITS PUSH","MWAD WASL OBIO","OKOL CLA PO","HOLD POSITION","LOW MORAL","GNRL M L REMOVED","1ST STAND DOWN"]
		firstday_res = [false,false,false,false,false,false,false,true,false,false,false,false,true,true,true,true,true,true,true,true,true,true,true]

	if Globals.day == 6:
		firstday = ["EXTMINATE REBELS","KEEP PUSHING","MORAL HIGH","SURE VICTORY","SURE VICTORY","SURE VICTORY","HOLD GROZNA","HOLD EXIME","FOR THE HOME","NO STEP BACK","WE ARE WINNING","VICTORY ASSURED","TRNSFR FRM LEVZI","HIGH MORAL","LOW LOSSES","AWAIT ORDERS","EXIME WILL HOLD","LEVZI EVACUATED","PURGE DISSIDENTS","MORAL LOW","RETREAT","ENEMY AT TRASIVE","HIGH DESSERTION","AWDJ MK OAL","AMN YY UYO","MCNAP I JJNAWL","NAOLCS EOOP"]
		firstday_res = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true]

	if Globals.day > 6:
		firstday = ["5B TO SE","7H TO NW","8B WAIT","2N WAIT","AWAIT ORDERS","MILL EXERSIZES","MEDIUM ALERT","RSSTNCE NOT TOL","RAPID ADVANCE","SCORCH EARTH","ALL UNTS PUSH","SURE VICTORY","SURE VICTORY","2D PUSH","WARNING AMBUSHES","GUERRILLAS FOUND","RAIZE GROZNA","NO TOLERANCE","ALL UNITS PUSH","WAR DECLARED","HIGH ALERT","UNITS ENGAGED","STAND UNTIL ORDERS","AVOID ENGAGEMNT","WAR DECLARED","WAR DECLARED","DFND THE HOME","HIGH ALERT","5N TO NE","7J TO SW","8N TO SE","2N WAIT"]
		firstday_res = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	money.text = str("£",Globals.money)


	if not fading:
		time_of_day += 1
	
	if time_of_day == 50:
		cooldown = 3
	
	
	
	cooldown -= 3- difficulty
	if cooldown == 0 and not fading:
		foundspot = false
		cooldown = 1000.0 * difficulty
		for I in 5:
			if goals_array[I] =="" and not foundspot:
				foundspot = true
				transferpos = round(rng.randf_range(0, firstday.size() - 1))
				goals_array[I] = firstday[transferpos]
				goals_resistance[I] = firstday_res[transferpos]
				timer[I]= round(rng.randf_range(27*difficulty,45*difficulty))
				if I== 0 and not goals_resistance[I]:
					$Array1.set_meta("Inview",true)
					$Array1/Label.text = goals_array[I]
				elif I== 1 and not goals_resistance[I]:
					$Array2.set_meta("Inview",true)
					$Array2/Label.text = goals_array[I]
				elif I== 2 and not goals_resistance[I]:
					$Array3.set_meta("Inview",true)
					$Array3/Label.text = goals_array[I]
				elif I== 3 and not goals_resistance[I]:
					$Array4.set_meta("Inview",true)
					$Array4/Label.text = goals_array[I]
				elif I== 4 and not goals_resistance[I]:
					$Array5.set_meta("Inview",true)
					$Array5/Label.text = goals_array[I]
				elif I== 0:
					$"Resist Box1".set_meta("Inview",true)
					$"Resist Box1/Label".text = goals_array[I]
				elif I== 1:
					$"Resist Box2".set_meta("Inview",true)
					$"Resist Box2/Label".text = goals_array[I]
				elif I== 2:
					$"Resist Box3".set_meta("Inview",true)
					$"Resist Box3/Label".text = goals_array[I]
				elif I== 3:
					$"Resist Box4".set_meta("Inview",true)
					$"Resist Box4/Label".text = goals_array[I]
				elif I== 4:
					$"Resist Box5".set_meta("Inview",true)
					$"Resist Box5/Label".text = goals_array[I]


#timers
	timer[0] -= delta
	$"Resist Box1/Label2".text = str(round(timer[0]))
	$Array1/Label2.text = str(round(timer[0]))
	if round(timer[0]* 10) == 0:
		if goals_resistance[0] == true:
			$"Resist Box1".set_meta("Inview",false)
		else:
			$Array1.set_meta("Inview",false)
		if goals_array[0] == goal_wordz:
			goal_wordz = ""
			outputmessage.text = ""
			textoutput.text = ""
			pos_in_goal = 0
		goals_array[0] = ""

	timer[1] -= delta
	$"Resist Box2/Label2".text = str(round(timer[1]))
	$Array2/Label2.text = str(round(timer[1]))
	if round(timer[1]* 10) == 0:
		if goals_resistance[1] == true:
			$"Resist Box2".set_meta("Inview",false)
		else:
			$Array2.set_meta("Inview",false)
		if goals_array[1] == goal_wordz:
			goal_wordz = ""
			outputmessage.text = ""
			textoutput.text = ""
			pos_in_goal = 0
		goals_array[1] = ""

	timer[2] -= delta
	$"Resist Box3/Label2".text = str(round(timer[2]))
	$Array3/Label2.text = str(round(timer[2]))
	if round(timer[2]* 10) == 0:
		if goals_resistance[2] == true:
			$"Resist Box3".set_meta("Inview",false)
		else:
			$Array3.set_meta("Inview",false)
		if goals_array[2] == goal_wordz:
			goal_wordz = ""
			outputmessage.text = ""
			textoutput.text = ""
			pos_in_goal = 0
		goals_array[2] = ""

	timer[3] -= delta
	$"Resist Box4/Label2".text = str(round(timer[3]))
	$Array4/Label2.text = str(round(timer[3]))
	if round(timer[3]* 10) == 0:
		if goals_resistance[4] == true:
			$"Resist Box4".set_meta("Inview",false)
		else:
			$Array4.set_meta("Inview",false)
		if goals_array[3] == goal_wordz:
			goal_wordz = ""
			outputmessage.text = ""
			textoutput.text = ""
			pos_in_goal = 0
		goals_array[3] = ""

	timer[4] -= delta
	$"Resist Box5/Label2".text = str(round(timer[4]))
	$Array5/Label2.text = str(round(timer[4]))
	if round(timer[4]* 10) == 0:
		if goals_resistance[4] == true:
			$"Resist Box5".set_meta("Inview",false)
		else:
			$Array5.set_meta("Inview",false)
		if goals_array[4] == goal_wordz:
			goal_wordz = ""
			outputmessage.text = ""
			textoutput.text = ""
			pos_in_goal = 0
		goals_array[4] = ""


	if timebetween != 0 :
		timebetween += 0.01
	if timebetween > difficulty :
		if goal_wordz == "":
			for i in 5:
				if goals_array[i] != "":
					if outputmessage.text == morse_code_translator[goals_array[i][0]]:
						goal_wordz = goals_array[i]
						print(goal_wordz)
						goal_position = i
						textoutput.text = ""
		if fading and outputmessage.text == " ━ ● ━ ━ ● ━ ● ━ ━ ● ●":
			$Timer.start()
			fading = false
			fading_timer = 0
			$Sprite2D2.set_meta("Inview",false)
			fading_timer = 0

		if goal_wordz != "":
			if outputmessage.text == morse_code_translator[goal_wordz[pos_in_goal]] :
				textoutput.text  += goal_wordz[pos_in_goal]
				outputmessage.text = ""
				pos_in_goal += 1
				if goals_resistance[0] != true:
					Globals.money += 1
				if pos_in_goal == goal_wordz.length() :
					goal_wordz = ""
					pos_in_goal = 0
					if goals_resistance[0] != true:
						Globals.money += 10
						money.text = str(Globals.money)
					goals_array[goal_position] = ""
					if goal_position == 0:
						$Array1.hide()
					if goal_position == 1:
						$Array2.hide()
					if goal_position == 2:
						$Array3.hide()
					if goal_position == 3:
						$Array4.hide()
					if goal_position == 4:
						$Array5.hide()
				elif goal_wordz[pos_in_goal] == " ":
					textoutput.text += " "
					pos_in_goal += 1
				
			else :
				outputmessage.text = ""
		else :
			outputmessage.text = ""
		
		#outputmessage.text +=  "  "
		
		
		timebetween = 0
		
	if fading and fading_timer == 10 and fad_modulation > 0 :
		$Background.modulate += Color(-.01,-.01,-.01)
		fading_timer = 0
		fad_modulation -= 1
	elif not fading and fading_timer == 10 and fad_modulation < 100 :
		$Background.modulate += Color(.01,.01,.01)
		fading_timer = 0
		fad_modulation += 1
	fading_timer += 1

	#if Input.is_action_just_pressed("debug"):
		#Engine.time_scale += 1

func _on_pressed() -> void:
	pass



func _on_button_down() -> void:
	light.show()
	notpressed.hide()
	pressed.show()
	beep.play()
	morse = true
	time = Time.get_ticks_msec() / 1000.0

func _on_button_up() -> void:
	light.hide()
	notpressed.show()
	pressed.hide()
	beep.stop()
	morse = false
	var release_time = Time.get_ticks_msec() / 1000.0
	var time_passed = release_time - time
	if time_passed > 0 and time_passed < .2 :
		outputmessage.text += " ●"
	elif time_passed < 4 :
		outputmessage.text += " ━"
	else:
		outputmessage.text            +=  " ?"
	timebetween = 0.001
	


func _on_timer_timeout() -> void:
	alarm.play()
	await get_tree().create_timer(2.7).timeout
	get_tree().change_scene_to_file("res://end_of_day_scene.tscn")

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=MCA.exe
#AutoIt3Wrapper_Outfile_x64=MCA_64.exe
#AutoIt3Wrapper_Compression=0
#AutoIt3Wrapper_Compile_Both=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;THIS WAS CREATED BY BULLTANK. ITS FREE. SOURCE IS INCLUDED. FEEL FREE TO DO WHATEVER WITH IT, JUST DON'T SELL IT..
;I WOULD POST LICENSE AGREEMENTS, BUT IF YOU'RE A JERK, YOU'LL IGNORE THEM ANYWAYS


;Includes from AutoIT to allow functions to run
;These are standard libraries included with AutoIT
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

;Setting the hotkeys that are used and displayed on the GUI
;These are configured from the config.ini file and loaded here
Global $hotkey_sieve = IniRead("config.ini","HOTKEYS","HOTKEY_SIEVE","z")
Global $hotkey_cobble_start = IniRead("config.ini","HOTKEYS","HOTKEY_COBBLE_START","x")
Global $hotkey_cobble_stop = IniRead("config.ini","HOTKEYS","HOTKEY_COBBLE_STOP","q")
Global $hotkey_custom = IniRead("config.ini","HOTKEYS","HOTKEY_CUSTOM","c")
Global $emergency_stop = IniRead("config.ini","HOTKEYS","HOTKEY_EMERGENCY","`")

;Setting of the actual hotkeys as defined by config.ini
HotKeySet($hotkey_sieve,"StartSieve")
HotKeySet($hotkey_cobble_start,"StartCobble")
HotKeySet($hotkey_cobble_stop,"StopCobble")
HotKeySet($hotkey_custom,"StartCustom")
HotKeySet($emergency_stop,"EmergencyStop")

;For users who switch left/right mouse button
;These are configured from the config.ini file and loaded here
Global $left_mouse = IniRead("config.ini","GLOBAL","LEFT_MOUSE_BUTTON","left")
Global $right_mouse = IniRead("config.ini","GLOBAL","RIGHT_MOUSE_BUTTON","right")

;Setting AutoIT options for mouse clicking and key sending delays.
;These are configured from the config.ini file and loaded here
AutoItSetOption("MouseClickDelay",IniRead("config.ini","GLOBAL TIMERS","MOUSE_CLICK_DELAY",0))
AutoItSetOption("MouseClickDownDelay",IniRead("config.ini","GLOBAL TIMERS","MOUSE_CLICK_DOWN_DELAY ",0))
AutoItSetOption("SendKeyDelay",IniRead("config.ini","GLOBAL TIMERS","SEND_KEY_DELAY ",0))
AutoItSetOption("SendKeyDownDelay",IniRead("config.ini","GLOBAL TIMERS","SEND_KEY_DOWN_DELAY ",0))

;Create the GUI for the user
$mca = GUICreate("MineClickAid", 609, 423, 520, 284)

;$pic = GUICtrlCreatePic(, 8, 8, 305, 167)

;Populating the GUI
GUICtrlCreateLabel("MineClickAid v0.1b", 336, 16, 252, 43)
	GUICtrlSetFont(-1, 24, 400, 0, "Calibri")

GUICtrlCreateLabel("A Minecraft auto clicker aid for minecraft.", 336, 72, 248, 17)
GUICtrlCreateLabel("This auto clicker software was developed by Bulltank.", 336, 92, 255, 17)
GUICtrlCreateLabel("The source code should have been included.", 336, 112, 255, 17)
GUICtrlCreateLabel("This software should have been free.", 336, 132, 255, 17)

;Auto Sieve GUI
GUICtrlCreateGroup("Auto Sieve", 24, 200, 177, 201)

	;GUICtrlCreateLabel("What are you going to sieve?", 40, 232, 143, 17)
	;$sf_sieve_object = GUICtrlCreateCombo("Gravel", 40, 256, 137, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	;GUICtrlSetData(-1, "Sand|Dust|Dirt|Soul Sand")

	GUICtrlCreateLabel("How many units?", 40, 232, 85, 17)
	$sf_sieve_units = GUICtrlCreateInput(IniRead("config.ini","GUI","GUI_DEFAULT_SIEVE_UNITS",0), 40, 256, 57, 21)

	GUICtrlCreateLabel("Press " & $hotkey_sieve & " when aiming at the sieve", 32, 352, 160, 17)
	GUICtrlCreateLabel("to begin auto sieving.", 56, 376, 105, 17)

;Cobble Collecting GUI
GUICtrlCreateGroup("Cobblestone Collecting", 216, 200, 177, 201)
	GUICtrlCreateLabel("This will begin to mine cobblestone", 221, 240, 168, 17)
	GUICtrlCreateLabel("before you have an auto generator", 221, 264, 168, 17)
	GUICtrlCreateLabel("Press " & $hotkey_cobble_start & " to start and " & $hotkey_cobble_stop & " to stop", 232, 368, 142, 17)

	;$sf_cc_speed = GUICtrlCreateCombo("Normal", 232, 312, 145, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	;GUICtrlSetData(-1, "Fast")

;Custom Auto-Clicker GUI
GUICtrlCreateGroup("Custom Auto-Clicker", 408, 200, 185, 201)

	$sf_cac_left = GUICtrlCreateRadio("Left Click", 416, 224, 113, 17)
		GUICtrlSetState(-1, $GUI_CHECKED)
	$sf_cac_right = GUICtrlCreateRadio("Right Click", 416, 248, 113, 17)
	$sf_cac_middle = GUICtrlCreateRadio("Middle Click", 416, 272, 113, 17)
	$sf_cac_other = GUICtrlCreateRadio("Other", 416, 296, 70, 17)
		$sf_cac_other_input = GUICtrlCreateInput("", 496, 294, 80, 21)

	GUICtrlCreateLabel("Click Delay (ms)", 416, 322, 79, 17)
	$sf_cac_clickdelay = GUICtrlCreateInput(IniRead("config.ini","GUI","GUI_DEFAULT_CLICK_MS_DELAY",300), 424, 340, 57, 21)

	GUICtrlCreateLabel("# Clicks", 528, 322, 42, 17)
	$sf_cac_clicks = GUICtrlCreateInput(IniRead("config.ini","GUI","GUI_DEFAULT_CLICKS ",100), 520, 340, 57, 21)

	GUICtrlCreateLabel("Press " & $hotkey_custom & " to start", 464, 376, 75, 17)

;Command to display the GUI to the user once it is built
GUISetState(@SW_SHOW)

;Loop to run the GUI
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			;Close this software with the red X from Windows
			Exit

	EndSwitch
WEnd

;Auto Sieve
Func StartSieve()

	;Dim $object = GUICtrlRead($sf_sieve_object)
	Dim $units = GUICtrlRead($sf_sieve_units)

	;Load values from config.ini for speed, clicks and delays
	Dim $sieve_clicks = IniRead("config.ini","SIEVE","SIEVE_CLICKS",15) ;15 right clicks per object
	Dim $sieve_stack_size = IniRead("config.ini","SIEVE","SIEVE_STACK_SIZE ",64)
	Dim $sieve_click_delay = IniRead("config.ini","SIEVE","SIEVE_CLICK_DELAY",170)
	Dim $sieve_reload_delay = IniRead("config.ini","SIEVE","SIEVE_RELOAD_DELAY",200)
	Dim $sieve_stack_reload_delay = IniRead("config.ini","SIEVE","SIEVE_STACK_RELOAD_DELAY ",1500)

	$i = 0
	$n = 0
	;For each unit ($units) defined by the user in the GUI we run a loop of the same thing
	While $i <> $units

		$z = 0
		;The number of clicks to sieve 1 unit
		;We loop the action of right clicking with a short delay in between
		;Delay is defined in config
		While $z <> $sieve_clicks
			MouseClick($right_mouse)
			Sleep($sieve_click_delay)
			$z = $z+1
		WEnd

		;Short delay as we load a new unit in the sieve
		Sleep($sieve_reload_delay)

		$i = $i+1
		$n = $n+1

		;If we completed a stack, there is a delay between inventory tweaks replaces the item in our inventory
		;This delay is defined in the config
		If $n = $sieve_stack_size Then
			$n = 0
			Sleep($sieve_stack_reload_delay)
		EndIf

	WEnd

EndFunc

Func StartCobble()
	;The quickest method for mining cobblestone is simply holding the mouse button down.
	;No matter how fast we spam click ,the delay kills the mining
	MouseDown($left_mouse)
EndFunc

Func StopCobble()
	;Lift the mouse button to stop mining
	MouseUp($left_mouse)
EndFunc

Func StartCustom()

	;Define the possible buttons being pressed
	Dim $button_left = GUICtrlRead($sf_cac_left)
	Dim $button_right = GUICtrlRead($sf_cac_right)
	Dim $button_middle = GUICtrlRead($sf_cac_middle)
	Dim $button_other = GUICtrlRead($sf_cac_other)
	Dim $button_other_input = GUICtrlRead($sf_cac_other_input)

	;If the delay is empty we set to 100.
	Dim $click_count_delay = GUICtrlRead($sf_cac_clickdelay)
	If $click_count_delay = "" Then
		$click_count_delay = 100
	EndIf

	;If the click count is empty we set to 1
	Dim $click_count = GUICtrlRead($sf_cac_clicks)
	If $click_count = "" Then
		$click_count = 1
	EndIf

	;We are now trying to figure out which button needs to be pressed
	If $button_left = 1 OR $button_right = 1 OR $button_middle = 1 Then

		If $button_left = 1 Then
			$mouse_down = $left_mouse ;Left
		ElseIf $button_right = 1 Then
			$mouse_down = $right_mouse ;Right
		Else
			$mouse_down = "middle" ;Middle
		EndIf

		;We now run a loop of the mouse button being pressed as defined by the user
		$i = 0
		While $i <> $click_count
			MouseClick($mouse_down)
			Sleep($click_count_delay)
			$i = $i + 1
		WEnd

	Else

		;AutoIT uses different command for mouse clicking or button pressing.
		;If not a mouse click, this is the same loop, but with a key press.
		$i = 0
		While $i <> $click_count
			Send($button_other_input)
			Sleep($click_count_delay)
			$i = $i + 1
		WEnd

	EndIf

EndFunc

Func EmergencyStop()
	;Shuts the software down stopping all loops.
	Exit
EndFunc

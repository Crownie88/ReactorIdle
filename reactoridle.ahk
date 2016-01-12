Gui, Add, Text,, Map:
Gui, Add, Text,, Setting:
Gui Add, ComboBox, vMap ym altsubmit, Island|Village|Region|City|Single heat cell|Metropolis|Mainland|Continent
Gui Add, ComboBox, vSetting altsubmit, 1:1|2:1|3:1|4:1|Full Research
Gui, Add, Button, default, OK
return

ClickGenerator(){
	; X and Y of generator to select
	; Use Autohotkeys Window Spy to see the relative coords.

	; Gen 2
	x=55
	y=272
	DoClick(x, y)
}

ClickHeatSource(){
	; X and Y of heatsource to select
	; Use Autohotkeys Window Spy to see the relative coords.

	;Wind turbine
	x=21 ; 191
	y=237
	DoClick(x, y)
}

ClickOffice(){
	; X and Y of Office to select
	; Use Autohotkeys Window Spy to see the relative coords.

	;Large Office
	x=123
	y=412
	DoClick(x, y)
}

ClickResearch(){
	; X and Y of research center to select
	; Use Autohotkeys Window Spy to see the relative coords.

	; Advanced research center
	x=55
	y=447
	DoClick(x, y)
}

1::
	WinGetTitle, Title, A
	if InStr(Title, "Reactor game"){
		Gui Show,autosize center,Select Setting
	}
return

ButtonOK:
	Gui, Submit
	map=%Map%
	setting=%Setting%
	if (setting < 5){
		File := GetLayout(map, setting)
		FillMap(File)
	}else{
		FullResearch()
	}
	MsgBox Mapped filled according to definition.
return

DoClick(x,y){
	MouseMove, x, y
	click
}

ClickComponent(comp){
	if (comp = "G"){
		ClickGenerator()
	}else if (comp = "H"){
		ClickHeatSource()
	}else if (comp = "O"){
		ClickOffice()
	}else if (comp = "R"){
		ClickResearch()
	}
}

ClickOnMap(x, y){	
	; MsgBox "here"
	xOs = 324
	yOs = 215
	while x > 0{
		xOs+=25
		x--
	}
	; MsgBox X Done
	while y > 0{
		yOs+=25
		y--
	}
	DoClick(xOs, yOs)
}

FullResearch(){
	ClickResearch()
	y=0
	while y < 15{
		x=0
		while x < 22{
			ClickOnMap(x,y)
			x++
		}
		y++
	}
}

FillMap(File)
{
	Array := Object()
	Loop, Read, %File%
	{
		Array.Insert(A_LoopReadLine)
	}
	for index, row in Array
	{
		Line := StrSplit(row, ",")
		if (Line.Length() = 3){
			ClickComponent(Line[1])
			ClickOnMap(Line[2], Line[3])
		}else{
			ClickOnMap(Line[1], Line[2])
		}
	}
}

GetLayout(map, setting)
{
	if(map = 1){
		; Island
		return % "island" setting ".txt"
	}else if (map = 2){
		; Village
		return % "village" setting ".txt"
	}else if (map = 3){
		; Region
		return % "region" setting ".txt"
	}else if (map = 4){
		; City
		return % "city" setting ".txt"
	}else if (map = 5){
		; Single heat cell
		return % "signleheatcell" setting ".txt"
	}else if (map = 6){
		; Metropolis
		return % "metropolis" setting ".txt"
	}else if (map = 7){
		; Mainland
		return % "mainland" setting ".txt"
	}else if (map = 8){
		; Continent
		return % "continent" setting ".txt"
	}else{
		MsgBox No map selected
	}
}
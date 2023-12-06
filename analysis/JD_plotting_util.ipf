#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3				// Use modern global access method and strict wave access
#pragma DefaultTab={3,20,4}		// Set default tab width in Igor Pro 9 and later

Menu "Graph"
	"Close All Graphs/9", CloseAllGraphs()
End

Function CloseAllGraphs([string no_close_graphs])
	no_close_graphs = selectString(paramisdefault(no_close_graphs), no_close_graphs, "")
	String name
	
	variable num_open_graph = ItemsInList(no_close_graphs, ";")
	variable i
	string no_close_graph
	variable count_no_close = 0
	variable to_close = 1
	variable num_graphs = num_open_graphs()
	
	
	do
		to_close = 1
		name = WinName(0,1) // name of the front graph
		
		for (i=0;i<num_open_graph;i+=1)
			no_close_graph = stringfromlist(i, no_close_graphs)
			if (CmpStr(no_close_graph, name) == 0)
				DoWindow/B $name
				count_no_close += 1
				to_close = 0
				continue
			endif
		endfor 
		
		if (strlen(name) == 0 || num_graphs <= num_open_graph || count_no_close > num_open_graph)
			break // all done
		endif
		if (to_close == 1)
			DoWindow/K $name // Close the graph
		endif
	while(1)
End



function num_open_graphs()
	variable i
	string start_graph_name, name
	
	start_graph_name = WinName(0,1)
	variable count = 1
	DoWindow/B $start_graph_name
	
	do
		name = WinName(0,1)
		
		if (cmpstr(name, start_graph_name) == 0)
			return count
			break
		endif
		count += 1
		
		DoWindow/B $name
		
	while(1)

end


function print_graph_names()
	variable i
	string name
	
	variable num_graphs = num_open_graphs()
	
	for (i=0;i<num_graphs;i+=1)
		name = WinName(0,1)
		
		print name
		DoWindow/B $name
	
	endfor

end


Function AddLegend(wav,param)
    wave wav        
    string param 
    string graphName
    
        graphName = WinName(0, 1)   // Top graph
    
    
    String list = TraceNameList(graphName, ";", 1)
    String legendText = ""
    Variable numItems = ItemsInList(list)
    Variable i
    for(i=0; i<numItems; i+=1)
        String item = StringFromList(i, list)+"--"+param+num2str(wav[i])
//        if (CmpStr(item,"wave1") == 0)
//            continue            // Skip this trace
//        endif
        String itemText
        sprintf itemText, "\\s(%s) %s", item, item
        if (i > 0)
            legendText += "\r"      // Add CR
        endif
        legendText += itemText
    endfor
    Legend/K/N=text0
    Legend/C/N=MyLegend/W=$graphName legendText
    Legend/C/N=text0/J/A=MT/E=0
End

	string wvname;wvname=stringfromlist(0,imagenamelist("",";"));TextBox/C/N=text1/F=0/A=MT/E wvname


//
//function/wave DiffWave(w, [numpts])
//	wave w
//	variable numpts
//	
//	numpts = paramisdefault(numpts) ? 150 : numpts
//	
//	duplicate/o w, tempwave
//	print dimsize(w, 0)
//	print ceil(dimsize(w,0)/numpts)
//	resample/DIM=0 /down=(ceil(dimsize(w,0)/numpts)) tempwave
//	differentiate/DIM=0 tempwave	
//	return tempwave
//end
//
//
//
//function DisplayMultiple(datnums, name_of_wave, [diff, x_label, y_label])
//// Plots data from each dat on same axes... Will differentiate first if diff = 1
//	wave datnums
//	string name_of_wave, x_label, y_label
//	variable diff
//
//	if (paramisDefault(x_label))
//		struct ScanVars S
//		scv_getLastScanVars(S)   
//		x_label = S.x_label
//	endif
//	if (paramisDefault(y_label))
//		struct ScanVars S2
//		scv_getLastScanVars(S2)   
//		y_label = S2.y_label
//	endif
//
////	x_label = selectstring(paramisdefault(x_label), x_label, "")
////	y_label = selectstring(paramisdefault(y_label), y_label, "")
//
//	string window_name = "test"
//	sprintf window_name, "Dats%dto%d", datnums[0], datnums[numpnts(datnums)-1]
//	dowindow/k $window_name
//	display/N=$window_name
//	TextBox/W=$window_name/C/N=textid/A=LT/X=1.00/Y=1.00/E=2 window_name	
//	
//	
//	variable i = 0, datnum
//	string wn
//	string tempwn
//	for(i=0; i < numpnts(datnums); i++)
//		datnum = datnums[i]
//		sprintf wn, "dat%d%s", datnum, name_of_wave
//		sprintf tempwn, "tempwave_%s", wn
//		duplicate/o $wn, $tempwn
//		if (diff == 1)
//			wave tempwave = diffwave($tempwn)
//			duplicate /o tempwave $tempwn
//			wave tempwave = $tempwn
//
//		else 
//			wave tempwave = $tempwn
//		endif
//		appendimage/W=$window_name tempwave
//		ModifyImage/W=$window_name $tempwn ctab= {*,*,VioletOrangeYellow,0}
//	endfor
//	Label left, y_label
//	Label bottom, x_label
//
//end


function displayplot2D(start, endnum, whichdat,[delta,xnum, shiftx, shifty])
	variable start, endnum
	string whichdat
	variable delta, xnum, shiftx, shifty
	if(paramisdefault(delta))
		delta=1
	endif
	if(delta==0)
		abort
	endif

	if(paramisdefault(shiftx))
		shiftx=0
	endif
	if(paramisdefault(shifty))
		shifty=0
	endif
		
	variable i=0, totoffx=0, totoffy=0
	string st
	//udh5()
	Display /W=(35,53,960,830)
	i=start
	do
		st="dat"+num2str(i)+whichdat
		appendtograph $st
		wavestats /q $st
		totoffx=shiftx*mod((i-start)/delta,xnum)
		totoffy=shifty*floor((i-start)/delta/xnum)-v_avg
		ModifyGraph offset($st)={totoffx,totoffy}
		i+=delta
	while (i<=endnum)
	makecolorful()
	legend
	Legend/C/N=text0/J/A=RC/E

end

function displayplot(start, endnum,whichdat,[delta,shiftx, shifty])
	variable start, endnum
	string whichdat
	variable delta, shiftx, shifty
	if(paramisdefault(delta))
		delta=1
	endif
	if(delta==0)
		abort
	endif

	if(paramisdefault(shiftx))
		shiftx=0
	endif
	if(paramisdefault(shifty))
		shifty=0
	endif
		
	variable i=0, totoffx=0, totoffy=0
	string st
	//udh5()
	Display /W=(35,53,960,830)
	i=start
	do
		st="dat"+num2str(i)+whichdat
		appendtograph $st
		ModifyGraph offset($st)={totoffx,totoffy}
		totoffx=totoffx+shiftx
		totoffy=totoffy+shifty
		i+=delta
	while (i<=endnum)
	makecolorful()
	legend
	Legend/C/N=text0/J/A=RC/E

end

function makecolorful([rev, nlines])
	variable rev, nlines
	variable num=0, index=0,colorindex
	string tracename
	string list=tracenamelist("",";",1)
	colortab2wave rainbow
	wave M_colors
	variable n=dimsize(M_colors,0), group
	do
		tracename=stringfromlist(index, list)
		if(strlen(tracename)==0)
			break
		endif
		index+=1
	while(1)
	num=index-1
	if( !ParamIsDefault(nlines))
		group=index/nlines
	endif
	index=0
	do
		tracename=stringfromlist(index, list)
		if( ParamIsDefault(nlines))
			if( ParamIsDefault(rev))
				colorindex=round(n*index/num)
			else
				colorindex=round(n*(num-index)/num)
			endif
		else
			if( ParamIsDefault(rev))
				colorindex=round(n*ceil((index+1)/nlines)/group)
			else
				colorindex=round(n*(group-ceil((index+1)/nlines))/group)
			endif
		endif
		if(colorindex>99)
			colorindex=99
		endif
		ModifyGraph rgb($tracename)=(M_colors[colorindex][0],M_colors[colorindex][1],M_colors[colorindex][2])
		index+=1
	while(index<=num)

end


Function QuickColorSpectrum2()                            // colors traces with 12 different colors
	String Traces    = TraceNameList("",";",1)               // get all the traces from the graph
	Variable Items   = ItemsInList(Traces)                   // count the traces
	Make/FREE/N=(11,3) colors = {{65280,0,0}, {65280,43520,0}, {0,65280,0}, {0,52224,0}, {0,65280,65280}, {0,43520,65280}, {0,15872,65280}, {65280,16384,55552}, {36864,14592,58880}, {0,0,0},{26112,26112,26112}}
	Variable i
	for (i = 0; i <DimSize(colors,1); i += 1)
		ModifyGraph rgb($StringFromList(i,Traces))=(colors[0][i],colors[1][i],colors[2][i])      // set new color offset
	endfor
End


function plot2d_heatmap(wav, [x_label, y_label])
	//plots the repeats against the sweeps for dataset cscurrent_2d
	wave wav

	string x_label, y_label
	
	x_label = selectstring(paramisdefault(x_label), x_label, "Gate (mV)")
	y_label = selectstring(paramisdefault(y_label), y_label, "Gate (mV)")

	variable num
	string wave_name

	wave_name = nameOfWave(wav)
	wave wav = $wave_name

	display //start with empty graph
	appendimage wav //append image of data
	ModifyImage $wave_name ctab= {*, *, Turbo,0} //setting color (idk why it prefers the pointer)
	ColorScale /A=RC /E width=20 //puts it on the right centre, /E places it outside

	Label bottom x_label
	Label left y_label

	ModifyGraph fSize=24
	ModifyGraph gFont="Gill Sans Light"
end


function setcolorscale2d(percent)
	variable percent
	variable x1, y1, x2, y2, xs, ys, minz, maxz, i=0, j=0
	string filename
	filename=csrwave(A)
	wave mywave = $filename
	x1=pcsr(A)
	y1=qcsr(A)
	x2=pcsr(B)
	y2=qcsr(B)
	duplicate /o/r=[x1,x2][y1,y2] mywave kjhdfgazs7f833jk
	wavestats/q kjhdfgazs7f833jk
	killwaves kjhdfgazs7f833jk
	ModifyImage '' ctab= {V_min,percent*V_max,PlanetEarth,0}
	//killwaves mywave
end


function twosubplot(graphID, wave2name,[labelx, labely])
//creates a subplot with an existing wave and GraphID with wave2
//wave2 will appear on top
	string graphID, wave2name, labelx, labely
	variable logy,logx
	wave wave2 = $wave2name
	
	labelx = selectString(paramIsDefault(labelx), labelx, "")
	labely = selectString(paramIsDefault(labely), labely, "")
	//variable minwave2 = wavemin(wave2)
	
	ModifyGraph /W = $graphID axisEnab(left)={0.525, 1.0} //graphID wont work
	AppendToGraph /W = $graphID /L=l2/B=b2 wave2 // vs something
	label b2 labelx
	label l2 labely
	

	
	ModifyGraph /W = $graphID axisEnab(l2)={0.0, 0.475}
	
	ModifyGraph /W = $graphID noLabel(b2)=2
	ModifyGraph /W = $graphID freePos(l2)=0
//	//ModifyGraph /W = $graphID freePos(b2)={minwave2,l2}
	ModifyGraph /W = $graphID freePos(b2)={0,left}

end


function create_marker_size(wave1d, every_n_max, [min_marker, max_marker])
	// create wave named nameofwave(wave1d) + "_marker_size" with every_n_max value equal to max_marker and the rest min_marker
	// aimed to help clean up graphs without deleting points from waves
	wave wave1d
	int every_n_max, min_marker, max_marker
	
	min_marker = paramisdefault(min_marker) ? 0.01 : min_marker // 0.01 is default
	max_marker = paramisdefault(max_marker) ? 1 : max_marker // 1 is default

	string wave_name = nameOfWave(wave1d)
	string wave_marker_name = wave_name + "_marker_size"
	
	duplicate /o $wave_name $wave_marker_name
	wave wave_marker = $wave_marker_name
	
	variable num_cols = dimsize(wave_marker, 0)
	variable i
	for (i = 0; i < num_cols; i++)
		
		if (mod(i, every_n_max) == 0)
			wave_marker[i] = max_marker
		else
			wave_marker[i] = min_marker
		endif
	endfor
end
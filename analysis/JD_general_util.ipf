#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3				// Use modern global access method and strict wave access
#pragma DefaultTab={3,20,4}		// Set default tab width in Igor Pro 9 and later
#include <Waves Average>
#include <FilterDialog> menus=0
#include <Split Axis>
#include <WMBatchCurveFitIM>
#include <Decimation>
#include <Wave Arithmetic Panel>



function center_dSdN(int wavenum, string kenner)
//wav is input wave, for example demod
//centered is output name
wave demod
string centered=kenner+num2str(wavenum)+"centered"
string centeravg=kenner+num2str(wavenum)+"centered_avg"
string cleaned=kenner+num2str(wavenum)+"cleaned"
string cleaned_avg=kenner+num2str(wavenum)+"cleaned_avg"


//duplicate/o demod centered
wave badthetasx

string condfit_prefix="cst"; //this can become an input if needed
string condfit_params_name=condfit_prefix+num2str(wavenum)+"fit_params"
wave condfit_params = $condfit_params_name

	duplicate/o/r=[][3] condfit_params mids

	centering(demod,centered,mids)
	wave temp=$centered

	duplicate/o temp $cleaned


	// removing lines with bad thetas;

	variable i, idx
	int nc
	int nr
	nr = dimsize(badthetasx,0) //number of rows
	i=0
	if (nr>0)
		do
			idx=badthetasx[i]-i //when deleting, I need the -i because if deleting in the loop the indeces of center change continously as points are deleted
			DeletePoints/M=1 idx,1, $cleaned
			i=i+1
		while (i<nr)
	endif


	avg_wav($cleaned)
	avg_wav($centered)
	display $cleaned_avg, $centeravg
	makecolorful()
	
end



function notch_filters(wave wav, [string Hzs, string Qs, string notch_name])
	// wav is the wave to be filtered.  notch_name, if specified, is the name of the wave after notch filtering.
	// If not specified the filtered wave will have the original name plus '_nf' 
	// This function is used to apply the notch filter for a choice of frequencies and Q factors
	// if the length of Hzs and Qs do not match then Q is chosen as the first Q is the list
	// It is expected that wav will have an associated JSON file to convert measurement times to points, via fd_getmeasfreq below
	// EXAMPLE usage: notch_filters(dat6430cscurrent_2d, Hzs="60;180;300", Qs="50;150;250")
	
	Hzs = selectString(paramisdefault(Hzs), Hzs, "60")
	Qs = selectString(paramisdefault(Qs), Qs, "50")
	variable num_Hz = ItemsInList(Hzs, ";")
	variable num_Q = ItemsInList(Qs, ";")
	
	// Get new filtered name and make a copy of wave
	String wav_name = nameOfWave(wav)
	notch_name = selectString(paramisdefault(notch_name), notch_name, wav_name + "_nf")
	if ((cmpstr(wav_name,notch_name)))
		duplicate/o wav $notch_name
	else
		print notch_name
		abort "I was going to overwrite your wave"
	endif
	wave notch_wave = $notch_name
		
	// Creating wave variables
	variable num_rows = dimsize(wav, 0)
	variable padnum = 2^ceil(log(num_rows) / log(2)); 
	duplicate /o wav tempwav // tempwav is the one we will operate on during the FFT
	variable offset = mean(wav)
	tempwav -= offset // make tempwav have zero average to reduce end effects associated with padding
	
	//Transform
	FFT/pad=(padnum)/OUT=1/DEST=temp_fft tempwav

	wave /c temp_fft
	duplicate/c/o temp_fft fftfactor // fftfactor is the wave to multiple temp_fft by to zero our certain frequencies
	
	// Accessing freq conversion for wav
	int wavenum = getfirstnum(wav_name)
	variable freqfactor = 1/(fd_getmeasfreq(wavenum) * dimdelta(wav, 0)) // freq in wav = Hz in real seconds * freqfactor

	fftfactor=1
	variable freq, Q, i
	for (i=0;i<num_Hz;i+=1)
		freq = freqfactor * str2num(stringfromlist(i, Hzs))
		Q = ((num_Hz==num_Q) ? str2num(stringfromlist(i, Qs)): str2num(stringfromlist(0, Qs))) // this sets Q to be the ith item on the list if num_Q==num_Hz, otherwise it sets it to be the first value
		fftfactor -= exp(-(x - freq)^2 / (freq / Q)^2)
	endfor
	temp_fft *= fftfactor

	//Inverse transform
	IFFT/DEST=temp_ifft  temp_fft
	wave temp_ifft
	
	temp_ifft += offset

	redimension/N=(num_rows, -1) temp_ifft
	copyscales wav, temp_ifft
	duplicate /o temp_ifft $notch_name
	
end



function spectrum_analyzer(wave data, variable samp_freq, [variable create_new_wave])
	// Built in powerspectrum function
	create_new_wave = paramisdefault(create_new_wave) ? 1 : create_new_wave

	duplicate/o data spectrum
	SetScale/P x 0,1/samp_freq,"", spectrum
	variable nr=dimsize(spectrum,0);  // number of points in x-direction
	variable le=2^(floor(log(nr)/log(2))); // max factor of 2 less than total num points
	wave slice;
	wave w_Periodogram

	variable i=0
	rowslice(spectrum,i)
		DSPPeriodogram/R=[1,(le)] /DB/NODC=1/DEST=W_Periodogram slice
	duplicate/o w_Periodogram, powerspec
	i=1
	do
		rowslice(spectrum,i)
		DSPPeriodogram/R=[1,(le)]/DB/NODC=1/DEST=W_Periodogram slice
		powerspec=powerspec+W_periodogram
		i=i+1
	while(i<dimsize(spectrum,1))
	powerspec[0]=nan
	
	if (create_new_wave == 1)
		String wav_name = nameOfWave(data)+"_powerspec"
		duplicate/o powerspec, $wav_name
		display $wav_name; // SetAxis bottom 0,500
	
	else
		display powerspec; // SetAxis bottom 0,500
	endif

end




function /s avg_wav(wave wav) // /WAVE lets your return a wave

	//  averaging any wave over columns (in y direction)
	// wave returned is avg_name
	string wn = nameofwave(wav)
	string avg_name = wn + "_avg";
	int nc
	int nr

	nr = dimsize($wn,0) //number of rows (sweep length)
	nc = dimsize($wn,1) //number of columns (repeats)
	ReduceMatrixSize(wav, 0, -1, nr, 0,-1, 1,1, avg_name)
	redimension/n=-1 $avg_name
	return avg_name
end


function stopalltimers()
	variable i
	i=0
	do
		print stopMSTimer(i)
		i=i+1
	while(i<9)
end

	
	
function udh5([dat_num, dat_list, dat_min_max])
	// Loads HDF files back into Igor, if no optional paramters specified loads all dat in file path into IGOR
	// NOTE: Assumes 'data' has been specified
	string dat_num,dat_list, dat_min_max
	dat_num = selectString(paramisdefault(dat_num), dat_num, "") // e.g. "302"
	dat_list = selectString(paramisdefault(dat_list), dat_list, "") // e.g. "302,303,304,305,401"
	dat_min_max = selectString(paramisdefault(dat_min_max), dat_min_max, "") // e.g. "302,310"
	
	string infile = wavelist("*",";","") // get wave list
	string hdflist = indexedfile(data,-1,".h5") // get list of .h5 files
	string currentHDF="", currentWav="", datasets="", currentDS
	
	
	////////////////////////////////////////////////////
	///// Overwriting hdflist if dat_num specified /////
	////////////////////////////////////////////////////
	if (!stringmatch(dat_num, ""))
		hdflist = "dat" + dat_num + ".h5"
	endif
	
	/////////////////////////////////////////////////////
	///// Overwriting hdflist if dat_list specified /////
	/////////////////////////////////////////////////////
	variable i
	if (!stringmatch(dat_list, ""))
		hdflist = ""
		for(i=0; i<ItemsInList(dat_list, ","); i+=1)
			hdflist = hdflist + "dat" + StringFromList(i, dat_list, ",") + ".h5;"
		endfor
	endif
	
	////////////////////////////////////////////////////////
	///// Overwriting hdflist if dat_min_max specified /////
	////////////////////////////////////////////////////////
	variable dat_start = str2num(StringFromList(0, dat_min_max, ","))
	variable dat_end = str2num(StringFromList(1, dat_min_max, ","))
	
	if (!stringmatch(dat_min_max, ""))
		hdflist = ""
		for(i=dat_start; i<dat_end+1; i+=1)
			hdflist = hdflist + "dat" + num2str(i) + ".h5;"
		endfor
	endif
	
	print(hdflist)
	
	variable numHDF = itemsinlist(hdflist, ";"), fileid = 0, numWN = 0, wnExists = 0
	variable j = 0, numloaded = 0


	for(i = 0; i < numHDF; i += 1) // loop over h5 filelist

		currentHDF = StringFromList(i, hdflist, ";")

		HDF5OpenFile/P=data /R fileID as currentHDF
		HDF5ListGroup /TYPE=2 /R=1 fileID, "/" // list datasets in root group
		datasets = S_HDF5ListGroup
		numWN = itemsinlist(datasets)  // number of waves in .h5
		currentHDF = currentHDF[0, (strlen(currentHDF) - 4)]
		for(j = 0; j < numWN; j += 1) // loop over datasets within h5 file
	    	currentDS = StringFromList(j, datasets)
			currentWav = currentHDF + currentDS
		    wnExists = FindListItem(currentWav, infile,  ";")
		    if (wnExists == -1)
		   		// load wave from hdf
		   		HDF5LoadData /Q /IGOR=-1 /N=$currentWav/TRAN=1 fileID, currentDS
		   		numloaded+=1
		    endif
		endfor
		HDF5CloseFile fileID
	endfor
	print numloaded, "waves uploaded"
end




function ud()
	string infile = wavelist("*",";",""); print infile
	string infolder =  indexedfile(data,-1,".ibw")
	string current, current1
	variable numstrings = itemsinlist(infolder), i, curplace, numloaded=0
	
	for(i=0; i<numstrings; i+=1)
		current1 = StringFromList(i,infolder)
		current = current1[0,(strlen(current1)-5)]
		curplace = FindListItem(current, infile,  ";")
		if (curplace==-1)
			LoadWave/Q/H/P=data current
			numloaded+=1
		endif
	endfor
	print numloaded, "waves uploaded"
end



macro plot2d(num,dataset,disp)
	variable num
	string dataset
	variable disp

	string wvname
	wvname="dat"+num2str(num)+dataset
	
	if (disp==1)
		display; 
	endif
	
	appendimage $wvname
	wavestats/q $wvname
	//ModifyImage $wvname ctab= {0.000,*,VioletOrangeYellow,0}
	ModifyImage $wvname ctab= {*,*,VioletOrangeYellow,0}
	ColorScale/C/N=text0/F=0/A=RC/E width=20,image=$wvname
	TextBox/C/N=text1/F=0/A=MT/E wvname

	ModifyGraph fSize=24
	ModifyGraph gFont="Gill Sans Light"
	ModifyGraph grid=0
	ModifyGraph width={Aspect,1.62},height=300
	ModifyGraph width=0,height=0

	variable inc
	inc=(V_max-V_min)/20
	Button autoscale,pos={52.00,9.00},size={103.00,21.00},proc=ButtonProc_2,title="high contrast"
	Button use_lookup,pos={49.00,35.00},size={105.00,23.00},proc=ButtonProc_5,title="use lookup"
	Button linear,pos={163.00,9.00},size={50.00,20.00},proc=ButtonProc_6,title="linear"
	
end




function mean_nan(wavenm)
	wave wavenm
	
	variable i=0, sumwv=0, numpts=dimsize(wavenm,0), numvals=0
	do
		if (abs(wavenm[i])>0)
			sumwv += wavenm[i]
			numvals+=1
		endif
		i+=1
	while(i<numpts)
	return (sumwv/numvals)
end



function centerwave(wavenm)
	string wavenm 
	wave data
	Duplicate/o $wavenm data
	data=data/1.5

	variable centerpt, centerval
	wave w_coef=w_coef 

	variable l= dimsize(data, 0 )
	WaveStats/Q/R=[l/2-100,l/2+100] data
	//wavestats /q data
	centerpt = v_maxrowloc
	
	
	CurveFit/q/NTHR=0 lor  data[(centerpt-20),(centerpt+20)] 
	centerval=w_coef[2]
	SetScale/P x (dimoffset(data,0)-centerval),dimdelta(data,0),"", data
	display data
end 
	

	
function subtract_bg(rs, bias, current, [identifier])
	variable rs, bias
	variable identifier
	wave current
	variable aspectrat=6.8/3.2;
	string wavenm=("cond"+num2str(identifier))
	
	if (paramisdefault(identifier))
		wavenm="cond"
	endif
	
    duplicate /o current  $wavenm
    wave cond=$wavenm
	duplicate /o current  temp
	
	temp=bias/current-rs
	cond=1/temp *aspectrat // cond * geometry of sample =conductivity

end	



macro setparams_wide()
	ModifyGraph fSize=24
	ModifyGraph gFont="Gill Sans Light"
	ModifyGraph width={Aspect,1},height=400
	ModifyGraph grid=0
	ModifyGraph width=500,height=380
	ModifyGraph width=0,height=0
endmacro



macro setparams_square()
	Label bottom ""
	Label left ""
		ModifyGraph fSize=24
	ModifyGraph gFont="Gill Sans Light"
	//ModifyGraph width=283.465,height={Aspect,1.62}
	ModifyGraph grid=2
	ModifyGraph width={Aspect,1},height=400

endmacro







	




Function Setmaxi(sva) : SetVariableControl
	STRUCT WMSetVariableAction &sva
	nvar maxi, mini

	switch( sva.eventCode )
		case 1: // mouse up
		case 2: // Enter key
		case 3: // Live update
		
			 maxi = sva.dval
			String sval = sva.sval
	ModifyImage ''#0 ctab= {mini,maxi,VioletOrangeYellow,0}
break
		case -1: // control being killed
			break
	endswitch

	return maxi
End

Function Setmini(sva) : SetVariableControl
	STRUCT WMSetVariableAction &sva
	nvar maxi, mini

	switch( sva.eventCode )
		case 1: // mouse up
		case 2: // Enter key
		case 3: // Live update
		
			 mini = sva.dval
			String sval = sva.sval
	ModifyImage ''#0 ctab= {mini,maxi,VioletOrangeYellow,0}

break
		case -1: // control being killed
			break
	endswitch

	return mini
End








Function save_specwave(waveno)
	variable waveno
	
	Variable index = 0
	do
		Wave/Z w = WaveRefIndexedDFR(:, index)
		if (!WaveExists(w))
			break
		endif
		
		String fileName = NameOfWave(w)
		string compare2="dat"+num2str(waveno)
		variable slen
		slen= strlen(compare2)

		if(stringmatch(fileName[0,slen-1], compare2))
		Save/C/O/P=data w as fileName
      print filename
		endif
		index += 1
	while(1)
	
	
End

function save_waves(Anfang,Ende)
	variable Anfang, Ende
	variable index=Anfang
	do
		save_specwave(index)
		index += 1
	while(index<Ende)
end



Function renamewave(oldprefix,newprefix)
   string oldprefix, newprefix
 
   string theList, theOne, theName
   variable ic, nt
 
   theList = WaveList("*",";","")
   nt = ItemsInList(theList)
   for (ic=0;ic<nt;ic+=1)
     theOne = StringFromList(ic,theList)
     theName = ReplaceString(oldprefix,theOne,newprefix)
     rename $theOne $theName
   endfor
   return 0
end






function int_PSD(tim)
	string tim
//	wave ref
	string inwave="spectrum_2020-10-09_"+tim+"fftADC0"
	string outwave="spectrum_2020-10-09_"+tim+"_int"
	wave nw=$inwave
	//execute("graph()")
	wavestats/q nw
	if (V_min<-140)
	DeletePoints 0,1, nw
	endif
	
	appendtoGraph/l $inwave; 

	duplicate/o $inwave $outwave
	wave nw_int=$outwave
	duplicate/o nw temp
	temp= 10^(nw/10);

	Integrate temp/D=nw_int
	appendtoGraph/r nw_int; 
	makecolorful(); 
	
//	matrixop/o diff=ref-nw
//	display diff
//	SetScale/I x 0,1269,"", diff


end

macro testLI()
closeallGraphs()
sc_openInstrConnections(0)
setFdacAWGSquareWave(fd, 100, -100, 0.001, 0.001, 0)
setupAWG(fd, AWs="0", DACs="0", numCycles=1, verbose=1)
ScanFastDAC(fd, 0, 1, "3", sweeprate=1,  use_awg=1,nosave = 0, repeats = 5)

//lock_in_main_2d(wave0_2d,1)
//demodulate(filenum,1,"wa,[append2hdf])
//display average
endmacro


//from:
// https://www.wavemetrics.com/code-snippet/stacked-plots-multiple-plots-layout

function MultiGraphLayout(GraphList, nCols, spacing, layoutName)
	string GraphList        // semicolon separated list of graphs to be appended to layout
	variable nCols      // number of graph columns
	string layoutName   // name of the layout
	variable spacing        // spacing between graphs in points!

	// how many graphs are there and how many rows are required
	variable nGraphs = ItemsInList(GraphList)
	variable nRows = ceil(nGraphs / nCols)
	variable LayoutWidth, LayoutHeight
	variable gWidth, gHeight
	variable maxWidth = 0, maxHeight = 0
	variable left, top
	variable i, j, n = 0

	string ThisGraph

	// detect total layout size from individual graph sizes; get maximum graph size as column/row size
	for(i=0; i<nGraphs; i+=1)

		ThisGraph = StringFromList(i, GraphList)
		GetWindow $ThisGraph gsize
		gWidth = (V_right - V_left)
		gHeight = (V_bottom - V_top)

		// update maximum
		maxWidth = gWidth > maxWidth ? gWidth : maxWidth
		maxHeight = gHeight > maxHeight ? gHeight : maxHeight
	endfor

	// calculate layout size
	LayoutWidth = maxWidth * nCols + ((nCols + 1) * spacing)
	LayoutHeight = maxHeight * nRows + ((nRows +1) * spacing)

	// make layout; kill if it exists
	DoWindow $layoutName
	if(V_flag)
		KillWindow $layoutName
	endif

	NewLayout/N=$layoutName/K=1/W=(517,55,1451,800)
	LayoutPageAction size=(LayoutWidth, LayoutHeight), margins=(0,0,0,0)
	ModifyLayout mag=0.75

	//append graphs
	top = spacing
	for(i=0; i<nRows; i+=1)

		// reset vertical position for each column
		left = spacing

		for (j=0; j<    nCols; j+=1)

			ThisGraph = StringFromList(n, GraphList)
			if(strlen(ThisGraph) == 0)
				return 0
			endif

			GetWindow $ThisGraph gsize
			gWidth = (V_right - V_left)
			gHeight = (V_bottom - V_top)

			AppendLayoutObject/F=0 /D=1 /R=(left, top, (left + gWidth), (top + gHeight)) graph $ThisGraph

			// shift next starting positions to the right
			left += maxWidth + spacing

			// increase plot counter
			n += 1
		endfor

		// shift next starting positions dwon
		top += maxHeight + spacing
	endfor

	return 1
end

function getfirstnum(numstr)
    string numstr
    
    string junk
    variable number
    sscanf numstr, "%[^0123456789]%d", junk, number
    return number
end

function /s getprefix(numstr)
    string numstr
    
    string junk
    variable number
    sscanf numstr, "%[^0123456789]%d", junk, number
    return junk
end

function /s getsuffix(numstr)
    string numstr
    
    string junk, suff
    variable number
    sscanf numstr, "%[^0123456789]%d%s", junk, number, suff
    return suff
end



function/wave rowslice(wave wav,int rownumb)
duplicate /o/rmd=[][rownumb,rownumb] wav, slice
redimension/n=(dimsize(slice,0)) slice
return slice
end




function centering(wave wave_not_centered, string centered_wave_name, wave mids)
	// shift the wave 'wave_not_centered' by the 'mids' wave
	// call the new wave 'centered_wave_name'
	duplicate/o wave_not_centered $centered_wave_name
	wave new2dwave=$centered_wave_name
	copyscales wave_not_centered new2dwave
	new2dwave=interp2d(wave_not_centered,(x+mids[q]),(y)) // mids is the shift in x
end

//function cst_centering(wave waved,string kenner_out)
//	string w2d=nameofwave(waved)
//	int wavenum=getfirstnum(w2d)
//	string centered=kenner_out+num2str(wavenum)+"centered"
//	string fit_params_name = kenner_out+num2str(wavenum)+"fit_params"
//	wave fit_params = $fit_params_name
//	
//	//	duplicate /o /r = [][0] waved wavex;redimension/N=(nr) wavex; wavex = x
//	duplicate/o waved $centered
//	wave new2dwave=$centered
//	copyscales waved new2dwave
//	new2dwave=interp2d(waved,(x+fit_params[q][3]),(y)) // column 3 is the center fit parameter
//end




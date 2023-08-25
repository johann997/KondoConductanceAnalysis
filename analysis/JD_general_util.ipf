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


function resampleWave(wave wav,variable targetFreq )
	// resamples wave w from measureFreq
	// to targetFreq (which should be lower than measureFreq)	
	string wn=nameOfWave(wav)
	int wavenum=getfirstnum(wn)
	string temp_name="dat"+num2str(wavenum)+"x_array"
	
	variable measureFreq
//	struct ScanVars S
//	fd_getScanVars(S,wavenum)
//	struct AWGVars S
//	fd_getoldAWG(S,wavenum)
//
//	measureFreq=S.measureFreq
	measureFreq = fd_getmeasfreq(wavenum)
	variable N=measureFreq/targetFreq

	
	RatioFromNumber (targetFreq / measureFreq)
	if (V_numerator > V_denominator)
		string cmd
		printf cmd "WARNING[scfd_resampleWaves]: Resampling will increase number of datapoints, not decrease! (ratio = %d/%d)\r", V_numerator, V_denominator
	endif
	resample/UP=(V_numerator)/DOWN=(V_denominator)/N=201/E=3 wav

	//DeletePoints/M=1 25,370, wav
	


	// TODO: Need to test N more (simple testing suggests we may need >200 in some cases!)
	// TODO: Need to decide what to do with end effect. Possibly /E=2 (set edges to 0) and then turn those zeros to NaNs? 
	// TODO: Or maybe /E=3 is safest (repeat edges). The default /E=0 (bounce) is awful.
end





//function spectrum_analyzer(wave data, variable samp_freq, [variable create_new_wave])
//	// Built in powerspectrum function
//	create_new_wave = paramisdefault(create_new_wave) ? 1 : create_new_wave
//
//	duplicate/o data spectrum
//	SetScale/P x 0,1/samp_freq,"", spectrum
//	variable nr=dimsize(spectrum,0);  // number of points in x-direction
//	variable le=2^(floor(log(nr)/log(2))); // max factor of 2 less than total num points
//	wave slice;
//	wave w_Periodogram
//
//	variable i=0
//	rowslice(spectrum,i)
//		DSPPeriodogram/R=[0,(le-1)]/PARS/NODC=2/DEST=W_Periodogram slice 
//	duplicate/o w_Periodogram, powerspec
//	i=1
//	do
//		rowslice(spectrum,i)
//		DSPPeriodogram/R=[0,(le-1)]/PARS/NODC=2/DEST=W_Periodogram slice 
//		powerspec=powerspec+W_periodogram
//		i=i+1
//	while(i<dimsize(spectrum,1))
//	powerspec[0]=nan
//	
//	if (create_new_wave == 1)
//		String wav_name = nameOfWave(data)+"_powerspec"
//		duplicate/o powerspec, $wav_name
//		display $wav_name; // SetAxis bottom 0,500
//	
//	else
//		display powerspec; // SetAxis bottom 0,500
//	endif
//	
//	ModifyGraph log(left)=1
//
//end



function spectrum_analyzer(wave data, variable samp_freq, [variable create_new_wave, int plot_on])
	// Built in powerspectrum function
	
	create_new_wave = paramisdefault(create_new_wave) ? 1 : create_new_wave
	plot_on = paramisdefault(plot_on) ? 1 : plot_on
	
	duplicate/o data spectrum
	SetScale/P x 0,1/samp_freq,"", spectrum
	variable numptsx = dimsize(spectrum,0);  // number of points in x-direction
	variable new_numptsx = 2^(floor(log(numptsx)/log(2))); // max factor of 2 less than total num points
	wave slice;
	wave w_Periodogram

	variable i=0
	rowslice(spectrum,i)
	DSPPeriodogram/R=[1,(new_numptsx)] /PARS/NODC=2/DEST=W_Periodogram slice
	duplicate/o w_Periodogram, powerspec
	i=1
	do
		rowslice(spectrum,i)
		DSPPeriodogram/R=[1, (new_numptsx)] /PARS/NODC=2/DEST=W_Periodogram slice
		powerspec = powerspec + W_periodogram
		i=i+1
	while(i<dimsize(spectrum,1))
//	powerspec[0]=nan


	if (create_new_wave == 1)
		String wav_name = nameOfWave(data) + "_powerspec"
		duplicate/o powerspec, $wav_name
		if (plot_on == 1)
			display $wav_name; // SetAxis bottom 0,500
		endif
		String wav_name_int = nameOfWave(data) + "_powerspec_int"
		duplicate /o powerspec $wav_name_int
		wave powerspec_int = $wav_name_int
	else
		if (plot_on == 1)
			display powerspec; // SetAxis bottom 0,500
		endif
		duplicate /o powerspec powerspec_int
		wave powerspec_int
	endif


	integrate powerspec_int
	if (plot_on == 1)
		appendtoGraph /r=l2 powerspec_int
		ModifyGraph freePos(l2)={inf,bottom}
		ModifyGraph rgb(powerspec_int)=(0,0,0)
		ModifyGraph log(left)=1
		
		Label left "nA^2/Hz"
		Label l2 "integrated nA^2/Hz"
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
	try
		ReduceMatrixSize(wav, 0, -1, nr, 0,-1, 1,1, avg_name)
	catch
		print "FAILED to average " + wn
	endtry
	redimension/n=-1 $avg_name
	return avg_name
end


function create_y_wave(wave_2d)
	// create global "y_wave" given a 2d array
	wave wave_2d
	
	string wave_2d_name = nameofwave(wave_2d)
	
	duplicate /o /RMD=[0][] $wave_2d_name y_wave
	y_wave = y
	redimension /n=(dimsize(y_wave, 1)) y_wave
end


function create_x_wave(wave_2d)
	// create global "x_wave" given a 2d array
	wave wave_2d
	
	string wave_2d_name = nameofwave(wave_2d)
	
	duplicate /o /RMD=[][0] $wave_2d_name x_wave
	x_wave = x
end






function stopalltimers()
	variable i
	i=0
	do
		print stopMSTimer(i)
		i=i+1
	while(i<9)
end

	
	
function udh5([dat_num, dat_list, dat_min_max, exclude_name])
	// Loads HDF files back into Igor, if no optional paramters specified loads all dat in file path into IGOR
	// NOTE: Assumes 'data' has been specified
	string dat_num,dat_list, dat_min_max, exclude_name
	dat_num = selectString(paramisdefault(dat_num), dat_num, "") // e.g. "302"
	dat_list = selectString(paramisdefault(dat_list), dat_list, "") // e.g. "302,303,304,305,401"
	dat_min_max = selectString(paramisdefault(dat_min_max), dat_min_max, "") // e.g. "302,310"
	exclude_name = selectString(paramisdefault(exclude_name), exclude_name, "") // e.g. "RAW"
	string strmatch_exclude_name = "*" + exclude_name + "*"
	
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
		
		if (cmpstr(strmatch_exclude_name, "**") == 1 && stringmatch(currentHDF, strmatch_exclude_name) == 1) // if exclude name set and within file name 
			continue
		endif
		


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



function prune_waves(wave1, wave2)
	// this function points from both waves if there is a NaN in either wave
	// assumes each wave has the same length
	wave wave1, wave2
	
	string wave1_name = nameofwave(wave1)
	string wave2_name = nameofwave(wave2)

	wave wave1_ref = $wave1_name
	wave wave2_ref = $wave2_name
	
	variable num_rows_wave1 = dimsize(wave1_ref, 0)

	int num_bad_rows = 0	
	int i 
	for (i = 0; i < num_rows_wave1; i++)

		if (numtype(wave1_ref[i - num_bad_rows]) == 2) // checking if its a NaN
			DeletePoints (i - num_bad_rows), 1, wave1_ref // delete row
			DeletePoints(i - num_bad_rows), 1, wave2_ref // delete row
			num_bad_rows += 1
		endif
	endfor
	
	
	variable num_rows_wave2 = dimsize(wave2_ref, 0)

	num_bad_rows = 0	
	for (i = 0; i < num_rows_wave2; i++)
	
		if (numtype(wave2_ref[i - num_bad_rows]) == 2)
			DeletePoints/M=0 (i - num_bad_rows), 1, wave1_ref // delete row
			DeletePoints/M=0 (i - num_bad_rows), 1, wave2_ref // delete row
			num_bad_rows += 1
		endif
	endfor
	
	
end
﻿#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3			// Use modern global access method and strict wave access
#pragma DefaultTab={3,20,4}		// Set default tab width in Igor Pro 9 and later
#include <Reduce Matrix Size>

function master_cond_clean_average(wave wav, int refit, string kenner_out, [int alternate_bias])
	// wav is the wave containing original dotcurrent data
	// refit tells whether to do new fits to each CT line
	// kenner_out is the prefix to replace dat for this analysis
	// kenner_out  can not contain a number otherwise getfirstnu will not work

	variable refnum, ms
	refnum=startmstimer

//	closeallGraphs()

	string datasetname = nameofwave(wav)
	string kenner = getsuffix(datasetname) //  cscurrent in the above case
	int wavenum = getfirstnum(datasetname) // XXX in the above case
	
	// these are the new wave names to be made
	string centered_wave_name = kenner_out + num2str(wavenum) + "_dot_centered"
	string cleaned_wave_name = kenner_out + num2str(wavenum) + "_dot_cleaned"
	string avg_wave_name = cleaned_wave_name + "_avg" // this name can be whatever, but keeping same standard as CT fitting. 

	string split_pos = cleaned_wave_name + "_pos"
	string split_neg = cleaned_wave_name + "_neg"
	string pos_avg = split_pos + "_avg"
	string neg_avg = split_neg + "_avg"
	string fit_params_name = kenner_out + num2str(wavenum) + "_dot_fit_params"
	variable N
	N=2  // how many sdevs in thetas are acceptable?


	if (refit==1)
		get_cond_fit_params($datasetname, kenner_out)// finds fit_params
		plot_gammas(fit_params_name, N) //need to do this to refind good and bad gammas
		duplicate/o/r=[][2] $fit_params_name mids
		centering($datasetname, centered_wave_name, mids)// only need to center after redoing fits, centred plot; returns centered_wave_name

//		remove_bad_gammas($centered_wave_name, cleaned_wave_name) // only need to clean after redoing fits; returns centered_wave_name
		duplicate /o $centered_wave_name $cleaned_wave_name
		
		split_wave($cleaned_wave_name, 0) //makes condxxxxcentered
		split_pos = cleaned_wave_name + "_pos"
		split_neg = cleaned_wave_name + "_neg"
		
	else
		split_wave($datasetname, 0) //makes condxxxxcentered
		split_pos = datasetname + "_pos"
		split_neg = datasetname + "_neg"
	endif

	// commentating out the splitting if we reverse bias
	if (alternate_bias == 1)
		pos_avg = split_pos + "_avg"
		neg_avg = split_neg + "_avg"
		zap_NaN_rows($split_pos, overwrite = 1, percentage_cutoff_inf = 0.15)
		zap_NaN_rows($split_neg, overwrite = 1, percentage_cutoff_inf = 0.15)
		
		avg_wav($split_pos) // pos average
		avg_wav($split_neg) // neg average
		
		get_conductance_from_current($pos_avg, $neg_avg, avg_wave_name) // condxxxxavg
	else
		zap_NaN_rows($cleaned_wave_name, overwrite = 1, percentage_cutoff_inf = 0.15)
		avg_wav($cleaned_wave_name)
		zap_NaNs($avg_wave_name, overwrite=1)
	endif
	
	plot_cond_figs(wavenum, N, kenner, kenner_out, refit=refit, alternate_bias=alternate_bias)

	ms=stopmstimer(refnum)
	print "Cond: time taken = " + num2str(ms/1e6) + "s"
end


function zap_NaN_rows(wave_2d, [overwrite, percentage_cutoff_inf])
	// removes any row from wave_2d where the number of NaNs is greater than the cutoff specified in percentage_cutoff_inf
	// wave_2d: 2d wave to remove rows from
	// overwrite: Default is overwrite = 0. overwrite = 1 will overwrite input wave and params wave.
	// percentage_cutoff_inf: Default is percentage_cutoff_inf = 0.15 :: 15%
	wave wave_2d
	int overwrite
	variable percentage_cutoff_inf
	
	percentage_cutoff_inf = paramisdefault(percentage_cutoff_inf) ? 0.15 : percentage_cutoff_inf // remove row with more than 15% NaN default


	// Duplicating 2d wave
	if (overwrite == 0)
		string wave_2d_name = nameofwave(wave_2d)
		string wave_2d_name_new = wave_2d_name + "_zap"
		duplicate /o wave_2d $wave_2d_name_new
		wave wave_2d_new = $wave_2d_name_new 
	endif
	
	
	create_x_wave(wave_2d)
	wave x_wave
	
	create_y_wave(wave_2d)
	wave y_wave
	
	variable num_rows = dimsize(wave_2d, 1)
	variable num_bad_rows = 0
	
	variable i 
	for (i = 0; i < num_rows; i++)
		duplicate /o /RMD=[][i - num_bad_rows] wave_2d data_slice
		wavestats /Q data_slice
		
		if (V_numNans / (V_npnts + V_numNans + V_numINFs) >= percentage_cutoff_inf)
		
			if (overwrite == 0)
				DeletePoints/M=1 (i - num_bad_rows), 1, wave_2d_new // delete row
			else
				DeletePoints/M=1 (i - num_bad_rows), 1, wave_2d // delete row
			endif
			
			num_bad_rows += 1
		endif
		
	endfor
end



function zapnan_scaling_overwrite(wave_1d, [overwrite])
	// removes any NaNs from a wave and preserves the x-scaling, assumes NaNs are only at the ends.
	// wave_1d: 2d wave to remove rows from
	// overwrite: Default is overwrite = 0. overwrite = 1 will overwrite input wave and params wave.
	// percentage_cutoff_inf: Default is percentage_cutoff_inf = 0.15 :: 15%
	wave wave_1d
	int overwrite

	// Duplicating 2d wave
	if (overwrite == 0)
		string wave_1d_name = nameofwave(wave_1d)
		string wave_1d_name_new = wave_1d_name + "_zap"
		duplicate /o wave_1d $wave_1d_name_new
		wave wave_1d_new = $wave_1d_name_new 
	endif
	
	
	create_x_wave(wave_1d)
	wave x_wave

	
	variable num_cols = dimsize(wave_1d, 0)
	variable value
	variable num_nan = 0
	
	variable i 
	for (i = 0; i < num_cols; i++)
	
		value = wave_1d[i]
		
		if (numtype(value) == 2)
			DeletePoints/M=0 (i - num_nan), 1, wave_1d_new // delete row
			DeletePoints/M=0 (i - num_nan), 1, x_wave // delete row
			num_nan += 1
		endif
	endfor
end



function/wave split_wave(wave wav, variable flag)
	string base_wave_name = nameofwave(wav)
	variable num_rows = dimsize(wav, 1)
//	int split_num_rows = round(num_rows/2)
	int split_num_rows = floor(num_rows/2)
	int i
	
	string pos_wave_name = base_wave_name + "_pos"
	duplicate /o /RMD=[][0, split_num_rows-1] wav $pos_wave_name
	wave pos_wave = $pos_wave_name
	
	for (i=0; i<split_num_rows; i++)
		pos_wave[][i] = wav[p][i*2 + flag]
	endfor
	
	
	string neg_wave_name = base_wave_name + "_neg"
	duplicate /o /RMD=[][0, split_num_rows-1] wav $neg_wave_name
	wave neg_wave = $neg_wave_name
	
	for (i=0; i<split_num_rows; i++)
		neg_wave[][i] = wav[p][i*2 + 1 + -1*flag]
	endfor

//	// split the wave into positive and negative waves
//	wave kenner
//	redimension/n=-1 kenner // n = -1 :: convert to 1d with same rows (Python columns)
//	string base_wave_name = nameofwave(wav)
//
//	////////////////////////////
//	///// create _pos wave /////
//	////////////////////////////
//	Duplicate/o kenner, idx
//	idx = kenner[p] > flag ? p : NaN
//	WaveTransform zapnans idx
//	
//	string pos_wave_name = base_wave_name + "_pos"
//	duplicate/o wav $pos_wave_name
//	wave out_wav = $pos_wave_name
//	Redimension/E=1/N=(-1,dimsize(idx,0)) out_wav
//
//	variable i=0
//	do
//		out_wav[][i]=wav[p][idx[i]]
//		i=i+1
//	while(i<dimsize(idx,0))
//
//
//	////////////////////////////
//	///// create _neg wave /////
//	////////////////////////////
//	Duplicate/o kenner,idx
//	idx = kenner[p][q] < flag ? p : NaN
//	WaveTransform zapnans idx
//
//	string neg_wave_name = base_wave_name + "_neg"
//	duplicate/o wav $neg_wave_name
//	wave out_wav1 = $neg_wave_name
//	Redimension/E=1/N=(-1,dimsize(idx,0)) out_wav1
//
//	i=0
//	do
//		out_wav1[][i]=wav[p][idx[i]]
//		i=i+1
//	while(i<dimsize(idx,0))
	
end




function plot_gammas(string fit_params_name, variable N)

	int wavenum =getfirstnum(fit_params_name)
	variable gammamean, gammastd
	variable cond_mid_mean, cond_mid_std
	variable i
	int nr

	wave fit_params = $fit_params_name
	nr = dimsize(fit_params,0)

	duplicate /O/R =[0,nr][3] fit_params gammas
	duplicate /O/R =[0,nr][2] fit_params cond_mids
	duplicate /O/R =[0,nr][1] fit_params amp

	gammamean = mean(gammas)
	gammastd = sqrt(variance(gammas))
	
	cond_mid_mean = mean(cond_mids)
	cond_mid_std = sqrt(variance(cond_mids))

	make /o/n =(nr) meanwave
	make /o/n =(nr) stdwave
	make /o/n =(nr) stdwave2
	make /o/n = 0 goodgammas
	make /o/n = 0 goodgammasx
	make /o/n = 0 badgammas
	make /o/n = 0 badgammasx
	
	// good and bad mid waves
	make /o/n = 0 good_cond_mids
	make /o/n = 0 good_cond_midsx
	make /o/n = 0 bad_cond_mids
	make /o/n = 0 bad_cond_midsx

	meanwave = gammamean
	stdwave = gammamean - N * gammastd
	stdwave2 = gammamean + N * gammastd

	for (i=0; i < nr ; i+=1)
	
		// find bad gammas
		if (abs(gammas[i] - gammamean) < (N * gammastd))
			insertPoints /v = (gammas[i]) nr, 1, goodgammas // value of gamma
			insertpoints /v = (i) nr, 1, goodgammasx        // the repeat
		else
			insertPoints /v = (gammas[i]) nr, 1, badgammas // value of gamma
			insertpoints /v = (i) nr, 1, badgammasx        // repeat
		endif
		
		// find bad mids
		if (abs(cond_mids[i] - cond_mid_mean) < (N * cond_mid_std))
			insertPoints /v = (cond_mids[i]) nr, 1, good_cond_mids // value of gamma
			insertpoints /v = (i) nr, 1, good_cond_midsx        // the repeat
		else
			insertPoints /v = (cond_mids[i]) nr, 1, bad_cond_mids // value of gamma
			insertpoints /v = (i) nr, 1, bad_cond_midsx        // repeat
		endif

	endfor


	duplicate/o goodgammas kenner
	kenner=(amp[goodgammasx])

	display meanwave, stdwave, stdwave2
	appendtograph goodgammas vs goodgammasx
	appendtograph badgammas vs badgammasx


	ModifyGraph fSize=24
	ModifyGraph gFont="Gill Sans Light"
	ModifyGraph lstyle(meanwave)=3,rgb(meanwave)=(17476,17476,17476)
	ModifyGraph lstyle(stdwave)=3,rgb(stdwave)=(52428,1,1)
	ModifyGraph lstyle(stdwave2)=3,rgb(stdwave2)=(52428,1,1)
	ModifyGraph mode(goodgammas)=3,lsize(goodgammas)=2, rgb(goodgammas)=(2,39321,1)
	ModifyGraph mode(badgammas)=3
	Legend/C/N=text0/J/A=RT "\\s(meanwave) mean\r\\s(stdwave) 2*std\r\\s(goodgammas) good\r\\s(badgammas) outliers"
	TextBox/C/N=text1/A=MT/E=2 "\\Z14\\Z16 gammas of dat" + num2str(wavenum)

	Label bottom "repeat"
	Label left "gamma values"

end
 
 
 
function plot_badgammas(wave wav)
	int i
	int nr
	wave badgammasx
	string dataset=nameOfWave(wav)

	nr = dimsize(badgammasx,0)
	display
	
	if(nr>0)
		for(i=0; i < nr; i +=1)
			appendtograph wav[][badgammasx[i]]
		endfor
	
		makecolorful()
		ModifyGraph fSize=24
		ModifyGraph gFont="Gill Sans Light"
		Label bottom "voltage"
		Label left dataset
		TextBox/C/N=text1/A=MT/E=2 "bad gammas of "+dataset
	endif
end


function /wave remove_bad_gammas(wave center, string cleaned_wave_name)
	// takes a wave 'center' and 'cleans' it based on 'badgammasx'
	// any row with a 'badgammax' will be removed from the 2d wave center
	wave badgammasx
	duplicate/o center $cleaned_wave_name
	
	wave bad_cond_midsx
	
	//////////////////////////////////////////
	///// removing lines with bad gammas /////
	//////////////////////////////////////////
	variable i, idx
	int nc
	int nr
	nr = dimsize(badgammasx,0) // number of rows
	i=0
	if (nr>0)
		do
			idx = badgammasx[i] - i // when deleting, I need the -i because if deleting in the loop the indeces of center change continously as points are deleted
			DeletePoints/M=1 idx,1, $cleaned_wave_name
			
//			// check if bad gamma row is also a bad mid row
//			FindValue /I=idx bad_cond_midsx
//			if (V_value >= 1)
//				DeletePoints/M=1 x2pnt(V_value), 0, bad_cond_midsx
//				bad_cond_midsx[] = bad_cond_midsx[]
//			endif
			i += 1
		while (i<nr)
	endif
	
	
	
	
	/////////////////////////////////////////////////
	///// removing lines with more than X% NaNs /////
	/////////////////////////////////////////////////
//	variable nan_cutoff = 0.3 // remove line if more than 30% of points are NaNs
//	variable num_columns = round(dimsize($cleaned_wave_name, 0)/2)
//	variable delete_interlaced_flag
//	
//	for (i=0; i < num_columns; i++)
//		delete_interlaced_flag = 0
//		
//		///// check if pos bias has NaNs /////
//		duplicate /RMD=[][i*2] /o $cleaned_wave_name temp_interlace1
//		WaveStats /q temp_interlace1
//		
//		if (V_numNans/V_npnts >= nan_cutoff)
//			delete_interlaced_flag = 1
//		endif
//		
//		///// check if neg bias has NaNs /////
//		duplicate /RMD=[][i*2 + 1] /o $cleaned_wave_name temp_interlace2
//		WaveStats /q temp_interlace2
//		
//		if (V_numNans/V_npnts >= nan_cutoff)
//			delete_interlaced_flag = 1
//		endif
//		
//		
//		///// delete interlaced section if either row has NaNs /////
//		if (delete_interlaced_flag == 1)
//			DeletePoints/M=1 i*2, 1, $cleaned_wave_name
//			DeletePoints/M=1 i*2, 1, $cleaned_wave_name
//		endif
//	
//	endfor


	return center

end




function/wave get_conductance_from_current(wave pos, wave neg, string newname)
	// using the positive and negative bias data gievn in current
	// calculate the 1d array in units of conductance
	// CHECK: bias and inline resistance is hard coded
	
	// Calcaultion for conductance: 
	// Total R = Dot R + Inline R
	// Inline R = 21150
	// Total R = Bias / Current
	// Condutcance = (1/Dot R) / quantum of conductance
	
	duplicate/o pos, $newname
	wave cond_wave = $newname;
	cond_wave = -(pos-neg)
//	cond_wave *= 1e-9 // units of A
//	
//	duplicate/o cond_wave current // keeping copy of current
//	duplicate/o cond_wave temp 
//	
//	variable bias = (514.95-495.05)/9950000; // divider is 9950 and 1000 is for V instead of mV
//	cond_wave = bias/temp
//	
//	cond_wave -= 21150
//	duplicate/o cond_wave temp 
//	
//	cond_wave = 1/temp
//	
//	cond_wave /= 7.7483e-05 
	
//	temp = cond/(bias - cond * 21150)
//	temp /= 7.7483e-05
//	cond = bias - temp*21150
//	temp = (temp/7.7483e-05)/cond
//	temp = (bias/temp)*1e9-21150;
//	temp = 1/temp/7.7483e-05
end



function /wave fit_single_peak(wave current_array)
	// fits the 1D current_array by taking the absolute value of the data
	// CHECK: Not ideal when the current is negative
	redimension/n=-1 current_array
	duplicate/o current_array temp
	
	//////////////////////
	///// OLD METHOD /////
	//////////////////////
	duplicate /o current_array temp_smooth
//	smooth 2000, temp_smooth
	
	variable pos_slice = 1
	variable temp_offset = temp_smooth[0]
	if (abs(wavemin(temp_smooth) - temp_offset) > abs(wavemax(temp_smooth) - temp_offset))
		pos_slice = 0
	endif
	
	
	variable amplitude, fwhm

	amplitude = (wavemax(temp_smooth) - wavemin(temp_smooth))
	if (pos_slice == 0)
		amplitude *= -1
	endif
	
	
	if (pos_slice == 1)
		FindLevels/Q/D=risingEdges/EDGE=1 temp_smooth, amplitude*0.5;  
		FindLevels/Q/D=fallingEdges/EDGE=2 temp_smooth, amplitude*0.5
	else
		duplicate /o temp_smooth temp_smooth_neg
		temp_smooth_neg *= -1
		FindLevels/Q/D=risingEdges/EDGE=1 temp_smooth_neg, amplitude*-0.5;  
		FindLevels/Q/D=fallingEdges/EDGE=2 temp_smooth_neg, amplitude*-0.5
	endif
	
	
	fwhm = fallingEdges[inf] - risingEdges[0]


	make/o/n=4 W_coef
	
	// W_coef[0] = y0 = y-offset
	// W_coef[1] = A = amplitude
	// W_coef[2] = x0 = x-offset
	// W_coef[3] = B = 'gamma'
	
	// offset
	if (pos_slice == 1)
		W_coef[0] = wavemin(temp_smooth)
	else
		W_coef[0] = wavemax(temp_smooth)
	endif
	
	
	// amplitude
	W_coef[1] =  amplitude*fwhm^2
	
	// x - offset
	if (pos_slice == 1)
		FindLevel /Q temp, wavemax(temp_smooth)
	else
		FindLevel /Q temp, wavemin(temp_smooth)
	endif
	W_coef[2] = V_LevelX 

	// 'gamma'
	W_coef[3] = fwhm^2 		
//	wavestats/q temp
//	
//	CurveFit/q lor current_array[round(V_maxrowloc-V_npnts/20), round(V_maxrowloc+V_npnts/20)] /D 
//	
	
	//////////////////////
	///// NEW METHOD /////
	//////////////////////
	// K0 = DC offset
	// K1 = Amplitude
	// K2 = x offset
	// K3 = Gamma
	variable K0, K1, K2, K3, K4
	wavestats/q temp
	variable mean_of_wave = mean(temp, pnt2x(temp, V_npnts*0.4), pnt2x(temp, V_npnts*0.6))
	if (mean_of_wave >= 0)
		temp -= wavemin(temp)
	else
		temp -= wavemax(temp)
		temp *= -1
		temp -= wavemin(temp)
	endif
	
	
	// only fit to ±5% the number of points on either side of the peak
	wavestats/q temp
	variable percentage_fit_width = 0.15
	variable min_fit_index = round(V_maxrowloc - V_npnts*percentage_fit_width)
	if (min_fit_index < 0)
		min_fit_index = 0
	endif
	
	variable max_fit_index = round(V_maxrowloc + V_npnts*percentage_fit_width)
	if (max_fit_index > V_npnts)
		max_fit_index = V_npnts - 1
	endif
	
//	closeallgraphs()
//	display current_array
//	CurveFit/q  lor current_array[min_fit_index, max_fit_index] /D // fit with lor (Lorentzian) :: /q = quiet :: /D = destwaveName
	CurveFit/q  lor current_array /D // fit with lor (Lorentzian) :: /q = quiet :: /D = destwaveName

//	ModifyGraph rgb(fit_temp_wave)=(0,0,0)
	
end




function /wave get_cond_fit_params(wave wav, string kenner_out)
	string w2d = nameofwave(wav)
	int wavenum = getfirstnum(w2d)
	string fit_params_name = kenner_out + num2str(wavenum) + "_dot_fit_params" //new array

	variable i
	string wavg
	int nc
	int nr
	wave fit_params
	wave W_coef
	wave W_sigma

	nr = dimsize(wav,0) //number of rows (data points)
	nc = dimsize(wav,1) //number of columns (total sweeps)
	make/o /N=(nr) temp_wave
	CopyScales wav, temp_wave

	make/o /N= (nc , 8) /o $fit_params_name
	wave fit_params = $fit_params_name

	for (i=0; i < nc ; i+=1) //nc
		temp_wave = wav[p][i]	;	redimension/n=-1 temp_wave

		fit_single_peak(temp_wave)
		fit_params[i][0,3] = W_coef[q]
		fit_params[i][4] = W_sigma[0]
		fit_params[i][5] = W_sigma[1]
		fit_params[i][6] = W_sigma[2]
		fit_params[i][7] = W_sigma[3]

	endfor

	return fit_params
end



function plot_cond_figs(variable wavenum, variable N, string kenner, string kenner_out, [int refit, int alternate_bias])	
	string dataset = "dat" + num2str(wavenum) + kenner
	string centered_wave_name = kenner_out + num2str(wavenum) + "_dot_centered"
	string cleaned_wave_name = kenner_out + num2str(wavenum) + "_dot_cleaned"
	string avg_wave_name = cleaned_wave_name + "_avg"

	string split_pos = cleaned_wave_name + "_pos"
	string split_neg = cleaned_wave_name + "_neg"
	string pos_avg = split_pos + "_avg"
	string neg_avg = split_neg + "_avg"
	string fit_params_name = kenner_out + num2str(wavenum) + "_dot_fit_params" 
//	closeallgraphs()

	/////////////////// thetas  //////////////////////////////////////

	plot2d_heatmap($dataset); // raw data
	
	if (alternate_bias == 1)
		plot2d_heatmap($split_pos) // positive bias
		plot2d_heatmap($split_neg) // negative bias
	endif
	
	if (refit == 1)
		plot2d_heatmap($centered_wave_name) // plot centered traces
		
		plot_gammas(fit_params_name,N)	// plot gamma values (FWHM)
		plot_badgammas($centered_wave_name) // plot traces with 'bad gammas'
		 
		plot2d_heatmap($cleaned_wave_name) // plot 2d with removed 'bad gamma' traces
	endif
	
	/////////////////// plot avg fit  //////////////////////////////////////
	
	display $avg_wave_name;

	string fit_name = "fit_" + avg_wave_name
	fit_single_peak($avg_wave_name) // getting fit parameters of final averaged trace
	
	Label bottom "gate (V)"
	Label left "cond (2e^2/h)"; // DelayUpdate
	ModifyGraph fSize=24
	ModifyGraph gFont="Gill Sans Light"
	ModifyGraph mode($fit_name)=0, lsize($fit_name)=1, rgb($fit_name)=(65535,0,0)
	ModifyGraph mode($avg_wave_name)=2, lsize($avg_wave_name)=2, rgb($avg_wave_name)=(0,0,0)
	Legend
	Legend/C/N=text0/J/A=LB/X=59.50/Y=53.03

	ModifyGraph log(left)=1,loglinear(left)=1

	TileWindows/O=1/C/P

end


	
//////////////////////
///// DEPRECATED /////
//////////////////////
/////////////////////////////////////////////////////////
///// Using fit_single_peak() in favour of the below/////
/////////////////////////////////////////////////////////
//function fit_function_lorentzian(A, G, Vo, V)
//	variable A,G,Vo,V
//	variable cond
//
//	cond=A*G/((V-Vo)^2+(G/2)^2);
//	return cond
//end
//
//
//
//Function CBpeak_fit(w, V) : FitFunc
//	Wave w
//	Variable V
//	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
//	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
//	//CurveFitDialog/ Equation:
//	//CurveFitDialog/ f(V) = CBpeak(A,G,Vo,V)
//	//CurveFitDialog/ End of Equation
//	//CurveFitDialog/ Independent Variables 1
//	//CurveFitDialog/ V
//	//CurveFitDialog/ Coefficients 3
//	//CurveFitDialog/ w[0] = A
//	//CurveFitDialog/ w[1] = G
//	//CurveFitDialog/ w[2] = Vo
//
//	return fit_function_lorentzian(w[0],w[1],w[2],V)
//End

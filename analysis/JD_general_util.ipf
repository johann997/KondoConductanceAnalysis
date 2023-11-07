#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3				// Use modern global access method and strict wave access
#pragma DefaultTab={3,20,4}		// Set default tab width in Igor Pro 9 and later
#include <Waves Average>
#include <FilterDialog> menus=0
#include <Split Axis>
#include <WMBatchCurveFitIM>
#include <Decimation>
#include <Wave Arithmetic Panel>


Function GetFreeMemory()
    variable freeMem

#if defined(IGOR64)
    freeMem = NumberByKey("PHYSMEM", IgorInfo(0)) - NumberByKey("USEDPHYSMEM", IgorInfo(0))
#else
    freeMem = NumberByKey("FREEMEM", IgorInfo(0))
#endif

    return freeMem / 1024 / 1024 / 1024
End



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



function notch_filters(wave wav, [string Hzs, string Qs, string notch_name, variable measure_freq])
	// wav is the wave to be filtered.  notch_name, if specified, is the name of the wave after notch filtering.
	// If not specified the filtered wave will have the original name plus '_nf' 
	// This function is used to apply the notch filter for a choice of frequencies and Q factors
	// if the length of Hzs and Qs do not match then Q is chosen as the first Q is the list
	// It is expected that wav will have an associated JSON file to convert measurement times to points, via fd_getmeasfreq below
	// EXAMPLE usage: notch_filters(dat6430cscurrent_2d, Hzs="60;180;300", Qs="50;150;250")
	
	Hzs = selectString(paramisdefault(Hzs), Hzs, "60")
	Qs = selectString(paramisdefault(Qs), Qs, "50")
	measure_freq = paramisdefault(measure_freq) ? 0 : measure_freq // default is to find measure freq from scanvars unless specified
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
	if (measure_freq == 0)
		measure_freq = fd_getmeasfreq(wavenum)
	endif
	variable freqfactor = 1/(measure_freq * dimdelta(wav, 0)) // freq in wav = Hz in real seconds * freqfactor

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

function zap_NaNs(wave_1d, [overwrite])
	// removes any datapoints with NaNs :: only removes NaNs from the end of the wave. Assumes NaNs are only at start and end and not within wave
	// wave_1d: 2d wave to remove rows from
	// overwrite: Default is overwrite = 1. overwrite = 0 will create new wave with "_zap" appended to the end
	// percentage_cutoff_inf: Default is percentage_cutoff_inf = 0.15 :: 15%
	wave wave_1d
	int overwrite
	
	overwrite = paramisdefault(overwrite) ? 1 : overwrite
	
	// Duplicating 1d wave
	if (overwrite == 0)
		string wave_1d_name = nameofwave(wave_1d)
		string wave_1d_name_new = wave_1d_name + "_zap"
		duplicate /o wave_1d $wave_1d_name_new
		wave wave_1d_new = $wave_1d_name_new 
	endif
	
	
	create_x_wave(wave_1d)
	wave x_wave
	
	
	variable num_rows = dimsize(wave_1d, 0)
	int end_of_start_nan = 0
	int start_of_end_nan = 0
		
	// find start and end of NaN rows
	int i 
	for (i = 0; i < num_rows; i++)
	
		if ((numtype(wave_1d[i]) == 0) && (end_of_start_nan == 0))
			end_of_start_nan = i
		endif
		
		
		if ((numtype(wave_1d[i]) != 0) && (end_of_start_nan != 0) && (start_of_end_nan == 0))
			start_of_end_nan = i
		endif
		
	endfor
	
	if (numtype(wave_1d[0]) == 0)
		end_of_start_nan = 0
	endif
	
	if (numtype(wave_1d[num_rows-1]) == 0)
		start_of_end_nan = num_rows
	endif
	
	
	
	// delete NaN rows
	if (end_of_start_nan > 0)
		if (overwrite == 1)
			deletePoints /M=0 0, end_of_start_nan, wave_1d
		else 
			deletePoints /M=0 0, end_of_start_nan, wave_1d_new
		endif
	endif
	
	if (start_of_end_nan < num_rows)
		if (overwrite == 1)
			deletePoints /M=0 start_of_end_nan-end_of_start_nan, num_rows-start_of_end_nan + 1, wave_1d
		else
			deletePoints /M=0 start_of_end_nan-end_of_start_nan, num_rows-start_of_end_nan + 1, wave_1d_new
		endif
	endif
	
	if ((end_of_start_nan > 0) && (start_of_end_nan < num_rows))
		if (overwrite == 1)
			setscale /I x, pnt2x(wave_1d, end_of_start_nan), pnt2x(wave_1d, start_of_end_nan - 1), wave_1d
		else
			setscale /I x, pnt2x(wave_1d, end_of_start_nan), pnt2x(wave_1d, start_of_end_nan - 1), wave_1d_new
		endif
	endif
	
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
		if (create_new_wave == 1)
			ModifyGraph rgb($wav_name_int)=(0,0,0)
		else
			ModifyGraph rgb(powerspec_int)=(0,0,0)
		endif
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

function average_every_n_rows(wav, n, [overwrite])
	// takes a 2d wave and averages every n rows (IGOR columns)
	// creates a wave with _avg appended to the end
	// assumes the wav has a multiple of n points
	wave wav 
	int n, overwrite
	
	overwrite = paramisdefault(overwrite) ? 0 : overwrite // default not resample the data

	
	string wave_name = nameOfWave(wav)
	string wave_name_averaged = wave_name + "_avg"

	
	variable num_rows = dimsize(wav, 1) // (repeats)
	variable num_columns = dimsize(wav, 0) // (sweep length)
	
	int num_rows_post_average = round(num_rows/n)
	
	ReduceMatrixSize(wav, 0, -1, num_columns, 0,-1, num_rows_post_average, 1, wave_name_averaged)

	if (overwrite == 1)
		duplicate /o $wave_name_averaged $wave_name
	endif
end


function crop_wave(wave wav, variable x_mid, variable y_mid, variable x_width, variable y_width)
	// takes a 2d wave and creates a new cropped wave with name "_crop" appended
	// cropped mask is determined by the centre and lengths (in gate dimensions) of the x and y
	
	string wave_name = nameOfWave(wav)
	string wave_name_averaged = wave_name + "_crop"
	
	variable num_columns = dimsize(wav, 0) // (sweep length)
	variable num_rows = dimsize(wav, 1) // (repeats)
	
	int x_coord_start, x_coord_end, y_coord_start, y_coord_end
	
	// setting x coordinates (with checks for bounds)
	if (x_width == INF)
		x_coord_start = 0
		x_coord_end = num_columns - 1
	else
		x_coord_start = scaletoindex(wav, x_mid - x_width, 0)
		x_coord_end = scaletoindex(wav, x_mid + x_width, 0)
	endif

	if (x_coord_start < 0)
		x_coord_start = 0
	endif	
	if (x_coord_end > num_columns - 1)
		x_coord_end = num_columns - 1
	endif
	
	// setting y coordinates (with checks for bounds)
	if (y_width == INF)
		y_coord_start = 0
		y_coord_end = num_rows - 1
	else
		y_coord_start = scaletoindex(wav, y_mid - y_width, 1)
		y_coord_end = scaletoindex(wav, y_mid + y_width, 1)
	endif
	
	if (y_coord_start < 0)
		y_coord_start = 0
	endif
	if (y_coord_end > num_rows - 1)
		y_coord_end = num_rows - 1
	endif
	
	int num_crop_columns = (x_coord_end - x_coord_start) + 1
	int num_crop_rows = (y_coord_end - y_coord_start) + 1
	
	ReduceMatrixSize(wav, x_coord_start, x_coord_end, num_crop_columns, y_coord_start, y_coord_end, num_crop_rows, 1, wave_name_averaged)
end


function interpolate_polyline(poly_y, poly_x, [num_points_to_interp])
	// interpolate poly_y and poly_x to form evernly space poly_y_interp and poly_x_interp
	// use graphWaveDraw to create rough set of points which creates the waves w_ypoly1 and w_xpoly1 e.g. interpolate_polyline(w_ypoly1, w_xpoly1)
	wave poly_x, poly_y
	int num_points_to_interp
	num_points_to_interp = paramisdefault(num_points_to_interp) ? 1000 : num_points_to_interp
	
	variable num_vals = dimsize(poly_x, 0)
	wave linspaced = linspace(poly_x[0], poly_x[num_vals - 1], num_points_to_interp, make_global = 0)
	duplicate /o linspaced poly_x_interp
	
	Interpolate2 /T=1 /I=3 /Y=poly_y_interp/X=poly_x_interp poly_x, poly_y //linear interpolation
	
end



function/wave Linspace(start, fin, num, [make_global])
	// An Igor substitute for np.linspace() (obviously with many caveats and drawbacks since it is in Igor...)
	//
	// To use this in command line:
	//		make/o/n=num tempwave
	// 		tempwave = linspace(start, fin, num)[p]
	//
	// To use in a function:
	//		wave tempwave = linspace(start, fin, num)  //Can be done ONCE (each linspace overwrites itself!)
	//	or
	//		make/n=num tempwave = linspace(start, fin, num)[p]  //Can be done MANY times
	//
	// To combine linspaces:
	//		make/free/o/n=num1 w1 = linspace(start1, fin1, num1)[p]
	//		make/free/o/n=num2 w2 = linspace(start2, fin2, num2)[p]
	//		concatenate/np/o {w1, w2}, tempwave
	//
	variable start, fin, num
	int make_global
	make_global = paramisdefault(make_global) ? 0 : make_global  // default to not make global wave
	
	if (num == 1)
		if (make_global == 1)
			Make/N=1/O linspaced = {start}
		else
			Make/N=1/O/Free linspaced = {start}
		endif
	else
		if (make_global == 1)
			Make/N=2/O linspace_start_end = {start, fin}
		else
			Make/N=2/O/Free linspace_start_end = {start, fin}
		endif
		Interpolate2/T=1/N=(num)/Y=linspaced linspace_start_end
	endif
	return linspaced
end




function/WAVE  get_z_from_xy(wave_2d, y_wave, x_wave)
	// return 1d wave where the y values are picked by the z value at each coordinate from y_wave and x_wave
	// creates z_wave in global workspace
	wave wave_2d, y_wave, x_wave
	
	duplicate /o y_wave z_wave
	wave z_wave
	
	variable num_vals = dimsize(y_wave, 0)
	variable x_val, y_val, x_coord, y_coord
	
	variable i
	for (i = 0; i < num_vals; i++)
		x_val = x_wave[i]
		y_val = y_wave[i]
		
		x_coord = scaletoindex(wave_2d, x_val, 0)
		y_coord = scaletoindex(wave_2d, y_val, 1)
		
		z_wave[i] = wave_2d[x_coord][y_coord]
		
	endfor
	
	SetScale/I x x_wave[0], x_wave[inf], "", z_wave
	
	return z_wave
end



function get_multiple_line_paths(wave_2d, y_wave, x_wave, [width_y, width_x, num_traces])
	wave wave_2d, y_wave, x_wave
	variable width_y, width_x
	int num_traces
	
	width_y = paramisdefault(width_y) ? 10 : width_y
	width_x = paramisdefault(width_y) ? 0 : width_x
	num_traces = paramisdefault(width_y) ? 10 : num_traces
	
	///// create empty 2d wave to store multiple rows of the line paths
	variable num_vals = dimsize(y_wave, 0)
	make /o/n=(num_vals, num_traces) line_path_2d_z
	make /o/n=(num_vals, num_traces) line_path_2d_y
	make /o/n=(num_vals, num_traces) line_path_2d_x
	
	
	///// calculate delta y to pull off each of the line paths
	variable delta_y = (width_y*2) / num_traces
	duplicate /o y_wave y_wave_offset
	y_wave_offset[] = y_wave[p] - width_y
	wave y_wave_offset
	
	///// calculate delta c to pull off each of the line paths
	variable delta_x = (width_x*2) / num_traces
	duplicate /o x_wave x_wave_offset
	x_wave_offset[] = x_wave[p] - width_x
	wave x_wave_offset
	
	
	variable i, offset
	for (i = 0; i < num_traces; i++)
	
		///// calculate the new y_wave_offset and x_wave_offset
		y_wave_offset[] = y_wave_offset[p] + delta_y
		x_wave_offset[] = x_wave_offset[p] + delta_x
		
		wave z_wave = get_z_from_xy(wave_2d, y_wave_offset, x_wave_offset)
		
		line_path_2d_z[][i] = z_wave[p]
		line_path_2d_y[][i] = y_wave_offset[p]
		line_path_2d_x[][i] = x_wave_offset[p]
	
	endfor
end


function plot_multiple_line_paths(wave_2d, y_wave, x_wave, [width_y, width_x, offset, num_traces, plot_contour, make_markers])
	wave wave_2d, y_wave, x_wave
	variable width_y, width_x, offset
	int num_traces, plot_contour, make_markers
	
	width_y = paramisdefault(width_y) ? 10 : width_y
	width_x = paramisdefault(width_y) ? 0 : width_x
	offset = paramisdefault(offset) ? 0.001 : offset
	num_traces = paramisdefault(width_y) ? 10 : num_traces
	plot_contour = paramisdefault(plot_contour) ? 1 : plot_contour
	make_markers = paramisdefault(make_markers) ? 0 : make_markers
	
	get_multiple_line_paths(wave_2d, y_wave, x_wave, width_y = width_y, width_x = width_x, num_traces = num_traces)
	
	wave line_path_2d_z, line_path_2d_y, line_path_2d_x
	
	///// display original 2d image with each trace
	string window_name = "line_path_traces"
	dowindow/k $window_name
	display/N=$window_name
	appendimage /W=$window_name wave_2d
	variable num_columns = dimsize(line_path_2d_y, 1)
	variable i
	for (i = 0; i < num_columns; i++)
		appendtograph /W=$window_name line_path_2d_y[][i] vs line_path_2d_x[][i]
		if (make_markers == 1)
			ModifyGraph mode=3, marker=13, mrkThick=2, rgb=(65535,0,52428)
		endif
	endfor
	
//	Display2DWaterfall(line_path_2d_z, offset = offset, plot_every_n = 1, plot_contour = plot_contour)
	
	// display integrated line traces
	window_name = "line_path_traces_z"
	dowindow/k $window_name
	display/N=$window_name
	appendimage /W=$window_name line_path_2d_z
	ModifyImage /W=$window_name line_path_2d_z ctab= {*,*,RedWhiteGreen,0}
end


function Display2DWaterfall(w, [offset, x_label, y_label, plot_every_n, y_min, y_max, plot_contour])
	wave w
	variable offset
	string x_label, y_label
	int plot_every_n, y_min, y_max, plot_contour
	
	variable num_repeats = DimSize(w, 1)
	int apply_offset = paramisdefault(offset) ? 0 : 1 // forcing theta OFF is default
	plot_every_n = paramisdefault(plot_every_n) ? 1 : plot_every_n // plotting every trace is default
	y_min = paramisdefault(y_min) ? 0 : y_min // y_min index 0 is default
	y_max = paramisdefault(y_max) ? dimsize(w, 1) : y_max // y_max index 0 is default
	plot_contour = paramisdefault(plot_contour) ? 0 : plot_contour // plotting contour OFF is default
	
	
	x_label = selectstring(paramisdefault(x_label), x_label, "")
	y_label = selectstring(paramisdefault(y_label), y_label, "")
	
	string name, wn = nameofwave(w)
	sprintf name "%s_", wn
	
	dowindow/k $name
	display/N=$name
	TextBox/W=$name/C/N=textid/A=LT/X=1.00/Y=1.00/E=2 name
	

	variable offset_to_apply
	duplicate  /o w wave_2d
	wave wave_2d
	
	duplicate  /o w wave_2d_contour
	wave wave_2d_contour
	
	
	variable i
	for(i = 0; i < num_repeats; i++)

		if (apply_offset == 1)
			offset_to_apply = i * offset
		else
			offset_to_apply = 0
		endif
		
		wave_2d[][i] = wave_2d[p][i] + offset_to_apply
		
		
		if ((mod(i, plot_every_n) == 0) && (i >= y_min) && (i < y_max))
   		AppendToGraph/W=$name wave_2d[][i]
   	endif
   	
	endfor
	
	makecolorful()
	
	string wavename_2d_contour = ""
	///// adding contour lines /////
	variable count = 0
	for(i = 0; i < num_repeats; i++)

		if (apply_offset == 1)
			offset_to_apply = i * offset
		else
			offset_to_apply = 0
		endif
		
   	
   	if ((mod(i, plot_every_n) == 0) && (i >= y_min) && (i < y_max) && (plot_contour == 1))
   	
//   		wave_2d_contour[][i] = wave_2d_contour[p][i]*0  + wave_2d_contour[0][i] + offset_to_apply
   		wave_2d_contour[][i] = wave_2d[0][i]
   		AppendToGraph/W=$name wave_2d_contour[][i]
   		
   		wavename_2d_contour = "wave_2d_contour#" + num2str(count)
   		
   		ModifyGraph rgb($wavename_2d_contour) = (30583,30583,30583), lstyle($wavename_2d_contour)=3, lsize($wavename_2d_contour)=0.1
   		
   		count += 1
   	endif
   	
	endfor
	
	
	

	Label /W=$name left y_label
	Label /W=$name bottom x_label
	

	
end




function get_multiple_line_paths_int(wave_2d, y_wave, x_wave, [width_y, width_x, num_traces])
	wave wave_2d, y_wave, x_wave
	variable width_y, width_x
	int num_traces
	
	width_y = paramisdefault(width_y) ? 10 : width_y
	width_x = paramisdefault(width_y) ? 0 : width_x
	num_traces = paramisdefault(width_y) ? 10 : num_traces
	
	string wave_name = nameofwave(wave_2d)
	
	get_multiple_line_paths(wave_2d, y_wave, x_wave, width_y = width_y, width_x = width_x, num_traces = num_traces)
	
	wave line_path_2d_z, line_path_2d_y, line_path_2d_x
	
	///// display original 2d image with each trace
	string window_name = "line_path_traces"
	dowindow/k $window_name
	display/N=$window_name
	appendimage /W=$window_name wave_2d
	ModifyImage /W=$window_name $wave_name ctab= {-0.0005, 0.0005, RedWhiteGreen, 0}
	variable num_columns = dimsize(line_path_2d_y, 1)
	variable i
	for (i = 0; i < num_columns; i++)
		appendtograph /W=$window_name line_path_2d_y[][i] vs line_path_2d_x[][i]
	endfor
	
	///// integrate line paths and remove y offset
	Integrate line_path_2d_z /D = line_path_2d_z_int
	
	offset_2d_traces(line_path_2d_z_int)
	
	// display integrated line traces
	window_name = "line_path_traces_z_int"
	dowindow/k $window_name
	display/N=$window_name
	appendimage /W=$window_name line_path_2d_z_int
	ModifyImage /W=$window_name line_path_2d_z_int ctab= {*,*,RedWhiteGreen,0}	
end


Function ApplyFakeWaterfall(graphName, dx, dy, hidden)      // e.g., ApplyFakeWaterfall("Graph0", 2, 100, 1)
	//hidden= h
	//h =0: Turns hidden line off.
	//h =1: Uses painter's algorithm.
	//h =2: True hidden.
	//h =3: Hides lines with bottom removed.
	//h =4: Hides lines using a different color for the bottom. When specified, the top color is the normal color for lines and the bottom color is set using ModifyGraph negRGB=(r,g,b).

	String graphName    // Name of graph or "" for top graph
	Variable dx, dy     // Used to offset traces to create waterfall effect
	Variable hidden     // If true, apply hidden line removal
	
	String traceList = TraceNameList(graphName, ";", 1)
	Variable numberOfTraces = ItemsInLIst(traceList)
	
	Variable traceNumber
	for(traceNumber=0; traceNumber<numberOfTraces; traceNumber+=1)
		String trace = StringFromList(traceNumber, traceList)
		Variable offsetX = (numberOfTraces-traceNumber-1) * dx
		Variable offsetY = (numberOfTraces-traceNumber-1) * dy
		ModifyGraph/W=$graphName offset($trace)={offsetX,offsetY}
		ModifyGraph/W=$graphName plusRGB($trace)=(65535,65535,65535)    // Fill color is white
		if (hidden)
			ModifyGraph/W=$graphName mode($trace)=7, hbFill($trace)=1       // Fill to zero, erase mode
		else
			ModifyGraph/W=$graphName mode($trace)=0                     // Lines between points
		endif
	endfor
End


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


function demodulate(datnum, harmonic, wave_kenner, [append2hdf, demod_wavename])
	///// if demod_wavename is use this name for demod wave. Otherwise default is "demod"
	variable datnum, harmonic
	string wave_kenner
	variable append2hdf
	string demod_wavename
	demod_wavename = selectString(paramisdefault(demod_wavename), demod_wavename, "demod")
	variable nofcycles, period, cols, rows
	string wn="dat" + num2str(datnum) + wave_kenner;
	wave wav=$wn
	struct AWGVars AWGLI
	fd_getoldAWG(AWGLI, datnum)

//	print AWGLI

	cols=dimsize(wav,0); //print cols
	rows=dimsize(wav,1); //print rows
	nofcycles=AWGLI.numCycles;
//	print nofcycles
	period=AWGLI.waveLen;
//	print "AWG num cycles  = " + num2str(nofcycles)
//	print "AWG wave len = " + num2str(period)
	
//	//Original Measurement Wave
	make /o/n=(cols) sine1d
	sine1d=sin(2*pi*(harmonic*p/period)) // create 1d sine wave with same frequency as AWG wave and specified harmonic

	matrixop /o sinewave=colrepeat(sine1d, rows)
	matrixop /o temp=wav * sinewave
	copyscales wav, temp
	temp=temp*pi/2;
	
	
	
	///// display steps of demod /////
//	display
//	appendimage temp
//
//	display
//	appendimage sinewave
//
	Duplicate /o sine1d, wave0x
	wave0x = x

//	display wav vs wave0x
//	appendtoGraph sine1d
	
//	print "cols = " + num2str(cols)
//	print "rows = " + num2str(rows)
//	print "(cols/period/nofcycles) = " + num2str(cols/period/nofcycles)
	ReduceMatrixSize(temp, 0, -1, (cols/period/nofcycles), 0,-1, rows, 1, demod_wavename)
	
	KillWindow /Z demod_window
	Display
	DoWindow/C demod_window
	Appendimage /W=demod_window $demod_wavename
	ModifyImage /W=demod_window $demod_wavename ctab = {*, *, RedWhiteGreen, 0}
	

	///// append to hdf /////
//wn="demod"
//	if (append2hdf)
//		variable fileid
//		fileid=get_hdfid(datnum) //opens the file
//		HDF5SaveData/o /IGOR=-1 /TRAN=1 /WRIT=1 /Z $wn, fileid
//		HDF5CloseFile/a fileid
//	endif

end

	
	
function udh5([dat_num, dat_list, dat_min_max, exclude_name, upload_RAW])
	// Loads HDF files back into Igor, if no optional paramters specified loads all dat in file path into IGOR
	// NOTE: Assumes 'data' has been specified
	string dat_num,dat_list, dat_min_max, exclude_name
	variable upload_RAW
	
	dat_num = selectString(paramisdefault(dat_num), dat_num, "") // e.g. "302"
	dat_list = selectString(paramisdefault(dat_list), dat_list, "") // e.g. "302,303,304,305,401"
	dat_min_max = selectString(paramisdefault(dat_min_max), dat_min_max, "") // e.g. "302,310"
	exclude_name = selectString(paramisdefault(exclude_name), exclude_name, "") // e.g. "RAW"
	string strmatch_exclude_name = "*" + exclude_name + "*"
	
	string infile = wavelist("*",";","") // get wave list
	string hdflist = indexedfile(data,-1,".h5") // get list of .h5 files
	string currentHDF="", currentWav="", datasets="", currentDS, edited_currentDS = ""
	
	string upload_raw_string = ""
	if (upload_RAW == 0)
		upload_raw_string = ""
	else
		upload_raw_string = "_RAW"
	endif
	
	
	////////////////////////////////////////////////////
	///// Overwriting hdflist if dat_num specified /////
	////////////////////////////////////////////////////
	if (!stringmatch(dat_num, ""))
		hdflist = "dat" + dat_num + upload_raw_string + ".h5"
	endif
	
	/////////////////////////////////////////////////////
	///// Overwriting hdflist if dat_list specified /////
	/////////////////////////////////////////////////////
	variable i
	if (!stringmatch(dat_list, ""))
		hdflist = ""
		for(i=0; i<ItemsInList(dat_list, ";"); i+=1)
			hdflist = hdflist + "dat" + StringFromList(i, dat_list, ";") + upload_raw_string + ".h5;"
		endfor
	endif
	
	////////////////////////////////////////////////////////
	///// Overwriting hdflist if dat_min_max specified /////
	////////////////////////////////////////////////////////
	variable dat_start = str2num(StringFromList(0, dat_min_max, ";"))
	variable dat_end = str2num(StringFromList(1, dat_min_max, ";"))
	
	if (!stringmatch(dat_min_max, ""))
		hdflist = ""
		for(i=dat_start; i<dat_end+1; i+=1)
			hdflist = hdflist + "dat" + num2str(i) + upload_raw_string + ".h5;"
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
		if (upload_RAW == 0)
			currentHDF = currentHDF[0, (strlen(currentHDF) - 4)]
		else
			currentHDF = currentHDF[0, (strlen(currentHDF) - 8)]
		endif
		for(j = 0; j < numWN; j += 1) // loop over datasets within h5 file
	    	currentDS = StringFromList(j, datasets)
	    	if (itemsinlist((currentDS + " "), "RAW") > 1)
	    		edited_currentDS = currentDS[0, (strlen(currentDS) - 5)]
	    	else
	    		edited_currentDS = currentDS
	    	endif
			currentWav = currentHDF + edited_currentDS
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
	new2dwave=interp2d(wave_not_centered,(x + mids[q]),(y)) // mids is the shift in x
end



function prune_waves(wave1, wave2)
	// this function removes points from both waves if there is a NaN in either wave
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


function crop_waves_by_x_scaling(wave1, wave2)
	// this function removes points from both waves if x point is not equal
	// assumes each wave has the same length
	wave wave1, wave2
	
	// create wave references
	string wave1_name = nameofwave(wave1)
	string wave2_name = nameofwave(wave2)

	wave wave1_ref = $wave1_name
	wave wave2_ref = $wave2_name
	
	// create x wave references
	create_x_wave(wave1_ref)
	wave wave1_x_wave = x_wave
	
	create_x_wave(wave2_ref)
	wave wave2_x_wave = x_wave
	
	
	// removing bad rows from wave1
	variable num_rows_wave1 = dimsize(wave1_ref, 0)
	variable x1, x2

	int num_bad_rows = 0	
	int i 
	for (i = 0; i < num_rows_wave1; i++)
	
		x1 = wave1_x_wave[i]
		
		FindValue /V=(x1) wave2_x_wave

		if (V_row == -1) // value from x1 is not in x2
			DeletePoints (i - num_bad_rows), 1, wave1_ref // delete row
			num_bad_rows += 1
		endif
	endfor
	
	
	// removing bad rows from wave2
	variable num_rows_wave2 = dimsize(wave2_ref, 0)

	num_bad_rows = 0	
	for (i = 0; i < num_rows_wave2; i++)
	
		x2 = wave2_x_wave[i]
		
		FindValue /V=(x2) wave1_x_wave
	
		if (V_row == -1) // value from x2 is not in x1
			DeletePoints (i - num_bad_rows), 1, wave2_ref // delete row
			num_bad_rows += 1
		endif
	endfor
	
end



function translate_wave_by_occupation(wave1, wave2)
	// overwrites x scaling of wave1 by shifting it using wave2
	// assumes both waves have correct x scaling
	// does not assume each wave has same delta x
	// hard coded to shift x-axis of wave1 when wave2 = 0.5
	
	wave wave1, wave2
	
	// create wave references
	string wave1_name = nameofwave(wave1)
	string wave2_name = nameofwave(wave2)
	
	wave wave1_ref = $wave1_name
	wave wave2_ref = $wave2_name
	
	// create x wave references
	create_x_wave(wave1_ref)
	wave wave1_x_wave = x_wave
	
	FindLevel /Q $wave2_name, 0.5
	variable gate_val_half = V_LevelX
	
	variable num_rows_wave1 = dimsize(wave1_ref, 0)
	
	print wave1_name, gate_val_half
	
	SetScale/I x (wave1_x_wave[0] - gate_val_half), (wave1_x_wave[num_rows_wave1 - 1] - gate_val_half), $wave1_name


end
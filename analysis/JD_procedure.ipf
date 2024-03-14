#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3				// Use modern global access method and strict wave access
#pragma DefaultTab={3,20,4}		// Set default tab width in Igor Pro 9 and later
#include <Global Fit 2>

/////  This .ipf contains some high level functions that help stitch multiple steps into one function

///// Procedure for creating the NRG waves /////

// 1) Start by adding the IGOR binary waves from the data folder.
// Go to Data/Load Waves/Load Igor Binary...


// 2) Create the large interpolated IGRO waves
// Run :: master_build_nrg_data()


// 3) Set the data path by running the below and choosing the Github data folder
// newpath data


// 4) Upload the relevant dat files
// •udh5(dat_min_max="6079,6102")


// 5) Notch filter, resample, fit conductance centre and average. Use conductance centers to fit transition and average.
// run_clean_average_procedure()


// 6) Run the NRG process :: Simultaneous fitting conductance. Use gamma and leverarm from conductance to fit transition and to determine N=0.5.
// run_nrg_procedure()




////////////////////// FUNCTION DATABASE //////////////////////////////
// denoise 
// centerandaverage
// run_single_clean_average_procedure
// run_clean_average_procedure
///////////////////////////////////////////////////////////////////////


function denoise(variable datnum, string cs_data_name, string dot_data_name, [variable notch_on, variable conductance_data]) 

	notch_on = paramisdefault(notch_on) ? 1 : notch_on
	conductance_data = paramisdefault(notch_on) ? 1 : conductance_data

	///// Defining wave names /////
	string cs_data_name_nf = cs_data_name + "_nf"
	string dot_data_name_nf = dot_data_name + "_nf"
	
	string cs_data_name_ps = cs_data_name + "_powerspec"
	string dot_data_name_ps = dot_data_name + "_powerspec"
	
	string cs_data_name_nf_ps = cs_data_name_nf + "_powerspec"
	string dot_data_name_nf_ps = dot_data_name_nf + "_powerspec"
	
	variable freq = fd_getmeasfreq(datnum)
	
	
	///// Calculating spectrum & notch on CS and dot current /////
	spectrum_analyzer($cs_data_name, freq)
	if (notch_on == 1)
		notch_filters($cs_data_name,Hzs="60;180;300;420;541", Qs="50;150;250;250;540")
		spectrum_analyzer($cs_data_name_nf, freq, plot_on = 0)
	endif
	
	if (conductance_data == 1)
		spectrum_analyzer($dot_data_name, freq)
		if (notch_on == 1)
			notch_filters($dot_data_name,Hzs="60;180;300;420;541", Qs="20;150;250;250;540")
			spectrum_analyzer($dot_data_name_nf, freq, plot_on = 0)
		endif
	endif
	
//	closeallGraphs()

	display 
	AppendToGraph $cs_data_name_ps; ModifyGraph rgb($cs_data_name_ps)=(0,0,0)
	AppendToGraph $dot_data_name_ps;
	
	string legend_text

	if (conductance_data == 0)
		legend_text = "\\s(" + cs_data_name_ps +  ")cs raw\r"
	else
		legend_text = "\\s(" + cs_data_name_ps +  ")cs raw\r\\s(" + dot_data_name_ps +  ")dot raw\r"
	endif
	
	if (notch_on == 1)
		AppendToGraph $cs_data_name_nf_ps;
		ModifyGraph rgb($cs_data_name_nf_ps)=(0,0,0)
		ModifyGraph lstyle($cs_data_name_nf_ps)=1;
		
		
		if (conductance_data == 0)
			legend_text = legend_text + "\\s(" + cs_data_name_nf_ps +  ")cs notch\r"
		else
			AppendToGraph $dot_data_name_nf_ps;
			ModifyGraph lstyle($dot_data_name_nf_ps)=1;
		
			legend_text = legend_text + "\\s(" + cs_data_name_nf_ps +  ")cs notch\r\\s(" + dot_data_name_nf_ps +  ")dot notch\r"
		endif
	endif
	
	
	ModifyGraph log(left)=1
	Legend /C/N=legend_figc/J/A=LT legend_text
end


function centerandaverage(datnum, cs_data_name, dot_data_name, [notch_on, conductance_data, fit_conductance]) 
	variable datnum
	string cs_data_name, dot_data_name
	variable notch_on, conductance_data, fit_conductance
	
	notch_on = paramisdefault(notch_on) ? 1 : notch_on
	conductance_data = paramisdefault(conductance_data) ? 1 : conductance_data
	fit_conductance = paramisdefault(fit_conductance) ? 1 : fit_conductance
	
	string cs_wave_name, dot_wave_name
	
	if (notch_on == 1)
		cs_wave_name = cs_data_name + "_nf"
		dot_wave_name = dot_data_name + "_nf"
	else
		cs_wave_name = cs_data_name
		dot_wave_name = dot_data_name
	endif

	string cleaned_dot_name = "dat"
	
	if (conductance_data == 0)
		master_ct_clean_average($cs_wave_name, 1, 0, "dat", condfit_prefix=cleaned_dot_name)
	else
		master_cond_clean_average($dot_wave_name, fit_conductance, cleaned_dot_name, alternate_bias=1)
		duplicate /o $cs_wave_name $("dat" + num2str(datnum) + "_cs_cleaned")
		avg_wav($("dat" + num2str(datnum) + "_cs_cleaned"))
//		master_ct_clean_average($cs_wave_name, 0, 1, "dat", condfit_prefix=cleaned_dot_name)//, minx=1580, maxx=3050)
	endif
end


function run_single_clean_average_procedure(variable datnum, [variable notch_on, variable plot, variable conductance_data])
	notch_on = paramisdefault(notch_on) ? 1 : notch_on
	plot = paramisdefault(plot) ? 1 : plot
	conductance_data = paramisdefault(conductance_data) ? 1 : conductance_data
	
	string cs_data_type = "cscurrent_2d"
	string dot_data_type = "dotcurrent_2d"
//	string dot_data_type = "dotcurrentx_2d"
	
	string cs_data_name = "dat" + num2str(datnum) + cs_data_type
	string dot_data_name = "dat" + num2str(datnum) + dot_data_type
	
	
	///// first denoise /////
	denoise(datnum, cs_data_name, dot_data_name, notch_on=notch_on, conductance_data=conductance_data)
	
	///// resample /////
//	if (datnum == 6084)
//		string dot_data_name_nf = dot_data_name + "_nf" 
//		resampleWave($dot_data_name_nf, 1000)
//	endif
	
	//// center the charge transitions and conductions data then average
	centerandaverage(datnum, cs_data_name, dot_data_name, notch_on=notch_on, fit_conductance=0)
	
	if (plot == 0)
		closeallGraphs()
	endif
end


function run_clean_average_procedure([datnums, dat_min_max])
	string datnums, dat_min_max
//	string default_datnums = "688;689;690;691;692;693;694;695;696;697;698;699"
//	string default_datnums = "699"

	datnums = selectString(paramisdefault(datnums), datnums, "") // e.g. "RAW"
	dat_min_max = selectString(paramisdefault(dat_min_max), dat_min_max, "") // e.g. "302,310"

	string dat_list = datnums
	
	int i
	////////////////////////////////////////////////////////
	///// Overwriting dat_list if dat_min_max specified /////
	////////////////////////////////////////////////////////
	variable dat_start = str2num(StringFromList(0, dat_min_max, ";"))
	variable dat_end = str2num(StringFromList(1, dat_min_max, ";"))
	
	if (!stringmatch(dat_min_max, ""))
		dat_list = ""
		for(i=dat_start; i<dat_end+1; i+=1)
			dat_list = dat_list + num2str(i) + ";"
		endfor
	endif
	////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////
	
	
	variable notch_on = 1
	
	variable num_dats = ItemsInList(dat_list, ";")
	
	variable plot = 0
	if (num_dats<2)
		plot = 1
	endif
	
	string window_name
	Display; KillWindow /Z conductance_vs_sweep; DoWindow/C/O conductance_vs_sweep 
//	DoWindow/C conductance_vs_sweep 
	
//	Display 
//	window_name = WinName(0,1)
	Display; KillWindow /Z transition_vs_sweep; DoWindow/C/O transition_vs_sweep 
//	DoWindow/C transition_vs_sweep
	
	string cond_avg, trans_avg
	variable datnum
	for (i=0;i<num_dats;i+=1)
		datnum = str2num(stringfromlist(i, dat_list))
		
		try
			run_single_clean_average_procedure(datnum, plot=1, notch_on=notch_on, conductance_data=1)
		catch
			print "FAILED CLEAN AND AVERAGE :: DAT " + num2str(datnum)
		endtry 
		
		cond_avg = "dat" + num2str(datnum) + "_dot_cleaned_avg"
		trans_avg = "dat" + num2str(datnum) + "_cs_cleaned_avg"
		
		closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
		
		// append to graphs 
		AppendToGraph /W=conductance_vs_sweep $cond_avg;
		AppendToGraph /W=transition_vs_sweep $trans_avg;
	endfor

end

//
//function run_nrg_procedure()
//
//	string datnums = "6079;6082;6085;6088"
////	string datnums = "6079"
//	variable notch_on = 1
//	
//	variable num_dats = ItemsInList(datnums, ";")
//	variable plot = 0
//	if (num_dats<2)
//		plot = 1
//	endif
//	
//	string window_name
//	Display 
//	DoWindow/C conductance_vs_sweep 
//	
//	Display 
//	window_name = WinName(0,1)
//	DoWindow/C transition_vs_sweep
//	
//	string cond_avg, trans_avg
//	variable i, datnum
//	for (i=0;i<num_dats;i+=1)
//		datnum = str2num(stringfromlist(i, datnums))
//		run_single_clean_average_procedure(datnum, plot=1, notch_on=notch_on)
//		
//		cond_avg = "dat" + num2str(datnum) + "_dot_cleaned_avg"
//		trans_avg = "dat" + num2str(datnum) + "_cs_cleaned_avg"
//		
//		closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
//		
//		// append to graphs 
//		AppendToGraph /W=conductance_vs_sweep $cond_avg;
//		AppendToGraph /W=transition_vs_sweep $trans_avg;
//	endfor
//
//end




////////////////////////////
///// WORKING WITH NRG /////
////////////////////////////
function create_nrg_cond_vs_occ()
	variable gt_min = -4.4, gt_max = 3.9, gt_val
	variable numptsy = 50
	variable numptsx = 1000
	
	// creating gamma array
	variable gt_index, interp_index
	wave occ_nrg, g_nrg
	create_y_wave(occ_nrg)
	wave y_wave
	redimension /n=-1 y_wave
	
	// creating dummy 1d slices
	duplicate /o /RMD=[][0] occ_nrg occ_nrg_single
	duplicate /o /RMD=[][0] g_nrg g_nrg_single
	wave occ_nrg_single, g_nrg_single
	
	// creating interp cond vs occ wave
	make /o/n=(numptsx,numptsy) g_nrg_interp
	setscale /I x, 0, 1, g_nrg_interp
	setscale /I y, gt_min, gt_max, g_nrg_interp
	wave g_nrg_interp
	
	int i, j
	for (i = 0; i < numptsy; i++)
		gt_val = gt_min + ((gt_max - gt_min)/numptsy)*i
	
		findlevel /q y_wave, gt_val
		gt_index = x2pnt(y_wave, V_LevelX)
		
		
		occ_nrg_single = occ_nrg[p][gt_index]
		g_nrg_single = g_nrg[p][gt_index]
		
		for (j=0; j < numptsx; j++)
			findlevel /q occ_nrg_single, j/numptsx
			interp_index = x2pnt(occ_nrg_single, V_LevelX)
			g_nrg_interp[j][i] = g_nrg_single[interp_index]
		
		endfor
		print i

	endfor
	
	plot_waterfall(g_nrg_interp, "Occupation", "Conductance", offset=0)
	plot_waterfall(g_nrg_interp, "Occupation", "Conductance", offset=1)
	plot_waterfall(g_nrg_interp, "Occupation", "Conductance", offset=0)
	
end





function plot_conductance_vs_temp_at_occupation()
	variable occ_numpts = 20
	variable occ_start = 0
	
	wave g_nrg_interp // asuume this has been created
	variable temp_numpts = dimsize(g_nrg_interp, 1)
	
	// make wave to hold redimensioned data
	make /o /n=(temp_numpts, occ_numpts) nrg_g_vs_temp
	wave nrg_g_vs_temp
	// scale x
	setscale /I y, occ_start, 1, nrg_g_vs_temp 
	// scale y
	create_y_wave(g_nrg_interp)
	wave y_wave
	setscale /I x, 1/exp(y_wave[0]), 1/exp(y_wave[inf]), nrg_g_vs_temp
	
	create_x_wave(g_nrg_interp)
	wave x_wave
	
	duplicate /o y_wave gamma_vals
	
	variable occ_val, g_nrg_interp_xindex
	
	int i
	for (i=0; i<occ_numpts; i++)
		occ_val = occ_start + ((1-occ_start)/occ_numpts)*i
		
		findlevel /q x_wave, occ_val
		g_nrg_interp_xindex = x2pnt(x_wave, V_LevelX)
		
//		print g_nrg_interp//g_nrg_interp[g_nrg_interp_xindex]
		nrg_g_vs_temp[][i] = g_nrg_interp[g_nrg_interp_xindex][p]
		
	endfor
end


Function kondotemp_fit_function(w, ys, xs) : FitFunc
	Wave w, xs, ys
	// f(x) = Amp*tanh((x - Mid)/(2*theta)) + Linear*x + Const+Quad*x^2
	// w[0] = G0
	// w[1] = Tk
	// w[2] = s


	ys= w[0] * ( (w[1]^2/(2^(1/w[2]) - 1)) / (xs^2 + (w[1]^2/(2^(1/w[2]) - 1))) ) ^ w[2]
End


function find_tk_from_nrg()

	wave nrg_g_vs_temp
	variable occ_numpts = dimsize(nrg_g_vs_temp, 1)
	
	create_x_wave(nrg_g_vs_temp)
	wave x_wave
	duplicate /o x_wave slice
	wave slice
	
	make /o/n=3 W_coef = {1, 1, 0.5}
	
	display
	int i
	for (i=0; i<occ_numpts; i++)
		slice = nrg_g_vs_temp[p][i]	
		redimension /n=-1 slice
		appendtograph slice
		FuncFit /TBOX=768 kondotemp_fit_function W_coef slice /D
		print W_coef
	endfor 
end

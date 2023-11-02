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
		master_ct_clean_average($cs_wave_name, 0, 1, "dat", condfit_prefix=cleaned_dot_name)//, minx=1580, maxx=3050)
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



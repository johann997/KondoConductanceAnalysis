#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3				// Use modern global access method and strict wave access
#pragma DefaultTab={3,20,4}		// Set default tab width in Igor Pro 9 and later
#include <Global Fit 2>



function denoise(variable datnum, string cs_data_name, string dot_data_name, [variable notch_on]) 

	notch_on = paramisdefault(notch_on) ? 1 : notch_on
	

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
		notch_filters($cs_data_name,Hzs="60;180;300;420", Qs="50;150;250;250")
		spectrum_analyzer($cs_data_name_nf, freq)
	endif
	
	spectrum_analyzer($dot_data_name, freq)
	if (notch_on == 1)
		notch_filters($dot_data_name,Hzs="60;180;300;420", Qs="50;150;250;250")
		spectrum_analyzer($dot_data_name_nf, freq)
	endif
	
//	closeallGraphs()
	
	display $cs_data_name_ps; 
	AppendToGraph $dot_data_name_ps;
	ModifyGraph lstyle($dot_data_name_ps)=1;
	
	if (notch_on == 1)
		AppendToGraph $cs_data_name_nf_ps;
		ModifyGraph rgb($cs_data_name_nf_ps)=(0,0,0)
	
		AppendToGraph $dot_data_name_nf_ps;
		ModifyGraph rgb($dot_data_name_nf_ps)=(0,0,0)
		ModifyGraph lstyle($dot_data_name_nf_ps)=1;
	endif
	
end


function centerandaverage(variable datnum, string cs_data_name, string dot_data_name, [variable notch_on]) 

	notch_on = paramisdefault(notch_on) ? 1 : notch_on
	
	string cs_wave_name, dot_wave_name
	
	if (notch_on == 1)
		cs_wave_name = cs_data_name + "_nf"
		dot_wave_name = dot_data_name + "_nf"
	else
		cs_wave_name = cs_data_name
		dot_wave_name = dot_data_name
	endif

	string cleaned_dot_name = "dat"
	master_cond_clean_average($dot_wave_name, 1, cleaned_dot_name)
	master_ct_clean_average($cs_wave_name, 0, 1, "dat", condfit_prefix=cleaned_dot_name, minx=1580, maxx=3050)
end


function run_single_procedure(variable datnum, [variable notch_on, variable plot])
	notch_on = paramisdefault(notch_on) ? 1 : notch_on
	plot = paramisdefault(plot) ? 1 : plot

	
	string cs_data_type = "cscurrent_2d"
	string dot_data_type = "dotcurrent_2d"
	
	string cs_data_name = "dat" + num2str(datnum) + cs_data_type
	string dot_data_name = "dat" + num2str(datnum) + dot_data_type
	
	
	///// first denoise /////
	denoise(datnum, cs_data_name, dot_data_name, notch_on=notch_on)
	
	//// center the charge transitions and conductions data then average
	centerandaverage(datnum, cs_data_name, dot_data_name, notch_on=notch_on)
	
	if (plot == 0)
		closeallGraphs()
	endif
end


function run_procedure()

	string datnums = "6079;6082;6085;6088"
//	string datnums = "6079"
	variable notch_on = 1
	
	variable num_dats = ItemsInList(datnums, ";")
	variable plot = 0
	if (num_dats<2)
		plot = 1
	endif
	
	string window_name
	Display 
	DoWindow/C conductance_vs_sweep 
	
	Display 
	window_name = WinName(0,1)
	DoWindow/C transition_vs_sweep
	
	string cond_avg, trans_avg
	variable i, datnum
	for (i=0;i<num_dats;i+=1)
		datnum = str2num(stringfromlist(i, datnums))
		run_single_procedure(datnum, plot=1, notch_on=notch_on)
		
		cond_avg = "dat" + num2str(datnum) + "_dot_cleaned_avg"
		trans_avg = "dat" + num2str(datnum) + "_cs_cleaned_avg"
		
		closeallGraphs(no_close_graphs = "conductance_vs_sweep;transition_vs_sweep")
		
		// append to graphs 
		AppendToGraph /W=conductance_vs_sweep $cond_avg;
		AppendToGraph /W=transition_vs_sweep $trans_avg;
	endfor

end